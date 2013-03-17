Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:49154 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932763Ab3CQWma (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 17 Mar 2013 18:42:30 -0400
Message-ID: <51462452.9010904@kernel.org>
Date: Sun, 17 Mar 2013 20:15:14 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Ge GAO <ggao@invensense.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH] using kfifo_in_spinlocked instead of separate code.
References: <1362439657-8691-1-git-send-email-ggao@invensense.com>
In-Reply-To: <1362439657-8691-1-git-send-email-ggao@invensense.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/04/2013 11:27 PM, Ge GAO wrote:
> From: Ge Gao <ggao@invensense.com>
I added your sign off given it should have been here.
Please make sure to run checkpatch.pl against all patches
as it catches silly mistakes like this.

Applied to togreg branch of iio.git
> 
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c |    5 ++---
>  1 files changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 331781f..7da0832 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -105,9 +105,8 @@ irqreturn_t inv_mpu6050_irq_handler(int irq, void *p)
>  	s64 timestamp;
>  
>  	timestamp = iio_get_time_ns();
> -	spin_lock(&st->time_stamp_lock);
> -	kfifo_in(&st->timestamps, &timestamp, 1);
> -	spin_unlock(&st->time_stamp_lock);
> +	kfifo_in_spinlocked(&st->timestamps, &timestamp, 1,
> +				&st->time_stamp_lock);
>  
>  	return IRQ_WAKE_THREAD;
>  }
> 
