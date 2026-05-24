Received: from mail-pg1-f178.google.com (mail-pg1-f178.google.com [209.85.215.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627AA324B2C
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 21:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779658859; cv=none; b=QFnipdqA7aNZisukUq0+ZKDfneu/p93vKKIu1etd7KyshfN/r+Fh4RR5s6ecKIua0zdlT0oHpNb8c56kM24qAVjuakfXiSLsyJXWhsTSGzg+4Lrdmg72lsXpXCWaCgqhj7taNhX/13lIGWUS7+bGLm24g771UyK4TQUTDA7ZlxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779658859; c=relaxed/simple;
	bh=oYFSrE+O4tOl5y5rSxJ3HNDmQyHcuh38rMWnm2gCobQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JP6Z+3VeJ+yT6bqDmLfazXZyJYKJfy2ZZ02aPsx1kaXLoaVHl3CEJjO/PBdGpyA7qyIZCzX0tzTL0OMWVaqil68l7xuTfWizmTOcwzoClvkTgddAWImeJ/lJE3wZMGaW2HglJQlTaf3Ydfzlcz+/4qvjlUCLXCIk2Di9OKKXSFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5P27TCY; arc=none smtp.client-ip=209.85.215.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5P27TCY"
Received: by mail-pg1-f178.google.com with SMTP id 41be03b00d2f7-c82a6278a4cso6884408a12.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 14:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779658854; x=1780263654; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=u/ZWDHqrANNr1pYzyRa4L7E5OX6ipaK/zFeIm8rbr4Q=;
        b=p5P27TCYeP0N9On+1FKx1bizAqNInrOpC4Adou9m85WIqupvQKPSk5ooqNgzQNY1KG
         TCzXA8OVeFd+tNajAMEjRrFYThxloupje2ckzHx9txiWSrOndMyUp/i+une0xXuTg9EI
         Ms3vEEKv8TCe6TgwQsIHZysTByZGIbC3DmwAscq3lMzx+laHrPGEYplYYRXxWG06KqWZ
         7AOQuedSqlwc7np73SnkW7bz9ENIB056AVdLeWzREEbOs7ADhT+UV5FB53dmOfrqcqgz
         FkYK8kJl707eL28JSbRN7u9Q5tBhnqrtXgxJy4SLYFaBQvZj2EOpsEy5onRwWz/lhmzi
         T2lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779658854; x=1780263654;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:sender:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=u/ZWDHqrANNr1pYzyRa4L7E5OX6ipaK/zFeIm8rbr4Q=;
        b=qbd5LD1gUNh/zYdgwWyPcqllnUB3dSsTekt3JNcYV9HrD2G44fSOOlWerpxitoxsRM
         QJ+s89nokf0o6obbAZMeWCW79gDyTq6pcfV6f4uY3dsds4Kcz5sV6lX65saXNb+T+8gT
         waTvdLpE52jlEt9sJnG7lCmcTdv8EQpAn7TihYH3zaR7Bk4rNirQK0dbq+vBbxNviQzQ
         E6B95tsjdwoKDn3r9dyeoGnydoMvYUQSuU6lxc1LuFnFVzfFProH5eUUAlng8C/wnfHG
         Rdc2Zf65uq1OAKLUMG5EVdp4mSt4Y1rK0vLMxOLQKGqhula0aUUqGlwxPCLJeviOGGfw
         jAPA==
X-Forwarded-Encrypted: i=1; AFNElJ/Ksef4pc3NzsNgBaMJBasb02VxYNz8PE2i6kLeIjIMVdjC2Cfgxrt5nuksAwSwe/j+45qeIudaooE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9cR4jXOj4Vl+v9BA7S1xW3IWjywI/CFqgGEjdoAnilYW3XmBp
	SRC3wFBWft1AbPv/eyDJ303SoZTbHjYyHcDRq8BEZX1JL/u1jiRoqfRQ
X-Gm-Gg: Acq92OEKaiq+NxKTQlz5qnalJFTkfBb2sFo+3EztfgCeB/JdDBfz5cpGE/xfOByXdn8
	eEP2qx0tl9ZvU3e09NYwNcPt2xaiT9TqxmGbRGjvSf8HZJFImhJvtiKaLBMcGq0O28NRAxyaEMs
	AWYAv9kh/pv/rC5JnpDhnunx3dPUPq3jc9pxOUT2ko9IdcS7/pwHYoUGVgAii0x1ZP9k6lttexS
	aTSN4ZK+qCgcqabz9S8dP0I/C4Ut66/g/5H5k0HYninQRmEKn9Fr768fhE69z1i1EDViQ8DmTeS
	dqcbecSmH/M8uw04MNfbLS9t69+4aBykqHM23H47bkKKxpiY2dI1JZLOz7PLOOGfUUKDbp9aO0t
	uFyiIGJJRzmuqHvMzFJ2GveRSrIeT2PtHDvTwmVuBWOc/BeypUS5KmT30YpBg3icouSanKJWMyP
	7LkCaXSer5Ms9hpTQMH9CuCNAb6e4BUITMBgHB/48VnZNSqiF+Q7F4FvAfczDlEcPwHuffEgVY
X-Received: by 2002:a05:6a20:a109:b0:39c:a78e:dba9 with SMTP id adf61e73a8af0-3b328ec0744mr12254393637.40.1779658853908;
        Sun, 24 May 2026 14:40:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:da43:aeff:fecc:bfd5? ([2600:1700:e321:62f0:da43:aeff:fecc:bfd5])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c852054d788sm6026079a12.21.2026.05.24.14.40.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2026 14:40:53 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <4349f634-dd7b-468a-912c-5ceb8a283954@roeck-us.net>
Date: Sun, 24 May 2026 14:40:51 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v1 3/4] iio: flow: add Sensirion SLF3x liquid flow
 sensor driver
To: Wadim Mueller <wafgo01@gmail.com>, jic23@kernel.org
Cc: lars@metafoo.de, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 jdelvare@suse.com, ak@it-klinger.de, linux-iio@vger.kernel.org,
 linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260524205112.26638-1-wafgo01@gmail.com>
 <20260524205112.26638-4-wafgo01@gmail.com>
Content-Language: en-US
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 np3900V20aS7eD9K8GTU0TGC1pyz6IVJwIE=
In-Reply-To: <20260524205112.26638-4-wafgo01@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 5/24/26 13:49, Wadim Mueller wrote:
> From: Wadim Mueller <wadim.mueller@cmblu.de>
> 
> Add an IIO driver for the Sensirion SLF3S family of digital
> liquid-flow sensors.  The supported sub-types (SLF3S-0600F,
> SLF3S-4000B) share the same register map and command set and are
> distinguished only by the flow scale; the variant is detected at
> probe time from the product-information register.
> 
Sice you are at it, it might make sense to also support SLF3S-1300F.


> The driver exposes two IIO channels:
>    - in_volumeflow_raw / in_volumeflow_scale (litres per second)
>    - in_temp_raw       / in_temp_scale       (milli-degC)
> 
> Continuous measurement mode is started in probe and stopped via
> devm-action; read_raw() fetches the most recent sample on demand.
> 
> Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
> ---
>   drivers/iio/Kconfig       |   1 +
>   drivers/iio/Makefile      |   1 +
>   drivers/iio/flow/Kconfig  |  22 ++++
>   drivers/iio/flow/Makefile |   7 +
>   drivers/iio/flow/slf3x.c  | 264 ++++++++++++++++++++++++++++++++++++++

What does the "X" refer to ? Why not "S" ?

>   5 files changed, 295 insertions(+)
>   create mode 100644 drivers/iio/flow/Kconfig
>   create mode 100644 drivers/iio/flow/Makefile
>   create mode 100644 drivers/iio/flow/slf3x.c
> 
> diff --git a/drivers/iio/Kconfig b/drivers/iio/Kconfig
> index 661127aed..652557a5b 100644
> --- a/drivers/iio/Kconfig
> +++ b/drivers/iio/Kconfig
> @@ -92,6 +92,7 @@ source "drivers/iio/common/Kconfig"
>   source "drivers/iio/dac/Kconfig"
>   source "drivers/iio/dummy/Kconfig"
>   source "drivers/iio/filter/Kconfig"
> +source "drivers/iio/flow/Kconfig"
>   source "drivers/iio/frequency/Kconfig"
>   source "drivers/iio/gyro/Kconfig"
>   source "drivers/iio/health/Kconfig"
> diff --git a/drivers/iio/Makefile b/drivers/iio/Makefile
> index cb80ef837..f03a4100c 100644
> --- a/drivers/iio/Makefile
> +++ b/drivers/iio/Makefile
> @@ -29,6 +29,7 @@ obj-y += dac/
>   obj-y += dummy/
>   obj-y += gyro/
>   obj-y += filter/
> +obj-y += flow/
>   obj-y += frequency/
>   obj-y += health/
>   obj-y += humidity/
> diff --git a/drivers/iio/flow/Kconfig b/drivers/iio/flow/Kconfig
> new file mode 100644
> index 000000000..355857a6b
> --- /dev/null
> +++ b/drivers/iio/flow/Kconfig
> @@ -0,0 +1,22 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Liquid / gas flow sensor drivers
> +#
> +# When adding new entries keep the list in alphabetical order
> +
> +menu "Flow sensors"
> +
> +config SENSIRION_SLF3X
> +	tristate "Sensirion SLF3x liquid flow sensor"
> +	depends on I2C
> +	select CRC8
> +	help
> +	  Say yes here to build support for the Sensirion SLF3S family of
> +	  digital liquid-flow sensors (SLF3S-0600F, SLF3S-4000B, ...).
> +	  The driver reports the volumetric flow rate and the embedded
> +	  temperature reading via the standard IIO interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called slf3x.
> +
> +endmenu
> diff --git a/drivers/iio/flow/Makefile b/drivers/iio/flow/Makefile
> new file mode 100644
> index 000000000..9eb9bdde0
> --- /dev/null
> +++ b/drivers/iio/flow/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0
> +#
> +# Makefile for industrial I/O flow sensor drivers
> +#
> +
> +# When adding new entries keep the list in alphabetical order
> +obj-$(CONFIG_SENSIRION_SLF3X) += slf3x.o
> diff --git a/drivers/iio/flow/slf3x.c b/drivers/iio/flow/slf3x.c
> new file mode 100644
> index 000000000..e4ee1a04a
> --- /dev/null
> +++ b/drivers/iio/flow/slf3x.c
> @@ -0,0 +1,264 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Sensirion SLF3x liquid flow sensor driver.
> + *
> + * Copyright (C) 2026 CMBlu Energy
> + * Author: Wadim Mueller <wadim.mueller@cmblu.de>
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iio/iio.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +
> +#include <linux/unaligned.h>
> +
> +#define SLF3X_CRC8_POLY		0x31
> +#define SLF3X_CRC8_INIT		0xff
> +
> +#define SLF3X_PRODUCT_ID_LEN	18
> +#define SLF3X_FAMILY_BYTE	1
> +#define SLF3X_SUBTYPE_BYTE	3
> +
> +#define SLF3X_FAMILY_ID		0x03
> +
> +#define SLF3X_MEAS_LEN		9
> +#define SLF3X_MEAS_DELAY_US	12000
> +
> +/* Temperature LSB is 1/200 °C; IIO_TEMP scale is in mC/LSB => 5. */
> +#define SLF3X_TEMP_SCALE	5
> +
> +static const u8 slf3x_cmd_prep_pid[]	= { 0x36, 0x7c };
> +static const u8 slf3x_cmd_read_pid[]	= { 0xe1, 0x02 };
> +static const u8 slf3x_cmd_start_water[]	= { 0x36, 0x08 };

I looked at LQ_DS_SLF3S-1300F, LQ_DS_SLF3S-0600F, and LQ_DS_SLF3S-4000B.
They all also support Isopropyl alcohol (IPA) measurements.

Would it make sense to also provide support for other liquid types
besides water ? That could be a sysfs attribute and/or a devicetree
property.

> +static const u8 slf3x_cmd_stop[]	= { 0x3f, 0xf9 };
> +
> +DECLARE_CRC8_TABLE(slf3x_crc_table);
> +
> +struct slf3x_variant {
> +	u8 sub_type;
> +	const char *name;
> +	/*
> +	 * Flow scale exposed via IIO_CHAN_INFO_SCALE in litres per second
> +	 * per LSB, encoded as IIO_VAL_FRACTIONAL (num / den).  The encoding
> +	 * comes from the Sensirion datasheet's "scale factor" (ticks per
> +	 * ml/min) combined with the 1 ml/min = 1/60000 l/s conversion.
> +	 */

Not my call to make, but at least the Sensirion sensors all talk about
flow rate per minute, not per second. A Google search suggests that
flow rate is normally measured per minute or even per hour, and that
per-second measurements are typically only used for large-scale engineering,
rivers, dams, and rapid industrial chemical dosing. Taking SLF3S-0600F
as example, it measures up to ±2000 µl/min (!). Even Sensirion's gas
sensors use per-minute flow rates.

Any special reason to use a per-second rate ?

> +	int scale_num;
> +	int scale_den;
> +};
> +
> +static const struct slf3x_variant slf3x_variants[] = {
> +	{ .sub_type = 0x03, .name = "slf3s-0600f",
> +	  .scale_num = 1, .scale_den = 6000000 },
> +	{ .sub_type = 0x05, .name = "slf3s-4000b",
> +	  .scale_num = 1, .scale_den = 1666680000 },
> +};
> +
> +struct slf3x_data {
> +	struct i2c_client *client;
> +	const struct slf3x_variant *variant;
> +};
> +
> +static int slf3x_verify_crc(const u8 *block)
> +{
> +	return crc8(slf3x_crc_table, block, 2, SLF3X_CRC8_INIT) == block[2] ?
> +		       0 :
> +		       -EIO;

This returns -EIO on error ...

> +}
> +
> +static int slf3x_write_cmd(struct i2c_client *client, const u8 *cmd)
> +{
> +	int ret = i2c_master_send(client, cmd, 2);
> +
> +	if (ret == 2)
> +		return 0;
> +	return ret < 0 ? ret : -EIO;
> +}
> +
> +static int slf3x_read_product_info(struct slf3x_data *sf)
> +{
> +	struct i2c_client *client = sf->client;
> +	u8 buf[SLF3X_PRODUCT_ID_LEN];
> +	int ret, i;
> +
> +	ret = slf3x_write_cmd(client, slf3x_cmd_prep_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = slf3x_write_cmd(client, slf3x_cmd_read_pid);
> +	if (ret)
> +		return ret;
> +
> +	ret = i2c_master_recv(client, buf, sizeof(buf));
> +	if (ret != sizeof(buf))
> +		return ret < 0 ? ret : -EIO;
> +
> +	for (i = 0; i < SLF3X_PRODUCT_ID_LEN; i += 3) {
> +		if (slf3x_verify_crc(&buf[i])) {

... which is then ignored here and replaced by -EIO.

Why not just have it return a boolean ?

> +			dev_err(&client->dev,
> +				"product-info CRC mismatch at byte %d\n", i);
> +			return -EIO;
> +		}
> +	}
> +
> +	if (buf[SLF3X_FAMILY_BYTE] != SLF3X_FAMILY_ID) {
> +		dev_err(&client->dev,
> +			"unexpected device family 0x%02x\n",
> +			buf[SLF3X_FAMILY_BYTE]);
> +		return -ENODEV;
> +	}
> +
> +	for (i = 0; i < ARRAY_SIZE(slf3x_variants); i++) {
> +		if (buf[SLF3X_SUBTYPE_BYTE] == slf3x_variants[i].sub_type) {
> +			sf->variant = &slf3x_variants[i];
> +			return 0;
> +		}
> +	}
> +
> +	dev_err(&client->dev, "unsupported SLF3x sub-type 0x%02x\n",
> +		buf[SLF3X_SUBTYPE_BYTE]);

Not my call to make, but the driver is way too noisy for my liking.

> +	return -ENODEV;
> +}
> +
> +static int slf3x_read_sample(struct slf3x_data *sf, s16 *flow, s16 *temp)
> +{
> +	u8 buf[SLF3X_MEAS_LEN];
> +	int ret, i;
> +
> +	ret = i2c_master_recv(sf->client, buf, sizeof(buf));
> +	if (ret != sizeof(buf))
> +		return ret < 0 ? ret : -EIO;
> +
> +	for (i = 0; i < SLF3X_MEAS_LEN; i += 3) {
> +		if (slf3x_verify_crc(&buf[i]))
> +			return -EIO;
> +	}
> +
> +	*flow = (s16)get_unaligned_be16(&buf[0]);
> +	*temp = (s16)get_unaligned_be16(&buf[3]);
> +	return 0;
> +}
> +
> +static const struct iio_chan_spec slf3x_channels[] = {
> +	{
> +		.type = IIO_VOLUMEFLOW,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +	{
> +		.type = IIO_TEMP,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> +				      BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static int slf3x_read_raw(struct iio_dev *indio_dev,
> +			  struct iio_chan_spec const *chan, int *val,
> +			  int *val2, long mask)
> +{
> +	struct slf3x_data *sf = iio_priv(indio_dev);
> +	s16 flow, temp;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = slf3x_read_sample(sf, &flow, &temp);
> +		if (ret)
> +			return ret;
> +		*val = (chan->type == IIO_VOLUMEFLOW) ? flow : temp;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		if (chan->type == IIO_VOLUMEFLOW) {
> +			*val = sf->variant->scale_num;
> +			*val2 = sf->variant->scale_den;
> +			return IIO_VAL_FRACTIONAL;
> +		}
> +		*val = SLF3X_TEMP_SCALE;
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info slf3x_info = {
> +	.read_raw = slf3x_read_raw,
> +};
> +
> +static void slf3x_stop_meas(void *data)
> +{
> +	struct slf3x_data *sf = data;
> +
> +	slf3x_write_cmd(sf->client, slf3x_cmd_stop);
> +}
> +
> +static int slf3x_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct iio_dev *indio_dev;
> +	struct slf3x_data *sf;
> +	int ret;
> +
> +	ret = devm_regulator_get_enable_optional(dev, "vdd");
> +	if (ret < 0 && ret != -ENODEV)
> +		return dev_err_probe(dev, ret, "failed to enable vdd\n");
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*sf));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	sf = iio_priv(indio_dev);
> +	sf->client = client;
> +	crc8_populate_msb(slf3x_crc_table, SLF3X_CRC8_POLY);
> +
> +	ret = slf3x_read_product_info(sf);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "product info read failed\n");
> +
> +	ret = slf3x_write_cmd(client, slf3x_cmd_start_water);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "start measurement failed\n");
> +
> +	usleep_range(SLF3X_MEAS_DELAY_US, SLF3X_MEAS_DELAY_US + 1000);
> +
> +	ret = devm_add_action_or_reset(dev, slf3x_stop_meas, sf);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = sf->variant->name;
> +	indio_dev->channels = slf3x_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(slf3x_channels);
> +	indio_dev->info = &slf3x_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct i2c_device_id slf3x_id[] = {
> +	{ "slf3s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, slf3x_id);
> +
> +static const struct of_device_id slf3x_of_match[] = {
> +	{ .compatible = "sensirion,slf3s" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, slf3x_of_match);
> +
> +static struct i2c_driver slf3x_driver = {
> +	.driver = {
> +		.name = "slf3x",
> +		.of_match_table = slf3x_of_match,
> +	},
> +	.probe = slf3x_probe,
> +	.id_table = slf3x_id,
> +};
> +module_i2c_driver(slf3x_driver);
> +
> +MODULE_AUTHOR("Wadim Mueller <wadim.mueller@cmblu.de>");
> +MODULE_DESCRIPTION("Sensirion SLF3x liquid flow sensor driver");
> +MODULE_LICENSE("GPL");

