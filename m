Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([94.23.35.102]:36754 "EHLO
	mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753117Ab3C1KYt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 28 Mar 2013 06:24:49 -0400
Message-ID: <51541A6E.8060908@free-electrons.com>
Date: Thu, 28 Mar 2013 11:24:46 +0100
From: Alexandre Belloni <alexandre.belloni@free-electrons.com>
MIME-Version: 1.0
To: Alexandre Belloni <alexandre.belloni@free-electrons.com>
CC: linux-iio@vger.kernel.org,
	Fabio Estevam <fabio.estevam@freescale.com>,
	Marek Vasut <marex@denx.de>, brian@crystalfontz.com,
	jimwall@q.com, Jonathan Cameron <jic23@kernel.org>,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] iio: mxs-lradc: Do hardware initialization earlier
References: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com>
In-Reply-To: <1364465583-19835-1-git-send-email-alexandre.belloni@free-electrons.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 28/03/2013 11:13, Alexandre Belloni wrote:
> We need to initialize hardware before registering the touchscreen. Else,
> we end up setting registers in mxs_lradc_ts_open(), getting called just
> after registering the touchscreen with input_register_device() and by
> the end of mxs_lradc_probe(), we reset the LRADC block hence losing the
> correct configuration.

Sorry, I fumbled and forgot my SoB:

Signed-off-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Jonathan Cameron <jic23@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> ---
>  drivers/staging/iio/adc/mxs-lradc.c |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/staging/iio/adc/mxs-lradc.c b/drivers/staging/iio/adc/mxs-lradc.c
> index 55a459b..e927e3f 100644
> --- a/drivers/staging/iio/adc/mxs-lradc.c
> +++ b/drivers/staging/iio/adc/mxs-lradc.c
> @@ -933,6 +933,9 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  
>  	INIT_WORK(&lradc->ts_work, mxs_lradc_ts_work);
>  
> +	/* Configure the hardware. */
> +	mxs_lradc_hw_init(lradc);
> +
>  	/* Check if touchscreen is enabled in DT. */
>  	ret = of_property_read_u32(node, "fsl,lradc-touchscreen-wires",
>  				&ts_wires);
> @@ -995,9 +998,6 @@ static int mxs_lradc_probe(struct platform_device *pdev)
>  		goto err_ts;
>  	}
>  
> -	/* Configure the hardware. */
> -	mxs_lradc_hw_init(lradc);
> -
>  	return 0;
>  
>  err_ts:


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com

