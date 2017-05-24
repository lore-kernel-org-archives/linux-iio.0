Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S937377AbdEXTYU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 24 May 2017 15:24:20 -0400
Date: Wed, 24 May 2017 20:24:17 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Tony Lindgren <tony@atomide.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-omap@vger.kernel.org,
        Marcel Partap <mpartap@gmx.net>,
        Michael Scott <michael.scott@linaro.org>
Subject: Re: [PATCH 3/3] iio: adc: cpcap: Remove hung interrupt quirk
Message-ID: <20170524202417.407ad526@kernel.org>
In-Reply-To: <20170523005146.726-4-tony@atomide.com>
References: <20170523005146.726-1-tony@atomide.com>
        <20170523005146.726-4-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 22 May 2017 17:51:46 -0700
Tony Lindgren <tony@atomide.com> wrote:

> This is no longer needed as the real problem was interrupt flags
> not getting passed properly from device tree to the cpcap-core.c
> mfd driver. This got fixed with commit ac89473213c6 ("mfd: cpcap:
> Fix interrupt to use level interrupt") So let's remove ADC
> interrupt specific the quirk.
> 
> Cc: Marcel Partap <mpartap@gmx.net>
> Cc: Michael Scott <michael.scott@linaro.org>
> Reviewed-by: Sebastian Reichel <sre@kernel.org>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
Applied to the togreg branch of iio.git and initially pushed out
as testing for the autobuilders to play with it.

Thanks for cleaning this up.

Jonathan
> ---
>  drivers/iio/adc/cpcap-adc.c | 24 +-----------------------
>  1 file changed, 1 insertion(+), 23 deletions(-)
> 
> diff --git a/drivers/iio/adc/cpcap-adc.c b/drivers/iio/adc/cpcap-adc.c
> --- a/drivers/iio/adc/cpcap-adc.c
> +++ b/drivers/iio/adc/cpcap-adc.c
> @@ -89,7 +89,7 @@
>  #define ST_ADC_CAL_BATTI_LOW_THRESHOLD	494
>  #define ST_ADC_CALIBRATE_DIFF_THRESHOLD	3
>  
> -#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration and quirk */
> +#define CPCAP_ADC_MAX_RETRIES		5	/* Calibration */
>  
>  /**
>   * struct cpcap_adc_ato - timing settings for cpcap adc
> @@ -635,27 +635,6 @@ static void cpcap_adc_setup_bank(struct cpcap_adc *ddata,
>  	}
>  }
>  
> -/*
> - * Occasionally the ADC does not seem to start and there will be no
> - * interrupt. Let's re-init interrupt to prevent the ADC from hanging
> - * for the next request. It is unclear why this happens, but the next
> - * request will usually work after doing this.
> - */
> -static void cpcap_adc_quirk_reset_lost_irq(struct cpcap_adc *ddata)
> -{
> -	int error;
> -
> -	dev_info(ddata->dev, "lost ADC irq, attempting to reinit\n");
> -	disable_irq(ddata->irq);
> -	error = regmap_update_bits(ddata->reg, CPCAP_REG_ADCC2,
> -				   CPCAP_BIT_ADTRIG_DIS,
> -				   CPCAP_BIT_ADTRIG_DIS);
> -	if (error)
> -		dev_warn(ddata->dev, "%s reset failed: %i\n",
> -			 __func__, error);
> -	enable_irq(ddata->irq);
> -}
> -
>  static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
>  				struct cpcap_adc_request *req)
>  {
> @@ -673,7 +652,6 @@ static int cpcap_adc_start_bank(struct cpcap_adc *ddata,
>  			return 0;
>  
>  		if (error == 0) {
> -			cpcap_adc_quirk_reset_lost_irq(ddata);
>  			error = -ETIMEDOUT;
>  			continue;
>  		}

