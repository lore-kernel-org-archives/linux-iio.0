Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56824 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752271Ab3IULM5 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:12:57 -0400
Message-ID: <523D8D5E.7040405@kernel.org>
Date: Sat, 21 Sep 2013 13:13:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 10/24] iio:max1363: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-10-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-10-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/adc/max1363.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
> 
> diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
> index 1e7160d..b4bc166 100644
> --- a/drivers/iio/adc/max1363.c
> +++ b/drivers/iio/adc/max1363.c
> @@ -1436,7 +1436,6 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	struct iio_poll_func *pf = p;
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct max1363_state *st = iio_priv(indio_dev);
> -	s64 time_ns;
>  	__u8 *rxbuf;
>  	int b_sent;
>  	size_t d_size;
> @@ -1470,11 +1469,7 @@ static irqreturn_t max1363_trigger_handler(int irq, void *p)
>  	if (b_sent < 0)
>  		goto done_free;
>  
> -	time_ns = iio_get_time_ns();
> -
> -	if (indio_dev->scan_timestamp)
> -		memcpy(rxbuf + d_size - sizeof(s64), &time_ns, sizeof(time_ns));
> -	iio_push_to_buffers(indio_dev, rxbuf);
> +	iio_push_to_buffers_with_timestamp(indio_dev, rxbuf, iio_get_time_ns());
>  
>  done_free:
>  	kfree(rxbuf);
> 
