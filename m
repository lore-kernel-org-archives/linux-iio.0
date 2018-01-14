Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:44008 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751015AbeANOB7 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Jan 2018 09:01:59 -0500
Date: Sun, 14 Jan 2018 14:01:55 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH v3 2/4] iio: humidity: hts221: remove trailing
 whitespace from a comment
Message-ID: <20180114140155.44512615@archlinux>
In-Reply-To: <20180108221231.13283-3-lorenzo.bianconi@redhat.com>
References: <20180108221231.13283-3-lorenzo.bianconi@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon,  8 Jan 2018 23:12:29 +0100
Lorenzo Bianconi <lorenzo.bianconi@redhat.com> wrote:

> Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
I wonder when that one snuck in and why we haven't had
doesn't of static checker warnings about it.

Applied to the togreg branch of iio.git and pushed out
as testing for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/iio/humidity/hts221_buffer.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/humidity/hts221_buffer.c b/drivers/iio/humidity/hts221_buffer.c
> index e971ea425268..f9522ee62170 100644
> --- a/drivers/iio/humidity/hts221_buffer.c
> +++ b/drivers/iio/humidity/hts221_buffer.c
> @@ -61,7 +61,7 @@ static irqreturn_t hts221_trigger_handler_thread(int irq, void *private)
>  	if (err < 0)
>  		return IRQ_HANDLED;
>  
> -	/* 
> +	/*
>  	 * H_DA bit (humidity data available) is routed to DRDY line.
>  	 * Humidity sample is computed after temperature one.
>  	 * Here we can assume data channels are both available if H_DA bit

