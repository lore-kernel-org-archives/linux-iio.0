Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C6103EFD31;
	Thu, 28 May 2026 12:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779972151; cv=none; b=NRZcIJdvDjR2q0YJBGIGqMFbTwdkA4rffOUrvvLfaxV64bCocIalTRTQkO+ayA9Bq5saT5gjGUKt1FNN31eS7ZT96lvadzyYCfTuSySHIX2LzWQ641KehKwWSEcqJ2l4oukuVkqCiyCg9/9Z8HxjGHBi72bo3+CW44Lu6sDC6kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779972151; c=relaxed/simple;
	bh=zCDmBqBKNLVx2HHukoTqQdcq7HiepUNWsYSAOtLQ1L4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bpZj69qIf1MunFbbnSJpnOf4xg3YrvhO5I7piYi4S6h7M/wKst3yHOedVlJXvvo1NLYAMO9+XVT2aM1JjryLEjgtiJeSCE9ktVlfy/RvX1YiVbcG8IKqaW07s8WtqGziS8GVms1T2+JnD2tzXoqoNk6//3Nxer3G0ODJdRkJcUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jvM1YQeN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jvM1YQeN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963C31F00A3A;
	Thu, 28 May 2026 12:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779972141;
	bh=aVS8DX9ln5xLsnrTXaBC68d2+dtey1SIzHgDoIDXv0w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jvM1YQeN5+vguckmJRGclagx06soaBkrWay0cqFzqa5Dyg+YLXxYpPbd93d4e6Kvw
	 hBqahauKFU3GPthp0q1M+MoYA3r6rX+o1Qb6Tq66OxhOAqldr3mb1hr4UdgzaEskOF
	 X8Cy4jeQdrPV02r9W/Tl9+EONtyaPmBebFVMbaC03IuK6H+i1QkZI1AYAQ2dLQb0Mu
	 l2I4PH1q9n6lX9WwO8H0PUu5Mww/Hos6lfFbQH4nuIXGwQICJh+IghRf10k0TluUZ8
	 O928NohIhl7hqrBipDPGZzc2ZoJSxHY+993opxrFqJGCw7/KooAzUjHh6FaPMmlpfi
	 lH7coKCWWANAw==
Date: Thu, 28 May 2026 13:42:11 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 3/5] iio: adc: versal-sysmon: add I2C driver
Message-ID: <20260528134211.259d8c19@jic23-huawei>
In-Reply-To: <20260527114211.174288-4-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
	<20260527114211.174288-4-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 27 May 2026 12:42:09 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add an I2C transport driver for the Versal SysMon block. The SysMon
> provides an I2C slave interface that allows an external master to
> read voltage and temperature measurements through the same register
> map used by the MMIO path.
> 
> The I2C command frame is an 8-byte structure containing a 4-byte data
> payload, a 2-byte register offset, and a 1-byte instruction field.
> Read operations send the frame with a read instruction, then receive
> a 4-byte response containing the register value.
> 
> Events are not supported on the I2C path because there is no
> interrupt line and the I2C regmap backend cannot be called from
> atomic context.
> 
> Co-developed-by: Conall O'Griofa <conall.ogriofa@amd.com>
> Signed-off-by: Conall O'Griofa <conall.ogriofa@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>
A few minor things inline.

> diff --git a/drivers/iio/adc/versal-sysmon-i2c.c b/drivers/iio/adc/versal-sysmon-i2c.c
> new file mode 100644
> index 00000000000..92d149f517e
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon-i2c.c
> @@ -0,0 +1,153 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Versal SysMon I2C driver
> + *
> + * Copyright (C) 2023 - 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/i2c.h>
> +#include <linux/module.h>
> +#include <linux/regmap.h>
> +
> +#include "versal-sysmon.h"
> +
> +#define SYSMON_I2C_INSTR_READ	BIT(2)
> +#define SYSMON_I2C_INSTR_WRITE	BIT(3)
> +
> +#define SYSMON_I2C_DATA0_MASK	GENMASK(7, 0)
> +#define SYSMON_I2C_DATA1_MASK	GENMASK(15, 8)
> +#define SYSMON_I2C_DATA2_MASK	GENMASK(23, 16)
> +#define SYSMON_I2C_DATA3_MASK	GENMASK(31, 24)
> +
> +#define SYSMON_I2C_OFS_LOW_MASK		GENMASK(9, 2)
> +#define SYSMON_I2C_OFS_HIGH_MASK	GENMASK(15, 10)
> +
> +/* Byte positions within the 8-byte I2C command frame (HW-defined) */
> +enum sysmon_i2c_payload_idx {
> +	SYSMON_I2C_DATA0_IDX = 0,
> +	SYSMON_I2C_DATA1_IDX = 1,
> +	SYSMON_I2C_DATA2_IDX = 2,
> +	SYSMON_I2C_DATA3_IDX = 3,
> +	SYSMON_I2C_OFS_LOW_IDX = 4,
> +	SYSMON_I2C_OFS_HIGH_IDX = 5,

With changes suggested below I think you only need the two base
offsets and the final one.  As such maybe 3 defines makes more sense
than an enum

> +	SYSMON_I2C_INSTR_IDX = 6,
If you do keep an enum, it would be good to add an entry for the final
byte to give some indication of why it is 8 bytes. Even if that is
reserved0
> +};
> +
> +static int sysmon_i2c_reg_read(void *context, unsigned int reg,
> +			       unsigned int *val)
> +{
> +	struct i2c_client *client = context;
> +	u8 write_buf[8] = { };
> +	u8 read_buf[4];
> +	int ret;
> +
> +	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
> +	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);

