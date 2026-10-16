Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DBC029D288;
	Fri, 16 Oct 2026 23:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792194014; cv=none; b=CNNHijDBN4/QZiV/g/pd9z4iYKwKA2shpw9iNbkJpqNEOLdW++feGKvWji0azlo+Bf6rUjJIczowgIb3qfUVR/vdqx+AuBJxBou9okuI73xOcBCLYL8HJzDqHZZbMtWenD6r3uNy4yB4q4fEFTQPTScpoHzjzXhjz39l1ItYlDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792194014; c=relaxed/simple;
	bh=mMy3W05UXKnHb4r9nb9OPrFeIhJO5K7bx9bvBtTU7zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q8KePXB/J2YyHhYhuXQ8fbfctv0DJieB2rs08FAu3cKHHr5X0QaVcYddENDvI1VDqG2nTEOQ/biOhMVR88zp0hpyPP0W+iglsp2nz96qUU+VyLm3axvnUrQ2ZpWJafqHxMGSuwtqll6m4qxTxkUPCtJjGZ4oaeYP5ztVZZKx2TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ELXK+tV+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ELXK+tV+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6061F000C4;
	Fri, 16 Oct 2026 23:40:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792194012;
	bh=sJ8wbFJE05+CFEL/C8dQE7zRFNsJBr8HlAPU8xGN3Qk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ELXK+tV+kjCSs6KJivZM7LlmS8gR8ejlcEnJVrFAYBu3hcOGxWkqke6tKRIAqhU6q
	 VWy+XUqBTy+MYiHtrZtDIXEK79U/6qMCb7FWpsUWm+1i+LnkaDS/2FOYWUO+N2v7LL
	 1BVj5nGr7Z2r/4KxGSRL3/jIKuIKcGFcAPoHvRnzn8PNeTcnwvt/7yyKIF512+djqG
	 nTWORjwseYBajVaTqyMxkfvD/gDbDIi72v6vWHZ2iIjFB6YbNypvFi8bpswOhwPIR2
	 pr040OJBHnu03batDCp8AWSK8w3DeWgJfehYfo5x72aMWl9/Jwumo+5GXC+ntgAODV
	 dTgNuumIrALKQ==
Date: Sat, 17 Oct 2026 00:40:05 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Bruce Tsao via B4 Relay <devnull+bruce.tsao.analog.com@kernel.org>
Cc: bruce.tsao@analog.com, linux-iio@vger.kernel.org, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: dac: add AD5413 driver
Message-ID: <20261017004005.126db7ae@jic23-hlaptop>
In-Reply-To: <20261017-ad5413-upstream-v1-2-61f40c8fef25@analog.com>
References: <20261017-ad5413-upstream-v1-0-61f40c8fef25@analog.com>
	<20261017-ad5413-upstream-v1-2-61f40c8fef25@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sat, 17 Oct 2026 03:23:54 +0800
Bruce Tsao via B4 Relay <devnull+bruce.tsao.analog.com@kernel.org> wrote:

> From: Bruce Tsao <bruce.tsao@analog.com>
>=20
> The AD5413 is a single-channel, 14-bit, voltage and current output
> digital-to-analog converter (DAC) with programmable output ranges,
> slew rate control and on-chip diagnostics.
>=20
> Add an IIO driver supporting the +-10.5 V voltage range and the
> 0-24 mA current range, output enable, slew rate control and device
> reset over the SPI interface.
>=20
> The device powers up with the SPI CRC enabled, so every frame carries
> a CRC-8 byte and the interface is configured for SPI mode 1. This lets
> the driver bring the device up directly from a cold boot without any
> pre-conditioning.
>=20
> Signed-off-by: Bruce Tsao <bruce.tsao@analog.com>
Hi Bruce

Good state for a v1.  Main thing in my feedback is take
another look at the endian conversions. It think those
have evolved into being way more complex than they need to be.

Jonathan

