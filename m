Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52261 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753376Ab3FBQ67 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 12:58:59 -0400
Message-ID: <51AB79CE.2000001@kernel.org>
Date: Sun, 02 Jun 2013 17:58:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>, "Patil, Rachna" <rachna@ti.com>,
	Pantelis Antoniou <panto@antoniou-consulting.com>
Subject: Re: [PATCH 07/19] iio: adc: am335x: Add DT support
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-8-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-8-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/2013 08:11 PM, Sebastian Andrzej Siewior wrote:
> From: "Patil, Rachna" <rachna@ti.com>
> 
> Add DT support for client ADC driver.
> 
> [ panto@antoniou-consulting.com : use of_get_child_by_name
> 	instead of of_find_node_by_name ]
> 
> Signed-off-by: Pantelis Antoniou <panto@antoniou-consulting.com>
> Signed-off-by: Patil, Rachna <rachna@ti.com>
> Signed-off-by: Felipe Balbi <balbi@ti.com>
> [bigeasy: shift the code to the left]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

I would take this directly but then I'd imagine that will cause havoc
when the later patches are applied and touch both iio and mfd.


> ---
>  drivers/iio/adc/ti_am335x_adc.c |   23 +++++++++++++++++++----
>  1 file changed, 19 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 5f9a7e7..e657709 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -22,6 +22,8 @@
>  #include <linux/platform_device.h>
>  #include <linux/io.h>
>  #include <linux/iio/iio.h>
> +#include <linux/of.h>
> +#include <linux/of_device.h>
>  
>  #include <linux/mfd/ti_am335x_tscadc.h>
>  #include <linux/platform_data/ti_am335x_adc.h>
> @@ -141,11 +143,12 @@ static int tiadc_probe(struct platform_device *pdev)
>  	struct iio_dev		*indio_dev;
>  	struct tiadc_device	*adc_dev;
>  	struct ti_tscadc_dev	*tscadc_dev = pdev->dev.platform_data;
> -	struct mfd_tscadc_board	*pdata;
> +	struct mfd_tscadc_board	*pdata = tscadc_dev->dev->platform_data;
> +	struct device_node	*node = tscadc_dev->dev->of_node;
>  	int			err;
> +	u32			val32;
>  
> -	pdata = tscadc_dev->dev->platform_data;
> -	if (!pdata || !pdata->adc_init) {
> +	if (!pdata && !node) {
>  		dev_err(&pdev->dev, "Could not find platform data\n");
>  		return -EINVAL;
>  	}
> @@ -159,7 +162,19 @@ static int tiadc_probe(struct platform_device *pdev)
>  	adc_dev = iio_priv(indio_dev);
>  
>  	adc_dev->mfd_tscadc = tscadc_dev;
> -	adc_dev->channels = pdata->adc_init->adc_channels;
> +
> +	if (pdata)
> +		adc_dev->channels = pdata->adc_init->adc_channels;
> +	else {
> +		node = of_get_child_by_name(node, "adc");
> +		if (!node)
> +			return  -EINVAL;
> +		err = of_property_read_u32(node,
> +				"ti,adc-channels", &val32);
> +		if (err < 0)
> +			goto err_free_device;
> +		adc_dev->channels = val32;
> +	}
>  
>  	indio_dev->dev.parent = &pdev->dev;
>  	indio_dev->name = dev_name(&pdev->dev);
> 
