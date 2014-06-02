Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:60363 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750927AbaFBR6U (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 2 Jun 2014 13:58:20 -0400
Message-ID: <538CBBA6.30203@kernel.org>
Date: Mon, 02 Jun 2014 19:00:06 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Paul Kocialkowski <contact@paulk.fr>
CC: linux-iio@vger.kernel.org, j-keerthy@ti.com,
	Sebastian Reichel <sre@debian.org>
Subject: Re: [PATCH] twl4030-madc: Request processed values in twl4030_get_madc_conversion
References: <1400933398.2079.16.camel@aldrin>
In-Reply-To: <1400933398.2079.16.camel@aldrin>
Content-Type: text/plain; charset=UTF-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 24/05/14 13:09, Paul Kocialkowski wrote:
> Not setting the raw parameter in the request causes it to be randomly
> initialized to a value that might be different from zero or zero. This leads to
> values that are randomly either raw or processed, making it very difficult to
> make reliable use of the values.
>
> Signed-off-by: Paul Kocialkowski <contact@paulk.fr>
This one seems obvious enough to me that I've applied it to the fixes-togreg
branch. Note you should cc the author or if the log makes it clear someone
else has been working with the driver recently, then cc them.
In this case Sebastian.

With quite a few of these mfd element drivers, the chance the relevant author
is still subscribed to the list is next to none (here goes for being proved
wrong ;)

Thanks for the patch!

Jonathan


> ---
>   drivers/iio/adc/twl4030-madc.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/iio/adc/twl4030-madc.c b/drivers/iio/adc/twl4030-madc.c
> index 7de1c4c..eb86786 100644
> --- a/drivers/iio/adc/twl4030-madc.c
> +++ b/drivers/iio/adc/twl4030-madc.c
> @@ -645,6 +645,7 @@ int twl4030_get_madc_conversion(int channel_no)
>   	req.channels = (1 << channel_no);
>   	req.method = TWL4030_MADC_SW2;
>   	req.active = 0;
> +	req.raw = 0;
>   	req.func_cb = NULL;
>   	ret = twl4030_madc_conversion(&req);
>   	if (ret < 0)
>

