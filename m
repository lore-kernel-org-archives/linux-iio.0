Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45196 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752260AbcAXPH1 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 24 Jan 2016 10:07:27 -0500
Subject: Re: [PATCH v2 3/3] iio: light: opt3001: enable operation w/o IRQ
To: Martin Kepplinger <martink@posteo.de>,
	Alexander Koch <mail@alexanderkoch.net>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-4-git-send-email-mail@alexanderkoch.net>
 <569D1BDD.1050804@posteo.de>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	mhornung.linux@gmail.com, dannenberg@ti.com, balbi@ti.com,
	fengguang.wu@intel.com, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56A4E8AA.10402@kernel.org>
Date: Sun, 24 Jan 2016 15:07:22 +0000
MIME-Version: 1.0
In-Reply-To: <569D1BDD.1050804@posteo.de>
Content-Type: text/plain; charset=iso-8859-15
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/01/16 17:07, Martin Kepplinger wrote:
> Am 2016-01-16 um 17:14 schrieb Alexander Koch:
>> Enable operation of the TI OPT3001 light sensor without having an
>> interrupt line available to connect the INT pin to.
>>
>> In this operation mode, we issue a conversion request and simply wait
>> for the conversion time available as timeout value, determined from
>> integration time configuration and the worst-case time given in the data
>> sheet (sect. 6.5, table on p. 5):
>>
>>   short integration time (100ms): 110ms + 3ms = 113ms
>>    long integration time (800ms): 880ms + 3ms = 883ms
>>
>> This change is transparent as behaviour defaults to using the interrupt
>> method if an interrupt no. is configured via device tree. Interrupt-less
>> operation mode is performed when no valid interrupt no. is given.
>>
>> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
>> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>
>> ---
>>  drivers/iio/light/opt3001.c | 137 ++++++++++++++++++++++++++++++--------------
>>  1 file changed, 95 insertions(+), 42 deletions(-)
>>
> 
> Looks ok to me, although I didn't verify anything. Not very important
> suggestions for changes inline:
Having actually read this closer now than I had when sending previous email
(all of 2 mins ago)...

1) The change to having a single define for the name would be a worthwhile
   one but is orthogonal to this patch set so should be done separately anyway.
2) The dev_info/dev_dbg is so trivial a change I doubt I can mess it up so
   will do that myself whilst applying.

Whilst we are here, the parameter indenting in this driver does really match
with consensus on indenting for parameters, so if anyone is doing a tidy up
file, through checkpatch.pl --strict at it and clean those up as well!

