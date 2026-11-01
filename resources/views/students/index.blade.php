@extends('layouts.app')

@section('title', 'Students')

@section('page-actions')
    <a href="{{ route('students.create') }}" class="btn btn-primary">
        <i class="bi bi-plus-lg me-1"></i> Add Student
    </a>
@endsection

@section('content')
    <div class="card sims-table-card">
        @if ($students->isEmpty())
            <div class="sims-empty-state">
                <i class="bi bi-people"></i>
                <p class="mb-1 fw-semibold">No students yet</p>
                <p class="mb-3 small">Get started by adding your first student record.</p>
                <a href="{{ route('students.create') }}" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Add Student
                </a>
            </div>
        @else
            <div class="table-responsive">
                <table class="table sims-table mb-0">
                    <thead>
                        <tr>
                            <th>Student No.</th>
                            <th>Name</th>
                            <th>Email</th>
                            <th>Course</th>
                            <th>Year Level</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($students as $student)
                            <tr>
                                <td><span class="sims-badge-chip">{{ $student->student_number }}</span></td>
                                <td class="fw-semibold">{{ $student->last_name }}, {{ $student->first_name }}</td>
                                <td class="text-secondary">{{ $student->email }}</td>
                                <td>{{ $student->course }}</td>
                                <td>{{ $student->year_level }}</td>
                                <td class="text-end">
                                    <div class="d-inline-flex gap-2">
                                        <a href="{{ route('students.edit', $student) }}" class="sims-icon-btn" title="Edit">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        @if (auth()->user()->isAdmin())
                                            <form action="{{ route('students.destroy', $student) }}" method="POST"
                                                  onsubmit="return confirm('Delete {{ $student->first_name }} {{ $student->last_name }}? This cannot be undone.');">
                                                @csrf
                                                @method('DELETE')
                                                <button type="submit" class="sims-icon-btn danger" title="Delete">
                                                    <i class="bi bi-trash"></i>
                                                </button>
                                            </form>
                                        @endif
                                    </div>
                                </td>
                            </tr>
                        @endforeach
                    </tbody>
                </table>
            </div>
        @endif
    </div>
@endsection
