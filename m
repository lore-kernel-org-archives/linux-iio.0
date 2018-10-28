Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726492AbeJ1XgD (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 19:36:03 -0400
Date: Sun, 28 Oct 2018 14:51:08 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Nishad Kamdar <nishadkamdar@gmail.com>
Cc: Slawomir Stepien <sst@poczta.fm>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/3] staging: iio: ad2s1210: Add device tree support.
Message-ID: <20181028145108.1079227f@archlinux>
In-Reply-To: <473e6abfe959e1ac78fe65bf8dc53ad25ad3b358.1540712249.git.nishadkamdar@gmail.com>
References: <cover.1540712249.git.nishadkamdar@gmail.com>
        <473e6abfe959e1ac78fe65bf8dc53ad25ad3b358.1540712249.git.nishadkamdar@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 28 Oct 2018 13:23:23 +0530
Nishad Kamdar <nishadkamdar@gmail.com> wrote:

> Replace platform data with device tree support.
> 
> Signed-off-by: Nishad Kamdar <nishadkamdar@gmail.com>
The whole gpio in or out thing makes less and less sense to
me and seems to contradict the datasheet.

If I'm not missing something I would just get rid of the option.
If I am missing something (not hard in the datasheet which, whilst
fairly clear, is a rather long ;)

Jonathan

> ---
>  drivers/staging/iio/resolver/Kconfig    |  1 +
>  drivers/staging/iio/resolver/ad2s1210.c | 17 ++++++++---------
>  drivers/staging/iio/resolver/ad2s1210.h | 17 -----------------
>  3 files changed, 9 insertions(+), 26 deletions(-)
> 
> diff --git a/drivers/staging/iio/resolver/Kconfig b/drivers/staging/iio/resolver/Kconfig
> index 6a469ee6101f..cc1202ff813d 100644
> --- a/drivers/staging/iio/resolver/Kconfig
> +++ b/drivers/staging/iio/resolver/Kconfig
> @@ -15,6 +15,7 @@ config AD2S90
>  
>  config AD2S1210
>  	tristate "Analog Devices ad2s1210 driver"
> +	depends on OF
>  	depends on SPI
>  	depends on GPIOLIB || COMPILE_TEST
>  	help
> diff --git a/drivers/staging/iio/resolver/ad2s1210.c b/drivers/staging/iio/resolver/ad2s1210.c
> index 0234869e9d74..5ecdb5785132 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.c
> +++ b/drivers/staging/iio/resolver/ad2s1210.c
> @@ -17,6 +17,7 @@
>  #include <linux/delay.h>
>  #include <linux/gpio/consumer.h>
>  #include <linux/module.h>
> +#include <linux/of.h>
>  
>  #include <linux/iio/iio.h>
>  #include <linux/iio/sysfs.h>
> @@ -76,7 +77,6 @@ struct ad2s1210_gpio {
>  };
>  
>  struct ad2s1210_state {
> -	const struct ad2s1210_platform_data *pdata;
>  	struct mutex lock;
>  	struct spi_device *sdev;
>  	struct gpio_desc *sample;
> @@ -84,6 +84,7 @@ struct ad2s1210_state {
>  	struct gpio_desc *a1;
>  	struct gpio_desc *res0;
>  	struct gpio_desc *res1;
> +	bool gpioin;
>  	unsigned int fclkin;
>  	unsigned int fexcit;
>  	bool hysteresis;
> @@ -314,7 +315,7 @@ static ssize_t ad2s1210_store_control(struct device *dev,
>  	}
>  	st->resolution
>  		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> -	if (st->pdata->gpioin) {
> +	if (st->gpioin) {
>  		data = ad2s1210_read_resolution_pin(st);
>  		if (data != st->resolution)
>  			dev_warn(dev, "ad2s1210: resolution settings not match\n");
> @@ -376,7 +377,7 @@ static ssize_t ad2s1210_store_resolution(struct device *dev,
>  	}
>  	st->resolution
>  		= ad2s1210_resolution_value[data & AD2S1210_SET_RESOLUTION];
> -	if (st->pdata->gpioin) {
> +	if (st->gpioin) {
>  		data = ad2s1210_read_resolution_pin(st);
>  		if (data != st->resolution)
>  			dev_warn(dev, "ad2s1210: resolution settings not match\n");
> @@ -603,7 +604,7 @@ static int ad2s1210_initial(struct ad2s1210_state *st)
>  	int ret;
>  
>  	mutex_lock(&st->lock);
> -	if (st->pdata->gpioin)
> +	if (st->gpioin)
>  		st->resolution = ad2s1210_read_resolution_pin(st);
>  	else
>  		ad2s1210_set_resolution_pin(st);
> @@ -644,7 +645,7 @@ static int ad2s1210_setup_gpios(struct ad2s1210_state *st)
>  	int ret, i;
>  	struct spi_device *spi = st->sdev;
>  	struct ad2s1210_gpio *pin;
> -	unsigned long flags = st->pdata->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
> +	unsigned long flags = st->gpioin ? GPIOD_IN : GPIOD_OUT_LOW;
>  
>  	struct ad2s1210_gpio gpios[] = {
>  		{ .ptr = &st->sample, .name = "sample", .flags = GPIOD_IN },
> @@ -673,16 +674,14 @@ static int ad2s1210_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
>  	struct ad2s1210_state *st;
> +	struct device_node *np = spi->dev.of_node;
>  	int ret;
>  
> -	if (!spi->dev.platform_data)
> -		return -EINVAL;
> -
>  	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
>  	if (!indio_dev)
>  		return -ENOMEM;
>  	st = iio_priv(indio_dev);
> -	st->pdata = spi->dev.platform_data;
> +	st->gpioin = of_property_read_bool(np, "gpioin");

Hmm. This bothered me in the earlier patch.  How are we meant to configure
these pins... (and this time I actually loaded the datasheet)

A0 and A1 always seem to be control signals written to the device so
I don't really understand why we would ever want them to be 'inputs'
on our host.

RES0 and RES1 are also control signals. Clearly marked as logic inputs.

The only thing I can think here is there is an evaluation board out there
were we are not in control of these, some other controller is.
That is a pretty weird board if so, hence I would only support the version
where we use GPIO outputs from the host.

This will further simplify patch 1 and get rid fo the need for this
non standard bit of devicetree binding.


>  	ret = ad2s1210_setup_gpios(st);
>  	if (ret < 0)
>  		return ret;
> diff --git a/drivers/staging/iio/resolver/ad2s1210.h b/drivers/staging/iio/resolver/ad2s1210.h
> index 63d479b20a6c..e69de29bb2d1 100644
> --- a/drivers/staging/iio/resolver/ad2s1210.h
> +++ b/drivers/staging/iio/resolver/ad2s1210.h
> @@ -1,17 +0,0 @@
> -/*
> - * ad2s1210.h plaform data for the ADI Resolver to Digital Converters:
> - * AD2S1210
> - *
> - * Copyright (c) 2010-2010 Analog Devices Inc.
> - *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License version 2 as
> - * published by the Free Software Foundation.
> - */
> -#ifndef _AD2S1210_H
> -#define _AD2S1210_H
> -
> -struct ad2s1210_platform_data {
> -	bool			gpioin;
> -};
> -#endif /* _AD2S1210_H */
