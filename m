Return-Path: <SRS0=pjyC=RR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE7F2C43381
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 19:31:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 725B6217F5
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 19:31:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X8DPZRU7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727165AbfCNTbs (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:31:48 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:41548 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfCNTbr (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Mar 2019 15:31:47 -0400
Received: by mail-lf1-f66.google.com with SMTP id 10so5119968lfr.8;
        Thu, 14 Mar 2019 12:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nfkOdm38MZ5q0MX4dU/CMa9jALCN4pcEV43X8h5vv/o=;
        b=X8DPZRU7a/pxrQekxSr7guT/JNlQryjM1JGgAAOa3/PnThrNIjBR2L+USIvH34FMku
         VhussrOzFlNjMLYgIRF6vU+RBq0HtK+l163s1940QB3bHord5I7rBzewfbO9Cema7ogP
         2bEdlXDvjpsfQJpAgJN/qzafbrf1ogB7io4Mhtggv+17Sp4oj0AFEYh3KrNo+UPZQenk
         NRT2rsm7vAYYYgd4NQbIAUGMZ/n89fFdI1hQmNyZ6LlUBaWM++U8reGLRTy5LlmrnF5y
         l/hp5SFVGeEyGYIxvPk2FlOr21RSpJRwCr9s83+zBX6X0Q63UzkXeFXgRYUCfNHKpeQt
         huIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nfkOdm38MZ5q0MX4dU/CMa9jALCN4pcEV43X8h5vv/o=;
        b=sONBrK8TTGIb1ThYPoZROlYL/fcDMNtgcglXh4CmHYgOYtwUDOvZFGEOaZxkqfMHRp
         9+THw/TM+hzcfdsxAZCaWayqz/+CTXWCOwXCc4PMPEHqQmkJ99cY6+gqOGY6jkr8pGu+
         5T+mkfNDUIyflg/4Rt3amOXcbEuPyXz8JuACInShIVO1XP2TQ5rd0uTRB3RDHnYnPN97
         1XZpNK9CmJplhWnRtFwp1RYh9ybo/x/WgQ9Hulb5/wQGE1RV4WNJ8P/lq+SwfKmYWskz
         Yn/gXCc12+hrYy1ZALjP81ttrR1mZ9cBrxJ574ebRPWLdLUMG++4UsRJ4nh3zirNL7ry
         sKMw==
X-Gm-Message-State: APjAAAWDSSFcNmnb7We3nz7feXnbON7WFz2Y4BPmpmlkg6qaXWU3CeU1
        7veCTV0sI3hcTAHFiHxb27Y=
X-Google-Smtp-Source: APXvYqyp7DnKuo5/TTvRb+p/76isV+n2WaiKFdnWiiNmfzLC43WqMbQMKzhRLNKltsJ2A6yGvaC9XA==
X-Received: by 2002:a19:9a8d:: with SMTP id c135mr27369556lfe.100.1552591904732;
        Thu, 14 Mar 2019 12:31:44 -0700 (PDT)
Received: from localhost (89-64-61-106.dynamic.chello.pl. [89.64.61.106])
        by smtp.gmail.com with ESMTPSA id q26sm2198262lfd.27.2019.03.14.12.31.43
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 12:31:43 -0700 (PDT)
Date:   Thu, 14 Mar 2019 20:31:18 +0100
From:   Tomasz Duszynski <tduszyns@gmail.com>
To:     Rui Miguel Silva <rui.silva@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Shawn Guo <shawnguo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] iio: gyro: fxas21002c: add spi driver
Message-ID: <20190314193117.GC23693@arch>
References: <20190313184002.2501-1-rui.silva@linaro.org>
 <20190313184002.2501-5-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190313184002.2501-5-rui.silva@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 13, 2019 at 06:40:00PM +0000, Rui Miguel Silva wrote:
> Add driver to talk over spi to a fxas21002c gyroscope device and use
> the core as main controller.
>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  drivers/iio/gyro/Kconfig          |  7 +++-
>  drivers/iio/gyro/Makefile         |  1 +
>  drivers/iio/gyro/fxas21002c_spi.c | 69 +++++++++++++++++++++++++++++++
>  3 files changed, 76 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/gyro/fxas21002c_spi.c
>
> diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
> index 71b6552ee06b..61c00cee037d 100644
> --- a/drivers/iio/gyro/Kconfig
> +++ b/drivers/iio/gyro/Kconfig
> @@ -78,7 +78,8 @@ config FXAS21002C
>         select IIO_BUFFER
>         select IIO_TRIGGERED_BUFFER
>         select FXAS21002C_I2C if (I2C)
> -       depends on I2C
> +       select FXAS21002C_SPI if (SPI)
> +       depends on (I2C || SPI_MASTER)
>         help
>           Say yes here to build support for NXP FXAS21002C Tri-axis Gyro
>           Sensor driver connected via I2C or SPI.
> @@ -90,6 +91,10 @@ config FXAS21002C_I2C
>         tristate
>         select REGMAP_I2C
>
> +config FXAS21002C_SPI
> +       tristate
> +       select REGMAP_SPI
> +
>  config HID_SENSOR_GYRO_3D
>  	depends on HID_SENSOR_HUB
>  	select IIO_BUFFER
> diff --git a/drivers/iio/gyro/Makefile b/drivers/iio/gyro/Makefile
> index adc18a5eb283..45cbd5dc644e 100644
> --- a/drivers/iio/gyro/Makefile
> +++ b/drivers/iio/gyro/Makefile
> @@ -14,6 +14,7 @@ obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>  obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
>  obj-$(CONFIG_FXAS21002C) += fxas21002c_core.o
>  obj-$(CONFIG_FXAS21002C_I2C) += fxas21002c_i2c.o
> +obj-$(CONFIG_FXAS21002C_SPI) += fxas21002c_spi.o
>
>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>
> diff --git a/drivers/iio/gyro/fxas21002c_spi.c b/drivers/iio/gyro/fxas21002c_spi.c
> new file mode 100644
> index 000000000000..88a4e9acad24
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas21002c_spi.c
> @@ -0,0 +1,69 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for NXP Fxas21002c Gyroscope - SPI
> + *
> + * Copyright (C) 2019 Linaro Ltd.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of.h>

Are we actually using something from of.h?

> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>

mod_devicetable.h and err.h are missing, would you mind adding these?

> +
> +#include "fxas21002c.h"
> +
> +static const struct regmap_config fxas21002c_regmap_spi_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = FXAS21002C_REG_CTRL3,
> +};
> +
> +static int fxas21002c_spi_probe(struct spi_device *spi)
> +{
> +	const struct spi_device_id *id = spi_get_device_id(spi);
> +	struct regmap *regmap;
> +
> +	regmap = devm_regmap_init_spi(spi, &fxas21002c_regmap_spi_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&spi->dev, "Failed to register spi regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	return fxas21002c_core_probe(&spi->dev, regmap, spi->irq, id->name);
> +}
> +
> +static int fxas21002c_spi_remove(struct spi_device *spi)
> +{
> +	fxas21002c_core_remove(&spi->dev);
> +
> +	return 0;
> +}
> +
> +static const struct spi_device_id fxas21002c_spi_id[] = {
> +	{ "fxas21002c", 0 },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, fxas21002c_spi_id);
> +
> +static const struct of_device_id fxas21002c_spi_of_match[] = {
> +	{ .compatible = "nxp,fxas21002c", },
> +	{ },

Presumably compatible chips will end up before sentinel which means
you can drop this extra coma.

> +};
> +MODULE_DEVICE_TABLE(of, fxas21002c_spi_of_match);
> +
> +static struct spi_driver fxas21002c_spi_driver = {
> +	.driver = {
> +		.name = "fxas21002c_spi",
> +		.pm = &fxas21002c_pm_ops,
> +		.of_match_table = of_match_ptr(fxas21002c_spi_of_match),

Some say of_match_ptr breaks ACPI probing so generally it better to
avoid it.

> +	},
> +	.probe		= fxas21002c_spi_probe,
> +	.remove		= fxas21002c_spi_remove,
> +	.id_table	= fxas21002c_spi_id,
> +};
> +module_spi_driver(fxas21002c_spi_driver);
> +
> +MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("FXAS21002C SPI Gyro driver");
> --
> 2.20.1
>
