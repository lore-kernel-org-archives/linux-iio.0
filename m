Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C571346AEEA;
	Tue, 11 Aug 2026 19:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786475501; cv=none; b=VHnozcqLh5b7GHzTyaj764vWS1dN/Ed3tdjHAofM7y7/iTHYSedD9a9+uQ7IQ5/3XVWEIJ/fAASwaWG2b+mJjbzybucIGorEZJ+1V+ShvXqwyKrxQiVL3M9PIg+Fw0FdFQekY2Fn03G6Yj4T2Eo12MCZO6hGx00YWHOsyGaztBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786475501; c=relaxed/simple;
	bh=bAjEsBO3u3UWD4KqQn+u/wbhY3lPTmIEpUekv7XUg7Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cHMcSFq9HXDzrluuzWKUrrxSiaJUH/7Q8hUxFsXRcSxbmRM3NOTMdYmcIECw1cdlGMCTEXccxKH/b2THOhYbSv6rIvFaYDHr52a7CSc0rQ2znC0bDQwsOvzFbAoYxvU9ZO/bp4bK7EycZzpIK1AKzRx+uFZM2hU1N2Kj9FVN2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=enkpMDkT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="enkpMDkT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED1371F000E9;
	Tue, 11 Aug 2026 19:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786475499;
	bh=RnWWikLNk0+7OXMQftDRskzGdA3W9xp7BArGYRUQaZ0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=enkpMDkT9dc+ozvK11IRb8z+kVPYSF80m1I8TkC78YbOXvUHwh+vmBM4KAl+DjBrY
	 NOJxEL2I+PPvs8vf2lWOJrpR+3jIKtTuu23kX/1dzD3fqwDijEgqjQLsKNz8BOI0OF
	 KuPHp/1Q2KDRoMR45X/FA6+M0taFc1XOUoX3BLQh6Cwv1I0CQigA3hTn7g3vULVRTz
	 3+5zAhRmXxYUPHltj0jtyPw6X1Amyg7TA9dhj6flRLnV+MNWk6pC/1g36wKFRQ8PIW
	 YwSFL6sCwv7h+Uv30i+0HxvKP/+u1jjZrmVnNV1FwkNAju58TmsjkUl7kIYNAPpahj
	 3wqnR2/ttic4A==
Date: Tue, 11 Aug 2026 20:11:32 +0100
From: Lee Jones <lee@kernel.org>
To: Svyatoslav Ryhel <clamor95@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>
Cc: Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>,
	Pavel Machek <pavel@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
	Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
	linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
	mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: Re: [PATCH v6 08/14] mfd: lm3533: Convert to use OF bindings
Message-ID: <20260811191132.GA1072730@google.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
 <20260731113632.158440-9-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260731113632.158440-9-clamor95@gmail.com>

Jonathan,

IIO ack please, mate.

