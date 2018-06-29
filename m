Return-Path: <SRS0=C+mm=JP=metafoo.de=lars@kernel.org>
Subject: Re: [PATCH] staging:iio:adc:ad7280a: Use GFP_ATOMIC in interrupt
 handler
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: Michael.Hennerich@analog.com, jic23@kernel.org, knaack.h@gmx.de,
 pmeerw@pmeerw.net, gregkh@linuxfoundation.org, linux-iio@vger.kernel.org,
 devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
References: <20180628235503.4464-1-karim.eshapa@gmail.com>
From: Lars-Peter Clausen <lars@metafoo.de>
Message-ID: <3ac43cff-5f4e-579a-574e-14ac865c37e1@metafoo.de>
Date: Fri, 29 Jun 2018 07:05:17 +0200
MIME-Version: 1.0
In-Reply-To: <20180628235503.4464-1-karim.eshapa@gmail.com>
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

On 06/29/2018 01:55 AM, Karim Eshapa wrote:
> Use GFP_ATOMIC rather GFP_KERNEL in interrupt handler,
> as GFP_KERNEL may sleep according to slab allocator.

This is a threaded interrupt. Sleeping is OK.

> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/staging/iio/adc/ad7280a.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/iio/adc/ad7280a.c b/drivers/staging/iio/adc/ad7280a.c
> index b736275c10f5..25c4fbc303f7 100644
> --- a/drivers/staging/iio/adc/ad7280a.c
> +++ b/drivers/staging/iio/adc/ad7280a.c
> @@ -692,7 +692,7 @@ static irqreturn_t ad7280_event_handler(int irq, void *private)
>  	unsigned int *channels;
>  	int i, ret;
>  
> -	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> +	channels = kcalloc(st->scan_cnt, sizeof(*channels), GFP_ATOMIC);
>  	if (!channels)
>  		return IRQ_HANDLED;
>  
> 
