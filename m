Return-Path: <lucas.de.marchi@gmail.com>
MIME-Version: 1.0
In-Reply-To: <1455115303-16008-5-git-send-email-adriana.reus@intel.com>
References: <1455115303-16008-1-git-send-email-adriana.reus@intel.com> <1455115303-16008-5-git-send-email-adriana.reus@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Thu, 11 Feb 2016 03:39:48 -0200
Message-ID: <CAKi4VAJJN0zf+tdo6ZRgh1_A8g4wtEBkU0W4+8h7OQYvQBSHLw@mail.gmail.com>
Subject: Re: [PATCH v4 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com,
	Michael Welling <mwelling@ieee.org>, lars@metafoo.de,
	Daniel Baluta <daniel.baluta@intel.com>, adi.reus@gmail.com, cmo@melexis.com
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

Hi Adriana,

On Wed, Feb 10, 2016 at 12:41 PM, Adriana Reus <adriana.reus@intel.com> wrote:
> -int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
> +int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
> +                      int (*inv_mpu_bus_setup)(struct iio_dev *))
>  {
>         struct inv_mpu6050_state *st;
>         struct iio_dev *indio_dev;
> @@ -700,6 +702,9 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name)
>         if (result)
>                 return result;
>
> +       if (inv_mpu_bus_setup)
> +               inv_mpu_bus_setup(indio_dev);

ok

> +static int inv_mpu_i2c_disable(struct iio_dev *indio_dev)
> +{
> +       struct inv_mpu6050_state *st = iio_priv(indio_dev);
> +       int ret = 0;
> +
> +       ret = inv_mpu6050_set_power_itg(st, true);
> +       if (ret)
> +               return ret;
> +
> +       ret = regmap_write(st->map, INV_MPU6050_REG_USER_CTRL,
> +                             INV_MPU6050_BIT_I2C_IF_DIS);
> +       if (ret) {
> +               inv_mpu6050_set_power_itg(st, false);
> +               return ret;
> +       }

ok

> +static int inv_mpu_probe(struct spi_device *spi)
> +{
> +       struct regmap *regmap;
> +       const struct spi_device_id *id = spi_get_device_id(spi);
> +       const char *name = id ? id->name : NULL;
> +       int result;
> +
> +       regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +                       (int)PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       result = regmap_write(regmap, INV_MPU6050_REG_USER_CTRL,
> +                             INV_MPU6050_BIT_I2C_IF_DIS);
> +       if (result) {
> +               dev_err(&spi->dev, "Failed to disable I2C interface\n");
> +               return result;
> +       }

leftover from previous patch?


Lucas De Marchi
