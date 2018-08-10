## bytes in Python
> In Python, a byte string is represented by a b, followed by the byte string's ASCII representation.

[why use base64 encoding?](https://www.zhihu.com/question/36306744)
- 总体来说就是为了更安全地将所传数据中非ascii码传输

[reference link](https://code.tutsplus.com/tutorials/base64-encoding-and-decoding-using-python--cms-25588)

- base64 why padding?
  1. 标准base64只有64个字符（英文大小写、数字和+、/）以及用作后缀等号；
  2. base64是把3个字节变成4个可打印字符，所以base64编码后的字符串一定能被4整除（不算用作后缀的等号）；
  3. 等号一定用作后缀，且数目一定是0个、1个或2个。这是因为如果原文长度不能被3整除，base64要在后面添加\0凑齐3n位。为了正确还原，添加了几个\0就加上几个等号。显然添加等号的数目只能是0、1或2；


## What is Base64

> Base64 is a way in which 8-bit binary data is encoded into a format that can be represented in 7 bits. This is done using only the characters A-Z, a-z, 0-9, +, and / in order to represent data, with = used to pad data. For instance, using this encoding, three 8-bit bytes are converted into four 7-bit bytes.

## Base64 Encoding

> Base64 encoding is the process of converting binary data into a limited character set of 64 characters. namely `A-Z`, `a-z`, `0-9`, `+` and `/`

encoding workflow
1. The text to be encoded in converted into its respective decimal values
2. The decimal values obtained in the above step are converted into their binary equivalents
3. All the binary equivalents are concatenated, obtaining a large set of binary numbers.
4. The large set of binary numbers is divided into equal sections, with each section containing only 6 bits.
5. The equal sets of 6 bits are converted into their decimal equivalents
6. Finally, the decimal equivalents are converted into their Base64 values 