Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 145AB3515D0
	for <linux-iio@vger.kernel.org>; Sat,  8 Aug 2026 16:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786205132; cv=none; b=LscF6O3/Mw49dsF0hM/rTayz7zZPCr2B6+PuMXof/XNwGi3ujd9FZT8chplxXrsEIFxrfCvc5nOv7YyKH89Y5CYjU12gZmbu7jORcvcpTLSamY2Txo6sSnRg8stHWmH/AB4de6nbfn0uUynEJZ2b39Pw+gHffv/WPfOlnQQJPeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786205132; c=relaxed/simple;
	bh=Vma49lOJkwNkx341JK8I2l5pWCzqRw60m+NyfIaqwBA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZQzoro2nOHlPxA0+2QPjO2lFKHUMOni0LvcwofnkUbTA/qEEXFSTJNubNcUyFwJDqcf99O361YqE4yenRoHXhFtOOvFFQEbB9HvGSwBO7l1bBs+mVl9qrbMf85Pq9XqycHgCht1VmOoUMXzUdQUQlhzzaa306hY29mJ++lI6IYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pbNFLrfQ; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pbNFLrfQ"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-38e08baf860so465822a91.2
        for <linux-iio@vger.kernel.org>; Sat, 08 Aug 2026 09:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786205128; x=1786809928; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RyQWTEDWBKQ0JEqAKoM+DsN3z0w6nQEztY/u5k8ioBM=;
        b=pbNFLrfQWs8QYj9cJwedtH5LJmApbRvrsEVs+1thZjrPlh7GtHkK802ox1PLq2VJkO
         4BQxl1bjonTSQdP1kJZasLu8lSIJYHDbOvvZYWNtFwICGoYtBY0ohO+Y1KkTeZvV2eWq
         VNth8/PpPsbVCCiVxVLDHZcQ37ulGjO+usBYhzmoAJm+PG7ZjoSDZ9lXOKUSOeePsWqF
         5abKBIJwVXLGVDOL6rRXY+LdXQSI4+E9c5XT8y0vEX/6ROUn325Oas/ABcqyilaM/VPs
         oFVUVVBy0PWRP5bPE7aRfnEawM5Ew5tR2cH8w+P1izBtYtyb1NIFDYNgFrR46SknJ+45
         FevA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786205128; x=1786809928;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RyQWTEDWBKQ0JEqAKoM+DsN3z0w6nQEztY/u5k8ioBM=;
        b=UQzleu7xWcs8VNwkdiVWPze5x3lXS8ThuDD59GMigk/dfeA39PRX/bvu9Jk2Bbk765
         laj/7V8DBtukf8dGO12mztVs/ERFcHAGVkJpPT2QTpOj8ejlL5XqmOVRdxamkmgGbQe8
         R6o6Kqf0VFWEzgFmEfRKrLRLGI6RWimQa3rmP0H8harpOk+k7VPLht4p1frqeDEbSkFd
         c9oyl6zFMebxKmNXzAVfendSr3yavTwISKHvYkPm/TkWaXkpO8R0/rdYww+s8eSEvPKb
         kkfwPSUt+dop1YhSpVDMNydYgeMURoyUPxXHOVtTe+G7nLnSipGZht96BOdj5V9acDwm
         vj6w==
X-Forwarded-Encrypted: i=1; AHgh+RpWdJarKjvq2kp2+WkD7tkN7/py0IX40FbNoC9HszPFiWeVaJX4deFEUN4xCrtQqIXio75vd9Djjzo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzU/+sKUciqADaQuu7vrNbU4qslduEjDqMUUkseE72TswuAFth0
	eFmhPO8JSFWY+9TQyZzKoEuTj6Zw8VeqCiSUDZ44Qfc1DaNdKcuMT6r/
