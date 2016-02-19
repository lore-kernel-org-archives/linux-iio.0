Return-Path: <cmo@melexis.com>
MIME-Version: 1.0
In-Reply-To: <1455810794-3188-3-git-send-email-daniel.baluta@intel.com>
References: <1455810794-3188-1-git-send-email-daniel.baluta@intel.com> <1455810794-3188-3-git-send-email-daniel.baluta@intel.com>
From: Crt Mori <cmo@melexis.com>
Date: Fri, 19 Feb 2016 10:09:45 +0100
Message-ID: <CAKv63us92Epe0go9JGNScbeOepg3_j8RyW9w2qgN01Jvnj3sUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 2/9] iio: imu: inv_mpu6050: Fix Yoda conditions
To: Daniel Baluta <daniel.baluta@intel.com>
Cc: Johnathan Iain Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
	lucas.demarchi@intel.com,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, ggao@invensense.com,
	Adriana Reus <adi.reus@gmail.com>, mwelling@ieee.org
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

This is quite trivial.

Acked-by: Crt Mori <cmo@melexis.com>

On 18 February 2016 at 16:53, Daniel Baluta <daniel.baluta@intel.com> wrote:
> This fixes the following checkpatch warning:
>         * WARNING: Comparisons should place the constant
>           on the right side of the test
>
> Signed-off-by: Daniel Baluta <daniel.baluta@intel.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 6 +++---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c | 2 +-
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index 84e014c..c550ebb 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -84,7 +84,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>          * clock source be switched to gyro. Otherwise, it must be set to
>          * internal clock
>          */
> -       if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
> +       if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
>                 result = regmap_read(st->map, st->reg->pwr_mgmt_1, &mgmt_1);
>                 if (result)
>                         return result;
> @@ -92,7 +92,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>                 mgmt_1 &= ~INV_MPU6050_BIT_CLK_MASK;
>         }
>
> -       if ((INV_MPU6050_BIT_PWR_GYRO_STBY == mask) && (!en)) {
> +       if ((mask == INV_MPU6050_BIT_PWR_GYRO_STBY) && (!en)) {
>                 /*
>                  * turning off gyro requires switch to internal clock first.
>                  * Then turn off gyro engine
> @@ -117,7 +117,7 @@ int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>         if (en) {
>                 /* Wait for output stabilize */
>                 msleep(INV_MPU6050_TEMP_UP_TIME);
> -               if (INV_MPU6050_BIT_PWR_GYRO_STBY == mask) {
> +               if (mask == INV_MPU6050_BIT_PWR_GYRO_STBY) {
>                         /* switch internal clock to PLL */
>                         mgmt_1 |= INV_CLK_PLL;
>                         result = regmap_write(st->map,
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> index 1fc5fd9..441080b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_ring.c
> @@ -168,7 +168,7 @@ irqreturn_t inv_mpu6050_read_fifo(int irq, void *p)
>
>                 result = kfifo_out(&st->timestamps, &timestamp, 1);
>                 /* when there is no timestamp, put timestamp as 0 */
> -               if (0 == result)
> +               if (result == 0)
>                         timestamp = 0;
>
>                 result = iio_push_to_buffers_with_timestamp(indio_dev, data,
> --
> 2.5.0
>
