Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-yk0-f196.google.com ([209.85.160.196]:35683 "EHLO
	mail-yk0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067AbcBET3h convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 5 Feb 2016 14:29:37 -0500
Received: by mail-yk0-f196.google.com with SMTP id u9so2822052ykd.2
        for <linux-iio@vger.kernel.org>; Fri, 05 Feb 2016 11:29:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1454577628-12708-5-git-send-email-adriana.reus@intel.com>
References: <1454577628-12708-1-git-send-email-adriana.reus@intel.com> <1454577628-12708-5-git-send-email-adriana.reus@intel.com>
From: Lucas De Marchi <lucas.de.marchi@gmail.com>
Date: Fri, 5 Feb 2016 17:29:15 -0200
Message-ID: <CAKi4VAK1x1tN-tUaChbFq6f7kd=nUUcwYNWx7B4YKLq_0oCkqw@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] iio: imu: inv_mpu6050: Add SPI support for MPU6000
To: Adriana Reus <adriana.reus@intel.com>
Cc: jic23@kernel.org, linux-iio@vger.kernel.org,
	srinivas.pandruvada@linux.intel.com, ggao@invensense.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Adriana,

On Thu, Feb 4, 2016 at 7:20 AM, Adriana Reus <adriana.reus@intel.com> wrote:
> The only difference between the MPU6000 and the
> MPU6050 is that the first also supports SPI.
> Add SPI driver for this chip.
>
> Signed-off-by: Adriana Reus <adriana.reus@intel.com>
> ---

[ ... ]

> diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> new file mode 100644
> index 0000000..6a1de35
> --- /dev/null
> +++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c
> @@ -0,0 +1,87 @@
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
> +
> +       return inv_mpu_core_probe(regmap, spi->irq, name);

Here we reset the chip making superfluous the I2C disable above. See
note on section "9.1 I2C and SPI (MPU-6000 only) Serial Interfaces":

"To prevent switching into I 2 C mode when using SPI (MPU-6000), the I
2 C interface should be disabled by
setting the I2C_IF_DIS configuration bit. Setting this bit should be
performed immediately after waiting for the
time specified by the “Start-Up Time for Register Read/Write” in Section 6.3."

Lucas De Marchi
