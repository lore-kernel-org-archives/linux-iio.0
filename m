Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:43550 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S938981AbdAHLWn (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 8 Jan 2017 06:22:43 -0500
Subject: Re: [PATCH 2/2] iio:adc:qcom-spmi-vadc silence a long constant
 warning.
To: linux-iio@vger.kernel.org
References: <20161230182550.12038-1-jic23@kernel.org>
 <20161230182550.12038-2-jic23@kernel.org>
Cc: Rama Krishna Phani A <rphani@codeaurora.org>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ef0d68a2-2653-8dd7-8b05-3102a8c09d42@kernel.org>
Date: Sun, 8 Jan 2017 11:22:41 +0000
MIME-Version: 1.0
In-Reply-To: <20161230182550.12038-2-jic23@kernel.org>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/12/16 18:25, Jonathan Cameron wrote:
> It is meant to be long and is only added to an s64.
> 
> Signed-off-by: Jonathan Cameron <jic23@kernel.org>
> Cc: Rama Krishna Phani A <rphani@codeaurora.org>
Applied to the togreg branch of iio.git and pushed out as testing.

Thanks

Jonathan
> ---
>  drivers/iio/adc/qcom-spmi-vadc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-vadc.c b/drivers/iio/adc/qcom-spmi-vadc.c
> index 9da3a8fb7514..244dbbd0d5e0 100644
> --- a/drivers/iio/adc/qcom-spmi-vadc.c
> +++ b/drivers/iio/adc/qcom-spmi-vadc.c
> @@ -101,7 +101,7 @@
>  #define KELVINMIL_CELSIUSMIL			273150
>  
>  #define PMI_CHG_SCALE_1				-138890
> -#define PMI_CHG_SCALE_2				391750000000
> +#define PMI_CHG_SCALE_2				391750000000LL
>  
>  #define VADC_CHAN_MIN			VADC_USBIN
>  #define VADC_CHAN_MAX			VADC_LR_MUX3_BUF_PU1_PU2_XO_THERM
> 

