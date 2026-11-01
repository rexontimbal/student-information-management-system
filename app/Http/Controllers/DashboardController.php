<?php

namespace App\Http\Controllers;

use App\Models\Enrollment;
use App\Models\Student;
use App\Models\Subject;
use App\Models\User;

class DashboardController extends Controller
{
    /**
     * Display the dashboard with system statistics.
     */
    public function index()
    {
        $studentsByCourse = Student::selectRaw('course, count(*) as total')
            ->groupBy('course')
            ->orderByDesc('total')
            ->limit(5)
            ->get();

        $enrollmentsByStatus = Enrollment::selectRaw('status, count(*) as total')
            ->groupBy('status')
            ->get()
            ->keyBy('status');

        $latestSchoolYear = Enrollment::max('school_year');

        $currentYearEnrollments = $latestSchoolYear
            ? Enrollment::where('school_year', $latestSchoolYear)->count()
            : 0;

        return view('dashboard', [
            'totalStudents' => Student::count(),
            'totalSubjects' => Subject::count(),
            'totalEnrollments' => Enrollment::count(),
            'totalUsers' => User::count(),
            'studentsByCourse' => $studentsByCourse,
            'enrollmentsByStatus' => $enrollmentsByStatus,
            'latestSchoolYear' => $latestSchoolYear,
            'currentYearEnrollments' => $currentYearEnrollments,
        ]);
    }
}
