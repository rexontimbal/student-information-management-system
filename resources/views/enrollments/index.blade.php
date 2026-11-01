@extends('layouts.app')

@section('title', 'Enrollments')

@section('page-actions')
    <a href="{{ route('enrollments.create') }}" class="btn btn-primary">
        <i class="bi bi-plus-lg me-1"></i> Add Enrollment
    </a>
@endsection

@section('content')
    <div class="card sims-table-card">
        @if ($enrollments->isEmpty())
            <div class="sims-empty-state">
                <i class="bi bi-clipboard2-check"></i>
                <p class="mb-1 fw-semibold">No enrollments yet</p>
                <p class="mb-3 small">Get started by enrolling a student in a subject.</p>
                <a href="{{ route('enrollments.create') }}" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Add Enrollment
                </a>
            </div>
        @else
            <div class="table-responsive">
                <table class="table sims-table mb-0">
                    <thead>
                        <tr>
                            <th>Student</th>
                            <th>Subject</th>
                            <th>School Year</th>
                            <th>Semester</th>
                            <th>Status</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($enrollments as $enrollment)
                            <tr>
                                <td class="fw-semibold">
                                    {{ $enrollment->student->last_name }}, {{ $enrollment->student->first_name }}
                                </td>
                                <td>
                                    <span class="sims-badge-chip">{{ $enrollment->subject->subject_code }}</span>
                                    {{ $enrollment->subject->subject_name }}
                                </td>
                                <td>{{ $enrollment->school_year }}</td>
                                <td>{{ $enrollment->semester }}</td>
                                <td>
                                    <span class="sims-status-badge sims-status-{{ $enrollment->status }}">
                                        {{ $enrollment->status }}
                                    </span>
                                </td>
                                <td class="text-end">
                                    <div class="d-inline-flex gap-2">
                                        <a href="{{ route('enrollments.edit', $enrollment) }}" class="sims-icon-btn" title="Edit">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        @if (auth()->user()->isAdmin())
                                            <button type="button" class="sims-icon-btn danger" title="Delete"
                                                    data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"
                                                    data-delete-url="{{ route('enrollments.destroy', $enrollment) }}"
                                                    data-delete-label="Delete enrollment: {{ $enrollment->student->first_name }} {{ $enrollment->student->last_name }} in {{ $enrollment->subject->subject_code }} ({{ $enrollment->school_year }}, {{ $enrollment->semester }})?">
                                                <i class="bi bi-trash"></i>
                                            </button>
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
