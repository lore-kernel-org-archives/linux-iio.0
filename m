Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A913D565D;
	Wed, 20 May 2026 10:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272635; cv=none; b=n/7Ow8y0clgFGOuyQ2Ijhi6h4LI3HUY3PlJTdFT6zTExqdsGr0DwXWAb+YUub9FsVMNUSqO2tibf2rXPlJXo7czwrkZkgcxvl0P9b5i1bCL0ufDorrFNI7F6oMNXTD+CTewdHFdjPfyKL5vBZ1WZMg3NGqBKu91kaJMuHD0wNAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272635; c=relaxed/simple;
	bh=WsoIzmaJbckTdlZEMPGbRANtoaoviVRVfKgT+xBrnBM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=B3QyCuX8HPuKOTU86VCqdvx+LlpZAMavZ4PoKzG3kJqU6+wOrbu2qI7CWjA/AEhcNmNLbq2TXFdfLuhAfkdgPEUaOcvGr5jA9r3dRvvu8h2Pfjj9DNTYKUYP/V6EGN7QAVsjSX9yG8FoN3tWYnRE3x6C0oPw9Kr5FKwt2Zh8LTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AEe3hZ/N; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AEe3hZ/N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F6E81F000E9;
	Wed, 20 May 2026 10:23:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779272626;
	bh=XfFsYV04OcrnSg9RB0+Liy0VnfuMTGCMkJ53gEVWeI0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=AEe3hZ/N1SEljONBMCTHgwHgH4q9GZxyr859lm9jvKOkmHvYVYX+YYKLbiLAVVtd+
	 kqBSUmv+8Fbfk2bBquImdNEvAG0Z74EfXfKTm0fCAwATHhENdHvVB3ZoRZSNuG51Aq
	 LbpczFFI5fPSkJYd9B9ORjtl4hXLjD6bJk0nr4d8LdOu7J7yBnY2e5u7pPHLGIow0R
	 6rJ4NkbldBgGoRl6Q1TnvicZ1clkCbdhQOtYkumR4jtTjmBr70pfaasd5N7bL7lfXc
	 tnAKJL6OuRsgJV2llX613waUaPN/plHjdB4U7jD4ORRwj91+MPMTX0qTTiydYPogMv
	 IHT9uzL2QodFg==
Date: Wed, 20 May 2026 11:23:38 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Piyush Patle <piyushpatle228@gmail.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Andreas Klinger <ak@it-klinger.de>, Andy
 Shevchenko <andy@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v9 06/11] iio: adc: hx711: introduce hx711_chip_info
 structure
Message-ID: <20260520112338.22e9dcb0@jic23-huawei>
In-Reply-To: <20260518220228.63322-7-piyushpatle228@gmail.com>
References: <20260518220228.63322-1-piyushpatle228@gmail.com>
	<20260518220228.63322-7-piyushpatle228@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 19 May 2026 03:32:22 +0530
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
> ---
> No code change from v8.
> 
> Regarding the __counted_by_ptr() annotation on hx711_chip_info.channels:
> this annotation was introduced in include/linux/compiler_types.h in
> commit 4b8a2e8e09be ("compiler_types.h: Add __counted_by_ptr()") which
> landed in 6.12-rc1.

Seems unlikely. I'm seeing it landing in January this year.  I'm guessing
you are looking at a backport to a stable tree maybe?  That commit id
isn't in upstream.

>  This tree is 6.17, so the macro is

Why are you on 6.17!  This is targetting 7.2 so all we care about is whether
it was in the 7.1-rc1 or not.  Meh doesn't matter as this text will get
dropped anyway when I merge.  

> well-defined.  Jonathan Cameron requested this annotation in his v7
> review; Sashiko's v8 bot flag was a false positive.
> 
> Regarding the legacy platform_device probe path: the concern that
> probe could succeed without chip_info (returning a useless device) was
> acknowledged.  Jonathan has indicated the current device_get_match_data()
> guard is acceptable, so no change was made.
> 
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

