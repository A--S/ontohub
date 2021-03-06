class Ontology < ActiveRecord::Base

  # Ontohub Library Includes  
  include Commentable
  include Permissionable
  include Metadatable

  # Ontology Model Includes
  include Ontology::Import
  include Ontology::States
  include Ontology::Versions
  include Ontology::Entities
  include Ontology::Sentences
  include Ontology::Links
  include Ontology::Distributed

  belongs_to :language
  belongs_to :logic, counter_cache: true

  attr_accessible :iri, :name, :description, :logic_id

  validates_presence_of :iri
  validates_uniqueness_of :iri, :if => :iri_changed?
  validates_format_of :iri, :with => URI::regexp(ALLOWED_URI_SCHEMAS)
  
  strip_attributes :only => [:name, :iri]

  scope :search, ->(query) { where "iri #{connection.ilike_operator} :term OR name #{connection.ilike_operator} :term", :term => "%" << query << "%" }
  scope :done_sorted_by_entities_count, where(state: 'done').order('ontologies.entities_count desc')

  def to_s
    name? ? name : iri
  end
  
  # title for links
  def title
    name? ? iri : nil
  end

  def symbols
    entities
  end

  def symbols_count
    entities_count
  end
  
end
