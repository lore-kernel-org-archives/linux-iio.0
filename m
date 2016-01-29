Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from devils.ext.ti.com ([198.47.26.153]:42206 "EHLO
	devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752422AbcA2SCT (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 29 Jan 2016 13:02:19 -0500
Date: Fri, 29 Jan 2016 12:01:25 -0600
From: Andreas Dannenberg <dannenberg@ti.com>
To: Alexander Koch <mail@alexanderkoch.net>
CC: <jic23@kernel.org>, <knaack.h@gmx.de>, <lars@metafoo.de>,
	<pmeerw@pmeerw.net>, <mhornung.linux@gmail.com>, <balbi@ti.com>,
	<fengguang.wu@intel.com>, <linux-iio@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] iio: light: opt3001: enable operation w/o IRQ
Message-ID: <20160129180125.GC7960@LTA0797059A>
References: <1452960878-1727-1-git-send-email-mail@alexanderkoch.net>
 <1452960878-1727-4-git-send-email-mail@alexanderkoch.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <1452960878-1727-4-git-send-email-mail@alexanderkoch.net>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, Jan 16, 2016 at 05:14:38PM +0100, Alexander Koch wrote:
> Enable operation of the TI OPT3001 light sensor without having an
> interrupt line available to connect the INT pin to.
> 
> In this operation mode, we issue a conversion request and simply wait
> for the conversion time available as timeout value, determined from
> integration time configuration and the worst-case time given in the data
> sheet (sect. 6.5, table on p. 5):
> 
>   short integration time (100ms): 110ms + 3ms = 113ms
>    long integration time (800ms): 880ms + 3ms = 883ms
> 
> This change is transparent as behaviour defaults to using the interrupt
> method if an interrupt no. is configured via device tree. Interrupt-less
> operation mode is performed when no valid interrupt no. is given.
> 
> Signed-off-by: Alexander Koch <mail@alexanderkoch.net>
> Signed-off-by: Michael Hornung <mhornung.linux@gmail.com>

Tested-by: Andreas Dannenberg <dannenberg@ti.com>

I tested both interrupt mode and non-interrupt mode using a BeagleBone
Black. Works like a champ. Also the hard-coded integration "wait" times
look good.


--
Andreas Dannenberg
Texas Instruments Inc


> ---
>  drivers/iio/light/opt3001.c | 137 ++++++++++++++++++++++++++++++--------------
>  1 file changed, 95 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/iio/light/opt3001.c b/drivers/iio/light/opt3001.c
> index b05c484..2a2340d 100644
> --- a/drivers/iio/light/opt3001.c
> +++ b/drivers/iio/light/opt3001.c
> @@ -70,9 +70,12 @@
>  
>  /*
>   * Time to wait for conversion result to be ready. The device datasheet
> - * worst-case max value is 880ms. Add some slack to be on the safe side.
> + * sect. 6.5 states results are ready after total integration time plus 3ms.
> + * This results in worst-case max values of 113ms or 883ms, respectively.
> + * Add some slack to be on the safe side.
>   */
> -#define OPT3001_RESULT_READY_TIMEOUT	msecs_to_jiffies(1000)
> +#define OPT3001_RESULT_READY_SHORT	150
> +#define OPT3001_RESULT_READY_LONG	1000
>  
>  struct opt3001 {
>  	struct i2c_client	*client;
> @@ -92,6 +95,8 @@ struct opt3001 {
>  
>  	u8			high_thresh_exp;
>  	u8			low_thresh_exp;
> +
> +	bool			use_irq;
>  };
>  
>  struct opt3001_scale {
> @@ -230,26 +235,30 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
>  	u16 reg;
>  	u8 exponent;
>  	u16 value;
> +	long timeout;
>  
> -	/*
> -	 * Enable the end-of-conversion interrupt mechanism. Note that doing
> -	 * so will overwrite the low-level limit value however we will restore
> -	 * this value later on.
> -	 */
> -	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_LOW_LIMIT,
> -			OPT3001_LOW_LIMIT_EOC_ENABLE);
> -	if (ret < 0) {
> -		dev_err(opt->dev, "failed to write register %02x\n",
> -				OPT3001_LOW_LIMIT);
> -		return ret;
> +	if (opt->use_irq) {
> +		/*
> +		 * Enable the end-of-conversion interrupt mechanism. Note that
> +		 * doing so will overwrite the low-level limit value however we
> +		 * will restore this value later on.
> +		 */
> +		ret = i2c_smbus_write_word_swapped(opt->client,
> +					OPT3001_LOW_LIMIT,
> +					OPT3001_LOW_LIMIT_EOC_ENABLE);
> +		if (ret < 0) {
> +			dev_err(opt->dev, "failed to write register %02x\n",
> +					OPT3001_LOW_LIMIT);
> +			return ret;
> +		}
> +
> +		/* Allow IRQ to access the device despite lock being set */
> +		opt->ok_to_ignore_lock = true;
>  	}
>  
> -	/* Reset data-ready indicator flag (will be set in the IRQ routine) */
> +	/* Reset data-ready indicator flag */
>  	opt->result_ready = false;
>  
> -	/* Allow IRQ to access the device despite lock being set */
> -	opt->ok_to_ignore_lock = true;
> -
>  	/* Configure for single-conversion mode and start a new conversion */
>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
>  	if (ret < 0) {
> @@ -269,32 +278,69 @@ static int opt3001_get_lux(struct opt3001 *opt, int *val, int *val2)
>  		goto err;
>  	}
>  
> -	/* Wait for the IRQ to indicate the conversion is complete */
> -	ret = wait_event_timeout(opt->result_ready_queue, opt->result_ready,
> -			OPT3001_RESULT_READY_TIMEOUT);
> +	if (opt->use_irq) {
> +		/* Wait for the IRQ to indicate the conversion is complete */
> +		ret = wait_event_timeout(opt->result_ready_queue,
> +				opt->result_ready,
> +				msecs_to_jiffies(OPT3001_RESULT_READY_LONG));
> +	} else {
> +		/* Sleep for result ready time */
> +		timeout = (opt->int_time == OPT3001_INT_TIME_SHORT) ?
> +			OPT3001_RESULT_READY_SHORT : OPT3001_RESULT_READY_LONG;
> +		msleep(timeout);
> +
> +		/* Check result ready flag */
> +		ret = i2c_smbus_read_word_swapped(opt->client,
> +						  OPT3001_CONFIGURATION);
> +		if (ret < 0) {
> +			dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_CONFIGURATION);
> +			goto err;
> +		}
> +
> +		if (!(ret & OPT3001_CONFIGURATION_CRF)) {
> +			ret = -ETIMEDOUT;
> +			goto err;
> +		}
> +
> +		/* Obtain value */
> +		ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_RESULT);
> +		if (ret < 0) {
> +			dev_err(opt->dev, "failed to read register %02x\n",
> +				OPT3001_RESULT);
> +			goto err;
> +		}
> +		opt->result = ret;
> +		opt->result_ready = true;
> +	}
>  
>  err:
> -	/* Disallow IRQ to access the device while lock is active */
> -	opt->ok_to_ignore_lock = false;
> +	if (opt->use_irq)
> +		/* Disallow IRQ to access the device while lock is active */
> +		opt->ok_to_ignore_lock = false;
>  
>  	if (ret == 0)
>  		return -ETIMEDOUT;
>  	else if (ret < 0)
>  		return ret;
>  
> -	/*
> -	 * Disable the end-of-conversion interrupt mechanism by restoring the
> -	 * low-level limit value (clearing OPT3001_LOW_LIMIT_EOC_ENABLE). Note
> -	 * that selectively clearing those enable bits would affect the actual
> -	 * limit value due to bit-overlap and therefore can't be done.
> -	 */
> -	value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> -	ret = i2c_smbus_write_word_swapped(opt->client, OPT3001_LOW_LIMIT,
> -			value);
> -	if (ret < 0) {
> -		dev_err(opt->dev, "failed to write register %02x\n",
> -				OPT3001_LOW_LIMIT);
> -		return ret;
> +	if (opt->use_irq) {
> +		/*
> +		 * Disable the end-of-conversion interrupt mechanism by
> +		 * restoring the low-level limit value (clearing
> +		 * OPT3001_LOW_LIMIT_EOC_ENABLE). Note that selectively clearing
> +		 * those enable bits would affect the actual limit value due to
> +		 * bit-overlap and therefore can't be done.
> +		 */
> +		value = (opt->low_thresh_exp << 12) | opt->low_thresh_mantissa;
> +		ret = i2c_smbus_write_word_swapped(opt->client,
> +						   OPT3001_LOW_LIMIT,
> +						   value);
> +		if (ret < 0) {
> +			dev_err(opt->dev, "failed to write register %02x\n",
> +					OPT3001_LOW_LIMIT);
> +			return ret;
> +		}
>  	}
>  
>  	exponent = OPT3001_REG_EXPONENT(opt->result);
> @@ -736,12 +782,18 @@ static int opt3001_probe(struct i2c_client *client,
>  		return ret;
>  	}
>  
> -	ret = request_threaded_irq(irq, NULL, opt3001_irq,
> -			IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> -			"opt3001", iio);
> -	if (ret) {
> -		dev_err(dev, "failed to request IRQ #%d\n", irq);
> -		return ret;
> +	/* Make use of INT pin only if valid IRQ no. is given */
> +	if (irq > 0) {
> +		ret = request_threaded_irq(irq, NULL, opt3001_irq,
> +				IRQF_TRIGGER_FALLING | IRQF_ONESHOT,
> +				"opt3001", iio);
> +		if (ret) {
> +			dev_err(dev, "failed to request IRQ #%d\n", irq);
> +			return ret;
> +		}
> +		opt->use_irq = true;
> +	} else {
> +		dev_info(opt->dev, "enabling interrupt-less operation\n");
>  	}
>  
>  	return 0;
> @@ -754,7 +806,8 @@ static int opt3001_remove(struct i2c_client *client)
>  	int ret;
>  	u16 reg;
>  
> -	free_irq(client->irq, iio);
> +	if (opt->use_irq)
> +		free_irq(client->irq, iio);
>  
>  	ret = i2c_smbus_read_word_swapped(opt->client, OPT3001_CONFIGURATION);
>  	if (ret < 0) {
> -- 
> 2.7.0
> 
