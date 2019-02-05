Return-Path: <SRS0=iTXR=QM=vger.kernel.org=linux-iio-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1213EC282CB
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 10:51:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B3A0C20844
	for <linux-iio@archiver.kernel.org>; Tue,  5 Feb 2019 10:51:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yrv0063z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726065AbfBEKv1 (ORCPT <rfc822;linux-iio@archiver.kernel.org>);
        Tue, 5 Feb 2019 05:51:27 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:41493 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725947AbfBEKv1 (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 5 Feb 2019 05:51:27 -0500
Received: by mail-wr1-f66.google.com with SMTP id x10so3048435wrs.8
        for <linux-iio@vger.kernel.org>; Tue, 05 Feb 2019 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=references:user-agent:from:to:cc:subject:in-reply-to:date
         :message-id:mime-version;
        bh=XGNWPaUxpC07Q9Bg4SnBQi7gIafmw6bX8XYzOjprYdY=;
        b=Yrv0063zWEsVi4O4HVtSb2rtgcu7cneVLLl93IbPr1M2t/Gq67cEGKDd07JNCiLygs
         Mv+Y3xK0ZY/SpfeJt4zHE54EhrBfa3vh6TmudyYNUvsU5BpEK1PW/S9yJoi2ln9NBLWd
         uSbhEBUAjytpeXB3hzhp+dsgTqfbGzIVMfitk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:references:user-agent:from:to:cc:subject
         :in-reply-to:date:message-id:mime-version;
        bh=XGNWPaUxpC07Q9Bg4SnBQi7gIafmw6bX8XYzOjprYdY=;
        b=ahKUvuPZ4mAXqsy23ykJ+EWLrfu7QozvtKYMc4yMGXZjHqmwRuRnmA0Ma5dMhBzPcN
         6C3lILsJunk9doP+niphni10rehDKHsXwyjSGAy4fad0Ty4VXuOrvS6pvL4Gg4BMlVGn
         Yu6BCJwLDi+uCT0uMXgkRdbuGkhN6MChR5l1hRbiZuNSyuwzxMMC4y2hgr9ZrlsX7I3o
         n9hmKRhdZ3uBgh+a7zQijm2ebVrieoSbC8GpfuZxJ2SVxCSL8s0NJMxHuuiwX3a5zGpf
         nio8+YQQ1iZkJD7urB5BfFnCbpPozVU+3yGbjGRnFVXvHisYy3nkp9zBbXdkmkDrFDSZ
         dpZQ==
X-Gm-Message-State: AHQUAubx3XhL0+hlxge76fygtFxXw1lrnNKNyrHzJFLRKUyxBnqt+Q8C
        P5QRB+0blSr0/wKIGaZte3s6SB3Q+Kk=
X-Google-Smtp-Source: AHgI3IbXDp+duGn9312uSvB5KKi+1ir60oSoxhwywlzwZ5q8+SO6XrKZgFMpx1LLtM+hpA/9Sdl8Pg==
X-Received: by 2002:adf:f28d:: with SMTP id k13mr3295139wro.78.1549363882756;
        Tue, 05 Feb 2019 02:51:22 -0800 (PST)
Received: from arch-late (a109-49-46-234.cpe.netcabo.pt. [109.49.46.234])
        by smtp.gmail.com with ESMTPSA id i186sm23619612wmd.19.2019.02.05.02.51.21
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 05 Feb 2019 02:51:22 -0800 (PST)
References: <20190204170012.13617-1-rui.silva@linaro.org> <20190204170012.13617-3-rui.silva@linaro.org> <alpine.DEB.2.21.1902042021170.22458@vps.pmeerw.net>
User-agent: mu4e 1.0; emacs 27.0.50
From:   Rui Miguel Silva <rui.silva@linaro.org>
To:     Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Fabio Estevam <fabio.estevam@nxp.com>,
        linux-iio@vger.kernel.org
Subject: Re: [PATCH 2/5] iio: gyro: fxas2100x: add core driver for fxas2100x gyroscope
In-reply-to: <alpine.DEB.2.21.1902042021170.22458@vps.pmeerw.net>
Date:   Tue, 05 Feb 2019 10:51:20 +0000
Message-ID: <m3zhra33vb.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
Sender: linux-iio-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-iio.vger.kernel.org>
X-Mailing-List: linux-iio@vger.kernel.org

Hi Peter,
On Mon 04 Feb 2019 at 20:03, Peter Meerwald-Stadler wrote:
> On Mon, 4 Feb 2019, Rui Miguel Silva wrote:
>
> Hello,
>
> please find some comments below

Many thanks for your review, I will take all them in account in 
v2.

---
Cheers,
	Rui

>
> regards, p.
>
>> This add the core support for the NXP fxas2100x Tri-axis 
>> gyroscope, using
>
> adds
>
>> the iio subsystem. It supports PM operations, axis reading, 
>> temperature, scale
>> factor of the axis, high pass and low pass filtering, and 
>> sampling frequency
>> selection.
>> 
>> It will have extras modules to support the communication over 
>> i2c
>> and spi.
>> 
>> Signed-off-by: Rui Miguel Silva <rui.silva@linaro.org>
>> ---
>>  drivers/iio/gyro/Kconfig          |  11 +
>>  drivers/iio/gyro/Makefile         |   1 +
>>  drivers/iio/gyro/fxas2100x.h      | 149 +++++
>>  drivers/iio/gyro/fxas2100x_core.c | 930 
>>  ++++++++++++++++++++++++++++++
>>  4 files changed, 1091 insertions(+)
>>  create mode 100644 drivers/iio/gyro/fxas2100x.h
>>  create mode 100644 drivers/iio/gyro/fxas2100x_core.c
>> 
>> diff --git a/drivers/iio/gyro/Kconfig 
>> b/drivers/iio/gyro/Kconfig
>> index 3126cf05e6b9..c168aa63de3b 100644
>> --- a/drivers/iio/gyro/Kconfig
>> +++ b/drivers/iio/gyro/Kconfig
>> @@ -73,6 +73,17 @@ config BMG160_SPI
>>  	tristate
>>  	select REGMAP_SPI
>>  
>> +config FXAS2100X
>> +	tristate "NXP FXAS2100X Gyro Sensor"
>> +	select IIO_BUFFER
>> +	select IIO_TRIGGERED_BUFFER
>> +	help
>> +	  Say yes here to build support for NXP FXAS2100X family 
>> Tri-axis Gyro
>> +	  Sensor driver connected via I2C or SPI.
>> +
>> +	  This driver can also be built as a module.  If so, the 
>> module
>> +	  will be called fxas2100x_i2c or fxas2100x_spi.
>> +
>>  config HID_SENSOR_GYRO_3D
>>  	depends on HID_SENSOR_HUB
>>  	select IIO_BUFFER
>> diff --git a/drivers/iio/gyro/Makefile 
>> b/drivers/iio/gyro/Makefile
>> index 295ec780c4eb..9e2395185a6e 100644
>> --- a/drivers/iio/gyro/Makefile
>> +++ b/drivers/iio/gyro/Makefile
>> @@ -12,6 +12,7 @@ obj-$(CONFIG_ADXRS450) += adxrs450.o
>>  obj-$(CONFIG_BMG160) += bmg160_core.o
>>  obj-$(CONFIG_BMG160_I2C) += bmg160_i2c.o
>>  obj-$(CONFIG_BMG160_SPI) += bmg160_spi.o
>> +obj-$(CONFIG_FXAS2100X) += fxas2100x_core.o
>>  
>>  obj-$(CONFIG_HID_SENSOR_GYRO_3D) += hid-sensor-gyro-3d.o
>>  
>> diff --git a/drivers/iio/gyro/fxas2100x.h 
>> b/drivers/iio/gyro/fxas2100x.h
>> new file mode 100644
>> index 000000000000..417445d2bcda
>> --- /dev/null
>> +++ b/drivers/iio/gyro/fxas2100x.h
>> @@ -0,0 +1,149 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +/*
>> + * Driver for NXP FXAS2100x Gyroscope - Header
>> + *
>> + * Copyright (C) 2018 Linaro Ltd.
>
> the other files are (C) 2019
>
>> + *
>> + */
>> +
>> +#ifndef FXAS2100X_H_
>> +#define FXAS2100X_H_
>> +
>> +#define FXAS2100X_REG_STATUS		0x00
>> +#define FXAS2100X_REG_OUT_X_MSB		0x01
>> +#define FXAS2100X_REG_OUT_X_LSB		0x02
>> +#define FXAS2100X_REG_OUT_Y_MSB		0x03
>> +#define FXAS2100X_REG_OUT_Y_LSB		0x04
>> +#define FXAS2100X_REG_OUT_Z_MSB		0x05
>> +#define FXAS2100X_REG_OUT_Z_LSB		0x06
>> +#define FXAS2100X_REG_DR_STATUS		0x07
>> +#define FXAS2100X_REG_F_STATUS		0x08
>> +#define FXAS2100X_REG_F_SETUP		0x09
>> +#define FXAS2100X_REG_F_EVENT		0x0A
>> +#define FXAS2100X_REG_INT_SRC_FLAG	0x0B
>> +#define FXAS2100X_REG_WHO_AM_I		0x0C
>> +#define FXAS2100X_REG_CTRL0		0x0D
>> +#define FXAS2100X_REG_RT_CFG		0x0E
>> +#define FXAS2100X_REG_RT_SRC		0x0F
>> +#define FXAS2100X_REG_RT_THS		0x10
>> +#define FXAS2100X_REG_RT_COUNT		0x11
>> +#define FXAS2100X_REG_TEMP		0x12
>> +#define FXAS2100X_REG_CTRL1		0x13
>> +#define FXAS2100X_REG_CTRL2		0x14
>> +#define FXAS2100X_REG_CTRL3		0x15
>> +
>> +enum fxas2100x_fields {
>> +	F_DR_STATUS,
>> +	F_OUT_X_MSB,
>> +	F_OUT_X_LSB,
>> +	F_OUT_Y_MSB,
>> +	F_OUT_Y_LSB,
>> +	F_OUT_Z_MSB,
>> +	F_OUT_Z_LSB,
>> +	/* DR_STATUS */
>> +	F_ZYX_OW, F_Z_OW, F_Y_OW, F_X_OW, F_ZYX_DR, F_Z_DR, 
>> F_Y_DR, F_X_DR,
>> +	/* F_STATUS */
>> +	F_OVF, F_WMKF, F_CNT,
>> +	/* F_SETUP */
>> +	F_MODE, F_WMRK,
>> +	/* F_EVENT */
>> +	F_EVENT, FE_TIME,
>> +	/* INT_SOURCE_FLAG */
>> +	F_BOOTEND, F_SRC_FIFO, F_SRC_RT, F_SRC_DRDY,
>> +	/* WHO_AM_I */
>> +	F_WHO_AM_I,
>> +	/* CTRL_REG0 */
>> +	F_BW, F_SPIW, F_SEL, F_HPF_EN, F_FS,
>> +	/* RT_CFG */
>> +	F_ELE, F_ZTEFE, F_YTEFE, F_XTEFE,
>> +	/* RT_SRC */
>> +	F_EA, F_ZRT, F_ZRT_POL, F_YRT, F_YRT_POL, F_XRT, 
>> F_XRT_POL,
>> +	/* RT_THS */
>> +	F_DBCNTM, F_THS,
>> +	/* RT_COUNT */
>> +	F_RT_COUNT,
>> +	/* TEMP */
>> +	F_TEMP,
>> +	/* CTRL_REG1 */
>> +	F_RST, F_ST, F_DR, F_ACTIVE, F_READY,
>> +	/* CTRL_REG2 */
>> +	F_INT_CFG_FIFO, F_INT_EN_FIFO, F_INT_CFG_RT, F_INT_EN_RT,
>> +	F_INT_CFG_DRDY, F_INT_EN_DRDY, F_IPOL, F_PP_OD,
>> +	/* CTRL_REG3 */
>> +	F_WRAPTOONE, F_EXTCTRLEN, F_FS_DOUBLE,
>> +	/* MAX FIELDS */
>> +	F_MAX_FIELDS,
>> +};
>> +
>> +static const struct reg_field fxas2100x_reg_fields[] = {
>
> where des reg_field come from?
> ideally, a .h file should #include all the stuff it needs
>
>> +	[F_DR_STATUS]		= REG_FIELD(FXAS2100X_REG_STATUS, 
>> 0, 7),
>> +	[F_OUT_X_MSB]		= 
>> REG_FIELD(FXAS2100X_REG_OUT_X_MSB, 0, 7),
>> +	[F_OUT_X_LSB]		= 
>> REG_FIELD(FXAS2100X_REG_OUT_X_LSB, 0, 7),
>> +	[F_OUT_Y_MSB]		= 
>> REG_FIELD(FXAS2100X_REG_OUT_Y_MSB, 0, 7),
>> +	[F_OUT_Y_LSB]		= 
>> REG_FIELD(FXAS2100X_REG_OUT_Y_LSB, 0, 7),
>> +	[F_OUT_Z_MSB]		= 
>> REG_FIELD(FXAS2100X_REG_OUT_Z_MSB, 0, 7),
>> +	[F_OUT_Z_LSB]		= 
>> REG_FIELD(FXAS2100X_REG_OUT_Z_LSB, 0, 7),
>> +	[F_ZYX_OW]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 7, 7),
>> +	[F_Z_OW]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 6, 6),
>> +	[F_Y_OW]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 5, 5),
>> +	[F_X_OW]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 4, 4),
>> +	[F_ZYX_DR]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 3, 3),
>> +	[F_Z_DR]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 2, 2),
>> +	[F_Y_DR]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 1, 1),
>> +	[F_X_DR]		= 
>> REG_FIELD(FXAS2100X_REG_DR_STATUS, 0, 0),
>> +	[F_OVF]			= 
>> REG_FIELD(FXAS2100X_REG_F_STATUS, 7, 7),
>> +	[F_WMKF]		= 
>> REG_FIELD(FXAS2100X_REG_F_STATUS, 6, 6),
>> +	[F_CNT]			= 
>> REG_FIELD(FXAS2100X_REG_F_STATUS, 0, 5),
>> +	[F_MODE]		= REG_FIELD(FXAS2100X_REG_F_SETUP, 
>> 6, 7),
>> +	[F_WMRK]		= REG_FIELD(FXAS2100X_REG_F_SETUP, 
>> 0, 5),
>> +	[F_EVENT]		= REG_FIELD(FXAS2100X_REG_F_EVENT, 
>> 5, 5),
>> +	[FE_TIME]		= REG_FIELD(FXAS2100X_REG_F_EVENT, 
>> 0, 4),
>> +	[F_BOOTEND]		= 
>> REG_FIELD(FXAS2100X_REG_INT_SRC_FLAG, 3, 3),
>> +	[F_SRC_FIFO]		= 
>> REG_FIELD(FXAS2100X_REG_INT_SRC_FLAG, 2, 2),
>> +	[F_SRC_RT]		= 
>> REG_FIELD(FXAS2100X_REG_INT_SRC_FLAG, 1, 1),
>> +	[F_SRC_DRDY]		= 
>> REG_FIELD(FXAS2100X_REG_INT_SRC_FLAG, 0, 0),
>> +	[F_WHO_AM_I]		= 
>> REG_FIELD(FXAS2100X_REG_WHO_AM_I, 0, 7),
>> +	[F_BW]			= REG_FIELD(FXAS2100X_REG_CTRL0, 
>> 6, 7),
>> +	[F_SPIW]		= REG_FIELD(FXAS2100X_REG_CTRL0, 
>> 5, 5),
>> +	[F_SEL]			= REG_FIELD(FXAS2100X_REG_CTRL0, 
>> 3, 4),
>> +	[F_HPF_EN]		= REG_FIELD(FXAS2100X_REG_CTRL0, 
>> 2, 2),
>> +	[F_FS]			= REG_FIELD(FXAS2100X_REG_CTRL0, 
>> 0, 1),
>> +	[F_ELE]			= REG_FIELD(FXAS2100X_REG_RT_CFG, 
>> 3, 3),
>> +	[F_ZTEFE]		= REG_FIELD(FXAS2100X_REG_RT_CFG, 
>> 2, 2),
>> +	[F_YTEFE]		= REG_FIELD(FXAS2100X_REG_RT_CFG, 
>> 1, 1),
>> +	[F_XTEFE]		= REG_FIELD(FXAS2100X_REG_RT_CFG, 
>> 0, 0),
>> +	[F_EA]			= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 6, 6),
>> +	[F_ZRT]			= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 5, 5),
>> +	[F_ZRT_POL]		= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 4, 4),
>> +	[F_YRT]			= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 3, 3),
>> +	[F_YRT_POL]		= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 2, 2),
>> +	[F_XRT]			= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 1, 1),
>> +	[F_XRT_POL]		= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 0, 0),
>> +	[F_DBCNTM]		= REG_FIELD(FXAS2100X_REG_RT_THS, 
>> 7, 7),
>> +	[F_THS]			= REG_FIELD(FXAS2100X_REG_RT_SRC, 
>> 0, 6),
>> +	[F_RT_COUNT]		= 
>> REG_FIELD(FXAS2100X_REG_RT_COUNT, 0, 7),
>> +	[F_TEMP]		= REG_FIELD(FXAS2100X_REG_TEMP, 0, 
>> 7),
>> +	[F_RST]			= REG_FIELD(FXAS2100X_REG_CTRL1, 
>> 6, 6),
>> +	[F_ST]			= REG_FIELD(FXAS2100X_REG_CTRL1, 
>> 5, 5),
>> +	[F_DR]			= REG_FIELD(FXAS2100X_REG_CTRL1, 
>> 2, 4),
>> +	[F_ACTIVE]		= REG_FIELD(FXAS2100X_REG_CTRL1, 
>> 1, 1),
>> +	[F_READY]		= REG_FIELD(FXAS2100X_REG_CTRL1, 
>> 0, 0),
>> +	[F_INT_CFG_FIFO]	= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 7, 7),
>> +	[F_INT_EN_FIFO]		= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 6, 6),
>> +	[F_INT_CFG_RT]		= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 5, 5),
>> +	[F_INT_EN_RT]		= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 4, 4),
>> +	[F_INT_CFG_DRDY]	= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 3, 3),
>> +	[F_INT_EN_DRDY]		= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 2, 2),
>> +	[F_IPOL]		= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 1, 1),
>> +	[F_PP_OD]		= REG_FIELD(FXAS2100X_REG_CTRL2, 
>> 0, 0),
>> +	[F_WRAPTOONE]		= REG_FIELD(FXAS2100X_REG_CTRL3, 
>> 3, 3),
>> +	[F_EXTCTRLEN]		= REG_FIELD(FXAS2100X_REG_CTRL3, 
>> 2, 2),
>> +	[F_FS_DOUBLE]		= REG_FIELD(FXAS2100X_REG_CTRL3, 
>> 0, 0),
>> +};
>> +
>> +extern const struct dev_pm_ops fxas2100x_pm_ops;
>> +
>> +int fxas2100x_core_probe(struct device *dev, struct regmap 
>> *regmap, int irq,
>> +			 const char *name);
>> +void fxas2100x_core_remove(struct device *dev);
>> +#endif
>> diff --git a/drivers/iio/gyro/fxas2100x_core.c 
>> b/drivers/iio/gyro/fxas2100x_core.c
>> new file mode 100644
>> index 000000000000..1f88760563dd
>> --- /dev/null
>> +++ b/drivers/iio/gyro/fxas2100x_core.c
>> @@ -0,0 +1,930 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*
>> + * Driver for NXP FXAS2100x Gyroscope - Core
>> + *
>> + * Copyright (C) 2019 Linaro Ltd.
>> + *
>> + */
>> +
>> +#include <linux/interrupt.h>
>> +#include <linux/module.h>
>> +#include <linux/pm.h>
>> +#include <linux/pm_runtime.h>
>> +#include <linux/regmap.h>
>> +
>> +#include <linux/iio/events.h>
>> +#include <linux/iio/iio.h>
>> +#include <linux/iio/buffer.h>
>> +#include <linux/iio/sysfs.h>
>> +#include <linux/iio/trigger.h>
>> +#include <linux/iio/trigger_consumer.h>
>> +#include <linux/iio/triggered_buffer.h>
>> +
>> +#include "fxas2100x.h"
>> +
>> +#define FXAS21002_CHIP_ID_1	0xD6
>> +#define FXAS21002_CHIP_ID_2	0xD7
>> +
>> +#define FXAS2100X_MODE_STANDBY	0x00
>> +#define FXAS2100X_MODE_READY	0x01
>> +#define FXAS2100X_MODE_ACTIVE	0x02
>> +
>> +#define FXAS2100X_STANDBY_ACTIVE_TIME_MS	62
>> +#define FXAS2100X_READY_ACTIVE_TIME_MS		7
>> +
>> +#define FXAS2100X_ODR_LIST_MAX		10
>> +
>> +#define FXAS2100X_SCALE_FRACTIONAL	32
>> +#define FXAS2100X_RANGE_LIMIT_DOUBLE	2000
>> +
>> +#define FXAS2100X_AXIS_TO_REG(axis)	(FXAS2100X_REG_OUT_X_MSB + 
>> ((axis) * 2))
>> +
>> +static const int fxas2100x_odr_values[] = {
>> +	800, 400, 200, 100, 50, 25, 12, 12
>> +};
>> +
>> +/*
>> + * This values are taken from the low-pass filter cuttoff 
>> frequency calculated
>
> These
> cutoff
>
>> + * ODR * 0.lpf_values. So, for ODR = 800Hz with a lpf value = 
>> 0.32
>> + * => LPF cuttof frequency = 800 * 0.32 = 256 Hz
>
> cutoff
>
>> + */
>> +static const int fxas2100x_lpf_values[] = {
>> +	32, 16, 8
>> +};
>> +
>> +/*
>> + * This values are taken from the high-pass filter cuttoff 
>> frequency calculated
>
> These
> cutoff
>
>> + * ODR * 0.0hpf_values. So, for ODR = 800Hz with a hpf value = 
>> 0.018750
>> + * => HPF cuttof frequency = 800 * 0.018750 = 15 Hz
>
> cutoff
>
>> + */
>> +static const int fxas2100x_hpf_values[] = {
>> +	18750, 9625, 4875, 2475
>> +};
>> +
>> +static const int fxas2100x_range_values[] = {
>> +	4000, 2000, 1000, 500, 250
>> +};
>> +
>> +struct fxas2100x_data {
>> +	u8 chip_id;
>> +	u8 mode;
>> +	u8 prev_mode;
>> +	struct regmap *regmap;
>> +	struct regmap_field *regmap_fields[F_MAX_FIELDS];
>> +	struct iio_trigger *dready_trig;
>> +	struct mutex lock;		/* protect access */
>
> the commend it not very useful; protect what?
>
>> +	s16 buffer[3];
>> +	int irq;
>> +};
>> +
>> +enum fxas2100x_channel_index {
>> +	CHANNEL_SCAN_INDEX_X,
>> +	CHANNEL_SCAN_INDEX_Y,
>> +	CHANNEL_SCAN_INDEX_Z,
>> +	CHANNEL_SCAN_MAX,
>> +};
>> +
>> +static int fxas2100x_odr_hz_from_value(struct fxas2100x_data 
>> *data, u8 value)
>> +{
>> +	int odr_value_max = ARRAY_SIZE(fxas2100x_odr_values) - 1;
>> +
>> +	value = min_t(u8, value, odr_value_max);
>> +
>> +	return fxas2100x_odr_values[value];
>> +}
>> +
>> +static int fxas2100x_odr_value_from_hz(struct fxas2100x_data 
>> *data,
>> +				       unsigned int hz)
>> +{
>> +	int odr_table_size = ARRAY_SIZE(fxas2100x_odr_values);
>> +	int i;
>> +
>> +	for (i = 0; i < odr_table_size; i++)
>> +		if (fxas2100x_odr_values[i] == hz)
>> +			return i;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int fxas2100x_lpf_bw_from_value(struct fxas2100x_data 
>> *data, u8 value)
>> +{
>> +	int lpf_value_max = ARRAY_SIZE(fxas2100x_lpf_values) - 1;
>> +
>> +	value = min_t(u8, value, lpf_value_max);
>> +
>> +	return fxas2100x_lpf_values[value];
>> +}
>> +
>> +static int fxas2100x_lpf_value_from_bw(struct fxas2100x_data 
>> *data,
>> +				       unsigned int hz)
>> +{
>> +	int lpf_table_size = ARRAY_SIZE(fxas2100x_lpf_values);
>> +	int i;
>> +
>> +	for (i = 0; i < lpf_table_size; i++)
>> +		if (fxas2100x_lpf_values[i] == hz)
>> +			return i;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int fxas2100x_hpf_sel_from_value(struct fxas2100x_data 
>> *data, u8 value)
>> +{
>> +	int hpf_value_max = ARRAY_SIZE(fxas2100x_hpf_values) - 1;
>> +
>> +	value = min_t(u8, value, hpf_value_max);
>> +
>> +	return fxas2100x_hpf_values[value];
>> +}
>> +
>> +static int fxas2100x_hpf_value_from_sel(struct fxas2100x_data 
>> *data,
>> +					unsigned int hz)
>> +{
>> +	int hpf_table_size = ARRAY_SIZE(fxas2100x_hpf_values);
>> +	int i;
>> +
>> +	for (i = 0; i < hpf_table_size; i++)
>> +		if (fxas2100x_hpf_values[i] == hz)
>> +			return i;
>> +
>> +	return -EINVAL;
>> +}
>> +
>> +static int fxas2100x_range_fs_from_value(struct fxas2100x_data 
>> *data,
>> +					 u8 value)
>> +{
>> +	int range_value_max = ARRAY_SIZE(fxas2100x_range_values) - 
>> 1;
>> +	unsigned int fs_double;
>> +	int ret;
>> +
>> +	/* We need to check if FS_DOUBLE is enabled to offset the 
>> value */
>> +	ret = regmap_field_read(data->regmap_fields[F_FS_DOUBLE], 
>> &fs_double);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	value = min_t(u8, value, range_value_max);
>> +
>> +	if (!fs_double)
>> +		value += 1;
>
> what if value is already the last element of range_values?
> shouldn't the min() operation be done beforehand?
>
>> +
>> +	return fxas2100x_range_values[value];
>> +}
>> +
>> +static int fxas2100x_range_value_from_fs(struct fxas2100x_data 
>> *data,
>> +					 unsigned int range)
>> +{
>> +	int range_table_size = ARRAY_SIZE(fxas2100x_range_values);
>> +	bool found = false;
>> +	int ret;
>> +	int i;
>> +
>> +	for (i = 0; i < range_table_size; i++)
>> +		if (fxas2100x_range_values[i] == range)
>> +			found = true;
>> +	if (!found)
>> +		return -EINVAL;
>> +
>> +	if (range > FXAS2100X_RANGE_LIMIT_DOUBLE)
>> +		ret = 
>> regmap_field_write(data->regmap_fields[F_FS_DOUBLE], 1);
>> +	else
>> +		ret = 
>> regmap_field_write(data->regmap_fields[F_FS_DOUBLE], 0);
>
> ret is not checked
>
>> +
>> +	return i;
>> +}
>> +
>> +static int fxas2100x_mode_get(struct fxas2100x_data *data)
>> +{
>> +	unsigned int active;
>> +	unsigned int ready;
>> +	int ret;
>> +
>> +	ret = regmap_field_read(data->regmap_fields[F_ACTIVE], 
>> &active);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (active)
>> +		return FXAS2100X_MODE_ACTIVE;
>> +
>> +	ret = regmap_field_read(data->regmap_fields[F_READY], 
>> &ready);
>> +	if (ret < 0)
>> +		return ret;
>> +	if (ready)
>> +		return FXAS2100X_MODE_READY;
>> +
>> +	return FXAS2100X_MODE_STANDBY;
>> +}
>> +
>> +static int fxas2100x_mode_set(struct fxas2100x_data *data, u8 
>> mode)
>
> maybe mode could be an enum?
>
>> +{
>> +	int ret;
>> +
>> +	if (mode > FXAS2100X_MODE_ACTIVE)
>> +		return -EINVAL;
>> +
>> +	if (mode == data->mode)
>> +		return 0;
>> +
>> +	if (mode == FXAS2100X_MODE_READY)
>> +		ret = 
>> regmap_field_write(data->regmap_fields[F_READY], 1);
>> +	else
>> +		ret = 
>> regmap_field_write(data->regmap_fields[F_READY], 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (mode == FXAS2100X_MODE_ACTIVE)
>> +		ret = 
>> regmap_field_write(data->regmap_fields[F_ACTIVE], 1);
>> +	else
>> +		ret = 
>> regmap_field_write(data->regmap_fields[F_ACTIVE], 0);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* if going to active wait the setup times */
>> +	if (mode == FXAS2100X_MODE_ACTIVE)
>> +		if (data->mode == FXAS2100X_MODE_STANDBY)
>> + 
>> msleep_interruptible(FXAS2100X_STANDBY_ACTIVE_TIME_MS);
>> +	if (data->mode == FXAS2100X_MODE_READY)
>> + 
>> msleep_interruptible(FXAS2100X_READY_ACTIVE_TIME_MS);
>> +
>> +	data->prev_mode = data->mode;
>> +	data->mode = mode;
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_pre_write(struct fxas2100x_data *data)
>> +{
>> +	int actual_mode;
>> +
>> +	actual_mode = fxas2100x_mode_get(data);
>
> no newline here (matter of taste)
>
>> +
>> +	if (actual_mode < 0)
>> +		return actual_mode;
>> +
>> +	return fxas2100x_mode_set(data, FXAS2100X_MODE_READY);
>> +}
>> +
>> +static int fxas2100x_post_write(struct fxas2100x_data *data)
>
> is this function really needed?
>
>> +{
>> +	return fxas2100x_mode_set(data, data->prev_mode);
>> +}
>> +
>> +static int  fxas2100x_pm_get(struct fxas2100x_data *data)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	int ret;
>> +
>> +	ret = pm_runtime_get_sync(dev);
>> +	if (ret < 0)
>> +		pm_runtime_put_noidle(dev);
>> +
>> +	return ret;
>> +}
>> +
>> +static int  fxas2100x_pm_put(struct fxas2100x_data *data)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +
>> +	pm_runtime_mark_last_busy(dev);
>> +
>> +	return pm_runtime_put_autosuspend(dev);
>> +}
>> +
>> +static int fxas2100x_temp_get(struct fxas2100x_data *data, int 
>> *val)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	unsigned int temp;
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = fxas2100x_pm_get(data);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	ret = regmap_field_read(data->regmap_fields[F_TEMP], 
>> &temp);
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to read temp: %d\n", ret);
>> +		goto data_unlock;
>> +	}
>> +
>> +	*val = sign_extend32(temp, 7);
>> +
>> +	ret = fxas2100x_pm_put(data);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	ret = IIO_VAL_INT;
>> +
>> +data_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_axis_get(struct fxas2100x_data *data, int 
>> index, int *val)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	__be16 axis_be;
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = fxas2100x_pm_get(data);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	ret = regmap_bulk_read(data->regmap, 
>> FXAS2100X_AXIS_TO_REG(index),
>> +			       &axis_be, sizeof(axis_be));
>> +	if (ret < 0) {
>> +		dev_err(dev, "failed to read axis: %d: %d\n", 
>> index, ret);
>> +		goto data_unlock;
>> +	}
>> +
>> +	*val = sign_extend32(be16_to_cpu(axis_be), 15);
>> +
>> +	ret = fxas2100x_pm_put(data);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	ret = IIO_VAL_INT;
>> +
>> +data_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_odr_get(struct fxas2100x_data *data, int 
>> *odr)
>> +{
>> +	unsigned int odr_bits;
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_field_read(data->regmap_fields[F_DR], 
>> &odr_bits);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	*odr = fxas2100x_odr_hz_from_value(data, odr_bits);
>> +
>> +	ret = IIO_VAL_INT;
>> +data_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_odr_set(struct fxas2100x_data *data, int 
>> odr)
>> +{
>> +	int odr_bits;
>> +	int ret;
>> +
>> +	odr_bits = fxas2100x_odr_value_from_hz(data, odr);
>
> no newline, I'd do the check right after the assignment
> here and elsewhere
>
>> +
>> +	if (odr_bits < 0)
>> +		return odr_bits;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = fxas2100x_pre_write(data);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +	ret = regmap_field_write(data->regmap_fields[F_DR], 
>> odr_bits);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +post_write:
>> +	ret = fxas2100x_post_write(data);
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_lpf_get(struct fxas2100x_data *data, int 
>> *val2)
>> +{
>> +	unsigned int bw_bits;
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_field_read(data->regmap_fields[F_BW], 
>> &bw_bits);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	*val2 = fxas2100x_lpf_bw_from_value(data, bw_bits) * 
>> 10000;
>> +
>> +	ret = IIO_VAL_INT_PLUS_MICRO;
>> +
>> +data_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_lpf_set(struct fxas2100x_data *data, int 
>> bw)
>> +{
>> +	int bw_bits;
>> +	int odr;
>> +	int ret;
>> +
>> +	bw_bits = fxas2100x_lpf_value_from_bw(data, bw);
>> +
>> +	if (bw_bits < 0)
>> +		return bw_bits;
>> +
>> +	/*
>> +	 * From table 33 of the device spec, for ODR = 25Hz and 
>> 12.5 value 0.08
>> +	 * is not allowed and for ODR = 12.5 value 0.16 is also 
>> not allowed
>> +	 */
>> +	ret = fxas2100x_odr_get(data, &odr);
>> +	if (ret < 0)
>> +		return -EINVAL;
>> +
>> +	if ((odr == 25 && bw_bits > 0x01) || (odr == 12 && bw_bits 
>> > 0))
>> +		return -EINVAL;
>> +
>
> probably the sequence 
> pre_write()
> regmap_field_write()
> post_write()
> could be put into a helper function to safe some lines of code
>
>> +	mutex_lock(&data->lock);
>> +	ret = fxas2100x_pre_write(data);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +	ret = regmap_field_write(data->regmap_fields[F_BW], 
>> bw_bits);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +post_write:
>> +	ret = fxas2100x_post_write(data);
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_hpf_get(struct fxas2100x_data *data, int 
>> *val2)
>> +{
>> +	unsigned int sel_bits;
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_field_read(data->regmap_fields[F_SEL], 
>> &sel_bits);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	*val2 = fxas2100x_hpf_sel_from_value(data, sel_bits);
>> +
>> +	ret = IIO_VAL_INT_PLUS_MICRO;
>> +
>> +data_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_hpf_set(struct fxas2100x_data *data, int 
>> sel)
>> +{
>> +	int sel_bits;
>> +	int ret;
>> +
>> +	sel_bits = fxas2100x_hpf_value_from_sel(data, sel);
>> +
>> +	if (sel_bits < 0)
>> +		return sel_bits;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = fxas2100x_pre_write(data);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +	ret = regmap_field_write(data->regmap_fields[F_SEL], 
>> sel_bits);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +post_write:
>> +	ret = fxas2100x_post_write(data);
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_scale_get(struct fxas2100x_data *data, 
>> int *val)
>> +{
>> +	int fs_bits;
>> +	int scale;
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_field_read(data->regmap_fields[F_FS], 
>> &fs_bits);
>> +	if (ret < 0)
>> +		goto data_unlock;
>> +
>> +	scale = fxas2100x_range_fs_from_value(data, fs_bits);
>> +
>> +	*val = scale;
>> +
>> +	ret = IIO_VAL_FRACTIONAL;
>> +
>> +data_unlock:
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_scale_set(struct fxas2100x_data *data, 
>> int range)
>> +{
>> +	int fs_bits;
>> +	int ret;
>> +
>> +	fs_bits = fxas2100x_range_value_from_fs(data, range);
>> +
>> +	if (fs_bits < 0)
>> +		return fs_bits;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = fxas2100x_pre_write(data);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +	ret = regmap_field_write(data->regmap_fields[F_FS], 
>> fs_bits);
>> +	if (ret < 0)
>> +		goto post_write;
>> +
>> +post_write:
>> +	ret = fxas2100x_post_write(data);
>> +
>> +	mutex_unlock(&data->lock);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_read_raw(struct iio_dev *indio_dev,
>> +			      struct iio_chan_spec const *chan, 
>> int *val,
>> +			      int *val2, long mask)
>> +{
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_RAW:
>> +		switch (chan->type) {
>> +		case IIO_TEMP:
>> +			return fxas2100x_temp_get(data, val);
>> +		case IIO_ANGL_VEL:
>> +			return fxas2100x_axis_get(data, 
>> chan->scan_index, val);
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ANGL_VEL:
>> +			*val2 = FXAS2100X_SCALE_FRACTIONAL;
>> +			return fxas2100x_scale_get(data, val);
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>> +		*val = 0;
>> +		return fxas2100x_lpf_get(data, val2);
>> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>> +		*val = 0;
>> +		return fxas2100x_hpf_get(data, val2);
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>> +		*val2 = 0;
>> +		return fxas2100x_odr_get(data, val);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static int fxas2100x_write_raw(struct iio_dev *indio_dev,
>> +			       struct iio_chan_spec const *chan, 
>> int val,
>> +			       int val2, long mask)
>> +{
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +	int range;
>> +
>> +	switch (mask) {
>> +	case IIO_CHAN_INFO_SAMP_FREQ:
>
> check that val2 == 0?
>
>> +		return fxas2100x_odr_set(data, val);
>> +	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>
> check that val == 0?
>
>> +		val2 = val2 / 10000;
>> +		return fxas2100x_lpf_set(data, val2);
>> +	case IIO_CHAN_INFO_SCALE:
>> +		switch (chan->type) {
>> +		case IIO_ANGL_VEL:
>> +			range = (((val * 1000 + val2 / 1000) *
>> +				  FXAS2100X_SCALE_FRACTIONAL) / 
>> 1000);
>> +			return fxas2100x_scale_set(data, range);
>> +		default:
>> +			return -EINVAL;
>> +		}
>> +	case IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY:
>> +		return fxas2100x_hpf_set(data, val2);
>> +	default:
>> +		return -EINVAL;
>> +	}
>> +}
>> +
>> +static IIO_CONST_ATTR_SAMP_FREQ_AVAIL("12.5 25 50 100 200 400 
>> 800");
>> +
>> +static 
>> IIO_CONST_ATTR(in_anglvel_filter_low_pass_3db_frequency_available,
>> +		      "0.32 0.16 0.08");
>> +
>> +static 
>> IIO_CONST_ATTR(in_anglvel_filter_high_pass_3db_frequency_available,
>> +		      "0.018750 0.009625 0.004875 0.002475");
>> +
>> +static IIO_CONST_ATTR(in_anglvel_scale_available,
>> +		      "125.0 62.5 31.25 15.625 7.8130");
>
> 7.8125? (see table 35)
>
>> +
>> +static struct attribute *fxas2100x_attributes[] = {
>> + 
>> &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> + 
>> &iio_const_attr_in_anglvel_filter_low_pass_3db_frequency_available.dev_attr.attr,
>> + 
>> &iio_const_attr_in_anglvel_filter_high_pass_3db_frequency_available.dev_attr.attr,
>> +	&iio_const_attr_in_anglvel_scale_available.dev_attr.attr,
>> +	NULL,
>> +};
>> +
>> +static const struct attribute_group fxas2100x_attrs_group = {
>> +	.attrs = fxas2100x_attributes,
>> +};
>> +
>> +#define FXAS2100X_CHANNEL(_axis) { 
>> \
>> +	.type = IIO_ANGL_VEL, 
>> \
>> +	.modified = 1, 
>> \
>> +	.channel2 = IIO_MOD_##_axis, 
>> \
>> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), 
>> \
>> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | 
>> \
>> +		BIT(IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY) | 
>> \
>> +		BIT(IIO_CHAN_INFO_HIGH_PASS_FILTER_3DB_FREQUENCY) 
>> |	\
>> +		BIT(IIO_CHAN_INFO_SAMP_FREQ), 
>> \
>> +	.scan_index = CHANNEL_SCAN_INDEX_##_axis, 
>> \
>> +	.scan_type = { 
>> \
>> +		.sign = 's', 
>> \
>> +		.realbits = 16, 
>> \
>> +		.storagebits = 16, 
>> \
>> +		.endianness = IIO_BE, 
>> \
>> +	}, 
>> \
>> +}
>> +
>> +static const struct iio_chan_spec fxas2100x_channels[] = {
>> +	{
>> +		.type = IIO_TEMP,
>> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
>> +		.scan_index = -1,
>> +	},
>> +	FXAS2100X_CHANNEL(X),
>> +	FXAS2100X_CHANNEL(Y),
>> +	FXAS2100X_CHANNEL(Z),
>> +};
>> +
>> +static const struct iio_info fxas2100x_info = {
>> +	.attrs			= &fxas2100x_attrs_group,
>> +	.read_raw		= &fxas2100x_read_raw,
>> +	.write_raw		= &fxas2100x_write_raw,
>> +};
>> +
>> +static irqreturn_t fxas2100x_trigger_handler(int irq, void *p)
>> +{
>> +	struct iio_poll_func *pf = p;
>> +	struct iio_dev *indio_dev = pf->indio_dev;
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	mutex_lock(&data->lock);
>> +	ret = regmap_bulk_read(data->regmap, 
>> FXAS2100X_REG_OUT_X_MSB,
>> +			       data->buffer, CHANNEL_SCAN_MAX * 
>> 2);
>
> 2 == sizeof(s16)
>
>> +	mutex_unlock(&data->lock);
>> +	if (ret < 0)
>> +		goto notify_done;
>> +
>> +	iio_push_to_buffers_with_timestamp(indio_dev, 
>> data->buffer,
>> +					   pf->timestamp);
>
> the buffer is too small; the timestamp needs to fit into the 
> buffer as 
> well
>
> 3*sizeof(s16) + /* padding */ sizeof(s16) + /* timestamp */ + 
> 4*sizeof(s16)
>
>> +
>> +notify_done:
>> +	iio_trigger_notify_done(indio_dev->trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int fxas2100x_chip_init(struct fxas2100x_data *data)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	unsigned int chip_id;
>> +	int ret;
>> +
>> +	ret = regmap_field_read(data->regmap_fields[F_WHO_AM_I], 
>> &chip_id);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	if (chip_id != FXAS21002_CHIP_ID_1 && chip_id != 
>> FXAS21002_CHIP_ID_2) {
>> +		dev_err(dev, "chip id %d is not supported\n", 
>> chip_id);
>
> maybe use %02x to output the chip id
>
>> +		return -EINVAL;
>> +	}
>> +
>> +	data->chip_id = chip_id;
>> +
>> +	ret = fxas2100x_mode_set(data, FXAS2100X_MODE_STANDBY);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	/* Set ODR to 200HZ as default */
>> +	ret = fxas2100x_odr_set(data, 200);
>> +	if (ret < 0)
>> +		dev_err(dev, "failed to set ODR: %d\n", ret);
>> +
>> +	return ret;
>> +}
>> +
>> +static int fxas2100x_data_rdy_trigger_set_state(struct 
>> iio_trigger *trig,
>> +						bool state)
>> +{
>> +	struct iio_dev *indio_dev = iio_trigger_get_drvdata(trig);
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +
>> +	return 
>> regmap_field_write(data->regmap_fields[F_INT_EN_DRDY], 
>> !!state);
>
> no need for !!, state is bool
>
>> +}
>> +
>> +static const struct iio_trigger_ops fxas2100x_trigger_ops = {
>> +	.set_trigger_state = 
>> &fxas2100x_data_rdy_trigger_set_state,
>> +};
>> +
>> +static irqreturn_t fxas2100x_data_rdy_trig_poll(int irq, void 
>> *private)
>> +{
>> +	struct iio_dev *indio_dev = private;
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +
>> +	iio_trigger_poll(data->dready_trig);
>> +
>> +	return IRQ_HANDLED;
>> +}
>> +
>> +static int fxas2100x_trigger_probe(struct fxas2100x_data 
>> *data)
>> +{
>> +	struct device *dev = regmap_get_device(data->regmap);
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	int ret;
>> +
>> +	if (!data->irq)
>> +		return 0;
>> +
>> +	data->dready_trig = devm_iio_trigger_alloc(dev, 
>> "%s-dev%d",
>> + 
>> indio_dev->name,
>> +						   indio_dev->id);
>> +	if (!data->dready_trig)
>> +		return -ENOMEM;
>> +
>> +	ret = devm_request_irq(dev, data->irq, 
>> fxas2100x_data_rdy_trig_poll,
>> +			       IRQF_TRIGGER_RISING, 
>> "fxas2100x_data_ready",
>> +			       data->dready_trig);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	data->dready_trig->dev.parent = dev;
>> +	data->dready_trig->ops = &fxas2100x_trigger_ops;
>> +	iio_trigger_set_drvdata(data->dready_trig, indio_dev);
>> +
>> +	ret = devm_iio_trigger_register(dev, data->dready_trig);
>
> just 
> return devm_iio_trigger_register(...);
>
>> +	if (ret)
>> +		return ret;
>> +
>> +	return 0;
>> +}
>> +
>> +int fxas2100x_core_probe(struct device *dev, struct regmap 
>> *regmap, int irq,
>> +			 const char *name)
>> +{
>> +	struct fxas2100x_data *data;
>> +	struct iio_dev *indio_dev;
>> +	struct regmap_field *f;
>> +	int i;
>> +	int ret;
>> +
>> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
>> +	if (!indio_dev)
>> +		return -ENOMEM;
>> +
>> +	data = iio_priv(indio_dev);
>> +	dev_set_drvdata(dev, indio_dev);
>> +	data->irq = irq;
>> +	data->regmap = regmap;
>> +
>> +	for (i = 0; i < F_MAX_FIELDS; i++) {
>> +		f = devm_regmap_field_alloc(dev, data->regmap,
>> + 
>> fxas2100x_reg_fields[i]);
>> +		if (IS_ERR(f)) {
>> +			dev_err(dev, "failed to alloc regmap field 
>> %d: %ld\n",
>> +				i, PTR_ERR(f));
>> +			return PTR_ERR(f);
>> +		}
>> +		data->regmap_fields[i] = f;
>> +	}
>> +
>> +	mutex_init(&data->lock);
>> +
>> +	ret = fxas2100x_chip_init(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	indio_dev->dev.parent = dev;
>> +	indio_dev->channels = fxas2100x_channels;
>> +	indio_dev->num_channels = ARRAY_SIZE(fxas2100x_channels);
>> +	indio_dev->name = name;
>> +	indio_dev->modes = INDIO_DIRECT_MODE;
>> +	indio_dev->info = &fxas2100x_info;
>> +
>> +	ret = fxas2100x_trigger_probe(data);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = devm_iio_triggered_buffer_setup(dev, indio_dev,
>> + 
>> iio_pollfunc_store_time,
>> + 
>> fxas2100x_trigger_handler, NULL);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	ret = pm_runtime_set_active(dev);
>> +	if (ret)
>> +		return ret;
>> +
>> +	pm_runtime_enable(dev);
>> +	pm_runtime_set_autosuspend_delay(dev, 2000);
>> +	pm_runtime_use_autosuspend(dev);
>> +
>> +	ret = devm_iio_device_register(dev, indio_dev);
>> +	if (ret < 0) {
>> +		dev_err(dev, "unable to register iio device: 
>> %d\n", ret);
>
> this error message is rather pointless, the user will find out 
> regardless :)
>
>> +		return ret;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL_GPL(fxas2100x_core_probe);
>> +
>> +void fxas2100x_core_remove(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +
>> +	pm_runtime_disable(dev);
>> +	pm_runtime_set_suspended(dev);
>> +	pm_runtime_put_noidle(dev);
>> +
>> +	fxas2100x_mode_set(data, FXAS2100X_MODE_STANDBY);
>> +}
>> +EXPORT_SYMBOL_GPL(fxas2100x_core_remove);
>> +
>> +#ifdef CONFIG_PM_SLEEP
>> +static int fxas2100x_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +
>> +	fxas2100x_mode_set(data, FXAS2100X_MODE_STANDBY);
>> +
>> +	return 0;
>> +}
>> +
>> +static int fxas2100x_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +
>> +	fxas2100x_mode_set(data, data->prev_mode);
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +#ifdef CONFIG_PM
>> +static int fxas2100x_runtime_suspend(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = fxas2100x_mode_set(data, FXAS2100X_MODE_READY);
>> +	if (ret < 0)
>> +		return -EAGAIN;
>> +
>> +	return 0;
>> +}
>> +
>> +static int fxas2100x_runtime_resume(struct device *dev)
>> +{
>> +	struct iio_dev *indio_dev = dev_get_drvdata(dev);
>> +	struct fxas2100x_data *data = iio_priv(indio_dev);
>> +	int ret;
>> +
>> +	ret = fxas2100x_mode_set(data, FXAS2100X_MODE_ACTIVE);
>> +	if (ret < 0)
>> +		return -EAGAIN;
>> +
>> +	return 0;
>> +}
>> +#endif
>> +
>> +const struct dev_pm_ops fxas2100x_pm_ops = {
>> +	SET_SYSTEM_SLEEP_PM_OPS(fxas2100x_suspend, 
>> fxas2100x_resume)
>> +	SET_RUNTIME_PM_OPS(fxas2100x_runtime_suspend,
>> +			   fxas2100x_runtime_resume, NULL)
>> +};
>> +EXPORT_SYMBOL_GPL(fxas2100x_pm_ops);
>> +
>> +MODULE_AUTHOR("Rui Miguel Silva <rui.silva@linaro.org>");
>> +MODULE_LICENSE("GPL v2");
>> +MODULE_DESCRIPTION("FXAS2100X Gyro driver");
>> 

