Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FCA5384250
	for <linux-iio@vger.kernel.org>; Sat,  1 Aug 2026 15:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785596552; cv=none; b=grZLURKWVNn/sGXSgBKWU0s+FqJ/MiUM8/xQwdnb+bcjsbiB9gejcVOJhbGlrR9SHYNZacix5UJVPjs6azVs64FxYbq1uOlhwFW3+1GADDK/Rwjf5H2kUYy921qALi1VxXp3dN00G/BW0yN38+TnTUMrRMPg5xkdM/Ey+f4vZSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785596552; c=relaxed/simple;
	bh=xRVg1yasPBB5NzmjfBOkqOl/aTRuM2I+kwlfUDeA67s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FcjvGAidfsN8rkjPi9Szmv+W9V8Pwn+c3FN2Wf8gyoUFaF6vn4HabM5wAuskcFIEHKdnVRB7oeOi5u4m0sgYNilWJfGVzyAzb2aBbClnQPNAO4MFwGr+I6dHyvf5Xg1PbQoolNkeiO55MJOjK3k/HDiUbwXYLukOOR3AwfmNANc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dQ01LDNB; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dQ01LDNB"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7ec58fa3e01so953892a34.1
        for <linux-iio@vger.kernel.org>; Sat, 01 Aug 2026 08:02:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1785596549; x=1786201349; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U+dM9uqc02yFtNS8yxq8WdKy5Ckg/Jxy7aMC/aM+dL0=;
        b=dQ01LDNBQHMlY7LfQRcvsp+fFidQP+84qa5IPPubm1tF4mCMMSKvQvn/JjxMoN8cv6
         VtkxYaHOCcEum6ksnSPuX4RroxlBmXEst1lVxEzWXyea5jlNRpQ5oYsqiDIXEfhi5mtd
         VrBNUbUpzf5JQOYy/2LxfpLK2cOdl4AWky4b2oepYC/s8oubeTm5rzGV1h2k64+WUIMF
         Gidw5+p2TexZCypa6AAxjoYd90YKbqH1GL2SxdWK9tsZMTyBdoAVLSoKgKmcNS9ozCDf
         wNDuUk+eZ+Sz9QUFCjUp68DKbFIa5Oym1aq8FYwaM3hwzTllT+XXQraPq2vudEy5FhUD
         e4Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785596549; x=1786201349;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=U+dM9uqc02yFtNS8yxq8WdKy5Ckg/Jxy7aMC/aM+dL0=;
        b=K43X92dF5S0JnEM+oqR6J9LWYVe7gvVRX1zfvBEcZ2MIHnyo5RWvuT8vZ/Xv5vf15e
         5ceItfntN2ipFl8ZibERPUNNStVySuK9/U05+nrmLHon91bs2vBet9ZTJWlMteaGLt7Q
         nm4S2q+KHD0SdxS1R7pp8UX4mTB2BADfqqaiLVoVsEbddRBRTTx4DRsv0Zp77WEhTI96
         93OtSQCpR/bMpR2poQu8/u8F5COQgzvx3o1tNnKeHxf4sHCx04FLDhis1pzbcP8HL5S5
         RyU2JYDXHUv3+cUI4b1uG3hEGUveP7Sy3LzmRXtl2Z8e4WO/Qf+isx7f/iLDLT4M2W8d
         AGSA==
X-Gm-Message-State: AOJu0YyoztJqCFxvHEKW4XV/Tf744TGLwkW2tEK8mo/KVy4RMNjtkism
	ApIwgTjdvZs0TrMj3rA7yPYO9A05FH4NyDFCGwHppzLseIriO7QLVEeW9+oZt/Nmi+g=
X-Gm-Gg: AR+sD10X37RRxHFXCZ5srX9HxJBvsdalhvLEmuVbdKhw7OpRoWIaYIaA6d7jQwEbW7o
	c02jbT1p9HEjXYmz1kxfUJU8qdHPUYQt20fTEQbp9k8ohwck2l362rxZ3swRniOCNbnl4Y5zAgx
	Om6v0aguhPTj3CMJajA+kY+u4fng3BFR5Y+D4mjXb0RsKfGYKWM6qDUK0IHm2RYW4/vvP5ZOSN3
	wCOA/7xAYfjARekRQ/gBX0GX+o1xzIISyfYlei5y5even01Pk3+NMqdCF6PjKHS+qOuARgYd7+q
	0NB7j+Fr/e/OZmbCJYDeTYitaKFE0EZUpzjvxHbRpcCe5YplphLBk0Q/8ZDMqM7e8iFMjHS9EHN
	C+JjEY2XytC9OJSKWIk7doW/HdEedoJ9imjHssuVNuAgeWxheKcMRUzIH6Upub1YOCi5eQSUG5M
	KT7dJWRuWlg+OSBhyXcfJ2hMhPN1T73GDh97yStNdUWBOoB9dzqYM71+O0WnOXgX8PZkzmvOa4q
	hKgqg+vzi6pbFJ2J3ME2pkHcrQono8Y3QFgsY2wrwQIdB3f3Ug=
