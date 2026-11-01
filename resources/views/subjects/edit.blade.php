@extends('layouts.app')

@section('title', 'Edit Subject')

@section('content')
    <div class="card" style="max-width: 760px;">
        <div class="card-body p-4 p-md-5">
            <form action="{{ route('subjects.update', $subject) }}" method="POST">
                @csrf
                @method('PUT')
                @include('subjects._form')
            </form>
        </div>
    </div>
@endsection