X-Gm-Gg: AR+sD13id51oc0LmxroeOG/r8eD1SeUabArPidp/Fe4AS9lvvd3qzNUS2KGwST/akZP
	M+1gzS4Rllge+zpOa4/E1Iof9el17j7n8lL9NMwiCleonh5uqNV1x72x2UQr2GEMP67nFUue3i2
	mkMfxlcDMgWkwmE1+Qq7jUG2VheWeLs0rnB90AFszeUKcX9j8xFdmCEiz4/K+05DW3PLihPC11D
	E3yJz35qi81Nw4l6PpZDAm8vdz5IlxDMsjs0DGcAYsr7GH4ZE/uJC0YrnvncSOvb5ukjTDzpA2j
	HBRgmKLrKi92lejbLcNDBCMw4iALQfIrVklPeVaqVJYS1INWpEseXqDFadNCGPdIorK8+nCDmbQ
	1iWwgr6lOTI25DW6DoO1L2CiW4FmYQ0Po7PoP46n0rw3HQNBauR4jecdG/Cjkpg0lL1odTf9R2+
	qnNAQ0knnO1UiMeOSDkroQkc0Gw/BMgQjmG/7qBemegSk3axtqbKFulqZMGyBj6ga5XPYh2g==
X-Received: by 2002:a17:90b:5484:b0:37f:c69d:ce69 with SMTP id 98e67ed59e1d1-3903c581f08mr32015152a91.10.1786205128063;
        Sat, 08 Aug 2026 09:05:28 -0700 (PDT)
Received: from localhost ([2804:30c:4018:dc00:8be4:f5b8:4af1:4728])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-14101a5ee91sm17495850c88.11.2026.08.08.09.05.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 09:05:26 -0700 (PDT)
Date: Sat, 8 Aug 2026 13:06:02 -0300
From: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Henrik Grimler <henrik.grimler@axis.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@axis.com
Subject: Re: [PATCH 2/3] iio: accel: Add support for ICM42370P
Message-ID: <andT6r0ZIR1DuZWg@debian-BULLSEYE-live-builder-AMD64>
References: <20260806-b4-inv_icm42370p-v1-0-670837f5842f@axis.com>
 <20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806-b4-inv_icm42370p-v1-2-670837f5842f@axis.com>

Hello Kanak,

Some additional comments (which may intersect with other reviews).

On 08/06, Kanak Shilledar wrote:
> Add support for the Invensense ICM42370P MEMS MotionTracking 3-axis
> accelerometer with a built-in temperature sensor. Compared to other
> sensors from the same vendor ICM42370 uses a different way of handling
> register banks. Although the device supports I2C, SPI, and I3C,
> implement only I2C support.  Provide basic support for raw sensor
> reads and a sysfs interface for setting the calibration bias. Keep the
> embedded temperature sensor enabled because the device design does not
> allow it to be turned off.
> 
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
...
> diff --git a/drivers/iio/accel/inv_icm42370.h b/drivers/iio/accel/inv_icm42370.h
> new file mode 100644
> index 0000000000000..9866a5e970dcd
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370.h
> @@ -0,0 +1,365 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +/*
> + * Copyright (C) 2020 Invensense, Inc.
> + * Copyright (C) 2026 Axis Communications AB
> + */
> +
> +#ifndef INV_ICM42370_H_
> +#define INV_ICM42370_H_
> +
> +#include <linux/bits.h>
> +#include <linux/bitfield.h>
> +#include <linux/regmap.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/common/inv_sensors_timestamp.h>

I think somebody already mentioned it (maybe Joshua), but devs have been
standardizing to have alphabetically sorted includes with IIO subsystem
ones highlighted at the end of the include list. E.g.

#include <linux/bits.h>
#include <linux/bitfield.h>
...
#include <linux/units.h>


#include <linux/iio/common/inv_sensors_timestamp.h>
#include <linux/iio/iio.h>

