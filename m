Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:33448 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751157AbeDNSAJ (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Sat, 14 Apr 2018 14:00:09 -0400
Received: by mail-pf0-f193.google.com with SMTP id f15so8543863pfn.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Apr 2018 11:00:09 -0700 (PDT)
Subject: Re: [PATCH] iio: imu: inv_mpu6050: do not flush fifo when iio buffer
 is full
To: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>,
        linux-iio@vger.kernel.org
References: <1523607906-22485-1-git-send-email-jmaneyrol@invensense.com>
From: Martin Kelly <martin@martingkelly.com>
Message-ID: <673bbcd1-f2f8-33ca-9920-db2289d10ce0@martingkelly.com>
Date: Sat, 14 Apr 2018 11:00:07 -0700
MIME-Version: 1.0
In-Reply-To: <1523607906-22485-1-git-send-email-jmaneyrol@invensense.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 04/13/2018 01:25 AM, Jean-Baptiste Maneyrol wrote:
> There is no need to flush fifo and loose all data when the iio
> buffer is full. Just drop the data by ignoring the error as
> commonly done in other drivers.
> 
> Signed-off-by: Jean-Baptiste Maneyrol <jmaneyrol@invensense.com>
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 6 ++----
>   1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index ff81c6a..27c663c 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -170,10 +170,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>   		if (result == 0)
>   			timestamp = 0;
>   
> -		result = iio_push_to_buffers_with_timestamp(indio_dev, data,
> -							    timestamp);
> -		if (result)
> -			goto flush_fifo;
> +		iio_push_to_buffers_with_timestamp(indio_dev, data, timestamp);
> +
>   		fifo_count -= bytes_per_datum;
>   	}
>   
> 

Reviewed-by: Martin Kelly <martin@martingkelly.com>

I wondered the same thing as I was reading this code :).
