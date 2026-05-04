Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 851A63E2772;
	Mon,  4 May 2026 17:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777915946; cv=none; b=GbcsYG3XOnO9X44qwHBUWKdwkZQO8vQjGXrt3kWCz1vfzGjoWv4bq+OsbLvoaitZsPmaiIVCV0kAnddNrifZm5OgbTNfMipC9EHH3K1K/a1KzAw1PdQSlT7qID27QyqAltJPktOHaUbb+DrnB3OQU+TYzxPfjgRPlzRifmyZjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777915946; c=relaxed/simple;
	bh=PsrW77BE83jmuKFMHLw6qCe+MVjSplndO6+//9KRHl4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itfmHR5OAJSViFXwY7oDSCMv6CHO5NerN4abZ8vf0h89xvlORoHA0zYCO54q4vHpEpjvarI+oRtlLxwU42RJkKDEg50rAfgTsLQkGmKCBit2zrUMcNxWOg30evzk5ZfLhEB/kSXBwILKBSVl6MtFpKgg0Q+Y0LXJz2KZ7ReRarA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R0uak8Fx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R0uak8Fx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93370C2BCF4;
	Mon,  4 May 2026 17:32:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777915946;
	bh=PsrW77BE83jmuKFMHLw6qCe+MVjSplndO6+//9KRHl4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=R0uak8Fx2TUyNNhedfkTdxdW2rlGxnE4RdtQOOhU4dGWyo36JgzpR4NykcY1Qs8f1
	 jzO2aongzbSvRyuQOKx1GM2TJM1lc8g21WfrgMLNkCblAFTOUeui5lb369CW7XsAVs
	 CSfPDoX3iDTGUyvvcOwm2DLN+FITyGOy678qBPzYxkM2IlumDa4T5wQjzy9+Vbut73
	 2VF0CRpW0uoY/4C7u861xeu2Z/VE3D31Ukj4fdrQjbEJQgaugvOtvEZiRXQhHli4cU
	 nKfZ9ravFI/9eS9uHPWc1Uq9WUHpdlHAWg/FE46F+6OJXa9Rl5YO18LJCalAcpSOV+
	 EwHHbDdPtVe0Q==
Date: Mon, 4 May 2026 18:32:15 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <git@amd.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
 <dlechner@baylibre.com>, <michal.simek@amd.com>, <conall.ogriofa@amd.com>,
 <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Guenter Roeck
 <linux@roeck-us.net>, linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v2 2/5] iio: adc: add Versal SysMon driver
Message-ID: <20260504183215.37c8ae65@jic23-huawei>
In-Reply-To: <20260502111951.538488-3-salih.erim@amd.com>
References: <20260502111951.538488-1-salih.erim@amd.com>
	<20260502111951.538488-3-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 2 May 2026 12:19:48 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add the AMD/Xilinx Versal System Monitor (SysMon) IIO driver.
> 
> The driver is split into a bus-agnostic core module
> (versal-sysmon-core) and a memory-mapped I/O platform driver
> (versal-sysmon). The core uses the regmap API so that different
> bus implementations can share the same IIO logic.
> 
> The core provides:
>   - Static temperature channels (current max/min, peak max/min)
>   - Supply voltage channels parsed from DT container nodes
>   - Temperature satellite channels parsed from DT container nodes
>   - read_raw for IIO_CHAN_INFO_RAW and IIO_CHAN_INFO_PROCESSED
>   - read_label using the DT label property

Various comments inline.  One thing to check.
Is this one strictly a hardware monitoring device? Or does it
get used for more general ADC purposes?  Did you consider an HWMON driver
for it? The above sounds a lot like hwmon. So why IIO for this one?

I wasn't awake enough on v1 to raise this!  Sorry about that.
+CC Guenter and linux-hwmon for that discussion.

Thanks,

Jonathan

> 
> The MMIO platform driver provides:
>   - Memory-mapped register access via custom regmap callbacks
>   - NPI unlock before every register write (platform management
>     controller may re-lock NPI unpredictably on Versal devices)
> 
> Threshold events, oversampling, and I2C bus support are added in
> subsequent patches.
> 
> Co-developed-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>



> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versal-sysmon-core.c
> new file mode 100644
> index 00000000000..37736c2900b
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -0,0 +1,320 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Versal SysMon core driver
> + *
> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/bitfield.h>
> +#include <linux/bits.h>
> +#include <linux/cleanup.h>
> +#include <linux/iio/iio.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +
> +#include "versal-sysmon.h"
> +
> +#define SYSMON_CHAN_TEMP(_chan, _address, _ext) {		\
> +	.type = IIO_TEMP,					\
> +	.indexed = 1,						\
> +	.address = _address,					\
> +	.channel = _chan,					\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |		\
> +		BIT(IIO_CHAN_INFO_PROCESSED),			\
Why do you need raw and processed?  There are a few reasons that can show
up in a driver.
1) Non linear transforms that aren't reversable and we need to be
   able to threshold on the raw.
2) History - don't copy this but some drivers used _PROCESSED and
   reviewers (i.e. mostly me) weren't paying attention. We then needed
   to add _raw for buffered / events and so ended up with both.

1 might apply here I guess?  If so add a comment to that affect above
.info_mask_separate being assigned.  I don't want this to get copied
into most drivers where things aren't non linear.


> +	.scan_type = {						\
> +		.sign = 's',					\
> +		.realbits = 15,					\
> +		.storagebits = 16,				\
> +		.endianness = IIO_CPU,				\
> +	},							\
> +	.datasheet_name = _ext,					\

