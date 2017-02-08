class Encryptor

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

  
  def encrypt(string, rotation)
    string.split("").collect{|letter| encrypt_letter(letter, rotation)}.join 
  end
  
  def decrypt(string, rotation)
    string.split("").collect{|letter| decrypt_letter(letter, rotation)}.join 
  end

  def encrypt_file(filename, rotation)
    input = File.open(filename, "r")
    message_to_encrypt = input.read
    encrypted_message = encrypt(message_to_encrypt, rotation)
    output = File.open(filename.gsub("txt","encrypted"), "w")
    output.write(encrypted_message)
    output.close
    
  end
  
  def decrypt_file(filename, rotation)
    input = File.open(filename, "r")
    message_to_decrypt = input.read
    decrypted_message = decrypt(message_to_decrypt, rotation)
    output.write(decrypted_message)
    output.close
    
  end
  
  def supported_characters
    (' '..'z').to_a
  end

  
  def crack(message)
    supported_characters.count.times.collect do |attempt|
      decrypt(message, attempt)
    end
    
  end
    
end