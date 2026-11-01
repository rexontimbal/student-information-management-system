<x-guest-layout>
    <h1>Create an account</h1>
    <p class="sims-guest-intro">Register to get access to the SIMS admin panel.</p>

    <form method="POST" action="{{ route('register') }}">
        @csrf

        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input id="name" type="text" name="name" value="{{ old('name') }}"
                   class="form-control @error('name') is-invalid @enderror"
                   required autofocus autocomplete="name">
            @error('name')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input id="email" type="email" name="email" value="{{ old('email') }}"
                   class="form-control @error('email') is-invalid @enderror"
                   required autocomplete="username">
            @error('email')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input id="password" type="password" name="password"
                   class="form-control @error('password') is-invalid @enderror"
                   required autocomplete="new-password">
            @error('password')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <div class="mb-4">
            <label for="password_confirmation" class="form-label">Confirm Password</label>
            <input id="password_confirmation" type="password" name="password_confirmation"
                   class="form-control @error('password_confirmation') is-invalid @enderror"
                   required autocomplete="new-password">
            @error('password_confirmation')
                <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
            @enderror
        </div>

        <button type="submit" class="btn btn-primary w-100">
            <i class="bi bi-person-plus-fill me-1"></i> Register
        </button>
    </form>

    <div class="sims-guest-footer">
        Already registered? <a href="{{ route('login') }}">Log in</a>
    </div>
</x-guest-layout>
