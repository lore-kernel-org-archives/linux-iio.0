Return-Path: <SRS0=ZeA0=SR=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2D10C10F0E
	for <linux-iio@archiver.kernel.org>; Mon, 15 Apr 2019 22:18:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9AC6E20854
	for <linux-iio@archiver.kernel.org>; Mon, 15 Apr 2019 22:18:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RV4F8TY+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727186AbfDOWSD (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Mon, 15 Apr 2019 18:18:03 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:34771 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725786AbfDOWSC (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 15 Apr 2019 18:18:02 -0400
Received: by mail-yw1-f67.google.com with SMTP id x129so6616452ywc.1
        for <linux-iio@vger.kernel.org>; Mon, 15 Apr 2019 15:18:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KsVNSmLrpdepymBy/9IERbdG/BVuPWrYSmVZnRBfrkI=;
        b=RV4F8TY+iryxWOE3DU7Y3Z0HVXW3qr/HroFR1vJIrrxo6O9e9Jj89G5/iYazNyx36W
         UVZn1GWFN7WeMyI3CZwqWcAw3FgZYL5cvml0TB7ArrPIF1+uW7zwMHDDoHMGzOv9+0tO
         KUV+yzD/2oAOBik2i8dC3dYhlVvfuFEFA4XmCZkniuaSco3FgKTRFtjToSRM56tK+9+l
         d6yCHrqqyUMuIQLypXECq4MB4WSoOLj4yVxKYqPUyEHgYy9YlMOcATYlizTtyxETCNuC
         Qok5QPs5PTBVrAUhoU7fyEm2L7DoKlmx5PLt3cAnUAHV9ITTrdOe203srXNbNjcJc9XT
         4fPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KsVNSmLrpdepymBy/9IERbdG/BVuPWrYSmVZnRBfrkI=;
        b=KIYA0MdSZDzCV+GZXWxekzO8QfRmeMITetl+57DUo6xy1Ed6qJQ2o5zbsCAq99jvNT
         SHx4YFmN50wq95TyvMYbznm6MvQbjn86+AQfV/i+3JgYgDm8l3Ul0ypeX5vJG3zc308n
         Ag+1pR6sp+jmpPI2VFDjxdDngYXB0S+6Om8z6qWWCAPmZFHetB4euVl21d1+bXvOPABl
         0HjAzCu1SzgRGGBUPfp7yj9HI3yfM7yf+BaXtKoHqUnPTtEwJyzFB4K062F41RhN1En2
         AGmyjvabbtYbxCBiesLkgEvEjf626kEJNsgCGupIhLMAYCDyLp08FYyjagvs4INkBsQj
         VYRA==
X-Gm-Message-State: APjAAAXTLyuLigcEyegUURK9pXdrgIkQhqZK04dM4BudaSR0KEZ5ZU/s
        OlUqeQBRXvqJ0k+5TUhPtNi+ovpYYGP4c4/uzfw=
X-Google-Smtp-Source: APXvYqwdE4Zjqwqv/VgwDHv+G7RPX8Od41EX/7acrXUCFkwzYpcOZM5xSi2RE9uGrJkIaXgoKR6n9t5/1b3GT2hXOlI=
X-Received: by 2002:a81:5f88:: with SMTP id t130mr63436408ywb.453.1555366681385;
 Mon, 15 Apr 2019 15:18:01 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1555354268.git.vitor.soares@synopsys.com> <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
In-Reply-To: <302f8296299d6cd25b3689f5eca1c510a3290db3.1555354268.git.vitor.soares@synopsys.com>
From:   Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Date:   Tue, 16 Apr 2019 00:17:50 +0200
Message-ID: <CAA2SeNLpVpvsfjBUg2d2A+aV4RCYP5VSogDBcNZPDm7jSkZgCQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] iio: imu: st_lsm6dsx: Add i3c basic support
To:     Vitor Soares <vitor.soares@synopsys.com>
Cc:     linux-iio@vger.kernel.org, linux-i3c@lists.infradead.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Jonathan Cameron <jic23@kernel.org>, bbrezillon@kernel.org,
        rafael@kernel.org, gregkh@linuxfoundation.org, broonie@kernel.org,
        joao.pinto@synopsys.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

>
> For today the st_lsm6dsx driver support lsm6dso sensor only in
> spi and i2c mode.
>
> The lsm6dso is also i3c capable so lets give i3c support to it.
>

Hi Vitor,

thx, this is very cool :)
Just a couple of nit inline

Regards,
Lorenzo

