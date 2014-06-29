Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.19.201]:55267 "EHLO mail.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751776AbaF2Nlu (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Sun, 29 Jun 2014 09:41:50 -0400
Message-ID: <53B0181C.7020504@kernel.org>
Date: Sun, 29 Jun 2014 14:43:56 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>,
	linux-iio@vger.kernel.org
CC: lars@metafoo.de, yannick.bedhomme@mobile-devices.fr
Subject: Re: [PATCH 1/2] iio: staging: sca3000: hide stufftoread logic
References: <1403886001-23354-1-git-send-email-josselin.costanzi@mobile-devices.fr> <1403886001-23354-2-git-send-email-josselin.costanzi@mobile-devices.fr>
In-Reply-To: <1403886001-23354-2-git-send-email-josselin.costanzi@mobile-devices.fr>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 27/06/14 17:20, Josselin Costanzi wrote:
> Change sca3000_ring implementation so that it exports a data_available
> function to iio.
>
> Signed-off-by: Josselin Costanzi <josselin.costanzi@mobile-devices.fr>
Looks to be safe and sensible. Technically changes the requirements on buffers
but as your change makes the only non compliant one meet the new requirement
we are fine.

A sensible change on it's own so applied to the togreg branch of iio.git.


Thanks,

Jonathan
> ---
>   drivers/iio/industrialio-buffer.c        | 5 +----
>   drivers/staging/iio/accel/sca3000_ring.c | 6 ++++++
>   2 files changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
> index 36b1ae9..2952ee0 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -39,10 +39,7 @@ static bool iio_buffer_is_active(struct iio_buffer *buf)
>
>   static bool iio_buffer_data_available(struct iio_buffer *buf)
>   {
> -	if (buf->access->data_available)
> -		return buf->access->data_available(buf);
> -
> -	return buf->stufftoread;
> +	return buf->access->data_available(buf);
>   }
>
>   /**
> diff --git a/drivers/staging/iio/accel/sca3000_ring.c b/drivers/staging/iio/accel/sca3000_ring.c
> index 1987106..33f0e92 100644
> --- a/drivers/staging/iio/accel/sca3000_ring.c
> +++ b/drivers/staging/iio/accel/sca3000_ring.c
> @@ -141,6 +141,11 @@ static int sca3000_ring_get_bytes_per_datum(struct iio_buffer *r)
>   	return 6;
>   }
>
> +static bool sca3000_ring_buf_data_available(struct iio_buffer *r)
> +{
> +	return r->stufftoread;
> +}
> +
>   static IIO_BUFFER_ENABLE_ATTR;
>   static IIO_BUFFER_LENGTH_ATTR;
>
> @@ -274,6 +279,7 @@ static const struct iio_buffer_access_funcs sca3000_ring_access_funcs = {
>   	.read_first_n = &sca3000_read_first_n_hw_rb,
>   	.get_length = &sca3000_ring_get_length,
>   	.get_bytes_per_datum = &sca3000_ring_get_bytes_per_datum,
> +	.data_available = sca3000_ring_buf_data_available,
>   	.release = sca3000_ring_release,
>   };
>
>