X-Received: by 2002:a05:6820:221e:b0:6ae:4767:a503 with SMTP id 006d021491bc7-6ae4767a98fmr4756954eaf.34.1785596548637;
        Sat, 01 Aug 2026 08:02:28 -0700 (PDT)
Received: from ?IPV6:2600:8803:e7e4:500:359b:17f1:d4f9:4949? ([2600:8803:e7e4:500:359b:17f1:d4f9:4949])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7f18f0da951sm3168830a34.24.2026.08.01.08.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Aug 2026 08:02:27 -0700 (PDT)
Message-ID: <185632fa-8e1d-467a-a194-aafac05dbdea@baylibre.com>
Date: Sat, 1 Aug 2026 10:02:27 -0500
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] iio: dac: mcp47a1: add support for new device
To: Joshua Crofts <joshua.crofts1@gmail.com>,
 Jonathan Cameron <jic23@kernel.org>, =?UTF-8?Q?Nuno_S=C3=A1?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260727-mcp47a1-add-support-v2-0-d4591a2ce69e@gmail.com>
 <20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
Content-Language: en-US
From: David Lechner <dlechner@baylibre.com>
In-Reply-To: <20260727-mcp47a1-add-support-v2-2-d4591a2ce69e@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/27/26 1:31 PM, Joshua Crofts wrote:
> The Microchip MCP47A1 is a 6-bit volatile Digital-to-Analog converter
> which communicates via I2C.
> 
> Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/dac/Kconfig   |  10 +++
>  drivers/iio/dac/Makefile  |   1 +
>  drivers/iio/dac/mcp47a1.c | 169 ++++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 181 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8a0b23418a64..552ced65cf75 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17703,6 +17703,7 @@ MICROCHIP MCP47A1 DAC DRIVER
>  M:	Joshua Crofts <joshua.crofts1@gmail.com>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/dac/microchip,mcp47a1.yaml
> +F:	drivers/iio/dac/mcp47a1.c
>  
>  MICROCHIP MCP9982 TEMPERATURE DRIVER
>  M:	Victor Duicu <victor.duicu@microchip.com>
> diff --git a/drivers/iio/dac/Kconfig b/drivers/iio/dac/Kconfig
> index d6d560c09e25..1d00cd911826 100644
> --- a/drivers/iio/dac/Kconfig
> +++ b/drivers/iio/dac/Kconfig
> @@ -565,6 +565,16 @@ config MCP4728
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called mcp4728.
>  
> +config MCP47A1
> +	tristate "MCP47A1 DAC driver"
> +	depends on I2C
> +	help
> +	  Say Y here if you want to build a driver for the Microchip
> +	  MCP47A1 digital-to-analog converter with an I2C interface.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called mcp47a1.
> +
>  config MCP47FEB02
>  	tristate "MCP47F(E/V)B01/02/04/08/11/12/14/18/21/22/24/28 DAC driver"
>  	depends on I2C
> diff --git a/drivers/iio/dac/Makefile b/drivers/iio/dac/Makefile
> index 5d20d37e44ce..992f8930f95c 100644
> --- a/drivers/iio/dac/Makefile
> +++ b/drivers/iio/dac/Makefile
> @@ -55,6 +55,7 @@ obj-$(CONFIG_MAX5821) += max5821.o
>  obj-$(CONFIG_MCF54415_DAC) += mcf54415_dac.o
>  obj-$(CONFIG_MCP4725) += mcp4725.o
>  obj-$(CONFIG_MCP4728) += mcp4728.o
> +obj-$(CONFIG_MCP47A1) += mcp47a1.o
>  obj-$(CONFIG_MCP47FEB02) += mcp47feb02.o
>  obj-$(CONFIG_MCP4821) += mcp4821.o
>  obj-$(CONFIG_MCP4922) += mcp4922.o
> diff --git a/drivers/iio/dac/mcp47a1.c b/drivers/iio/dac/mcp47a1.c
> new file mode 100644
> index 000000000000..140e93ff2ba0
> --- /dev/null
> +++ b/drivers/iio/dac/mcp47a1.c
> @@ -0,0 +1,169 @@
> +// SPDX-License-Identifier: GPL-2.0

