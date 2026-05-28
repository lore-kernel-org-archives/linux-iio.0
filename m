Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCDB3EBF37;
	Thu, 28 May 2026 12:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779971062; cv=none; b=F+9S1d87d9SpVhoGyxWLbjCNXTSZzFYVj9x6esA0FnIpbKsyI4q2TuVi+3INPrlhDKnRPk9CA/I58rgsiBnN0IzrMnXFzvqdLzS26FosM8fNzLXEAYZq6CN/XhgVkDhaRRtsHx8ulhwgL5JNSdYMe99KnvdFWKJsrID6XUjjEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779971062; c=relaxed/simple;
	bh=6dXR0QbE9J3kIudryjQtGinb6wxFZprB9NRkTUj770k=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ea9+6538zwWb5rJelM90KPLhAX7XR8P8spjB5h7/S9cPOM7C5ihRUQXZ1+YrhdqZZEG66z+93CYHYoHmjqpHfKyUicQmhk2q6+Vu5IQtjcNhZGWs8Pa12FMTluNPcJA65MRihe0yoDDx3Acj2eyVu3eyn1aKbwWvmgQ+m0uCJlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C1+dtboI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C1+dtboI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C92991F00A3C;
	Thu, 28 May 2026 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779971060;
	bh=2KHy8m224WdDKulHXNmfuVWu+2wQiKPiPlKgouY4BME=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=C1+dtboIi0rTYHBpYS85SmBrLOdayx0vZTx1F4mEtbnMRtD6wnaiXhdZ03Qf9NhGu
	 seHwlqHkVsQu8lZVk87by/FHntSRbeor1zX5Ve6mT3dGPJQhHngO5gtLeqOeR/+EwD
	 iwJU1IbA3ehdymBLnfYhyR+qu6zLus5n6hAe3vGKHDLfGDm+HPlZr9Vorbm2uKL+qa
	 S78iu+2vwxWL0L4dfxRqkQ51HiDNELETFNaU7Ef7B9UW+e/09Jayv6IGewQvd/ikm7
	 LGjshZ3d61+B+sBA40EeIjxzDeNIRz3nQ+KqZ6aLFU/+7mzU8CruOV5lwJ4J2KFq1Z
	 n9N36m5jSDdCA==
Date: Thu, 28 May 2026 13:24:10 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salih Erim <salih.erim@amd.com>
Cc: Andy Shevchenko <andy@kernel.org>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Rob
 Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor
 Dooley <conor+dt@kernel.org>, Conall O'Griofa <conall.ogriofa@amd.com>,
 Michal Simek <michal.simek@amd.com>, Guenter Roeck <linux@roeck-us.net>,
 Salih Erim <erimsalih@gmail.com>, <linux-iio@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/5] iio: adc: add Versal SysMon driver
Message-ID: <20260528132410.0e03cfb1@jic23-huawei>
In-Reply-To: <20260527114211.174288-3-salih.erim@amd.com>
References: <20260527114211.174288-1-salih.erim@amd.com>
	<20260527114211.174288-3-salih.erim@amd.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Wed, 27 May 2026 12:42:08 +0100
Salih Erim <salih.erim@amd.com> wrote:

> Add the core driver and MMIO platform driver for the AMD/Xilinx Versal
> System Monitor (SysMon) block.
>=20
> The SysMon block resides in the platform management controller (PMC) and
> provides on-chip voltage and temperature monitoring through a 10-bit,
> 200 kSPS ADC. It can monitor up to 160 voltage channels and 64
> temperature satellites distributed across the SoC, with a consistent
> sample rate of 8 kSPS per channel regardless of how many channels are
> enabled.
>=20
> The driver is split into three compilation units:
>   - versal-sysmon-core: Channel parsing, IIO registration, read_raw
>   - versal-sysmon: MMIO platform driver with custom regmap accessors
>=20
> Voltage results are stored in a 19-bit modified floating-point format
> and converted to millivolts. Temperature results are stored in Q8.7
> signed fixed-point Celsius format and converted to millicelsius.
>=20
> The MMIO regmap backend uses a custom reg_write accessor that
> automatically unlocks the NPI (NoC programming interface) lock
> register before each write, as required by the hardware. The regmap
> is configured with fast_io since the underlying MMIO accessors are
> safe to call from atomic context.
>=20
> Co-developed-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> Signed-off-by: Salih Erim <salih.erim@amd.com>

