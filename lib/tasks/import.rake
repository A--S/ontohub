namespace :import do
  namespace :xml_files do
    desc 'Import the latest XML of every ontology again.'
    task :again => :environment do
      ActiveRecord::Base.logger = Logger.new($stdout)
      Ontology.all.map(&:import_latest_version)
    end
  end
end
