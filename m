Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:35485 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755186AbcJHQoT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 8 Oct 2016 12:44:19 -0400
Subject: Re: [PATCH v4 1/2] staging: iio: ad7606: fix improper setting of
 oversampling pins
To: Eva Rachel Retuya <eraretuya@gmail.com>, linux-iio@vger.kernel.org,
        outreachy-kernel@googlegroups.com
References: <cover.1475942324.git.eraretuya@gmail.com>
 <b1ac6778d27e1406a8fd83b329266fce6144248e.1475942324.git.eraretuya@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, gregkh@linuxfoundation.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <1f33d844-e8da-c2fc-0a0a-7e32a8be8fc0@kernel.org>
Date: Sat, 8 Oct 2016 17:44:15 +0100
MIME-Version: 1.0
In-Reply-To: <b1ac6778d27e1406a8fd83b329266fce6144248e.1475942324.git.eraretuya@gmail.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 08/10/16 17:05, Eva Rachel Retuya wrote:
> The oversampling ratio is controlled using the oversampling pins,
> OS [2:0] with OS2 being the MSB control bit, and OS0 the LSB control
> bit.
> 
> The gpio connected to the OS2 pin is not being set correctly, only OS0
> and OS1 pins are being set. Fix the typo to allow proper control of the
> oversampling pins.
> 
> Signed-off-by: Eva Rachel Retuya <eraretuya@gmail.com>
> Fixes: b9618c0 ("staging: IIO: ADC: New driver for AD7606/AD7606-6/AD7606-4")
> Acked-by: Lars-Peter Clausen <lars@metafoo.de>
I've applied this to the togreg branch of iio.git, but not currently marked
it for stable.  Primarily because it has been broken for a very long time.
If anyone wants this in stable, then feel free to shout out and we can send the
request to stable once it has merged.

Applied to the togreg branch and pushed out as testing for the autobuilders to
play with it.

Thanks,

Jonathan
> ---
>  drivers/staging/iio/adc/ad7606_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_core.c b/drivers/staging/iio/adc/ad7606_core.c
> index f79ee61..cbd6bc5 100644
> --- a/drivers/staging/iio/adc/ad7606_core.c
> +++ b/drivers/staging/iio/adc/ad7606_core.c
> @@ -189,7 +189,7 @@ static ssize_t ad7606_store_oversampling_ratio(struct device *dev,
>  	mutex_lock(&indio_dev->mlock);
>  	gpio_set_value(st->pdata->gpio_os0, (ret >> 0) & 1);
>  	gpio_set_value(st->pdata->gpio_os1, (ret >> 1) & 1);
> -	gpio_set_value(st->pdata->gpio_os1, (ret >> 2) & 1);
> +	gpio_set_value(st->pdata->gpio_os2, (ret >> 2) & 1);
>  	st->oversampling = lval;
>  	mutex_unlock(&indio_dev->mlock);
>  
> 