Prefer more specific GPL-2.0-only or GPL-2.0-or-later (your choice).

> +/*
> + * Microchip MCP47A1 DAC driver
> + *
> + * Copyright (c) 2026 Joshua Crofts <joshua.crofts1@gmail.com>
> + *
> + * Datasheet: https://ww1.microchip.com/downloads/aemDocuments/documents/OTH/ProductDocuments/DataSheets/25154A.pdf
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/delay.h>
> +#include <linux/err.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define MCP47A1_REG_MAX		0x40

Unused macro.

> +#define MCP47A1_CMD_CODE	0x00
> +#define MCP47A1_MAX_STEP	63
> +
> +struct mcp47a1_data {
> +	struct i2c_client *client;
> +	int vref_mV;
> +};
> +
> +static const int mcp47a1_raw_avail[] = { 0, 1, MCP47A1_MAX_STEP };
> +
> +static const struct iio_chan_spec mcp47a1_channels[] = {
> +	{
> +		.type = IIO_VOLTAGE,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = 0,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_separate_available = BIT(IIO_CHAN_INFO_RAW),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +	},
> +};
> +
> +static int mcp47a1_write(struct iio_dev *indio_dev,
> +			 struct iio_chan_spec const *chan,
> +			 int val, int val2, long mask)
> +{
> +	struct mcp47a1_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		if (val < 0 || val > MCP47A1_MAX_STEP)

There is also in_range() which is nice for this sort of check.

> +			return -EINVAL;
> +
> +		return i2c_smbus_write_byte_data(data->client, MCP47A1_CMD_CODE,
> +						 val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp47a1_read(struct iio_dev *indio_dev,
> +			struct iio_chan_spec const *chan,
> +			int *val, int *val2, long mask)
> +{
> +	struct mcp47a1_data *data = iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		ret = i2c_smbus_read_byte_data(data->client, MCP47A1_CMD_CODE);
> +		if (ret < 0)
> +			return ret;
> +
> +		*val = ret;
> +
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		*val = data->vref_mV;
> +		*val2 = MCP47A1_MAX_STEP;
> +
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mcp47a1_read_avail(struct iio_dev *indio_dev,
> +			      struct iio_chan_spec const *chan,
> +			      const int **vals, int *type, int *length,
> +			      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*vals = mcp47a1_raw_avail;
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static const struct iio_info mcp47a1_info = {
> +	.write_raw = mcp47a1_write,
> +	.read_raw = mcp47a1_read,
> +	.read_avail = mcp47a1_read_avail,
> +};
> +
> +static int mcp47a1_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct mcp47a1_data *data;
> +	struct iio_dev *indio_dev;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_regulator_get_enable(dev, "vdd");
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to enable regulator\n");
> +
> +	/* Delay after device exits reset state (see AC/DC characteristics) */
> +	fsleep(20);
> +
> +	ret = devm_regulator_get_enable_read_voltage(dev, "vref");
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "Failed to read vref\n");
> +
> +	data->vref_mV = ret / (MICRO / MILLI);
> +
> +	indio_dev->name = "mcp47a1";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &mcp47a1_info;
> +	indio_dev->channels = mcp47a1_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(mcp47a1_channels);
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct of_device_id mcp47a1_of_match[] = {
> +	{ .compatible = "microchip,mcp47a1" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, mcp47a1_of_match);
> +
> +static const struct i2c_device_id mcp47a1_id[] = {
> +	{ .name = "mcp47a1" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mcp47a1_id);
> +
> +static struct i2c_driver mcp47a1_driver = {
> +	.driver = {
> +		.name = "mcp47a1",
> +		.of_match_table = mcp47a1_of_match,
> +	},
> +	.probe = mcp47a1_probe,
> +	.id_table = mcp47a1_id,
> +};
> +module_i2c_driver(mcp47a1_driver);
> +
> +MODULE_AUTHOR("Joshua Crofts <joshua.crofts1@gmail.com>");
> +MODULE_DESCRIPTION("MCP47A1 DAC");
> +MODULE_LICENSE("GPL");
> 

If only all drivers were this simple. :-)