> diff --git a/drivers/iio/dac/ad5413.c b/drivers/iio/dac/ad5413.c
> new file mode 100644
> index 000000000000..96cce32fc640
> --- /dev/null
> +++ b/drivers/iio/dac/ad5413.c
> @@ -0,0 +1,666 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * AD5413 Digital to analog converters driver
> + *
> + * Copyright 2026 Analog Devices Inc.
> + */
> +#include <linux/bitfield.h>
> +#include <linux/crc8.h>
> +#include <linux/delay.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iopoll.h>
> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/property.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/reset.h>
> +#include <linux/spi/spi.h>
> +#include <linux/units.h>
> +#include <linux/util_macros.h>
> +
> +/* AD5413 registers definition */
> +#define AD5413_REG_NOP 0x00
> +#define AD5413_REG_DAC_INPUT 0x01
> +#define AD5413_REG_DAC_OUTPUT 0x02
> +#define AD5413_REG_CLEAR_CODE 0x03
> +#define AD5413_REG_USER_GAIN 0x04
> +#define AD5413_REG_USER_OFFSET 0x05
> +#define AD5413_REG_DAC_CONFIG 0x06
> +#define AD5413_REG_DAC_CONFIG_SR_STEP_MSK GENMASK(15, 13)
Mixing fields and register defines can make for hard reading. I sugest
using a bit of indenting to make them visually different.
#define AD5413_REG_DAC_CONFIG 0x06
#define   AD5413_REG_DAC_CONFIG_SR_STEP_MSK GENMASK(15, 13)
#define   AD5413_REG_DAC_CONFIG_SR_CLOCK_MSK GENMASK(12, 9)
#define   AD5413_REG_DAC_CONFIG_SR_EN_MSK BIT(8)
#define   AD5413_REG_DAC_CONFIG_RSET_EXT_EN_MSK BIT(7)
#define   AD5413_REG_DAC_CONFIG_OUT_EN_MSK BIT(6)
#define   AD5413_REG_DAC_CONFIG_INT_EN_MSK BIT(5)
#define   AD5413_REG_DAC_CONFIG_OVRNG_EN_MSK BIT(4)
#define   AD5413_REG_DAC_CONFIG_RANGE_MSK GENMASK(3, 0)
define AD5413_REG_SW_LDAC 0x07

etc. If you have values of fields defined, then indent them
even further.

> +#define AD5413_REG_DAC_CONFIG_SR_CLOCK_MSK GENMASK(12, 9)
> +#define AD5413_REG_DAC_CONFIG_SR_EN_MSK BIT(8)
> +#define AD5413_REG_DAC_CONFIG_RSET_EXT_EN_MSK BIT(7)
> +#define AD5413_REG_DAC_CONFIG_OUT_EN_MSK BIT(6)
> +#define AD5413_REG_DAC_CONFIG_INT_EN_MSK BIT(5)
> +#define AD5413_REG_DAC_CONFIG_OVRNG_EN_MSK BIT(4)
> +#define AD5413_REG_DAC_CONFIG_RANGE_MSK GENMASK(3, 0)
> +#define AD5413_REG_SW_LDAC 0x07
> +#define AD5413_REG_KEY 0x08
> +#define AD5413_REG_KEY_REG_ADDR_MASK GENMASK(20, 16)
> +#define AD5413_REG_KEY_CODE_MASK GENMASK(15, 0)
> +#define AD5413_REG_GP_CONFIG1 0x09
> +#define AD5413_REG_GP_CONFIG2 0x0A
> +#define AD5413_REG_DIGITAL_DIAG_CONFIG 0x10
> +#define AD5413_REG_FAULT_PIN_CONFIG 0x12
> +#define AD5413_REG_TWO_STAGE_READBACK_SELECT 0x13
> +#define AD5413_REG_DIGITAL_DIAG_RESULTS 0x14
> +#define AD5413_REG_DIGITAL_DIAG_CAL_MEM_UNREFRESHED_MSK BIT(15)
> +#define AD5413_REG_DIGITAL_DIAG_SLEW_BUSY_MSK BIT(14)
> +#define AD5413_REG_ANALOG_DIAG_RESULTS 0x15
> +#define AD5413_REG_STATUS 0x16
> +#define AD5413_REG_CHIP_ID 0x17
> +#define AD5413_REG_FREQ_MONITOR 0x18
> +#define AD5413_REG_DEVICE_ID_3 0x1C
> +
> +/* Special Key Codes (bits[15:0]) */
> +#define AD5413_REG_KEY_CODE_RESET_1 0x15FA
> +#define AD5413_REG_KEY_CODE_RESET_2 0xAF51
> +#define AD5413_REG_KEY_CODE_CALIB_MEM_REFRESH 0xFCBA
> +
> +/* DIGITAL_DIAG_RESULTS Register (Addr =3D 0x14) Busy Flags */
> +
> +#define AD5413_WR_FLAG_MSK(x) (0x80u | ((x) & 0x1F))
> +
> +/* CRC-8 polynomial x^8 + x^2 + x + 1, enabled by default on the device =
*/
> +#define AD5413_CRC8_POLY 0x07
> +
> +#define AD5413_FULL_SCALE_MICRO (16383ULL * MICRO)
> +
> +struct ad5413_range {
> +	int reg;
> +	int min;
> +	int max;
> +};
> +
> +struct ad5413_state {
> +	struct spi_device *spi;
> +	struct regulator_bulk_data supplies[3];
> +	struct mutex lock; /* Protects all register access via SPI */

Not necessary to protect data accesses in general as spi will do that.
The point you want to make is about rmw sequences.

> +	const struct ad5413_range *out_range;
> +	unsigned int slew_time;
> +	bool pwr_down;
> +	u8 crc8_tbl[CRC8_TABLE_SIZE];
> +	__be32 d32[3] __aligned(IIO_DMA_MINALIGN);

As below. I'd throw in a d8 array to simplify the data mangling.

> +};
> +
> +/*
> + * Output ranges corresponding to DAC_CONFIG[3:0] bits.
> + * Defined by the following symbolic identifiers:
> + *   AD5413_RANGE_PLUSMINUS_10_5V - =C2=B110.5 V voltage range
> + *   AD5413_RANGE_0MA_24MA        - 0 mA to 24 mA current range
> + */
> +enum ad5413_output_range {
> +	AD5413_RANGE_PLUSMINUS_10_5V =3D 0x3,
> +	AD5413_RANGE_0MA_24MA =3D 0x9,
> +};
> +
> +static const struct ad5413_range ad5413_voltage_range[] =3D { {

Given only one element, why the array?

> +	.reg =3D AD5413_RANGE_PLUSMINUS_10_5V,
> +	.min =3D -10500000,
> +	.max =3D 10500000,
> +} };
> +
> +static const struct ad5413_range ad5413_current_range[] =3D { {

Same on this one.

> +	.reg =3D AD5413_RANGE_0MA_24MA,
> +	.min =3D 0,
> +	.max =3D 24000,
> +} };

