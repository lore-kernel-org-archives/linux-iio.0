Return-Path: <lars@metafoo.de>
Message-ID: <4FF18C68.5000904@metafoo.de>
Date: Mon, 02 Jul 2012 13:56:24 +0200
From: Lars-Peter Clausen <lars@metafoo.de>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@kernel.org>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH 1/2] iio:kfifo_buf  Take advantage of the fixed record
 size used in IIO
References: <1341060763-9602-1-git-send-email-jic23@kernel.org> <1341060763-9602-2-git-send-email-jic23@kernel.org>
In-Reply-To: <1341060763-9602-2-git-send-email-jic23@kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-iio@vger.kernel.org>

On 06/30/2012 02:52 PM, Jonathan Cameron wrote:
> @@ -106,11 +108,12 @@ static int iio_read_first_n_kfifo(struct iio_buffer *r,
>  	int ret, copied;
>  	struct iio_kfifo *kf = iio_to_kfifo(r);
>  
> -	if (n < r->bytes_per_datum)
> +	if (n < r->bytes_per_datum || r->bytes_per_datum == 0)
>  		return -EINVAL;

Strictly speaking this is a unrelated change, but well...

I'll apply the kfifo patches to my IIO working tree and see if I'll get any
issues.

- Lars
