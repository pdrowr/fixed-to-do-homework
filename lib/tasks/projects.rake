# frozen_string_literal: true

namespace :projects do
  desc 'Print projects and all of them items'
  task print: :environment do
    projects = Project.all.includes(:items)

    projects.each_with_index do |project, index|
      puts "#{index + 1} - #{project.title}"

      project.items.each_with_index do |item, idx|
        puts "    #{index + 1}.#{idx +1} - #{item.action} #{item.done? ? '[COMPLETED]' : ''}"
      end

    end
  end
end
