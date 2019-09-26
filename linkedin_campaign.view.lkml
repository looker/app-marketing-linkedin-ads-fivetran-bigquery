view: linkedin_campaign {
  extends: [linkedin_ads_config]
  derived_table: {
    sql:
    (
    SELECT campaign_history.* FROM `{{ campaign.linkedin_ads_schema._sql }}.campaign_history` as campaign_history
    INNER JOIN (
    SELECT
    id, max(last_modified_time) as max_fivetran_synced
    FROM `{{ campaign.linkedin_ads_schema._sql }}.campaign_history`
    GROUP BY id) max_campaign_history
    ON max_campaign_history.id = campaign_history.id
    AND max_campaign_history.max_fivetran_synced = campaign_history.last_modified_time
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

  dimension: account_id_string {
    hidden: yes
    sql: CAST(${TABLE}.account_id as STRING) ;;
  }

  dimension: associated_entity {
    type: string
    sql: ${TABLE}.associated_entity ;;
  }

  dimension: audience_expansion_enabled {
    type: yesno
    sql: ${TABLE}.audience_expansion_enabled ;;
  }

  dimension: campaign_group_id {
    type: number
    sql: ${TABLE}.campaign_group_id ;;
  }

  dimension: cost_type {
    type: string
    sql: ${TABLE}.cost_type ;;
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

  dimension: creative_selection {
    type: string
    sql: ${TABLE}.creative_selection ;;
  }

  dimension: daily_budget_amount {
    type: number
    sql: ${TABLE}.daily_budget_amount ;;
  }

  dimension: daily_budget_currency_code {
    type: string
    sql: ${TABLE}.daily_budget_currency_code ;;
  }

  dimension: format {
    type: string
    sql: ${TABLE}.format ;;
  }

  dimension_group: _date {
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

  dimension: locale_country {
    type: string
    sql: ${TABLE}.locale_country ;;
  }

  dimension: locale_language {
    type: string
    sql: ${TABLE}.locale_language ;;
  }

  dimension: name {
    type: string
    sql: ${TABLE}.name ;;
  }

  dimension: objective_type {
    type: string
    sql: ${TABLE}.objective_type ;;
  }

  dimension: offsite_delivery_enabled {
    type: yesno
    sql: ${TABLE}.offsite_delivery_enabled ;;
  }

  dimension: optimization_target_type {
    type: string
    sql: ${TABLE}.optimization_target_type ;;
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

  dimension: type {
    type: string
    sql: ${TABLE}.type ;;
  }

  dimension: unit_cost_amount {
    type: number
    sql: ${TABLE}.unit_cost_amount ;;
  }

  dimension: unit_cost_currency_code {
    type: string
    sql: ${TABLE}.unit_cost_currency_code ;;
  }

  dimension: version_tag {
    type: string
    sql: ${TABLE}.version_tag ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
