Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932275AbdJZQdU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 26 Oct 2017 12:33:20 -0400
Date: Thu, 26 Oct 2017 17:33:14 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-iio@vger.kernel.org, Alison Schofield <amsfield22@gmail.com>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        LKML <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio/adc/palmas: Use common error handling code in
 palmas_gpadc_calibrate()
Message-ID: <20171026173314.0bd5fd27@archlinux>
In-Reply-To: <0ae3662d-6a74-622c-0423-e8552ea79bca@users.sourceforge.net>
References: <0ae3662d-6a74-622c-0423-e8552ea79bca@users.sourceforge.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 26 Oct 2017 08:08:49 +0200
SF Markus Elfring <elfring@users.sourceforge.net> wrote:

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Thu, 26 Oct 2017 07:58:03 +0200
> 
> * Add a jump target so that a specific error message is stored only once
>   at the end of this function implementation.
> 
> * Adjust condition checks.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Markus,

You need to a apply a check in these cases. If the code is harder
to read afterwards and hence more prone to bugs being introduced
now or in future, it is not a good change.

As such I won't be taking this sort of change.

Jonathan
> ---
>  drivers/iio/adc/palmas_gpadc.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/iio/adc/palmas_gpadc.c b/drivers/iio/adc/palmas_gpadc.c
> index 69b9affeef1e..5e6566692d46 100644
> --- a/drivers/iio/adc/palmas_gpadc.c
> +++ b/drivers/iio/adc/palmas_gpadc.c
> @@ -304,17 +304,13 @@ static int palmas_gpadc_calibrate(struct palmas_gpadc *adc, int adc_chan)
>  
>  	ret = palmas_read(adc->palmas, PALMAS_TRIM_GPADC_BASE,
>  				adc->adc_info[adc_chan].trim1_reg, &d1);
> -	if (ret < 0) {
> -		dev_err(adc->dev, "TRIM read failed: %d\n", ret);
> -		goto scrub;
> -	}
> +	if (ret)
> +		goto report_failure;
>  
>  	ret = palmas_read(adc->palmas, PALMAS_TRIM_GPADC_BASE,
>  				adc->adc_info[adc_chan].trim2_reg, &d2);
> -	if (ret < 0) {
> -		dev_err(adc->dev, "TRIM read failed: %d\n", ret);
> -		goto scrub;
> -	}
> +	if (ret)
> +		goto report_failure;
>  
>  	/* gain error calculation */
>  	k = (1000 + (1000 * (d2 - d1)) / (x2 - x1));
> @@ -329,6 +325,10 @@ static int palmas_gpadc_calibrate(struct palmas_gpadc *adc, int adc_chan)
>  
>  scrub:
>  	return ret;
> +
> +report_failure:

This makes for complex code flow where it is not needed. As such I am
not going to even think about taking this sort of patch.

> +	dev_err(adc->dev, "TRIM read failed: %d\n", ret);
> +	goto scrub;
>  }
>  
>  static int palmas_gpadc_start_conversion(struct palmas_gpadc *adc, int adc_chan)