> +static int ad5413_spi_reg_read(struct ad5413_state *st, unsigned int add=
r,
> +			       u16 *val)
> +{
> +	struct spi_transfer t[] =3D {
> +		{
> +			.tx_buf =3D &st->d32[0],
> +			.len =3D 4,
> +			.cs_change =3D 1,
> +		},
> +		{
> +			.tx_buf =3D &st->d32[1],
> +			.rx_buf =3D &st->d32[2],
> +			.len =3D 4,
> +		},
> +	};
> +	u8 sel[3], nop[3];
> +	int ret;
> +
> +	/* Two-stage readback: select the register to read back. */
> +	sel[0] =3D AD5413_WR_FLAG_MSK(AD5413_REG_TWO_STAGE_READBACK_SELECT);
> +	sel[1] =3D 0;
> +	sel[2] =3D addr;
> +	st->d32[0] =3D cpu_to_be32((sel[0] << 24) | (sel[1] << 16) |
> +				 (sel[2] << 8) |
> +				 crc8(st->crc8_tbl, sel, sizeof(sel), 0));

See below. I suspect similarly overly complicated endian dance.

> +
> +	/* NOP frame clocks the selected register contents out on SDO. */
> +	nop[0] =3D AD5413_WR_FLAG_MSK(AD5413_REG_NOP);
> +	nop[1] =3D 0;
> +	nop[2] =3D 0;
> +	st->d32[1] =3D cpu_to_be32((nop[0] << 24) | (nop[1] << 16) |
> +				 (nop[2] << 8) |
> +				 crc8(st->crc8_tbl, nop, sizeof(nop), 0));
> +
> +	ret =3D spi_sync_transfer(st->spi, t, ARRAY_SIZE(t));
> +	if (ret < 0)
> +		return ret;
> +
> +	/*
> +	 * The readback CRC covers the live FAULT pin status bit, which can
> +	 * toggle between capture and clock-out, so it is not validated here.
> +	 */
> +	*val =3D be32_to_cpu(st->d32[2]) >> 8;
> +
> +	return 0;
> +}
> +
> +static int ad5413_spi_reg_write(struct ad5413_state *st, unsigned int ad=
dr,
> +				unsigned int val)
> +{
> +	u8 buf[3] =3D { };
	u8 buf[3] =3D {
		[0] =3D AD...

> +
> +	buf[0] =3D AD5413_WR_FLAG_MSK(addr);
> +	buf[1] =3D val >> 8;
> +	buf[2] =3D val;

This is fun as that's a put_unaligned_be16 which you then do
another endian swap on.

> +
> +	st->d32[0] =3D cpu_to_be32((buf[0] << 24) | (buf[1] << 16) |
> +				 (buf[2] << 8) |

Ok. I'm lost.

In both cass we start with
	buf[0] =3D AD5413_WR_FLAG_MSK(addr),
	buf[1] =3D (val >> 8) & 0xff;
	buf[2] =3D val & 0xff;

Then you build a native endian integer. So on a little endian cpu that means
=09
	v[0] =3D crc8(buf..)
	v[1] =3D val & 0xff;
	v[2] =3D (val >> 8) & 0xff;
	v[3] =3D AD5413_WR_FLAG_MSK(addr)

	d32 is that swapped (pretend it's u8 array)
	d32[0] =3D AD5413_WR_FLAG_MSK(addr);
	d32[1] =3D (val >> 8) & 0xff;
	d32[2] =3D  val & 0xff;
	d32[3] =3D crc8(buf..)

on a big endian
	v[0] =3D AD5413_WR_FLAG_MSK(addr)
	v[1] =3D (val >> 8) & 0xff;
	v[2] =3D val & 0xff;
	v[3] =3D crc8(buf..)
d32 is not swapped. (again pretend u8 array
	d32[0] =3D AD5413_WR_FLAG_MSK(addr);
	d32[1] =3D (val >> 8) & 0xff;
	d32[2] =3D  val & 0xff;
	d32[3] =3D crc8(buf..)
(snap which is good).

Fun bit, is the 3 bytes are right for computing the crc8 so... This is all
equivalent of:
static int ad5413_spi_reg_write(struct ad5413_state *st, unsigned int addr,
				unsigned int val)
{
	st->d8[0] =3D AD5413_WR_FLAG_MSK(addr);
	put_unaligned_be16(&st->d8[1], val);
	st->d8[3] =3D crc8(st->crc8_tbl, buf, 3, 0);

	return spi_write(st->spi, st->d8, sizeof(st->d8));
}
As long as you have a st->d8[4] array to use (and I didn't unwind
that all incorrectly).

> +				 crc8(st->crc8_tbl, buf, sizeof(buf), 0));
> +
> +	return spi_write(st->spi, &st->d32[0], sizeof(st->d32[0]));
> +}
> +
> +static int ad5413_spi_write_mask(struct ad5413_state *st, unsigned int a=
ddr,
> +				 unsigned long mask, unsigned int val)
> +{
> +	u16 regval;
> +	int ret;
> +
> +	ret =3D ad5413_spi_reg_read(st, addr, &regval);
> +	if (ret)
> +		return ret;
> +
> +	return ad5413_spi_reg_write(st, addr, (regval & ~mask) | val);
> +}


> +
> +static int ad5413_slew_rate_config(struct ad5413_state *st)
> +{
> +	unsigned int sr_clk_idx =3D 0, sr_step_idx =3D 0;
> +	int i, res;
> +	s64 diff_new, diff_old =3D S64_MAX;
> +	u64 sr_step, calc_slew_time;
> +
> +	/*
> +	 * The slew time can be determined by using the formula:
> +	 * Slew Time =3D (Full Scale Out / (Step Size x Update Clk Freq))
> +	 * where Slew time is expressed in microseconds
> +	 * Given the desired slew time, the following algorithm determines the
> +	 * best match for the step size and the update clock frequency.
> +	 */
> +	for (i =3D 0; i < ARRAY_SIZE(ad5413_sr_clk); i++) {

	for (int i =3D 0;

is acceptable these days and makes the scope explicit.

> +		/*
> +		 * Go through each valid update clock freq and determine a raw
> +		 * value for the step size by using the formula:
> +		 * Step Size =3D Full Scale Out / (Update Clk Freq * Slew Time)
> +		 */
> +		sr_step =3D div64_u64(AD5413_FULL_SCALE_MICRO,
> +				    (u64)ad5413_sr_clk[i] * st->slew_time);
> +		/*
> +		 * After a raw value for step size was determined, find the
> +		 * closest valid match
> +		 */
> +		res =3D find_closest(sr_step, ad5413_sr_step, ARRAY_SIZE(ad5413_sr_ste=
p));
> +
> +		/* Calculate the slew time */
> +		calc_slew_time =3D div_u64(AD5413_FULL_SCALE_MICRO,
> +					 ad5413_sr_step[res] * ad5413_sr_clk[i]);
> +		/*
> +		 * Determine with how many microseconds the calculated slew time
> +		 * is different from the desired slew time and store the diff
> +		 * for the next iteration
> +		 */
> +		diff_new =3D abs(st->slew_time - calc_slew_time);
> +		if (diff_new < diff_old) {
> +			diff_old =3D diff_new;
> +			sr_clk_idx =3D i;
> +			sr_step_idx =3D res;
> +		}
> +	}
> +
> +	return ad5413_slew_rate_set(st, sr_clk_idx, sr_step_idx);
> +}

> +
> +static int ad5413_internal_buffers_en(struct ad5413_state *st, bool enab=
le)
> +{
> +	int ret;
> +
> +	ret =3D ad5413_spi_write_mask(st,
> +				    AD5413_REG_DAC_CONFIG,
> +				    AD5413_REG_DAC_CONFIG_INT_EN_MSK,
> +				    FIELD_PREP(AD5413_REG_DAC_CONFIG_INT_EN_MSK,
> +					       enable));
> +	if (ret < 0)
> +		return ret;
I'd not expect a function with that name to return > 0 so perhaps
just if (ret)?

> +
> +	/* Wait to allow time for the internal calibrations to complete */

The function name and parameters are probably clear enough that you can
drop the comment.

> +	return ad5413_wait_for_task_complete(st,
> +					     AD5413_REG_DIGITAL_DIAG_RESULTS,
> +					     AD5413_REG_DIGITAL_DIAG_CAL_MEM_UNREFRESHED_MSK);
> +}

> +static int ad5413_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan, int *val,
> +			   int *val2, long info)
> +{
> +	struct ad5413_state *st =3D iio_priv(indio_dev);
> +	int max, min, ret;
> +	u16 regval;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->lock);
> +		ret =3D ad5413_spi_reg_read(st, AD5413_REG_DAC_INPUT, &regval);
> +		if (ret)
> +			return ret;
> +
> +		/* 14-bit DAC data is in bits [15:2] of the register. */
> +		*val =3D regval >> 2;
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SCALE:
> +		min =3D st->out_range->min;
> +		max =3D st->out_range->max;
> +		*val =3D (max - min) / 1000;
> +		*val2 =3D 14;
> +		return IIO_VAL_FRACTIONAL_LOG2;
> +	case IIO_CHAN_INFO_OFFSET:
> +		min =3D st->out_range->min;
> +		max =3D st->out_range->max;
> +		*val =3D div_s64((s64)min * BIT(14), max - min);
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad5413_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan, int val, int val2,
> +			    long info)
> +{
> +	struct ad5413_state *st =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&st->lock);
> +		/* 14-bit DAC data is in bits [15:2] of the register. */
> +		ret =3D ad5413_spi_reg_write(st, AD5413_REG_DAC_INPUT, val << 2);
> +		return ret;

		return ad54...

> +	}
> +	default:
> +		return -EINVAL;
> +	}
> +}

