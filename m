Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56749 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752396Ab3IULJq (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:09:46 -0400
Message-ID: <523D8C9F.1010700@kernel.org>
Date: Sat, 21 Sep 2013 13:10:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 03/24] iio:ad7266: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-3-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-3-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/adc/ad7266.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index c304966..656aa3e 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -96,9 +96,8 @@ static irqreturn_t ad7266_trigger_handler(int irq, void *p)
>  
>  	ret = spi_read(st->spi, st->data, 4);
>  	if (ret == 0) {
> -		if (indio_dev->scan_timestamp)
> -			((s64 *)st->data)[1] = pf->timestamp;
> -		iio_push_to_buffers(indio_dev, st->data);
> +		iio_push_to_buffers_with_timestamp(indio_dev, st->data,
> +			    pf->timestamp);
>  	}
>  
>  	iio_trigger_notify_done(indio_dev->trig);
> 
