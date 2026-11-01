<x-guest-layout>
    <h1>Welcome back</h1>
    <p class="sims-guest-intro">Sign in to manage students, subjects, and enrollments.</p>

    @if (session('status'))
        <div class="sims-alert sims-alert-success">
            <i class="bi bi-check-circle-fill"></i>
            <div>{{ session('status') }}</div>
        </div>
    @endif

    <form method="POST" action="{{ route('login') }}">
        @csrf

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input id="email" type="email" name="email" value="{{ old('email') }}"
                   class="form-control @error('email') is-invalid @enderror"
                   required autofocus autocomplete="username">
            @error('email')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input id="password" type="password" name="password"
                   class="form-control @error('password') is-invalid @enderror"
                   required autocomplete="current-password">
            @error('password')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <div class="d-flex align-items-center justify-content-between mb-4">
            <div class="form-check">
                <input class="form-check-input" type="checkbox" id="remember_me" name="remember">
                <label class="form-check-label small" for="remember_me">
                    Remember me
                </label>
            </div>

            @if (Route::has('password.request'))
                <a href="{{ route('password.request') }}" class="small text-decoration-none" style="color: var(--sims-primary); font-weight: 600;">
                    Forgot your password?
                </a>
            @endif
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-box-arrow-in-right me-1"></i> Log in
        </button>
    </form>

    @if (Route::has('register'))
        <div class="sims-guest-footer">
            Don't have an account? <a href="{{ route('register') }}">Register</a>
        </div>
    @endif
</x-guest-layout>
