Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38382 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753049AbdICQlk (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 3 Sep 2017 12:41:40 -0400
Date: Sun, 3 Sep 2017 17:41:35 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Colin King <colin.king@canonical.com>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Jean-Baptiste Maneyrol <JManeyrol@invensense.com>,
        linux-iio@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: imu: inv_mpu6050: make arrays hz and d static
Message-ID: <20170903174135.2ad75bf8@archlinux>
In-Reply-To: <20170830111616.27559-1-colin.king@canonical.com>
References: <20170830111616.27559-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Wed, 30 Aug 2017 12:16:16 +0100
Colin King <colin.king@canonical.com> wrote:

> From: Colin Ian King <colin.king@canonical.com>
> 
> Don't populate the arrays on the stack, instead make them static.
> Makes the object code smaller by 135 bytes:
> 
> Before:
>    text	   data	    bss	    dec	    hex	filename
>   15135	   4240	    128	  19503	   4c2f	inv_mpu_core.o
> 
> After:
>    text	   data	    bss	    dec	    hex	filename
>   14840	   4400	    128	  19368	   4ba8	inv_mpu_core.o
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied to the togreg branch of iio.git and pushed out as
testing or the autobuilders to play with it.

Thanks,

Jonathan
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 44830bce13df..6692f5e08dc8 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -570,10 +570,12 @@ static int inv_mpu6050_write_raw(struct iio_dev *indio_dev,
>   */
>  static int inv_mpu6050_set_lpf(struct inv_mpu6050_state *st, int rate)
>  {
> -	const int hz[] = {188, 98, 42, 20, 10, 5};
> -	const int d[] = {INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
> -			INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
> -			INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ};
> +	static const int hz[] = {188, 98, 42, 20, 10, 5};
> +	static const int d[] = {
> +		INV_MPU6050_FILTER_188HZ, INV_MPU6050_FILTER_98HZ,
> +		INV_MPU6050_FILTER_42HZ, INV_MPU6050_FILTER_20HZ,
> +		INV_MPU6050_FILTER_10HZ, INV_MPU6050_FILTER_5HZ
> +	};
>  	int i, h, result;
>  	u8 data;
>  

