Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43818 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdJAKOz (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 1 Oct 2017 06:14:55 -0400
Date: Sun, 1 Oct 2017 11:08:26 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 1/3] staging: iio: tsl2x7x: rename tsl2x7x_settings
 variable to settings
Message-ID: <20171001110826.1dfc1cfb@archlinux>
In-Reply-To: <20170930010921.15447-2-masneyb@onstation.org>
References: <20170930010921.15447-1-masneyb@onstation.org>
        <20170930010921.15447-2-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Sep 2017 21:09:19 -0400
Brian Masney <masneyb@onstation.org> wrote:

> The length of the 'tsl2x7x_settings' variable within the tsl2X7X_chip
> structure makes some of the line lengths greater than 80 characters for
> upcoming patches. This patch shortens the name of the 'tsl2x7x_settings'
> variable in this structure to just 'settings' to improve code
> readability.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>

Hi Brian,

A few things have sneaked in here that aren't technically part of
the described change.  Should have been mentioned in the description
however trivial they are.

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/light/tsl2x7x.c | 183 +++++++++++++++++-------------------
>  1 file changed, 85 insertions(+), 98 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index d9defc8ece83..e340ea624e5c 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -174,7 +174,7 @@ struct tsl2X7X_chip {
>  	struct i2c_client *client;
>  	u16 prox_data;
>  	struct tsl2x7x_als_info als_cur_info;
> -	struct tsl2x7x_settings tsl2x7x_settings;
> +	struct tsl2x7x_settings settings;
>  	struct tsl2X7X_platform_data *pdata;
>  	int als_time_scale;
>  	int als_saturation;
> @@ -390,9 +390,9 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  		lux = 0;
>  	} else {
>  		ch0lux = DIV_ROUND_UP(ch0 * p->ch0,
> -			tsl2X7X_als_gainadj[chip->tsl2x7x_settings.als_gain]);
> +			tsl2X7X_als_gainadj[chip->settings.als_gain]);
>  		ch1lux = DIV_ROUND_UP(ch1 * p->ch1,
> -			tsl2X7X_als_gainadj[chip->tsl2x7x_settings.als_gain]);
> +			tsl2X7X_als_gainadj[chip->settings.als_gain]);
>  		lux = ch0lux - ch1lux;
>  	}
>  
> @@ -419,7 +419,7 @@ static int tsl2x7x_get_lux(struct iio_dev *indio_dev)
>  	 */
>  
>  	lux64 = lux;
> -	lux64 = lux64 * chip->tsl2x7x_settings.als_gain_trim;
> +	lux64 = lux64 * chip->settings.als_gain_trim;
>  	lux64 >>= 8;
>  	lux = lux64;
>  	lux = (lux + 500) / 1000;
> @@ -514,12 +514,10 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
>  {
>  	/* If Operational settings defined elsewhere.. */
>  	if (chip->pdata && chip->pdata->platform_default_settings)
> -		memcpy(&chip->tsl2x7x_settings,
> -		       chip->pdata->platform_default_settings,
> +		memcpy(&chip->settings, chip->pdata->platform_default_settings,
>  		       sizeof(tsl2x7x_default_settings));
>  	else
> -		memcpy(&chip->tsl2x7x_settings,
> -		       &tsl2x7x_default_settings,
> +		memcpy(&chip->settings, &tsl2x7x_default_settings,
>  		       sizeof(tsl2x7x_default_settings));
>  
>  	/* Load up the proper lux table. */
> @@ -542,9 +540,7 @@ static void tsl2x7x_defaults(struct tsl2X7X_chip *chip)
>  static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(indio_dev);
> -	int gain_trim_val;

This change doesn't have much to do with the rename..

> -	int ret;
> -	int lux_val;
> +	int ret, lux_val;
>  
>  	ret = i2c_smbus_read_byte_data(chip->client,
>  				       TSL2X7X_CMD_REG | TSL2X7X_CNTRL);
> @@ -575,16 +571,16 @@ static int tsl2x7x_als_calibrate(struct iio_dev *indio_dev)
>  		return lux_val;
>  	}
>  
> -	gain_trim_val =  ((chip->tsl2x7x_settings.als_cal_target)
> -			* chip->tsl2x7x_settings.als_gain_trim) / lux_val;
> -	if ((gain_trim_val < 250) || (gain_trim_val > 4000))
> +	ret = (chip->settings.als_cal_target * chip->settings.als_gain_trim) /
> +			lux_val;
> +	if (ret < 250 || ret > 4000)
>  		return -ERANGE;
>  
> -	chip->tsl2x7x_settings.als_gain_trim = gain_trim_val;
> +	chip->settings.als_gain_trim = ret;
>  	dev_info(&chip->client->dev,
>  		 "%s als_calibrate completed\n", chip->client->name);
>  
> -	return (int)gain_trim_val;
> +	return ret;
>  }
>  
>  static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
> @@ -602,34 +598,30 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  		chip->pdata->power_on(indio_dev);
>  
>  	/* Non calculated parameters */
> -	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] =
> -			chip->tsl2x7x_settings.prx_time;
> -	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] =
> -			chip->tsl2x7x_settings.wait_time;
> -	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] =
> -			chip->tsl2x7x_settings.prox_config;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_TIME] = chip->settings.prx_time;
> +	chip->tsl2x7x_config[TSL2X7X_WAIT_TIME] = chip->settings.wait_time;
> +	chip->tsl2x7x_config[TSL2X7X_PRX_CONFIG] = chip->settings.prox_config;
>  
>  	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHLO] =
> -		(chip->tsl2x7x_settings.als_thresh_low) & 0xFF;
> +		(chip->settings.als_thresh_low) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_ALS_MINTHRESHHI] =
> -		(chip->tsl2x7x_settings.als_thresh_low >> 8) & 0xFF;
> +		(chip->settings.als_thresh_low >> 8) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHLO] =
> -		(chip->tsl2x7x_settings.als_thresh_high) & 0xFF;
> +		(chip->settings.als_thresh_high) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_ALS_MAXTHRESHHI] =
> -		(chip->tsl2x7x_settings.als_thresh_high >> 8) & 0xFF;
> -	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] =
> -		chip->tsl2x7x_settings.persistence;
> +		(chip->settings.als_thresh_high >> 8) & 0xFF;
> +	chip->tsl2x7x_config[TSL2X7X_PERSISTENCE] = chip->settings.persistence;
>  
>  	chip->tsl2x7x_config[TSL2X7X_PRX_COUNT] =
> -			chip->tsl2x7x_settings.prox_pulse_count;
> +			chip->settings.prox_pulse_count;
>  	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHLO] =
> -			(chip->tsl2x7x_settings.prox_thres_low) & 0xFF;
> +			(chip->settings.prox_thres_low) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_PRX_MINTHRESHHI] =
> -			(chip->tsl2x7x_settings.prox_thres_low >> 8) & 0xFF;
> +			(chip->settings.prox_thres_low >> 8) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHLO] =
> -			(chip->tsl2x7x_settings.prox_thres_high) & 0xFF;
> +			(chip->settings.prox_thres_high) & 0xFF;
>  	chip->tsl2x7x_config[TSL2X7X_PRX_MAXTHRESHHI] =
> -			(chip->tsl2x7x_settings.prox_thres_high >> 8) & 0xFF;
> +			(chip->settings.prox_thres_high >> 8) & 0xFF;
>  
>  	/* and make sure we're not already on */
>  	if (chip->tsl2x7x_chip_status == TSL2X7X_CHIP_WORKING) {
> @@ -639,7 +631,7 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  	}
>  
>  	/* determine als integration register */
> -	als_count = (chip->tsl2x7x_settings.als_time * 100 + 135) / 270;
> +	als_count = (chip->settings.als_time * 100 + 135) / 270;
>  	if (!als_count)
>  		als_count = 1; /* ensure at least one cycle */
>  
> @@ -649,9 +641,9 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  	/* Set the gain based on tsl2x7x_settings struct */
>  	chip->tsl2x7x_config[TSL2X7X_GAIN] =
> -		chip->tsl2x7x_settings.als_gain |
> -			(TSL2X7X_mA100 | TSL2X7X_DIODE1)
> -			| ((chip->tsl2x7x_settings.prox_gain) << 2);
> +		chip->settings.als_gain |
> +			(TSL2X7X_mA100 | TSL2X7X_DIODE1) |
> +			(chip->settings.prox_gain << 2);
>  
>  	/* set chip struct re scaling and saturation */
>  	chip->als_saturation = als_count * 922; /* 90% of full scale */
> @@ -706,15 +698,15 @@ static int tsl2x7x_chip_on(struct iio_dev *indio_dev)
>  
>  	chip->tsl2x7x_chip_status = TSL2X7X_CHIP_WORKING;
>  
> -	if (chip->tsl2x7x_settings.interrupts_en != 0) {
> +	if (chip->settings.interrupts_en != 0) {
>  		dev_info(&chip->client->dev, "Setting Up Interrupt(s)\n");
>  
>  		reg_val = TSL2X7X_CNTL_PWR_ON | TSL2X7X_CNTL_ADC_ENBL;
> -		if ((chip->tsl2x7x_settings.interrupts_en == 0x20) ||
> -		    (chip->tsl2x7x_settings.interrupts_en == 0x30))
> +		if ((chip->settings.interrupts_en == 0x20) ||
> +		    (chip->settings.interrupts_en == 0x30))
>  			reg_val |= TSL2X7X_CNTL_PROX_DET_ENBL;
>  
> -		reg_val |= chip->tsl2x7x_settings.interrupts_en;
> +		reg_val |= chip->settings.interrupts_en;
>  		ret = i2c_smbus_write_byte_data(chip->client,
>  						(TSL2X7X_CMD_REG |
>  						TSL2X7X_CNTRL), reg_val);
> @@ -837,25 +829,25 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	u8 tmp_irq_settings;
>  	u8 current_state = chip->tsl2x7x_chip_status;
>  
> -	if (chip->tsl2x7x_settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
> +	if (chip->settings.prox_max_samples_cal > MAX_SAMPLES_CAL) {
>  		dev_err(&chip->client->dev,
>  			"max prox samples cal is too big: %d\n",
> -			chip->tsl2x7x_settings.prox_max_samples_cal);
> -		chip->tsl2x7x_settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
> +			chip->settings.prox_max_samples_cal);
> +		chip->settings.prox_max_samples_cal = MAX_SAMPLES_CAL;
>  	}
>  
>  	/* have to stop to change settings */
>  	tsl2x7x_chip_off(indio_dev);
>  
>  	/* Enable proximity detection save just in case prox not wanted yet*/
> -	tmp_irq_settings = chip->tsl2x7x_settings.interrupts_en;
> -	chip->tsl2x7x_settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
> +	tmp_irq_settings = chip->settings.interrupts_en;
> +	chip->settings.interrupts_en |= TSL2X7X_CNTL_PROX_INT_ENBL;
>  
>  	/*turn on device if not already on*/
>  	tsl2x7x_chip_on(indio_dev);
>  
>  	/*gather the samples*/
> -	for (i = 0; i < chip->tsl2x7x_settings.prox_max_samples_cal; i++) {
> +	for (i = 0; i < chip->settings.prox_max_samples_cal; i++) {
>  		usleep_range(15000, 17500);
>  		tsl2x7x_get_prox(indio_dev);
>  		prox_history[i] = chip->prox_data;
> @@ -866,18 +858,17 @@ static void tsl2x7x_prox_cal(struct iio_dev *indio_dev)
>  	tsl2x7x_chip_off(indio_dev);
>  	calP = &prox_stat_data[PROX_STAT_CAL];
>  	tsl2x7x_prox_calculate(prox_history,
> -			       chip->tsl2x7x_settings.prox_max_samples_cal,
> -			       calP);
> -	chip->tsl2x7x_settings.prox_thres_high = (calP->max << 1) - calP->mean;
> +			       chip->settings.prox_max_samples_cal, calP);
> +	chip->settings.prox_thres_high = (calP->max << 1) - calP->mean;
>  
>  	dev_info(&chip->client->dev, " cal min=%d mean=%d max=%d\n",
>  		 calP->min, calP->mean, calP->max);
>  	dev_info(&chip->client->dev,
>  		 "%s proximity threshold set to %d\n",
> -		 chip->client->name, chip->tsl2x7x_settings.prox_thres_high);
> +		 chip->client->name, chip->settings.prox_thres_high);
>  
>  	/* back to the way they were */
> -	chip->tsl2x7x_settings.interrupts_en = tmp_irq_settings;
> +	chip->settings.interrupts_en = tmp_irq_settings;
>  	if (current_state == TSL2X7X_CHIP_WORKING)
>  		tsl2x7x_chip_on(indio_dev);
>  }
> @@ -914,7 +905,7 @@ static ssize_t in_illuminance0_integration_time_show(struct device *dev,
>  	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  	int y, z;
>  
> -	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
> +	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.als_time) + 1;
>  	z = y * TSL2X7X_MIN_ITIME;
>  	y /= 1000;
>  	z %= 1000;
> @@ -936,11 +927,10 @@ static ssize_t in_illuminance0_integration_time_store(struct device *dev,
>  		return ret;
>  
>  	result.fract /= 3;
> -	chip->tsl2x7x_settings.als_time =
> -			TSL2X7X_MAX_TIMER_CNT - (u8)result.fract;
> +	chip->settings.als_time = TSL2X7X_MAX_TIMER_CNT - (u8)result.fract;
>  
>  	dev_info(&chip->client->dev, "%s: als time = %d",
> -		 __func__, chip->tsl2x7x_settings.als_time);
> +		 __func__, chip->settings.als_time);
>  
>  	tsl2x7x_invoke_change(indio_dev);
>  
> @@ -956,8 +946,7 @@ static ssize_t in_illuminance0_target_input_show(struct device *dev,
>  {
>  	struct tsl2X7X_chip *chip = iio_priv(dev_to_iio_dev(dev));
>  
> -	return snprintf(buf, PAGE_SIZE, "%d\n",
> -			chip->tsl2x7x_settings.als_cal_target);
> +	return snprintf(buf, PAGE_SIZE, "%d\n", chip->settings.als_cal_target);
>  }
>  
>  static ssize_t in_illuminance0_target_input_store(struct device *dev,
> @@ -973,7 +962,7 @@ static ssize_t in_illuminance0_target_input_store(struct device *dev,
>  		return -EINVAL;
>  
>  	if (value)
> -		chip->tsl2x7x_settings.als_cal_target = value;
> +		chip->settings.als_cal_target = value;
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
>  	if (ret < 0)
> @@ -991,9 +980,9 @@ static ssize_t in_intensity0_thresh_period_show(struct device *dev,
>  	int y, z, filter_delay;
>  
>  	/* Determine integration time */
> -	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
> +	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.als_time) + 1;
>  	z = y * TSL2X7X_MIN_ITIME;
> -	filter_delay = z * (chip->tsl2x7x_settings.persistence & 0x0F);
> +	filter_delay = z * (chip->settings.persistence & 0x0F);
>  	y = filter_delay / 1000;
>  	z = filter_delay % 1000;
>  
> @@ -1014,14 +1003,14 @@ static ssize_t in_intensity0_thresh_period_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.als_time) + 1;
> +	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.als_time) + 1;
>  	z = y * TSL2X7X_MIN_ITIME;
>  
>  	filter_delay =
>  		DIV_ROUND_UP((result.integer * 1000) + result.fract, z);
>  
> -	chip->tsl2x7x_settings.persistence &= 0xF0;
> -	chip->tsl2x7x_settings.persistence |= (filter_delay & 0x0F);
> +	chip->settings.persistence &= 0xF0;
> +	chip->settings.persistence |= (filter_delay & 0x0F);
>  
>  	dev_info(&chip->client->dev, "%s: als persistence = %d",
>  		 __func__, filter_delay);
> @@ -1041,9 +1030,9 @@ static ssize_t in_proximity0_thresh_period_show(struct device *dev,
>  	int y, z, filter_delay;
>  
>  	/* Determine integration time */
> -	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.prx_time) + 1;
> +	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.prx_time) + 1;
>  	z = y * TSL2X7X_MIN_ITIME;
> -	filter_delay = z * ((chip->tsl2x7x_settings.persistence & 0xF0) >> 4);
> +	filter_delay = z * ((chip->settings.persistence & 0xF0) >> 4);
>  	y = filter_delay / 1000;
>  	z = filter_delay % 1000;
>  
> @@ -1064,14 +1053,14 @@ static ssize_t in_proximity0_thresh_period_store(struct device *dev,
>  	if (ret)
>  		return ret;
>  
> -	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->tsl2x7x_settings.prx_time) + 1;
> +	y = (TSL2X7X_MAX_TIMER_CNT - (u8)chip->settings.prx_time) + 1;
>  	z = y * TSL2X7X_MIN_ITIME;
>  
>  	filter_delay =
>  		DIV_ROUND_UP((result.integer * 1000) + result.fract, z);
>  
> -	chip->tsl2x7x_settings.persistence &= 0x0F;
> -	chip->tsl2x7x_settings.persistence |= ((filter_delay << 4) & 0xF0);
> +	chip->settings.persistence &= 0x0F;
> +	chip->settings.persistence |= ((filter_delay << 4) & 0xF0);
>  
>  	dev_info(&chip->client->dev, "%s: prox persistence = %d",
>  		 __func__, filter_delay);
> @@ -1205,9 +1194,9 @@ static int tsl2x7x_read_interrupt_config(struct iio_dev *indio_dev,
>  	int ret;
>  
>  	if (chan->type == IIO_INTENSITY)
> -		ret = !!(chip->tsl2x7x_settings.interrupts_en & 0x10);
> +		ret = !!(chip->settings.interrupts_en & 0x10);
>  	else
> -		ret = !!(chip->tsl2x7x_settings.interrupts_en & 0x20);
> +		ret = !!(chip->settings.interrupts_en & 0x20);
>  
>  	return ret;
>  }
> @@ -1223,14 +1212,14 @@ static int tsl2x7x_write_interrupt_config(struct iio_dev *indio_dev,
>  
>  	if (chan->type == IIO_INTENSITY) {
>  		if (val)
> -			chip->tsl2x7x_settings.interrupts_en |= 0x10;
> +			chip->settings.interrupts_en |= 0x10;
>  		else
> -			chip->tsl2x7x_settings.interrupts_en &= 0x20;
> +			chip->settings.interrupts_en &= 0x20;
>  	} else {
>  		if (val)
> -			chip->tsl2x7x_settings.interrupts_en |= 0x20;
> +			chip->settings.interrupts_en |= 0x20;
>  		else
> -			chip->tsl2x7x_settings.interrupts_en &= 0x10;
> +			chip->settings.interrupts_en &= 0x10;
>  	}
>  
>  	ret = tsl2x7x_invoke_change(indio_dev);
> @@ -1255,11 +1244,11 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_INTENSITY) {
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
> -				chip->tsl2x7x_settings.als_thresh_high = val;
> +				chip->settings.als_thresh_high = val;
>  				ret = 0;
>  				break;
>  			case IIO_EV_DIR_FALLING:
> -				chip->tsl2x7x_settings.als_thresh_low = val;
> +				chip->settings.als_thresh_low = val;
>  				ret = 0;
>  				break;
>  			default:
> @@ -1268,11 +1257,11 @@ static int tsl2x7x_write_event_value(struct iio_dev *indio_dev,
>  		} else {
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
> -				chip->tsl2x7x_settings.prox_thres_high = val;
> +				chip->settings.prox_thres_high = val;
>  				ret = 0;
>  				break;
>  			case IIO_EV_DIR_FALLING:
> -				chip->tsl2x7x_settings.prox_thres_low = val;
> +				chip->settings.prox_thres_low = val;
>  				ret = 0;
>  				break;
>  			default:
> @@ -1305,11 +1294,11 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_INTENSITY) {
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
> -				*val = chip->tsl2x7x_settings.als_thresh_high;
> +				*val = chip->settings.als_thresh_high;
>  				ret = IIO_VAL_INT;
>  				break;
>  			case IIO_EV_DIR_FALLING:
> -				*val = chip->tsl2x7x_settings.als_thresh_low;
> +				*val = chip->settings.als_thresh_low;
>  				ret = IIO_VAL_INT;
>  				break;
>  			default:
> @@ -1318,11 +1307,11 @@ static int tsl2x7x_read_event_value(struct iio_dev *indio_dev,
>  		} else {
>  			switch (dir) {
>  			case IIO_EV_DIR_RISING:
> -				*val = chip->tsl2x7x_settings.prox_thres_high;
> +				*val = chip->settings.prox_thres_high;
>  				ret = IIO_VAL_INT;
>  				break;
>  			case IIO_EV_DIR_FALLING:
> -				*val = chip->tsl2x7x_settings.prox_thres_low;
> +				*val = chip->settings.prox_thres_low;
>  				ret = IIO_VAL_INT;
>  				break;
>  			default:
> @@ -1379,15 +1368,13 @@ static int tsl2x7x_read_raw(struct iio_dev *indio_dev,
>  		break;
>  	case IIO_CHAN_INFO_CALIBSCALE:
>  		if (chan->type == IIO_LIGHT)
> -			*val =
> -			tsl2X7X_als_gainadj[chip->tsl2x7x_settings.als_gain];
> +			*val = tsl2X7X_als_gainadj[chip->settings.als_gain];
>  		else
> -			*val =
> -			tsl2X7X_prx_gainadj[chip->tsl2x7x_settings.prox_gain];
> +			*val = tsl2X7X_prx_gainadj[chip->settings.prox_gain];
>  		ret = IIO_VAL_INT;
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		*val = chip->tsl2x7x_settings.als_gain_trim;
> +		*val = chip->settings.als_gain_trim;
>  		ret = IIO_VAL_INT;
>  		break;
>  
> @@ -1411,13 +1398,13 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		if (chan->type == IIO_INTENSITY) {
>  			switch (val) {
>  			case 1:
> -				chip->tsl2x7x_settings.als_gain = 0;
> +				chip->settings.als_gain = 0;
>  				break;
>  			case 8:
> -				chip->tsl2x7x_settings.als_gain = 1;
> +				chip->settings.als_gain = 1;
>  				break;
>  			case 16:
> -				chip->tsl2x7x_settings.als_gain = 2;
> +				chip->settings.als_gain = 2;
>  				break;
>  			case 120:
>  				switch (chip->id) {
> @@ -1428,7 +1415,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  				case tmd2772:
>  					return -EINVAL;
>  				}
> -				chip->tsl2x7x_settings.als_gain = 3;
> +				chip->settings.als_gain = 3;
>  				break;
>  			case 128:
>  				switch (chip->id) {
> @@ -1439,7 +1426,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  				case tmd2771:
>  					return -EINVAL;
>  				}
> -				chip->tsl2x7x_settings.als_gain = 3;
> +				chip->settings.als_gain = 3;
>  				break;
>  			default:
>  				return -EINVAL;
> @@ -1447,16 +1434,16 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		} else {
>  			switch (val) {
>  			case 1:
> -				chip->tsl2x7x_settings.prox_gain = 0;
> +				chip->settings.prox_gain = 0;
>  				break;
>  			case 2:
> -				chip->tsl2x7x_settings.prox_gain = 1;
> +				chip->settings.prox_gain = 1;
>  				break;
>  			case 4:
> -				chip->tsl2x7x_settings.prox_gain = 2;
> +				chip->settings.prox_gain = 2;
>  				break;
>  			case 8:
> -				chip->tsl2x7x_settings.prox_gain = 3;
> +				chip->settings.prox_gain = 3;
>  				break;
>  			default:
>  				return -EINVAL;
> @@ -1464,7 +1451,7 @@ static int tsl2x7x_write_raw(struct iio_dev *indio_dev,
>  		}
>  		break;
>  	case IIO_CHAN_INFO_CALIBBIAS:
> -		chip->tsl2x7x_settings.als_gain_trim = val;
> +		chip->settings.als_gain_trim = val;
>  		break;
>  
>  	default:

