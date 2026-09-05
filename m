Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41D971DA60D
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 06:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788590586; cv=none; b=NbulZmFunmbnh+JdXynIndwRBtnPhqA1Uw8NIfdVmeYKLyTvXjJM+WEXoZkREPjkUdVuqjhfopdsVGRWx6dq8N+EC+Lur/WCV1tbF/II8g3L9trWbXL/QEZvgq+ldcsI7cKyeN3q9bc/bf+r9q3jqBrIcI2FchsSEKHwjpLsEcM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788590586; c=relaxed/simple;
	bh=9e1CDBZ5qXyPweEnk5YwGajjCLZUFMAY+tL3lOR/dnw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SrTNcfMCr6Ay6d4DJldbVkKwHRxg+qjMbIN1E0kvrHKlEruTyGO3EfEbeJBb3L0ySVCNMw69VdZwKDYsuvSVl8D+gDq65l1gsyQ6CqDcmCApY9mkykPuO0JqI3W/PrcqEFeXXu7W+w/rbijBTNXYKLSGGLVKmQbT21nLLZgk5mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PqJGgh3+; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PqJGgh3+"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-49557167508so21333885e9.1
        for <linux-iio@vger.kernel.org>; Fri, 04 Sep 2026 23:43:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788590582; x=1789195382; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=tjkyY2xqPL7I9woz0da0q5nTHjDAuM+FGeb1WmGHRXM=;
        b=PqJGgh3+WVMUiFuBZrE2HYpS4VJDsOB3F6aGjpK0rjhulYBfU5ZbPiBphXDY4DOUzR
         hQ2i1TVO3mIMioXs7wdXqFrkKmO1GrG9O3F7mWeLK7w1iy5iKacBonnpRxwwTRKVhMTd
         Gah6pX93SzDClzCiTKwgK+sacvVUhaVUd44b68ioFBH1klRVEvTRw6kBx0uK3vlN+n/5
         rkiVeOAA3m193yRkYizFmODtr9RUtTQHBybRZubFqcgFbkIL3LQPD91CYXV+yWAXqnes
         MHNXAiVDlys4ECMonOrpOeA7ANRnV/j0Yn2npgZfVGPyBinQG5NNmCPfV93RWYSSN160
         Iyrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788590582; x=1789195382;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=tjkyY2xqPL7I9woz0da0q5nTHjDAuM+FGeb1WmGHRXM=;
        b=R061E65oL0iY8yoTk+NpyfPoexy6CBuTK1bKKu9nk6jY03wTJmcqqplDJdQ+B+gkoj
         Ko1UqOw8AkS8jQzZALMjptM5Dh2WtJz3ntG9b4MPq/gtV5AVNCSGYY1Qsw/pTLejiUCf
         jDb7B/s8ssoKdVqadeREDtovHZpuOBfsSRzQ7S8S/pmXWSHn1hugxmHII3gSpn8dY0px
         w1WhH4eBPBGCTJfArKka/T+7m7OjLsbA3synuT9KxAFmr4z6VuFy/q8UULJLJ0qU2FJz
         yQ9pzFW2wkOUIMZWoYmMk+Wocn3GVnICrxeMv3AbmCs9bCHwYNjX+v4vIDHJ6veIm7es
         SzmQ==
X-Forwarded-Encrypted: i=1; AKwUvBwe+9+i0s3mp8SKt/vqdl7Dt/A7bZxmvsBHDMG+LcaRL1tkfcJf+VVeDQ9+X3x+Gp8DuhAFMWlxUEE=@vger.kernel.org
X-Gm-Message-State: AFuF++mNDHofFporLI8zDP5XvsBoDVOEFBpNJWAogM8GWnR2znzphq/m
	eKiT0VQl94+/nhBuUgeZ5AVZAhO+/5OlR0BJskqqwgHBhkQrQBEqZ8+y
