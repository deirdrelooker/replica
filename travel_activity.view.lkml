view: travel_activity {
  sql_table_name: replica.travel_activity ;;
  drill_fields: [id]
  suggestions: yes

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."id" ;;
  }

  dimension: day_id {
    type: number
    sql: ${TABLE}.day_id ;;
  }

  dimension: distance_bucket_id {
    type: number
    sql: ${TABLE}.distance_bucket_id ;;
  }

  dimension: distance_miles {
    type: number
    sql: ${TABLE}.distance_miles ;;
  }

  dimension: duration {
    type: number
    sql: ${TABLE}.duration ;;
  }

  dimension: duration_bucket_id {
    type: number
    sql: ${TABLE}.duration_bucket_id ;;
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

  dimension: household_num_vehicles_id {
    type: number
    sql: ${TABLE}.household_num_vehicles_id ;;
  }

  dimension: household_size {
    type: number
    sql: ${TABLE}.household_size ;;
  }

  dimension: next_activity_type_id {
    type: number
    sql: ${TABLE}.next_activity_type_id ;;
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

  dimension: primary_travel_mode_id {
    type: number
    sql: ${TABLE}.primary_travel_mode_id ;;
  }

  dimension: start_place_cell_id {
    type: string
    sql: ${TABLE}.start_place_cell_id ;;
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
}
