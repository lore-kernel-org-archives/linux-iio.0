Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751391AbdJNSy4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 14 Oct 2017 14:54:56 -0400
Date: Sat, 14 Oct 2017 19:54:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Eugen Hristev <eugen.hristev@microchip.com>
Cc: <nicolas.ferre@microchip.com>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <ludovic.desroches@microchip.com>
Subject: Re: [PATCH] iio: adc: at91-sama5d2_adc: fix probe error on missing
 trigger property
Message-ID: <20171014195452.06352c7b@archlinux>
In-Reply-To: <1507720874-12526-1-git-send-email-eugen.hristev@microchip.com>
References: <1507720874-12526-1-git-send-email-eugen.hristev@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 11 Oct 2017 14:21:14 +0300
Eugen Hristev <eugen.hristev@microchip.com> wrote:

> This fix allows platforms to probe correctly even if the
> trigger edge property is missing. The hardware trigger
> will no longer be registered in the sybsystem
> Preserves backwards compatibility with the support that
> was in the driver before the hardware trigger.
> 
> Signed-off-by: Eugen Hristev <eugen.hristev@microchip.com>
> ---
> Hello Jonathan,
> The trigger feature is new and it prevents
> current platforms from probing correctly.
> Here is a link with the failure from kernelci.org
> https://storage.kernelci.org/mainline/master/v4.14-rc2-255-g74d83ec2b734/arm/sama5_defconfig/lab-free-electrons/boot-at91-sama5d2_xplained.txt
> This would need to go to 4.14-final, if it's not too late.
>

Should make it easily enough.  Applied to the fixes-togreg branch of iio.git.
Oops on missing compatibility was broken. I added the
kernelci.org link to the commit message part.

Jonathan
 
> 
>  drivers/iio/adc/at91-sama5d2_adc.c | 45 ++++++++++++++++++++++++--------------
>  1 file changed, 29 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91-sama5d2_adc.c b/drivers/iio/adc/at91-sama5d2_adc.c
> index 318601b..755a493 100644
> --- a/drivers/iio/adc/at91-sama5d2_adc.c
> +++ b/drivers/iio/adc/at91-sama5d2_adc.c
> @@ -225,6 +225,7 @@ struct at91_adc_trigger {
>  	char				*name;
>  	unsigned int			trgmod_value;
>  	unsigned int			edge_type;
> +	bool				hw_trig;
>  };
>  
>  struct at91_adc_state {
> @@ -254,16 +255,25 @@ static const struct at91_adc_trigger at91_adc_trigger_list[] = {
>  		.name = "external_rising",
>  		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_RISE,
>  		.edge_type = IRQ_TYPE_EDGE_RISING,
> +		.hw_trig = true,
>  	},
>  	{
>  		.name = "external_falling",
>  		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_FALL,
>  		.edge_type = IRQ_TYPE_EDGE_FALLING,
> +		.hw_trig = true,
>  	},
>  	{
>  		.name = "external_any",
>  		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_EXT_TRIG_ANY,
>  		.edge_type = IRQ_TYPE_EDGE_BOTH,
> +		.hw_trig = true,
> +	},
> +	{
> +		.name = "software",
> +		.trgmod_value = AT91_SAMA5D2_TRGR_TRGMOD_NO_TRIGGER,
> +		.edge_type = IRQ_TYPE_NONE,
> +		.hw_trig = false,
>  	},
>  };
>  
> @@ -595,7 +605,7 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	struct at91_adc_state *st;
>  	struct resource	*res;
>  	int ret, i;
> -	u32 edge_type;
> +	u32 edge_type = IRQ_TYPE_NONE;
>  
>  	indio_dev = devm_iio_device_alloc(&pdev->dev, sizeof(*st));
>  	if (!indio_dev)
> @@ -639,14 +649,14 @@ static int at91_adc_probe(struct platform_device *pdev)
>  	ret = of_property_read_u32(pdev->dev.of_node,
>  				   "atmel,trigger-edge-type", &edge_type);
>  	if (ret) {
> -		dev_err(&pdev->dev,
> -			"invalid or missing value for atmel,trigger-edge-type\n");
> -		return ret;
> +		dev_dbg(&pdev->dev,
> +			"atmel,trigger-edge-type not specified, only software trigger available\n");
>  	}
>  
>  	st->selected_trig = NULL;
>  
> -	for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT; i++)
> +	/* find the right trigger, or no trigger at all */
> +	for (i = 0; i < AT91_SAMA5D2_HW_TRIG_CNT + 1; i++)
>  		if (at91_adc_trigger_list[i].edge_type == edge_type) {
>  			st->selected_trig = &at91_adc_trigger_list[i];
>  			break;
> @@ -715,24 +725,27 @@ static int at91_adc_probe(struct platform_device *pdev)
>  
>  	platform_set_drvdata(pdev, indio_dev);
>  
> -	ret = at91_adc_buffer_init(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
> -		goto per_clk_disable_unprepare;
> -	}
> +	if (st->selected_trig->hw_trig) {
> +		ret = at91_adc_buffer_init(indio_dev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "couldn't initialize the buffer.\n");
> +			goto per_clk_disable_unprepare;
> +		}
>  
> -	ret = at91_adc_trigger_init(indio_dev);
> -	if (ret < 0) {
> -		dev_err(&pdev->dev, "couldn't setup the triggers.\n");
> -		goto per_clk_disable_unprepare;
> +		ret = at91_adc_trigger_init(indio_dev);
> +		if (ret < 0) {
> +			dev_err(&pdev->dev, "couldn't setup the triggers.\n");
> +			goto per_clk_disable_unprepare;
> +		}
>  	}
>  
>  	ret = iio_device_register(indio_dev);
>  	if (ret < 0)
>  		goto per_clk_disable_unprepare;
>  
> -	dev_info(&pdev->dev, "setting up trigger as %s\n",
> -		 st->selected_trig->name);
> +	if (st->selected_trig->hw_trig)
> +		dev_info(&pdev->dev, "setting up trigger as %s\n",
> +			 st->selected_trig->name);
>  
>  	dev_info(&pdev->dev, "version: %x\n",
>  		 readl_relaxed(st->base + AT91_SAMA5D2_VERSION));

