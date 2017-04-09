Return-Path: <jic23@kernel.org>
Subject: Re: [PATCH] Fixed two style issues in ade7759.c file: * indentation
 for multi-line arguments in function declarations and calls * permissions
 converted to octal, instead of or-ed flags
To: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>,
 Nikola Jelic <nikola.jelic83@gmail.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
References: <20170330203924.8399-1-nikola.jelic83@gmail.com>
 <f62e33f1-45c5-f5a6-165e-a9ee135c5d52@jic23.retrosnub.co.uk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <86c75d65-09e0-70ac-177b-c2ddea4478da@kernel.org>
Date: Sun, 9 Apr 2017 10:59:50 +0100
MIME-Version: 1.0
In-Reply-To: <f62e33f1-45c5-f5a6-165e-a9ee135c5d52@jic23.retrosnub.co.uk>
Content-Type: text/plain; charset=windows-1252
List-ID: <linux-iio@vger.kernel.org>

On 02/04/17 14:40, Jonathan Cameron wrote:
> On 30/03/17 21:39, Nikola Jelic wrote:
>> Signed-off-by: Nikola Jelic <nikola.jelic83@gmail.com>
> This needs to also be sent to linux-iio@vger.kernel.org
> 	
> Please resend.
Not seen resend yet so I'll take a quick look at this as
it stands.

See inline as the resulting indenting is inconsistent.
If you are going to fix an issue like that please do it
throughout - including macros that take parameters.

