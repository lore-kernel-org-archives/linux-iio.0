Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from saturn.retrosnub.co.uk ([178.18.118.26]:41570 "EHLO
	saturn.retrosnub.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842AbaBHM3B (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 8 Feb 2014 07:29:01 -0500
Message-ID: <52F6232C.5040508@kernel.org>
Date: Sat, 08 Feb 2014 12:29:32 +0000
From: Jonathan Cameron <jic23@kernel.org>
MIME-Version: 1.0
To: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
CC: Ge Gao <ggao@invensense.com>, linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: imu: inv_mpu6050: Fix typo and formatting
References: <1391596475-21986-1-git-send-email-manuel.stahl@iis.fraunhofer.de> <1391596475-21986-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
In-Reply-To: <1391596475-21986-2-git-send-email-manuel.stahl@iis.fraunhofer.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 05/02/14 10:34, Manuel Stahl wrote:
> Signed-off-by: Manuel Stahl <manuel.stahl@iis.fraunhofer.de>
Applied to the togreg branch of iio.git

Thanks,
> ---
>   drivers/iio/imu/inv_mpu6050/inv_mpu_core.c |  2 +-
>   drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  | 38 +++++++++++++++---------------
>   2 files changed, 20 insertions(+), 20 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index df7f1e1..fda1ee2 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -117,7 +117,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>   		return result;
>
>   	if (en) {
> -		/* Wait for output stablize */
> +		/* Wait for output stabilize */
>   		msleep(INV_MPU6050_TEMP_UP_TIME);
>   		if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
>   			/* switch internal clock to PLL */
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index f383955..0ab382b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -126,35 +126,35 @@ struct inv_mpu6050_state {
>   #define INV_MPU6050_REG_SAMPLE_RATE_DIV     0x19
>   #define INV_MPU6050_REG_CONFIG              0x1A
>   #define INV_MPU6050_REG_GYRO_CONFIG         0x1B
> -#define INV_MPU6050_REG_ACCEL_CONFIG	    0x1C
> +#define INV_MPU6050_REG_ACCEL_CONFIG        0x1C
>
>   #define INV_MPU6050_REG_FIFO_EN             0x23
> -#define INV_MPU6050_BIT_ACCEL_OUT                   0x08
> -#define INV_MPU6050_BITS_GYRO_OUT                   0x70
> +#define INV_MPU6050_BIT_ACCEL_OUT           0x08
> +#define INV_MPU6050_BITS_GYRO_OUT           0x70
>
>   #define INV_MPU6050_REG_INT_ENABLE          0x38
> -#define INV_MPU6050_BIT_DATA_RDY_EN                 0x01
> -#define INV_MPU6050_BIT_DMP_INT_EN                  0x02
> +#define INV_MPU6050_BIT_DATA_RDY_EN         0x01
> +#define INV_MPU6050_BIT_DMP_INT_EN          0x02
>
>   #define INV_MPU6050_REG_RAW_ACCEL           0x3B
>   #define INV_MPU6050_REG_TEMPERATURE         0x41
>   #define INV_MPU6050_REG_RAW_GYRO            0x43
>
>   #define INV_MPU6050_REG_USER_CTRL           0x6A
> -#define INV_MPU6050_BIT_FIFO_RST                    0x04
> -#define INV_MPU6050_BIT_DMP_RST                     0x08
> -#define INV_MPU6050_BIT_I2C_MST_EN                  0x20
> -#define INV_MPU6050_BIT_FIFO_EN                     0x40
> -#define INV_MPU6050_BIT_DMP_EN                      0x80
> +#define INV_MPU6050_BIT_FIFO_RST            0x04
> +#define INV_MPU6050_BIT_DMP_RST             0x08
> +#define INV_MPU6050_BIT_I2C_MST_EN          0x20
> +#define INV_MPU6050_BIT_FIFO_EN             0x40
> +#define INV_MPU6050_BIT_DMP_EN              0x80
>
>   #define INV_MPU6050_REG_PWR_MGMT_1          0x6B
> -#define INV_MPU6050_BIT_H_RESET                     0x80
> -#define INV_MPU6050_BIT_SLEEP                       0x40
> -#define INV_MPU6050_BIT_CLK_MASK                    0x7
> +#define INV_MPU6050_BIT_H_RESET             0x80
> +#define INV_MPU6050_BIT_SLEEP               0x40
> +#define INV_MPU6050_BIT_CLK_MASK            0x7
>
>   #define INV_MPU6050_REG_PWR_MGMT_2          0x6C
> -#define INV_MPU6050_BIT_PWR_ACCL_STBY               0x38
> -#define INV_MPU6050_BIT_PWR_GYRO_STBY               0x07
> +#define INV_MPU6050_BIT_PWR_ACCL_STBY       0x38
> +#define INV_MPU6050_BIT_PWR_GYRO_STBY       0x07
>
>   #define INV_MPU6050_REG_FIFO_COUNT_H        0x72
>   #define INV_MPU6050_REG_FIFO_R_W            0x74
> @@ -180,10 +180,10 @@ struct inv_mpu6050_state {
>
>   /* init parameters */
>   #define INV_MPU6050_INIT_FIFO_RATE           50
> -#define INV_MPU6050_TIME_STAMP_TOR                        5
> -#define INV_MPU6050_MAX_FIFO_RATE                         1000
> -#define INV_MPU6050_MIN_FIFO_RATE                         4
> -#define INV_MPU6050_ONE_K_HZ                              1000
> +#define INV_MPU6050_TIME_STAMP_TOR           5
> +#define INV_MPU6050_MAX_FIFO_RATE            1000
> +#define INV_MPU6050_MIN_FIFO_RATE            4
> +#define INV_MPU6050_ONE_K_HZ                 1000
>
>   /* scan element definition */
>   enum inv_mpu6050_scan {
>

