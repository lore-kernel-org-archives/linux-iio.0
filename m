Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:35020 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751775AbdL2Rzw (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:55:52 -0500
Date: Fri, 29 Dec 2017 17:55:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 4/4] Drivers:iio:adc: else is not generally useful after
 a break or return
Message-ID: <20171229175547.206795de@archlinux>
In-Reply-To: <1514566389-3485-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1514566389-3485-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 29 Dec 2017 22:23:09 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> Fixes checkpatch warnings:
> WARNING: else is not generally useful after a break or return
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>

Please then run checkpatch on the result + ideally sparse / smatch.

The result of this is wrong indentation.

Jonathan

> ---
>  drivers/iio/adc/at91_adc.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 7b40925..da18c04 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -939,7 +939,6 @@ static int at91_adc_probe_dt(struct at91_adc_state *st,
>  	/* Check if touchscreen is supported. */
>  	if (st->caps->has_ts)
>  		return at91_adc_probe_dt_ts(node, st, &idev->dev);
> -	else
>  		dev_info(&idev->dev, "not support touchscreen in the adc compatible string.\n");
> 
>  	return 0;
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

