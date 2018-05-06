Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([46.235.226.198]:53632 "EHLO
        saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751714AbeEFRIT (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sun, 6 May 2018 13:08:19 -0400
Date: Sun, 6 May 2018 18:08:16 +0100
From: Jonathan Cameron <jic23@jic23.retrosnub.co.uk>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
Subject: Re: [PATCH 2/2] iio: imu: inv_mpu6050: make loop a do-while
Message-ID: <20180506180816.4c15b826@archlinux>
In-Reply-To: <20180501175642.8551-3-mkelly@xevo.com>
References: <20180501175642.8551-1-mkelly@xevo.com>
        <20180501175642.8551-3-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue,  1 May 2018 10:56:42 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> Prior to this loop, we check if fifo_count < bytes_per_datum and bail if
> so. This means that when we hit the loop, we know that fifo_count >=
> bytes_per_datum, so the check is unneeded and we can turn the loop into
> a do-while for a slight performance improvement.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Seems logical to me, but I'd like to give Jean-Baptiste a chance
to comment on this one.

If it looks like we have forgotten about it in a week or so do
give me a poke!

Thanks,

Jonathan

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 0cb7c20100ca..11593deaaebd 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -174,7 +174,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (kfifo_len(&st->timestamps) >
>  	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
>  		goto flush_fifo;
> -	while (fifo_count >= bytes_per_datum) {
> +	do {
>  		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>  					  data, bytes_per_datum);
>  		if (result)
> @@ -188,7 +188,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
>  
>  		fifo_count -= bytes_per_datum;
> -	}
> +	} while (fifo_count >= bytes_per_datum);
>  
>  end_session:
>  	mutex_unlock(&st->lock);

