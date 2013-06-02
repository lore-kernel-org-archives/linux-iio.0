Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:52820 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754811Ab3FBRuU (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 2 Jun 2013 13:50:20 -0400
Message-ID: <51AB85DB.2000305@kernel.org>
Date: Sun, 02 Jun 2013 18:50:19 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: linux-input@vger.kernel.org, linux-iio@vger.kernel.org,
	Samuel Ortiz <sameo@linux.intel.com>,
	Jonathan Cameron <jic23@cam.ac.uk>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Felipe Balbi <balbi@ti.com>
Subject: Re: [PATCH 17/19] mfd / iio: ti_am335x_adc: rename device from tiadc
 to TI-adc
References: <1369681926-22185-1-git-send-email-bigeasy@linutronix.de> <1369681926-22185-18-git-send-email-bigeasy@linutronix.de>
In-Reply-To: <1369681926-22185-18-git-send-email-bigeasy@linutronix.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/27/2013 08:12 PM, Sebastian Andrzej Siewior wrote:
> TI-adc reads a little better compared to tiadc.
> While here add an alias so the driver is loaded on demand.
> 
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>

but you'll be wanting a few more acks on a name change...
> ---
>  drivers/iio/adc/ti_am335x_adc.c |    4 ++--
>  drivers/mfd/ti_am335x_tscadc.c  |    2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index 72ffe89..d0317fc 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -299,14 +299,14 @@ static const struct dev_pm_ops tiadc_pm_ops = {
>  
>  static struct platform_driver tiadc_driver = {
>  	.driver = {
> -		.name   = "tiadc",
> +		.name   = "TI-adc",
>  		.owner	= THIS_MODULE,
>  		.pm	= TIADC_PM_OPS,
>  	},
>  	.probe	= tiadc_probe,
>  	.remove	= tiadc_remove,
>  };
> -
> +MODULE_ALIAS("platform:TI-adc");
>  module_platform_driver(tiadc_driver);
>  
>  MODULE_DESCRIPTION("TI ADC controller driver");
> diff --git a/drivers/mfd/ti_am335x_tscadc.c b/drivers/mfd/ti_am335x_tscadc.c
> index c25fe00..014df14 100644
> --- a/drivers/mfd/ti_am335x_tscadc.c
> +++ b/drivers/mfd/ti_am335x_tscadc.c
> @@ -193,7 +193,7 @@ static	int ti_tscadc_probe(struct platform_device *pdev)
>  	if (adc_channels > 0) {
>  		tscadc->adc_cell = tscadc->used_cells;
>  		cell = &tscadc->cells[tscadc->used_cells++];
> -		cell->name = "tiadc";
> +		cell->name = "TI-adc";
>  		cell->platform_data = tscadc;
>  		cell->pdata_size = sizeof(*tscadc);
>  	}
> 
