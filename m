Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51645 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751564Ab3JAIBF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 04:01:05 -0400
Message-ID: <524A8F6C.8000200@kernel.org>
Date: Tue, 01 Oct 2013 10:01:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 11/25] iio:ad5791: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-11-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-11-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
The minus 1 in here had me confused for a bit, but that is indeed
the transfer function given in the datasheet.

Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/ad5791.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5791.c b/drivers/iio/dac/ad5791.c
> index 3cee89b..d64acbd 100644
> --- a/drivers/iio/dac/ad5791.c
> +++ b/drivers/iio/dac/ad5791.c
> @@ -270,9 +270,9 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>  		*val >>= chan->scan_type.shift;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = (((u64)st->vref_mv) * 1000000ULL) >> chan->scan_type.realbits;
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		*val = st->vref_mv;
> +		*val2 = (1 << chan->scan_type.realbits) - 1;
> +		return IIO_VAL_FRACTIONAL;
>  	case IIO_CHAN_INFO_OFFSET:
>  		val64 = (((u64)st->vref_neg_mv) << chan->scan_type.realbits);
>  		do_div(val64, st->vref_mv);
> 