Note the blank line between the main include list and the includes from IIO.
Also, I'd suggest trying iwyu (https://include-what-you-use.org/) to get a
proper list of includes. Jonathan once shared a mapping file to help with
that https://lore.kernel.org/linux-iio/20250629194336.34a03946@jic23-huawei/.
Bonus, one post that might be helpful to get the tool running https://hackerbikepacker.com/iwyu.

> +
> +enum inv_icm42370_chip {
> +	INV_CHIP_INVALID,
> +	INV_CHIP_ICM42370,
> +	INV_CHIP_NB,
> +};
> +
> +/* sensor configuration struct */
> +struct inv_icm42370_conf {
> +	int mode;
> +	int fs;
> +	int odr;
> +	int filter;
> +};
> +
> +/**
> + * struct inv_icm42370_data - driver state variables
> + * @lock:		lock for serializing multiple register access.
> + * @name:		chip name.
> + * @map:		regmap pointer.
> + * @vdd_supply:		VDD voltage regulator for the chip.
> + * @vddio_supply:	I/O voltage regulator for the chip.
> + * @indio_accel:	accelerometer IIO device.
> + * @sensor_state:	per-sensor state tracking (e.g. power, ODR).
> + * @buffer:		buffer for reading data registers, aligned for DMA.
> + * @accel_calibbias:	accelerometer calibration bias for X, Y, and Z axes.
> + * @fifo:		FIFO state and configuration.
> + * @timestamp:		interrupt timestamp.
> + * @chip:		chip identifier.
> + * @conf:		chip sensors configurations.
> + */
> +struct inv_icm42370_data {
There is another 'state' struct declared below which leaves us with two types of
state structs for icm42370? Would it make sense to have them merged?

> +	struct mutex lock;
> +	const char *name;
> +	struct regmap *map;
> +	struct regulator *vdd_supply;
> +	struct regulator *vddio_supply;
I'm not seeing the regulators being used after probe. For these power supplies,
devm_regulator_get_enable() is usually enough to get them running. If that
applies to icm42370, then there will be no need for vdd fields in the state struct.

> +	struct iio_dev *indio_accel;
> +	struct inv_icm42370_sensor_state *sensor_state;
> +	u8 buffer[2] __aligned(IIO_DMA_MINALIGN);
The __aligned() pragma forces cache line alignment on the field it annotates.
IIO device drivers often have annotations like that to make data buffers use
separate cache lines and thus avoid data mishandling when doing DMA.
Though, if the alignment is forced closer to the beginning of the struct, we
may end up with holes in memory. This is not a subject I specialize in, though,
you may find this LWN article better than my poor explanation.
https://lwn.net/Articles/335942/

Besides avoiding holes in data structures, running pahole may also help you
better understand the alignment issue.

> +	s16 accel_calibbias[3];
> +	struct inv_icm42370_fifo fifo;
> +	s64 timestamp;
> +	enum inv_icm42370_chip chip;
> +	struct inv_icm42370_conf conf;
> +};
> +
...
> +
> +/* IIO format int + micro */
> +static const int inv_icm42370_accel_odr[] = {
> +	/* 1.5625Hz */
> +	1, 562500,
> +	/* 3.125Hz */
> +	3, 125000,
> +	/* 6.25Hz */
> +	6, 250000,
> +	/* 12.5Hz */
> +	12, 500000,
> +	/* 25Hz */
> +	25, 0,
> +	/* 50Hz */
> +	50, 0,
> +	/* 100Hz */
> +	100, 0,
> +	/* 200Hz */
> +	200, 0,
> +	/* 400Hz */
> +	400, 0,
> +	/* 800Hz */
> +	800, 0,
> +	/* 1.6kHz */
> +	1600, 0,
IMHO, one line for constant and one for comment is too expansive,
Since these are very short lines, I'd just do
	1600, 0, /* 1.6kHz */

> +};
> +
> +#define INV_ICM42370_SENSOR_CONF_INIT { -1, -1, -1, -1 }
> +
> +/* Registers in USER BANK 1 */
> +#define INV_ICM42370_REG_MCLK_RDY 0x0
> +#define INV_ICM42370_REG_DEVICE_CONFIG 0x01
> +#define INV_ICM42370_REG_SIGNAL_PATH_RESET 0x02
...
> +
> +#define INV_ICM42370_MCLK_RDY_BIT BIT(3)
> +#define INV_ICM42370_SOFT_RESET_BIT BIT(4)
> +#define INV_ICM42370_ACCEL_MODE_LN 0x03
> +
> +#define INV_ICM42370_DATA_INVALID -32768
> +#define INV_ICM42370_ACCEL_STARTUP_TIME_MS 10

