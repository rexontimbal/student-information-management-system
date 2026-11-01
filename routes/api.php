<?php

use App\Http\Controllers\Api\StudentController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

// NOTE: These Student API endpoints are intentionally left open (no auth middleware)
// for easy testing with Thunder Client/Postman during development.
// In production, protect them (e.g. ->middleware('auth:sanctum')) and/or require API tokens.
Route::apiResource('students', StudentController::class)->names('api.students');
