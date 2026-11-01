<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">

        <title>{{ config('app.name', 'SIMS') }}</title>

        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">
        <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
    </head>
    <body>
        <div class="sims-guest-shell">
            <div class="sims-guest-wrap text-center" style="max-width: 480px;">
                <div class="sims-guest-brand justify-content-center">
                    <div class="mark" style="width: 60px; height: 60px; font-size: 1.6rem; border-radius: 16px;">S</div>
                </div>

                <h1 class="fw-bold mb-2" style="font-size: 2rem; color: var(--sims-ink);">SIMS</h1>
                <p class="text-secondary mb-4">
                    Student Information Management System &mdash; manage students, subjects, and enrollments in one place.
                </p>

                <div class="d-flex flex-column flex-sm-row gap-2 justify-content-center">
                    @auth
                        <a href="{{ url('/dashboard') }}" class="btn btn-primary px-4">
                            <i class="bi bi-speedometer2 me-1"></i> Go to Dashboard
                        </a>
                    @else
                        <a href="{{ route('login') }}" class="btn btn-primary px-4">
                            <i class="bi bi-box-arrow-in-right me-1"></i> Log in
                        </a>
                        @if (Route::has('register'))
                            <a href="{{ route('register') }}" class="btn btn-outline-primary px-4">
                                <i class="bi bi-person-plus-fill me-1"></i> Register
                            </a>
                        @endif
                    @endauth
                </div>
            </div>
        </div>
    </body>
</html>
