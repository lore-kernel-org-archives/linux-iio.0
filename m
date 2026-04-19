Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7733335AC0C;
	Sun, 19 Apr 2026 12:00:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776600021; cv=none; b=mt1j9HDfTYI4h/iMlSlUV5Yy4ClLN5excR64Eze+MbNicvZECv1/F/5U0cwfJG1rM9RWLlx5cSmHy75ZIoUY2CIUSRoSb2R0enKo0D/KvVhnnm1cnJ3p+DM0gGoXM4vgQuOqmomxX+GroOLo27qAchYZvjWyjD5XVcHlUYH3rH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776600021; c=relaxed/simple;
	bh=zxsJgrVTxbmyOlPjEIk6TXBgPG1U0IXA/gRE2ImqV4A=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JL8ZFflJxqHs09y5OKw2NcZRCcUAfvVDWlEON72dOwg/3Ojmrc6lK22LyVHUSTvI3x7bF616D2s3auZcJ7eDKlRcv2PoIIOcFAhc7HSSJekXMvkkGLQyUcSbvBgQsospRx4m/EvUiaeqENeyPGxNXKYl2tvg5Q4gQArcmv3PlfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CptTnozj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CptTnozj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A18C0C2BCB3;
	Sun, 19 Apr 2026 12:00:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776600021;
	bh=zxsJgrVTxbmyOlPjEIk6TXBgPG1U0IXA/gRE2ImqV4A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CptTnozjFpWHwdTVBKG0SUMVwXiU18rRRokpSPluGciHNfSKuHg8LK1X2JwYf+ItA
	 MMsllBeqE4OdQTr71WEIomDzAWcpF+5wSyeB6aUjmnXhuLh9lDXWw0u3HmGUHJVRNN
	 KdA0obM3DmDuiFEtRzfHWue3LbvVRZXGyZBK+A4WTd1EDz6r96q/HMy3smO4K2+4Hh
	 IdXNQ9JZcDXhL6qM3oxwaRjhMm5GlTy4jH9mcDmWtWXHGTRQ3HTTSmItPQKEvYYrwv
	 pYam1yLy0loIzfRh5OK8QZBlQqspVQXCRl92EXB9IkwBMO4yP2g34jA+0OLSeJlc8w
	 23oxegagEnyrA==
Date: Sun, 19 Apr 2026 13:00:12 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] iio: adc: hx711: add support for HX710B
Message-ID: <20260419130012.42b87ad4@jic23-huawei>
In-Reply-To: <20260418170610.312523-1-piyushpatle228@gmail.com>
References: <20260418170610.312523-1-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 18 Apr 2026 22:36:00 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Refactor the driver around per-chip configuration so HX711 and HX710B
> can share the same core.
> 
> Add HX710B channel definitions, pulse-count based channel selection, a
> variant-specific iio_info, and fixed-scale handling at probe. Update the
> Kconfig text and trim comments so the added support stays focused on the
> actual driver behavior.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>

Various comments inline. Many of which probably overlap with David's
review.

Jonathan

> ---
>  drivers/iio/adc/Kconfig |   9 +-
>  drivers/iio/adc/hx711.c | 222 ++++++++++++++++++++++++++++++++--------
>  2 files changed, 184 insertions(+), 47 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 60038ae8dfc4..ddf981fa72a2 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -784,18 +784,21 @@ config HI8435
>  	  called hi8435.
>  
>  config HX711
> -	tristate "AVIA HX711 ADC for weight cells"
> +	tristate "AVIA HX711 and HX710B ADC"
>  	depends on GPIOLIB
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> -	  If you say yes here you get support for AVIA HX711 ADC which is used
> -	  for weigh cells
> +	  If you say yes here you get support for AVIA HX711 and HX710B ADCs
> +	  which are used for bridge sensors such as weigh cells.
>  
>  	  This driver uses two GPIOs, one acts as the clock and controls the
>  	  channel selection and gain, the other one is used for the measurement
>  	  data
>  
> +	  The HX710B is a variant with fixed gain and a different channel
> +	  selection scheme.
> +
>  	  Currently the raw value is read from the chip and delivered.
>  	  To get an actual weight one needs to subtract the
>  	  zero offset and multiply by a scale factor.
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 1db8b68a8f64..cd251fa9f6b7 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-or-later
>  /*
> - * HX711: analog to digital converter for weight sensor module
> + * HX711/HX710B ADC driver

I'd keep the extra info that it's for weight sensors.


>   *
>   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>   */
> @@ -76,13 +76,34 @@ static int hx711_get_scale_to_gain(int scale)
>  	return -EINVAL;
>  }
>  
> +/**
> + * struct hx711_chip_info - per-variant static configuration
> + * @name: IIO device name
> + * @channels: channel specification
> + * @num_channels: number of channels
> + * @chan_pulse_count: trailing pulse count for fixed-gain variants
> + * @num_chan_pulses: number of pulse-count entries
> + * @reset_channel: default channel after reset
> + */
> +struct hx711_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels;
> +	int				num_channels;
> +	const int			*chan_pulse_count;
> +	int				num_chan_pulses;
> +	int				reset_channel;
Various comments inline about probably adding more field rather than
relying on chan_pulse_count for things that aren't immediately obviously
related to that.