Defines and macros are parsed and expanded early by the C preprocessor.
Usually, enums, structs, and other declarations rely on register definitions and
macros, not the opposite. So, as general piece of advice, I'd suggest to move
the defines up, right after the include section.

> +
> +typedef int (*inv_icm42370_bus_setup)(struct inv_icm42370_data *);
> +extern const struct regmap_config inv_icm42370_regmap_config;
> +
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup);
> +u32 inv_icm42370_odr_to_period(enum inv_icm42370_odr odr);
> +
> +int inv_icm42370_core_probe(struct regmap *regmap, int chip, int irq,
> +			    inv_icm42370_bus_setup bus_setup);
> +
> +struct iio_dev *inv_icm42370_accel_init(struct iio_dev *indio_dev,
> +					struct inv_icm42370_data *data);
> +
> +int inv_icm42370_set_accel_conf(struct inv_icm42370_data *dev_data,
> +				struct inv_icm42370_conf *conf,
> +				unsigned int *sleep_ms);
> +
> +int inv_icm42370_accel_parse_fifo(struct iio_dev *indio_dev);
> +
> +#endif
> diff --git a/drivers/iio/accel/inv_icm42370_core.c b/drivers/iio/accel/inv_icm42370_core.c
> new file mode 100644
> index 0000000000000..9f6c302e6f331
> --- /dev/null
> +++ b/drivers/iio/accel/inv_icm42370_core.c
> @@ -0,0 +1,1251 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2020 Invensense, Inc.
> + * Copyright (C) 2026 Axis Communications AB
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/irq.h>
> +#include <linux/slab.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/pm_runtime.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include <linux/iio/common/inv_sensors_timestamp.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>
This include section looks okay. Nevertheless, check out iwyu to figure out
extra or missing includes.

> +
> +#include "inv_icm42370.h"
> +
> +const struct regmap_config inv_icm42370_regmap_config = {
> +	.name = "inv_icm42370",
> +	.reg_bits = 8,
> +	.val_bits = 8,
> +	.max_register = 0x7E,
> +};
> +EXPORT_SYMBOL_NS_GPL(inv_icm42370_regmap_config, "IIO_ICM42370");
> +
...
> +	static u32 odr_periods[INV_ICM42370_ODR_NB] = {
> +		/* reserved values */
> +		0,
> +		0,
> +		0,
> +		0,
> +		0,
> +		/* 1.6kHz */
> +		625000,
> +		/* 800Hz */
> +		1250000,
> +		/* 400Hz */
> +		2500000,
> +		/* 200Hz */
> +		5000000,
> +		/* 100Hz */
> +		10000000,
> +		/* 50Hz */
> +		20000000,
> +		/* 25Hz */
> +		40000000,
> +		/* 12.5Hz */
> +		80000000,
> +		/* 6.25Hz */
> +		160000000,
> +		/* 3.125Hz */
> +		320000000,
> +		/* 1.5625Hz */
> +		640000000,
Same suggestion to do constants and comment on same line here.

> +	};
> +
> +	return odr_periods[odr];
> +}

Need to go AFK. Hope I can come back to it latter. If not, may catch up in v2.

With best regards,
Marcelo
