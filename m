Return-Path: <SRS0=pjyC=RR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_MUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25520C43381
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 19:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EAB4621874
	for <linux-iio@archiver.kernel.org>; Thu, 14 Mar 2019 19:45:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W44kvbc+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727228AbfCNTpu (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Thu, 14 Mar 2019 15:45:50 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:36733 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726972AbfCNTpu (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 14 Mar 2019 15:45:50 -0400
Received: by mail-lj1-f193.google.com with SMTP id v10so5908239lji.3;
        Thu, 14 Mar 2019 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3mei27eK+7OO35CVOu3wbY1sNorWl/WGJmqN5xWLeaw=;
        b=W44kvbc+YDpUr9seX4Z5fy08R2r8j8jKA2a/X4jWGVG++9VVB21jr8lB5TYRLYnpob
         HJa5Cq2XftngGu85K31r+DCkwvnm/7gpWXJRM6Icz/evr5E8pYjOv9BwoJdjg4mtqw5P
         iHF0NbSKT/ISZvtVKsEv0z8ohxw+1dvoi4apKs/IFUzKSTqxV0oTu3Isge8oBbB+BoAn
         dVpiw6Vu7mbNF/I/mB7zBteLVcbkJKCwXqgdZzwwjgIEEj7/SCgKJhQthLQDSh6Hmp47
         UCunCgZd+k4qTEBG4Y3zyOnULnmWa6qeOOYj1nprPAdnuE71NtFzqBxmiT4iy+sfTxlU
         HJ6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3mei27eK+7OO35CVOu3wbY1sNorWl/WGJmqN5xWLeaw=;
        b=uHTfYJ6jApDoEKsCzW3K1bu5cxn6TB5UAH7b4EOao0+vhvD35k9stDj+Rs4F8PDWMa
         l9eHZh3CO5WGZgxP4UTKEnoSr+6fYNVKUc2QpzBXPAysbREuDHZB0H5we4D5Pr9F4qsk
         NeXTHe8JjHGD5UXck1sqCY+6Vs4ddSJlQZ/F+F26ZIpMdNAtdQ0FeqYEgIEjlkbIJNqF
         p+PrrkbEknFO3AQGiBJJ5/JUrRC2p93WGj1us4mkbJY2RiPhwwobbZRGncGA0drClLk8
         4rolzzs408KmhaR9Vk8Mbv5qPVH+yM45UaqmYWe5sP6gCJgLN9UdX8O5x1EKn/irjr3t
         TKfw==
X-Gm-Message-State: APjAAAXD0CkYULSGRGT2Mx1lSTrhtCEPlsePydPqY5eyJ059Dehz3ML1
        EIp2XgqbIdWE1LTGrCIlLLE=
X-Google-Smtp-Source: APXvYqwv4NlRn48V75UH9KwNJNBgxXOryLXc2doEjdA68Kn30H1vrg5sAqqIgRdiZwKjmGRJ/MtwEw==
X-Received: by 2002:a2e:20b:: with SMTP id 11mr27739169ljc.41.1552592311825;
        Thu, 14 Mar 2019 12:38:31 -0700 (PDT)
Received: from localhost (89-64-61-106.dynamic.chello.pl. [89.64.61.106])
        by smtp.gmail.com with ESMTPSA id v1sm2895460lfg.13.2019.03.14.12.38.30
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Mar 2019 12:38:31 -0700 (PDT)
Date:   Thu, 14 Mar 2019 20:38:06 +0100
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
Subject: Re: [PATCH v3 3/6] iio: gyro: fxas21002c: add i2c driver
Message-ID: <20190314193805.GD23693@arch>
References: <20190313184002.2501-1-rui.silva@linaro.org>
 <20190313184002.2501-4-rui.silva@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190313184002.2501-4-rui.silva@linaro.org>
User-Agent: Mutt/1.11.4 (2019-03-13)
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

On Wed, Mar 13, 2019 at 06:39:59PM +0000, Rui Miguel Silva wrote:
> Add the real driver to talk over i2c and use the fxas21002c core
> for the main tasks.
>
> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
> ---
>  drivers/iio/gyro/Kconfig          |  6 +++
>  drivers/iio/gyro/Makefile         |  1 +
>  drivers/iio/gyro/fxas21002c_i2c.c | 73 +++++++++++++++++++++++++++++++
>  3 files changed, 80 insertions(+)
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
> index 000000000000..c248ac5251df
> --- /dev/null
> +++ b/drivers/iio/gyro/fxas21002c_i2c.c
> @@ -0,0 +1,73 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Driver for NXP FXAS21002C Gyroscope - I2C
> + *
> + * Copyright (C) 2018 Linaro Ltd.
> + */
> +
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +

Some headers are missing. Generally not a big deal but better to have
everything in place.

> +#include "fxas21002c.h"
> +
> +static const struct regmap_config fxas21002c_regmap_i2c_conf = {
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = FXAS21002C_REG_CTRL3,
> +};
> +
> +static int fxas21002c_i2c_probe(struct i2c_client *i2c,
> +				const struct i2c_device_id *id)
> +{
> +	struct regmap *regmap;
> +	const char *name = NULL;
> +
> +	regmap = devm_regmap_init_i2c(i2c, &fxas21002c_regmap_i2c_conf);
> +	if (IS_ERR(regmap)) {
> +		dev_err(&i2c->dev, "Failed to register i2c regmap: %ld\n",
> +			PTR_ERR(regmap));
> +		return PTR_ERR(regmap);
> +	}
> +
> +	if (id)
> +		name = id->name;
> +
> +	return fxas21002c_core_probe(&i2c->dev, regmap, i2c->irq, name);
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
> +	{ },

Comma not really needed?

> +};
> +MODULE_DEVICE_TABLE(of, fxas21002c_i2c_of_match);
> +
> +static struct i2c_driver fxas21002c_i2c_driver = {
> +	.driver = {
> +		.name = "fxas21002c_i2c",
> +		.pm = &fxas21002c_pm_ops,
> +		.of_match_table = of_match_ptr(fxas21002c_i2c_of_match),

of_match_ptr can be dropped I guess due to the fact that it breaks
ACPI probing.

> +	},
> +	.probe		= fxas21002c_i2c_probe,

New drivers should rather use probe_new.

> +	.remove		= fxas21002c_i2c_remove,
> +	.id_table	= fxas21002c_i2c_id,
> +};
> +module_i2c_driver(fxas21002c_i2c_driver);
> +
> +MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
> +MODULE_LICENSE("GPL v2");
> +MODULE_DESCRIPTION("FXAS21002C I2C Gyro driver");
> --
> 2.20.1
>
