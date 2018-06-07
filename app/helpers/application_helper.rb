# frozen_string_literal: true

module ApplicationHelper
  def pretty_time_span(a, b)
    diff = b - a
    res = []

    if diff >= 1.year
      res << "#{(diff / 1.year).round}y"
      diff -= (diff / 1.year).round.years
    end

    if diff >= 1.month
      res << "#{(diff / 1.month).round}m"
      diff -= (diff / 1.month).round.months
    end

    if diff >= 1.day
      res << "#{(diff / 1.day).round}d"
      diff -= (diff / 1.day).round.days
    end

    if diff >= 1.hour
      res << "#{(diff / 1.hour).round}h"
      diff -= (diff / 1.hour).round.hours
    end

    if diff >= 1.minute
      res << "#{(diff / 1.minute).round}m"
      diff -= (diff / 1.minute).round.minutes
    end

    if diff >= 1.second
      res << "#{(diff / 1.second).round}s"
      diff -= (diff / 1.second).round.seconds
    end

    res << "#{(diff / 0.001).round}ms" if diff >= 0.001 || res.empty?

    res.join ', '
  end
end
