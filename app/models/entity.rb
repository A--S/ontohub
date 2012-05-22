class Entity < ActiveRecord::Base

  include Metadatable
  include Entity::Searching

  belongs_to :ontology_version
  has_and_belongs_to_many :sentences

  scope :kind, ->(kind) { where :kind => kind }

  delegate :ontology, :to => :ontology_version

  def self.grouped_by_kind
    select('kind, count(*) AS count').group(:kind).order('count DESC, kind').all
  end

end
