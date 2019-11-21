class DatabaseCredential < ApplicationRecord
  has_many :endpoints
  validates :user, presence: true
  validates :database, presence: true
  validates :host, presence: true
  validates :port, presence: true

  def password
    super.blank? ? '' : encryptor.decrypt_and_verify(super)
  end

  def password=(plain_data)
    encrypted_data = encryptor.encrypt_and_sign(plain_data)
    super(encrypted_data)
  end

  rails_admin do
    fields :id, :name, :user, :database, :password, :host, :port, :created_at

    exclude_fields :salt

    object_label_method do
      :object_label
    end
  end

  def object_label
    name || id
  end

  private

  def encryptor
    ActiveSupport::MessageEncryptor.new(key)
  end

  def key
    password = Rails.application.secrets[:secret_key_base]
    length = ActiveSupport::MessageEncryptor.key_len
    create_salt_if_needed
    ActiveSupport::KeyGenerator.new(password).generate_key(salt, length)
  end

  def create_salt_if_needed
    return unless salt.nil?

    length = ActiveSupport::MessageEncryptor.key_len
    self.salt = SecureRandom.hex(length)
  end
end
