class EncryptDecrypt

  require 'base64'
  require 'digest'
  require 'openssl'

  def decipher_password(password)
    cryptkey = Digest::SHA256.digest('Nixnogen')
    cryptoKey = "P7x\x88\xAE|\xC4\x11;c\xC0\x81\xEF\x17\xF0&\xB1\xE5\x92U\xAC\x8By\xB9\x03i\x83\x8B\xF4\x86\x88\x9E" ;
    iv       = 'a2xhcgAAAAAAAAAA'
    buf      = password # 32 chars
    # enc      = encrypt(cryptkey, iv, buf)
    dec      = decrypt(cryptkey, iv, password)
  end

  def decrypt(key, iv, data)
    cipher(:decrypt, key, iv, data)
  end

  def encrypt(key, iv, data)
    cipher(:encrypt, key, iv, data)
  end

  def cipher(mode, key, iv, data)
    cipher1 = OpenSSL::Cipher.new('AES-256-CBC').send(mode)
    cipher1.key = key
    cipher1.iv  = iv

    encrypted = ''
    puts('encryp first', cipher1.inspect)
    encrypted << cipher1.update(data)
    puts('encryp', encrypted.inspect, cipher1.inspect, cipher1.methods.inspect)
    encrypted << cipher1.final
    puts('encryp last', encrypted.inspect, cipher1.inspect)
    encrypted
  end

end