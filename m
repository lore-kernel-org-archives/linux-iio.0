Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:34475 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755282AbcBCDzl (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 2 Feb 2016 22:55:41 -0500
Received: by mail-yk0-f196.google.com with SMTP id z7so322746yka.1
        for <linux-iio@vger.kernel.org>; Tue, 02 Feb 2016 19:55:41 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454425338-17674-5-git-send-email-adriana.reus@intel.com>
References: <1454425338-17674-1-git-send-email-adriana.reus@intel.com> <1454425338-17674-5-git-send-email-adriana.reus@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Wed, 3 Feb 2016 01:39:41 -0200
Message-ID: <CAKi4VA++NyD8uge=EfN2NT2F1xRgCYv-F89Q-Dpcu=56i4US+g@mail.gmail.com>
Subject: Re: [PATCH v1 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Adriana,

On Tue, Feb 2, 2016 at 1:02 PM, Adriana Reus <adriana.reus@intel.com> wrote:
> The only difference between the MPU6000 and the
> MPU6050 is that the first also supports SPI.
> Add SPI driver for this chip.
>
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> ---
>  Changes since initial version:
>  * Modified Kconfig so that the SPI component selects the core component
>    instead of the other way around.
>
>  drivers/iio/imu/inv_mpu6050/Kconfig       |  7 +++
>  drivers/iio/imu/inv_mpu6050/Makefile      |  3 ++
>  drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h |  1 +
>  drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c | 80 +++++++++++++++++++++++++++++++
>  4 files changed, 91 insertions(+)
>  create mode 100644 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
>
> diff --git a/drivers/iio/imu/inv_mpu6050/Kconfig b/drivers/iio/imu/inv_mpu6050/Kconfig
> index 483f52d..6f6a419 100644
> --- a/drivers/iio/imu/inv_mpu6050/Kconfig
> +++ b/drivers/iio/imu/inv_mpu6050/Kconfig
> @@ -25,3 +25,10 @@ config INV_MPU6050_I2C
>           This driver can be built as a module. The module will be called
>           inv-mpu6050-i2c.
>
> +config INV_MPU6050_SPI
> +       tristate "Invensense MPU6050 devices"
> +       select INV_MPU6050_IIO
> +       select REGMAP_SPI
> +       help
> +         This driver can be built as a module. The module will be called
> +         inv-mpu6050-spi.
> diff --git a/drivers/iio/imu/inv_mpu6050/Makefile b/drivers/iio/imu/inv_mpu6050/Makefile
> index ca4941d..734af5e 100644
> --- a/drivers/iio/imu/inv_mpu6050/Makefile
> +++ b/drivers/iio/imu/inv_mpu6050/Makefile
> @@ -7,3 +7,6 @@ inv-mpu6050-objs := inv_mpu_core.o inv_mpu_ring.o inv_mpu_trigger.o
>
>  obj-$(CONFIG_INV_MPU6050_I2C) += inv-mpu6050-i2c.o
>  inv-mpu6050-i2c-objs := inv_mpu_i2c.o inv_mpu_acpi.o
> +
> +obj-$(CONFIG_INV_MPU6050_SPI) += inv-mpu6050-spi.o
> +inv-mpu6050-spi-objs := inv_mpu_spi.o
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> index af406a3..758fe2b 100644
> --- a/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_iio.h
> @@ -62,6 +62,7 @@ struct inv_mpu6050_reg_map {
>  enum inv_devices {
>         INV_MPU6050,
>         INV_MPU6500,
> +       INV_MPU6000,
>         INV_NUM_PARTS
>  };
>
> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> new file mode 100644
> index 0000000..484171e
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -0,0 +1,80 @@
> +/*
> +* Copyright (C) 2015 Intel Corporation Inc.
> +*
> +* This software is licensed under the terms of the GNU General Public
> +* License version 2, as published by the Free Software Foundation, and
> +* may be copied, distributed, and modified under those terms.
> +*
> +* This program is distributed in the hope that it will be useful,
> +* but WITHOUT ANY WARRANTY; without even the implied warranty of
> +* MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> +* GNU General Public License for more details.
> +*/
> +#include <linux/module.h>
> +#include <linux/acpi.h>
> +#include <linux/spi/spi.h>
> +#include <linux/regmap.h>
> +#include <linux/iio/iio.h>
> +#include "inv_mpu_iio.h"
> +
> +static const struct regmap_config inv_mpu_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +};
> +
> +static int inv_mpu_probe(struct spi_device *spi)
> +{
> +       struct regmap *regmap;
> +       const struct spi_device_id *id = spi_get_device_id(spi);
> +       const char *name = id ? id->name : NULL;
> +
> +       regmap = devm_regmap_init_spi(spi, &inv_mpu_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&spi->dev, "Failed to register spi regmap %d\n",
> +                       (int)PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       return inv_mpu_core_probe(regmap, spi->irq, name);

I think there's still some spi-only initialization missing. As per
datasheet we should disable the I2C interface when using the SPI
interface.

Lucas De Marchi
