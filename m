Return-Path: <SRS0=djfl=QN=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D085C169C4
	for <linux-iio@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4329920844
	for <linux-iio@archiver.kernel.org>; Wed,  6 Feb 2019 13:20:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731024AbfBFNUP (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Wed, 6 Feb 2019 08:20:15 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3182 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730734AbfBFNUO (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 6 Feb 2019 08:20:14 -0500
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id B46391C48FF5F246BF98;
        Wed,  6 Feb 2019 21:20:06 +0800 (CST)
Received: from localhost (10.202.226.61) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.408.0; Wed, 6 Feb 2019
 21:20:02 +0800
Date:   Wed, 6 Feb 2019 13:19:51 +0000
From:   Jonathan Cameron <jonathan.cameron@huawei.com>
To:     Rui Miguel Silva <rui.silva@linaro.org>
CC:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: Re: [PATCH v2 3/5] iio: gyro: fxas2100x: add i2c driver
Message-ID: <20190206131951.0000212c@huawei.com>
In-Reply-To: <20190205174333.17672-4-rui.silva@linaro.org>
References: <20190205174333.17672-1-rui.silva@linaro.org>
        <20190205174333.17672-4-rui.silva@linaro.org>
Organization: Huawei
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.226.61]
X-CFilter-Loop: Reflected
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Tue, 5 Feb 2019 17:43:31 +0000
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> This add the real driver to talk over i2c and use the fxas2100x core
> for the main tasks.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Trivial comments inline.
> ---
>  drivers/iio/gyro/Kconfig         |  6 +++
>  drivers/iio/gyro/Makefile        |  1 +
>  drivers/iio/gyro/fxas2100x_i2c.c | 73 ++++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
>  create mode 100644 drivers/iio/gyro/fxas2100x_i2c.c
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index c168aa63de3b..1f9bfc51febb 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -77,6 +77,8 @@ config FXAS2100X
>  	tristate "NXP FXAS2100X Gyro Sensor"
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
> +	select FXAS2100X_I2C if (I2C)
> +	depends on (I2C || SPI_MASTER)
Bit illogical to do the SPI_MASTER case in this patch.

>  	help
>  	  Say yes here to build support for NXP FXAS2100X family Tri-axis Gyro
>  	  Sensor driver connected via I2C or SPI.
> @@ -84,6 +86,10 @@ config FXAS2100X
>  	  This driver can also be built as a module.  If so, the module
>  	  will be called fxas2100x_i2c or fxas2100x_spi.
>  
> +config FXAS2100X_I2C
> +	tristate
> +	select REGMAP_I2C
> +
>  config HID_SENSOR_GYRO_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 9e2395185a6e..8b1540ddbbce 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_BMG160) += bmg160_core.o
>  obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>  obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
>  obj-$(CONFIG_FXAS2100X) += fxas2100x_core.o
> +obj-$(CONFIG_FXAS2100X_I2C) += fxas2100x_i2c.o
>  
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>  
> diff --git a/drivers/iio/gyro/fxas2100x_i2c.c b/drivers/iio/gyro/fxas2100x_i2c.c
> new file mode 100644
> index 000000000000..b8f6d2b7f6dd
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas2100x_i2c.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for NXP FXAS2100x Gyroscope - I2C
> + *
> + * Copyright (C) 2018 Linaro Ltd.
> + *
No need for blank line.

> + */
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "fxas2100x.h"
> +
> +static const struct regmap_config fxas2100x_regmap_i2c_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = FXAS2100X_REG_CTRL3,
> +};
> +
> +static int fxas2100x_i2c_probe(struct i2c_client *i2c,
> +			       const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &fxas2100x_regmap_i2c_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return fxas2100x_core_probe(&i2c->dev, regmap, i2c->irq, name);
> +}
> +
> +static int fxas2100x_i2c_remove(struct i2c_client *i2c)
> +{
> +	fxas2100x_core_remove(&i2c->dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id fxas2100x_i2c_id[] = {
> +	{ "fxas2100x", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, fxas2100x_i2c_id);
> +
> +static const struct of_device_id fxas2100x_i2c_of_match[] = {
> +	{ .compatible = "nxp,fxas21002", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, fxas2100x_i2c_of_match);
> +
> +static struct i2c_driver fxas2100x_i2c_driver = {
> +	.driver = {
> +		.name = "fxas2100x_i2c",
> +		.pm = &fxas2100x_pm_ops,
> +		.of_match_table = of_match_ptr(fxas2100x_i2c_of_match),
> +	},
> +	.probe		= fxas2100x_i2c_probe,
> +	.remove		= fxas2100x_i2c_remove,
> +	.id_table	= fxas2100x_i2c_id,
> +};
> +module_i2c_driver(fxas2100x_i2c_driver);
> +
> +MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("FXAS2100X I2C Gyro driver");