> +};
> +
>  struct hx711_data {
> -	struct device		*dev;
> -	struct gpio_desc	*gpiod_pd_sck;
> -	struct gpio_desc	*gpiod_dout;
> -	int			gain_set;	/* gain set on device */
> -	int			gain_chan_a;	/* gain for channel A */
> -	struct mutex		lock;
> +	struct device			*dev;
> +	struct gpio_desc		*gpiod_pd_sck;
> +	struct gpio_desc		*gpiod_dout;
> +	int				gain_set;	/* HX711 */
> +	int				gain_chan_a;	/* HX711 channel A gain */
> +	int				channel_set;	/* HX710B */
> +	int				scale;		/* HX710B scale */
> +	const struct hx711_chip_info	*chip_info;
The indentation change is a lot of noise.  I'd just not bother doing it.
Just have chip_info as the one thing more indented.

My personal preference is never do careful alignment for structure members anyway
as it leads to churn like this when a future patch 'needs' to change it.

> +	struct mutex			lock;
>  	/*
>  	 * triggered buffer
>  	 * 2x32-bit channel + 64-bit naturally aligned timestamp
> @@ -92,13 +113,10 @@ struct hx711_data {
>  		aligned_s64 timestamp;
>  	} buffer;
>  	/*
> -	 * delay after a rising edge on SCK until the data is ready DOUT
> -	 * this is dependent on the hx711 where the datasheet tells a
> -	 * maximum value of 100 ns
> -	 * but also on potential parasitic capacities on the wiring
> +	 * Delay after SCK rising edge before sampling DOUT.
>  	 */
> -	u32			data_ready_delay_ns;
> -	u32			clock_frequency;
> +	u32				data_ready_delay_ns;
> +	u32				clock_frequency;
>  };

