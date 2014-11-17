Return-Path: <lars@metafoo.de>
Message-ID: <5469B7FF.6050500@metafoo.de>
Date: Mon, 17 Nov 2014 09:55:27 +0100
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Fabien Proriol <Fabien.Proriol@jdsu.com>,
 Jonathan Cameron <jic23@kernel.org>,
 Michal Simek <michal.simek@xilinx.com>,
 "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: [PATCH] 0001-xilinx-xadc-core-Fix-voltage-offset.patch
References: <545B9479.5030700@jdsu.com> <545B976D.4080303@metafoo.de> <545B9EF1.8000606@jdsu.com> <545BA105.70105@metafoo.de> <545BA802.5090206@jdsu.com> <54690AE5.4050900@metafoo.de> <5469B725.8080908@jdsu.com>
In-Reply-To: <5469B725.8080908@jdsu.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
List-ID: <linux-iio@vger.kernel.org>

On 11/17/2014 09:53 AM, Fabien Proriol wrote:
>  From bdeab2d72a00587eac15eb91ec0820ff6d11bfe8 Mon Sep 17 00:00:00 2001
> From: Fabien Proriol <fabien.proriol@jdsu.com>
> Date: Mon, 17 Nov 2014 09:46:02 +0100
> Subject: [PATCH] iio: Fix iio_channel_read return if channel havn't info
>
> iio_channel_read must return an error to avoid offset for channel
> without IIO_CHAN_INFO_OFFSET property
>
> Signed-off-by: Fabien Proriol <fabien.proriol@jdsu.com>

Reviewed-by: Lars-Peter Clausen <lars@metafoo.de>

Thanks.

> ---
>   drivers/iio/inkern.c | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/iio/inkern.c b/drivers/iio/inkern.c
> index 1e8e94d..917eb00 100644
> --- a/drivers/iio/inkern.c
> +++ b/drivers/iio/inkern.c
> @@ -423,6 +423,9 @@ static int iio_channel_read(struct iio_channel *chan, int *val, int *val2,
>   	if (val2 == NULL)
>   		val2 = &unused;
>
> +	if(!iio_channel_has_info(chan->channel, info))
> +		return -EINVAL;
> +
>   	return chan->indio_dev->info->read_raw(chan->indio_dev, chan->channel,
>   						val, val2, info);
>   }
>
