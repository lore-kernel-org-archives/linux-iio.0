Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43546 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932795AbdAHLWY (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 06:22:24 -0500
Subject: Re: [PATCH 1/2] iio:adc:qcom-spmi-vadc : fix undefined __divdi3
To: linux-iio@vger.kernel.org
References: <20161230182550.12038-1-jic23@kernel.org>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <bcf621d2-4adb-52c6-d7d0-ef79df847e00@kernel.org>
Date: Sun, 8 Jan 2017 11:22:22 +0000
MIME-Version: 1.0
In-Reply-To: <20161230182550.12038-1-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/16 18:25, Jonathan Cameron wrote:
> A simple do_div call works here as all the signed 64 bit is
> actually small and unsigned at this point, and the numerator is
> u32.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
Hopefully this is fine. It's holding up my pull request so I'm going to
apply this now. 

Applied to the togreg branch of iio.git and pushed out as testing.

Jonathan
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index aaf4caf06505..9da3a8fb7514 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -664,7 +664,7 @@ static int vadc_scale_die_temp(struct vadc_priv *vadc,
>  	if (voltage > 0) {
>  		prescale = &vadc_prescale_ratios[prop->prescale];
>  		voltage = voltage * prescale->den;
> -		voltage /= (prescale->num * 2);
> +		do_div(voltage, prescale->num * 2);
>  	} else {
>  		voltage = 0;
>  	}
> 

