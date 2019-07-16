view: linkedin_video_ad {
  derived_table: {
    sql:
    (
    SELECT video_ad_history.* FROM `{{ video_ad.linkedin_ads_schema._sql }}.video_ad_history` as video_ad_history
    INNER JOIN (
    SELECT
    id, max(last_modified_time) as max_fivetran_synced
    FROM `{{ video_ad.linkedin_ads_schema._sql }}.video_ad_history`
    GROUP BY id) max_video_history
    ON max_video_history.id = video_ad_history.id
    AND max_video_history.max_fivetran_synced = video_ad_history.last_modified_time
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

  dimension_group: account_last_modified {
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
    sql: ${TABLE}.account_last_modified_time ;;
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

  dimension: owner {
    type: string
    sql: ${TABLE}.owner ;;
  }

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
