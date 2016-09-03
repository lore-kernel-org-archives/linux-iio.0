Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:45183 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754064AbcICQWf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 3 Sep 2016 12:22:35 -0400
Subject: Re: [PATCH] iio: dac: ad5446: return unshifted values in read_raw
To: =?UTF-8?Q?Martin_Hundeb=c3=b8ll?= <mnhu@prevas.dk>,
        linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
References: <20160830062743.10611-1-mnhu@prevas.dk>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <9943db15-38f5-3f6f-416a-d93420843bfb@kernel.org>
Date: Sat, 3 Sep 2016 17:21:16 +0100
MIME-Version: 1.0
In-Reply-To: <20160830062743.10611-1-mnhu@prevas.dk>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 30/08/16 07:27, Martin Hundebøll wrote:
> The Analog Devices DAC chips supported by the ad5456 driver ignore
> between 0 and 6 of the least significant bits, and thus the written raw
> value is shifted accordingly before being cached and written.
> 
> Since the shifted value is cached, it is returned to the user in
> ad5446_read_raw(), which might be confusing to the user (at least it was
> for me).
> 
> Instead store the unshifted value and do the shifting when needed (i.e.
> when writing data and disabling powerdown mode).
> 
> Signed-off-by: Martin Hundebøll <mnhu@prevas.dk>
Lars?

Looks right to me, could you just sanity check this.
Stable material I think.

Jonathan
> ---
>  drivers/iio/dac/ad5446.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5446.c b/drivers/iio/dac/ad5446.c
> index 46bb62a..8d172d7 100644
> --- a/drivers/iio/dac/ad5446.c
> +++ b/drivers/iio/dac/ad5446.c
> @@ -118,7 +118,7 @@ static ssize_t ad5446_write_dac_powerdown(struct iio_dev *indio_dev,
>  		shift = chan->scan_type.realbits + chan->scan_type.shift;
>  		val = st->pwr_down_mode << shift;
>  	} else {
> -		val = st->cached_val;
> +		val = st->cached_val << chan->scan_type.shift;
>  	}
>  
>  	ret = st->chip_info->write(st, val);
> @@ -195,9 +195,9 @@ static int ad5446_write_raw(struct iio_dev *indio_dev,
>  		if (val >= (1 << chan->scan_type.realbits) || val < 0)
>  			return -EINVAL;
>  
> -		val <<= chan->scan_type.shift;
>  		mutex_lock(&indio_dev->mlock);
>  		st->cached_val = val;
> +		val <<= chan->scan_type.shift;
>  		if (!st->pwr_down)
>  			ret = st->chip_info->write(st, val);
>  		mutex_unlock(&indio_dev->mlock);
> 

