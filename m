Return-Path: <knaack.h@gmx.de>
Message-ID: <5488CA94.3000406@gmx.de>
Date: Wed, 10 Dec 2014 23:35:00 +0100
From: Hartmut Knaack <knaack.h@gmx.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>,
 Jonathan Cameron <jic23@kernel.org>
CC: Peter Meerwald <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 04/11] staging:iio:sca3000: Register same channels
 for device and buffer
References: <1417024517-7564-1-git-send-email-lars@metafoo.de> <1417024517-7564-5-git-send-email-lars@metafoo.de>
In-Reply-To: <1417024517-7564-5-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-15
List-ID: <linux-iio@vger.kernel.org>

Lars-Peter Clausen schrieb am 26.11.2014 um 18:55:
> In preparation for moving the buffer registration to the core make sure to
> register the same channel array for the device and the buffer. Currently
> the temperature channel is not registered for the buffer, setting its scan
> index to -1 will make sure that it is skipped for the buffer.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
>  drivers/staging/iio/accel/sca3000_core.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/staging/iio/accel/sca3000_core.c b/drivers/staging/iio/accel/sca3000_core.c
> index cd46a61..9eedb93 100644
> --- a/drivers/staging/iio/accel/sca3000_core.c
> +++ b/drivers/staging/iio/accel/sca3000_core.c
> @@ -459,6 +459,7 @@ static const struct iio_chan_spec sca3000_channels_with_temp[] = {
>  		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>  		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) |
>  			BIT(IIO_CHAN_INFO_OFFSET),
> +		.scan_index = -1,
>  	},
>  };
>  
> @@ -1154,9 +1155,8 @@ static int sca3000_probe(struct spi_device *spi)
>  	if (ret < 0)
>  		return ret;
>  
> -	ret = iio_buffer_register(indio_dev,
> -				  sca3000_channels,
> -				  ARRAY_SIZE(sca3000_channels));
> +	ret = iio_buffer_register(indio_dev, indio_dev->channels,
> +		indio_dev->num_channels);
Indentation could be better here, otherwise looking good to me (including
previous patches in this series).
>  	if (ret < 0)
>  		goto error_unregister_dev;
>  
> 
