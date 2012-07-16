Return-Path: <pmeerw@pmeerw.net>
Date: Mon, 16 Jul 2012 11:26:52 +0200 (CEST)
From: Peter Meerwald <pmeerw@pmeerw.net>
To: Michael Hennerich <michael.hennerich@analog.com>
cc: jic23@kernel.org, linux-iio@vger.kernel.org,
    device-drivers-devel@blackfin.uclinux.org, fengguang.wu@intel.com
Subject: Re: [PATCH] iio: staging: ad7298_ring: Fix maybe-uninitialized
 warning
In-Reply-To: <1342428125-31577-1-git-send-email-michael.hennerich@analog.com>
Message-ID: <alpine.DEB.2.01.1207161124570.18056@pmeerw.net>
References: <1342428125-31577-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-ID: <linux-iio@vger.kernel.org>


> drivers/staging/iio/adc/ad7298_ring.c:97:37: warning: 'time_ns' may
> be used uninitialized in this function [-Wmaybe-uninitialized]

> diff --git a/drivers/staging/iio/adc/ad7298_ring.c b/drivers/staging/iio/adc/ad7298_ring.c
> index fd1d855..506016f 100644
> --- a/drivers/staging/iio/adc/ad7298_ring.c
> +++ b/drivers/staging/iio/adc/ad7298_ring.c
> @@ -76,7 +76,7 @@ static irqreturn_t ad7298_trigger_handler(int irq, void *p)
>  	struct iio_dev *indio_dev = pf->indio_dev;
>  	struct ad7298_state *st = iio_priv(indio_dev);
>  	struct iio_buffer *ring = indio_dev->buffer;
> -	s64 time_ns;
> +	s64 time_ns = 0;
>  	__u16 buf[16];
>  	int b_sent, i;

I'd rather suggest 
s64 time_ns = iio_get_time_ns();

and simplify the if (indio_dev->scan_timestamp) block

p.

-- 

Peter Meerwald
+43-664-2444418 (mobile)
