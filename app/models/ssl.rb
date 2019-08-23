class SSL
	@@public_key = OpenSSL::PKey::RSA.new(File.read(File.expand_path('../keys/ssl_keys/public.pem', __dir__)))
	@@private_key = OpenSSL::PKey::RSA.new(File.read(File.expand_path('../keys/ssl_keys/private.pem', __dir__)))
	
	def self.encrypt(plaintext)
		Base64.encode64( @@public_key.public_encrypt(plaintext) )
	end

	def self.decrypt(ciphertext)
		@@private_key.private_decrypt( Base64.decode64(ciphertext) )
	end
end