Jonathan
> 
>> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
>> index b05c484..2a2340d 100644
>> --- a/drivers/iio/light/opt3001.c
>> +++ b/drivers/iio/light/opt3001.c
>> @@ -70,9 +70,12 @@
>>  
>>  /*
>>   * Time to wait for conversion result to be ready. The device datasheet
>> - * worst-case max value is 880ms. Add some slack to be on the safe side.
>> + * sect. 6.5 states results are ready after total integration time plus 3ms.
>> + * This results in worst-case max values of 113ms or 883ms, respectively.
>> + * Add some slack to be on the safe side.
>>   */
>> -#define OPT3001_RESULT_READY_TIMEOUT	msecs_to_jiffies(1000)
>> +#define OPT3001_RESULT_READY_SHORT	150
>> +#define OPT3001_RESULT_READY_LONG	1000
>>  
>>  struct opt3001 {
>>  	struct i2c_client	*client;
>> @@ -92,6 +95,8 @@ struct opt3001 {
>>  
>>  	u8			high_thresh_exp;
>>  	u8			low_thresh_exp;
>> +
>> +	bool			use_irq;
>>  };
>>  
>>  struct opt3001_scale {
>> @@ -230,26 +235,30 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
>>  	u16 reg;
>>  	u8 exponent;
>>  	u16 value;
>> +	long timeout;
>>  
>> -	/*
>> -	 * Enable the end-of-conversion interrupt mechanism. Note that doing
>> -	 * so will overwrite the low-level limit value however we will restore
>> -	 * this value later on.
>> -	 */
>> -	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_LOW_LIMIT,
>> -			OPT3001_LOW_LIMIT_EOC_ENABLE);
>> -	if (ret < 0) {
>> -		dev_err(opt->dev, "failed to write register %02x\n",
>> -				OPT3001_LOW_LIMIT);
>> -		return ret;
>> +	if (opt->use_irq) {
>> +		/*
>> +		 * Enable the end-of-conversion interrupt mechanism. Note that
>> +		 * doing so will overwrite the low-level limit value however we
>> +		 * will restore this value later on.
>> +		 */
>> +		ret = i2c_smbus_write_word_swapped(opt->client,
>> +					OPT3001_LOW_LIMIT,
>> +					OPT3001_LOW_LIMIT_EOC_ENABLE);
>> +		if (ret < 0) {
>> +			dev_err(opt->dev, "failed to write register %02x\n",
>> +					OPT3001_LOW_LIMIT);
>> +			return ret;
>> +		}
>> +
>> +		/* Allow IRQ to access the device despite lock being set */
>> +		opt->ok_to_ignore_lock = true;
>>  	}
>>  
>> -	/* Reset data-ready indicator flag (will be set in the IRQ routine) */
>> +	/* Reset data-ready indicator flag */
>>  	opt->result_ready = false;
>>  
>> -	/* Allow IRQ to access the device despite lock being set */
>> -	opt->ok_to_ignore_lock = true;
>> -
>>  	/* Configure for single-conversion mode and start a new conversion */
>>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
>>  	if (ret < 0) {
>> @@ -269,32 +278,69 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
>>  		goto err;
>>  	}
>>  
>> -	/* Wait for the IRQ to indicate the conversion is complete */
>> -	ret = wait_event_timeout(opt->result_ready_queue, opt->result_ready,
>> -			OPT3001_RESULT_READY_TIMEOUT);
>> +	if (opt->use_irq) {
>> +		/* Wait for the IRQ to indicate the conversion is complete */
>> +		ret = wait_event_timeout(opt->result_ready_queue,
>> +				opt->result_ready,
>> +				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
>> +	} else {
>> +		/* Sleep for result ready time */
>> +		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
>> +			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
>> +		msleep(timeout);
>> +
>> +		/* Check result ready flag */
>> +		ret = i2c_smbus_read_word_swapped(opt->client,
>> +						  OPT3001_CONFIGURATION);
>> +		if (ret < 0) {
>> +			dev_err(opt->dev, "failed to read register %02x\n",
>> +				OPT3001_CONFIGURATION);
>> +			goto err;
>> +		}
>> +
>> +		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
>> +			ret = -ETIMEDOUT;
>> +			goto err;
>> +		}
>> +
>> +		/* Obtain value */
>> +		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
>> +		if (ret < 0) {
>> +			dev_err(opt->dev, "failed to read register %02x\n",
>> +				OPT3001_RESULT);
>> +			goto err;
>> +		}
>> +		opt->result = ret;
>> +		opt->result_ready = true;
>> +	}
>>  
>>  err:
>> -	/* Disallow IRQ to access the device while lock is active */
>> -	opt->ok_to_ignore_lock = false;
>> +	if (opt->use_irq)
>> +		/* Disallow IRQ to access the device while lock is active */
>> +		opt->ok_to_ignore_lock = false;
>>  
>>  	if (ret == 0)
>>  		return -ETIMEDOUT;
>>  	else if (ret < 0)
>>  		return ret;
>>  
>> -	/*
>> -	 * Disable the end-of-conversion interrupt mechanism by restoring the
>> -	 * low-level limit value (clearing OPT3001_LOW_LIMIT_EOC_ENABLE). Note
>> -	 * that selectively clearing those enable bits would affect the actual
>> -	 * limit value due to bit-overlap and therefore can't be done.
>> -	 */
>> -	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
>> -	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_LOW_LIMIT,
>> -			value);
>> -	if (ret < 0) {
>> -		dev_err(opt->dev, "failed to write register %02x\n",
>> -				OPT3001_LOW_LIMIT);
>> -		return ret;
>> +	if (opt->use_irq) {
>> +		/*
>> +		 * Disable the end-of-conversion interrupt mechanism by
>> +		 * restoring the low-level limit value (clearing
>> +		 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
>> +		 * those enable bits would affect the actual limit value due to
>> +		 * bit-overlap and therefore can't be done.
>> +		 */
>> +		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
>> +		ret = i2c_smbus_write_word_swapped(opt->client,
>> +						   OPT3001_LOW_LIMIT,
>> +						   value);
>> +		if (ret < 0) {
>> +			dev_err(opt->dev, "failed to write register %02x\n",
>> +					OPT3001_LOW_LIMIT);
>> +			return ret;
>> +		}
>>  	}
>>  
>>  	exponent = OPT3001_REG_EXPONENT(opt->result);
>> @@ -736,12 +782,18 @@ static int opt3001_probe(struct i2c_client *client,
>>  		return ret;
>>  	}
>>  
>> -	ret = request_threaded_irq(irq, NULL, opt3001_irq,
>> -			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> -			"opt3001", iio);
>> -	if (ret) {
>> -		dev_err(dev, "failed to request IRQ #%d\n", irq);
>> -		return ret;
>> +	/* Make use of INT pin only if valid IRQ no. is given */
>> +	if (irq > 0) {
>> +		ret = request_threaded_irq(irq, NULL, opt3001_irq,
>> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
>> +				"opt3001", iio);
> 
> You can define your driver's name once and use it at least here and in
> struct i2c_driver, and struct i2c_device_id.
Whilst a fair comment, it's a change that should actually be done in a
separate patch as it's not part of the functionality added here.
(this code is just indented, so ends up in the diff)
> 
>> +		if (ret) {
>> +			dev_err(dev, "failed to request IRQ #%d\n", irq);
>> +			return ret;
>> +		}
>> +		opt->use_irq = true;
>> +	} else {
>> +		dev_info(opt->dev, "enabling interrupt-less operation\n");
>>  	}
> 
> I'd probably make this debug level output.
> 
>>  
>>  	return 0;
>> @@ -754,7 +806,8 @@ static int opt3001_remove(struct i2c_client *client)
>>  	int ret;
>>  	u16 reg;
>>  
>> -	free_irq(client->irq, iio);
>> +	if (opt->use_irq)
>> +		free_irq(client->irq, iio);
>>  
>>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
>>  	if (ret < 0) {
>>
> 

