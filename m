Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:33386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750802AbeC3KU3 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 30 Mar 2018 06:20:29 -0400
Date: Fri, 30 Mar 2018 11:20:25 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/2] iio:kfifo_buf: check for uint overflow
Message-ID: <20180330112025.4ba22957@archlinux>
In-Reply-To: <20180326212752.7321-2-mkelly@xevo.com>
References: <20180326212752.7321-1-mkelly@xevo.com>
        <20180326212752.7321-2-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 26 Mar 2018 14:27:52 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Currently, the following causes a kernel OOPS in memcpy:
> 
> echo 1073741825 > buffer/length
> echo 1 > buffer/enable
> 
> Note that using 1073741824 instead of 1073741825 causes "write error:
> Cannot allocate memory" but no OOPS.
> 
> This is because 1073741824 == 2^30 and 1073741825 == 2^30+1. Since kfifo
> rounds up to the nearest power of 2, it will actually call kmalloc with
> roundup_pow_of_two(length) * bytes_per_datum.
> 
> Using length == 1073741825 and bytes_per_datum == 2, we get:
> 
> kmalloc(roundup_pow_of_two(1073741825) * 2
> or kmalloc(2147483648 * 2)
> or kmalloc(4294967296)
> or kmalloc(UINT_MAX + 1)
> 
> so this overflows to 0, causing kmalloc to return ZERO_SIZE_PTR and
> subsequent memcpy to fail once the device is enabled.
> 
> Fix this by checking for overflow prior to allocating a kfifo. With this
> check added, the above code returns -EINVAL when enabling the buffer,
> rather than causing an OOPS.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Applied to the fixes-togreg branch of iio.git and marked for stable.

I thought about this for a few mins.  A 4 gig allocation on a 32bit
machine is going to fail anyway for obvious reasons, but good
to protect against overflow if someone were to write this value.

Particularly good description btw!

Thanks,

Jonathan


> ---
>  drivers/iio/buffer/kfifo_buf.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/iio/buffer/kfifo_buf.c b/drivers/iio/buffer/kfifo_buf.c
> index ac622edf2486..70c302a93d7f 100644
> --- a/drivers/iio/buffer/kfifo_buf.c
> +++ b/drivers/iio/buffer/kfifo_buf.c
> @@ -27,6 +27,13 @@ static inline int __iio_allocate_kfifo(struct iio_kfifo *buf,
>  	if ((length == 0) || (bytes_per_datum == 0))
>  		return -EINVAL;
>  
> +	/*
> +	 * Make sure we don't overflow an unsigned int after kfifo rounds up to
> +	 * the next power of 2.
> +	 */
> +	if (roundup_pow_of_two(length) > UINT_MAX / bytes_per_datum)
> +		return -EINVAL;
> +
>  	return __kfifo_alloc((struct __kfifo *)&buf->kf, length,
>  			     bytes_per_datum, GFP_KERNEL);
>  }

