<!DOCTYPE html>
<html lang="{{ str_replace('_', '-', app()->getLocale()) }}">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">

        <title>@yield('title', config('app.name', 'SIMS')) &middot; {{ config('app.name', 'SIMS') }}</title>

        <!-- Google Font -->
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

        <!-- Bootstrap 5 -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css" rel="stylesheet">

        <!-- SIMS custom theme -->
        <link href="{{ asset('css/custom.css') }}" rel="stylesheet">
    </head>
    <body>
        <div class="sims-guest-shell">
            <div class="sims-guest-wrap">
                <a href="/" class="sims-guest-brand">
                    <div class="mark">S</div>
                    <div>
                        <div class="name">SIMS</div>
                        <div class="sub">Student Information Management System</div>
                    </div>
                </a>

                <div class="card sims-guest-card">
                    <div class="card-body p-4 p-md-5">
                        {{ $slot }}
                    </div>
                </div>
            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
    </body>
</html>
