Return-Path: <jic23@kernel.org>
Message-ID: <4F96DB47.30800@kernel.org>
Date: Tue, 24 Apr 2012 17:56:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>, linux-iio@vger.kernel.org,
 device-drivers-devel@blackfin.uclinux.org, drivers@analog.com
Subject: Re: [PATCH v2 09/11] staging:iio:dac:ad5446: Return cached value
 for 'raw' attribute
References: <1335286181-20474-1-git-send-email-lars@metafoo.de> <1335286181-20474-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1335286181-20474-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 04/24/2012 05:49 PM, Lars-Peter Clausen wrote:
> We can not read back the value from the device, but we cache the value anyway so
> we might as well return the cached value instead of an error.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@kernel.org>
> ---
>  drivers/staging/iio/dac/ad5446.c |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/staging/iio/dac/ad5446.c b/drivers/staging/iio/dac/ad5446.c
> index 731cd05..9dc67c8 100644
> --- a/drivers/staging/iio/dac/ad5446.c
> +++ b/drivers/staging/iio/dac/ad5446.c
> @@ -229,6 +229,9 @@ static int ad5446_read_raw(struct iio_dev *indio_dev,
>  	unsigned long scale_uv;
>  
>  	switch (m) {
> +	case IIO_CHAN_INFO_RAW:
> +		*val = st->cached_val;
> +		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
>  		scale_uv = (st->vref_mv * 1000) >> chan->scan_type.realbits;
>  		*val =  scale_uv / 1000;
