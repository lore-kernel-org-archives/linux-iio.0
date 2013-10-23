Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:55475 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752897Ab3JWXEa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 23 Oct 2013 19:04:30 -0400
In-Reply-To: <20131023193620.GA5874@linutronix.de>
References: <1382547624-15256-1-git-send-email-bigeasy@linutronix.de> <20131023193620.GA5874@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=UTF-8
Subject: Re: [PATCH 1/2 v2] iio: adc: ti_am335x_adc: do not free the kfifo twice
From: Jonathan Cameron <jic23@kernel.org>
Date: Thu, 24 Oct 2013 00:04:25 +0100
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Felipe Balbi <balbi@ti.com>, linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <b0a96423-568f-4c22-aa31-b1cb9af47ba7@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org



Sebastian Andrzej Siewior <bigeasy@linutronix.de> wrote:
>Since commit 9e69c9 ("iio: Add reference counting for buffers") the iio
>core frees the buffer. So if the driver does it as well then bad things
>will happen.

It is late and I haven't looked at this in much detail but I suspect that this is a reference count issue as the allocation of indio_dev->buffer is directly rather than via iio_buffer_activate. Lars?
>
>Cc: Lars-Peter Clausen <lars@metafoo.de>
>Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
>---
>v1…v2: make it compile after removal of error_kfifo_free label. Grml.
>       I tested it before I removed the same thing from
>       tiadc_iio_buffered_hardware_setup()
>
> drivers/iio/adc/ti_am335x_adc.c | 5 +----
> 1 file changed, 1 insertion(+), 4 deletions(-)
>
>diff --git a/drivers/iio/adc/ti_am335x_adc.c
>b/drivers/iio/adc/ti_am335x_adc.c
>index f974dea..4f6e0ce 100644
>--- a/drivers/iio/adc/ti_am335x_adc.c
>+++ b/drivers/iio/adc/ti_am335x_adc.c
>@@ -239,7 +239,7 @@ static int tiadc_iio_buffered_hardware_setup(struct
>iio_dev *indio_dev,
> 	ret = request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
> 				flags, indio_dev->name, indio_dev);
> 	if (ret)
>-		goto error_kfifo_free;
>+		return ret;
> 
> 	indio_dev->setup_ops = setup_ops;
> 	indio_dev->modes |= INDIO_BUFFER_HARDWARE;
>@@ -254,8 +254,6 @@ static int tiadc_iio_buffered_hardware_setup(struct
>iio_dev *indio_dev,
> 
> error_free_irq:
> 	free_irq(irq, indio_dev);
>-error_kfifo_free:
>-	iio_kfifo_free(indio_dev->buffer);
> 	return ret;
> }
> 
>@@ -264,7 +262,6 @@ static void
>tiadc_iio_buffered_hardware_remove(struct iio_dev *indio_dev)
> 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> 
> 	free_irq(adc_dev->mfd_tscadc->irq, indio_dev);
>-	iio_kfifo_free(indio_dev->buffer);
> 	iio_buffer_unregister(indio_dev);
> }
> 

-- 
Sent from my Android phone with K-9 Mail. Please excuse my brevity.