Jonathan
> 
> Jonathan
>> ---
>>  drivers/staging/iio/meter/ade7759.c | 94 ++++++++++++++++++-------------------
>>  1 file changed, 47 insertions(+), 47 deletions(-)
>>
>> diff --git a/drivers/staging/iio/meter/ade7759.c b/drivers/staging/iio/meter/ade7759.c
>> index 0b65f1847510..f3c1d7c9de6a 100644
>> --- a/drivers/staging/iio/meter/ade7759.c
>> +++ b/drivers/staging/iio/meter/ade7759.c
>> @@ -72,8 +72,8 @@ struct ade7759_state {
>>  };
>>  
>>  static int ade7759_spi_write_reg_8(struct device *dev,
>> -		u8 reg_address,
>> -		u8 val)
>> +				   u8 reg_address,
>> +				   u8 val)
>>  {
>>  	int ret;
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> @@ -90,8 +90,8 @@ static int ade7759_spi_write_reg_8(struct device *dev,
>>  }
>>  
>>  static int ade7759_spi_write_reg_16(struct device *dev,
>> -		u8 reg_address,
>> -		u16 value)
>> +				    u8 reg_address,
>> +				    u16 value)
>>  {
>>  	int ret;
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>> @@ -108,8 +108,8 @@ static int ade7759_spi_write_reg_16(struct device *dev,
>>  }
>>  
>>  static int ade7759_spi_read_reg_8(struct device *dev,
>> -		u8 reg_address,
>> -		u8 *val)
>> +				  u8 reg_address,
>> +				  u8 *val)
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct ade7759_state *st = iio_priv(indio_dev);
>> @@ -118,7 +118,7 @@ static int ade7759_spi_read_reg_8(struct device *dev,
>>  	ret = spi_w8r8(st->us, ADE7759_READ_REG(reg_address));
>>  	if (ret < 0) {
>>  		dev_err(&st->us->dev, "problem when reading 8 bit register 0x%02X",
>> -				reg_address);
>> +			reg_address);
>>  		return ret;
>>  	}
>>  	*val = ret;
>> @@ -127,8 +127,8 @@ static int ade7759_spi_read_reg_8(struct device *dev,
>>  }
>>  
>>  static int ade7759_spi_read_reg_16(struct device *dev,
>> -		u8 reg_address,
>> -		u16 *val)
>> +				   u8 reg_address,
>> +				   u16 *val)
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct ade7759_state *st = iio_priv(indio_dev);
>> @@ -147,8 +147,8 @@ static int ade7759_spi_read_reg_16(struct device *dev,
>>  }
>>  
>>  static int ade7759_spi_read_reg_40(struct device *dev,
>> -		u8 reg_address,
>> -		u64 *val)
>> +				   u8 reg_address,
>> +				   u64 *val)
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct ade7759_state *st = iio_priv(indio_dev);
>> @@ -169,7 +169,7 @@ static int ade7759_spi_read_reg_40(struct device *dev,
>>  	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
>>  	if (ret) {
>>  		dev_err(&st->us->dev, "problem when reading 40 bit register 0x%02X",
>> -				reg_address);
>> +			reg_address);
>>  		goto error_ret;
>>  	}
>>  	*val = ((u64)st->rx[1] << 32) | (st->rx[2] << 24) |
>> @@ -181,8 +181,8 @@ static int ade7759_spi_read_reg_40(struct device *dev,
>>  }
>>  
>>  static ssize_t ade7759_read_8bit(struct device *dev,
>> -		struct device_attribute *attr,
>> -		char *buf)
>> +				 struct device_attribute *attr,
>> +				 char *buf)
>>  {
>>  	int ret;
>>  	u8 val = 0;
>> @@ -196,8 +196,8 @@ static ssize_t ade7759_read_8bit(struct device *dev,
>>  }
>>  
>>  static ssize_t ade7759_read_16bit(struct device *dev,
>> -		struct device_attribute *attr,
>> -		char *buf)
>> +				  struct device_attribute *attr,
>> +				  char *buf)
>>  {
>>  	int ret;
>>  	u16 val = 0;
>> @@ -211,8 +211,8 @@ static ssize_t ade7759_read_16bit(struct device *dev,
>>  }
>>  
>>  static ssize_t ade7759_read_40bit(struct device *dev,
>> -		struct device_attribute *attr,
>> -		char *buf)
>> +				  struct device_attribute *attr,
>> +				  char *buf)
>>  {
>>  	int ret;
>>  	u64 val = 0;
>> @@ -226,9 +226,9 @@ static ssize_t ade7759_read_40bit(struct device *dev,
>>  }
>>  
>>  static ssize_t ade7759_write_8bit(struct device *dev,
>> -		struct device_attribute *attr,
>> -		const char *buf,
>> -		size_t len)
>> +				  struct device_attribute *attr,
>> +				  const char *buf,
>> +				  size_t len)
>>  {
>>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>  	int ret;
>> @@ -244,9 +244,9 @@ static ssize_t ade7759_write_8bit(struct device *dev,
>>  }
>>  
>>  static ssize_t ade7759_write_16bit(struct device *dev,
>> -		struct device_attribute *attr,
>> -		const char *buf,
>> -		size_t len)
>> +				   struct device_attribute *attr,
>> +				   const char *buf,
>> +				   size_t len)
>>  {
>>  	struct iio_dev_attr *this_attr = to_iio_dev_attr(attr);
>>  	int ret;
>> @@ -267,8 +267,8 @@ static int ade7759_reset(struct device *dev)
>>  	u16 val;
>>  
>>  	ret = ade7759_spi_read_reg_16(dev,
>> -			ADE7759_MODE,
>> -			&val);
>> +				      ADE7759_MODE,
>> +				      &val);
>>  	if (ret < 0)
>>  		return ret;
>>  
>> @@ -279,49 +279,49 @@ static int ade7759_reset(struct device *dev)
>>  }
>>  
>>  static IIO_DEV_ATTR_AENERGY(ade7759_read_40bit, ADE7759_AENERGY);
>> -static IIO_DEV_ATTR_CFDEN(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_CFDEN(0644,
>>  		ade7759_read_16bit,
>>  		ade7759_write_16bit,
>>  		ADE7759_CFDEN);
>> -static IIO_DEV_ATTR_CFNUM(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_CFNUM(0644,
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_CFNUM);
>>  static IIO_DEV_ATTR_CHKSUM(ade7759_read_8bit, ADE7759_CHKSUM);
>> -static IIO_DEV_ATTR_PHCAL(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_PHCAL(0644,
>>  		ade7759_read_16bit,
>>  		ade7759_write_16bit,
>>  		ADE7759_PHCAL);
>> -static IIO_DEV_ATTR_APOS(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_APOS(0644,
>>  		ade7759_read_16bit,
>>  		ade7759_write_16bit,
>>  		ADE7759_APOS);
>> -static IIO_DEV_ATTR_SAGCYC(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_SAGCYC(0644,
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_SAGCYC);
>> -static IIO_DEV_ATTR_SAGLVL(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_SAGLVL(0644,
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_SAGLVL);
>> -static IIO_DEV_ATTR_LINECYC(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_LINECYC(0644,
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_LINECYC);
>>  static IIO_DEV_ATTR_LENERGY(ade7759_read_40bit, ADE7759_LENERGY);
>> -static IIO_DEV_ATTR_PGA_GAIN(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_PGA_GAIN(0644,
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_GAIN);
>> -static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_ACTIVE_POWER_GAIN(0644,
>>  		ade7759_read_16bit,
>>  		ade7759_write_16bit,
>>  		ADE7759_APGAIN);
>> -static IIO_DEV_ATTR_CH_OFF(1, S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_CH_OFF(1, 0644,
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_CH1OS);
>> -static IIO_DEV_ATTR_CH_OFF(2, S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_CH_OFF(2, 0644,
Why not fix intending on these as well?
>>  		ade7759_read_8bit,
>>  		ade7759_write_8bit,
>>  		ADE7759_CH2OS);
>> @@ -355,8 +355,8 @@ static int ade7759_stop_device(struct device *dev)
>>  	u16 val;
>>  
>>  	ret = ade7759_spi_read_reg_16(dev,
>> -			ADE7759_MODE,
>> -			&val);
>> +				      ADE7759_MODE,
>> +				      &val);
>>  	if (ret < 0) {
>>  		dev_err(dev, "unable to power down the device, error: %d\n",
>>  			ret);
>> @@ -393,16 +393,16 @@ static int ade7759_initial_setup(struct iio_dev *indio_dev)
>>  }
>>  
>>  static ssize_t ade7759_read_frequency(struct device *dev,
>> -		struct device_attribute *attr,
>> -		char *buf)
>> +				      struct device_attribute *attr,
>> +				      char *buf)
>>  {
>>  	int ret;
>>  	u16 t;
>>  	int sps;
>>  
>>  	ret = ade7759_spi_read_reg_16(dev,
>> -			ADE7759_MODE,
>> -			&t);
>> +				      ADE7759_MODE,
>> +				      &t);
>>  	if (ret)
>>  		return ret;
>>  
>> @@ -413,9 +413,9 @@ static ssize_t ade7759_read_frequency(struct device *dev,
>>  }
>>  
>>  static ssize_t ade7759_write_frequency(struct device *dev,
>> -		struct device_attribute *attr,
>> -		const char *buf,
>> -		size_t len)
>> +				       struct device_attribute *attr,
>> +				       const char *buf,
>> +				       size_t len)
>>  {
>>  	struct iio_dev *indio_dev = dev_to_iio_dev(dev);
>>  	struct ade7759_state *st = iio_priv(indio_dev);
>> @@ -458,7 +458,7 @@ static IIO_DEV_ATTR_TEMP_RAW(ade7759_read_8bit);
>>  static IIO_CONST_ATTR(in_temp_offset, "70 C");
>>  static IIO_CONST_ATTR(in_temp_scale, "1 C");
>>  
>> -static IIO_DEV_ATTR_SAMP_FREQ(S_IWUSR | S_IRUGO,
>> +static IIO_DEV_ATTR_SAMP_FREQ(0644,
>>  		ade7759_read_frequency,
>>  		ade7759_write_frequency);
>>  
>>
> 
