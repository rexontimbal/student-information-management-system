<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Student;
use Illuminate\Http\JsonResponse;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class StudentController extends Controller
{
    /**
     * GET /api/students
     */
    public function index(): JsonResponse
    {
        return response()->json(Student::orderBy('last_name')->orderBy('first_name')->get());
    }

    /**
     * GET /api/students/{student}
     *
     * Route model binding returns a 404 JSON response automatically
     * (ModelNotFoundException -> "Not Found" JSON) when the id doesn't exist.
     */
    public function show(Student $student): JsonResponse
    {
        return response()->json($student);
    }

    /**
     * POST /api/students
     */
    public function store(Request $request): JsonResponse
    {
        $validated = $request->validate($this->rules());

        $student = Student::create($validated);

        return response()->json($student, 201);
    }

    /**
     * PUT /api/students/{student}
     */
    public function update(Request $request, Student $student): JsonResponse
    {
        $validated = $request->validate($this->rules($student));

        $student->update($validated);

        return response()->json($student);
    }

    /**
     * DELETE /api/students/{student}
     */
    public function destroy(Student $student): JsonResponse
    {
        $student->delete();

        return response()->json(['message' => 'Student deleted successfully.']);
    }

    /**
     * Validation rules for storing/updating a student (mirrors the web StudentController).
     */
    private function rules(?Student $student = null): array
    {
        return [
            'student_number' => [
                'required',
                'string',
                'max:50',
                Rule::unique('students', 'student_number')->ignore($student?->id),
            ],
            'first_name' => ['required', 'string', 'max:100'],
            'last_name' => ['required', 'string', 'max:100'],
            'email' => [
                'required',
                'string',
                'email',
                'max:255',
                Rule::unique('students', 'email')->ignore($student?->id),
            ],
            'course' => ['required', 'string', 'max:100'],
            'year_level' => ['required', 'string', 'max:50'],
        ];
    }
}
