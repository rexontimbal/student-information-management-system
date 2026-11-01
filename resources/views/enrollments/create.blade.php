@extends('layouts.app')

@section('title', 'Add Enrollment')

@section('content')
    <div class="card" style="max-width: 760px;">
        <div class="card-body p-4 p-md-5">
            <form action="{{ route('enrollments.store') }}" method="POST">
                @csrf
                @include('enrollments._form')
            </form>
        </div>
    </div>
@endsection
