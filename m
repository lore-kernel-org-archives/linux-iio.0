Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from www.linutronix.de ([62.245.132.108]:35388 "EHLO
	Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493Ab3JXKen (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 24 Oct 2013 06:34:43 -0400
Message-ID: <5268F7BD.2010508@linutronix.de>
Date: Thu, 24 Oct 2013 12:34:37 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@kernel.org>, Felipe Balbi <balbi@ti.com>,
	linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: ti_am335x_adc: do not free the kfifo twice
References: <9ctn6ye3lkct930eq1ivw2wc.1382550258829@email.android.com> <5268F2C9.5010104@kernel.org> <5268E773.3020507@linutronix.de> <5268EB39.7010208@metafoo.de>
In-Reply-To: <5268EB39.7010208@metafoo.de>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/24/2013 11:41 AM, Lars-Peter Clausen wrote:
> The driver seems to be missing the iio_buffer_attach() call. Something like
> this should fix the problem:
> 
> diff --git a/drivers/iio/adc/ti_am335x_adc.c b/drivers/iio/adc/ti_am335x_adc.c
> index ef54d8a..bf9c89c 100644
> --- a/drivers/iio/adc/ti_am335x_adc.c
> +++ b/drivers/iio/adc/ti_am335x_adc.c
> @@ -229,12 +229,15 @@ static int tiadc_iio_buffered_hardware_setup(struct
> iio_dev *indio_dev,
>  	unsigned long flags,
>  	const struct iio_buffer_setup_ops *setup_ops)
>  {
> +	struct iio_buffer *buffer;
>  	int ret;
> 
> -	indio_dev->buffer = iio_kfifo_allocate(indio_dev);
> -	if (!indio_dev->buffer)
> +	buffer = iio_kfifo_allocate(indio_dev);
> +	if (!buffer)
>  		return -ENOMEM;
> 
> +	iio_device_attach_buffer(indio_dev, buffer);
> +
>  	ret = request_threaded_irq(irq,	pollfunc_th, pollfunc_bh,
>  				flags, indio_dev->name, indio_dev);
>  	if (ret)

Yep, that works, thanks.

Shouldn't the two

         tiadc_iio_buffered_hardware_remove(indio_dev);
         tiadc_channels_remove(indio_dev);

in tiadc_remove() be reversed in their call order? The second alter is
accessing the buffer which is released by the former one.

btw: is all this ref counting really required? I mean I would assume
allocate buffer in one place (at probe time) release it remove time
should be enough.

Sebastian
