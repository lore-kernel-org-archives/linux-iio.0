Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:37383 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752931Ab1JJIlo (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 10 Oct 2011 04:41:44 -0400
Message-ID: <4E92AFC6.4060108@cam.ac.uk>
Date: Mon, 10 Oct 2011 09:41:42 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org
Subject: Re: [PATCH] staging:iio:dac Add AD5064 driver
References: <1317985694-12670-1-git-send-email-lars@metafoo.de> <4E8EEF99.2080502@cam.ac.uk> <4E8F507A.9040905@metafoo.de>
In-Reply-To: <4E8F507A.9040905@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/07/11 20:18, Lars-Peter Clausen wrote:
> On 10/07/2011 02:24 PM, Jonathan Cameron wrote:
>> On 10/07/11 12:08, Lars-Peter Clausen wrote:
>>> This patch adds support for the Analog Devices AD6064, AD6064-1, AD6044, AD6024
>>> quad channel digital-to-analog converter devices.
>>>
>>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> 
> Hi
> 
>>
>> Hi Lars-Peter,
>>
>> This is looking very nice.  A couple of little suggestions:
>>
>> 1) Use bulk regulator apis to get rid of some boilerplate.
> 
> I wanted to use the bulk regulator API at first but decided against it, so we
> can support the case where only some, but not all, of the channels are used and
> some channels don't have a supply for their vref.
That would be fair enough if you were actually supporting the ability to do that
in the driver.  You aren't, so please use the bulk apis.
If this is added later, then that is the time to hand roll a custom version of this.

