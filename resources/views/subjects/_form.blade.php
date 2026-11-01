@php
    $subject = $subject ?? null;
@endphp

<div class="row g-4">
    <div class="col-md-6">
        <label for="subject_code" class="form-label">Subject Code</label>
        <input type="text" id="subject_code" name="subject_code"
               class="form-control @error('subject_code') is-invalid @enderror"
               value="{{ old('subject_code', $subject?->subject_code) }}" maxlength="50"
               placeholder="e.g. CS101">
        @error('subject_code')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-6">
        <label for="units" class="form-label">Units</label>
        <input type="number" id="units" name="units" min="1" max="6"
               class="form-control @error('units') is-invalid @enderror"
               value="{{ old('units', $subject?->units) }}">
        @error('units')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>

    <div class="col-md-12">
        <label for="subject_name" class="form-label">Subject Name</label>
        <input type="text" id="subject_name" name="subject_name"
               class="form-control @error('subject_name') is-invalid @enderror"
               value="{{ old('subject_name', $subject?->subject_name) }}" maxlength="150"
               placeholder="e.g. Introduction to Computing">
        @error('subject_name')
            <div class="sims-field-error"><i class="bi bi-exclamation-circle-fill"></i>{{ $message }}</div>
        @enderror
    </div>
</div>

<div class="d-flex gap-2 mt-4 pt-3 border-top">
    <button type="submit" class="btn btn-primary">
        <i class="bi bi-check-lg me-1"></i> {{ $subject ? 'Save Changes' : 'Add Subject' }}
    </button>
    <a href="{{ route('subjects.index') }}" class="btn btn-outline-primary">Cancel</a>
</div>
