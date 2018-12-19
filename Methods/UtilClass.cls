public class UtilClass {
    
    public static String EncriptaData(String data){
        
        Blob chave = Blob.valueOf('aAk!h@37WQ9bsAfk');
        string encodedCipherText = EncodingUtil.base64Encode(Crypto.encryptWithManagedIV('AES128', chave, Blob.valueOf(data)));
        string encodedData = encodingUtil.URLEncode(encodedCipherText,'UTF-8');
        
        return encodedData;
        
    }
    
    public static String DecriptaData(String data){
        
        Blob chave = Blob.valueOf('aAk!h@37WQ9bsAfk');
        Blob blobData = EncodingUtil.base64Decode(data);    
        Blob decryptedBlob = Crypto.decryptWithManagedIV('AES128', chave, blobData);    
        string decodedData = decryptedBlob.toString();
        return decodedData;
    }
    
    
}