>  
>  static int hx711_read_raw(struct iio_dev *indio_dev,
> @@ -274,6 +328,7 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  				int *val, int *val2, long mask)
>  {
>  	struct hx711_data *hx711_data = iio_priv(indio_dev);
> +	const struct hx711_chip_info *info = hx711_data->chip_info;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -290,7 +345,10 @@ static int hx711_read_raw(struct iio_dev *indio_dev,
>  		*val = 0;
>  		mutex_lock(&hx711_data->lock);
>  
> -		*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
> +		if (info->chan_pulse_count)

I'd prefer a more obvious bool to use for this.
info->fixed_scale or something like that?

> +			*val2 = hx711_data->scale;
> +		else
> +			*val2 = hx711_get_gain_to_scale(hx711_data->gain_set);
>  
>  		mutex_unlock(&hx711_data->lock);
>  
> @@ -332,7 +390,8 @@ static int hx711_write_raw(struct iio_dev *indio_dev,
>  			if (gain != 32)
>  				hx711_data->gain_chan_a = gain;
>  
> -			ret = hx711_read(hx711_data);
> +			ret = hx711_read(hx711_data,
> +					 hx711_get_gain_to_pulse(hx711_data->gain_set));
>  			if (ret < 0) {
>  				mutex_unlock(&hx711_data->lock);
>  				return ret;
> @@ -423,6 +482,10 @@ static const struct iio_info hx711_iio_info = {
>  	.attrs			= &hx711_attribute_group,
>  };

> +/*
> + * HX710B trailing pulse counts.
> + * 25 selects differential input, 26 selects DVDD-AVDD.
> + */
> +static const int hx710b_pulse_counts[] = {
> +	25,	/* channel 0: differential input, 10 SPS */
> +	26,	/* channel 1: DVDD-AVDD voltage,   40 SPS */
Odd spacing in the comments.

> +};
> +
> +static const struct hx711_chip_info hx711_chip = {
> +	.name			= "hx711",
> +	.channels		= hx711_chan_spec,
> +	.num_channels		= ARRAY_SIZE(hx711_chan_spec),
> +	.chan_pulse_count	= NULL,

That will be the 'natural' default if you don't set it.  I'm not
sure explicitly setting it to NULL is providing useful documentation
so perhaps just let the C spec stuff ensure it is null.

> +};
> +
> +static const struct hx711_chip_info hx710b_chip = {
> +	.name			= "hx710b",
> +	.channels		= hx710b_chan_spec,
> +	.num_channels		= ARRAY_SIZE(hx710b_chan_spec),
> +	.chan_pulse_count	= hx710b_pulse_counts,
> +	.num_chan_pulses	= ARRAY_SIZE(hx710b_pulse_counts),
> +	.reset_channel		= 0,

Given this is only set in this instance and is 0, what benefit is
it bringing?

> +};
> +
>  static int hx711_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct hx711_data *hx711_data;
> +	const struct hx711_chip_info *chip_info;
>  	struct iio_dev *indio_dev;
>  	int ret;
>  	int i;
> @@ -472,6 +594,11 @@ static int hx711_probe(struct platform_device *pdev)
>  
>  	mutex_init(&hx711_data->lock);
>  
> +	chip_info = device_get_match_data(dev);

We've had some recent discussions around concluded there is little point in
sanity checking something that would be such an obvious bug in a driver.
So for new code at least, don't add this check so we get slightly simpler code.

> +	if (!chip_info)
> +		return -ENODEV;
> +	hx711_data->chip_info = chip_info;
> +
>  	/*
>  	 * PD_SCK stands for power down and serial clock input of HX711
>  	 * in the driver it is an output
> @@ -510,12 +637,20 @@ static int hx711_probe(struct platform_device *pdev)
>  	/* we need 10^-9 mV */
>  	ret *= 100;
>  
> -	for (i = 0; i < HX711_GAIN_MAX; i++)
> -		hx711_gain_to_scale[i].scale =
> -			ret / hx711_gain_to_scale[i].gain / 1678;
> +	if (chip_info->chan_pulse_count) {
> +		/* HX710B uses a fixed gain, so compute scale once at probe. */

Have a flag in chip_info for fixed gain and probably put these value in
chip_info as well.

> +		hx711_data->scale = ret / 128 / 1678;
> +		hx711_data->channel_set = chip_info->reset_channel;
> +		indio_dev->info = &hx710b_iio_info;
> +	} else {
> +		for (i = 0; i < HX711_GAIN_MAX; i++)
> +			hx711_gain_to_scale[i].scale =
> +				ret / hx711_gain_to_scale[i].gain / 1678;
>  
> -	hx711_data->gain_set = 128;
> -	hx711_data->gain_chan_a = 128;
> +		hx711_data->gain_set = 128;
> +		hx711_data->gain_chan_a = 128;
> +		indio_dev->info = &hx711_iio_info;

I'd not make this one dependent on else for chan_pulse_count.
handle it as a separate thing in chip_info as the code will end up more readable.

> +	}

> @@ -554,7 +688,8 @@ static int hx711_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id of_hx711_match[] = {
> -	{ .compatible = "avia,hx711", },
> +	{ .compatible = "avia,hx711",  .data = &hx711_chip  },
> +	{ .compatible = "avia,hx710b", .data = &hx710b_chip },

Even though it's a new part you are adding, put it above the old
one to have alpha numeric ordering. Makes it easier to know where to
add other new parts in future.

>  	{ }
>  };
>  
> @@ -571,7 +706,6 @@ static struct platform_driver hx711_driver = {
>  module_platform_driver(hx711_driver);
>  
>  MODULE_AUTHOR("Andreas Klinger <ak@it-klinger.de>");
> -MODULE_DESCRIPTION("HX711 bitbanging driver - ADC for weight cells");
> +MODULE_DESCRIPTION("HX711/HX710B GPIO ADC driver");
>  MODULE_LICENSE("GPL");
>  MODULE_ALIAS("platform:hx711-gpio");
> -

Looks like an unrelated change.  Always do a quick check for these before
sending out patches.  They slow things down a little and are easy to clean up!

Thanks,

Jonathan



