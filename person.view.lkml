view: person {
  sql_table_name: replica.person ;;
  drill_fields: [id]

  dimension: id {
    primary_key: yes
    type: string
    sql: ${TABLE}."id" ;;
  }

  dimension: age {
    type: number
    sql: ${TABLE}.age ;;
  }

  dimension: age_tier {
    type: tier
    tiers: [0, 10, 20, 30, 40, 50, 60, 70, 80]
    style: integer
    sql: ${TABLE}.age ;;
  }

  dimension: age_bucket_id {
    type: number
    sql: ${TABLE}.age_bucket_id ;;
  }

  dimension: commute_mode_id {
    type: number
    sql: ${TABLE}.commute_mode_id ;;
  }

  dimension: employment_id {
    type: number
    sql: ${TABLE}.employment_id ;;
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

  dimension: housing_unit_cell_id {
    type: string
    sql: ${TABLE}.housing_unit_cell_id ;;
  }

  dimension: income_bucket_id {
    type: number
    sql: ${TABLE}.income_bucket_id ;;
  }

  dimension: income_usd {
    type: number
    sql: ${TABLE}.income_usd ;;
  }

  dimension: office_unit_cell_id {
    type: string
    sql: ${TABLE}.office_unit_cell_id ;;
  }

  dimension: race_ethnicity_id {
    type: number
    sql: ${TABLE}.race_ethnicity_id ;;
  }

  dimension: region_id {
    type: number
    sql: ${TABLE}.region_id ;;
  }

  dimension: residency_id {
    type: number
    sql: ${TABLE}.residency_id ;;
  }

  dimension: sex_id {
    type: number
    sql: ${TABLE}.sex_id ;;
  }

  dimension: year {
    type: number
    sql: ${TABLE}.year ;;
  }

  measure: count {
    type: count
    drill_fields: [id, travel_activity.count, travel_segment.count]
  }

  measure: average_income {
    type: average
    sql: ${income_usd} ;;
    value_format_name: usd
    drill_fields: [employment_id,average_income]


  }
}
