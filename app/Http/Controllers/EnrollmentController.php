<?php

namespace App\Http\Controllers;

use App\Models\Enrollment;
use App\Models\Student;
use App\Models\Subject;
use Illuminate\Database\QueryException;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class EnrollmentController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $enrollments = Enrollment::with('student', 'subject')
            ->latest()
            ->get();

        return view('enrollments.index', compact('enrollments'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('enrollments.create', [
            'students' => Student::orderBy('last_name')->orderBy('first_name')->get(),
            'subjects' => Subject::orderBy('subject_code')->get(),
        ]);
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate($this->rules(), $this->messages());

        try {
            Enrollment::create($validated);
        } catch (QueryException $e) {
            return back()->withInput()->withErrors([
                'subject_id' => $this->duplicateMessage(),
            ]);
        }

        return redirect()->route('enrollments.index')->with('success', 'Enrollment added successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Enrollment $enrollment)
    {
        return redirect()->route('enrollments.edit', $enrollment);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Enrollment $enrollment)
    {
        return view('enrollments.edit', [
            'enrollment' => $enrollment,
            'students' => Student::orderBy('last_name')->orderBy('first_name')->get(),
            'subjects' => Subject::orderBy('subject_code')->get(),
        ]);
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Enrollment $enrollment)
    {
        $validated = $request->validate($this->rules($enrollment), $this->messages());

        try {
            $enrollment->update($validated);
        } catch (QueryException $e) {
            return back()->withInput()->withErrors([
                'subject_id' => $this->duplicateMessage(),
            ]);
        }

        return redirect()->route('enrollments.index')->with('success', 'Enrollment updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Enrollment $enrollment)
    {
        $enrollment->delete();

        return redirect()->route('enrollments.index')->with('success', 'Enrollment deleted successfully.');
    }

    /**
     * Validation rules for storing/updating an enrollment.
     */
    private function rules(?Enrollment $enrollment = null): array
    {
        return [
            'student_id' => ['required', 'integer', 'exists:students,id'],
            'subject_id' => [
                'required',
                'integer',
                'exists:subjects,id',
                Rule::unique('enrollments', 'subject_id')
                    ->ignore($enrollment?->id)
                    ->where('student_id', request('student_id'))
                    ->where('school_year', request('school_year'))
                    ->where('semester', request('semester')),
            ],
            'school_year' => ['required', 'string', 'max:20'],
            'semester' => ['required', 'string', 'max:50'],
            'status' => ['required', Rule::in(['enrolled', 'dropped', 'completed'])],
        ];
    }

    /**
     * Friendly messages, including the composite-unique violation on subject_id.
     */
    private function messages(): array
    {
        return [
            'subject_id.unique' => $this->duplicateMessage(),
        ];
    }

    private function duplicateMessage(): string
    {
        return 'This student is already enrolled in that subject for the selected school year and semester.';
    }
}