> Since there are no users of this driver via platform data, remove the
> platform data support and switch to using Device Tree bindings.
> 
> Previously, all cell devices were linked to the parent device. This could
> cause problems further down the line because the LM3533 has multiple cells
> of the same type. Using a single phandle to the parent could cause
> confusion when attempting to reference or call the correct child node.
> Since this commit adds a dedicated node for every cell, remove linking of
> the cell to the parent node.
> 
> Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
> Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org> #for backlight
> ---
>  drivers/iio/light/lm3533-als.c      |  66 +++++---
>  drivers/leds/leds-lm3533.c          |  47 ++++--
>  drivers/mfd/lm3533-core.c           | 237 ++++++++++++----------------
>  drivers/mfd/lm3533-ctrlbank.c       |   5 -
>  drivers/video/backlight/lm3533_bl.c |  54 +++++--
>  include/linux/mfd/lm3533.h          |  52 +-----
>  6 files changed, 217 insertions(+), 244 deletions(-)
> 
> diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
> index 55c35018704c8..4870e8050088b 100644
> --- a/drivers/iio/light/lm3533-als.c
> +++ b/drivers/iio/light/lm3533-als.c
> @@ -17,15 +17,17 @@
>  #include <linux/mutex.h>
>  #include <linux/mfd/core.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/units.h>
>  
>  #include <linux/mfd/lm3533.h>
>  
>  
> -#define LM3533_ALS_RESISTOR_MIN			1
> -#define LM3533_ALS_RESISTOR_MAX			127
> +#define LM3533_ALS_RESISTOR_MIN_OHMS		1575
> +#define LM3533_ALS_RESISTOR_MAX_OHMS		200000
>  #define LM3533_ALS_CHANNEL_CURRENT_MAX		2
>  #define LM3533_ALS_THRESH_MAX			3
>  #define LM3533_ALS_ZONE_MAX			4
> @@ -57,6 +59,9 @@ struct lm3533_als {
>  
>  	atomic_t zone;
>  	struct mutex thresh_mutex;
> +
> +	u32 r_select;
> +	bool pwm_mode;
>  };
>  
>  
> @@ -403,7 +408,7 @@ static ssize_t show_thresh_either_en(struct device *dev,
>  	int enable;
>  	int ret;
>  
> -	if (als->irq) {
> +	if (als->irq > 0) {
>  		ret = lm3533_als_get_int_mode(indio_dev, &enable);
>  		if (ret)
>  			return ret;
> @@ -425,7 +430,7 @@ static ssize_t store_thresh_either_en(struct device *dev,
>  	u8 zone;
>  	int ret;
>  
> -	if (!als->irq)
> +	if (als->irq <= 0)
>  		return -EBUSY;
>  
>  	if (kstrtoul(buf, 0, &enable))
> @@ -708,29 +713,38 @@ static const struct attribute_group lm3533_als_attribute_group = {
>  	.attrs = lm3533_als_attributes
>  };
>  
> -static int lm3533_als_setup(struct lm3533_als *als,
> -			    const struct lm3533_als_platform_data *pdata)
> +static int lm3533_als_setup(struct lm3533_als *als)
>  {
>  	struct device *dev = &als->pdev->dev;
>  	int ret;
>  
> +	als->pwm_mode = device_property_read_bool(dev, "ti,pwm-mode");
> +
>  	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
> -				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
> +				 LM3533_ALS_INPUT_MODE_MASK, als->pwm_mode);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
> -				     pdata->pwm_mode);
> +				     als->pwm_mode);
>  
>  	/* ALS input is always high impedance in PWM-mode. */
> -	if (pdata->pwm_mode)
> +	if (als->pwm_mode)
>  		return 0;
>  
> -	if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
> -	    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
> +	ret = device_property_read_u32(dev, "ti,resistor-ohms",
> +				       &als->r_select);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to ger resistor value\n");
> +
> +	if (als->r_select < LM3533_ALS_RESISTOR_MIN_OHMS ||
> +	    als->r_select > LM3533_ALS_RESISTOR_MAX_OHMS)
>  		return dev_err_probe(dev, -EINVAL,
>  				     "invalid resistor value\n");
>  
> +	als->r_select = DIV_ROUND_UP(2 * MICRO, 10 * als->r_select);
> +
>  	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
> -			   pdata->r_select);
> +			   als->r_select);
>  	if (ret)
>  		return dev_err_probe(dev, ret, "failed to set resistor\n");
>  
> @@ -793,7 +807,6 @@ static const struct iio_info lm3533_als_info = {
>  
>  static int lm3533_als_probe(struct platform_device *pdev)
>  {
> -	const struct lm3533_als_platform_data *pdata;
>  	struct lm3533 *lm3533;
>  	struct lm3533_als *als;
>  	struct iio_dev *indio_dev;
> @@ -803,12 +816,6 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  	if (!lm3533)
>  		return -EINVAL;
>  
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*als));
>  	if (!indio_dev)
>  		return -ENOMEM;
> @@ -817,25 +824,27 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  	indio_dev->channels = lm3533_als_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(lm3533_als_channels);
>  	indio_dev->name = dev_name(&pdev->dev);
> -	iio_device_set_parent(indio_dev, pdev->dev.parent);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  
>  	als = iio_priv(indio_dev);
>  	als->regmap = lm3533->regmap;
>  	als->pdev = pdev;
> -	als->irq = lm3533->irq;
> +	als->irq = platform_get_irq_optional(pdev, 0);
> +	if (als->irq == -EPROBE_DEFER)
> +		return -EPROBE_DEFER;
> +
>  	atomic_set(&als->zone, 0);
>  	mutex_init(&als->thresh_mutex);
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	if (als->irq) {
> +	if (als->irq > 0) {
>  		ret = lm3533_als_setup_irq(als, indio_dev);
>  		if (ret)
>  			return ret;
>  	}
>  
> -	ret = lm3533_als_setup(als, pdata);
> +	ret = lm3533_als_setup(als);
>  	if (ret)
>  		goto err_free_irq;
>  
> @@ -854,7 +863,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
>  err_disable:
>  	lm3533_als_disable(als);
>  err_free_irq:
> -	if (als->irq)
> +	if (als->irq > 0)
>  		free_irq(als->irq, indio_dev);
>  
>  	return ret;
> @@ -868,13 +877,20 @@ static void lm3533_als_remove(struct platform_device *pdev)
>  	lm3533_als_set_int_mode(indio_dev, false);
>  	iio_device_unregister(indio_dev);
>  	lm3533_als_disable(als);
> -	if (als->irq)
> +	if (als->irq > 0)
>  		free_irq(als->irq, indio_dev);
>  }
>  
> +static const struct of_device_id lm3533_als_match_table[] = {
> +	{ .compatible = "ti,lm3533-als" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_als_match_table);
> +
>  static struct platform_driver lm3533_als_driver = {
>  	.driver	= {
>  		.name	= "lm3533-als",
> +		.of_match_table = lm3533_als_match_table,
>  	},
>  	.probe		= lm3533_als_probe,
>  	.remove		= lm3533_als_remove,
> diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
> index 0cb0585eb9600..7259097bd6a71 100644
> --- a/drivers/leds/leds-lm3533.c
> +++ b/drivers/leds/leds-lm3533.c
> @@ -12,6 +12,7 @@
>  #include <linux/mfd/core.h>
>  #include <linux/mutex.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
>  
> @@ -50,6 +51,9 @@ struct lm3533_led {
>  	struct mutex mutex;
>  	unsigned long flags;
>  
> +	u32 max_current;
> +	u32 pwm;
> +
>  	bool have_als;
>  };
>  
> @@ -616,22 +620,20 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
>  	NULL
>  };
>  
> -static int lm3533_led_setup(struct lm3533_led *led,
> -					struct lm3533_led_platform_data *pdata)
> +static int lm3533_led_setup(struct lm3533_led *led)
>  {
>  	int ret;
>  
> -	ret = lm3533_ctrlbank_set_max_current(&led->cb, pdata->max_current);
> +	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
>  	if (ret)
>  		return ret;
>  
> -	return lm3533_ctrlbank_set_pwm(&led->cb, pdata->pwm);
> +	return lm3533_ctrlbank_set_pwm(&led->cb, led->pwm);
>  }
>  
>  static int lm3533_led_probe(struct platform_device *pdev)
>  {
>  	struct lm3533 *lm3533;
> -	struct lm3533_led_platform_data *pdata;
>  	struct lm3533_led *led;
>  	int ret;
>  
> @@ -641,12 +643,6 @@ static int lm3533_led_probe(struct platform_device *pdev)
>  	if (!lm3533)
>  		return -EINVAL;
>  
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	if (pdev->id < 0 || pdev->id >= LM3533_LVCTRLBANK_COUNT) {
>  		dev_err(&pdev->dev, "illegal LED id %d\n", pdev->id);
>  		return -EINVAL;
> @@ -659,8 +655,6 @@ static int lm3533_led_probe(struct platform_device *pdev)
>  	led->regmap = lm3533->regmap;
>  	led->have_als = lm3533->have_als;
>  
> -	led->cdev.name = pdata->name;
> -	led->cdev.default_trigger = pdata->default_trigger;
>  	led->cdev.brightness_set_blocking = lm3533_led_set;
>  	led->cdev.brightness_get = lm3533_led_get;
>  	led->cdev.blink_set = lm3533_led_blink_set;
> @@ -668,6 +662,15 @@ static int lm3533_led_probe(struct platform_device *pdev)
>  	led->cdev.groups = lm3533_led_attribute_groups;
>  	led->id = pdev->id;
>  
> +	led->cdev.name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> +					pdev->name, led->id);
> +	if (!led->cdev.name)
> +		return -ENOMEM;
> +
> +	led->cdev.default_trigger = "none";
> +	device_property_read_string(&pdev->dev, "linux,default-trigger",
> +				    &led->cdev.default_trigger);
> +
>  	mutex_init(&led->mutex);
>  
>  	/* The class framework makes a callback to get brightness during
> @@ -680,7 +683,7 @@ static int lm3533_led_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, led);
>  
> -	ret = led_classdev_register(pdev->dev.parent, &led->cdev);
> +	ret = led_classdev_register(&pdev->dev, &led->cdev);
>  	if (ret) {
>  		dev_err(&pdev->dev, "failed to register LED %d\n", pdev->id);
>  		return ret;
> @@ -688,7 +691,14 @@ static int lm3533_led_probe(struct platform_device *pdev)
>  
>  	led->cb.dev = led->cdev.dev;
>  
> -	ret = lm3533_led_setup(led, pdata);
> +	device_property_read_u32(&pdev->dev, "led-max-microamp",
> +				 &led->max_current);
> +	led->max_current = clamp(led->max_current, LM3533_MAX_CURRENT_MIN,
> +				 LM3533_MAX_CURRENT_MAX);
> +
> +	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
> +
> +	ret = lm3533_led_setup(led);
>  	if (ret)
>  		goto err_deregister;
>  
> @@ -725,9 +735,16 @@ static void lm3533_led_shutdown(struct platform_device *pdev)
>  	lm3533_led_set(&led->cdev, LED_OFF);		/* disable blink */
>  }
>  
> +static const struct of_device_id lm3533_led_match_table[] = {
> +	{ .compatible = "ti,lm3533-leds" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_led_match_table);
> +
>  static struct platform_driver lm3533_led_driver = {
>  	.driver = {
>  		.name = "lm3533-leds",
> +		.of_match_table = lm3533_led_match_table,
>  	},
>  	.probe		= lm3533_led_probe,
>  	.remove		= lm3533_led_remove,
> diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
> index 53b87958c2c68..c7c7e71719ae0 100644
> --- a/drivers/mfd/lm3533-core.c
> +++ b/drivers/mfd/lm3533-core.c
> @@ -15,16 +15,23 @@
>  #include <linux/gpio/consumer.h>
>  #include <linux/i2c.h>
>  #include <linux/mfd/core.h>
> +#include <linux/property.h>
>  #include <linux/regmap.h>
>  #include <linux/seq_file.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/units.h>
>  
>  #include <linux/mfd/lm3533.h>
>  
>  
>  #define LM3533_BOOST_OVP_MASK		0x06
> +#define LM3533_BOOST_OVP_MIN		(16 * MICRO)
> +#define LM3533_BOOST_OVP_MAX		(40 * MICRO)
> +
>  #define LM3533_BOOST_FREQ_MASK		0x01
> +#define LM3533_BOOST_FREQ_MIN		(500 * HZ_PER_KHZ)
> +#define LM3533_BOOST_FREQ_MAX		(1000 * HZ_PER_KHZ)
>  
>  #define LM3533_BL_ID_MASK		1
>  #define LM3533_LED_ID_MASK		3
> @@ -33,6 +40,7 @@
>  
>  #define LM3533_HVLED_ID_MAX		2
>  #define LM3533_LVLED_ID_MAX		5
> +#define LM3533_CELLS_MAX		7
>  
>  #define LM3533_REG_OUTPUT_CONF1		0x10
>  #define LM3533_REG_OUTPUT_CONF2		0x11
> @@ -40,44 +48,6 @@
>  
>  #define LM3533_REG_MAX			0xb2
>  
> -
> -static struct mfd_cell lm3533_als_devs[] = {
> -	{
> -		.name	= "lm3533-als",
> -		.id	= -1,
> -	},
> -};
> -
> -static struct mfd_cell lm3533_bl_devs[] = {
> -	{
> -		.name	= "lm3533-backlight",
> -		.id	= 0,
> -	},
> -	{
> -		.name	= "lm3533-backlight",
> -		.id	= 1,
> -	},
> -};
> -
> -static struct mfd_cell lm3533_led_devs[] = {
> -	{
> -		.name	= "lm3533-leds",
> -		.id	= 0,
> -	},
> -	{
> -		.name	= "lm3533-leds",
> -		.id	= 1,
> -	},
> -	{
> -		.name	= "lm3533-leds",
> -		.id	= 2,
> -	},
> -	{
> -		.name	= "lm3533-leds",
> -		.id	= 3,
> -	},
> -};
> -
>  /*
>   * HVLED output config -- output hvled controlled by backlight bl
>   */
> @@ -299,125 +269,92 @@ static const struct attribute_group *lm3533_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static int lm3533_device_als_init(struct lm3533 *lm3533)
> -{
> -	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> -	int ret;
> -
> -	if (!pdata->als)
> -		return 0;
> -
> -	lm3533_als_devs[0].platform_data = pdata->als;
> -	lm3533_als_devs[0].pdata_size = sizeof(*pdata->als);
> -
> -	ret = mfd_add_devices(lm3533->dev, 0, lm3533_als_devs, 1, NULL,
> -			      0, NULL);
> -	if (ret) {
> -		dev_err(lm3533->dev, "failed to add ALS device\n");
> -		return ret;
> -	}
> -
> -	lm3533->have_als = 1;
> -
> -	return 0;
> -}
> -
> -static int lm3533_device_bl_init(struct lm3533 *lm3533)
> -{
> -	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> -	int i;
> -	int ret;
> -
> -	if (!pdata->backlights || pdata->num_backlights == 0)
> -		return 0;
> -
> -	if (pdata->num_backlights > ARRAY_SIZE(lm3533_bl_devs))
> -		pdata->num_backlights = ARRAY_SIZE(lm3533_bl_devs);
> -
> -	for (i = 0; i < pdata->num_backlights; ++i) {
> -		lm3533_bl_devs[i].platform_data = &pdata->backlights[i];
> -		lm3533_bl_devs[i].pdata_size = sizeof(pdata->backlights[i]);
> -	}
> -
> -	ret = mfd_add_devices(lm3533->dev, 0, lm3533_bl_devs,
> -			      pdata->num_backlights, NULL, 0, NULL);
> -	if (ret) {
> -		dev_err(lm3533->dev, "failed to add backlight devices\n");
> -		return ret;
> -	}
> -
> -	lm3533->have_backlights = 1;
> -
> -	return 0;
> -}
> -
> -static int lm3533_device_led_init(struct lm3533 *lm3533)
> -{
> -	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> -	int i;
> -	int ret;
> -
> -	if (!pdata->leds || pdata->num_leds == 0)
> -		return 0;
> -
> -	if (pdata->num_leds > ARRAY_SIZE(lm3533_led_devs))
> -		pdata->num_leds = ARRAY_SIZE(lm3533_led_devs);
> -
> -	for (i = 0; i < pdata->num_leds; ++i) {
> -		lm3533_led_devs[i].platform_data = &pdata->leds[i];
> -		lm3533_led_devs[i].pdata_size = sizeof(pdata->leds[i]);
> -	}
> -
> -	ret = mfd_add_devices(lm3533->dev, 0, lm3533_led_devs,
> -			      pdata->num_leds, NULL, 0, NULL);
> -	if (ret) {
> -		dev_err(lm3533->dev, "failed to add LED devices\n");
> -		return ret;
> -	}
> -
> -	lm3533->have_leds = 1;
> -
> -	return 0;
> -}
> -
>  static int lm3533_device_init(struct lm3533 *lm3533)
>  {
> -	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
> +	struct device *dev = lm3533->dev;
> +	struct mfd_cell *lm3533_devices;
> +	u32 reg, nchilds;
> +	u32 count = 0;
>  	int ret;
>  
> -	dev_dbg(lm3533->dev, "%s\n", __func__);
> +	nchilds = device_get_child_node_count(dev);
> +	if (!nchilds || nchilds > LM3533_CELLS_MAX)
> +		return dev_err_probe(dev, -ENODEV,
> +				     "num of child nodes is not supported\n");
>  
> -	if (!pdata) {
> -		dev_err(lm3533->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> +	lm3533_devices = devm_kcalloc(dev, nchilds, sizeof(*lm3533_devices),
> +				      GFP_KERNEL);
> +	if (!lm3533_devices)
> +		return -ENOMEM;
>  
> -	lm3533->hwen = devm_gpiod_get(lm3533->dev, NULL, GPIOD_OUT_LOW);
> -	if (IS_ERR(lm3533->hwen))
> -		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen), "failed to request HWEN GPIO\n");
> -	gpiod_set_consumer_name(lm3533->hwen, "lm3533-hwen");
> +	device_for_each_child_node_scoped(dev, child) {
> +		if (count >= nchilds)
> +			break;
> +
> +		if (fwnode_device_is_compatible(child, "ti,lm3533-als")) {
> +			lm3533_devices[count].name = "lm3533-als";
> +			lm3533_devices[count].of_compatible = "ti,lm3533-als";
> +			lm3533_devices[count].id = PLATFORM_DEVID_NONE;
> +
> +			lm3533->have_als = true;
> +			count++;
> +		} else if (fwnode_device_is_compatible(child, "ti,lm3533-backlight")) {
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
> +			if (ret || reg >= LM3533_HVLED_ID_MAX) {
> +				dev_err(dev, "invalid backlight node %pfw\n", child);
> +				continue;
> +			}
> +
> +			lm3533_devices[count].name = "lm3533-backlight";
> +			lm3533_devices[count].of_compatible = "ti,lm3533-backlight";
> +			lm3533_devices[count].id = reg;
> +			lm3533_devices[count].of_reg = reg;
> +			lm3533_devices[count].use_of_reg = true;
> +
> +			lm3533->have_backlights = true;
> +			count++;
> +		} else if (fwnode_device_is_compatible(child, "ti,lm3533-leds")) {
> +			ret = fwnode_property_read_u32(child, "reg", &reg);
> +			if (ret || reg < LM3533_HVLED_ID_MAX ||
> +			    reg > LM3533_LVLED_ID_MAX) {
> +				dev_err(dev, "invalid LED node %pfw\n", child);
> +				continue;
> +			}
> +
> +			lm3533_devices[count].name = "lm3533-leds";
> +			lm3533_devices[count].of_compatible = "ti,lm3533-leds";
> +			lm3533_devices[count].id = reg - LM3533_HVLED_ID_MAX;
> +			lm3533_devices[count].of_reg = reg;
> +			lm3533_devices[count].use_of_reg = true;
> +
> +			lm3533->have_leds = true;
> +			count++;
> +		}
> +	}
>  
>  	lm3533_enable(lm3533);
>  
>  	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
>  				 LM3533_BOOST_FREQ_MASK,
> -				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata->boost_freq));
> +				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, lm3533->boost_freq));
>  	if (ret) {
> -		dev_err(lm3533->dev, "failed to set boost frequency\n");
> +		dev_err(dev, "failed to set boost frequency\n");
>  		goto err_disable;
>  	}
>  
>  	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
>  				 LM3533_BOOST_OVP_MASK,
> -				 FIELD_PREP(LM3533_BOOST_OVP_MASK, pdata->boost_ovp));
> +				 FIELD_PREP(LM3533_BOOST_OVP_MASK, lm3533->boost_ovp));
>  	if (ret) {
> -		dev_err(lm3533->dev, "failed to set boost ovp\n");
> +		dev_err(dev, "failed to set boost ovp\n");
>  		goto err_disable;
>  	}
>  
> -	lm3533_device_als_init(lm3533);
> -	lm3533_device_bl_init(lm3533);
> -	lm3533_device_led_init(lm3533);
> +	ret = mfd_add_devices(dev, 0, lm3533_devices, count, NULL, 0, NULL);
> +	if (ret) {
> +		dev_err(dev, "failed to add MFD devices: %d\n", ret);
> +		goto err_disable;
> +	}
>  
>  	return 0;
>  
> @@ -502,7 +439,26 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
>  		return PTR_ERR(lm3533->regmap);
>  
>  	lm3533->dev = &i2c->dev;
> -	lm3533->irq = i2c->irq;
> +
> +	lm3533->hwen = devm_gpiod_get_optional(lm3533->dev, "enable",
> +					       GPIOD_OUT_LOW);
> +	if (IS_ERR(lm3533->hwen))
> +		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
> +				     "failed to get HWEN GPIO\n");
> +
> +	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
> +				 &lm3533->boost_ovp);
> +
> +	lm3533->boost_ovp = clamp(lm3533->boost_ovp, LM3533_BOOST_OVP_MIN,
> +				  LM3533_BOOST_OVP_MAX);
> +	lm3533->boost_ovp = lm3533->boost_ovp / (8 * MICRO) - 2;
> +
> +	device_property_read_u32(lm3533->dev, "ti,boost-freq-hz",
> +				 &lm3533->boost_freq);
> +
> +	lm3533->boost_freq = clamp(lm3533->boost_freq, LM3533_BOOST_FREQ_MIN,
> +				   LM3533_BOOST_FREQ_MAX);
> +	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
>  
>  	return lm3533_device_init(lm3533);
>  }
> @@ -516,6 +472,12 @@ static void lm3533_i2c_remove(struct i2c_client *i2c)
>  	lm3533_device_exit(lm3533);
>  }
>  
> +static const struct of_device_id lm3533_match_table[] = {
> +	{ .compatible = "ti,lm3533" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_match_table);
> +
>  static const struct i2c_device_id lm3533_i2c_ids[] = {
>  	{ "lm3533" },
>  	{ }
> @@ -526,6 +488,7 @@ static struct i2c_driver lm3533_i2c_driver = {
>  	.driver = {
>  		   .name = "lm3533",
>  		   .dev_groups = lm3533_attribute_groups,
> +		   .of_match_table = lm3533_match_table,
>  	},
>  	.id_table	= lm3533_i2c_ids,
>  	.probe		= lm3533_i2c_probe,
> diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
> index 91e13cfa3cf04..3aab8ece4e8cb 100644
> --- a/drivers/mfd/lm3533-ctrlbank.c
> +++ b/drivers/mfd/lm3533-ctrlbank.c
> @@ -13,11 +13,6 @@
>  
>  #include <linux/mfd/lm3533.h>
>  
> -
> -#define LM3533_MAX_CURRENT_MIN		5000
> -#define LM3533_MAX_CURRENT_MAX		29800
> -#define LM3533_MAX_CURRENT_STEP		800
> -
>  #define LM3533_PWM_MAX			0x3f
>  
>  #define LM3533_REG_PWM_BASE		0x14
> diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
> index 9ef171d3aaeab..5ce237cb42190 100644
> --- a/drivers/video/backlight/lm3533_bl.c
> +++ b/drivers/video/backlight/lm3533_bl.c
> @@ -10,6 +10,7 @@
>  #include <linux/module.h>
>  #include <linux/init.h>
>  #include <linux/platform_device.h>
> +#include <linux/property.h>
>  #include <linux/backlight.h>
>  #include <linux/regmap.h>
>  #include <linux/slab.h>
> @@ -29,6 +30,9 @@ struct lm3533_bl {
>  	struct backlight_device *bd;
>  	int id;
>  
> +	u32 max_current;
> +	u32 pwm;
> +
>  	bool have_als;
>  };
>  
> @@ -242,25 +246,25 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
>  	NULL,
>  };
>  
> -static int lm3533_bl_setup(struct lm3533_bl *bl,
> -					struct lm3533_bl_platform_data *pdata)
> +static int lm3533_bl_setup(struct lm3533_bl *bl)
>  {
>  	int ret;
>  
> -	ret = lm3533_ctrlbank_set_max_current(&bl->cb, pdata->max_current);
> +	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
>  	if (ret)
>  		return ret;
>  
> -	return lm3533_ctrlbank_set_pwm(&bl->cb, pdata->pwm);
> +	return lm3533_ctrlbank_set_pwm(&bl->cb, bl->pwm);
>  }
>  
>  static int lm3533_bl_probe(struct platform_device *pdev)
>  {
>  	struct lm3533 *lm3533;
> -	struct lm3533_bl_platform_data *pdata;
>  	struct lm3533_bl *bl;
>  	struct backlight_device *bd;
>  	struct backlight_properties props;
> +	char *name = NULL;
> +	u32 default_brightness = LM3533_BL_MAX_BRIGHTNESS;
>  	int ret;
>  
>  	dev_dbg(&pdev->dev, "%s\n", __func__);
> @@ -269,12 +273,6 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>  	if (!lm3533)
>  		return -EINVAL;
>  
> -	pdata = dev_get_platdata(&pdev->dev);
> -	if (!pdata) {
> -		dev_err(&pdev->dev, "no platform data\n");
> -		return -EINVAL;
> -	}
> -
>  	if (pdev->id < 0 || pdev->id >= LM3533_HVCTRLBANK_COUNT) {
>  		dev_err(&pdev->dev, "illegal backlight id %d\n", pdev->id);
>  		return -EINVAL;
> @@ -292,13 +290,21 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>  	bl->cb.id = lm3533_bl_get_ctrlbank_id(bl);
>  	bl->cb.dev = NULL;			/* until registered */
>  
> +	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-%d",
> +			      pdev->name, pdev->id);
> +	if (!name)
> +		return -ENOMEM;
> +
> +	device_property_read_u32(&pdev->dev, "default-brightness",
> +				 &default_brightness);
> +
>  	memset(&props, 0, sizeof(props));
>  	props.type = BACKLIGHT_RAW;
>  	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
> -	props.brightness = pdata->default_brightness;
> -	bd = devm_backlight_device_register(&pdev->dev, pdata->name,
> -					pdev->dev.parent, bl, &lm3533_bl_ops,
> -					&props);
> +	props.brightness = default_brightness;
> +
> +	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
> +					    bl, &lm3533_bl_ops, &props);
>  	if (IS_ERR(bd)) {
>  		dev_err(&pdev->dev, "failed to register backlight device\n");
>  		return PTR_ERR(bd);
> @@ -309,12 +315,19 @@ static int lm3533_bl_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, bl);
>  
> -	backlight_update_status(bd);
> +	device_property_read_u32(&pdev->dev, "led-max-microamp",
> +				 &bl->max_current);
> +	bl->max_current = clamp(bl->max_current, LM3533_MAX_CURRENT_MIN,
> +				LM3533_MAX_CURRENT_MAX);
>  
> -	ret = lm3533_bl_setup(bl, pdata);
> +	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
> +
> +	ret = lm3533_bl_setup(bl);
>  	if (ret)
>  		return ret;
>  
> +	backlight_update_status(bd);
> +
>  	ret = lm3533_ctrlbank_enable(&bl->cb);
>  	if (ret)
>  		return ret;
> @@ -366,11 +379,18 @@ static void lm3533_bl_shutdown(struct platform_device *pdev)
>  	lm3533_ctrlbank_disable(&bl->cb);
>  }
>  
> +static const struct of_device_id lm3533_bl_match_table[] = {
> +	{ .compatible = "ti,lm3533-backlight" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lm3533_bl_match_table);
> +
>  static struct platform_driver lm3533_bl_driver = {
>  	.driver = {
>  		.name	= "lm3533-backlight",
>  		.pm	= &lm3533_bl_pm_ops,
>  		.dev_groups = lm3533_bl_attribute_groups,
> +		.of_match_table = lm3533_bl_match_table,
>  	},
>  	.probe		= lm3533_bl_probe,
>  	.remove		= lm3533_bl_remove,
> diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
> index 74cfb52c3bd17..5710e88da45d2 100644
> --- a/include/linux/mfd/lm3533.h
> +++ b/include/linux/mfd/lm3533.h
> @@ -15,6 +15,10 @@
>  #define LM3533_ATTR_RW(_name) \
>  	DEVICE_ATTR(_name, S_IRUGO | S_IWUSR , show_##_name, store_##_name)
>  
> +#define LM3533_MAX_CURRENT_MIN		5000
> +#define LM3533_MAX_CURRENT_MAX		29800
> +#define LM3533_MAX_CURRENT_STEP		800
> +
>  struct device;
>  struct gpio_desc;
>  struct regmap;
> @@ -25,7 +29,9 @@ struct lm3533 {
>  	struct regmap *regmap;
>  
>  	struct gpio_desc *hwen;
> -	int irq;
> +
> +	u32 boost_ovp;
> +	u32 boost_freq;
>  
>  	unsigned have_als:1;
>  	unsigned have_backlights:1;
> @@ -38,50 +44,6 @@ struct lm3533_ctrlbank {
>  	int id;
>  };
>  
> -struct lm3533_als_platform_data {
> -	unsigned pwm_mode:1;		/* PWM input mode (default analog) */
> -	u8 r_select;			/* 1 - 127 (ignored in PWM-mode) */
> -};
> -
> -struct lm3533_bl_platform_data {
> -	char *name;
> -	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
> -	u8 default_brightness;		/* 0 - 255 */
> -	u8 pwm;				/* 0 - 0x3f */
> -};
> -
> -struct lm3533_led_platform_data {
> -	char *name;
> -	const char *default_trigger;
> -	u16 max_current;		/* 5000 - 29800 uA (800 uA step) */
> -	u8 pwm;				/* 0 - 0x3f */
> -};
> -
> -enum lm3533_boost_freq {
> -	LM3533_BOOST_FREQ_500KHZ,
> -	LM3533_BOOST_FREQ_1000KHZ,
> -};
> -
> -enum lm3533_boost_ovp {
> -	LM3533_BOOST_OVP_16V,
> -	LM3533_BOOST_OVP_24V,
> -	LM3533_BOOST_OVP_32V,
> -	LM3533_BOOST_OVP_40V,
> -};
> -
> -struct lm3533_platform_data {
> -	enum lm3533_boost_ovp boost_ovp;
> -	enum lm3533_boost_freq boost_freq;
> -
> -	struct lm3533_als_platform_data *als;
> -
> -	struct lm3533_bl_platform_data *backlights;
> -	int num_backlights;
> -
> -	struct lm3533_led_platform_data *leds;
> -	int num_leds;
> -};
> -
>  int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb);
>  int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb);
>  
> -- 
> 2.53.0
> 
> 

-- 
Lee Jones
