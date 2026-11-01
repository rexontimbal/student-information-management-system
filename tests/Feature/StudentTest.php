<?php

namespace Tests\Feature;

use App\Models\Student;
use App\Models\User;
use Illuminate\Foundation\Testing\RefreshDatabase;
use Tests\TestCase;

class StudentTest extends TestCase
{
    use RefreshDatabase;

    public function test_logged_in_user_can_view_student_list(): void
    {
        $user = User::factory()->create();
        Student::create($this->validStudentData());

        $response = $this->actingAs($user)->get('/students');

        $response->assertOk();
        $response->assertSee('2026-0001');
    }

    public function test_guest_cannot_view_student_list(): void
    {
        $response = $this->get('/students');

        $response->assertRedirect('/login');
    }

    public function test_logged_in_user_can_create_a_student_with_valid_data(): void
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->post('/students', $this->validStudentData());

        $response->assertRedirect('/students');
        $response->assertSessionHasNoErrors();
        $this->assertDatabaseHas('students', [
            'student_number' => '2026-0001',
            'email' => 'juan@example.com',
        ]);
    }

    public function test_validation_fails_with_missing_data(): void
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->post('/students', []);

        $response->assertSessionHasErrors([
            'student_number', 'first_name', 'last_name', 'email', 'course', 'year_level',
        ]);
        $this->assertDatabaseCount('students', 0);
    }

    public function test_validation_fails_with_invalid_email(): void
    {
        $user = User::factory()->create();

        $response = $this->actingAs($user)->post('/students', array_merge(
            $this->validStudentData(),
            ['email' => 'not-an-email']
        ));

        $response->assertSessionHasErrors('email');
        $this->assertDatabaseCount('students', 0);
    }

    public function test_validation_fails_with_duplicate_student_number(): void
    {
        $user = User::factory()->create();
        Student::create($this->validStudentData());

        $response = $this->actingAs($user)->post('/students', array_merge(
            $this->validStudentData(),
            ['email' => 'different@example.com']
        ));

        $response->assertSessionHasErrors('student_number');
        $this->assertDatabaseCount('students', 1);
    }

    public function test_admin_can_delete_a_student(): void
    {
        $admin = User::factory()->create(['role' => 'admin']);
        $student = Student::create($this->validStudentData());

        $response = $this->actingAs($admin)->delete("/students/{$student->id}");

        $response->assertRedirect('/students');
        $this->assertDatabaseMissing('students', ['id' => $student->id]);
    }

    public function test_staff_user_gets_403_when_deleting_a_student(): void
    {
        $staff = User::factory()->create(['role' => 'staff']);
        $student = Student::create($this->validStudentData());

        $response = $this->actingAs($staff)->delete("/students/{$student->id}");

        $response->assertForbidden();
        $this->assertDatabaseHas('students', ['id' => $student->id]);
    }

    private function validStudentData(): array
    {
        return [
            'student_number' => '2026-0001',
            'first_name' => 'Juan',
            'last_name' => 'Dela Cruz',
            'email' => 'juan@example.com',
            'course' => 'BS Computer Science',
            'year_level' => '2nd Year',
        ];
    }
}
