@extends('layouts.app')

@section('title', 'Dashboard')

@section('content')
    <div class="card" style="border-radius: 16px;">
        <div class="card-body p-4 p-md-5">
            <div class="d-flex align-items-start gap-3">
                <div style="width:52px;height:52px;border-radius:14px;background:linear-gradient(135deg,var(--sims-primary-light),var(--sims-accent));display:flex;align-items:center;justify-content:center;flex-shrink:0;">
                    <i class="bi bi-stars text-white fs-4"></i>
                </div>
                <div>
                    <h2 class="fw-bold mb-1" style="font-size:1.3rem;">
                        Welcome back, {{ auth()->user()->name }} 👋
                    </h2>
                    <p class="text-secondary mb-0">
                        You're signed in as
                        <span class="fw-semibold" style="color: var(--sims-primary);">{{ auth()->user()->role ?? 'staff' }}</span>.
                        This is the new SIMS admin shell &mdash; use the sidebar to navigate between modules.
                    </p>
                </div>
            </div>
        </div>
    </div>

    <!-- Summary stat cards -->
    <div class="row g-4 mt-4">
        <div class="col-6 col-lg-3">
            <div class="card sims-stat-card">
                <div class="sims-stat-icon bg-indigo"><i class="bi bi-people-fill"></i></div>
                <div>
                    <div class="sims-stat-value">{{ $totalStudents }}</div>
                    <div class="sims-stat-label">Students</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="card sims-stat-card">
                <div class="sims-stat-icon bg-teal"><i class="bi bi-journal-bookmark-fill"></i></div>
                <div>
                    <div class="sims-stat-value">{{ $totalSubjects }}</div>
                    <div class="sims-stat-label">Subjects</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="card sims-stat-card">
                <div class="sims-stat-icon bg-amber"><i class="bi bi-clipboard2-check-fill"></i></div>
                <div>
                    <div class="sims-stat-value">{{ $totalEnrollments }}</div>
                    <div class="sims-stat-label">Enrollments</div>
                </div>
            </div>
        </div>

        <div class="col-6 col-lg-3">
            <div class="card sims-stat-card">
                <div class="sims-stat-icon bg-rose"><i class="bi bi-person-badge-fill"></i></div>
                <div>
                    <div class="sims-stat-value">{{ $totalUsers }}</div>
                    <div class="sims-stat-label">Registered Users</div>
                </div>
            </div>
        </div>
    </div>

    @if ($latestSchoolYear)
        <div class="text-secondary small mt-3">
            <i class="bi bi-calendar3 me-1"></i>
            <strong>{{ $currentYearEnrollments }}</strong> enrollment{{ $currentYearEnrollments === 1 ? '' : 's' }}
            recorded for the most recent school year, <strong>{{ $latestSchoolYear }}</strong>.
        </div>
    @endif

    <!-- Breakdown section -->
    <div class="row g-4 mt-1">
        <div class="col-lg-6">
            <div class="card sims-breakdown-card">
                <div class="card-header">
                    <i class="bi bi-bar-chart-fill me-2" style="color: var(--sims-primary);"></i>
                    Students by Course
                    <span class="text-secondary fw-normal small">(top 5)</span>
                </div>
                @if ($studentsByCourse->isEmpty())
                    <div class="sims-breakdown-empty">No student data yet.</div>
                @else
                    @foreach ($studentsByCourse as $row)
                        <div class="sims-breakdown-row">
                            <span class="label">{{ $row->course }}</span>
                            <span class="value">{{ $row->total }}</span>
                        </div>
                    @endforeach
                @endif
            </div>
        </div>

        <div class="col-lg-6">
            <div class="card sims-breakdown-card">
                <div class="card-header">
                    <i class="bi bi-pie-chart-fill me-2" style="color: var(--sims-primary);"></i>
                    Enrollments by Status
                </div>
                @if ($enrollmentsByStatus->isEmpty())
                    <div class="sims-breakdown-empty">No enrollment data yet.</div>
                @else
                    @foreach (['enrolled', 'dropped', 'completed'] as $status)
                        <div class="sims-breakdown-row">
                            <span class="label">
                                <span class="sims-status-badge sims-status-{{ $status }}">{{ $status }}</span>
                            </span>
                            <span class="value">{{ $enrollmentsByStatus->get($status)?->total ?? 0 }}</span>
                        </div>
                    @endforeach
                @endif
            </div>
        </div>
    </div>
@endsection
