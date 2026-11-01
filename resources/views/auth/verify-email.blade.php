<x-guest-layout>
    <h1>Verify your email</h1>
    <p class="sims-guest-intro">
        Thanks for signing up! Before getting started, could you verify your email address by clicking on the
        link we just emailed to you? If you didn't receive the email, we'll gladly send you another.
    </p>

    @if (session('status') == 'verification-link-sent')
        <div class="sims-alert sims-alert-success">
            <i class="bi bi-check-circle-fill"></i>
            <div>A new verification link has been sent to the email address you provided during registration.</div>
        </div>
    @endif

    <div class="d-flex align-items-center justify-content-between gap-3">
        <form method="POST" action="{{ route('verification.send') }}">
            @csrf
            <button type="submit" class="btn btn-primary">
                <i class="bi bi-envelope-fill me-1"></i> Resend Verification Email
            </button>
        </form>

        <form method="POST" action="{{ route('logout') }}">
            @csrf
            <button type="submit" class="btn btn-outline-primary">
                <i class="bi bi-box-arrow-right me-1"></i> Log Out
            </button>
        </form>
    </div>
</x-guest-layout>