Various comments inline.


> ---
> Changes in v3:
>   - IWYU: add array_size.h, string.h, types.h to core; audit and
>     fix header and MMIO driver includes (Andy)
>   - Rename _ext to _name in SYSMON_CHAN_TEMP macro parameter (Andy,
>     Jonathan)
>   - Use .info_mask_separate =3D BIT() style in SYSMON_CHAN_TEMP (Andy)
>   - Use s16 parameter in sysmon_q8p7_to_millicelsius (Andy)
>   - Use sign_extend32() in sysmon_supply_rawtoprocessed (Andy)
>   - Split sysmon_read_raw parameters logically across lines (Andy)
>   - Remove redundant (int) casts on regval (Andy)
>   - Split num_supply/num_temp initialization (Andy)
>   - Use __free(fwnode_handle) cleanup, remove goto err_put (Andy)
>   - Use size_add() for overflow-safe allocation (Andy)
>   - Use dev_err_probe() in sysmon_parse_fw error paths (Jonathan)
>   - Move fwnode_irq_get() to core_probe, remove irq parameter
>     from bus driver interfaces (Jonathan)
>   - Use (int)MILLI at call sites, drop SYSMON_MILLI define (Andy,
>     Jonathan)
>   - Remove sysmon->dev, sysmon->indio_dev, sysmon->irq from struct;
>     pass as local variables or use regmap_get_device() (Jonathan)
>   - Use struct device *dev local in sysmon_platform_probe (Andy)
>   - Describe protected data in lock comment (Jonathan)
>   - Add comment explaining RAW+PROCESSED co-exposure (Jonathan)

Looking at this again, I'm thinking we don't need them both.
In particular it makes it ambiguous for what scaling of events is
so best to use one or the other.

>=20
> Changes in v2:
>   - Split into core (versal-sysmon-core.c) + MMIO platform driver
>     (versal-sysmon.c) + shared header (versal-sysmon.h)
>   - Uses regmap API instead of direct readl/writel
>   - MMIO regmap uses custom callbacks with NPI unlock in write path
>   - Reverse Christmas Tree variable ordering throughout
>   - Header include order fixed
>   - MAINTAINERS entry folded in with wildcard F: pattern
>   - Kconfig: hidden VERSAL_SYSMON_CORE + VERSAL_SYSMON selects it
>   - Kconfig/Makefile: alphabetical ordering (VERSAL before VF610)
>   - Bounds validation on DT reg values
>   - Named constants replace magic numbers (SYSMON_REG_STRIDE,
>     SYSMON_SUPPLY_MANTISSA_BITS, SYSMON_MILLI)
>   - kernel-doc for exported sysmon_core_probe() and sysmon_parse_fw()
>   - Supply voltage conversion uses proper two's complement sign
>     extension (s16 cast) matching the hardware specification
>   - Register offsets sorted by address in header
>   - Each patch introduces only the defines, fields, and includes
>     it uses (no dead code in any commit)
>   - Removed unused linux/limits.h and linux/units.h includes
>   - Renamed iio_dev_info to sysmon_iio_info
>   - regmap_write return values checked in probe init path