> +static ssize_t ad5413_write_powerdown(struct iio_dev *indio_dev, uintptr=
_t priv,
> +				      struct iio_chan_spec const *chan,
> +				      const char *buf, size_t len)
> +{
> +	struct ad5413_state *st =3D iio_priv(indio_dev);
> +	bool pwr_down;
> +	unsigned int dac_config_mode, val;
> +	unsigned long dac_config_msk;

Where nothing else dictates ordering, reverse xmas tree preferred.

> +	int ret;
> +
> +	ret =3D kstrtobool(buf, &pwr_down);
> +	if (ret)
> +		return ret;
> +
> +	val =3D pwr_down ? 0 : 1;
> +
> +	dac_config_mode =3D FIELD_PREP(AD5413_REG_DAC_CONFIG_OUT_EN_MSK, (val))=
 |
> +			  FIELD_PREP(AD5413_REG_DAC_CONFIG_INT_EN_MSK, (val));
> +	dac_config_msk =3D AD5413_REG_DAC_CONFIG_OUT_EN_MSK |
> +			 AD5413_REG_DAC_CONFIG_INT_EN_MSK;
> +
> +	guard(mutex)(&st->lock);
> +	ret =3D ad5413_spi_write_mask(st, AD5413_REG_DAC_CONFIG, dac_config_msk,
> +				    dac_config_mode);
> +	if (ret < 0)
> +		return ret;
> +
> +	st->pwr_down =3D pwr_down;
> +
> +	return len;
> +}

