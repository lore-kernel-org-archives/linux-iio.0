Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:37716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752346AbeCXNfi (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 09:35:38 -0400
Date: Sat, 24 Mar 2018 13:35:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 04/11] staging: iio: tsl2x7x: simplify
 tsl2x7x_prox_cal()
Message-ID: <20180324133532.053d3a12@archlinux>
In-Reply-To: <20180321102912.5130-5-masneyb@onstation.org>
References: <20180321102912.5130-1-masneyb@onstation.org>
        <20180321102912.5130-5-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 21 Mar 2018 06:29:05 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_prox_cal() would set the interrupt flag, and reset the device to
> start doing the calibration routine. However, this did not actually
> affect the readings since they are polled. This patch drops the interrupt
> code.
> 
> This patch also drops the function tsl2x7x_prox_calculate() and removes
> support for the standard deviation and min sample since those values
> were not used.
> 
> Driver was tested using a TSL2772 hooked up to a Raspberry Pi 2. I
> performed the following testing at various distances:
> 
> - Put hand in front of sensor and keep the sensor and hand stationary.
> - Perform calibration routine.
> - Run iio_event_monitor.
> - Verify that a proximity event is triggered when my hand comes
>   anywhere between the sensor and where I performed the calibration
>   routine.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
Applied.  Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 107 +++++-------------------------------
>  1 file changed, 15 insertions(+), 92 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 9c929e273135..99230d9313e1 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -149,13 +149,6 @@ struct tsl2x7x_als_info {
>  	u16 lux;
>  };
>  
> -struct tsl2x7x_prox_stat {
> -	int min;
> -	int max;
> -	int mean;
> -	unsigned long stddev;
> -};
> -
>  struct tsl2x7x_chip_info {
>  	int chan_table_elements;
>  	struct iio_chan_spec		channel[4];
> @@ -771,106 +764,36 @@ static int tsl2x7x_invoke_change(struct iio_dev *indio_dev)
>  	return ret;
>  }
>  
> -static void tsl2x7x_prox_calculate(int *data, int length,
> -				   struct tsl2x7x_prox_stat *stat)
> -{
> -	int i;
> -	int sample_sum;
> -	int tmp;
> -
> -	if (!length)
> -		length = 1;
> -
> -	sample_sum = 0;
> -	stat->min = INT_MAX;
> -	stat->max = INT_MIN;
> -	for (i = 0; i < length; i++) {
> -		sample_sum += data[i];
> -		stat->min = min(stat->min, data[i]);
> -		stat->max = max(stat->max, data[i]);
> -	}
> -
> -	stat->mean = sample_sum / length;
> -	sample_sum = 0;
> -	for (i = 0; i < length; i++) {
> -		tmp = data[i] - stat->mean;
> -		sample_sum += tmp * tmp;
> -	}
> -	stat->stddev = int_sqrt((long)sample_sum / length);
> -}
> -
> -/**
> - * tsl2x7x_prox_cal() - Calculates std. and sets thresholds.
> - * @indio_dev:	pointer to IIO device
> - *
> - * Calculates a standard deviation based on the samples,
> - * and sets the threshold accordingly.
> - */
>  static int tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  {
> -	int prox_history[MAX_SAMPLES_CAL + 1];
> -	int i, ret;
> -	struct tsl2x7x_prox_stat prox_stat_data[2];
> -	struct tsl2x7x_prox_stat *cal;
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	u8 tmp_irq_settings;
> -	u8 current_state = chip->tsl2x7x_chip_status;
> -
> -	if (chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
> -		dev_err(&chip->client->dev,
> -			"max prox samples cal is too big: %d\n",
> -			chip->settings.prox_max_samples_cal);
> -		chip->settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
> -	}
> -
> -	/* have to stop to change settings */
> -	ret = tsl2x7x_chip_off(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -
> -	/* Enable proximity detection save just in case prox not wanted yet*/
> -	tmp_irq_settings = chip->settings.interrupts_en;
> -	chip->settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
> +	int prox_history[MAX_SAMPLES_CAL + 1];
> +	int i, ret, mean, max, sample_sum;
>  
> -	/*turn on device if not already on*/
> -	ret = tsl2x7x_chip_on(indio_dev);
> -	if (ret < 0)
> -		return ret;
> +	if (chip->settings.prox_max_samples_cal < 1 ||
> +	    chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL)
> +		return -EINVAL;
>  
> -	/*gather the samples*/
>  	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
>  		usleep_range(15000, 17500);
>  		ret = tsl2x7x_get_prox(indio_dev);
>  		if (ret < 0)
>  			return ret;
> +
>  		prox_history[i] = chip->prox_data;
> -		dev_info(&chip->client->dev, "2 i=%d prox data= %d\n",
> -			 i, chip->prox_data);
>  	}
>  
> -	ret = tsl2x7x_chip_off(indio_dev);
> -	if (ret < 0)
> -		return ret;
> -	cal = &prox_stat_data[PROX_STAT_CAL];
> -	tsl2x7x_prox_calculate(prox_history,
> -			       chip->settings.prox_max_samples_cal, cal);
> -	chip->settings.prox_thres_high = (cal->max << 1) - cal->mean;
> -
> -	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
> -		 cal->min, cal->mean, cal->max);
> -	dev_info(&chip->client->dev,
> -		 "%s proximity threshold set to %d\n",
> -		 chip->client->name, chip->settings.prox_thres_high);
> -
> -	/* back to the way they were */
> -	chip->settings.interrupts_en = tmp_irq_settings;
> -	if (current_state == TSL2X7X_CHIP_WORKING) {
> -		ret = tsl2x7x_chip_on(indio_dev);
> -		if (ret < 0)
> -			return ret;
> +	sample_sum = 0;
> +	max = INT_MIN;
> +	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
> +		sample_sum += prox_history[i];
> +		max = max(max, prox_history[i]);
>  	}
> +	mean = sample_sum / chip->settings.prox_max_samples_cal;
>  
> -	return 0;
> +	chip->settings.prox_thres_high = (max << 1) - mean;
> +
> +	return tsl2x7x_invoke_change(indio_dev);
>  }
>  
>  static ssize_t