> diff --git a/drivers/iio/adc/versal-sysmon-core.c b/drivers/iio/adc/versa=
l-sysmon-core.c
> new file mode 100644
> index 00000000000..ebe052f6982
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon-core.c
> @@ -0,0 +1,311 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Versal SysMon core driver
> + *
> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/cleanup.h>
> +#include <linux/device.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regmap.h>
> +#include <linux/string.h>
> +#include <linux/sysfs.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "versal-sysmon.h"
> +
> +/*
> + * Both RAW and PROCESSED are exposed: RAW is needed for event thresholds
> + * (which operate in hardware register format), PROCESSED gives userspace
> + * the converted millivolt or millicelsius value.
The conversion seems to be linear.  So you should be providing _SCALE and
maybe _OFFSET to let the users work out any necessary conversion.

I don't yet see a reason to provide PROCESSED for this channel type.

> + */
> +#define SYSMON_CHAN_TEMP(_chan, _address, _name) {		\
> +	.type =3D IIO_TEMP,					\
> +	.indexed =3D 1,						\
> +	.address =3D _address,					\
> +	.channel =3D _chan,					\
> +	.info_mask_separate =3D					\
> +		BIT(IIO_CHAN_INFO_RAW) |				\
> +		BIT(IIO_CHAN_INFO_PROCESSED),			\
> +	.scan_type =3D {						\

This is mainly there for buffered interfaces (chardev) but I don't think
you yet support that so drop it.

> +		.sign =3D 's',					\
> +		.realbits =3D 15,					\
> +		.storagebits =3D 16,				\
> +		.endianness =3D IIO_CPU,				\
> +	},							\
> +	.datasheet_name =3D _name,				\
> +}
> +
> +/* Static temperature channels (always present) */
> +static const struct iio_chan_spec temp_channels[] =3D {
> +	SYSMON_CHAN_TEMP(0, SYSMON_TEMP_MAX, "temp"),
> +	SYSMON_CHAN_TEMP(1, SYSMON_TEMP_MIN, "min"),
> +	SYSMON_CHAN_TEMP(2, SYSMON_TEMP_MAX_MAX, "max_max"),
> +	SYSMON_CHAN_TEMP(3, SYSMON_TEMP_MIN_MIN, "min_min"),
> +};
> +
> +static void sysmon_q8p7_to_millicelsius(s16 raw_data, int *val)
> +{
> +	*val =3D (raw_data * (int)MILLI) >> SYSMON_FRACTIONAL_SHIFT;

That's a very simple linear scaling so provide _RAW and get rid of this.

> +}
> +
> +static void sysmon_supply_rawtoprocessed(int raw_data, int *val)
> +{
> +	int mantissa, format, exponent;
> +
> +	mantissa =3D FIELD_GET(SYSMON_MANTISSA_MASK, raw_data);
> +	exponent =3D SYSMON_SUPPLY_MANTISSA_BITS - FIELD_GET(SYSMON_MODE_MASK, =
raw_data);
> +	format =3D FIELD_GET(SYSMON_FMT_MASK, raw_data);
> +	/*
> +	 * When format bit is set the mantissa is two's complement
> +	 * (per hardware spec); sign-extend to int for correct arithmetic.
> +	 */
> +	if (format)
> +		mantissa =3D sign_extend32(mantissa, 15);
> +
> +	*val =3D (mantissa * (int)MILLI) >> exponent;
> +}


