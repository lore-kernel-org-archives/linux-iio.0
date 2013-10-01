Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51545 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751509Ab3JAHx2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:53:28 -0400
Message-ID: <524A8DA3.1050201@kernel.org>
Date: Tue, 01 Oct 2013 09:53:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 09/25] iio:ad5755: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied.
> ---
>  drivers/iio/dac/ad5755.c | 17 +++++------------
>  1 file changed, 5 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
> index f305a0c..bd31dbc 100644
> --- a/drivers/iio/dac/ad5755.c
> +++ b/drivers/iio/dac/ad5755.c
> @@ -253,15 +253,6 @@ static inline int ad5755_get_offset(struct ad5755_state *st,
>  	return (min * (1 << chan->scan_type.realbits)) / (max - min);
>  }
>  
> -static inline int ad5755_get_scale(struct ad5755_state *st,
> -	struct iio_chan_spec const *chan)
> -{
> -	int min, max;
> -
> -	ad5755_get_min_max(st, chan, &min, &max);
> -	return ((max - min) * 1000000000ULL) >> chan->scan_type.realbits;
> -}
> -
>  static int ad5755_chan_reg_info(struct ad5755_state *st,
>  	struct iio_chan_spec const *chan, long info, bool write,
>  	unsigned int *reg, unsigned int *shift, unsigned int *offset)
> @@ -303,13 +294,15 @@ static int ad5755_read_raw(struct iio_dev *indio_dev,
>  {
>  	struct ad5755_state *st = iio_priv(indio_dev);
>  	unsigned int reg, shift, offset;
> +	int min, max;
>  	int ret;
>  
>  	switch (info) {
>  	case IIO_CHAN_INFO_SCALE:
> -		*val = 0;
> -		*val2 = ad5755_get_scale(st, chan);
> -		return IIO_VAL_INT_PLUS_NANO;
> +		ad5755_get_min_max(st, chan, &min, &max);
> +		*val = max - min;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	case IIO_CHAN_INFO_OFFSET:
>  		*val = ad5755_get_offset(st, chan);
>  		return IIO_VAL_INT;
> 
