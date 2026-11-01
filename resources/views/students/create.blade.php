@extends('layouts.app')

@section('title', 'Add Student')

@section('content')
    <div class="card" style="max-width: 760px;">
        <div class="card-body p-4 p-md-5">
            <form action="{{ route('students.store') }}" method="POST">
                @csrf
                @include('students._form')
            </form>
        </div>
    </div>
@endsection
