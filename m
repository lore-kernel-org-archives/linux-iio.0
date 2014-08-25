Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:46795 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933464AbaHYUp2 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 25 Aug 2014 16:45:28 -0400
Message-ID: <53FBA067.5000506@kernel.org>
Date: Mon, 25 Aug 2014 21:45:27 +0100
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
CC: linux-iio@vger.kernel.org
Subject: Re: [PATCH v1 7/8] iio: inv_mpu6050: Fix indio_dev->trig assignment
References: <1408740516-31261-1-git-send-email-srinivas.pandruvada@linux.intel.com> <1408740516-31261-8-git-send-email-srinivas.pandruvada@linux.intel.com>
In-Reply-To: <1408740516-31261-8-git-send-email-srinivas.pandruvada@linux.intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 22/08/14 21:48, Srinivas Pandruvada wrote:
> This can result in wrong reference count for trigger device, call
> iio_trigger_get to increment reference.
> Refer to http://www.spinics.net/lists/linux-iio/msg13669.html for discussion
> with Jonathan.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Applied to the fixes-togreg branch of iio.igt

Thanks,
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> index 03b9372..926fcce 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_trigger.c
> @@ -135,7 +135,7 @@ int inv_mpu6050_probe_trigger(struct iio_dev *indio_dev)
>  	ret = iio_trigger_register(st->trig);
>  	if (ret)
>  		goto error_free_irq;
> -	indio_dev->trig = st->trig;
> +	indio_dev->trig = iio_trigger_get(st->trig);
>  
>  	return 0;
>  
> 
