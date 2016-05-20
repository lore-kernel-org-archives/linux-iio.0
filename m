Return-Path: <mranostay@gmail.com>
MIME-Version: 1.0
In-Reply-To: <e29974565e941e37684fcd883330915cfaf2cf47.1463582011.git.leonard.crestez@intel.com>
References: <cover.1463582011.git.leonard.crestez@intel.com> <e29974565e941e37684fcd883330915cfaf2cf47.1463582011.git.leonard.crestez@intel.com>
From: Matt Ranostay <mranostay@gmail.com>
Date: Thu, 19 May 2016 19:34:10 -0700
Message-ID: <CAKzfze8dDENOvaDf_VH8MRy-HEmCu3q_aGEzD+GYR7B1Ob2rBw@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] iio: inv_mpu6050: Initial regcache support
To: Crestez Dan Leonard <leonard.crestez@intel.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>, Ge Gao <ggao@invensense.com>,
	Peter Rosin <peda@axentia.se>, linux-i2c@vger.kernel.org,
	Wolfram Sang <wsa@the-dreams.de>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>,
	Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>,
	Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

On Wed, May 18, 2016 at 8:00 AM, Crestez Dan Leonard
<leonard.crestez@intel.com> wrote:
> Signed-off-by: Crestez Dan Leonard <leonard.crestez@intel.com>
> ---
>  drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 47 ++++++++++++++++++++++++++++++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c  |  5 ----
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h  |  1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c  |  5 ----
>  4 files changed, 48 insertions(+), 10 deletions(-)
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> index b269b37..5918c23 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
> @@ -116,6 +116,53 @@ static const struct inv_mpu6050_hw hw_info[] = {
>         },
>  };
>
> +static bool inv_mpu6050_volatile_reg(struct device *dev, unsigned int reg)
> +{
> +       if (reg >= INV_MPU6050_REG_RAW_ACCEL && reg < INV_MPU6050_REG_RAW_ACCEL + 6)
> +               return true;
> +       if (reg >= INV_MPU6050_REG_RAW_GYRO && reg < INV_MPU6050_REG_RAW_GYRO + 6)
> +               return true;

I think you want to put parenthesis around the addition operations...
the condition check probably don't evaluate to what you are expecting.

> +       switch (reg) {
> +       case INV_MPU6050_REG_TEMPERATURE:
> +       case INV_MPU6050_REG_TEMPERATURE + 1:
> +       case INV_MPU6050_REG_USER_CTRL:
> +       case INV_MPU6050_REG_PWR_MGMT_1:
> +       case INV_MPU6050_REG_FIFO_COUNT_H:
> +       case INV_MPU6050_REG_FIFO_COUNT_H + 1:
> +       case INV_MPU6050_REG_FIFO_R_W:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +static bool inv_mpu6050_precious_reg(struct device *dev, unsigned int reg)
> +{
> +       switch (reg) {
> +       case INV_MPU6050_REG_FIFO_R_W:
> +               return true;
> +       default:
> +               return false;
> +       }
> +}
> +
> +/*
> + * Common regmap config for inv_mpu devices
> + *
> + * The current volatile/precious registers are common among supported devices.
> + * When that changes the volatile/precious callbacks should go through the
> + * inv_mpu6050_reg_map structs.
> + */
> +const struct regmap_config inv_mpu_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +
> +       .cache_type = REGCACHE_RBTREE,
> +       .volatile_reg = inv_mpu6050_volatile_reg,
> +       .precious_reg = inv_mpu6050_precious_reg,
> +};
> +EXPORT_SYMBOL_GPL(inv_mpu_regmap_config);
> +
>  int inv_mpu6050_switch_engine(struct inv_mpu6050_state *st, bool en, u32 mask)
>  {
>         unsigned int d, mgmt_1;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> index 1a424a6..1a8d1a5 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_i2c.c
> @@ -20,11 +20,6 @@
>  #include <linux/module.h>
>  #include "inv_mpu_iio.h"
>
> -static const struct regmap_config inv_mpu_regmap_config = {
> -       .reg_bits = 8,
> -       .val_bits = 8,
> -};
> -
>  /*
>   * The i2c read/write needs to happen in unlocked mode. As the parent
>   * adapter is common. If we use locked versions, it will fail as
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index 47ca25b..297b0ef 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -291,3 +291,4 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
>  int inv_mpu_core_remove(struct device *dev);
>  int inv_mpu6050_set_power_itg(struct inv_mpu6050_state *st, bool power_on);
>  extern const struct dev_pm_ops inv_mpu_pmops;
> +extern const struct regmap_config inv_mpu_regmap_config;
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> index 190a4a5..b3bd977 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -17,11 +17,6 @@
>  #include <linux/iio/iio.h>
>  #include "inv_mpu_iio.h"
>
> -static const struct regmap_config inv_mpu_regmap_config = {
> -       .reg_bits = 8,
> -       .val_bits = 8,
> -};
> -
>  static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
>  {
>         struct inv_mpu6050_state *st = iio_priv(indio_dev);
> --
> 2.5.5
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-iio" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
