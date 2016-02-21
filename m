Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:60567 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751778AbcBUUkM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 21 Feb 2016 15:40:12 -0500
Subject: Re: [RFC PATCH 6/9] iio: imu: inv_mpu6050: Fix code indent for if
 statement
To: Daniel Baluta <daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com>
 <1455810794-3188-7-git-send-email-daniel.baluta@intel.com>
Cc: knaack.h@gmx.de, lars@metafoo.de, pmeerw@pmeerw.net,
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
	wsa@the-dreams.de, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com, srinivas.pandruvada@linux.intel.com,
	ggao@invensense.com, adi.reus@gmail.com, cmo@melexis.com,
	mwelling@ieee.org
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56CA20AA.2030401@kernel.org>
Date: Sun, 21 Feb 2016 20:40:10 +0000
MIME-Version: 1.0
In-Reply-To: <1455810794-3188-7-git-send-email-daniel.baluta@intel.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 18/02/16 15:53, Daniel Baluta wrote:
> This fixes the following checkpatch.pl warning:
> 
> WARNING: suspect code indent for conditional statements (8, 24)
> +       if (kfifo_len(&st->timestamps) >
> [...]
> +                       goto flush_fifo;
> 
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
Applied.
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 441080b..0bc5091 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -158,8 +158,8 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>  		goto flush_fifo;
>  	/* Timestamp mismatch. */
>  	if (kfifo_len(&st->timestamps) >
> -		fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
> -			goto flush_fifo;
> +	    fifo_count / bytes_per_datum + INV_MPU6050_TIME_STAMP_TOR)
> +		goto flush_fifo;
>  	while (fifo_count >= bytes_per_datum) {
>  		result = regmap_bulk_read(st->map, st->reg->fifo_r_w,
>  					  data, bytes_per_datum);
> 

