Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56729 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752353Ab3IULIc (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:08:32 -0400
Message-ID: <523D8C54.7060507@kernel.org>
Date: Sat, 21 Sep 2013 13:08:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org,
	Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Subject: Re: [PATCH 02/24] iio:bma180: Use iio_push_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-2-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code shorter and a bit less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Oleksandr Kravchenko <o.v.kravchenko@globallogic.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/accel/bma180.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/iio/accel/bma180.c b/drivers/iio/accel/bma180.c
> index 3eff246..bda7a83 100644
> --- a/drivers/iio/accel/bma180.c
> +++ b/drivers/iio/accel/bma180.c
> @@ -471,13 +471,10 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct bma180_data *data = iio_priv(indio_dev);
> +	int64_t time_ns = iio_get_time_ns();
>  	int bit, ret, i = 0;
>  
>  	mutex_lock(&data->mutex);
> -	if (indio_dev->scan_timestamp) {
> -		ret = indio_dev->scan_bytes / sizeof(s64) - 1;
> -		((s64 *)data->buff)[ret] = iio_get_time_ns();
> -	}
>  
>  	for_each_set_bit(bit, indio_dev->buffer->scan_mask,
>  			 indio_dev->masklength) {
> @@ -490,7 +487,7 @@ static irqreturn_t bma180_trigger_handler(int irq, void *p)
>  	}
>  	mutex_unlock(&data->mutex);
>  
> -	iio_push_to_buffers(indio_dev, data->buff);
> +	iio_push_to_buffers_with_timestamp(indio_dev, data->buff, time_ns);
>  err:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> 