> +
> +/**
> + * sysmon_parse_fw() - Parse firmware nodes and configure IIO channels.
> + * @indio_dev: IIO device instance
> + * @dev: Parent device
> + *
> + * Reads voltage-channels and temperature-channels container nodes from
> + * firmware and builds the IIO channel array. Static temperature channels
> + * are prepended, followed by supply and satellite channels from DT.
> + *
> + * Return: 0 on success, negative errno on failure.
> + */
> +static int sysmon_parse_fw(struct iio_dev *indio_dev, struct device *dev)
> +{
> +	struct fwnode_handle *supply_node __free(fwnode_handle) =3D
> +		device_get_named_child_node(dev, "voltage-channels");
> +	struct fwnode_handle *temp_node __free(fwnode_handle) =3D
> +		device_get_named_child_node(dev, "temperature-channels");

Move these down to just above each check. Note that when using __free()
it is fine not to have all declarations at the top.

> +	unsigned int num_supply =3D 0, num_temp =3D 0;
> +	unsigned int idx, temp_chan_idx, volt_chan_idx;
> +	struct iio_chan_spec *sysmon_channels;
> +	const char *label;
> +	u32 reg;
> +	int ret;
> +
	struct fwnode_handle *supply_node __free(fwnode_handle) =3D
		device_get_named_child_node(dev, "voltage-channels");
	if (supply_node)
> +	if (supply_node)
> +		num_supply =3D fwnode_get_child_node_count(supply_node);
	struct fwnode_handle *temp_node __free(fwnode_handle) =3D
		device_get_named_child_node(dev, "temperature-channels");
	if (temp_node)

> +	if (temp_node)
> +		num_temp =3D fwnode_get_child_node_count(temp_node);
> +
> +	sysmon_channels =3D devm_kcalloc(dev,
> +				       size_add(ARRAY_SIZE(temp_channels),
> +						num_supply + num_temp),
> +				       sizeof(*sysmon_channels), GFP_KERNEL);
> +	if (!sysmon_channels)
> +		return -ENOMEM;
> +
> +	/* Static temperature channels first (fixed indices) */
> +	idx =3D 0;
> +	memcpy(sysmon_channels, temp_channels, sizeof(temp_channels));
> +	idx +=3D ARRAY_SIZE(temp_channels);
> +
> +	/* Supply channels from DT */
> +	fwnode_for_each_child_node_scoped(supply_node, child) {
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "missing reg for supply channel\n");
> +
> +		if (reg > SYSMON_SUPPLY_IDX_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "supply reg %u exceeds max %u\n",
> +					     reg, SYSMON_SUPPLY_IDX_MAX);
> +
> +		ret =3D fwnode_property_read_string(child, "label", &label);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "missing label for supply channel\n");
> +
> +		sysmon_channels[idx++] =3D (struct iio_chan_spec) {
> +			.type =3D IIO_VOLTAGE,
> +			.indexed =3D 1,
> +			.address =3D reg,
> +			.info_mask_separate =3D
> +				BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_PROCESSED),
Add a similar comment to the one you have for temperature channels here.
This is tricky because I have no idea how a user would set a floating point
threshold via raw.  Their expectation is that is simple and linear.

How hard is it to take a _PROCESSED event value and convert it back to
a format that can be used for setting the register values? To me that
seems like a much more intuitive interface

=46rom a quick look at the event patch it seems you are doing that? In which =
case drop raw.

> +			.scan_type =3D {
> +				.realbits =3D 19,
> +				.storagebits =3D 32,
> +				.endianness =3D IIO_CPU,
> +				.sign =3D fwnode_property_read_bool(child,
> +					"bipolar") ? 's' : 'u',

As above, this only gets exposed when buffered interfaces are added, so for
now don't set it unless you are using them for some internal purposes.
Also .sign is being replace with .format.

> +			},
> +			.datasheet_name =3D label,
> +		};
> +	}
> +
> +	/* Temperature satellite channels from DT */
> +	fwnode_for_each_child_node_scoped(temp_node, child) {
> +		ret =3D fwnode_property_read_u32(child, "reg", &reg);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "missing reg for temp channel\n");
> +
> +		if (reg < 1 || reg > SYSMON_TEMP_SAT_MAX)
> +			return dev_err_probe(dev, -EINVAL,
> +					     "temp reg %u out of range [1..%u]\n",
> +					     reg, SYSMON_TEMP_SAT_MAX);
> +
> +		ret =3D fwnode_property_read_string(child, "label", &label);
> +		if (ret < 0)
> +			return dev_err_probe(dev, ret,
> +					     "missing label for temp channel\n");
> +
> +		sysmon_channels[idx++] =3D (struct iio_chan_spec) {
> +			.type =3D IIO_TEMP,
> +			.indexed =3D 1,
> +			.address =3D SYSMON_TEMP_SAT_BASE +
> +				   ((reg - 1) * SYSMON_REG_STRIDE),
> +			.info_mask_separate =3D
> +				BIT(IIO_CHAN_INFO_RAW) |
> +				BIT(IIO_CHAN_INFO_PROCESSED),

As above, add a comment on why both (or drop one of them)

> +			.scan_type =3D {
> +				.sign =3D 's',
> +				.realbits =3D 15,
> +				.storagebits =3D 16,
> +				.endianness =3D IIO_CPU,
> +			},
> +			.datasheet_name =3D label,
> +		};
> +	}
> +
> +	indio_dev->num_channels =3D idx;
> +	indio_dev->info =3D &sysmon_iio_info;
> +
> +	/*
> +	 * Assign per-type sequential channel numbers.
> +	 * IIO sysfs uses type prefix (in_tempN, in_voltageN)
> +	 * so numbers only need to be unique within each type.
> +	 */
> +	temp_chan_idx =3D 0;
> +	volt_chan_idx =3D 0;
> +	for (idx =3D 0; idx < indio_dev->num_channels; idx++) {
> +		if (sysmon_channels[idx].type =3D=3D IIO_TEMP)
> +			sysmon_channels[idx].channel =3D temp_chan_idx++;
> +		else
> +			sysmon_channels[idx].channel =3D volt_chan_idx++;
> +	}
> +
> +	indio_dev->channels =3D sysmon_channels;
> +
> +	return 0;
> +}

