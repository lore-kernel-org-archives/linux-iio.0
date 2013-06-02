Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52885 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754829Ab3FBR4n (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 13:56:43 -0400
Message-ID: <51AB8758.5010705@kernel.org>
Date: Sun, 02 Jun 2013 18:56:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	sameo@linux.intel.com, jic23@cam.ac.uk, dmitry.torokhov@gmail.com,
	balbi@ti.com
Subject: Re: [PATCH 1/5] drivers/iio: am335x_adc: cleanup on missing DT nodes
References: <1369847397-27451-1-git-send-email-bigeasy@linutronix.de> <1369847397-27451-2-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369847397-27451-2-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/29/2013 06:09 PM, Sebastian Andrzej Siewior wrote:
> Currently we leak indio_dev() if the DT has no "adc" node in it.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Given you are going to end up rerolling the original series
(and it hasn't been taken by anyone yet) this wants to go
in a new version of that not as a separate patch.
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index d0317fc..b2f27de 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -208,8 +208,10 @@ static int tiadc_probe(struct platform_device *pdev)
>  	adc_dev->mfd_tscadc = tscadc_dev;
>  
>  	node = of_get_child_by_name(node, "adc");
> -	if (!node)
> -		return  -EINVAL;
> +	if (!node) {
> +		err = -EINVAL;
> +		goto err_free_device;
> +	}
>  	err = of_property_read_u32(node,
>  			"ti,adc-channels", &val32);
>  	if (err < 0)
> 
