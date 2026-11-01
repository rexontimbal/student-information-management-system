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

        <!-- SIMS custom theme (overrides Bootstrap defaults) -->
        <link href="{{ asset('css/custom.css') }}" rel="stylesheet">

        @stack('styles')
    </head>
    <body>
        <div class="sims-app">
            <div class="sims-sidebar-backdrop" id="sidebarBackdrop"></div>

            <!-- Sidebar -->
            <aside class="sims-sidebar" id="simsSidebar">
                <div class="sims-sidebar-brand">
                    <div class="mark">S</div>
                    <div>
                        <div class="name">SIMS</div>
                        <div class="sub">Admin Panel</div>
                    </div>
                </div>

                <nav class="sims-nav">
                    <div class="sims-nav-section-label">Main</div>

                    <a href="{{ route('dashboard') }}" class="sims-nav-link {{ request()->routeIs('dashboard') ? 'active' : '' }}">
                        <i class="bi bi-grid-1x2-fill"></i>
                        <span>Dashboard</span>
                    </a>

                    <div class="sims-nav-section-label">Academics</div>

                    <a href="{{ Route::has('students.index') ? route('students.index') : '#' }}" class="sims-nav-link {{ request()->routeIs('students.*') ? 'active' : '' }}">
                        <i class="bi bi-people-fill"></i>
                        <span>Students</span>
                    </a>

                    <a href="{{ Route::has('subjects.index') ? route('subjects.index') : '#' }}" class="sims-nav-link {{ request()->routeIs('subjects.*') ? 'active' : '' }}">
                        <i class="bi bi-journal-bookmark-fill"></i>
                        <span>Subjects</span>
                    </a>

                    <a href="{{ Route::has('enrollments.index') ? route('enrollments.index') : '#' }}" class="sims-nav-link {{ request()->routeIs('enrollments.*') ? 'active' : '' }}">
                        <i class="bi bi-clipboard2-check-fill"></i>
                        <span>Enrollments</span>
                    </a>
                </nav>

                @auth
                    <div class="sims-sidebar-user">
                        <div class="who">
                            <div class="avatar">{{ strtoupper(substr(auth()->user()->name, 0, 1)) }}</div>
                            <div class="meta">
                                <div class="u-name">{{ auth()->user()->name }}</div>
                                <span class="u-role">{{ auth()->user()->role ?? 'staff' }}</span>
                            </div>
                        </div>
                        <form method="POST" action="{{ route('logout') }}">
                            @csrf
                            <button type="submit" class="btn-logout">
                                <i class="bi bi-box-arrow-right"></i>
                                <span>Log Out</span>
                            </button>
                        </form>
                    </div>
                @endauth
            </aside>

            <div class="sims-main">
                <!-- Mobile topbar -->
                <div class="sims-topbar">
                    <button class="btn-hamburger" id="sidebarToggle" type="button" aria-label="Toggle navigation">
                        <i class="bi bi-list"></i>
                    </button>
                    <div class="d-flex align-items-center gap-2">
                        <div class="mark">S</div>
                        <strong>SIMS</strong>
                    </div>
                    <div style="width:40px;"></div>
                </div>

                <!-- Page header -->
                @isset($header)
                    <div class="sims-page-header">
                        <div class="title-row">
                            <div>{{ $header }}</div>
                        </div>
                    </div>
                @else
                    @hasSection('title')
                        <div class="sims-page-header">
                            <div class="title-row">
                                <h1>@yield('title')</h1>
                                <div>@yield('page-actions')</div>
                            </div>
                        </div>
                    @endif
                @endisset

                <div class="sims-page-content">
                    @isset($slot)
                        {{ $slot }}
                    @else
                        @yield('content')
                    @endisset
                </div>
            </div>
        </div>

        <!-- Toast notifications -->
        <div class="toast-container sims-toast-container position-fixed top-0 end-0 p-3">
            @if (session('success'))
                <div class="toast sims-toast sims-toast-success" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="4000">
                    <div class="toast-body d-flex align-items-start gap-2">
                        <i class="bi bi-check-circle-fill"></i>
                        <div class="flex-grow-1">{{ session('success') }}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            @endif

            @if (session('error'))
                <div class="toast sims-toast sims-toast-danger" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="4000">
                    <div class="toast-body d-flex align-items-start gap-2">
                        <i class="bi bi-exclamation-triangle-fill"></i>
                        <div class="flex-grow-1">{{ session('error') }}</div>
                        <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                    </div>
                </div>
            @endif

            @if ($errors->any())
                @foreach ($errors->all() as $message)
                    <div class="toast sims-toast sims-toast-danger" role="alert" aria-live="assertive" aria-atomic="true" data-bs-delay="4000">
                        <div class="toast-body d-flex align-items-start gap-2">
                            <i class="bi bi-exclamation-triangle-fill"></i>
                            <div class="flex-grow-1">{{ $message }}</div>
                            <button type="button" class="btn-close" data-bs-dismiss="toast" aria-label="Close"></button>
                        </div>
                    </div>
                @endforeach
            @endif
        </div>

        <!-- Reusable delete confirmation modal -->
        <div class="modal fade" id="deleteConfirmModal" tabindex="-1" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered">
                <div class="modal-content sims-modal">
                    <div class="modal-body p-4">
                        <div class="d-flex align-items-center gap-3 mb-2">
                            <div class="sims-modal-icon"><i class="bi bi-exclamation-triangle-fill"></i></div>
                            <h5 class="fw-bold mb-0">Delete this record?</h5>
                        </div>
                        <p class="text-secondary mb-1" id="deleteConfirmLabel"></p>
                        <p class="small fw-semibold mb-0" style="color: var(--sims-danger);">This action cannot be undone.</p>
                    </div>
                    <div class="modal-footer border-0 justify-content-end pb-4 pt-0">
                        <button type="button" class="btn btn-outline-primary" data-bs-dismiss="modal">Cancel</button>
                        <form id="deleteConfirmForm" method="POST" action="">
                            @csrf
                            @method('DELETE')
                            <button type="submit" class="btn btn-danger">
                                <i class="bi bi-trash me-1"></i> Delete
                            </button>
                        </form>
                    </div>
                </div>
            </div>
        </div>

        <!-- Bootstrap 5 JS -->
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

        <script>
            (function () {
                const sidebar = document.getElementById('simsSidebar');
                const backdrop = document.getElementById('sidebarBackdrop');
                const toggle = document.getElementById('sidebarToggle');

                function closeSidebar() {
                    sidebar.classList.remove('show');
                    backdrop.classList.remove('show');
                }

                toggle?.addEventListener('click', function () {
                    sidebar.classList.toggle('show');
                    backdrop.classList.toggle('show');
                });

                backdrop?.addEventListener('click', closeSidebar);
            })();

            // Show all flash/validation toasts on page load, auto-dismissing.
            (function () {
                document.querySelectorAll('.sims-toast-container .toast').forEach(function (el) {
                    new bootstrap.Toast(el).show();
                });
            })();

            // Populate the shared delete confirmation modal from the triggering button's data attributes.
            (function () {
                const deleteModal = document.getElementById('deleteConfirmModal');
                deleteModal?.addEventListener('show.bs.modal', function (event) {
                    const button = event.relatedTarget;
                    document.getElementById('deleteConfirmForm').action = button.getAttribute('data-delete-url');
                    document.getElementById('deleteConfirmLabel').textContent = button.getAttribute('data-delete-label');
                });
            })();
        </script>

        @stack('scripts')
    </body>
</html>
