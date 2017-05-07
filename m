Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:57455 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755481AbdEGVvL (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 7 May 2017 17:51:11 -0400
Subject: Re: [PATCH] iio: proximity: as3935: fix iio_trigger_poll issue
To: Matt Ranostay <matt.ranostay@konsulko.com>
Cc: linux-iio@vger.kernel.org, stable@vger.kernel.org
References: <20170505003219.17570-1-matt.ranostay@konsulko.com>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <ec098e23-72d0-cbc3-5cbd-4c089914d788@kernel.org>
Date: Sun, 7 May 2017 13:21:24 +0100
MIME-Version: 1.0
In-Reply-To: <20170505003219.17570-1-matt.ranostay@konsulko.com>
Content-Type: text/plain; charset=utf-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/05/17 01:32, Matt Ranostay wrote:
> Using iio_trigger_poll() can oops when multiple interrupts
> happen before the first is handled.
> 
Ah. I see. This should cause all sorts of trouble and warnings.

It's calling the irq_chip infrastructure without going through the
dance necessary to make that happen from an irq context.

This is indeed the simplest fix.

Jonathan
> Use iio_trigger_poll_chained() instead and use the timestamp
> when processed, since it will be in theory be 2 ms max latency.
> 
> Fixes: 24ddb0e4bba4 ("iio: Add AS3935 lightning sensor support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
> ---
>  drivers/iio/proximity/as3935.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
> index ddf9bee89f77..d98d38227f26 100644
> --- a/drivers/iio/proximity/as3935.c
> +++ b/drivers/iio/proximity/as3935.c
> @@ -215,7 +215,7 @@ static irqreturn_t as3935_trigger_handler(int irq, void *private)
>  
>  	st->buffer[0] = val & AS3935_DATA_MASK;
>  	iio_push_to_buffers_with_timestamp(indio_dev, &st->buffer,
> -					   pf->timestamp);
> +					   iio_get_time_ns(indio_dev));
>  err_read:
>  	iio_trigger_notify_done(indio_dev->trig);
>  
> @@ -244,7 +244,7 @@ static void as3935_event_work(struct work_struct *work)
>  
>  	switch (val) {
>  	case AS3935_EVENT_INT:
> -		iio_trigger_poll(st->trig);
> +		iio_trigger_poll_chained(st->trig);
>  		break;
>  	case AS3935_NOISE_INT:
>  		dev_warn(&st->spi->dev, "noise level is too high\n");
> 

