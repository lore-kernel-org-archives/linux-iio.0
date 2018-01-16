Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from szxga04-in.huawei.com ([45.249.212.190]:4204 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1750802AbeAPKrP (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 16 Jan 2018 05:47:15 -0500
Date: Tue, 16 Jan 2018 10:46:47 +0000
From: Jonathan Cameron <Jonathan.Cameron@huawei.com>
To: <alexandru.ardelean@analog.com>
CC: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>
Subject: Re: [PATCH][RESEND] staging: iio: adc: ad7192: disable burnout
 currents on misconfig
Message-ID: <20180116104647.0000656e@huawei.com>
In-Reply-To: <20180116100437.10220-1-alexandru.ardelean@analog.com>
References: <20180116100437.10220-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 16 Jan 2018 12:04:37 +0200
<alexandru.ardelean@analog.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 

Firstly, even a change to a description makes this a V2 patch
not a resend.  Resends should be identical and only occur if
either:
1) Someone asks you to resend for some reason (wrong cc's perhaps)
2) It has been a long time since anyone responded and looks like
your series has been forgotten.

> According to the datasheet for all ad719x ADCs,
> the burnout currents can be enabled only if buffer is enabled
> and CHOP is disabled.
> 
> So, if neither of these conditions are met, then
> we should disable the burnout currents in the driver as well,
> and warn the user.
> 
> This change doesn't fix anything.
> The burnout currents simply won't work if CHOP is enabled
> or buffer is disabled.
> The intent is to provide the user with some feedback
> instead of silently not working inside the chip.
> 
> This is especially useful when considering device-tree
> support (and/or device-tree overlays) at a later point,
> which will allow for a quicker/simpler reconfiguration
> of the chip settings.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>
Thanks, much better description. I'll pick this up when I'm next
on the correct PC (possibly not until the weekend).

Jonathan

> ---
>  drivers/staging/iio/adc/ad7192.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/staging/iio/adc/ad7192.c b/drivers/staging/iio/adc/ad7192.c
> index d11c6de9c777..7f204013d6d4 100644
> --- a/drivers/staging/iio/adc/ad7192.c
> +++ b/drivers/staging/iio/adc/ad7192.c
> @@ -266,6 +266,12 @@ static int ad7192_setup(struct ad7192_state *st,
>  
>  	st->conf = AD7192_CONF_GAIN(0);
>  
> +	if (pdata->burnout_curr_en && (!pdata->buf_en || pdata->chop_en)) {
> +		pdata->burnout_curr_en = false;
> +		dev_warn(dev,
> +			 "Can't enable burnout currents: see CHOP or buffer\n");
> +	}
> +
>  	if (pdata->rej60_en)
>  		st->mode |= AD7192_MODE_REJ60;
>  

