view: travel_activity {
  sql_table_name: replica.travel_activity ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."id" ;;
  }

  dimension: day_id {
    type: number
    sql: ${TABLE}.day_id ;;
  }

  dimension: distance_miles {
    type: number
    sql: ${TABLE}.distance_miles ;;
  }

  dimension: distance_miles_tier {
    type: tier
    tiers: [0.5, 1, 2, 4, 8, 16, 32, 64]
    style: classic # the default value, could be excluded
    sql: ${distance_miles} ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: duration_mins_tier {
    type: tier
    tiers: [5, 10, 20, 40, 80]
    style: integer # the default value, could be excluded
    sql: ${duration} ;;
  }

  dimension: end_place_cell_id {
    type: string
    sql: ${TABLE}.end_place_cell_id ;;
  }

  dimension_group: end {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.end_time ;;
  }

  dimension: household_id {
    type: string
    sql: ${TABLE}.household_id ;;
  }

  dimension: household_income_bucket_id {
    type: number
    sql: ${TABLE}.household_income_bucket_id ;;
  }

  dimension: household_income_usd {
    type: number
    sql: ${TABLE}.household_income_usd ;;
  }

  dimension: household_income_tier {
    type: tier
    tiers: [15000, 25000, 50000, 75000, 100000, 150000, 200000]
    style: integer # the default value, could be excluded
    sql: ${household_income_usd} ;;
  }

  dimension: household_num_vehicles_id {
    type: number
    sql: ${TABLE}.household_num_vehicles_id ;;
  }


  dimension: household_num_vehicles_label {
    type: string
    case: {
      when: {
        sql: ${household_num_vehicles_id} = 0 ;;
        label: "Unknown"
      }
      when: {
        sql: ${household_num_vehicles_id} = 1 ;;
        label: "One vehicle"
      }
      when: {
        sql: ${household_num_vehicles_id} = 2 ;;
        label: "Two vehicles"
      }
      when: {
        sql: ${household_num_vehicles_id} = 3 ;;
        label: "Three or more vehicles"
      }
      when: {
        sql: ${household_num_vehicles_id} = 4 ;;
        label: "No vehicles"
      }
    }
  }

  dimension: household_size {
    type: number
    sql: ${TABLE}.household_size ;;
  }

  dimension: household_size_tier {
    type: tier
    tiers: [1, 2, 3, 4, 5, 6, 7, 8]
    style: integer # the default value, could be excluded
    sql: ${household_size} ;;
  }

  dimension: next_activity_type_id {
    type: number
    sql: ${TABLE}.next_activity_type_id ;;
  }

 dimension: purpose_label {
    type: string
    case: {
      when: {
        sql: ${next_activity_type_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${next_activity_type_id} = 1 ;;
        label: "Home"
      }
      when: {
        sql: ${next_activity_type_id} = 2 ;;
        label: "Work"
      }
      when: {
        sql: ${next_activity_type_id} = 3 ;;
        label: "School"
      }
      when: {
        sql: ${next_activity_type_id} = 4 ;;
        label: "Eat"
      }
      when: {
        sql: ${next_activity_type_id} = 5 ;;
        label: "Shop"
      }
      when: {
        sql: ${next_activity_type_id} = 6 ;;
        label: "Social"
      }
      when: {
        sql: ${next_activity_type_id} = 7 ;;
        label: "Recreation"
      }
      when: {
        sql: ${next_activity_type_id} = 8 ;;
        label: "Errands"
      }
      when: {
        sql: ${next_activity_type_id} = 9 ;;
        label: "Travel"
      }
      when: {
        sql: ${next_activity_type_id} = 10 ;;
        label: "Pass-through"
      }
      when: {
        sql: ${next_activity_type_id} = 11 ;;
        label: "Facilitate (drop-off etc.)"
      }
      when: {
        sql: ${next_activity_type_id} = 12 ;;
        label: "Lodging"
      }
      when: {
        sql: ${next_activity_type_id} = 13 ;;
        label: "Region arrival"
      }
      when: {
        sql: ${next_activity_type_id} = 14 ;;
        label: "Region departure"
      }
      when: {
        sql: ${next_activity_type_id} = 15 ;;
        label: "Commercial"
      }
    }
  }
  dimension: person_age {
    type: number
    sql: ${TABLE}.person_age ;;
  }

  dimension: person_age_bucket_id {
    type: number
    sql: ${TABLE}.person_age_bucket_id ;;
  }

  dimension: person_commute_mode_id {
    type: number
    sql: ${TABLE}.person_commute_mode_id ;;
  }

  dimension: person_employment_id {
    type: number
    sql: ${TABLE}.person_employment_id ;;
  }

  dimension: person_housing_unit_cell_id {
    type: string
    sql: ${TABLE}.person_housing_unit_cell_id ;;
  }

  dimension: person_id {
    type: string
    # hidden: yes
    sql: ${TABLE}.person_id ;;
  }

  dimension: person_income_bucket_id {
    type: number
    sql: ${TABLE}.person_income_bucket_id ;;
  }

  dimension: person_income_usd {
    type: number
    sql: ${TABLE}.person_income_usd ;;
  }

  dimension: person_office_unit_cell_id {
    type: string
    sql: ${TABLE}.person_office_unit_cell_id ;;
  }

  dimension: person_race_ethnicity_id {
    type: number
    sql: ${TABLE}.person_race_ethnicity_id ;;
  }

  dimension: person_residency_id {
    type: number
    sql: ${TABLE}.person_residency_id ;;
  }

  dimension: person_sex_id {
    type: number
    sql: ${TABLE}.person_sex_id ;;
  }

  dimension: previous_activity_type_id {
    type: number
    sql: ${TABLE}.previous_activity_type_id ;;
  }

  dimension: previous_activity_type_label {
    type: string
    case: {
      when: {
        sql: ${previous_activity_type_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${previous_activity_type_id} = 1 ;;
        label: "Home"
      }
      when: {
        sql: ${previous_activity_type_id} = 2 ;;
        label: "Work"
      }
      when: {
        sql: ${previous_activity_type_id} = 3 ;;
        label: "School"
      }
      when: {
        sql: ${previous_activity_type_id} = 4 ;;
        label: "Eat"
      }
      when: {
        sql: ${previous_activity_type_id} = 5 ;;
        label: "Shop"
      }
      when: {
        sql: ${previous_activity_type_id} = 6 ;;
        label: "Social"
      }
      when: {
        sql: ${previous_activity_type_id} = 7 ;;
        label: "Recreation"
      }
      when: {
        sql: ${previous_activity_type_id} = 8 ;;
        label: "Errands"
      }
      when: {
        sql: ${previous_activity_type_id} = 9 ;;
        label: "Travel"
      }
      when: {
        sql: ${previous_activity_type_id} = 10 ;;
        label: "Pass-through"
      }
      when: {
        sql: ${previous_activity_type_id} = 11 ;;
        label: "Facilitate (drop-off etc.)"
      }
      when: {
        sql: ${previous_activity_type_id} = 12 ;;
        label: "Lodging"
      }
      when: {
        sql: ${previous_activity_type_id} = 13 ;;
        label: "Region arrival"
      }
      when: {
        sql: ${previous_activity_type_id} = 14 ;;
        label: "Region departure"
      }
      when: {
        sql: ${previous_activity_type_id} = 15 ;;
        label: "Commercial"
      }
    }
  }

  dimension: primary_travel_mode_id {
    type: number
    sql: ${TABLE}.primary_travel_mode_id ;;
  }

  dimension: primary_mode_label {
    type: string
    case: {
      when: {
        sql: ${primary_travel_mode_id} = 0 ;;
        label: "Other"
      }
      when: {
        sql: ${primary_travel_mode_id} = 1 ;;
        label: "Walking"
      }
      when: {
        sql: ${primary_travel_mode_id} = 2 ;;
        label: "Biking"
      }
      when: {
        sql: ${primary_travel_mode_id} = 3 ;;
        label: "Public transit"
      }
      when: {
        sql: ${primary_travel_mode_id} = 4 ;;
        label: "Private transit"
      }
      when: {
        sql: ${primary_travel_mode_id} = 5 ;;
        label: "Taxi/TNC"
      }
      when: {
        sql: ${primary_travel_mode_id} = 6 ;;
        label: "Driving"
      }
      when: {
        sql: ${primary_travel_mode_id} = 7 ;;
        label: "Auto passenger"
      }
      when: {
        sql: ${primary_travel_mode_id} = 8 ;;
        label: "Commercial"
      }
    }
  }

  dimension: start_place_cell_id {
    type: string
    sql: ${TABLE}.start_place_cell_id ;;
  }

  dimension: start_place_tract_id {
    type: string
    sql: LEFT(${start_place_cell_id},11) ;;
  }

  dimension: start_place_tract_map {
    type: string
    map_layer_name: census_tract    # this is your map layer
    sql: LEFT(${start_place_cell_id},11) ;;
  }

  dimension_group: start {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.start_time ;;
  }

  measure: count {
    type: count
    drill_fields: [id, person.id]
  }

  measure: person_count_distinct {
    type: count_distinct
    sql: ${person_id} ;;
  }

  measure: resident_count_distinct {
    type: count_distinct
    sql: ${person.id} ;;
  }

  measure: average_distance_miles {
    type: average
    value_format: "0.##"
    sql: ${distance_miles} ;;
  }

  measure: total_distance_miles {
    type: sum
    value_format: "#,##0"
    sql: ${distance_miles};;
  }

  measure: average_distance_per_person_miles {
    type: number
    value_format: "0.##"
    sql: SUM(${distance_miles})/COUNT(DISTINCT(${person_id}));;
  }

  measure: average_distance_per_resident {
    type: number
    value_format: "0.##"
    sql: SUM(${distance_miles})/COUNT(DISTINCT(${person.id}));;
  }

  measure: average_duration_minutes {
    type: average
    value_format: "0.##"
    sql: ${duration}/60 ;;
  }
  measure: average_speed_mph {
    type: number
    value_format: "0.##"
    sql: (${average_distance_miles}/(${average_duration_minutes}/60)) ;;
  }



}
