@php
    $enrollment = $enrollment ?? null;
@endphp

<div class="row g-4">
    <div class="col-md-6">
        <label for="student_id" class="form-label">Student</label>
        <select id="student_id" name="student_id" class="form-select @error('student_id') is-invalid @enderror">
            <option value="">-- Select Student --</option>
            @foreach ($students as $student)
                <option value="{{ $student->id }}" @selected((int) old('student_id', $enrollment?->student_id) === $student->id)>
                    {{ $student->last_name }}, {{ $student->first_name }} ({{ $student->student_number }})
                </option>
            @endforeach
        </select>
        @error('student_id')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="subject_id" class="form-label">Subject</label>
        <select id="subject_id" name="subject_id" class="form-select @error('subject_id') is-invalid @enderror">
            <option value="">-- Select Subject --</option>
            @foreach ($subjects as $subject)
                <option value="{{ $subject->id }}" @selected((int) old('subject_id', $enrollment?->subject_id) === $subject->id)>
                    {{ $subject->subject_code }} - {{ $subject->subject_name }}
                </option>
            @endforeach
        </select>
        @error('subject_id')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-4">
        <label for="school_year" class="form-label">School Year</label>
        <input type="text" id="school_year" name="school_year"
               class="form-control @error('school_year') is-invalid @enderror"
               value="{{ old('school_year', $enrollment?->school_year) }}" maxlength="20"
               placeholder="e.g. 2025-2026">
        @error('school_year')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-4">
        <label for="semester" class="form-label">Semester</label>
        <select id="semester" name="semester" class="form-select @error('semester') is-invalid @enderror">
            <option value="">-- Select Semester --</option>
            @foreach (['1st Semester', '2nd Semester', 'Summer'] as $sem)
                <option value="{{ $sem }}" @selected(old('semester', $enrollment?->semester) === $sem)>{{ $sem }}</option>
            @endforeach
        </select>
        @error('semester')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-4">
        <label for="status" class="form-label">Status</label>
        <select id="status" name="status" class="form-select @error('status') is-invalid @enderror">
            @foreach (['enrolled', 'dropped', 'completed'] as $status)
                <option value="{{ $status }}" @selected(old('status', $enrollment?->status ?? 'enrolled') === $status)>
                    {{ ucfirst($status) }}
                </option>
            @endforeach
        </select>
        @error('status')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>
</div>

<div class="d-flex gap-2 mt-4 pt-3 border-top">
    <button type="submit" class="btn btn-primary">
        <i class="bi bi-check-lg me-1"></i> {{ $enrollment ? 'Save Changes' : 'Add Enrollment' }}
    </button>
    <a href="{{ route('enrollments.index') }}" class="btn btn-outline-primary">Cancel</a>
</div>
