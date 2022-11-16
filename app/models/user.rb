class User < ApplicationRecord
    validates :username, presence: true
    validates :password_digest, presence: true
    validates :password, length: {minimum: 6}, allow_nil: true
    attr_reader :password
    before_validation :ensure_session_token
    # spire

    def self.find_by_credentials(username, password)
        @user = User.find_by(username: username)
        if @user && @user.is_password?(password)
            return @user
        else
            return nil
        end
    end
    def password=(password)
        @password = password
        self.password_digest = BCrypt::Password.create(password)
        # debugger
    end
    def is_password?(password)
        output = BCrypt::Password.new(self.password_digest)
        output.is_password?(password)
    end
    def reset_session_token!
        self.session_token = generate_new_session_token
        self.save!
        self.session_token
    end
    def generate_new_session_token
        output = SecureRandom::urlsafe_base64
        while User.exists?(session_token: output)
            output = SecureRandom::urlsafe_base64
        end
        output
    end
    def ensure_session_token
        self.session_token ||= generate_new_session_token
    end
end
