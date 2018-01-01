Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45752 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751059AbeAAKN5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Mon, 1 Jan 2018 05:13:57 -0500
Date: Mon, 1 Jan 2018 10:13:52 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 7/7] Drivers:iio:adc: Fix space prohibited before that
 ','
Message-ID: <20180101101352.0ce18a5b@archlinux>
In-Reply-To: <1514624686-8485-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1514624686-8485-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sat, 30 Dec 2017 14:34:46 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to the ad799x.c file that fixes
> ERROR: space prohibited before that ','
> found by the checkpatch.pl tool
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

I'm curious.  What tree are you looking in? This has been
fixed since a patch back in April 2016...

Jonathan

> ---
>  drivers/iio/adc/ad799x.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
> index 01d7158..a3f5254 100644
> --- a/drivers/iio/adc/ad799x.c
> +++ b/drivers/iio/adc/ad799x.c
> @@ -477,7 +477,7 @@ static int ad799x_read_event_value(struct iio_dev *indio_dev,
>  	if (ret < 0)
>  		return ret;
>  	*val = (ret >> chan->scan_type.shift) &
> -		GENMASK(chan->scan_type.realbits - 1 , 0);
> +		GENMASK(chan->scan_type.realbits - 1, 0);
> 
>  	return IIO_VAL_INT;
>  }
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

