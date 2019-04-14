Return-Path: <SRS0=A0tK=SQ=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EE22C10F14
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:41:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 18C9D218FC
	for <linux-iio@archiver.kernel.org>; Sun, 14 Apr 2019 13:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1555249289;
	bh=9aDtPpBMvZGJt013pP3AgBysG8TsTr0x4VkfeyjRLSg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=D0fNFumO0TdKVZVL2ylMitDZeYoiyCIAb7qMfSJzMx53M4gNhBg4nt28YQvgRfmeq
	 kpZR9tMcuC5EJ/65nJ9z/VLkzqH5OlA41U7yam20kwYbDa8JHRyC6Vujzlp6rXmJeF
	 IzICPAdJNN+n6cwN0UuU3cktRAAx3nKQ5eOWYjQE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726237AbfDNNl2 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Sun, 14 Apr 2019 09:41:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:47386 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725805AbfDNNl2 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 14 Apr 2019 09:41:28 -0400
Received: from archlinux (cpc91196-cmbg18-2-0-cust659.5-4.cable.virginm.net [81.96.234.148])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 62A592084E;
        Sun, 14 Apr 2019 13:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1555249287;
        bh=9aDtPpBMvZGJt013pP3AgBysG8TsTr0x4VkfeyjRLSg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=FFB9cpAfZRCy90ffEmQYcZwwzdSEqpqTK5UNa7EvH5zomu8B7UPcLRr1hGwLUaHVg
         GWsgRBpCQNbdL22XjdNTypaIweR8QecKnYpQ9pgMN7aCv65C7H5uev0SeHuDN0m74w
         gVE0PifUDYaHDKAxFf+elagF0+WQdM+5l/m9nHCo=
Date:   Sun, 14 Apr 2019 14:39:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 3/6] iio: gyro: fxas21002c: add i2c driver
Message-ID: <20190414143910.2d206120@archlinux>
In-Reply-To: <20190412164901.2321-4-rui.silva@linaro.org>
References: <20190412164901.2321-1-rui.silva@linaro.org>
        <20190412164901.2321-4-rui.silva@linaro.org>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Fri, 12 Apr 2019 17:48:58 +0100
Rui Miguel Silva <rui.silva@linaro.org> wrote:

> Add the real driver to talk over i2c and use the fxas21002c core
> for the main tasks.
> 
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
Applied, thanks,

Jonathan
> ---
>  drivers/iio/gyro/Kconfig          |  6 +++
>  drivers/iio/gyro/Makefile         |  1 +
>  drivers/iio/gyro/fxas21002c_i2c.c | 69 +++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+)
>  create mode 100644 drivers/iio/gyro/fxas21002c_i2c.c
> 
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index cfd2cf44bac8..71b6552ee06b 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -77,6 +77,8 @@ config FXAS21002C
>         tristate "NXP FXAS21002C Gyro Sensor"
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
> +       select FXAS21002C_I2C if (I2C)
> +       depends on I2C
>         help
>           Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
>           Sensor driver connected via I2C or SPI.
> @@ -84,6 +86,10 @@ config FXAS21002C
>           This driver can also be built as a module.  If so, the module
>           will be called fxas21002c_i2c or fxas21002c_spi.
>  
> +config FXAS21002C_I2C
> +       tristate
> +       select REGMAP_I2C
> +
>  config HID_SENSOR_GYRO_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index 247dc600a602..adc18a5eb283 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -13,6 +13,7 @@ obj-$(CONFIG_BMG160) += bmg160_core.o
>  obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>  obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
>  obj-$(CONFIG_FXAS21002C) += fxas21002c_core.o
> +obj-$(CONFIG_FXAS21002C_I2C) += fxas21002c_i2c.o
>  
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>  
> diff --git a/drivers/iio/gyro/fxas21002c_i2c.c b/drivers/iio/gyro/fxas21002c_i2c.c
> new file mode 100644
> index 000000000000..a7807fd97483
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas21002c_i2c.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for NXP FXAS21002C Gyroscope - I2C
> + *
> + * Copyright (C) 2018 Linaro Ltd.
> + */
> +
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "fxas21002c.h"
> +
> +static const struct regmap_config fxas21002c_regmap_i2c_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = FXAS21002C_REG_CTRL3,
> +};
> +
> +static int fxas21002c_i2c_probe(struct i2c_client *i2c)
> +{
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &fxas21002c_regmap_i2c_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return fxas21002c_core_probe(&i2c->dev, regmap, i2c->irq, i2c->name);
> +}
> +
> +static int fxas21002c_i2c_remove(struct i2c_client *i2c)
> +{
> +	fxas21002c_core_remove(&i2c->dev);
> +
> +	return 0;
> +}
> +
> +static const struct i2c_device_id fxas21002c_i2c_id[] = {
> +	{ "fxas21002c", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, fxas21002c_i2c_id);
> +
> +static const struct of_device_id fxas21002c_i2c_of_match[] = {
> +	{ .compatible = "nxp,fxas21002c", },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, fxas21002c_i2c_of_match);
> +
> +static struct i2c_driver fxas21002c_i2c_driver = {
> +	.driver = {
> +		.name = "fxas21002c_i2c",
> +		.pm = &fxas21002c_pm_ops,
> +		.of_match_table = fxas21002c_i2c_of_match,
> +	},
> +	.probe_new	= fxas21002c_i2c_probe,
> +	.remove		= fxas21002c_i2c_remove,
> +	.id_table	= fxas21002c_i2c_id,
> +};
> +module_i2c_driver(fxas21002c_i2c_driver);
> +
> +MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("FXAS21002C I2C Gyro driver");

