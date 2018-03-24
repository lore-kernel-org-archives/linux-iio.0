Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:59270 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751903AbeCXMfT (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 24 Mar 2018 08:35:19 -0400
Date: Sat, 24 Mar 2018 12:35:19 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Martin Kelly <mkelly@xevo.com>
Cc: linux-iio@vger.kernel.org,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>
Subject: How to handle missing timestamps? (was Re: [PATCH] iio: imu:
 inv_mpu6050: improve missing timestamp handling)
Message-ID: <20180324123519.0acba88e@archlinux>
In-Reply-To: <20180324000240.19519-1-mkelly@xevo.com>
References: <20180324000240.19519-1-mkelly@xevo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 23 Mar 2018 17:02:40 -0700
Martin Kelly <mkelly@xevo.com> wrote:

> When interrupts are generated at a slower rate than the FIFO queue fills
> up, we will have fewer timestamps than samples. Currently, we fill in 0
> for any unmatched timestamps. However, this is very confusing for
> userspace, which does not expect discontinuities in timestamps and
> must somehow work around the issue.
> 
> Improve the situation by using the most recent timestamp when a
> timestamp is missing. Although this guess is not perfectly accurate, it
> is still close to the correct timestamp and won't result in the
> confusion caused by using 0.
> 
> Signed-off-by: Martin Kelly <mkelly@xevo.com>
Hmm. I would like to see where other peoples opinions on this lie.
The decision to mark it as 0 was deliberately made.  There are a number
of applications where you have to 'know' the timestamps are incorrect
- pretending simply doesn't work.  Arguably it is fine for a system
to detect that it is seeing repeated values and hence 'fix them up.
This is a change in ABI however which is going to be unfortunate
if we have code out there which is doing the right thing - interpolating
timestamps only once we have another known point to build from.

So opinions anyone?

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index ff81c6aa009d..a982037d5dad 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -126,6 +126,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	int result;
>  	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>  	u16 fifo_count;
> +	s64 last_timestamp;
>  	s64 timestamp;
>  
>  	mutex_lock(&st->lock);
> @@ -159,6 +160,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	if (kfifo_len(&st->timestamps) >
>  	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
>  		goto flush_fifo;
> +	last_timestamp = 0;
>  	while (fifo_count >= bytes_per_datum) {
>  		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>  					  data, bytes_per_datum);
> @@ -166,9 +168,11 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  			goto flush_fifo;
>  
>  		result = kfifo_out(&st->timestamps, &timestamp, 1);
> -		/* when there is no timestamp, put timestamp as 0 */
> +		/* when there is no timestamp, just use the last one we saw */
>  		if (result == 0)
> -			timestamp = 0;
> +			timestamp = last_timestamp;
> +		else
> +			last_timestamp = timestamp;
>  
>  		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
>  							    timestamp);

