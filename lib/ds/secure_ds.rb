#!/usr/bin/env ruby
require "openssl"
require 'digest/sha2'
require 'base64'

# We use the AES 256 bit cipher-block chaining symetric encryption
alg = "AES-256-CBC"

# We want a 256 bit key symetric key based on some passphrase
digest = Digest::SHA256.new
digest.update("fouad is cool symetric key")
key = digest.digest
# We could also have just created a random key
# key = OpenSSL::Cipher::Cipher.new(alg).random_key

# For security as part of the encryption algorithm, we create a random
# initialization vector.
iv = OpenSSL::Cipher::Cipher.new(alg).random_iv
#iv = OpenSSL::Cipher::Cipher.new(alg).key = "dfsdfasfsafasfaffouad"
#p OpenSSL::Cipher::Cipher.new(alg).methods

# Example, we debug output our key in various formats
puts "Our key: #{key}"

# Base64 the key
key64 = [key].pack('m')
puts "Our key base 64: #{key64}"

# Base64 decode the key
raise 'Key Error' if(key.nil? or key.size != 32)
puts "Our key retrieved from base64: #{key64.unpack('m')[0]}"

# Now we do the actual setup of the cipher
aes = OpenSSL::Cipher::Cipher.new(alg)
aes.encrypt
aes.key = key
aes.iv = iv

=begin
# Now we go ahead and encrypt our plain text.
cipher = aes.update("This is line 1\n")
cipher << aes.update("This is some other string without linebreak.")
cipher << aes.update("This follows immediately after period.")
cipher << aes.update("Same with this final sentence")
cipher << aes.final
=end
class Env
  def initialize(str)
    @str = str
  end
  def say_hello
    @str
  end
end

#o = Env.new("hello\n")
#data = Marshal.dump(o)
#obj = Marshal.load(data)
#obj.say_hello  #=> "hello\n"

o = Env.new("hello\n")
#cipher = Marshal.dump(Env.new("hello"))
#cipher = Marshal.dump(o)
cipher = "fouad" 

puts "Our Encrypted data in base64"
cipher64 = [cipher].pack('m')
puts cipher64

decode_cipher = OpenSSL::Cipher::Cipher.new(alg)
decode_cipher.decrypt
decode_cipher.key = key
decode_cipher.iv = iv
plain = decode_cipher.update(cipher64.unpack('m')[0])
p plain
#p decode_cipher.final
#plain << decode_cipher.final
#puts "Decrypted Text"
#puts plain
#p plain
obj = Marshal.load(plain)
p obj.say_hello  #=> "hello\n"


=begin
'
# aes encode a file into another file.
File.open("foo.enc","w") do |enc|
   File.open("foo") do |f|
     loop do
       r = f.read(4096)
       break unless r
       cipher = aes.update(r)
       enc << cipher
     end
   end

   enc << aes.final
end
'
=end
