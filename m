Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CDCD37204B;
	Tue, 12 May 2026 12:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778588355; cv=none; b=gp2YvVJU3OVPyL5w7v9LsjPkK6iDGvXF/Kd1m0U3zDBkLtCJLQeRiTULGAXTpd1zFsjVMENI96ZbojGbZAtYc+WVgXAn4JiJ+d0onBSP0ohW65SMuYGKJn7sFjm+74FLYbEcr6W/HIS1oStpHX4p2lpv5ZiHWHj1n9UUER+WtD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778588355; c=relaxed/simple;
	bh=Lj3+Nnn60F6KDZrpfio/n6EVGV07QDpbZc24HcoAacw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=coeaTjovah4evGgWZ7wwklm8dCye3d3HB6qgibOJSfJbYXejF7Dn3eIt1JCllCxj7ub+aEFDZpdUK8ZKkvrgqr8DKAmYn5QEqCBD67lKblwTcoYQBr1qR4KObsyrbynxERBViXkDMOEgivokzrNxTL3U0/Ns1nbbHmFSg2KZzoA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXD8BRHG; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXD8BRHG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D47E7C2BCB0;
	Tue, 12 May 2026 12:19:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778588355;
	bh=Lj3+Nnn60F6KDZrpfio/n6EVGV07QDpbZc24HcoAacw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tXD8BRHGsAoR0V/+ezz6seXgh4B5sXCbVYglNIxg1LQvG6HDeNo88rZrUa9dPYq7P
	 9agl1dns9BN2V/gsXIuqZDeOjbK36bvx90TEUHiByWDPVkWlUxoosDAnLUG312rh1S
	 PHNtP+YJF2vuhwl06wHA7elZnMnz7GMLf8yCAbk+fWbIW/afQRU5weboxvzeX/MESq
	 fFae0EmqLDSfl9aE1LQRkamOMXk2UOz+WqO7JEGFJpR7urqM+EZxL4w7a2S0xOElJA
	 7AOh1+fmf4hRbAWfaWS+/ZTE0/EEtgPppGxGUzAV7S6qCqAp4SS5N5kLhKSSYxF8An
	 qfjuEDO4APcqw==
Date: Tue, 12 May 2026 13:19:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: ak@it-klinger.de, andriy.shevchenko@linux.intel.com,
 dlechner@baylibre.com, nuno.sa@analog.com, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8 v8 06/11] iio: adc: hx711: introduce hx711_chip_info
 structure
Message-ID: <20260512131905.42c35224@jic23-huawei>
In-Reply-To: <20260511174342.123820-7-piyushpatle228@gmail.com>
References: <20260511174342.123820-1-piyushpatle228@gmail.com>
	<20260511174342.123820-7-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 May 2026 23:13:31 +0530
Piyush Patle <piyushpatle228@gmail.com> wrote:

> Add a per-variant static configuration structure and populate the IIO
> device fields from it at probe time.
> 
> This is a preparatory change for adding support for more HX711-compatible
> hardware variants without duplicating the probe-time setup.
> 
> No functional change for existing HX711 users.
> 
> Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Mostly for my reference when v8 sashiko comes in - there was feedback on this
in v7 but it was something we don't care about - in a driver that supports
multiple parts - if someone is using the legacy path to force a driver match
we can't do the right thing - guessing it is an hx711 is not appropriate.

Given it is vanishingly unlikely (famous last words) anyone is using that
path with a device like this one (who isn't a developer who can easily fix
that) let us merge this and see if anyone screams before trying to
deal with that case.

I'm going to hold off for now though as waiting on v8 sashiko review of the
rest of the series.

Jonathan

> ---
>  drivers/iio/adc/hx711.c | 41 ++++++++++++++++++++++++++++++++++++-----
>  1 file changed, 36 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/adc/hx711.c b/drivers/iio/adc/hx711.c
> index 86d2a70dd3de..10ccc69f209b 100644
> --- a/drivers/iio/adc/hx711.c
> +++ b/drivers/iio/adc/hx711.c
> @@ -4,6 +4,8 @@
>   *
>   * Copyright (c) 2016 Andreas Klinger <ak@it-klinger.de>
>   */
> +#include <linux/array_size.h>
> +#include <linux/dev_printk.h>
>  #include <linux/err.h>
>  #include <linux/kernel.h>
>  #include <linux/module.h>
> @@ -74,6 +76,20 @@ static int hx711_get_scale_to_gain(const int *gain_scale, int scale)
>  	return -EINVAL;
>  }
>  
> +/**
> + * struct hx711_chip_info - per-variant static configuration
> + * @name: IIO device name
> + * @channels: channel specification array
> + * @num_channels: number of entries in @channels
> + * @iio_info: IIO info ops for this variant
> + */
> +struct hx711_chip_info {
> +	const char			*name;
> +	const struct iio_chan_spec	*channels __counted_by_ptr(num_channels);
> +	unsigned int			num_channels;
> +	const struct iio_info		*iio_info;
> +};
> +
>  struct hx711_data {
>  	struct device		*dev;
>  	struct gpio_desc	*gpiod_pd_sck;
> @@ -81,6 +97,7 @@ struct hx711_data {
>  	int			gain_set;	/* gain set on device */
>  	int			gain_chan_a;	/* gain for channel A */
>  	int			gain_scale[HX711_GAIN_MAX];
> +	const struct hx711_chip_info	*chip_info;
>  	struct mutex		lock;
>  	/*
>  	 * triggered buffer
> @@ -456,8 +473,16 @@ static const struct iio_chan_spec hx711_chan_spec[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(2),
>  };
>  
> +static const struct hx711_chip_info hx711_chip = {
> +	.name		= "hx711",
> +	.channels	= hx711_chan_spec,
> +	.iio_info	= &hx711_iio_info,
> +	.num_channels	= ARRAY_SIZE(hx711_chan_spec),
> +};
> +
>  static int hx711_probe(struct platform_device *pdev)
>  {
> +	const struct hx711_chip_info *chip_info;
>  	struct device *dev = &pdev->dev;
>  	struct hx711_data *hx711_data;
>  	struct iio_dev *indio_dev;
> @@ -473,6 +498,12 @@ static int hx711_probe(struct platform_device *pdev)
>  
>  	mutex_init(&hx711_data->lock);
>  
> +	chip_info = device_get_match_data(dev);
> +	if (!chip_info)
> +		return dev_err_probe(dev, -ENODEV, "missing driver data\n");
> +
> +	hx711_data->chip_info = chip_info;
> +
>  	/*
>  	 * PD_SCK stands for power down and serial clock input of HX711
>  	 * in the driver it is an output
> @@ -534,11 +565,11 @@ static int hx711_probe(struct platform_device *pdev)
>  	hx711_data->data_ready_delay_ns =
>  				1000000000 / hx711_data->clock_frequency;
>  
> -	indio_dev->name = "hx711";
> -	indio_dev->info = &hx711_iio_info;
> +	indio_dev->name = chip_info->name;
> +	indio_dev->info = chip_info->iio_info;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = hx711_chan_spec;
> -	indio_dev->num_channels = ARRAY_SIZE(hx711_chan_spec);
> +	indio_dev->channels = chip_info->channels;
> +	indio_dev->num_channels = chip_info->num_channels;
>  
>  	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>  					      iio_pollfunc_store_time,
> @@ -555,7 +586,7 @@ static int hx711_probe(struct platform_device *pdev)
>  }
>  
>  static const struct of_device_id of_hx711_match[] = {
> -	{ .compatible = "avia,hx711", },
> +	{ .compatible = "avia,hx711", .data = &hx711_chip },
>  	{ }
>  };
>  