Can we rename _ext.  We still have legacy .extended_name in here
and people might assume that is in use (definitely don't use that!)
_name or something like that instead of _ext?
 
> +}
> +
> +/* Static temperature channels (always present) */
> +static const struct iio_chan_spec temp_channels[] = {
> +	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
> +	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
> +	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
> +	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
> +};
> +
> +static void sysmon_q8p7_to_millicelsius(int raw_data, int *val)
> +{
> +	*val = ((s16)raw_data * SYSMON_MILLI) >> SYSMON_FRACTIONAL_SHIFT;
> +}
> +
> +static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
> +{
> +	int mantissa, format, exponent;
> +
> +	mantissa = FIELD_GET(SYSMON_MANTISSA_MASK, raw_data);
> +	exponent = SYSMON_SUPPLY_MANTISSA_BITS - FIELD_GET(SYSMON_MODE_MASK, raw_data);
> +	format = FIELD_GET(SYSMON_FMT_MASK, raw_data);
> +	/*
> +	 * When format bit is set the mantissa is two's complement
> +	 * (per hardware spec); sign-extend to int for correct arithmetic.
> +	 */
> +	if (format)
> +		mantissa = (int)(s16)mantissa;
> +
> +	*val = (mantissa * SYSMON_MILLI) >> exponent;
> +}

> +/**
> + * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
> + * @indio_dev: IIO device instance
> + * @dev: Parent device
> + *
> + * Reads supply-channels and temperature-channels container nodes from
> + * firmware and builds the IIO channel array. Static temperature channels
> + * are prepended, followed by supply and satellite channels from DT.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	unsigned int idx, temp_chan_idx, volt_chan_idx;
> +	struct fwnode_handle *supply_node, *temp_node;
> +	unsigned int num_supply = 0, num_temp = 0;
> +	struct iio_chan_spec *sysmon_channels;
> +	const char *label;
> +	u32 reg;
> +	int ret;
> +
> +	supply_node = device_get_named_child_node(dev, "supply-channels");
> +	if (supply_node)
> +		num_supply = fwnode_get_child_node_count(supply_node);
> +
> +	temp_node = device_get_named_child_node(dev, "temperature-channels");
> +	if (temp_node)
> +		num_temp = fwnode_get_child_node_count(temp_node);

Once you have these using __free() look closely at the various exit points.
Most can be direct returns and as this is only called from probe() you can
use dev_err_probe() to simplify things a little.

> diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sysmon.c
> new file mode 100644
> index 00000000000..c597934e869
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon.c

> +
> +static int sysmon_platform_probe(struct platform_device *pdev)
> +{
> +	struct sysmon_mmio *mmio;
> +	struct regmap *regmap;
> +	int irq;
> +
> +	mmio = devm_kzalloc(&pdev->dev, sizeof(*mmio), GFP_KERNEL);
> +	if (!mmio)
> +		return -ENOMEM;
> +
> +	mmio->base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio->base))
> +		return PTR_ERR(mmio->base);
> +
> +	regmap = devm_regmap_init(&pdev->dev, NULL, mmio,
> +				  &sysmon_mmio_regmap_config);
> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	irq = platform_get_irq_optional(pdev, 0);

Could you instead use fwnode_irq_get(dev_fwnode(dev), 0) in the
shared code to get  this?  There may be subtle differences in
handling but those will be in strange corner cases that probably
don't apply here.

> +
> +	return sysmon_core_probe(&pdev->dev, regmap, irq);
> +}

> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sysmon.h
> new file mode 100644
> index 00000000000..fc4d2338328
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon.h
> @@ -0,0 +1,69 @@

> +
> +/* Q8.7 fractional shift */
> +#define SYSMON_FRACTIONAL_SHIFT		7U
> +#define SYSMON_SUPPLY_MANTISSA_BITS	16
> +
> +/* Signed milli scale (MILLI from linux/units.h is unsigned long) */
> +#define SYSMON_MILLI			1000

Cast that one rather than defining the number again.  I see you discussed
this with Andy but no conclusion reached.

> +
> +/**
> + * struct sysmon - Driver data for Versal SysMon
> + * @dev: pointer to device struct
> + * @indio_dev: pointer to the iio device (needed for work callbacks)
> + * @regmap: register map for hardware access
> + * @lock: mutex for serializing user-space access

Normally we talk about what data is protected. The comment below
is better.  Also ignore checkpatch, you don't need it commented down there
- in kernel-doc is absolutely fine.

> + * @irq: interrupt number
> + */
> +struct sysmon {
> +	struct device *dev;

I'm always a bit in two minds about this. You can always get the dev
from the regmap but it can be a little more ugly than strictly necessary.
See how bad it is using regmap_get_device()

> +	struct iio_dev *indio_dev;
This smells backwards. Given this sysmon structure is allocated in the
private area of iio_priv() we should never need to go in this direction.
I don't think you really use this beyond one place where you can easily pass
it to. Anyhow this indio_dev pointer needs to go.

> +	struct regmap *regmap;
> +	/* Serializes access to device registers and state */
> +	struct mutex lock;
> +	int irq;

It's relatively rare to need to keep irq around after probe() and
I don't think you need to here.  Just store it in a local variable
that you pass into the interrupt init functions.

> +};
> +
> +int sysmon_core_probe(struct device *dev, struct regmap *regmap, int irq);
> +
> +#endif /* _VERSAL_SYSMON_H_ */

