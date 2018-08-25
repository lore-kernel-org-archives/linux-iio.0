Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:36566 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725815AbeHYM0C (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 25 Aug 2018 08:26:02 -0400
Date: Sat, 25 Aug 2018 09:47:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcus Folkesson <marcus.folkesson@gmail.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Michael Welling <mwelling@ieee.org>
Subject: Re: [PATCH] iio: dac: mcp4922: fix error handling in
 mcp4922_write_raw
Message-ID: <20180825094741.4581deb0@archlinux>
In-Reply-To: <20180824202440.21754-1-marcus.folkesson@gmail.com>
References: <20180824202440.21754-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 24 Aug 2018 22:24:40 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Do not try to write negative values and make sure that the write goes well.
> 
+CC Michael as it's his driver.

I'll take this as it 'appears' straight forward but I won't be pushing
it out as a non rebasing branch for a few days if I've missed anything.

Applied to the togreg branch of iio.git and pushed out for now as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/iio/dac/mcp4922.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/mcp4922.c b/drivers/iio/dac/mcp4922.c
> index bf9aa3fc0534..b5190d1dae8e 100644
> --- a/drivers/iio/dac/mcp4922.c
> +++ b/drivers/iio/dac/mcp4922.c
> @@ -94,17 +94,22 @@ static int mcp4922_write_raw(struct iio_dev *indio_dev,
>  		long mask)
>  {
>  	struct mcp4922_state *state = iio_priv(indio_dev);
> +	int ret;
>  
>  	if (val2 != 0)
>  		return -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > GENMASK(chan->scan_type.realbits-1, 0))
> +		if (val < 0 || val > GENMASK(chan->scan_type.realbits - 1, 0))
>  			return -EINVAL;
>  		val <<= chan->scan_type.shift;
> -		state->value[chan->channel] = val;
> -		return mcp4922_spi_write(state, chan->channel, val);
> +
> +		ret = mcp4922_spi_write(state, chan->channel, val);
> +		if (!ret)
> +			state->value[chan->channel] = val;
> +		return ret;
> +
>  	default:
>  		return -EINVAL;
>  	}
