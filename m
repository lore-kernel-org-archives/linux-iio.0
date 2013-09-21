Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56944 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3IULST (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:18:19 -0400
Message-ID: <523D8E9F.8070104@kernel.org>
Date: Sat, 21 Sep 2013 13:18:39 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 20/24] staging:iio:ad7606: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-20-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-20-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/staging/iio/adc/ad7606_ring.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7606_ring.c b/drivers/staging/iio/adc/ad7606_ring.c
> index 2b25cb0..3bf174c 100644
> --- a/drivers/staging/iio/adc/ad7606_ring.c
> +++ b/drivers/staging/iio/adc/ad7606_ring.c
> @@ -46,7 +46,6 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
>  	struct ad7606_state *st = container_of(work_s, struct ad7606_state,
>  						poll_work);
>  	struct iio_dev *indio_dev = iio_priv_to_dev(st);
> -	s64 time_ns;
>  	__u8 *buf;
>  	int ret;
>  
> @@ -78,12 +77,7 @@ static void ad7606_poll_bh_to_ring(struct work_struct *work_s)
>  			goto done;
>  	}
>  
> -	time_ns = iio_get_time_ns();
> -
> -	if (indio_dev->scan_timestamp)
> -		*((s64 *)(buf + indio_dev->scan_bytes - sizeof(s64))) = time_ns;
> -
> -	iio_push_to_buffers(indio_dev, buf);
> +	iio_push_to_buffers_with_timestamp(indio_dev, buf, iio_get_time_ns());
>  done:
>  	gpio_set_value(st->pdata->gpio_convst, 0);
>  	iio_trigger_notify_done(indio_dev->trig);
> 
