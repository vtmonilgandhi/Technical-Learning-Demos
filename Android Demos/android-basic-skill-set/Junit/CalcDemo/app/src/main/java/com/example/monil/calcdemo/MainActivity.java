package com.example.monil.calcdemo;

import android.support.v7.app.AppCompatActivity;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class MainActivity extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_main);

        final EditText value1 = (EditText) findViewById(R.id.value1);
        final EditText value2 = (EditText) findViewById(R.id.value2);

        final TextView result = (TextView) findViewById(R.id.result);

        Button addButton = (Button) findViewById(R.id.addValues);
        addButton.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                try {
                    int val1 = Integer.parseInt(value1.getText().toString());
                    int val2 = Integer.parseInt(value2.getText().toString());

                    Integer answer = val1 + val2;
                    result.setText(answer.toString());
                } catch (Exception e) {
                    Log.e("TAG", "Failed to add numbers", e);
                }
            }
        });

        Button multiplyButton = (Button) findViewById(R.id.multiplyValues);
        multiplyButton.setOnClickListener(new View.OnClickListener() {

            public void onClick(View v) {
                try {
                    int val1 = Integer.parseInt(value1.getText().toString());
                    int val2 = Integer.parseInt(value2.getText().toString());

                    Integer answer = val1 * val2;
                    result.setText(answer.toString());
                } catch (Exception e) {
                    Log.e("TAG", "Failed to multiply numbers", e);
                }
            }
        });
    }
}



