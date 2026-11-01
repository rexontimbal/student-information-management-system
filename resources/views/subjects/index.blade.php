@extends('layouts.app')

@section('title', 'Subjects')

@section('page-actions')
    <a href="{{ route('subjects.create') }}" class="btn btn-primary">
        <i class="bi bi-plus-lg me-1"></i> Add Subject
    </a>
@endsection

@section('content')
    <div class="card sims-table-card">
        @if ($subjects->isEmpty())
            <div class="sims-empty-state">
                <i class="bi bi-journal-bookmark"></i>
                <p class="mb-1 fw-semibold">No subjects yet</p>
                <p class="mb-3 small">Get started by adding your first subject record.</p>
                <a href="{{ route('subjects.create') }}" class="btn btn-primary">
                    <i class="bi bi-plus-lg me-1"></i> Add Subject
                </a>
            </div>
        @else
            <div class="table-responsive">
                <table class="table sims-table mb-0">
                    <thead>
                        <tr>
                            <th>Subject Code</th>
                            <th>Subject Name</th>
                            <th>Units</th>
                            <th class="text-end">Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        @foreach ($subjects as $subject)
                            <tr>
                                <td><span class="sims-badge-chip">{{ $subject->subject_code }}</span></td>
                                <td class="fw-semibold">{{ $subject->subject_name }}</td>
                                <td>{{ $subject->units }}</td>
                                <td class="text-end">
                                    <div class="d-inline-flex gap-2">
                                        <a href="{{ route('subjects.edit', $subject) }}" class="sims-icon-btn" title="Edit">
                                            <i class="bi bi-pencil"></i>
                                        </a>
                                        @if (auth()->user()->isAdmin())
                                            <button type="button" class="sims-icon-btn danger" title="Delete"
                                                    data-bs-toggle="modal" data-bs-target="#deleteConfirmModal"
                                                    data-delete-url="{{ route('subjects.destroy', $subject) }}"
                                                    data-delete-label="Delete subject: {{ $subject->subject_code }} - {{ $subject->subject_name }}?">
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
