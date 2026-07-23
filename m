Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099DD30D419
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:19:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841546; cv=none; b=Mn6tqs10IW3iCOZFXhJi7iqPOmQYRDvHrox/nXTxx2uaMwouwJIneSqmoONZUYLaqxc3t0FEwEjKn8jGGFcbU//QBU/seGxKYjy0RyYGwwLkPkPO4M+hRKfgvsIY5gNwvO7OEU0nbV1bIHDZJOHl9h1lHRnHLyQn20dqDqoaQTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841546; c=relaxed/simple;
	bh=0vsVoelk+/wWdUpGFevd6sjDKbAxqASZjRMARMQi/Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDn30SE46/FEbkeTkH+vpje6lpMN6MbdD/iWqjmG9PzVQdPRfyD3Gowg78Pxbh51wyb0Se6QCi59gZeae/MIqpTY50YZotQt0JUDpaqqccIovpL7XniL/8ay/5aDGfP/A9WS9J4TipvTy9ac8xMJSanlqUE+gJnJKsBOxXZO2XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WIZdkBG/; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WIZdkBG/"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-495590dde14so12668525e9.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784841542; x=1785446342; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=osseF/smU9bE9A/ptH3A6z+xfWhuPXTWzsZ+GLWxQTs=;
        b=WIZdkBG/keTj9UEs6lhI+8O0j9MxMFilRWjgiIFNyia9Ghck/tEv1sjCh3AThMyqk6
         080G/T4Irm+VgImS2vYLgqYVjotVXgdN8Y8e1YXkx3PTDeBUif2sFPk3eCgHLsrZvcbv
         ierT07axHsr/91J2R2GsUE/UOajDJLI6PmzOg6GYNKPS7x9nfrrg6luEUNNdYJY/pbDW
         6al/2l3p+GmpTn+8PQdyWDVXa+wTU/MrAS1YrAKanHXP88jdazkb4ibH4xHLpObf4uuR
         VJC/u0ziz/ZozlFLGwQXb0B5/LZbH/VdRd5EtakJ4Z9EKM7/yuQj9oiEIxANwBgJGF/Z
         sJSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784841542; x=1785446342;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=osseF/smU9bE9A/ptH3A6z+xfWhuPXTWzsZ+GLWxQTs=;
        b=tQOXnwHiBrDxF/ZMXUZf1h2XE4+24jH8NCVvyzbg/PkEhJwnw0xDgzpyHQDfsWb6MM
         8UrQ9kTQMC1MfDtgcfad3NCG35C+uf0UQquDyN8HBaeV32q10vUrww+CyCq/rpF7irqJ
         +orphYt6+xgqF5NYJfDfdZmLzwQDpCxulR9XQ6NFU/1EdyKYG4CTLZuXHGW33SbBzSbB
         +fKQyWLPeulrbBSIasx8rYBYS7IcAUdUBSAbqc+Rio+4/s3Jox/HmHVW6hD3WcS6sn0/
         uHgdxnIR8NfOxeBkvmUNOYyLKrNV5gAV1/ecd6aaPxVxrP35xY5Ad638y6/j1SWBSayr
         zwmg==
X-Forwarded-Encrypted: i=1; AHgh+RpmDpDnLaEikDzXzqH1ljznR8lgRG8dn03qbcXOd9hFma0EHck4KWVIZi8FkkK2pAwb41OzbVZlDlU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwLByXlJBCF7rSmdnoWd8bjW0j9z2KwMLQ419iJcNMt67L9BkJY
	5Joeyf3TrqtXa0cJVN6VaJ/gyCl/Fan6daDR6bU2yZBwWSanuVLQ9ATi
X-Gm-Gg: AR+sD13M0ZRZ6iS+g+PvWVJbncAxE7gVr1Ennh+ljPrYUK91sK9tqy4K5K+GS9QOqvv
	2DYeB6q1Xajt+C4Yslrj0bAFOCzN8JeZRJFGFMx4GJ3x/bbUZtpOHRTFLqGLgL1ToeXqOllPlFk
	1q1GbQUeno1hBYem95i9/LU8w04groEKRBj18lHwFfEZiW6N9E3+LLRRb54S6l82gnOArOHtRBt
	ZfBw1N/FucPasgAqOlkNASIMByH414cuTHtor1Zq8npjH6aVZObXblAW0/iovQ59ljCBrZunQhr
	1KwM5ZA/nq6DrVq4t6I/tLsOeACCdFOb5yQdvwab0or7lAmBTOiaMIXEMczizEkD85cAkmhwlQA
	dzJGTGy3JPldGWemIuFfASMk3yWB6ci+qUkTGEBU+nlM5HjsBXdbXgYw+Ckhc29dz+MVEk1wxPR
	kg4HqD95NEW1mNtuUly+xa2+jtb5qKhg1CQhVo79iNJYxmu+JL5jbJR4LT6hfprSuras3OhYIeI
	TyCPK8PiGeUrTC6gG/0KUFriAN90HbSvoKt7uIpb8ZAbRh3Z2oacacOKODnkYYSk5DReU3oVK2M
	GMaqQ0W88ByBuxC0eSfAUJxv8i+T0EmIFP6EI60vyadjQAde/vx9BgTLEwB8/N8XBwz2xXlH8vi
	mPcughh3LPds=
