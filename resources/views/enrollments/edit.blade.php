@extends('layouts.app')

@section('title', 'Edit Enrollment')

@section('content')
    <div class="card" style="max-width: 760px;">
        <div class="card-body p-4 p-md-5">
            <form action="{{ route('enrollments.update', $enrollment) }}" method="POST">
                @csrf
                @method('PUT')
                @include('enrollments._form')
            </form>
        </div>
    </div>
@endsection
