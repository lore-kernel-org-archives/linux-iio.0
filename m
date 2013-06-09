Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:60990 "EHLO
	mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750949Ab3FIQtL (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Jun 2013 12:49:11 -0400
Message-ID: <51B4B2CE.3020300@metafoo.de>
Date: Sun, 09 Jun 2013 18:52:30 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Samuel Ortiz <sameo@linux.intel.com>, Felipe Balbi <balbi@ti.com>,
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: Re: [PATCH 21/22] iio/ti_am335x_adc: Allow to specify input line
References: <1370449495-29981-1-git-send-email-bigeasy@linutronix.de> <1370449495-29981-22-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1370449495-29981-22-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> @@ -199,8 +213,11 @@ static int tiadc_probe(struct platform_device *pdev)
>  	struct tiadc_device	*adc_dev;
>  	struct ti_tscadc_dev	*tscadc_dev = ti_tscadc_dev_get(pdev);
>  	struct device_node	*node = tscadc_dev->dev->of_node;
> +	struct property		*prop;
> +	const __be32		*cur;
>  	int			err;
> -	u32			val32;
> +	u32			val;
> +	int channels		= 0;

The indention here looks a bit strange.

>  
>  	if (!node) {
>  		dev_err(&pdev->dev, "Could not find valid DT data.\n");
> @@ -222,11 +239,13 @@ static int tiadc_probe(struct platform_device *pdev)
>  		err = -EINVAL;
>  		goto err_free_device;
>  	}
> -	err = of_property_read_u32(node,
> -			"ti,adc-channels", &val32);
> -	if (err < 0)
> -		goto err_free_device;
> -	adc_dev->channels = val32;
> +
> +	of_property_for_each_u32(node, "ti,adc-channels", prop, cur, val) {
> +

No need for the extra new line

> +		adc_dev->channel_line[channels] = val;
> +		channels++;

You should make sure that channels is never >= 8

> +	}
> +	adc_dev->channels = channels;
>  
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->name = dev_name(&pdev->dev);
