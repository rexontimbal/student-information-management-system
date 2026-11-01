<?php

namespace App\Http\Controllers;

use App\Models\Subject;
use Illuminate\Http\Request;
use Illuminate\Validation\Rule;

class SubjectController extends Controller
{
    /**
     * Display a listing of the resource.
     */
    public function index()
    {
        $subjects = Subject::orderBy('subject_code')->get();

        return view('subjects.index', compact('subjects'));
    }

    /**
     * Show the form for creating a new resource.
     */
    public function create()
    {
        return view('subjects.create');
    }

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate($this->rules());

        Subject::create($validated);

        return redirect()->route('subjects.index')->with('success', 'Subject added successfully.');
    }

    /**
     * Display the specified resource.
     */
    public function show(Subject $subject)
    {
        return redirect()->route('subjects.edit', $subject);
    }

    /**
     * Show the form for editing the specified resource.
     */
    public function edit(Subject $subject)
    {
        return view('subjects.edit', compact('subject'));
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, Subject $subject)
    {
        $validated = $request->validate($this->rules($subject));

        $subject->update($validated);

        return redirect()->route('subjects.index')->with('success', 'Subject updated successfully.');
    }

    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Subject $subject)
    {
        $subject->delete();

        return redirect()->route('subjects.index')->with('success', 'Subject deleted successfully.');
    }

    /**
     * Validation rules for storing/updating a subject.
     */
    private function rules(?Subject $subject = null): array
    {
        return [
            'subject_code' => [
                'required',
                'string',
                'max:50',
                Rule::unique('subjects', 'subject_code')->ignore($subject?->id),
            ],
            'subject_name' => ['required', 'string', 'max:150'],
            'units' => ['required', 'integer', 'between:1,6'],
        ];
    }
}
