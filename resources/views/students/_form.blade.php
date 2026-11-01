@php
    $student = $student ?? null;
@endphp

<div class="row g-4">
    <div class="col-md-6">
        <label for="student_number" class="form-label">Student Number</label>
        <input type="text" id="student_number" name="student_number"
               class="form-control @error('student_number') is-invalid @enderror"
               value="{{ old('student_number', $student?->student_number) }}" maxlength="50">
        @error('student_number')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="email" class="form-label">Email Address</label>
        <input type="email" id="email" name="email"
               class="form-control @error('email') is-invalid @enderror"
               value="{{ old('email', $student?->email) }}" maxlength="255">
        @error('email')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="first_name" class="form-label">First Name</label>
        <input type="text" id="first_name" name="first_name"
               class="form-control @error('first_name') is-invalid @enderror"
               value="{{ old('first_name', $student?->first_name) }}" maxlength="100">
        @error('first_name')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="last_name" class="form-label">Last Name</label>
        <input type="text" id="last_name" name="last_name"
               class="form-control @error('last_name') is-invalid @enderror"
               value="{{ old('last_name', $student?->last_name) }}" maxlength="100">
        @error('last_name')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="course" class="form-label">Course</label>
        <input type="text" id="course" name="course"
               class="form-control @error('course') is-invalid @enderror"
               value="{{ old('course', $student?->course) }}" maxlength="100"
               placeholder="e.g. BS Computer Science">
        @error('course')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="year_level" class="form-label">Year Level</label>
        <input type="text" id="year_level" name="year_level"
               class="form-control @error('year_level') is-invalid @enderror"
               value="{{ old('year_level', $student?->year_level) }}" maxlength="50"
               placeholder="e.g. 2nd Year">
        @error('year_level')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>
</div>

<div class="d-flex gap-2 mt-4 pt-3 border-top">
    <button type="submit" class="btn btn-primary">
        <i class="bi bi-check-lg me-1"></i> {{ $student ? 'Save Changes' : 'Add Student' }}
    </button>
    <a href="{{ route('students.index') }}" class="btn btn-outline-primary">Cancel</a>
</div>
