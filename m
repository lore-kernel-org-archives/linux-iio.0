Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55718 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753141AbeAFMrP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 6 Jan 2018 07:47:15 -0500
Date: Sat, 6 Jan 2018 12:47:10 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers:iio:adc: remove comparison to bool
Message-ID: <20180106124710.27a6f71d@archlinux>
In-Reply-To: <1515123837-32473-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1515123837-32473-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri,  5 Jan 2018 09:13:57 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is the patch to the file ti_am335x_adc.c
> which fixes the following coccinelle warning:
> 
> WARNING: Comparison to bool
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
Applied to the togreg branch of iio.git with the subject changed
so that it says what driver this is effecting.

A directory isn't much use to anyone when there are lots of drivers
in it.

I'm what was patch 1/2?

Jonathan
> ---
>  drivers/iio/adc/ti_am335x_adc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index b3e573c..80df5a3 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -523,7 +523,7 @@ static int tiadc_read_raw(struct iio_dev *indio_dev,
>  	}
>  	am335x_tsc_se_adc_done(adc_dev->mfd_tscadc);
>  
> -	if (found == false)
> +	if (!found)
>  		ret =  -EBUSY;
>  
>  err_unlock:

