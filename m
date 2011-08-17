Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:36180 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187Ab1HQJWE (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 17 Aug 2011 05:22:04 -0400
Message-ID: <4E4B89F4.3090201@cam.ac.uk>
Date: Wed, 17 Aug 2011 10:29:24 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"device-drivers-devel@blackfin.uclinux.org"
	<device-drivers-devel@blackfin.uclinux.org>
Subject: Re: [PATCH 5/6] staging:iio:adc:ad7150: use i2c_smbus commands +
 drop unused poweroff timeout control.
References: <1313570537-26971-1-git-send-email-jic23@cam.ac.uk> <1313570537-26971-6-git-send-email-jic23@cam.ac.uk> <4E4B8413.6070204@analog.com>
In-Reply-To: <4E4B8413.6070204@analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/17/11 10:04, Michael Hennerich wrote:
> On 08/17/2011 10:42 AM, Jonathan Cameron wrote:
>> Minimal changes to code layout as going to do chan spec conversion shortly.
>> Otherwise, there are numerous code sharing opportunities in here and abi
>> elements that are uterly non compliant.
>>
>> Signed-off-by: Jonathan Cameron<jic23@cam.ac.uk>
>> ---
>>   drivers/staging/iio/adc/ad7150.c |  279 +++++++++++++++++---------------------
>>   1 files changed, 122 insertions(+), 157 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
>> index 973fcea..2bea6fe 100644
>> --- a/drivers/staging/iio/adc/ad7150.c
>> +++ b/drivers/staging/iio/adc/ad7150.c
>> @@ -88,47 +88,6 @@ ad7150_conv_mode_table[AD7150_MAX_CONV_MODE] = {
>>   };
>>
>>   /*
>> - * ad7150 register access by I2C
>> - */
>> -
>> -static int ad7150_i2c_read(struct ad7150_chip_info *chip, u8 reg, u8 *data, int len)
>> -{
>> -       struct i2c_client *client = chip->client;
>> -       int ret = 0;
>> -
>> -       ret = i2c_master_send(client,&reg, 1);
>> -       if (ret<  0) {
>> -               dev_err(&client->dev, "I2C write error\n");
>> -               return ret;
>> -       }
>> -
>> -       ret = i2c_master_recv(client, data, len);
>> -       if (ret<  0) {
>> -               dev_err(&client->dev, "I2C read error\n");
>> -               return ret;
>> -       }
>> -
>> -       return ret;
>> -}
>> -
>> -static int ad7150_i2c_write(struct ad7150_chip_info *chip, u8 reg, u8 data)
>> -{
>> -       struct i2c_client *client = chip->client;
>> -       int ret = 0;
>> -
>> -       u8 tx[2] = {
>> -               reg,
>> -               data,
>> -       };
>> -
>> -       ret = i2c_master_send(client, tx, 2);
>> -       if (ret<  0)
>> -               dev_err(&client->dev, "I2C write error\n");
>> -
>> -       return ret;
>> -}
>> -
>> -/*
>>    * sysfs nodes
>>    */
>>
>> @@ -196,16 +155,23 @@ static ssize_t ad7150_store_conversion_mode(struct device *dev,
>>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>>          struct ad7150_chip_info *chip = iio_priv(dev_info);
>>          u8 cfg;
>> -       int i;
>> +       int i, ret;
>>
>> -       ad7150_i2c_read(chip, AD7150_CFG,&cfg, 1);
>> +       ret = i2c_smbus_read_byte_data(chip->client, AD7150_CFG);
>> +       if (ret<  0)
>> +               return ret;
>> +       cfg = ret;
>>
>>          for (i = 0; i<  AD7150_MAX_CONV_MODE; i++) {
>>                  if (strncmp(buf, ad7150_conv_mode_table[i].name,
>>                                  strlen(ad7150_conv_mode_table[i].name) - 1) == 0) {
>>                          chip->conversion_mode = ad7150_conv_mode_table[i].name;
>>                          cfg |= 0x18 | ad7150_conv_mode_table[i].reg_cfg;
>> -                       ad7150_i2c_write(chip, AD7150_CFG, cfg);
>> +                       ret = i2c_smbus_write_byte_data(chip->client,
>> +                                                       AD7150_CFG,
>> +                                                       cfg);
>> +                       if (ret<  0)
>> +                               return ret;
>>                          return len;
>>                  }
>>          }
>> @@ -234,10 +200,13 @@ static ssize_t ad7150_show_ch1_value(struct device *dev,
>>   {
>>          struct iio_dev *dev_info = dev_get_drvdata(dev);
>>          struct ad7150_chip_info *chip = iio_priv(dev_info);
>> -       u8 data[2];
>> +       int ret;
>> +
>> +       ret = i2c_smbus_read_word_data(chip->client, AD7150_CH1_DATA_HIGH);
> 
> Hi Jonathan,
> 
> Byte ordering issue here-
> 
> SMBus Read Word:  i2c_smbus_read_word_data()
> ============================================
> 
> This operation is very like Read Byte; again, data is read from a
> device, from a designated register that is specified through the Comm
> byte. But this time, the data is a complete word (16 bits).
> 
> S Addr Wr [A] Comm [A] S Addr Rd [A] [DataLow] A [DataHigh] NA
> 
> i2c_smbus_read_word_data() and i2c_smbus_write_word_data() assumes the
> Low byte first - however the AD7150 transmits and expects the High-byte first.
> 
> Therefore we need an unconditional swab16() for all smbus word transactions.
> 
> return sprintf(buf, "%d\n", swab16(ret));
> 
> 
> -Michael

Good catch. Thanks - will update through the series.

