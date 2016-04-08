package com.jakefallin.rhsapp.Fragments;

import android.content.Context;
import android.os.Bundle;
import android.support.design.widget.CoordinatorLayout;
import android.support.design.widget.Snackbar;
import android.support.v4.app.Fragment;
import android.support.v7.widget.LinearLayoutManager;
import android.support.v7.widget.RecyclerView;
import android.util.AttributeSet;
import android.util.Log;
import android.view.LayoutInflater;
import android.view.View;
import android.view.ViewGroup;

import com.android.volley.Request;
import com.android.volley.Response;
import com.android.volley.VolleyError;
import com.android.volley.VolleyLog;
import com.android.volley.toolbox.JsonObjectRequest;
import com.jakefallin.rhsapp.Adapters.ScheduleAdapter;
import com.jakefallin.rhsapp.MainActivity;
import com.jakefallin.rhsapp.R;
import com.jakefallin.rhsapp.Util.AppController;
import com.jakefallin.rhsapp.Util.Fab;
import com.jakefallin.rhsapp.Util.Schedule;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import java.util.ArrayList;

public class ScheduleFragment extends Fragment {


    private String jsonResponse;

    private ArrayList<Schedule> scheduleListToday;
    private ArrayList<Schedule> scheduleListTomorrow;

    private ScheduleAdapter mAdapterToday;
    private ScheduleAdapter temp;
    private ScheduleAdapter mAdapterTomorrow;
    private String urlJsonObj = "http://app.ridgewood.k12.nj.us/rhsstu/api/public/mobile/getdashboard.php";
    private static String TAG = MainActivity.class.getSimpleName();

    private ArrayList<String> period = new ArrayList<String>();
    private ArrayList<String> start = new ArrayList<String>();
    private ArrayList<String> end = new ArrayList<String>();
    boolean today = true;
    RecyclerView recyclerView;

    Fab f;

    public static ScheduleFragment newInstance(boolean today) {
        ScheduleFragment myFragment = new ScheduleFragment();

        Bundle args = new Bundle();
        args.putBoolean("b", today);
        myFragment.setArguments(args);

        return myFragment;
    }


    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        Bundle bundle = this.getArguments();


        scheduleListToday = new ArrayList<Schedule>();
        scheduleListTomorrow = new ArrayList<Schedule>();
        makeJsonObjectRequest();

        mAdapterToday = new ScheduleAdapter(scheduleListToday);
        mAdapterTomorrow = new ScheduleAdapter(scheduleListToday);

        final CoordinatorLayout c = (CoordinatorLayout)getActivity().findViewById(R.id.main_content);
        f = (Fab) getActivity().findViewById(R.id.fab);

        f.setOnClickListener(new View.OnClickListener()
        {
            public void onClick(View v)
            {
                if(today) {
                    Snackbar.make(c, "Showing tomorrow's schedule.", Snackbar.LENGTH_SHORT).show();
                    mAdapterToday.updateList(scheduleListTomorrow);
                    today = false;
                }
                else {
                    Snackbar.make(c, "Showing today's schedule.", Snackbar.LENGTH_SHORT).show();
                    mAdapterToday.updateList(scheduleListToday);
                    today = true;
                }
            }
        });
    }

    @Override
    public View onCreateView(LayoutInflater inflater, ViewGroup container,
                             Bundle savedInstanceState) {

        recyclerView = (RecyclerView) inflater.inflate(
                R.layout.recycler_view_schedule, container, false);

            recyclerView.setAdapter(mAdapterToday);
            recyclerView.setHasFixedSize(true);
            recyclerView.setLayoutManager(new LinearLayoutManager(getActivity()));

        return recyclerView;
    }

    @Override
    public void onInflate(Context context, AttributeSet attrs,
                          Bundle savedInstanceState) {
        super.onInflate(context, attrs, savedInstanceState);

    }

    private void makeJsonObjectRequest() {

        final JsonObjectRequest jsonObjReq = new JsonObjectRequest(Request.Method.GET,
                urlJsonObj, null, new Response.Listener<JSONObject>() {

            @Override
            public void onResponse(JSONObject response) {
                Log.d(TAG, response.toString());

                try {

                    // Parsing json object response
                    // response will be a json object
                    JSONObject today = response.getJSONObject("today");
                    JSONObject tomorrow = response.getJSONObject("next");

                    boolean nonDay = today.getBoolean("nonDay");

                    String dayToday = today.getString("day");
                    String messageToday = today.getString("message");

                    JSONArray scheduleToday = today.getJSONArray("schedule");
                    JSONArray scheduleTomorrow = tomorrow.getJSONArray("schedule");


                    for (int i = 0; i < scheduleToday.length(); i++) {
                        try {

                            JSONObject scheduleObj = scheduleToday.getJSONObject(i);

                            String e = scheduleObj.getString("end");
                            String s = scheduleObj.getString("start");
                            String p = scheduleObj.getString("period");

                            if (p.equals("Lunch")) {
                                Schedule temp = new Schedule(p, s, e);
                                scheduleListToday.add(temp);
                                mAdapterToday.notifyDataSetChanged();
                            } else {
                                Schedule temp = new Schedule("Period " + p, s, e);
                                scheduleListToday.add(temp);
                                mAdapterToday.notifyDataSetChanged();
                            }
                        } catch (JSONException e) {

                        }
                    }

                    for (int i = 0; i < scheduleTomorrow.length(); i++) {
                        try {

                            JSONObject scheduleObj = scheduleTomorrow.getJSONObject(i);

                            String e = scheduleObj.getString("end");
                            String s = scheduleObj.getString("start");
                            String p = scheduleObj.getString("period");

                            if (p.equals("Lunch")) {
                                Schedule temp = new Schedule(p, s, e);
                                scheduleListTomorrow.add(temp);
                                mAdapterTomorrow.notifyDataSetChanged();
                            } else {
                                Schedule temp = new Schedule("Period " + p, s, e);
                                scheduleListTomorrow.add(temp);
                                mAdapterTomorrow.notifyDataSetChanged();
                            }
                        } catch (JSONException e) {

                        }
                    }


                } catch (JSONException e) {
                    e.printStackTrace();

                }
            }
        }, new Response.ErrorListener() {

            @Override
            public void onErrorResponse(VolleyError error) {
                VolleyLog.d(TAG, "Error: " + error.getMessage());

                // hide the progress dialog
            }
        });

        // Adding request to request queue
        AppController.getInstance().addToRequestQueue(jsonObjReq);
    }


    private void scheduleData() {

        int length = period.size();

    }



}
