Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45887 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750792AbdAHVDL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 16:03:11 -0500
Subject: Re: [PATCH] guessing
To: linux-iio@vger.kernel.org
References: <20170108210140.17507-1-jic23@kernel.org>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <17e808f1-e232-9efc-b27f-fe85dd0b84f2@kernel.org>
Date: Sun, 8 Jan 2017 21:03:08 +0000
MIME-Version: 1.0
In-Reply-To: <20170108210140.17507-1-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/01/17 21:01, Jonathan Cameron wrote:
And that wasn't meant to go out with this title.

Sorry.

Jonathan
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index faaf711325b5..0a19761d656c 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -641,7 +641,7 @@ static int vadc_scale_therm(struct vadc_priv *vadc,
>  	vadc_scale_calib(vadc, adc_code, prop, &voltage);
>  
>  	if (prop->calibration == VADC_CALIB_ABSOLUTE)
> -		voltage /= 1000;
> +		voltage = div64_s64(voltage, 1000);
>  
>  	vadc_map_voltage_temp(adcmap_100k_104ef_104fb,
>  			      ARRAY_SIZE(adcmap_100k_104ef_104fb),
> 

