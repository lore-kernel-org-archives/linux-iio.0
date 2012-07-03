Return-Path: <jic23@kernel.org>
Message-ID: <4FF353C7.8040804@kernel.org>
Date: Tue, 03 Jul 2012 21:19:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 3/3] staging iio adt7410: make 16bit mode default
References: <1341307288-1926-1-git-send-email-s.hauer@pengutronix.de> <1341307288-1926-4-git-send-email-s.hauer@pengutronix.de> <DB904C5425BA6F4E8424B3B51A1414D17140805E78@NWD2CMBX1.ad.analog.com>
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D17140805E78@NWD2CMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/03/2012 11:42 AM, Zhang, Sonic wrote:
> Acked-by: Sonic Zhang <sonic.zhang@analog.com>
> 
>> -----Original Message-----
>> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>> Sent: Tuesday, July 03, 2012 5:21 PM
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Zhang, Sonic; Sascha Hauer
>> Subject: [PATCH 3/3] staging iio adt7410: make 16bit mode default
>>
>> In 13bit mode the lower three bits of the adc value contain
>> flags. The driver does not use these flags at all, so make 16bit
>> mode the default.
>>
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
merged (for next version rather than fixes as whilst a reasonable
change, it's not a fix).

Anyhow, please do note that the intent is to move this driver out
to hwmon. It's a long way from abi compliant for iio. I just mention
this to avoid you wasting time pulling it nearer to the abi (if
you were thinking of doing so of course!)
>> ---
>> drivers/staging/iio/adc/adt7410.c |   24 +++++++++++++-----------
>> 1 file changed, 13 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
>> index f9188e5..f8dd567 100644
>> --- a/drivers/staging/iio/adc/adt7410.c
>> +++ b/drivers/staging/iio/adc/adt7410.c
>> @@ -756,13 +756,15 @@ static int __devinit adt7410_probe(struct i2c_client
>> *client,
>>                       goto error_unreg_ct_irq;
>>       }
>>
>> -      if (client->irq && adt7410_platform_data[0]) {
>> +      ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip->config);
>> +      if (ret) {
>> +              ret = -EIO;
>> +              goto error_unreg_int_irq;
>> +      }
>>
>> -              ret = adt7410_i2c_read_byte(chip, ADT7410_CONFIG, &chip-
>>> config);
>> -              if (ret) {
>> -                      ret = -EIO;
>> -                      goto error_unreg_int_irq;
>> -              }
>> +      chip->config |= ADT7410_RESOLUTION;
>> +
>> +      if (client->irq && adt7410_platform_data[0]) {
>>
>>               /* set irq polarity low level */
>>               chip->config &= ~ADT7410_CT_POLARITY;
>> @@ -771,12 +773,12 @@ static int __devinit adt7410_probe(struct i2c_client
>> *client,
>>                       chip->config |= ADT7410_INT_POLARITY;
>>               else
>>                       chip->config &= ~ADT7410_INT_POLARITY;
>> +      }
>>
>> -              ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, chip-
>>> config);
>> -              if (ret) {
>> -                      ret = -EIO;
>> -                      goto error_unreg_int_irq;
>> -              }
>> +      ret = adt7410_i2c_write_byte(chip, ADT7410_CONFIG, chip->config);
>> +      if (ret) {
>> +              ret = -EIO;
>> +              goto error_unreg_int_irq;
>>       }
>>       ret = iio_device_register(indio_dev);
>>       if (ret)
>> --
>> 1.7.10
>>
> 
> 
