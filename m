Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:38498 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751015AbeANMdt (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 14 Jan 2018 07:33:49 -0500
Date: Sun, 14 Jan 2018 12:33:46 +0000
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: <alexandru.ardelean@analog.com>
Cc: <linux-iio@vger.kernel.org>, <michael.hennerich@analog.com>
Subject: Re: [PATCH] staging: iio: adc: ad7192: disable burnout currents on
 misconfig
Message-ID: <20180114123346.3c8ffd53@archlinux>
In-Reply-To: <20180110111411.18505-1-alexandru.ardelean@analog.com>
References: <20180110111411.18505-1-alexandru.ardelean@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 10 Jan 2018 13:14:11 +0200
<alexandru.ardelean@analog.com> wrote:

> From: Alexandru Ardelean <alexandru.ardelean@analog.com>
> 
> According to the datasheet for all ad719x ADCs,
> the burnout currents can be enabled only if buffer is enabled
> and CHOP is disabled.
> 
> So, if neither of these conditions are met, then
> we should disable the burnout currents in the driver as well,
> and warn the user.
> 
> Signed-off-by: Alexandru Ardelean <alexandru.ardelean@analog.com>

What this patch is missing is a description of what the result of
getting this wrong is.  Does this break the device, cause fires
or just not work as expected?

We need this information to decided whether backporting to stable
is required or not.

Patch content is fine.

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