Also, I'm not sure that this would be the right way to go about it anyway.
You might be better to treat each channel as a separate device.  That way each
can register or fail on it's own and also things like runtime pm can work at
a finer grained level.  So you'd have 4 separate iio devices on a shared bus
(maybe as a mfd - multi function device).
> 
>>
>> 2) No readback of current output values?  Seems that this
>> is useful if nothing else to provide sanity check that the
>> values are valid and have stuck. Or to let a userapp check
>> the current status on load.
> 
> The chip itself doesn't support readback, so the only thing I could do is cache
> the output values.
Technically we don't require readback so up to you.  Just seemed a little odd!
> 
>>
>> One big one though.  It doesn't build :(
>>
>> you have a sizeof(data) in the write rather than I think sizeof(st->data)
>>
> 
> Oh, sorry. I had actually fixed this locally, looks like I missed to regenerate
> the patch.
Happens to us all from time to time ;)
>> Anyhow, about incorporating something like: (I haven't used the bulk regulator
>> apis before so wasn't entirely sure how neat it would be. Having found out
>>  I might as well email you the result!)
>>
>> Clearly you could do the keep a copy of voltage_uv as you did before if you
>> prefer and it is probably slightly neater than carrying the number of reference
>> voltages around.  No guarantee the following actually works ;)
>>
>> [PATCH] staging:iio:dac:ad5064 use bulk regulator apis.
>>
>> ---
>>  drivers/staging/iio/dac/ad5064.c |  107 ++++++++++++-------------------------
>>  1 files changed, 35 insertions(+), 72 deletions(-)
>>
>> diff --git a/drivers/staging/iio/dac/ad5064.c b/drivers/staging/iio/dac/ad5064.c
>> index 6ee00ea..a60bbbe 100644
>> --- a/drivers/staging/iio/dac/ad5064.c
>> +++ b/drivers/staging/iio/dac/ad5064.c
>> @@ -45,10 +45,12 @@
>>  /**
>>   * struct ad5064_chip_info - chip specific information
>>   * @channel: channel specification
>> + * @num_refs: number of reference voltages
>>  */
>>  
>>  struct ad5064_chip_info {
>>  	struct iio_chan_spec channel[AD5064_DAC_CHANNELS];
>> +	int num_refs;
>>  };
>>  
>>  /**
>> @@ -65,7 +67,7 @@ struct ad5064_chip_info {
>>  struct ad5064_state {
>>  	struct spi_device		*spi;
>>  	const struct ad5064_chip_info	*chip_info;
>> -	struct regulator		*reg[AD5064_DAC_CHANNELS];
>> +	struct regulator_bulk_data	reg[AD5064_DAC_CHANNELS];
>>  	unsigned int			vref_uv[AD5064_DAC_CHANNELS];
>>  	bool				pwr_down[AD5064_DAC_CHANNELS];
>>  	u8				pwr_down_mode[AD5064_DAC_CHANNELS];
>> @@ -100,24 +102,28 @@ static const struct ad5064_chip_info ad5064_chip_info_tbl[] = {
>>  		.channel[1] = AD5064_CHANNEL(1, 12),
>>  		.channel[2] = AD5064_CHANNEL(2, 12),
>>  		.channel[3] = AD5064_CHANNEL(3, 12),
>> +		.num_refs = 4,
>>  	},
>>  	[ID_AD5044] = {
>>  		.channel[0] = AD5064_CHANNEL(0, 14),
>>  		.channel[1] = AD5064_CHANNEL(1, 14),
>>  		.channel[2] = AD5064_CHANNEL(2, 14),
>>  		.channel[3] = AD5064_CHANNEL(3, 14),
>> +		.num_refs = 4,
>>  	},
>>  	[ID_AD5064] = {
>>  		.channel[0] = AD5064_CHANNEL(0, 16),
>>  		.channel[1] = AD5064_CHANNEL(1, 16),
>>  		.channel[2] = AD5064_CHANNEL(2, 16),
>>  		.channel[3] = AD5064_CHANNEL(3, 16),
>> +		.num_refs = 4,
>>  	},
>>  	[ID_AD5064_1] = {
>>  		.channel[0] = AD5064_CHANNEL(0, 16),
>>  		.channel[1] = AD5064_CHANNEL(1, 16),
>>  		.channel[2] = AD5064_CHANNEL(2, 16),
>>  		.channel[3] = AD5064_CHANNEL(3, 16),
>> +		.num_refs = 1,
>>  	},
>>  };
>>  
>> @@ -128,7 +134,7 @@ static int ad5064_spi_write(struct ad5064_state *st, unsigned int cmd,
>>  
>>  	st->data = cpu_to_be32(AD5064_CMD(cmd) | AD5064_ADDR(addr) | val);
>>  
>> -	return spi_write(st->spi, &st->data, sizeof(data));
>> +	return spi_write(st->spi, &st->data, sizeof(st->data));
>>  }
>>  
>>  static int ad5064_sync_powerdown_mode(struct ad5064_state *st,
>> @@ -270,10 +276,12 @@ static int ad5064_read_raw(struct iio_dev *indio_dev,
>>  {
>>  	struct ad5064_state *st = iio_priv(indio_dev);
>>  	unsigned long scale_uv;
>> -
>> +	int regulator_num;
>>  	switch (m) {
>>  	case (1 << IIO_CHAN_INFO_SCALE_SEPARATE):
>> -		scale_uv = (st->vref_uv[chan->channel] * 100);
>> +		regulator_num =
>> +			st->chip_info->num_refs == 1 ? 0 : chan->channel;
>> +		scale_uv = (st->vref_uv[regulator_num] * 100);
>>  		scale_uv >>= (chan->scan_type.realbits);
>>  		*val =  scale_uv / 100000;
>>  		*val2 = (scale_uv % 100000) * 10;
>> @@ -324,29 +332,6 @@ static inline unsigned int ad5064_num_vref(enum ad5064_type type)
>>  	}
>>  }
>>  
>> -static int ad5064_request_shared_vref(struct device *dev,
>> -	struct ad5064_state *st)
>> -{
>> -	unsigned int i;
>> -	int voltage_uv;
>> -	int ret;
>> -
>> -	st->reg[0] = regulator_get(dev, "vref");
>> -	if (!IS_ERR(st->reg[0])) {
>> -		ret = regulator_enable(st->reg[0]);
>> -		if (ret)
>> -			return ret;
>> -
>> -		voltage_uv = regulator_get_voltage(st->reg[0]);
>> -		for (i = 0; i < AD5064_DAC_CHANNELS; ++i)
>> -			st->vref_uv[i] = voltage_uv;
>> -	} else {
>> -		dev_warn(dev, "Unkown reference voltage\n");
>> -	}
>> -
>> -	return 0;
>> -}
>> -
>>  static const char * const ad5064_vref_names[] = {
>>  	"vrefA",
>>  	"vrefB",
>> @@ -354,31 +339,7 @@ static const char * const ad5064_vref_names[] = {
>>  	"vrefD",
>>  };
>>  
>> -static int ad5064_request_separate_vref(struct device *dev,
>> -	struct ad5064_state *st)
>> -{
>> -	unsigned int i;
>> -	int voltage_uv;
>> -	int ret;
>> -
>> -	for (i = 0; i < AD5064_DAC_CHANNELS; ++i)
>> -		st->reg[i] = regulator_get(dev, ad5064_vref_names[i]);
>> -
>> -	for (i = 0; i < AD5064_DAC_CHANNELS; ++i) {
>> -		if (!IS_ERR(st->reg[i])) {
>> -			ret = regulator_enable(st->reg[i]);
>> -			if (ret)
>> -				return ret;
>> -
>> -			voltage_uv = regulator_get_voltage(st->reg[i]);
>> -			st->vref_uv[i] = voltage_uv;
>> -		} else {
>> -			dev_warn(dev, "Unkown reference voltage for channel %d\n", i);
>> -		}
>> -	}
>> -
>> -	return 0;
>> -}
>> +static const char * const ad5064_1_vref_name = "vref";
>>  
>>  static int __devinit ad5064_probe(struct spi_device *spi)
>>  {
>> @@ -386,23 +347,35 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>>  	struct iio_dev *indio_dev;
>>  	struct ad5064_state *st;
>>  	unsigned int i;
>> -	int ret;
>> +	int ret, voltage_uv;
>>  
>>  	indio_dev = iio_allocate_device(sizeof(*st));
>>  	if (indio_dev == NULL)
>>  		return  -ENOMEM;
>>  
>>  	st = iio_priv(indio_dev);
>> +	st->chip_info = &ad5064_chip_info_tbl[type];
>>  	spi_set_drvdata(spi, indio_dev);
>>  
>>  	if (type == ID_AD5064_1)
>> -		ret = ad5064_request_shared_vref(&spi->dev, st);
>> +		st->reg[0].supply = ad5064_1_vref_name;
>>  	else
>> -		ret = ad5064_request_separate_vref(&spi->dev, st);
>> +		for (i = 0; i < st->chip_info->num_refs; ++i)
>> +			st->reg[0].supply = ad5064_vref_names[i];
>> +
>> +	ret = regulator_bulk_get(&spi->dev,
>> +				 st->chip_info->num_refs,
>> +				 st->reg);
>>  	if (ret)
>> -		goto error_put_reg;
>> +		goto error_free_dev;
>>  
>> -	st->chip_info = &ad5064_chip_info_tbl[type];
>> +	ret = regulator_bulk_enable(st->chip_info->num_refs, st->reg);
>> +	if (ret)
>> +		goto error_put_reg;
>> +	for (i = 0; i < st->chip_info->num_refs; ++i) {
>> +		voltage_uv = regulator_get_voltage(st->reg[i].consumer);
>> +		st->vref_uv[i] = voltage_uv;
>> +	}
>>  
>>  	st->spi = spi;
>>  	for (i = 0; i < AD5064_DAC_CHANNELS; ++i)
>> @@ -422,16 +395,10 @@ static int __devinit ad5064_probe(struct spi_device *spi)
>>  	return 0;
>>  
>>  error_disable_reg:
>> -	for (i = 0; i < ad5064_num_vref(type); ++i) {
>> -		if (!IS_ERR(st->reg[i]))
>> -			regulator_disable(st->reg[i]);
>> -	}
>> +	regulator_bulk_disable(st->chip_info->num_refs, st->reg);
>>  error_put_reg:
>> -	for (i = 0; i < ad5064_num_vref(type); ++i) {
>> -		if (!IS_ERR(st->reg[i]))
>> -			regulator_put(st->reg[i]);
>> -	}
>> -
>> +	regulator_bulk_free(st->chip_info->num_refs, st->reg);
>> +error_free_dev:
>>  	iio_free_device(indio_dev);
>>  
>>  	return ret;
>> @@ -440,15 +407,11 @@ error_put_reg:
>>  
>>  static int __devexit ad5064_remove(struct spi_device *spi)
>>  {
>> -	enum ad5064_type type = spi_get_device_id(spi)->driver_data;
>>  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
>>  	struct ad5064_state *st = iio_priv(indio_dev);
>> -	unsigned int i;
>>  
>> -	for (i = 0; i < ad5064_num_vref(type); ++i) {
>> -		regulator_disable(st->reg[i]);
>> -		regulator_put(st->reg[i]);
>> -	}
>> +	regulator_bulk_disable(st->chip_info->num_refs, st->reg);
>> +	regulator_bulk_free(st->chip_info->num_refs, st->reg);
>>  
>>  	iio_device_unregister(indio_dev);
>>  
> 
> 