X-Received: by 2002:a05:600c:1914:b0:495:5e86:4e59 with SMTP id 5b1f17b1804b1-49573cf6226mr55191805e9.22.1784841542022;
        Thu, 23 Jul 2026 14:19:02 -0700 (PDT)
Received: from systembl0wer (ip-86-49-244-181.bb.vodafone.cz. [86.49.244.181])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4957bfb20ddsm6120095e9.3.2026.07.23.14.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 14:19:01 -0700 (PDT)
Date: Thu, 23 Jul 2026 23:18:59 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>, Rob Herring <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH 1/3] iio: dac: mcp47feb02: refactor MCP47FEB02 I2C
 driver into two modules
Message-ID: <20260723231859.03f92ce6@systembl0wer>
In-Reply-To: <20260723-mcp47feb02_refactor-v1-1-ee59e63672bc@microchip.com>
References: <20260723-mcp47feb02_refactor-v1-0-ee59e63672bc@microchip.com>
	<20260723-mcp47feb02_refactor-v1-1-ee59e63672bc@microchip.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 23 Jul 2026 16:43:10 +0300
Ariana Lazar <ariana.lazar@microchip.com> wrote:

> diff --git a/drivers/iio/dac/mcp47feb02-i2c.c b/drivers/iio/dac/mcp47feb02-i2c.c
> new file mode 100644
> index 0000000000000000000000000000000000000000..808c51d0afdf564321abcd46a5a7d9595c5472da
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02-i2c.c
> @@ -0,0 +1,145 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * IIO driver for MCP47FEB02 Multi-Channel DAC with I2C interface
> + *
> + * Copyright (C) 2026 Microchip Technology Inc. and its subsidiaries
> + *
> + * Author: Ariana Lazar <ariana.lazar@microchip.com>
> + *
> + * Datasheet links for devices with I2C interface:
> + * [MCP47FEBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005375A.pdf
> + * [MCP47FVBxx] https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/20005405A.pdf
> + * [MCP47FxBx4/8] https://ww1.microchip.com/downloads/aemDocuments/documents/MSLD/ProductDocuments/DataSheets/MCP47FXBX48-Data-Sheet-DS200006368A.pdf
> + */
> +#include <linux/device.h>

struct device *dev is an opaque pointer, no need to include device.h

On the other hand, please include dev_printk.h for dev_err_probe().
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>

Remove mod_devicetable.h, no need to include it as it's in spi.h
> +#include <linux/pm.h>
> +#include <linux/regmap.h>
> +
> +#include "mcp47feb02.h"
> +
> +/* Parts with EEPROM memory */
> +MCP47FEB02_CHIP_INFO(mcp47feb01, 1, 8,  false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb02, 2, 8,  false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb04, 4, 8,  true,  true);
> +MCP47FEB02_CHIP_INFO(mcp47feb08, 8, 8,  true,  true);
> +MCP47FEB02_CHIP_INFO(mcp47feb11, 1, 10, false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb12, 2, 10, false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb14, 4, 10, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp47feb18, 8, 10, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp47feb21, 1, 12, false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb22, 2, 12, false, true);
> +MCP47FEB02_CHIP_INFO(mcp47feb24, 4, 12, true,  true);
> +MCP47FEB02_CHIP_INFO(mcp47feb28, 8, 12, true,  true);
> +
> +/* Parts without EEPROM memory */
> +MCP47FEB02_CHIP_INFO(mcp47fvb01, 1, 8,  false, false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb02, 2, 8,  false, false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb04, 4, 8,  true,  false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb08, 8, 8,  true,  false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb11, 1, 10, false, false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb12, 2, 10, false, false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb14, 4, 10, true,  false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb18, 8, 10, true,  false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb21, 1, 12, false, false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb22, 2, 12, false, false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb24, 4, 12, true,  false);
> +MCP47FEB02_CHIP_INFO(mcp47fvb28, 8, 12, true,  false);
> +
> +static int mcp47feb02_i2c_probe(struct i2c_client *client)
> +{
> +	const struct mcp47feb02_features *chip_features;
> +	struct device *dev = &client->dev;
> +	struct regmap *regmap;
> +
> +	chip_features = i2c_get_match_data(client);
> +	if (!chip_features)
> +		return -EINVAL;

return dev_err_probe + -ENODEV.
> +
> +	if (chip_features->have_eeprom)
> +		regmap = devm_regmap_init_i2c(client, &mcp47feb02_regmap_config);
> +	else
> +		regmap = devm_regmap_init_i2c(client, &mcp47fvb02_regmap_config);
> +
> +	if (IS_ERR(regmap))
> +		return dev_err_probe(dev, PTR_ERR(regmap), "Error initializing I2C regmap\n");
> +
> +	return mcp47feb02_common_probe(chip_features, regmap);
> +}
> +
> +static const struct i2c_device_id mcp47feb02_i2c_id[] = {
> +	{ "mcp47feb01", (kernel_ulong_t)&mcp47feb01_chip_features },

Forgot to mention this in patch 3, but please use named initializers.

> +	{ "mcp47feb02", (kernel_ulong_t)&mcp47feb02_chip_features },
> +	{ "mcp47feb04", (kernel_ulong_t)&mcp47feb04_chip_features },
> +	{ "mcp47feb08", (kernel_ulong_t)&mcp47feb08_chip_features },
> +	{ "mcp47feb11", (kernel_ulong_t)&mcp47feb11_chip_features },
> +	{ "mcp47feb12", (kernel_ulong_t)&mcp47feb12_chip_features },
> +	{ "mcp47feb14", (kernel_ulong_t)&mcp47feb14_chip_features },

...

> diff --git a/drivers/iio/dac/mcp47feb02.h b/drivers/iio/dac/mcp47feb02.h
> new file mode 100644
> index 0000000000000000000000000000000000000000..7dbf157d7d6dcfeda7e47141ad447dfa0a79fd51
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47feb02.h
> @@ -0,0 +1,153 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +#ifndef __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +#define __DRIVERS_IIO_DAC_MCP47FEB02_H__
> +
> +#include <linux/bitops.h>

bits.h should suffice.

> +#include <linux/device.h>

No need for device.h
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>

You're missing mutex.h, types.h.

> +
> +#include <linux/iio/iio.h>

If we're going by IWYU, you also don't need this header.
> +
> +/* Register addresses must be left shifted with 3 positions in order to append command mask */
> +#define MCP47FEB02_DAC0_REG_ADDR			0x00
> +#define MCP47FEB02_VREF_REG_ADDR			0x40
> +#define MCP47FEB02_POWER_DOWN_REG_ADDR			0x48
> +#define MCP47FEB02_DAC_CTRL_MASK			GENMASK(1, 0)
> +
> +#define MCP47FEB02_GAIN_CTRL_STATUS_REG_ADDR		0x50
> +#define MCP47FEB02_GAIN_BIT_MASK			BIT(0)
> +#define MCP47FEB02_GAIN_BIT_STATUS_EEWA_MASK		BIT(6)
> +#define MCP47FEB02_GAIN_BITS_MASK			GENMASK(15, 8)
> +
> +#define MCP47FEB02_WIPERLOCK_STATUS_REG_ADDR		0x58
> +
> +#define MCP47FEB02_NV_DAC0_REG_ADDR			0x80
> +#define MCP47FEB02_NV_VREF_REG_ADDR			0xC0
> +#define MCP47FEB02_NV_POWER_DOWN_REG_ADDR		0xC8
> +#define MCP47FEB02_NV_GAIN_CTRL_I2C_SLAVE_REG_ADDR	0xD0
> +#define MCP47FEB02_NV_I2C_SLAVE_ADDR_MASK		GENMASK(7, 0)
> +
> +/* Voltage reference, Power-Down control register and DAC Wiperlock status register fields */
> +#define DAC_CTRL_MASK(ch)				(GENMASK(1, 0) << (2 * (ch)))
> +#define DAC_CTRL_VAL(ch, val)				((val) << (2 * (ch)))
> +
> +/* Gain Control and I2C Slave Address Reguster fields */

You probably meant Register?

> +#define DAC_GAIN_MASK(ch)				(BIT(0) << (8 + (ch)))
> +#define DAC_GAIN_VAL(ch, val)				((val) << (8 + (ch)))
> +
> +#define REG_ADDR(reg)					((reg) << 3)
> +#define NV_REG_ADDR(reg)				((NV_DAC_ADDR_OFFSET + (reg)) << 3)
> +#define READFLAG_MASK					GENMASK(2, 1)
> +
> +#define MCP47FEB02_MAX_CH				8
> +#define MCP47FEB02_MAX_SCALES_CH			3
> +#define MCP47FEB02_DAC_WIPER_UNLOCKED			0
> +#define MCP47FEB02_NORMAL_OPERATION			0
> +#define MCP47FEB02_INTERNAL_BAND_GAP_uV			2440000
> +#define NV_DAC_ADDR_OFFSET				0x10
> +


-- 
Kind regards,
Joshua Crofts
