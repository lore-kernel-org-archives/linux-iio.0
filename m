Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C132F3CC310;
	Thu, 11 Jun 2026 11:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781176383; cv=none; b=TN315LKp/4rN2vnRpNwOnEQRGKmDqgeONmG3SYWPU+Ni3WS6hyg/IrLWH0rQbmUgIRT+8wezPbjN4KPxWDKKOBDJVdPZUyqDKVzstLk9CSv6xDjNMcPXRLsj5CA/zMWSq8rmIAz740V4GQVjf5C2SEfVrmiIYhqfACvTedDqbO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781176383; c=relaxed/simple;
	bh=zRp5ZVqEieZr8Os8CXHFtrFLZ2CE0g9MkXjJjTEQ85o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8oX3sfhnMXr5pD9Uj9yPVztk4i76J/r9f8gXulUcnJLheWo9WdUTZH5S1KA+8JertQ/FvXxXZ1zlyYGuGY/6M1svA/yi/N7Wq88vDkCIObhvLjvmI5Rg9qBw1xzopEwNyrGP7zBvDw0UrVzNsgyS5gmZ9UTgKZiCmanESHu8LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G7amzcdy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G7amzcdy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194AD1F00893;
	Thu, 11 Jun 2026 11:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781176382;
	bh=GF22alfEsZ7Aj2kyDUA7F/rXbdcAZKycOhAhKwwxKyc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G7amzcdyJY2HL5ZLEeJ/ZKCVWLtQpUV/IbYrOpcu0UJefokAGuRlwuM4XnpqHT+Gw
	 g7XIwBjfjruSSnMqRlEnI1Kqi/yb0A8FgPq4nvc7iSW6ISO50+fFDkn8QegSr93NAQ
	 qDZ/tl8ZJLtmVaryMNuBlK/MuFX56Nr6fyXMUNuCjGGmOFZbgpjkQauq1nCjugFItj
	 VOydb8Z9O9BGW8CL1b8ZKSOLg2kmzwM2EWDlpJuXRJM4UrZ7WQPpHvooJ35qk503SJ
	 nTH5QLnD2/pZHD5EdncnJdaVztVGH7WFoye8BJBTqiPqcVM38DcIRE6t9ALDq7iurs
	 wbi7/8QJQz0cA==
Date: Thu, 11 Jun 2026 12:12:52 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Chris Morgan <macroalpha82@gmail.com>
Cc: linux-iio@vger.kernel.org, andy@kernel.org, nuno.sa@analog.com,
 dlechner@baylibre.com, jean-baptiste.maneyrol@tdk.com,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 heiko@sntech.de, conor+dt@kernel.org, krzk+dt@kernel.org, robh@kernel.org,
 andriy.shevchenko@intel.com, Chris Morgan <macromorgan@hotmail.com>
Subject: Re: [PATCH V11 4/9] iio: imu: inv_icm42607: Add I2C and SPI For
 icm42607
Message-ID: <20260611121252.679bc6ec@jic23-huawei>
In-Reply-To: <20260610175455.19006-5-macroalpha82@gmail.com>
References: <20260610175455.19006-1-macroalpha82@gmail.com>
	<20260610175455.19006-5-macroalpha82@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 12:54:48 -0500
Chris Morgan <macroalpha82@gmail.com> wrote:

> From: Chris Morgan <macromorgan@hotmail.com>
> 
> Add I2C and SPI driver support for InvenSense ICM-42607 devices.
> Add necessary Kconfig and Makefile to allow building of (incomplete)
> driver.
> 
> Signed-off-by: Chris Morgan <macromorgan@hotmail.com>

Some similar missing FIELD_PREP() comments. Not a bug, but
a readability issue that is easy to resolve.

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> index 334264120b42..26dc09bbeaed 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_core.c
>
> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> new file mode 100644
> index 000000000000..2946d5465853
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_i2c.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "inv_icm42607.h"
> +
> +static int inv_icm42607_i2c_bus_setup(struct inv_icm42607_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
> +				INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_DRIVE_CONFIG2_I2C_MASK,
> +			 INV_ICM42607_SLEW_RATE_12_36NS);
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG2,
> +				 INV_ICM42607_DRIVE_CONFIG2_I2C_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_SPI_DIS);
FIELD_PREP() (see below)
> +}

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> new file mode 100644
> index 000000000000..3485777ac5b6
> --- /dev/null
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_spi.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright (C) 2026 InvenSense, Inc.
> + */
> +
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +#include <linux/spi/spi.h>
> +
> +#include "inv_icm42607.h"
> +
> +static int inv_icm42607_spi_bus_setup(struct inv_icm42607_state *st)
> +{
> +	unsigned int val;
> +	int ret;
> +
> +	/* Only support 4-wire mode for now. */
> +	ret = regmap_set_bits(st->map, INV_ICM42607_REG_DEVICE_CONFIG,
> +				      INV_ICM42607_DEVICE_CONFIG_SPI_AP_4WIRE);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_clear_bits(st->map, INV_ICM42607_REG_INTF_CONFIG1,
> +				INV_ICM42607_INTF_CONFIG1_I3C_DDR_EN |
> +				INV_ICM42607_INTF_CONFIG1_I3C_SDR_EN);
> +	if (ret)
> +		return ret;
> +
> +	val = FIELD_PREP(INV_ICM42607_DRIVE_CONFIG3_SPI_MASK,
> +			 INV_ICM42607_SLEW_RATE_2NS);
> +	ret = regmap_update_bits(st->map, INV_ICM42607_REG_DRIVE_CONFIG3,
> +				 INV_ICM42607_DRIVE_CONFIG3_SPI_MASK, val);
> +	if (ret)
> +		return ret;
> +
> +	return regmap_update_bits(st->map, INV_ICM42607_REG_INTF_CONFIG0,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_MASK,
> +				  INV_ICM42607_INTF_CONFIG0_UI_SIFS_CFG_I2C_DIS);
Should be a FIELD_PREP() for readability (so reviewer doesn't need to check
this field includes bit 0)

> +}
>


