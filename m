Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752762AbeDUQS5 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 21 Apr 2018 12:18:57 -0400
Date: Sat, 21 Apr 2018 17:18:51 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Brian Masney <masneyb@onstation.org>
Cc: linux-iio@vger.kernel.org, gregkh@linuxfoundation.org,
        devel@driverdev.osuosl.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, linux-kernel@vger.kernel.org,
        Jon.Brenner@ams.com
Subject: Re: [PATCH 03/13] staging: iio: tsl2x7x: don't return error in IRQ
 handler
Message-ID: <20180421171851.1543aba0@archlinux>
In-Reply-To: <20180421004153.19073-4-masneyb@onstation.org>
References: <20180421004153.19073-1-masneyb@onstation.org>
        <20180421004153.19073-4-masneyb@onstation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 20 Apr 2018 20:41:43 -0400
Brian Masney <masneyb@onstation.org> wrote:

> tsl2x7x_event_handler() could return an error and this could cause the
> interrupt to remain masked. We shouldn't return an error in the
> interrupt handler so this patch always returns IRQ_HANDLED. An error
> will be logged if one occurs.
> 
> Signed-off-by: Brian Masney <masneyb@onstation.org>
There is a slight argument that we should report an error from the 
interrupt clear if it generates an error, but I'm not that bothered
as that is unlikely to happen and people rarely see these errors in
their logs anyway.

Applied to the togreg branch of iio.git and pushed out as testing
for the autobuilders to play with it.

Thanks,

Jonathan

> ---
>  drivers/staging/iio/light/tsl2x7x.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/staging/iio/light/tsl2x7x.c b/drivers/staging/iio/light/tsl2x7x.c
> index 9cdcc8c9e812..95a00b965c5e 100644
> --- a/drivers/staging/iio/light/tsl2x7x.c
> +++ b/drivers/staging/iio/light/tsl2x7x.c
> @@ -1320,7 +1320,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  
>  	ret = tsl2x7x_read_status(chip);
>  	if (ret < 0)
> -		return ret;
> +		return IRQ_HANDLED;
>  
>  	/* What type of interrupt do we need to process */
>  	if (ret & TSL2X7X_STA_PRX_INTR) {
> @@ -1341,9 +1341,7 @@ static irqreturn_t tsl2x7x_event_handler(int irq, void *private)
>  			       timestamp);
>  	}
>  
> -	ret = tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
> -	if (ret < 0)
> -		return ret;
> +	tsl2x7x_clear_interrupts(chip, TSL2X7X_CMD_PROXALS_INT_CLR);
>  
>  	return IRQ_HANDLED;
>  }

