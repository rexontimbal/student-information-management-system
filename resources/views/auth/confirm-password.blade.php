<x-guest-layout>
    <h1>Confirm password</h1>
    <p class="sims-guest-intro">
        This is a secure area of the application. Please confirm your password before continuing.
    </p>

    <form method="POST" action="{{ route('password.confirm') }}">
        @csrf

        <div class="mb-4">
            <label for="password" class="form-label">Password</label>
            <input id="password" type="password" name="password"
                   class="form-control @error('password') is-invalid @enderror"
                   required autocomplete="current-password">
            @error('password')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-shield-lock-fill me-1"></i> Confirm
        </button>
    </form>
</x-guest-layout>
