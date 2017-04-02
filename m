Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:47248 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750931AbdDBIuE (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 2 Apr 2017 04:50:04 -0400
Subject: Re: [PATCH] iio: dac: ad5504: Remove unnecessary cast on void pointer
To: simran singhal <singhalsimran0@gmail.com>, lars@metafoo.de
References: <20170401141153.GA26918@singhal-Inspiron-5558>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <7a4d91fe-9401-f799-0e72-9b3431aa7ac3@kernel.org>
Date: Sun, 2 Apr 2017 09:50:02 +0100
MIME-Version: 1.0
In-Reply-To: <20170401141153.GA26918@singhal-Inspiron-5558>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 01/04/17 15:11, simran singhal wrote:
> The following Coccinelle script was used to detect this:
> @r@
> expression x;
> void* e;
> type T;
> identifier f;
> @@
> (
>   *((T *)e)
> |
>   ((T *)x)[...]
> |
>   ((T*)x)->f
> |
> - (T*)
>   e
> )
> 
> Signed-off-by: simran singhal <singhalsimran0@gmail.com>
It could be argued for this one that it is acting as documentation
as it might not be obvious without looking up the definition of
the iio_get_time_ns function that it takes a struct iio_dev.

However, on balance I think that this case is simple enough that
it should be fine as you have it.

Applied.
> ---
>  drivers/iio/dac/ad5504.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
> index 22a027d..712d86b 100644
> --- a/drivers/iio/dac/ad5504.c
> +++ b/drivers/iio/dac/ad5504.c
> @@ -223,7 +223,7 @@ static irqreturn_t ad5504_event_handler(int irq, void *private)
>  					    0,
>  					    IIO_EV_TYPE_THRESH,
>  					    IIO_EV_DIR_RISING),
> -		       iio_get_time_ns((struct iio_dev *)private));
> +		       iio_get_time_ns(private));
>  
>  	return IRQ_HANDLED;
>  }
> 

