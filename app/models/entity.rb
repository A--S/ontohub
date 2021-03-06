class Entity < ActiveRecord::Base

  include Metadatable
  include Entity::Searching
  include Entity::Readability

  belongs_to :ontology
  has_and_belongs_to_many :sentences

  scope :kind, ->(kind) { where :kind => kind }

  def self.groups_by_kind
    groups = select('kind, count(*) AS count').group(:kind).order('count DESC, kind').all
    groups << Struct.new(:kind, :count).new("Symbol",0) if groups.empty?
    groups
  end

end
