Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49669 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751574AbcDPTZu (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 16 Apr 2016 15:25:50 -0400
Subject: Re: [PATCH 1/2] iio: adc: Indent if statement
To: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
References: <cover.1460316026.git.ksenija.stanojevic@gmail.com>
 <4e0dac35d2751f51e033b360e65bdd10edf4bb35.1460316026.git.ksenija.stanojevic@gmail.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <571291BB.8040100@kernel.org>
Date: Sat, 16 Apr 2016 20:25:47 +0100
MIME-Version: 1.0
In-Reply-To: <4e0dac35d2751f51e033b360e65bdd10edf4bb35.1460316026.git.ksenija.stanojevic@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/04/16 20:20, Ksenija Stanojevic wrote:
> Indent lines inside if statement.
> 
> Signed-off-by: Ksenija Stanojevic <ksenija.stanojevic@gmail.com>
Applied to the togreg branch of iio.git - initially pushed out as testing.

Thanks,

Jonathan
> ---
>  drivers/iio/adc/mxs-lradc.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/mxs-lradc.c b/drivers/iio/adc/mxs-lradc.c
> index 33051b8..07287af 100644
> --- a/drivers/iio/adc/mxs-lradc.c
> +++ b/drivers/iio/adc/mxs-lradc.c
> @@ -1500,9 +1500,10 @@ static int mxs_lradc_hw_init(struct mxs_lradc *lradc)
>  		mxs_lradc_reg_clear(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
>  				    LRADC_CTRL0);
>  
> -	if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
> -		mxs_lradc_reg_set(lradc, LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> -				  LRADC_CTRL0);
> +		if (lradc->use_touchscreen == MXS_LRADC_TOUCHSCREEN_5WIRE)
> +			mxs_lradc_reg_set(lradc,
> +					  LRADC_CTRL0_MX28_TOUCH_SCREEN_TYPE,
> +					  LRADC_CTRL0);
>  	}
>  
>  	/* Start internal temperature sensing. */
> 

