view: linkedin_campaign_group {
  extends: [linkedin_ads_config]
  derived_table: {
    sql:
    (
    SELECT campaign_group_history.* FROM `{{ campaign_group.linkedin_ads_schema._sql }}.campaign_group_history` as campaign_group_history
    INNER JOIN (
    SELECT
    id, max(last_modified_time) as max_fivetran_synced
    FROM `{{ campaign_group.linkedin_ads_schema._sql }}.campaign_group_history`
    GROUP BY id) max_campaign_group_history
    ON max_campaign_group_history.id = campaign_group_history.id
    AND max_campaign_group_history.max_fivetran_synced = campaign_group_history.last_modified_time
    ) ;;
  }

  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension_group: _fivetran_synced {
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
    sql: ${TABLE}._fivetran_synced ;;
  }

  dimension: account_id {
    type: number
    sql: ${TABLE}.account_id ;;
  }

  dimension: backfilled {
    type: yesno
    sql: ${TABLE}.backfilled ;;
  }

  dimension_group: created {
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
    sql: ${TABLE}.created_time ;;
  }

  dimension_group: last_modified {
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
    sql: ${TABLE}.last_modified_time ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension_group: run_schedule_end {
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
    sql: ${TABLE}.run_schedule_end ;;
  }

  dimension_group: run_schedule_start {
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
    sql: ${TABLE}.run_schedule_start ;;
  }

  dimension: status {
    type: string
    sql: ${TABLE}.status ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
