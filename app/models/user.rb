class User < ApplicationRecord
    has_secure_password
    has_many :goals, dependent: :destroy
    has_many :completions, dependent: :destroy

    before_validation :set_username, :capitalize_name, :remove_whitespace
    validates_presence_of :first_name, :last_name, :email, :username

    VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
    validates :email, uniqueness: true, format: VALID_EMAIL_REGEX
    validates :username, uniqueness: true

    private

    def set_username
        self.username = self.email unless self.username?
    end

    def capitalize_name
        self.first_name = self.first_name.capitalize
        self.last_name = self.last_name.capitalize
    end

    def remove_whitespace
        self.first_name = self.first_name.strip
        self.last_name = self.last_name.strip
        self.email = self.email.strip
        self.username = self.username.strip
    end
end