> Signed-off-by: Vitor Soares <vitor.soares@synopsys.com>
> ---
>  drivers/iio/imu/st_lsm6dsx/Kconfig          |  8 +++-
>  drivers/iio/imu/st_lsm6dsx/Makefile         |  1 +
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c | 67 +++++++++++++++++++++++++++++
>  3 files changed, 75 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
>
> diff --git a/drivers/iio/imu/st_lsm6dsx/Kconfig b/drivers/iio/imu/st_lsm6dsx/Kconfig
> index 094fd00..1ab9bbf 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Kconfig
> +++ b/drivers/iio/imu/st_lsm6dsx/Kconfig
> @@ -1,11 +1,12 @@
>
>  config IIO_ST_LSM6DSX
>         tristate "ST_LSM6DSx driver for STM 6-axis IMU MEMS sensors"
> -       depends on (I2C || SPI)
> +       depends on (I2C || SPI || I3C)
>         select IIO_BUFFER
>         select IIO_KFIFO_BUF
>         select IIO_ST_LSM6DSX_I2C if (I2C)
>         select IIO_ST_LSM6DSX_SPI if (SPI_MASTER)
> +       select IIO_ST_LSM6DSX_I3C if (I3C)
>         help
>           Say yes here to build support for STMicroelectronics LSM6DSx imu
>           sensor. Supported devices: lsm6ds3, lsm6ds3h, lsm6dsl, lsm6dsm,
> @@ -23,3 +24,8 @@ config IIO_ST_LSM6DSX_SPI
>         tristate
>         depends on IIO_ST_LSM6DSX
>         select REGMAP_SPI
> +
> +config IIO_ST_LSM6DSX_I3C
> +       tristate
> +       depends on IIO_ST_LSM6DSX
> +       select REGMAP_I3C
> diff --git a/drivers/iio/imu/st_lsm6dsx/Makefile b/drivers/iio/imu/st_lsm6dsx/Makefile
> index e5f733c..c676965 100644
> --- a/drivers/iio/imu/st_lsm6dsx/Makefile
> +++ b/drivers/iio/imu/st_lsm6dsx/Makefile
> @@ -4,3 +4,4 @@ st_lsm6dsx-y := st_lsm6dsx_core.o st_lsm6dsx_buffer.o \
>  obj-$(CONFIG_IIO_ST_LSM6DSX) += st_lsm6dsx.o
>  obj-$(CONFIG_IIO_ST_LSM6DSX_I2C) += st_lsm6dsx_i2c.o
>  obj-$(CONFIG_IIO_ST_LSM6DSX_SPI) += st_lsm6dsx_spi.o
> +obj-$(CONFIG_IIO_ST_LSM6DSX_I3C) += st_lsm6dsx_i3c.o
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> new file mode 100644
> index 0000000..2df5e70
> --- /dev/null
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c
> @@ -0,0 +1,67 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2018 Synopsys, Inc. and/or its affiliates.
> + *
> + * Author: Vitor Soares <vitor.soares@synopsys.com>
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/i3c/device.h>
> +#include <linux/i3c/master.h>
> +#include <linux/slab.h>
> +#include <linux/of.h>
> +#include <linux/regmap.h>
> +
> +#include "st_lsm6dsx.h"
> +
> +#define NAME_SIZE      32
> +
> +struct st_lsm6dsx_i3c_data {
> +       char name[NAME_SIZE];
> +       enum st_lsm6dsx_hw_id id;
> +};
> +
> +static const struct st_lsm6dsx_i3c_data hw_data[] = {
> +       { ST_LSM6DSO_DEV_NAME, ST_LSM6DSO_ID },
> +};
> +
> +static const struct regmap_config st_lsm6dsx_i3c_regmap_config = {
> +       .reg_bits = 8,
> +       .val_bits = 8,
> +};
> +
> +static int st_lsm6dsx_i3c_probe(struct i3c_device *i3cdev)
> +{
> +       const struct i3c_device_id *id = i3c_get_device_id(i3cdev);
> +       const struct st_lsm6dsx_i3c_data *hw_data = id->data;
> +       struct regmap *regmap;
> +
> +       regmap = devm_regmap_init_i3c(i3cdev, &st_lsm6dsx_i3c_regmap_config);
> +       if (IS_ERR(regmap)) {
> +               dev_err(&i3cdev->dev, "Failed to register i3c regmap %d\n",
> +                       (int)PTR_ERR(regmap));
> +               return PTR_ERR(regmap);
> +       }
> +
> +       return st_lsm6dsx_probe(&i3cdev->dev, 0, hw_data->id,
> +                               hw_data->name, regmap);

In order to support the hw FIFO, I guess you are planning to support
interrupts/IBI here

> +}
> +

please remove 'new line' here

> +
> +static const struct i3c_device_id st_lsm6dsx_i3c_ids[] = {
> +       I3C_DEVICE(0x0104, 0x006C, &hw_data[0]),
> +       { /* sentinel */ },
> +};
> +MODULE_DEVICE_TABLE(i3c, st_lsm6dsx_i3c_ids);
> +
> +static struct i3c_driver st_lsm6dsx_driver = {
> +       .driver.name = "st_lsm6dsx_i3c",
> +       .probe = st_lsm6dsx_i3c_probe,
> +       .id_table = st_lsm6dsx_i3c_ids,
> +};
> +module_i3c_driver(st_lsm6dsx_driver);
> +
> +MODULE_AUTHOR("Vitor Soares <vitor.soares@synopsys.com>");
> +MODULE_DESCRIPTION("STMicroelectronics st_lsm6dsx i3c driver");
> +MODULE_LICENSE("GPL v2");
> +
> --
> 2.7.4
>


-- 
UNIX is Sexy: who | grep -i blonde | talk; cd ~; wine; talk; touch;
unzip; touch; strip; gasp; finger; gasp; mount; fsck; more; yes; gasp;
umount; make clean; sleep
