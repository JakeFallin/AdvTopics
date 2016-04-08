//package com.jakefallin.rhsapp;
//
//import android.app.Fragment;
//import android.content.Context;
//import android.support.v4.app.FragmentManager;
//import android.support.v4.app.FragmentPagerAdapter;
//
///**
// * Created by Jake on 3/22/2016.
// */
//public class MainActivityAdapter extends FragmentPagerAdapter{
//
//    public static final int NUM_ITEMS = 3;
//    public static final int TODAY = 0;
//    public static final int SCHEDULE = 1;
//    public static final int ABSENCE = 2;
//
//    private Context context;
//
////    public MainActivityAdapter(Context context, FragmentManager fm) {
////        super(fm);
//        this.context = context;
//    }
//
//    @Override
//    public Fragment getItem(int position) {
//        switch (position) {
//            case TODAY:
//                return InfoFragment.newInstance();
//            case SCHEDULE:
//                return ScheduleFragment.newInstance();
//            case ABSENCE:
//                return AbsencesFragment.newInstance();
//            default:
//                return null;
//        }
//    }
//
//    @Override
//    public CharSequence getPageTitle(int position) {
//        switch (position) {
//            case ALL_POS:
//                return context.getString(R.string.all);
//            case SHARED_POS:
//                return context.getString(R.string.shared);
//            case FAVORITES_POS:
//                return context.getString(R.string.favorites);
//            default:
//                return "";
//        }
//    }
//
//    @Override
//    public int getCount() {
//        return NUM_ITEMS;
//    }
//}
//}
