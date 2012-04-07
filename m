Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 15.mo3.mail-out.ovh.net ([87.98.150.177]:55045 "EHLO
	mo3.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750695Ab2DGENd (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 7 Apr 2012 00:13:33 -0400
Received: from mail622.ha.ovh.net (b7.ovh.net [213.186.33.57])
	by mo3.mail-out.ovh.net (Postfix) with SMTP id 5DEF7FF838C
	for <linux-iio@vger.kernel.org>; Sat,  7 Apr 2012 05:48:43 +0200 (CEST)
Date: Sat, 7 Apr 2012 05:31:24 +0200
From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	Patrice Vilchez <patrice.vilchez@atmel.com>,
	Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
	Nicolas Ferre <nicolas.ferre@atmel.com>
Subject: Re: [PATCH 4/5] IIO: AT91: ADC: Add support for the
 AT91SAM9M10G45-EK board
Message-ID: <20120407033124.GF16641@game.jcrosoft.org>
References: <1333641684-20325-1-git-send-email-maxime.ripard@free-electrons.com>
 <1333641684-20325-5-git-send-email-maxime.ripard@free-electrons.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1333641684-20325-5-git-send-email-maxime.ripard@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

> diff --git a/arch/arm/mach-at91/board-sam9m10g45ek.c b/arch/arm/mach-at91/board-sam9m10g45ek.c
> index e1bea73..dca46c8 100644
> --- a/arch/arm/mach-at91/board-sam9m10g45ek.c
> +++ b/arch/arm/mach-at91/board-sam9m10g45ek.c
> @@ -27,6 +27,8 @@
>  #include <linux/atmel-mci.h>
>  #include <linux/delay.h>
>  
> +#include <linux/platform_data/at91_adc.h>
> +
>  #include <mach/hardware.h>
>  #include <video/atmel_lcdc.h>
>  #include <media/soc_camera.h>
> @@ -314,6 +316,13 @@ static struct at91_tsadcc_data ek_tsadcc_data = {
>  	.ts_sample_hold_time	= 0x0a,
>  };
>  
> +/*
> + * ADCs
> + */
> +static struct at91_adc_data ek_adc_data = {
> +	.channels_used = BIT(0) | BIT(1) | BIT(2) | BIT(3) | BIT(4) | BIT(5) | BIT(6) | BIT(7),
> +	.vref = 3300,
> +};
>  
>  /*
>   * GPIO Buttons
> @@ -479,6 +488,8 @@ static void __init ek_board_init(void)
>  	at91_add_device_lcdc(&ek_lcdc_data);
>  	/* Touch Screen */
>  	at91_add_device_tsadcc(&ek_tsadcc_data);
> +	/* ADC */
> +	at91_add_device_adc(&ek_adc_data);
>  	/* Push Buttons */
>  	ek_add_device_buttons();
>  	/* AC97 */
> diff --git a/drivers/staging/iio/adc/at91_adc.c b/drivers/staging/iio/adc/at91_adc.c
> index c76516a..04bac43 100644
> --- a/drivers/staging/iio/adc/at91_adc.c
> +++ b/drivers/staging/iio/adc/at91_adc.c
> @@ -56,6 +56,13 @@ struct at91_adc_state {
>  	wait_queue_head_t	wq_data_avail;
>  };
>  
> +static struct at91_adc_desc at91_adc_desc_sam9g45 = {
> +	.clock = 13200000,
> +	.clock_name = "tsc_clk",
> +	.num_channels = 8,
> +	.startup_time = 40,
> +};
> +
>  static struct at91_adc_desc at91_adc_desc_sam9g20 = {
>  	.clock = 5000000,
>  	.clock_name = "adc_clk",
> @@ -70,6 +77,11 @@ static int at91_adc_select_soc(struct at91_adc_state *st)
>  		return 0;
>  	}
>  
> +	if (cpu_is_at91sam9g45()) {
> +		st->desc = &at91_adc_desc_sam9g45;
> +		return 0;
> +	}
> +
>  	return -ENODEV;
>  }
>  
soc specific

Best Regards,
J.
