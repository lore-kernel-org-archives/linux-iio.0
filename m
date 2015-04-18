Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60818 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750741AbbDRQlP (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 18 Apr 2015 12:41:15 -0400
Message-ID: <55328926.20509@kernel.org>
Date: Sat, 18 Apr 2015 17:41:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: "Ivan T. Ivanov" <ivan.ivanov@linaro.org>
CC: Stanimir Varbanov <svarbanov@mm-sol.com>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH] iio: adc: spmi-vadc: Fix overflow in output value normalization
References: <1429282268-30501-1-git-send-email-ivan.ivanov@linaro.org>
In-Reply-To: <1429282268-30501-1-git-send-email-ivan.ivanov@linaro.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 17/04/15 15:51, Ivan T. Ivanov wrote:
> With 'dx' equal to 0.625V and 15 bit ADC, calculations overflow
> when difference against GND is ~20% of the ADC range. Fix this.
> 
> Signed-off-by: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan
>
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 3211729..0c4618b 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -18,6 +18,7 @@
>  #include <linux/iio/iio.h>
>  #include <linux/interrupt.h>
>  #include <linux/kernel.h>
> +#include <linux/math64.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/platform_device.h>
> @@ -471,11 +472,11 @@ static s32 vadc_calibrate(struct vadc_priv *vadc,
>  			  const struct vadc_channel_prop *prop, u16 adc_code)
>  {
>  	const struct vadc_prescale_ratio *prescale;
> -	s32 voltage;
> +	s64 voltage;
> 
>  	voltage = adc_code - vadc->graph[prop->calibration].gnd;
>  	voltage *= vadc->graph[prop->calibration].dx;
> -	voltage = voltage / vadc->graph[prop->calibration].dy;
> +	voltage = div64_s64(voltage, vadc->graph[prop->calibration].dy);
> 
>  	if (prop->calibration == VADC_CALIB_ABSOLUTE)
>  		voltage += vadc->graph[prop->calibration].dx;
> @@ -487,7 +488,7 @@ static s32 vadc_calibrate(struct vadc_priv *vadc,
> 
>  	voltage = voltage * prescale->den;
> 
> -	return voltage / prescale->num;
> +	return div64_s64(voltage, prescale->num);
>  }
> 
>  static int vadc_decimation_from_dt(u32 value)
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

