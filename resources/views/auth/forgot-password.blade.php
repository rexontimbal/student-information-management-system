<x-guest-layout>
    <h1>Forgot your password?</h1>
    <p class="sims-guest-intro">
        No problem. Just let us know your email address and we will email you a password reset link.
    </p>

    @if (session('status'))
        <div class="sims-alert sims-alert-success">
            <i class="bi bi-check-circle-fill"></i>
            <div>{{ session('status') }}</div>
        </div>
    @endif

    <form method="POST" action="{{ route('password.email') }}">
        @csrf

        <div class="mb-4">
            <label for="email" class="form-label">Email</label>
            <input id="email" type="email" name="email" value="{{ old('email') }}"
                   class="form-control @error('email') is-invalid @enderror"
                   required autofocus>
            @error('email')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-envelope-fill me-1"></i> Email Password Reset Link
        </button>
    </form>

    <div class="sims-guest-footer">
        <a href="{{ route('login') }}">Back to login</a>
    </div>
</x-guest-layout>
