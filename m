Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40151 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916Ab1JSM5e (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 19 Oct 2011 08:57:34 -0400
Message-ID: <4E9EC942.7060305@cam.ac.uk>
Date: Wed, 19 Oct 2011 13:57:38 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org,
	device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH 1/4] staging:iio:dac:ad5791: Use correct DAC bit-size
References: <1319027030-9696-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1319027030-9696-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/19/11 13:23, Lars-Peter Clausen wrote:
> Commit c5b99396 ("staging:iio:dac:ad5791 chan spec conversion.") introduced a
> small bug, using storagebits instead of realbits throughout the driver, which
> causes the driver to work incorrectly. This patch fixes it.
oops
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/dac/ad5791.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/dac/ad5791.c b/drivers/staging/iio/dac/ad5791.c
> index fbf446d..9a76c43 100644
> --- a/drivers/staging/iio/dac/ad5791.c
> +++ b/drivers/staging/iio/dac/ad5791.c
> @@ -234,11 +234,11 @@ static int ad5791_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		*val &= AD5791_DAC_MASK;
>  		*val >>= chan->scan_type.shift;
> -		*val -= (1 << (chan->scan_type.storagebits - 1));
> +		*val -= (1 << (chan->scan_type.realbits - 1));
>  		return IIO_VAL_INT;
>  	case (1 << IIO_CHAN_INFO_SCALE_SHARED):
>  		*val = 0;
> -		*val2 = (st->vref_mv * 1000) >> chan->scan_type.storagebits;
> +		*val2 = (st->vref_mv * 1000) >> chan->scan_type.realbits;
>  		return IIO_VAL_INT_PLUS_MICRO;
>  	default:
>  		return -EINVAL;
> @@ -257,8 +257,8 @@ static int ad5791_write_raw(struct iio_dev *indio_dev,
>  
>  	switch (mask) {
>  	case 0:
> -		val += (1 << (chan->scan_type.storagebits - 1));
> -		val &= AD5791_RES_MASK(chan->scan_type.storagebits);
> +		val += (1 << (chan->scan_type.realbits - 1));
> +		val &= AD5791_RES_MASK(chan->scan_type.realbits);
>  		val <<= chan->scan_type.shift;
>  
>  		return ad5791_spi_write(st->spi, chan->address, val);

