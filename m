Return-Path: <jic23@kernel.org>
Message-ID: <502AB2DF.3080301@kernel.org>
Date: Tue, 14 Aug 2012 21:19:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 drivers@analog.com
Subject: Re: [PATCH 07/22] staging:iio:ad7793: Remove unused platform_data
 from device state struct
References: <1344616596-8026-1-git-send-email-lars@metafoo.de> <1344616596-8026-7-git-send-email-lars@metafoo.de> <502AA96C.3090105@kernel.org>
In-Reply-To: <502AA96C.3090105@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 08/14/2012 08:39 PM, Jonathan Cameron wrote:
> On 08/10/2012 05:36 PM, Lars-Peter Clausen wrote:
>> The platform data for the device is only used from within the drivers probe
>> callback, so there is no need to keep it around in the devices state struct.
>>
>> While we are at it mark the platform data struct as const.
>>
There a couple of obvious bugs in this patch....

My plan with these is to first send a series to Greg with the
fixes in it (not including this which is merely a cleanup?)
Once that shows up in his trees I'll do a second pull request with
this + the sigma delta cleanups.
It is probably the cleanest approach and we aren't pressed for time
at the moment.  To show what will be in there I will push out
a new branch to kernel.org shortly togreg-postfixes.

Lars-Peter, please verify that my fixup of this is correct
(all I've done is build tested it).


>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> ---
>>  drivers/staging/iio/adc/ad7793.c |   14 ++++++--------
>>  1 file changed, 6 insertions(+), 8 deletions(-)
>>
>> diff --git a/drivers/staging/iio/adc/ad7793.c b/drivers/staging/iio/adc/ad7793.c
>> index 112e2b7..0ba598e 100644
>> --- a/drivers/staging/iio/adc/ad7793.c
>> +++ b/drivers/staging/iio/adc/ad7793.c
>> @@ -44,7 +44,6 @@ struct ad7793_state {
>>  	struct iio_trigger		*trig;
>>  	const struct ad7793_chip_info	*chip_info;
>>  	struct regulator		*reg;
>> -	struct ad7793_platform_data	*pdata;
>>  	wait_queue_head_t		wq_data_avail;
>>  	bool				done;
>>  	bool				irq_dis;
>> @@ -253,7 +252,8 @@ out:
>>  	return ret;
>>  }
>>  
>> -static int ad7793_setup(struct ad7793_state *st)
>> +static int ad7793_setup(struct ad7793_state *st
>> +	const struct ad7793_platform_data *pdata)
> Really odd.  There's a missing comma between the arguments here...
> I'll fixup.
>>  {
>>  	int i, ret = -1;
>>  	unsigned long long scale_uv;
>> @@ -277,9 +277,9 @@ static int ad7793_setup(struct ad7793_state *st)
>>  		goto out;
>>  	}
>>  
>> -	st->mode  = (st->pdata->mode & ~AD7793_MODE_SEL(-1)) |
>> +	st->mode  = (pdata->mode & ~AD7793_MODE_SEL(-1)) |
>>  			AD7793_MODE_SEL(AD7793_MODE_IDLE);
>> -	st->conf  = st->pdata->conf & ~AD7793_CONF_CHAN(-1);
>> +	st->conf  = pdata->conf & ~AD7793_CONF_CHAN(-1);
>>  
>>  	ret = ad7793_write_reg(st, AD7793_REG_MODE, sizeof(st->mode), st->mode);
>>  	if (ret)
>> @@ -882,7 +882,7 @@ static const struct ad7793_chip_info ad7793_chip_info_tbl[] = {
>>  
>>  static int __devinit ad7793_probe(struct spi_device *spi)
>>  {
>> -	struct ad7793_platform_data *pdata = spi->dev.platform_data;
>> +	const struct ad7793_platform_data *pdata = spi->dev.platform_data;
>>  	struct ad7793_state *st;
>>  	struct iio_dev *indio_dev;
>>  	int ret, voltage_uv = 0;
>> @@ -915,8 +915,6 @@ static int __devinit ad7793_probe(struct spi_device *spi)
>>  	st->chip_info =
>>  		&ad7793_chip_info_tbl[spi_get_device_id(spi)->driver_data];
>>  
>> -	st->pdata = pdata;
>> -
>>  	if (pdata && pdata->vref_mv)
>>  		st->int_vref_mv = pdata->vref_mv;
>>  	else if (voltage_uv)
>> @@ -944,7 +942,7 @@ static int __devinit ad7793_probe(struct spi_device *spi)
>>  	if (ret)
>>  		goto error_unreg_ring;
>>  
>> -	ret = ad7793_setup(st);
>> +	ret = ad7793_setup(st, pdata);
>>  	if (ret)
>>  		goto error_remove_trigger;
>>  
>>