X-Gm-Gg: AYBFou22FUNdpayqsIrY7N5EoLaAHZ8doNL7hu234/Ka0u4c6QAxrOrTGaUMY0bTMNd
	ZvsMDKiX7nr1XwMjg/G98h2ymEzzrfUjPYELnDgDQbcnQ6/habrHCXvkdYRp4KjF2bFtrcEUQDn
	EY15oGr3IacnK5I/LZSRe3R0/0HinMDJAQf36BYWcLQMfOkjilJV6WUjRgs85CENyNmBY14tKi/
	PfMu1JIG1lpqq2l9jj2HTSkSJ3mwhI6GIkbtPLjROpTxC0WMPfQbj62XzI6Hpj2WmH3jtZg5OXh
	Hf/2zSWP44b9vkxO6XyBcLHTYS/LOf03mrfqnLtjt7qMtnGJXYtHSaCba8EZJrdNpmYpU46h7fc
	ah+XeJY3QjUpxJY3bzGAzGGlymo4a/T5YfY9VKwEXsu81S05CAPh5vUCXiKDpfAtDGm4LvTNypZ
	nTepI7+E60DU7k63PZbP7SwXMoeLBVE6BCmf0npe8WkFXnXckiZ6DkEnKdjlgeVp7lAXF3TOn7R
	bdgClkgaOeqnvhb2Z25uW2tJRcoKrS48mZUWG2/JXT33vWBsg/waS3psNgiduRhc+3DD/SXI7KZ
	w5zah+9OcAKeOFTOCr1BAp7IrQPtI0ud/3fVG2uTDZexnZwo8zfbmaI7BUM7v3WwVblZR4+pErZ
	gtBu6d6GATpeApvaun1TiANYsFQHTwkFGnRsMUQ==
X-Received: by 2002:a05:600d:8490:20b0:49c:f89b:f82 with SMTP id 5b1f17b1804b1-49cf89b1bc2mr154079265e9.12.1788590582198;
        Fri, 04 Sep 2026 23:43:02 -0700 (PDT)