I'd guess an unaligned put works here a well? though you'll need
to do a FIELD_GET() to extract the slightly shifted content.

> +	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_READ;
> +
> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(write_buf))
> +		return -EIO;
> +
> +	ret = i2c_master_recv(client, read_buf, sizeof(read_buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(read_buf))
> +		return -EIO;
> +
> +	*val = FIELD_PREP(SYSMON_I2C_DATA0_MASK,
> +			  read_buf[SYSMON_I2C_DATA0_IDX]) |
> +	       FIELD_PREP(SYSMON_I2C_DATA1_MASK,
> +			  read_buf[SYSMON_I2C_DATA1_IDX]) |
> +	       FIELD_PREP(SYSMON_I2C_DATA2_MASK,
> +			  read_buf[SYSMON_I2C_DATA2_IDX]) |
> +	       FIELD_PREP(SYSMON_I2C_DATA3_MASK,
> +			  read_buf[SYSMON_I2C_DATA3_IDX]);
Very complex way to express what I think is
	*val = get_unaligned_le32(&read_buf[0]);
> +
> +	return 0;
> +}
> +
> +static int sysmon_i2c_reg_write(void *context, unsigned int reg,
> +				unsigned int val)
> +{
> +	struct i2c_client *client = context;
> +	u8 write_buf[8] = { };

> +	int ret;
> +
> +	write_buf[SYSMON_I2C_DATA0_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA0_MASK, val);
> +	write_buf[SYSMON_I2C_DATA1_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA1_MASK, val);
> +	write_buf[SYSMON_I2C_DATA2_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA2_MASK, val);
> +	write_buf[SYSMON_I2C_DATA3_IDX] =
> +		FIELD_GET(SYSMON_I2C_DATA3_MASK, val);

That's a put_unaligned_le32() I think?

> +	write_buf[SYSMON_I2C_OFS_LOW_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_LOW_MASK, reg);
> +	write_buf[SYSMON_I2C_OFS_HIGH_IDX] =
> +		FIELD_GET(SYSMON_I2C_OFS_HIGH_MASK, reg);

I'd guess put_unaligned_le16()? Will need a a FIELD_PREP()
for the full thing though.

> +	write_buf[SYSMON_I2C_INSTR_IDX] = SYSMON_I2C_INSTR_WRITE;
> +
> +	ret = i2c_master_send(client, write_buf, sizeof(write_buf));
> +	if (ret < 0)
> +		return ret;
> +	if (ret != sizeof(write_buf))
> +		return -EIO;
> +
> +	return 0;
> +}

> +static const struct of_device_id sysmon_i2c_of_match_table[] = {
> +	{ .compatible = "xlnx,versal-sysmon" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, sysmon_i2c_of_match_table);
> +
> +static const struct i2c_device_id sysmon_i2c_id_table[] = {
> +	{ "versal-sysmon" },

Named initializer for this.  Uwe is cleaning these up across IIO;
let us not add another one!

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, sysmon_i2c_id_table);
> +
> +static struct i2c_driver sysmon_i2c_driver = {
> +	.probe = sysmon_i2c_probe,
> +	.driver = {
> +		.name = "versal-sysmon-i2c",
> +		.of_match_table = sysmon_i2c_of_match_table,
> +	},
> +	.id_table = sysmon_i2c_id_table,
> +};
> +module_i2c_driver(sysmon_i2c_driver);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("AMD Versal SysMon I2C Driver");
> +MODULE_AUTHOR("Conall O'Griofa <conall.ogriofa@amd.com>");
> +MODULE_AUTHOR("Salih Erim <salih.erim@amd.com>");

