Return-Path: <jic23@kernel.org>
Message-ID: <4EE07FEC.404@kernel.org>
Date: Thu, 08 Dec 2011 09:14:20 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: Jonathan Cameron <jic23@cam.ac.uk>,
 Michael Hennerich <michael.hennerich@analog.com>,
 linux-iio@vger.kernel.org, device-drivers-devel@blackfin.uclinux.org,
 drivers@analog.com
Subject: Re: [PATCH] staging:iio:kfifo_buf: Fix potential buffer overflow
 in iio_read_first_n_kfifo
References: <1323269014-21611-1-git-send-email-lars@metafoo.de>
In-Reply-To: <1323269014-21611-1-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 12/07/2011 02:43 PM, Lars-Peter Clausen wrote:
> n is the number of bytes to read, not the number of samples. So if there is
> enough data available we will write to the userspace buffer beyond its bounds.
> Fix this by copying n bytes maximum. Also round n down to the next multiple of
> the sample size, so we will only read complete samples. If the buffer is too
> small to hold at least one sample return -EINVAL.
> 
Dratt. You are quite right.  The documentation for read_first_n is
rather cryptic.  It was a while ago, but I think the plan was that it
would be a call to read n scans though clearly it is not in either the
users or ring_sw.   I guess we might allow partial reads from some
buffer implementations so probably better this way with the fix in
the buffer itself as you have done here.   We should also update the
docs in buffer.h to make it clear it is in bytes rather than 'elements'
as it currently says.   If you would like to add it to this patch that
would be great.  I guess I've just been 'lucky' whilst testing this
buffer...
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
> ---
>  drivers/staging/iio/kfifo_buf.c |    6 +++++-
>  1 files changed, 5 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/staging/iio/kfifo_buf.c b/drivers/staging/iio/kfifo_buf.c
> index a64ebbf..930029b 100644
> --- a/drivers/staging/iio/kfifo_buf.c
> +++ b/drivers/staging/iio/kfifo_buf.c
> @@ -161,7 +161,11 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>  	int ret, copied;
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
>  
> -	ret = kfifo_to_user(&kf->kf, buf, r->bytes_per_datum*n, &copied);
> +	if (n < r->bytes_per_datum)
> +		return -EINVAL;
> +
> +	n = rounddown(n, r->bytes_per_datum);
> +	ret = kfifo_to_user(&kf->kf, buf, n, &copied);
>  
>  	return copied;
>  }