> diff --git a/drivers/iio/adc/versal-sysmon.c b/drivers/iio/adc/versal-sys=
mon.c
> new file mode 100644
> index 00000000000..8473288e7db
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon.c
> @@ -0,0 +1,92 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * AMD Versal SysMon MMIO platform driver
> + *
> + * Copyright (C) 2019 - 2022, Xilinx, Inc.
> + * Copyright (C) 2022 - 2026, Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/io.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/regmap.h>
> +
> +#include "versal-sysmon.h"
> +
> +struct sysmon_mmio {
> +	void __iomem *base;
> +};
> +
> +static int sysmon_mmio_reg_read(void *context, unsigned int reg,
> +				unsigned int *val)
> +{
> +	struct sysmon_mmio *mmio =3D context;
> +
> +	*val =3D readl(mmio->base + reg);

Blank line before simple returns slightly helps readabilty.

> +	return 0;
> +}

> +static int sysmon_platform_probe(struct platform_device *pdev)
> +{
> +	struct device *dev =3D &pdev->dev;
> +	struct sysmon_mmio *mmio;
> +	struct regmap *regmap;
> +
> +	mmio =3D devm_kzalloc(dev, sizeof(*mmio), GFP_KERNEL);
> +	if (!mmio)
> +		return -ENOMEM;
> +
> +	mmio->base =3D devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(mmio->base))
> +		return PTR_ERR(mmio->base);
> +
> +	regmap =3D devm_regmap_init(dev, NULL, mmio,
> +				  &sysmon_mmio_regmap_config);

Fits on one line I think even with a strict 80 char limit (which we relax
when readabilty is hurt)

> +	if (IS_ERR(regmap))
> +		return PTR_ERR(regmap);
> +
> +	return sysmon_core_probe(dev, regmap);
> +}

> diff --git a/drivers/iio/adc/versal-sysmon.h b/drivers/iio/adc/versal-sys=
mon.h
> new file mode 100644
> index 00000000000..d24d2481915
> --- /dev/null
> +++ b/drivers/iio/adc/versal-sysmon.h

...

> +
> +/* Q8.7 fractional shift */
> +#define SYSMON_FRACTIONAL_SHIFT		7U

This should perhaps be a mask then use FIELD_GET() to extract the value.

> +#define SYSMON_SUPPLY_MANTISSA_BITS	16
> +
> +/**
> + * struct sysmon - Driver data for Versal SysMon
> + * @regmap: register map for hardware access
> + * @lock: protects regmap access
> + */
> +struct sysmon {
> +	struct regmap *regmap;
> +	/* Protects regmap access */

regmap has it's own internal locks. So this comment needs to explain
in more detail what is being protected.  I assume read modify write
or long related sequences that must not be interrupted and aren't encapsula=
ted
in single regmap calls?

> +	struct mutex lock;
> +};

