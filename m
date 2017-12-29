Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55156 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751152AbdL2Rab (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 29 Dec 2017 12:30:31 -0500
Date: Fri, 29 Dec 2017 17:30:26 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: venkat.prashanth2498@gmail.com
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] Drivers:iio:adc : fix quoted string split across
 lines issue in at91_adc.c
Message-ID: <20171229173026.30bf8760@archlinux>
In-Reply-To: <1513519701-3421-1-git-send-email-venkat.prashanth2498@gmail.com>
References: <1513519701-3421-1-git-send-email-venkat.prashanth2498@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Sun, 17 Dec 2017 19:38:21 +0530
venkat.prashanth2498@gmail.com wrote:

> From: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> 
> This is a patch to the at91_adc.c file that fixes up a quoted string split
> across lines warning found by the checkpatch.pl tool
> 
> Signed-off-by: Venkat Prashanth B U <venkat.prashanth2498@gmail.com>
> ---
>  drivers/iio/adc/at91_adc.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index a4767d6..c3729f8 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -737,8 +737,8 @@ static int at91_adc_of_get_resolution(struct at91_adc_state *st,
> 
>  count = of_property_count_strings(np, "atmel,adc-res-names");
>  if (count < 2) {
> -dev_err(&idev->dev, "You must specified at least two resolution names for "
> -	"adc-res-names property in the DT\n");
> +dev_err(&idev->dev, "You must specified at least two resolution names for
> +	adc-res-names property in the DT\n");
This still seems to be on two lines.

The check patch is complaining because such a broken string is difficult to
grep for. It's still difficult like this.

Key thing here is that the ability to grep for the string is more important than
the 80 character limit.

Jonathan

>  	return count;
>  }
> 
> --
> 1.9.1
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

