require "digest/md5"

class Encryptor
  def initialize
    puts "Whats the password"
    @pass = Digest::MD5.hexdigest(gets.to_s)
  end

  def cipher(rotation)
    characters = (' '..'z').to_a
    rotated_characters = (' '..'z').to_a.rotate(rotation)
    Hash[characters.zip(rotated_characters)]
  end

  def encrypt_letter(letter, rotation)
    cipher_for_rotation = cipher(rotation)
    cipher_for_rotation[letter]
  end

  def decrypt_letter(letter, rotation)
     cipher_for_rotation = cipher(-rotation)
     cipher_for_rotation[letter]
  end

  def encrypt(string, num1, num2, num3)
    a = [num1, num2, num3]
    rotation = a.cycle
    string.split("").collect{|letter| encrypt_letter(letter, rotation.next)}.join 
  end
  
  def decrypt(string, r1, r2, r3)
    a = [r1, r2, r3]
    rotation = a.cycle
    string.split("").collect{|letter| decrypt_letter(letter, rotation.next)}.join 
  end

  def encrypt_file(filename, r1, r2, r3)
    input = File.open(filename, "r")
    message_to_encrypt = input.read
    encrypted_message = encrypt(message_to_encrypt, rotation)
    output = File.open(filename.gsub("txt","encrypted"), "w")
    output.write(@pass + "\n")
    output.write(encrypted_message)
    output.close   
  end
  
  def decrypt_file(filename, r1, r2, r3)
    input = File.open(filename, "r")
    pass_check = input.readline.chomp
    if pass_check == @pass
      message_to_decrypt = input.read
      decrypted_message = decrypt(message_to_decrypt, rotation)
      output = File.open(filename.gsub("encrypted","decrypted"), "w")
      output.write(decrypted_message)
      output.close
    else puts
      "INVALID PASSWORD"
    end    
  end
  
  def supported_characters
    (' '..'z').to_a
  end

  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message)
    end
  end

  def real_time_encrypt(string, rotation)
    puts encrypt(string, rotation)
    end
    
  def real_time_decrypt(string, rotation)
    puts decrypt(string, rotation)
  end
  
end