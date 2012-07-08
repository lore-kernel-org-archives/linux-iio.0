Return-Path: <jic23@kernel.org>
Message-ID: <4FF95384.4040206@kernel.org>
Date: Sun, 08 Jul 2012 10:31:48 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Zhang, Sonic" <Sonic.Zhang@analog.com>
CC: Sascha Hauer <s.hauer@pengutronix.de>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH] stagin iio adt7410: use local platformdata if none is
 specified
References: <1341307673-7936-1-git-send-email-s.hauer@pengutronix.de> <DB904C5425BA6F4E8424B3B51A1414D17140805E7A@NWD2CMBX1.ad.analog.com>
In-Reply-To: <DB904C5425BA6F4E8424B3B51A1414D17140805E7A@NWD2CMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 07/03/2012 11:43 AM, Zhang, Sonic wrote:
> Acked-by: Sonic Zhang <sonic.zhang@analog.com>
> 
>> -----Original Message-----
>> From: Sascha Hauer [mailto:s.hauer@pengutronix.de]
>> Sent: Tuesday, July 03, 2012 5:28 PM
>> To: linux-iio@vger.kernel.org
>> Cc: Jonathan Cameron; Zhang, Sonic; Sascha Hauer
>> Subject: [PATCH] stagin iio adt7410: use local platformdata if none is specified
>>
>> The adt7410 expects information about an irq in platform_data.
>> The driver can work without an irq, so make platform_data optional
>> by specifying a dummy platform_data if the device has none.
>>
In theory irq 0 is a valid interrupt on some platforms.  Doubt it would
ever be used for this, but there is still a plausible issue around this
platform data.  Anyhow, this is definitely an improvement so merged.
>> Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
>> ---
>>
>> This should have been part of the other series for the adt7410 I just sent,
>> but I overlooked this patch.
>>
>> drivers/staging/iio/adc/adt7410.c |    4 ++++
>> 1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/staging/iio/adc/adt7410.c b/drivers/staging/iio/adc/adt7410.c
>> index 917b692..d7d9ad9 100644
>> --- a/drivers/staging/iio/adc/adt7410.c
>> +++ b/drivers/staging/iio/adc/adt7410.c
>> @@ -720,6 +720,7 @@ static int __devinit adt7410_probe(struct i2c_client *client,
>>       struct iio_dev *indio_dev;
>>       int ret = 0;
>>       unsigned long *adt7410_platform_data = client->dev.platform_data;
>> +      unsigned long local_pdata[] = {0, 0};
>>
>>       indio_dev = iio_device_alloc(sizeof(*chip));
>>       if (indio_dev == NULL) {
>> @@ -737,6 +738,9 @@ static int __devinit adt7410_probe(struct i2c_client *client,
>>       indio_dev->info = &adt7410_info;
>>       indio_dev->modes = INDIO_DIRECT_MODE;
>>
>> +      if (!adt7410_platform_data)
>> +              adt7410_platform_data = local_pdata;
>> +
>>       /* CT critcal temperature event. line 0 */
>>       if (client->irq) {
>>               ret = request_threaded_irq(client->irq,
>> --
>> 1.7.10
>>
> 
> 
