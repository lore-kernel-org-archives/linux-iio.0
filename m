Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:56884 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752237Ab3IULPs (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 21 Sep 2013 07:15:48 -0400
Message-ID: <523D8E08.9090306@kernel.org>
Date: Sat, 21 Sep 2013 13:16:08 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Lars-Peter Clausen <lars@metafoo.de>
CC: linux-iio@vger.kernel.org, Ge Gao <ggao@invensense.com>
Subject: Re: [PATCH 15/24] iio:mpu6050: Use iio_push_to_buffers_with_timestamp()
References: <1379595601-26448-1-git-send-email-lars@metafoo.de> <1379595601-26448-15-git-send-email-lars@metafoo.de>
In-Reply-To: <1379595601-26448-15-git-send-email-lars@metafoo.de>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 09/19/13 13:59, Lars-Peter Clausen wrote:
> Makes the code a bit shorter and less ugly.
> 
> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
> Cc: Ge Gao <ggao@invensense.com>
Applied to the togreg branch of iio.git

> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 7da0832..4295171 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -124,7 +124,6 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  	u8 data[INV_MPU6050_OUTPUT_DATA_SIZE];
>  	u16 fifo_count;
>  	s64 timestamp;
> -	u64 *tmp;
>  
>  	mutex_lock(&indio_dev->mlock);
>  	if (!(st->chip_config.accl_fifo_enable |
> @@ -170,9 +169,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		if (0 == result)
>  			timestamp = 0;
>  
> -		tmp = (u64 *)data;
> -		tmp[DIV_ROUND_UP(bytes_per_datum, 8)] = timestamp;
> -		result = iio_push_to_buffers(indio_dev, data);
> +		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
> +			timestamp);
>  		if (result)
>  			goto flush_fifo;
>  		fifo_count -= bytes_per_datum;
> 
