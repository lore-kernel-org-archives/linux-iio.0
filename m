Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:51526 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751518Ab3JAHwO (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 1 Oct 2013 03:52:14 -0400
Message-ID: <524A8D5A.1030608@kernel.org>
Date: Tue, 01 Oct 2013 09:52:42 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 07/25] iio:ad5624r: Report scale as fractional value
References: <1380360717-26103-1-git-send-email-lars@metafoo.de> <1380360717-26103-7-git-send-email-lars@metafoo.de>
In-Reply-To: <1380360717-26103-7-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/28/13 10:31, Lars-Peter Clausen wrote:
> Move the complexity of calculating the fixed point scale to the core.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>  drivers/iio/dac/ad5624r_spi.c | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/dac/ad5624r_spi.c b/drivers/iio/dac/ad5624r_spi.c
> index dbb1289..774dd96 100644
> --- a/drivers/iio/dac/ad5624r_spi.c
> +++ b/drivers/iio/dac/ad5624r_spi.c
> @@ -50,15 +50,12 @@ static int ad5624r_read_raw(struct iio_dev *indio_dev,
>  			   long m)
>  {
>  	struct ad5624r_state *st = iio_priv(indio_dev);
> -	unsigned long scale_uv;
>  
>  	switch (m) {
>  	case IIO_CHAN_INFO_SCALE:
> -		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
> -		*val =  scale_uv / 1000;
> -		*val2 = (scale_uv % 1000) * 1000;
> -		return IIO_VAL_INT_PLUS_MICRO;
> -
> +		*val = st->vref_mv;
> +		*val2 = chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL_LOG2;
>  	}
>  	return -EINVAL;
>  }
> 
