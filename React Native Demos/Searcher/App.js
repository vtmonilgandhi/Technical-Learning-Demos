import React, { useState } from "react";
import { StyleSheet, View, Button, ScrollView, FlatList } from "react-native";

import GoalItem from "./components/GoalItem";
import GoalInput from "./components/GoalInput";

export default function App() {
  const [courseGoals, setCourseGoals] = useState([]);
  const [isAddMode, setIsAddMode] = useState(false);

  const addGoalHandler = (GoalTitle) => {
    if (GoalTitle.length === 0) {
      return;
    }
    setCourseGoals((currentGoals) => [
      ...currentGoals,
      { id: Math.random().toString(), value: GoalTitle },
    ]);
    setIsAddMode(false);
  };

  const removeGoalHandler = (goalId) => {
    setCourseGoals((currentGoals) => {
      return currentGoals.filter((goal) => goal.id != goalId);
    });
  };

  const cancelGoalHandler = () => {
    setIsAddMode(false);
  };

  return (
    <View style={styles.screen}>
      <Button
        title="Add New Goal"
        onPress={() => {
          setIsAddMode(true);
        }}
      />
      <GoalInput
        visible={isAddMode}
        onAddGoal={addGoalHandler}
        onCancel={cancelGoalHandler}
      />

      {/* ScrollView Demo */}
      {/* 
      <ScrollView>
        {courseGoals.map((goal) => {
          return (
            <View key={goal} style={styles.listItem}>
              <Text>{goal}</Text>
            </View>
          );
        })}
      </ScrollView>
       */}
      <FlatList
        keyExtractor={(item, index) => item.id}
        data={courseGoals}
        renderItem={(itemData) => (
          <GoalItem
            id={itemData.item.id}
            onDelete={removeGoalHandler}
            title={itemData.item.value}
          />
        )}
      />
    </View>
  );
}

const styles = StyleSheet.create({
  screen: {
    padding: 50,
  },
});
