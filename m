Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:42547 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbbDZSsa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 26 Apr 2015 14:48:30 -0400
Message-ID: <553D32FC.7080307@kernel.org>
Date: Sun, 26 Apr 2015 19:48:28 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Irina Tirdea <irina.tirdea@intel.com>, linux-iio@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>
CC: linux-kernel@vger.kernel.org, Vlad Dogaru <vlad.dogaru@intel.com>
Subject: Re: [PATCH v2 09/17] iio: accel: mma9553: comment and error message
 fixes
References: <1428939664-12503-1-git-send-email-irina.tirdea@intel.com> <1428939664-12503-10-git-send-email-irina.tirdea@intel.com>
In-Reply-To: <1428939664-12503-10-git-send-email-irina.tirdea@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 13/04/15 16:40, Irina Tirdea wrote:
> Use "GPIO" instead of "gpio" and "ACPI" instead of "acpi".
> 
> Includes a couple of small style fixes in comments
> (missing full stop, whitespace, paranthesis).
> 
> Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
> Suggested-by: Hartmut Knaack <knaack.h@gmx.de>
Applied to the togreg branch of iio.git

Thanks.

J
> ---
>  drivers/iio/accel/mma9553.c | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/iio/accel/mma9553.c b/drivers/iio/accel/mma9553.c
> index 0f30006..a6b74de 100644
> --- a/drivers/iio/accel/mma9553.c
> +++ b/drivers/iio/accel/mma9553.c
> @@ -76,14 +76,14 @@
>  #define MMA9553_DEFAULT_GPIO_PIN	mma9551_gpio6
>  #define MMA9553_DEFAULT_GPIO_POLARITY	0
>  
> -/* Bitnum used for gpio configuration = bit number in high status byte */
>  #define STATUS_TO_BITNUM(bit)		(ffs(bit) - 9)
> +/* Bitnum used for GPIO configuration = bit number in high status byte */
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
> @@ -399,13 +399,13 @@ static int mma9553_init(struct mma9553_data *data)
>  				      sizeof(data->conf), (u16 *) &data->conf);
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
> @@ -457,7 +457,8 @@ static int mma9553_read_raw(struct iio_dev *indio_dev,
>  			 * The HW only counts steps and other dependent
>  			 * parameters (speed, distance, calories, activity)
>  			 * if power is on (from enabling an event or the
> -			 * step counter */
> +			 * step counter).
> +			 */
>  			powered_on =
>  			    mma9553_is_any_event_enabled(data, false, 0) ||
>  			    data->stepcnt_enabled;
> @@ -900,7 +901,7 @@ static int mma9553_get_calibgender_mode(struct iio_dev *indio_dev,
>  	gender = mma9553_get_bits(data->conf.filter, MMA9553_MASK_CONF_MALE);
>  	/*
>  	 * HW expects 0 for female and 1 for male,
> -	 * while iio index is 0 for male and 1 for female
> +	 * while iio index is 0 for male and 1 for female.
>  	 */
>  	return !gender;
>  }
> @@ -1113,16 +1114,16 @@ static int mma9553_gpio_probe(struct i2c_client *client)
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