Received: from systembl0wer ([212.89.239.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cfbdacc45sm97802275e9.11.2026.09.04.23.43.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 23:43:02 -0700 (PDT)
Date: Sat, 5 Sep 2026 08:42:58 +0200
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: Chang Yu <marcus.yu.56@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: light: add AS7343 multi-spectral sensor driver
Message-ID: <20260905084258.350fdccb@systembl0wer>
In-Reply-To: <521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
References: <cover.1788586814.git.marcus.yu.56@gmail.com>
	<521c26094635bae6376d92f3cecf84c911d5a740.1788586814.git.marcus.yu.56@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Chang,

Comments inline.

Josh

On Fri,  4 Sep 2026 22:53:26 -0700
Chang Yu <marcus.yu.56@gmail.com> wrote:

> This patch adds a driver for the AMS AS7343 14-channel multi-spectral
> sensor with I2C interface.
> 
> The driver exposes 12 spectral channels (11 visible + 1 near-infrared)
> via the IIO sysfs interface. Each channel's raw data is provided as a
> 16-bit little-endian unsigned integer.
> 
> Basic power management (suspend/resume) is supported. More complex
> features such as interrupt support and configurable gain/integration
> time will be added in future patches.
> 
> Signed-off-by: Chang Yu <marcus.yu.56@gmail.com>
> ---
>  MAINTAINERS                |   7 +
>  drivers/iio/light/Kconfig  |  11 ++
>  drivers/iio/light/Makefile |   1 +
>  drivers/iio/light/as7343.c | 309 +++++++++++++++++++++++++++++++++++++
>  4 files changed, 328 insertions(+)
>  create mode 100644 drivers/iio/light/as7343.c
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 04fa5322d9f7..236102b3c28e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1430,6 +1430,13 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
>  F:	drivers/iio/light/as73211.c
>  
> +AMS AS7343 DRIVER
> +M:	Chang Yu <marcus.yu.56@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/ams,as7343.yaml

This goes into the first patch in your series, i.e. the dt-binding
patch.

> +F:	drivers/iio/light/as7343.c

This line should be then added in this patch.

> +
>  AMT (Automatic Multicast Tunneling)
>  M:	Taehee Yoo <ap420073@gmail.com>
>  L:	netdev@vger.kernel.org
> diff --git a/drivers/iio/light/Kconfig b/drivers/iio/light/Kconfig
> index ef36824f312f..edbeeba9d873 100644
> --- a/drivers/iio/light/Kconfig
> +++ b/drivers/iio/light/Kconfig
> @@ -149,6 +149,17 @@ config AS73211
>  	 This driver can also be built as a module.  If so, the module
>  	 will be called as73211.
>  
> +config AS7343
> +	tristate "AMS AS7343 14-Channel Multi-Spectral Sensor"
> +	depends on I2C
> +	select REGMAP_I2C
> +	help
> +	 Say Y here to build support for the AMS AS7343 14-channel
> +	 multi-spectral sensor.
> +
> +	 To compile this driver as a module, choose M here: the module will
> +	 be called as7343.
> +
>  config BH1745
>  	tristate "ROHM BH1745 colour sensor"
>  	depends on I2C
> diff --git a/drivers/iio/light/Makefile b/drivers/iio/light/Makefile
> index 64e354c49ed8..5d0d33802519 100644
> --- a/drivers/iio/light/Makefile
> +++ b/drivers/iio/light/Makefile
> @@ -16,6 +16,7 @@ obj-$(CONFIG_APDS9306)		+= apds9306.o
>  obj-$(CONFIG_APDS9960)		+= apds9960.o
>  obj-$(CONFIG_APDS9999)		+= apds9999.o
>  obj-$(CONFIG_AS73211)		+= as73211.o
> +obj-$(CONFIG_AS7343)		+= as7343.o
>  obj-$(CONFIG_BH1745)		+= bh1745.o
>  obj-$(CONFIG_BH1750)		+= bh1750.o
>  obj-$(CONFIG_BH1780)		+= bh1780.o
> diff --git a/drivers/iio/light/as7343.c b/drivers/iio/light/as7343.c
> new file mode 100644
> index 000000000000..b620dd308380
> --- /dev/null
> +++ b/drivers/iio/light/as7343.c
> @@ -0,0 +1,309 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Support for AMS AS7343 14-channel multi-spectral sensor.
> + * (7-bit I2C slave address 0x39)
> + *
> + * Based on the work of:
> + *   Christian Eggers <ceggers@arri.de> (AS73211 driver)
> + *
> + * Copyright (c) 2026 Chang Yu <marcus.yu.56@gmail.com>
> + *
> + * Datasheets:
> + *   https://look.ams-osram.com/m/5f2d27fff9a874d2/original/AS7343-14-Channel-Multi-Spectral-Sensor.pdf
> + *
> + * TODO:
> + *   - Support for configurable gain and integration time
> + *   - Interrupt support
> + *   - Add support for reading the VIS channel
> + *   - Flicker detection
> + */
> +
> +#include "linux/array_size.h"
> +#include "linux/regmap.h"

Why did you use quotation marks here? <linux/array_size.h>
and <linux/regmap.h> are valid.

> +#include <linux/bitfield.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>

It's common to have the IIO headers separately below the
generic <linux/*> headers.

> +#include <linux/module.h>
> +#include <linux/pm.h>
> +#include <linux/stringify.h>

You're missing err.h, regulator/consumer.h,
> +
> +#define AS7343_DRV_NAME "as7343"
> +#define AS7343_DEVICE_ID 0x81
> +
> +/* AS7343 registers */
> +#define AS7343_REG_ID 0x5a
> +#define AS7343_REG_ENABLE 0x80
> +#define AS7343_REG_ATIME 0x81
> +#define AS7343_REG_CFG0 0xbf
> +#define AS7343_REG_CFG1 0xc6
> +#define AS7343_REG_CFG20 0xd6
> +#define AS7343_REG_CONTROL 0xfa
> +#define AS7343_REG_ASTATUS 0x94

Blank line here.

> +/* AS7343 data registers */
> +#define AS7343_REG_DATA_FZ 0x95
> +#define AS7343_REG_DATA_FY 0x97
> +#define AS7343_REG_DATA_FXL 0x99
> +#define AS7343_REG_DATA_NIR 0x9b
> +#define AS7343_REG_DATA_F2 0xa1
> +#define AS7343_REG_DATA_F3 0xa3
> +#define AS7343_REG_DATA_F4 0xa5
> +#define AS7343_REG_DATA_F6 0xa7
> +#define AS7343_REG_DATA_F1 0xad
> +#define AS7343_REG_DATA_F7 0xaf
> +#define AS7343_REG_DATA_F8 0xb1
> +#define AS7343_REG_DATA_F5 0xb3
> +#define AS7343_REG_MAX 0xff
> +
> +/* AS7343 register bit masks */
> +#define AS7343_ENABLE_PON BIT(0)
> +#define AS7343_ENABLE_SP_EN BIT(1)
> +#define AS7343_CFG0_REG_BANK BIT(4)
> +#define AS7343_CFG20_AUTO_SMUX GENMASK(6, 5)
> +#define AS7343_CONTROL_SW_RESET BIT(3)
> +#define AS7343_CFG1_AGAIN GENMASK(4, 0)
> +
> +/* AS7343 settings */
> +#define AS7343_INT_TIME 29 /* (29 + 1) * 2.87ms = 83.4ms */
> +#define AS7343_GAIN 7 /* 64x gain */
> +#define AS7343_AUTO_CHANNEL_READOUT 3 /* Automatic all-channel readout */
> +
> +/* AS7343 scan indices */
> +#define AS7343_SCAN_INDEX_F1 0
> +#define AS7343_SCAN_INDEX_F2 1
> +#define AS7343_SCAN_INDEX_FZ 2
> +#define AS7343_SCAN_INDEX_F3 3
> +#define AS7343_SCAN_INDEX_F4 4
> +#define AS7343_SCAN_INDEX_FY 5
> +#define AS7343_SCAN_INDEX_F5 6
> +#define AS7343_SCAN_INDEX_FXL 7
> +#define AS7343_SCAN_INDEX_F6 8
> +#define AS7343_SCAN_INDEX_F7 9
> +#define AS7343_SCAN_INDEX_F8 10
> +#define AS7343_SCAN_INDEX_NIR 11
> +#define AS7343_SCAN_INDEX_TS 12
> +
> +#define AS7343_SCAN_MASK_ALL                                      \
> +	(BIT(AS7343_SCAN_INDEX_F1) | BIT(AS7343_SCAN_INDEX_F2) |  \
> +	 BIT(AS7343_SCAN_INDEX_FZ) | BIT(AS7343_SCAN_INDEX_F3) |  \
> +	 BIT(AS7343_SCAN_INDEX_F4) | BIT(AS7343_SCAN_INDEX_FY) |  \
> +	 BIT(AS7343_SCAN_INDEX_F5) | BIT(AS7343_SCAN_INDEX_FXL) | \
> +	 BIT(AS7343_SCAN_INDEX_F6) | BIT(AS7343_SCAN_INDEX_F7) |  \
> +	 BIT(AS7343_SCAN_INDEX_F8) | BIT(AS7343_SCAN_INDEX_NIR))
> +
> +static const unsigned long as7343_scan_masks[] = { AS7343_SCAN_MASK_ALL, 0 };
> +
> +#define AS7343_CHAN(_chan) \
> +	{ \
> +	.type = IIO_INTENSITY, \
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW), \
> +	.address = AS7343_REG_DATA_##_chan, \
> +	.extend_name = __stringify(_chan), \
> +	.scan_index = AS7343_SCAN_INDEX_##_chan, \
> +	.scan_type = { \
> +		.sign = 'u', \
> +		.realbits = 16, \
> +		.storagebits = 16, \
> +		.endianness = IIO_LE, \
> +	}, \
> +}
> +
> +static const struct iio_chan_spec as7343_channels[] = {
> +	AS7343_CHAN(F1),
> +	AS7343_CHAN(F2),
> +	AS7343_CHAN(FZ),
> +	AS7343_CHAN(F3),
> +	AS7343_CHAN(F4),
> +	AS7343_CHAN(FY),
> +	AS7343_CHAN(F5),
> +	AS7343_CHAN(FXL),
> +	AS7343_CHAN(F6),
> +	AS7343_CHAN(F7),
> +	AS7343_CHAN(F8),
> +	AS7343_CHAN(NIR),

Don't forget to update any mentions of only 12 channels being
implemented once you add support for the Flicker and VIS channel.

> +	IIO_CHAN_SOFT_TIMESTAMP(AS7343_SCAN_INDEX_TS),
> +};
> +
> +/**
> + * struct as7343_data - Instance data for one AS7343
> + * @client: I2C client.
> + * @regmap: Register map.
> + */

Eh, I'd remove the comment for now as the contents of the struct
are pretty self explanatory.

> +struct as7343_data {
> +	struct i2c_client *client;
> +	struct regmap *regmap;
> +};
> +
> +static int as7343_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long mask)
> +{
> +	struct as7343_data *data = iio_priv(indio_dev);
> +	unsigned int low, high;
> +	unsigned int unused;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW: {
> +		/* Reading ASTATUS latches all data registers to this read.
> +		 * We don't care about the returned saturation/gain status for
> +		 * now.
> +		 */
> +		ret = regmap_read(data->regmap, AS7343_REG_ASTATUS, &unused);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret = regmap_read(data->regmap, chan->address, &low);
> +		if (ret < 0)
> +			return ret;

Blank line here.

> +		ret = regmap_read(data->regmap, chan->address + 1, &high);
> +		if (ret < 0)
> +			return ret;
> +		*val = (high << 8) | low;
> +		return IIO_VAL_INT;
> +	}
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +

...

> +	/* Need to set REG_BANK to 1 before we can access ID */
> +	ret = regmap_set_bits(data->regmap, AS7343_REG_CFG0,
> +			      AS7343_CFG0_REG_BANK);
> +	if (ret < 0)
> +		return ret;
> +	/* Check device ID */

Unnecessary comment, add a blank line instead.

> +	ret = regmap_read(data->regmap, AS7343_REG_ID, &val);
> +	if (val != AS7343_DEVICE_ID)
> +		return -ENODEV;

It's better to just do a dev_warn() in case of any fallback
devices instead of a hard return.

> +	/* Unset REG_BANK */

Unnecessary comment.

> +	ret = regmap_clear_bits(data->regmap, AS7343_REG_CFG0,
> +				AS7343_CFG0_REG_BANK);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Configure the SMUX to readout all channels */
> +	ret = regmap_update_bits(data->regmap, AS7343_REG_CFG20,
> +				 AS7343_CFG20_AUTO_SMUX,
> +				 FIELD_PREP(AS7343_CFG20_AUTO_SMUX,
> +					    AS7343_AUTO_CHANNEL_READOUT));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Set 83.4ms integration time and x64 gain for now */

Good for an initial draft, however you'll definitely have to
implement the write function for this to get merged into mainline.
Skimming the datasheet shows that there are more integration times
possible, not to mention that you can also set the gain etc.

> +	ret = regmap_write(data->regmap, AS7343_REG_ATIME, AS7343_INT_TIME);
> +	if (ret < 0)
> +		return ret;

Blank line.

> +	ret = regmap_update_bits(data->regmap, AS7343_REG_CFG1,
> +				 AS7343_CFG1_AGAIN,
> +				 FIELD_PREP(AS7343_CFG1_AGAIN, AS7343_GAIN));
> +	if (ret < 0)
> +		return ret;
> +
> +	/* Start measurements */
> +	ret = regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
> +			      AS7343_ENABLE_SP_EN);
> +	if (ret < 0)
> +		return ret;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static int as7343_suspend(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct as7343_data *data = iio_priv(indio_dev);
> +
> +	return regmap_clear_bits(data->regmap, AS7343_REG_ENABLE,
> +				 AS7343_ENABLE_SP_EN);
> +}
> +
> +static int as7343_resume(struct device *dev)
> +{
> +	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +	struct as7343_data *data = iio_priv(indio_dev);
> +
> +	return regmap_set_bits(data->regmap, AS7343_REG_ENABLE,
> +			       AS7343_ENABLE_SP_EN);
> +}
> +

You have suspend/resume functions, yet you're missing a
devm_pm_runtime_enable() in probe. Additionally, you could enable
the autosuspend function as well (note, you'll have to wake the
device before reading, there are macros that simplify this though,
see PM_RUNTIME_ACQUIRE_AUTOSUSPEND)

Also, there isn't any devm_add_action_or_reset() function that
guarantees powering the device off on teardown (you can reuse your
suspend function as the callback).

> +static DEFINE_SIMPLE_DEV_PM_OPS(as7343_pm_ops, as7343_suspend, as7343_resume);
> +
> +static const struct of_device_id as7343_of_match[] = {
> +	{ .compatible = "ams,as7343" },
> +	{},

Remove the comma + add a space in between the {}

Same goes for the struct i2c_device_id definition.

-- 
Kind regards,
Joshua Crofts