> +static const struct iio_chan_spec ad5413_voltage_ch[] =3D {
> +	AD5413_DAC_CHAN(IIO_VOLTAGE),
> +};
> +
> +static const struct iio_chan_spec ad5413_current_ch[] =3D {
> +	AD5413_DAC_CHAN(IIO_CURRENT),

Why an array?  For these, given you are just copying them in place
maybe use a macro that has (struct iio_chan_spec) { values }
so that you can just have the assignment in code without the
need for these two template arrays.

> +};
> +
> +static int ad5413_parse_fw(struct ad5413_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;
> +
> +	if (device_property_read_bool(dev, "adi,chan-current-mode"))
> +		st->out_range =3D &ad5413_current_range[0];

I ask this above, but it was motivated by this. If there is only
one structure why do we want an array for these?

> +	else
> +		st->out_range =3D &ad5413_voltage_range[0];
> +
> +	st->slew_time =3D 0;
> +	if (device_property_present(dev, "adi,slew-time-us")) {
> +		ret =3D device_property_read_u32(dev,
> +					       "adi,slew-time-us",
> +					       &st->slew_time);
> +		if (ret)
> +			return dev_err_probe(dev, ret, "Failed to read adi,slew-time-us\n");
> +
> +		if (st->slew_time > 1 * MICRO)
> +			return dev_err_probe(dev, -EINVAL, "adi,slew-time-us out of range\n");
> +	}
> +
> +	return 0;
> +}
> +
> +static int ad5413_init(struct ad5413_state *st)
> +{
> +	struct reset_control *reset;
> +	u16 regval;
> +	int ret;
> +
> +	reset =3D devm_reset_control_get_optional_exclusive(&st->spi->dev, NULL=
);
> +	if (IS_ERR(reset))
> +		return PTR_ERR(reset);
> +
> +	if (reset) {
> +		/* Hard reset via the reset controller */
> +		ret =3D reset_control_assert(reset);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(100);

For most sleeps a comment that refers to the datasheet is useful
so if people hit problems in future they understand why the sleeps take
particular values. If the datasheet is uninformative on a particular
value just say something about having found it to work in practice.

> +
> +		ret =3D reset_control_deassert(reset);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(100);
> +	} else {
> +		/*
> +		 * CRC is enabled by default after power-on/reset. The SPI
> +		 * helpers always append the CRC byte, so the device accepts
> +		 * these soft-reset key frames without any bootstrap step.
> +		 */
> +		ret =3D ad5413_spi_reg_write(st, AD5413_REG_KEY,
> +					   AD5413_REG_KEY_CODE_RESET_1);
> +		if (ret)
> +			return ret;
> +
> +		ret =3D ad5413_spi_reg_write(st, AD5413_REG_KEY,
> +					   AD5413_REG_KEY_CODE_RESET_2);
> +		if (ret)
> +			return ret;
> +
> +		fsleep(100);
> +	}
> +
> +	ret =3D ad5413_calib_mem_refresh(st);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ad5413_spi_reg_read(st, AD5413_REG_DIGITAL_DIAG_RESULTS, &regva=
l);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ad5413_spi_reg_write(st, AD5413_REG_DIGITAL_DIAG_RESULTS, regva=
l);

Whilst it doesn't matter in practice, I'd rather this only wrote the write =
1 to clear
bits rather than also writing the read only ones up the top. Acts as docume=
ntation
about what this is doing.

> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D ad5413_set_out_range(st, st->out_range->reg);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (st->slew_time) {
> +		ret =3D ad5413_slew_rate_config(st);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	ret =3D ad5413_internal_buffers_en(st, 1);
> +	if (ret < 0)
> +		return ret;
> +
> +	return ad5413_spi_write_mask(st,
> +				    AD5413_REG_DAC_CONFIG,
> +				    AD5413_REG_DAC_CONFIG_OUT_EN_MSK,
> +				    FIELD_PREP(AD5413_REG_DAC_CONFIG_OUT_EN_MSK, 1));
> +}
}

