Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51416 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932861AbbDILbI (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 9 Apr 2015 07:31:08 -0400
Message-ID: <552662FF.6030006@kernel.org>
Date: Thu, 09 Apr 2015 12:31:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/8] iio: accel: mma9553: coding style fixes
References: <1428503857-9081-1-git-send-email-irina.tirdea@intel.com> <1428503857-9081-2-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428503857-9081-2-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/04/15 15:37, Irina Tirdea wrote:
> Fix a couple of coding style issues including:
>   * issues reported by checkpatch.pl --strict
>   * add mma9553_ prefix to all local functions/declarations
>   * fix documentation
>   * use GENMASK instead of direct masks
>   * fix code alignment
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Please break this up into smaller focused patches as it's a mixture of
various different things.

First high urgency patches:

Typo fixes
Wrong docs fixes

Then lower urgency (nice to have ones)

Prefixing naming
GENMASK
Aligment

So I'd say at least 5 short patches.
> ---
>  drivers/iio/accel/mma9551_core.c |  8 ++--
>  drivers/iio/accel/mma9551_core.h |  2 +-
>  drivers/iio/accel/mma9553.c      | 98 ++++++++++++++++++++--------------------
>  3 files changed, 55 insertions(+), 53 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9551_core.c b/drivers/iio/accel/mma9551_core.c
> index 7f55a6d..54b3ae6 100644
> --- a/drivers/iio/accel/mma9551_core.c
> +++ b/drivers/iio/accel/mma9551_core.c
> @@ -374,7 +374,7 @@ EXPORT_SYMBOL(mma9551_read_status_word);
>   * @app_id:	Application ID
>   * @reg:	Application register
>   * @len:	Length of array to read in bytes
> - * @val:	Array of words to read
> + * @buf:	Array of words to read
wrong docs aren't a style fix and probably want to go in faster so
please break these out into a separate patch.
>   *
>   * Read multiple configuration registers (word-sized registers).
>   *
> @@ -409,7 +409,7 @@ EXPORT_SYMBOL(mma9551_read_config_words);
>   * @app_id:	Application ID
>   * @reg:	Application register
>   * @len:	Length of array to read in bytes
> - * @val:	Array of words to read
> + * @buf:	Array of words to read
>   *
>   * Read multiple status registers (word-sized registers).
>   *
> @@ -444,7 +444,7 @@ EXPORT_SYMBOL(mma9551_read_status_words);
>   * @app_id:	Application ID
>   * @reg:	Application register
>   * @len:	Length of array to write in bytes
> - * @val:	Array of words to write
> + * @buf:	Array of words to write
>   *
>   * Write multiple configuration registers (word-sized registers).
>   *
> @@ -785,7 +785,7 @@ EXPORT_SYMBOL(mma9551_read_accel_scale);
>   */
>  int mma9551_app_reset(struct i2c_client *client, u32 app_mask)
>  {
> -	return mma9551_write_config_byte(client, MMA9551_APPID_RCS,
This isn't a style fix.  I'm guessing it is a straight fix for a typo?
Please break this out to it's own patch. More important than style fixes.

> +	return mma9551_write_config_byte(client, MMA9551_APPID_RSC,
>  					 MMA9551_RSC_RESET +
>  					 MMA9551_RSC_OFFSET(app_mask),
>  					 MMA9551_RSC_VAL(app_mask));
> diff --git a/drivers/iio/accel/mma9551_core.h b/drivers/iio/accel/mma9551_core.h
> index edaa56b..79939e4 100644
> --- a/drivers/iio/accel/mma9551_core.h
> +++ b/drivers/iio/accel/mma9551_core.h
> @@ -22,7 +22,7 @@
>  #define MMA9551_APPID_TILT		0x0B
>  #define MMA9551_APPID_SLEEP_WAKE	0x12
>  #define MMA9551_APPID_PEDOMETER	        0x15
> -#define MMA9551_APPID_RCS		0x17
> +#define MMA9551_APPID_RSC		0x17
>  #define MMA9551_APPID_NONE		0xff
>  
>  /* Reset/Suspend/Clear application app masks */
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 2df1af7..d095f81 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -54,6 +54,7 @@
>  #define MMA9553_MASK_CONF_STEPCOALESCE		GENMASK(7, 0)
>  
>  #define MMA9553_REG_CONF_ACTTHD			0x0E
> +#define MMA9553_MAX_ACTTHD			GENMASK(15, 0)
>  
>  /* Pedometer status registers (R-only) */
>  #define MMA9553_REG_STATUS			0x00
> @@ -62,8 +63,8 @@
>  #define MMA9553_MASK_STATUS_STEPCHG		BIT(13)
>  #define MMA9553_MASK_STATUS_ACTCHG		BIT(12)
>  #define MMA9553_MASK_STATUS_SUSP		BIT(11)
> -#define MMA9553_MASK_STATUS_ACTIVITY		(BIT(10) | BIT(9) | BIT(8))
> -#define MMA9553_MASK_STATUS_VERSION		0x00FF
> +#define MMA9553_MASK_STATUS_ACTIVITY		GENMASK(10, 8)
> +#define MMA9553_MASK_STATUS_VERSION		GENMASK(7, 0)
>  
>  #define MMA9553_REG_STEPCNT			0x02
>  #define MMA9553_REG_DISTANCE			0x04
> @@ -75,14 +76,14 @@
>  #define MMA9553_DEFAULT_GPIO_PIN	mma9551_gpio6
>  #define MMA9553_DEFAULT_GPIO_POLARITY	0
>  
> -/* Bitnum used for gpio configuration = bit number in high status byte */
> -#define STATUS_TO_BITNUM(bit)		(ffs(bit) - 9)
> +/* Bitnum used for GPIO configuration = bit number in high status byte */
> +#define MMA9553_STATUS_TO_BITNUM(bit)	(ffs(bit) - 9)
>  
>  #define MMA9553_DEFAULT_SAMPLE_RATE	30	/* Hz */
>  
>  /*
>   * The internal activity level must be stable for ACTTHD samples before
> - * ACTIVITY is updated.The ACTIVITY variable contains the current activity
> + * ACTIVITY is updated. The ACTIVITY variable contains the current activity
>   * level and is updated every time a step is detected or once a second
>   * if there are no steps.
>   */
> @@ -343,21 +344,21 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
>  	struct mma9553_event *ev_step_detect;
>  	bool activity_enabled;
>  
> -	activity_enabled =
> -	    mma9553_is_any_event_enabled(data, true, IIO_ACTIVITY);
> -	ev_step_detect =
> -	    mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD, IIO_EV_DIR_NONE);
> +	activity_enabled = mma9553_is_any_event_enabled(data, true,
> +							IIO_ACTIVITY);
> +	ev_step_detect = mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD,
> +					   IIO_EV_DIR_NONE);
This is defintlely a matter of taste rather than required, but fair enough
in a style cleanup patch.
>  
>  	/*
>  	 * If both step detector and activity are enabled, use the MRGFL bit.
>  	 * This bit is the logical OR of the SUSPCHG, STEPCHG, and ACTCHG flags.
>  	 */
>  	if (activity_enabled && ev_step_detect->enabled)
> -		bitnum = STATUS_TO_BITNUM(MMA9553_MASK_STATUS_MRGFL);
> +		bitnum = MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_MRGFL);
>  	else if (ev_step_detect->enabled)
> -		bitnum = STATUS_TO_BITNUM(MMA9553_MASK_STATUS_STEPCHG);
> +		bitnum = MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_STEPCHG);
>  	else if (activity_enabled)
> -		bitnum = STATUS_TO_BITNUM(MMA9553_MASK_STATUS_ACTCHG);
> +		bitnum = MMA9553_STATUS_TO_BITNUM(MMA9553_MASK_STATUS_ACTCHG);
>  	else			/* Reset */
>  		appid = MMA9551_APPID_NONE;
>  
> @@ -365,13 +366,15 @@ static int mma9553_conf_gpio(struct mma9553_data *data)
>  		return 0;
>  
>  	/* Save initial values for activity and stepcnt */
> -	if (activity_enabled || ev_step_detect->enabled)
> -		mma9553_read_activity_stepcnt(data, &data->activity,
> -					      &data->stepcnt);
> +	if (activity_enabled || ev_step_detect->enabled) {
> +		ret = mma9553_read_activity_stepcnt(data, &data->activity,
> +						    &data->stepcnt);
> +		if (ret < 0)
> +			return ret;
> +	}
>  
> -	ret = mma9551_gpio_config(data->client,
> -				  MMA9553_DEFAULT_GPIO_PIN,
> -				  appid, bitnum, MMA9553_DEFAULT_GPIO_POLARITY);
> +	ret = mma9551_gpio_config(data->client, MMA9553_DEFAULT_GPIO_PIN, appid,
> +				  bitnum, MMA9553_DEFAULT_GPIO_POLARITY);
>  	if (ret < 0)
>  		return ret;
>  	data->gpio_bitnum = bitnum;
> @@ -392,19 +395,19 @@ static int mma9553_init(struct mma9553_data *data)
>  	 * a device identification command to differentiate the MMA9553L
>  	 * from the MMA9550L.
>  	 */
> -	ret =
> -	    mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMETER,
> -				      MMA9553_REG_CONF_SLEEPMIN,
> -				      sizeof(data->conf), (u16 *) &data->conf);
> +	ret = mma9551_read_config_words(data->client, MMA9551_APPID_PEDOMETER,
> +					MMA9553_REG_CONF_SLEEPMIN,
> +					sizeof(data->conf),
> +					(u16 *)&data->conf);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
> -			"device is not MMA9553L: failed to read cfg regs\n");
> +			"failed to read configuration registers\n");
>  		return ret;
>  	}
>  
>  
> -	/* Reset gpio */
>  	data->gpio_bitnum = -1;
> +	/* Reset GPIO */
>  	ret = mma9553_conf_gpio(data);
>  	if (ret < 0)
>  		return ret;
> @@ -417,18 +420,18 @@ static int mma9553_init(struct mma9553_data *data)
>  	data->conf.sleepmin = MMA9553_DEFAULT_SLEEPMIN;
>  	data->conf.sleepmax = MMA9553_DEFAULT_SLEEPMAX;
>  	data->conf.sleepthd = MMA9553_DEFAULT_SLEEPTHD;
> -	data->conf.config =
> -	    mma9553_set_bits(data->conf.config, 1, MMA9553_MASK_CONF_CONFIG);
> +	data->conf.config = mma9553_set_bits(data->conf.config, 1,
> +					     MMA9553_MASK_CONF_CONFIG);
>  	/*
>  	 * Clear the activity debounce counter when the activity level changes,
>  	 * so that the confidence level applies for any activity level.
>  	 */
>  	data->conf.config = mma9553_set_bits(data->conf.config, 1,
>  					     MMA9553_MASK_CONF_ACT_DBCNTM);
> -	ret =
> -	    mma9551_write_config_words(data->client, MMA9551_APPID_PEDOMETER,
> -				       MMA9553_REG_CONF_SLEEPMIN,
> -				       sizeof(data->conf), (u16 *) &data->conf);
> +	ret = mma9551_write_config_words(data->client, MMA9551_APPID_PEDOMETER,
> +					 MMA9553_REG_CONF_SLEEPMIN,
> +					 sizeof(data->conf),
> +					 (u16 *)&data->conf);
>  	if (ret < 0) {
>  		dev_err(&data->client->dev,
>  			"failed to write configuration registers\n");
> @@ -791,7 +794,7 @@ static int mma9553_write_event_config(struct iio_dev *indio_dev,
>  
>  	mutex_unlock(&data->mutex);
>  
> -	return ret;
> +	return 0;
>  
>  err_conf_gpio:
>  	if (state) {
> @@ -896,7 +899,7 @@ static int mma9553_get_calibgender_mode(struct iio_dev *indio_dev,
>  	gender = mma9553_get_bits(data->conf.filter, MMA9553_MASK_CONF_MALE);
>  	/*
>  	 * HW expects 0 for female and 1 for male,
> -	 * while iio index is 0 for male and 1 for female
> +	 * while iio index is 0 for male and 1 for female.
>  	 */
>  	return !gender;
>  }
> @@ -943,11 +946,11 @@ static const struct iio_event_spec mma9553_activity_events[] = {
>  	},
>  };
>  
> -static const char * const calibgender_modes[] = { "male", "female" };
> +static const char * const mma9553_calibgender_modes[] = { "male", "female" };
>  
>  static const struct iio_enum mma9553_calibgender_enum = {
> -	.items = calibgender_modes,
> -	.num_items = ARRAY_SIZE(calibgender_modes),
> +	.items = mma9553_calibgender_modes,
> +	.num_items = ARRAY_SIZE(mma9553_calibgender_modes),
>  	.get = mma9553_get_calibgender_mode,
>  	.set = mma9553_set_calibgender_mode,
>  };
> @@ -1054,16 +1057,15 @@ static irqreturn_t mma9553_event_handler(int irq, void *private)
>  		return IRQ_HANDLED;
>  	}
>  
> -	ev_prev_activity =
> -	    mma9553_get_event(data, IIO_ACTIVITY,
> -			      mma9553_activity_to_mod(data->activity),
> -			      IIO_EV_DIR_FALLING);
> -	ev_activity =
> -	    mma9553_get_event(data, IIO_ACTIVITY,
> -			      mma9553_activity_to_mod(activity),
> -			      IIO_EV_DIR_RISING);
> -	ev_step_detect =
> -	    mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD, IIO_EV_DIR_NONE);
> +	ev_prev_activity = mma9553_get_event(data, IIO_ACTIVITY,
> +					     mma9553_activity_to_mod(
> +					     data->activity),
> +					     IIO_EV_DIR_FALLING);
> +	ev_activity = mma9553_get_event(data, IIO_ACTIVITY,
> +					mma9553_activity_to_mod(activity),
> +					IIO_EV_DIR_RISING);
> +	ev_step_detect = mma9553_get_event(data, IIO_STEPS, IIO_NO_MOD,
> +					   IIO_EV_DIR_NONE);
>  
>  	if (ev_step_detect->enabled && (stepcnt != data->stepcnt)) {
>  		data->stepcnt = stepcnt;
> @@ -1108,16 +1110,16 @@ static int mma9553_gpio_probe(struct i2c_client *client)
>  
>  	dev = &client->dev;
>  
> -	/* data ready gpio interrupt pin */
> +	/* data ready GPIO interrupt pin */
>  	gpio = devm_gpiod_get_index(dev, MMA9553_GPIO_NAME, 0, GPIOD_IN);
>  	if (IS_ERR(gpio)) {
> -		dev_err(dev, "acpi gpio get index failed\n");
> +		dev_err(dev, "ACPI GPIO get index failed\n");
>  		return PTR_ERR(gpio);
>  	}
>  
>  	ret = gpiod_to_irq(gpio);
>  
> -	dev_dbg(dev, "gpio resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
> +	dev_dbg(dev, "GPIO resource, no:%d irq:%d\n", desc_to_gpio(gpio), ret);
>  
>  	return ret;
>  }
> 

