class User < ApplicationRecord
    validates :email ,:session_token, uniqueness:true,presence:true
    validates :password_digest  ,presence:true
    validates :password ,length: {minimum: 6}, allow_nil:true
     before_validation:ensure_session_token
     attr_reader :password
    def password=(password)
        @password=password
        self.password_digest=BCrypt::Password.create(password)
    end
    def is_password?(password)
    password_object=BCrypt::Password.new(password_digest)
    password_object.is_password?(password)
    end

    def generate_unique_session_token
        SecureRandom::urlsafe_base64(16)
    end

    def reset_session_token!
        self.session_token=self.generate_unique_session_token
           self.save! 
           self.session_token
    end

    def ensure_session_token
        self.session_token ||= generate_unique_session_token
    end

    def self.find_by_credentials(email, password)
        user=User.find_by(email: email)
        if user && user.is_password?(password)
            user 
        else
            nil 
        end
    end
end
