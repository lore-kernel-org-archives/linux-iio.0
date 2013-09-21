Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56815 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752266Ab3IULMb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:12:31 -0400
Message-ID: <523D8D43.1020802@kernel.org>
Date: Sat, 21 Sep 2013 13:12:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Josh Wu <josh.wu@atmel.com>
Subject: Re: [PATCH 09/24] iio:at91_adc: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-9-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-9-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Josh Wu <josh.wu@atmel.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/adc/at91_adc.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
> index 6da5ebb..ee5f51ca 100644
> --- a/drivers/iio/adc/at91_adc.c
> +++ b/drivers/iio/adc/at91_adc.c
> @@ -83,13 +83,7 @@ static irqreturn_t at91_adc_trigger_handler(int irq, void *p)
>  		j++;
>  	}
>  
> -	if (idev->scan_timestamp) {
> -		s64 *timestamp = (s64 *)((u8 *)st->buffer +
> -					ALIGN(j, sizeof(s64)));
> -		*timestamp = pf->timestamp;
> -	}
> -
> -	iio_push_to_buffers(idev, st->buffer);
> +	iio_push_to_buffers_with_timestamp(idev, st->buffer, pf->timestamp);
>  
>  	iio_trigger_notify_done(idev->trig);
>  
> 
