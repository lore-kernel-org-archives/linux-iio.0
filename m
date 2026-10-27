Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793111852;
	b=mpSLMC9Idkfs+De2vKmudos31/5fZn4VWdU4EWTKFF2Sr4h4k1ty4wXly5cl4cKLZV1b
	 PhUTmKSR2u1qduFFDdY9Z/rJtJJyVs2W+kPg6N7G1mkdwpdxq2KUnhrV7AlbfgcSOKBbp
	 t2FRp9IbvUqs4+Dhhb/HS/EcMSDA1vpto0BA0k22TWCp9VPjG+zzoLRL8l4S2KwXplfR/
	 CKbfUq+h30CBUvz2ty/OjfFbDzuAahnyk7FmopxY6kpkpDOjXNR6umMxtlhnkF8aWOsAv
	 OzlIihiY701NwNufHcseitMZuZhLb8ChNZZy0pgtU0obCj/zbioYZ5i7CHELEwqyCAQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111852;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NMImbodtkJkJh1MOcuRbaVEWTAwXNEwUi7aWVqU7WBI=;
	b=DMI/x/N+oYWmvlgQG628YQ8Lzg8mT4ygY3C7KxPf0eSC66A5eEgSP18XRGk1c0SsAm63
	 sz7qxFK20B9OylEglUUyHmon/eab5XWodngwX9xpzpod9/3jYHL4wUTpPpWt3zwIO9gAB
	 hHTF7q+rDToi2joLMtpg5+6Lo9qpSuoyxA8rBubsn7ZNSss3vIKJkmN5R0VmErZI2Y6SS
	 5lDu8kvI0oumHSjb5Hq9Kmpvgs7QcXN4Qms22RvFRwgQ56qGidkHvSjou+3s/0UL8feZF
	 VFNWQaTQjaPMggXnpED3anzh/hAp3zXzJLUenpCaLRq6Z0TjvCOv9KpcKbSHA9VYxrA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyKQb0iy;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A953C606A31D;
	Tue, 27 Oct 2026 14:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IyKQb0iy
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=90.182.112.124
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793111851;
	b=AwXOdctHJXQ/oUR1JXMSuBVdwuyrK2qzpGNTK17R1AgtLDL4NXDiHesd8L8ELp1GeeFC
	 FZ2/rHc4CbKxWXJzvgL6y3Cb9ftk6uD+iSsRbfVJqKIkk6wXz1MkagjXcsPijuDnYVBAp
	 IwmLsy78Fz/NMooplVi3TnXst26xLEiaeGFHPvoVIfgW9Fs/O0FbhzPbgQ/WlP8A1ms6f
	 jQZEtFaGsLAOyfSjprJeqWrLb6IYPq70wSd6tjQ8kCfg1CATNIU9NNX+jrm0j2y6pExdK
	 MigPHD15XT4FfXb0B25QvL4jbJI1cdUUdRnJQZfra4gobRELpAX2wHtDpaskq/Fps4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793111851;
	h=DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
	 References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NMImbodtkJkJh1MOcuRbaVEWTAwXNEwUi7aWVqU7WBI=;
	b=ELFbFwnYAnYXDERa7iyf0OCK708//rYBUAJIm9/BkpDriNmOs9N0gDAQEVTIvLN50ECE
	 1L7TzzUMjf82dMN3oygrPDXuMBiHejesfZ8jZTekaBz0PfWuCpyVtv6uI9waqGUQwyzp6
	 FM7aaTpjWs7XF3NWo1Th/dvGp+Jz5ZwM6MnO8nMARWyK+k9eDzgtHYHWFLvky487/3tld
	 v7+TfZRR2mMv2OBWGrqXsmWdSL5e72xLDuvWiO+42nE+FfnLmwDjjM+kjipacVP3yfRGx
	 U/nEz/qktU/7+rxjH6bWxNQuAiUP4D8+bqH1XRipn36enl+ne1oMqLOOtxOc9SAH0QQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=90.182.112.124
Received: from localhost (90-182-112-124.rcp.o2.cz [90.182.112.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPSA id 3E5571F01829;
	Tue, 27 Oct 2026 14:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111851;
	bh=NMImbodtkJkJh1MOcuRbaVEWTAwXNEwUi7aWVqU7WBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=IyKQb0iyKSDfYMT0RltEAcUJLHPltJvuIiCZgOhJ++6cje0ODzwRSHnk6Lj5/bK+g
	 +kV7CET6neNfrhn62LzWB0eZaxoQN2Dldn6bZAHhCu/674KufhHGBSvwFq8bF1kxRG
	 nyDHAKv2acO9vdHRBi36hZPZH3IZdnsSQ2blpriwMv8kKwwC/LoCCtunogEmeu+aGX
	 jQoWiugunmV2TgbVrdYysEJbXH4upWzT2yRSALOf0z2nSebI9rROxCpG53lszpVJwa
	 M4/aTSZ+J4C0TFXfoh5KyExCIxs6Thb5SabTMXXeYL+7LOaH2jHtq3SWO7rmuWrMVU
	 0cy+xrV6AS+Jw==
Date: Tue, 27 Oct 2026 15:37:13 +0100
From: Joshua Crofts <crofts@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: Sergiu Cuciurean <sergiu.cuciurean@analog.com>, Jonathan Cameron
 <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, Nuno
 =?ISO-8859-1?Q?S=E1?= <nuno.sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski
 <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Uwe
 =?ISO-8859-1?Q?Kleine-K=F6nig?= <ukleinek@kernel.org>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: add ltc2387 driver
Message-ID: <20261027153713.000066ce@kernel.org>
In-Reply-To: <20261027134409.76824-3-Nicolae-daniel.Deaconescu@analog.com>
References: <20261027134409.76824-1-Nicolae-daniel.Deaconescu@analog.com>
	<20261027134409.76824-3-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-w64-mingw32)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 27 Oct 2026 15:44:09 +0200
Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com> wrote:

> From: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
>=20
> Add a driver for the LTC2387-16/18 and the ADAQ23875/23876/23878.

Hi, some comments from me. Additionally, please check out what
Sashiko says:

https://sashiko.dev/#/patchset/20261027134409.76824-1-Nicolae-daniel.Deacon=
escu%40analog.com


> The driver generates CNV and the gated data clock with two PWM
> channels, timed against the reference clock to meet t_FIRSTCLK, and
> gets sample data through the IIO backend framework from the AXI ADC
> core. It supports one-lane and two-lane output and reports the
> sampling frequency the PWMs produce after rounding to whole reference
> clock cycles. in_voltage_scale is referred to the analog input, so on
> the ADAQ parts it is divided by the front-end gain.
>=20
> Signed-off-by: Sergiu Cuciurean <sergiu.cuciurean@analog.com>
> Co-developed-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@ana=
log.com>
> Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analo=
g.com>
> Assisted-by: Claude:claude-opus-5-5

Drop this tag, it has been deprecated.

> diff --git a/drivers/iio/adc/ltc2387.c b/drivers/iio/adc/ltc2387.c
> new file mode 100644
> index 000000000000..c236b99baa4a
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2387.c
> @@ -0,0 +1,482 @@
> +// SPDX-License-Identifier: (GPL-2.0-only OR BSD-3-Clause)
> +/*
> + * Linear Technology LTC2387 ADC driver
> + *
> + * Copyright 2022 - 2026 Analog Devices Inc.
> + */
> +
> +#include <linux/clk.h>
> +#include <linux/device.h>
> +#include <linux/err.h>
> +#include <linux/iio/backend.h>
> +#include <linux/iio/iio.h>
> +#include <linux/iio/sysfs.h>

Better to have the iio specific headers separately after the generic
linux headers.

> +#include <linux/kernel.h>

No, do not use this header for new drivers. Use the IWYU principle when
deciding what to include.

> +#include <linux/math64.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/property.h>
> +#include <linux/pwm.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/mod_devicetable.h>

Drop this header, it's included by platform_device.h

+ you're missing additional headers, e.g. types.h

> +
> +#define LTC2387_VREF		4096
> +#define LTC2387_T_CNVH		8
> +
> +/*
> + * Minimal value for t_{FIRSTCLK} according to
> + * https://www.analog.com/media/en/technical-documentation/data-sheets/2=
38718fa.pdf
> + * is 65 ns. Add some slack because there is some rounding involved in t=
he PWM
> + * driver. With the PWM driver rounding to the nearest possible value, t=
argeting
> + * 70 ns works for input clk rates >=3D 100 MHz.
> + */
> +#define LTC2387_T_FIRSTCLK_NS	70
> +
> +#define KHz 1000

We have units.h for this.

> +#define MHz (1000 * KHz)
> +
> +#define LTC2378_MULTIPLE_CHAN(_idx, _storagebits, _realbits, _shift)	\
> +	{								\
> +		.type =3D IIO_VOLTAGE,					\
> +		.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),\
> +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),\
> +		.indexed =3D 1,						\
> +		.channel =3D _idx,					\
> +		.scan_index =3D _idx,					\
> +		.scan_type =3D {						\
> +			.sign =3D 's',					\
> +			.storagebits =3D _storagebits,			\
> +			.realbits =3D _realbits,				\
> +			.shift =3D _shift,				\
> +		},							\
> +	}
> +

...

> +struct ltc2387_dev {
> +	const struct ltc2387_info *device_info;
> +	enum ltc2387_lane_modes lane_mode;
> +	unsigned long ref_clk_rate;
> +	struct iio_backend *back;
> +	struct pwm_device *clk_gate;
> +	struct regulator *vref;
> +	struct pwm_device *cnv;
> +	struct clk *ref_clk;
> +
> +	unsigned int vref_mv;

_mV

> +	u32 sampling_freq;
> +	u32 gain_milli;
> +};
> +
> +static int ltc2387_set_sampling_freq(struct ltc2387_dev *ltc, int freq)
> +{
> +	unsigned long long ref_clk_period_ns;
> +	struct pwm_waveform clk_gate_wf =3D { }, cnv_wf =3D { };

Reverse xmas tree please.

> +	unsigned long long period_cycles;
> +	int ret, clk_en_time;
> +	u32 rem;
> +
> +	if (freq <=3D 0 || freq > ltc->ref_clk_rate)
> +		return -EINVAL;
> +
> +	ref_clk_period_ns =3D DIV_ROUND_UP(NSEC_PER_SEC, ltc->ref_clk_rate);
> +
> +	cnv_wf.duty_length_ns =3D ref_clk_period_ns;
> +
> +	/*
> +	 * The goal here is that the PWM is configured with a minimal period not
> +	 * less than 1 / freq (with freq measured in Hz).
> +	 *
> +	 * When a period P (measured in ns) is passed to pwm_apply_state(), the
> +	 * actually implemented period is:
> +	 *
> +	 *      round_down(P * R / NSEC_PER_SEC) / R
> +	 *
> +	 * (measured in s) with R =3D ltc->ref_clk_rate. So we have:
> +	 *
> +	 *        round_down(P * R / NSEC_PER_SEC) / R =E2=89=A5 1 / freq
> +	 *      =E2=9F=BA round_down(P * R / NSEC_PER_SEC) =E2=89=A5 R / freq

Ehhh, not really sure about these non-standard characters in the comments.
Had to check lore to see what this renders to. Wouldn't it be easier to use
a trigraph <=3D>? Same for the digraph stuff you have.

> +	 *
> +	 * With the LHS being integer this is equivalent to:
> +	 *
> +	 *        round_down(P * R / NSEC_PER_SEC) =E2=89=A5 round_up(R / freq)
> +	 *      =E2=9F=BA P * R / NSEC_PER_SEC =E2=89=A5 round_up(R / freq)
> +	 *      =E2=9F=BA P =E2=89=A5 round_up(R / freq) * NSEC_PER_SEC / R
> +	 */
> +
> +	cnv_wf.period_length_ns =3D
> +		div_u64_rem((u64)DIV_ROUND_UP(ltc->ref_clk_rate, freq) * NSEC_PER_SEC,
> +			    ltc->ref_clk_rate, &rem);
> +	if (rem)
> +		cnv_wf.period_length_ns +=3D 1;
> +
> +	/* Gate the active period of the clock (see page 10-13 for both LTC's) =
*/
> +	if (ltc->lane_mode =3D=3D TWO_LANES)
> +		clk_en_time =3D DIV_ROUND_UP_ULL(ltc->device_info->resolution, 4);
> +	else
> +		clk_en_time =3D DIV_ROUND_UP_ULL(ltc->device_info->resolution, 2);
> +
> +	clk_gate_wf.duty_length_ns =3D ref_clk_period_ns * clk_en_time;
> +	clk_gate_wf.duty_offset_ns =3D LTC2387_T_FIRSTCLK_NS;
> +
> +	if (cnv_wf.period_length_ns < clk_gate_wf.duty_length_ns)
> +		cnv_wf.period_length_ns =3D clk_gate_wf.duty_length_ns + ref_clk_perio=
d_ns;
> +
> +	clk_gate_wf.period_length_ns =3D cnv_wf.period_length_ns;
> +
> +	if (clk_gate_wf.duty_offset_ns >=3D clk_gate_wf.period_length_ns)
> +		div64_u64_rem(clk_gate_wf.duty_offset_ns,
> +			      clk_gate_wf.period_length_ns,
> +			      &clk_gate_wf.duty_offset_ns);
> +
> +	ret =3D pwm_set_waveform_might_sleep(ltc->cnv, &cnv_wf, false);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D pwm_set_waveform_might_sleep(ltc->clk_gate, &clk_gate_wf, false=
);
> +	if (ret < 0)
> +		return ret;
> +
> +	period_cycles =3D mul_u64_u32_div(cnv_wf.period_length_ns,
> +					ltc->ref_clk_rate, NSEC_PER_SEC);
> +	if (!period_cycles)
> +		return -EINVAL;
> +
> +	ltc->sampling_freq =3D DIV_ROUND_CLOSEST_ULL(ltc->ref_clk_rate,
> +						   period_cycles);
> +
> +	return 0;
> +}
> +
> +static int ltc2387_setup(struct iio_dev *indio_dev)
> +{
> +	struct ltc2387_dev *ltc =3D iio_priv(indio_dev);
> +	struct device *dev =3D indio_dev->dev.parent;
> +
> +	if (device_property_present(dev, "adi,use-two-lanes"))
> +		ltc->lane_mode =3D TWO_LANES;
> +
> +	return ltc2387_set_sampling_freq(ltc, 15 * MHz);
> +}
> +
> +static int ltc2387_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan,
> +			    int *val, int *val2, long info)
> +{
> +	struct ltc2387_dev *ltc =3D iio_priv(indio_dev);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*val =3D ltc->sampling_freq;
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		/* Referred to the SMA input, so divided by the front-end gain. */
> +		*val =3D ltc->vref_mv * 2 * 1000;

vref_mv * 2 * MILLI;

> +		*val2 =3D ltc->gain_milli << chan->scan_type.realbits;
> +		return IIO_VAL_FRACTIONAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ltc2387_write_raw(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     int val, int val2, long info)
> +{
> +	struct ltc2387_dev *ltc =3D iio_priv(indio_dev);
> +

Probably add a mutex here to protect writing, ideally in guard() form.

> +	switch (info) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ltc2387_set_sampling_freq(ltc, val);
> +
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static void ltc2387_pwm_disable(void *data)
> +{
> +	pwm_disable(data);
> +}
> +
> +static void ltc2387_regulator_disable(void *data)
> +{
> +	regulator_disable(data);
> +}
> +
> +static void ltc2387_clk_disable(void *data)
> +{
> +	clk_disable_unprepare(data);
> +}
> +
> +static const struct iio_info ltc2387_info =3D {
> +	.read_raw =3D ltc2387_read_raw,
> +	.write_raw =3D ltc2387_write_raw,
> +};
> +
> +static const struct of_device_id ltc2387_of_match[] =3D {
> +	{
> +		.compatible =3D "lltc,ltc2387-16",
> +		.data =3D &ltc2387_infos[ID_LTC2387_16]
> +	}, {
> +		.compatible =3D "lltc,ltc2387-16-x4",
> +		.data =3D &ltc2387_infos[ID_LTC2387_16_X4]
> +	}, {
> +		.compatible =3D "lltc,ltc2387-18",
> +		.data =3D &ltc2387_infos[ID_LTC2387_18]
> +	}, {
> +		.compatible =3D "lltc,ltc2387-18-x4",
> +		.data =3D &ltc2387_infos[ID_LTC2387_18_X4]
> +	}, {
> +		.compatible =3D "adi,adaq23875",
> +		.data =3D &ltc2387_infos[ID_ADAQ23875]
> +	}, {
> +		.compatible =3D "adi,adaq23876",
> +		.data =3D &ltc2387_infos[ID_ADAQ23876]
> +	}, {
> +		.compatible =3D "adi,adaq23878",
> +		.data =3D &ltc2387_infos[ID_ADAQ23878]
> +	},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, ltc2387_of_match);

Have the device tables after the probe() function.

> +
> +static int ltc2387_probe(struct platform_device *pdev)
> +{
> +	struct iio_dev			*indio_dev;
> +	struct ltc2387_dev		*ltc;
> +	int				ret;

Maybe unify the style you define variables? (aligned vs. non-aligned).

> +
> +	indio_dev =3D devm_iio_device_alloc(&pdev->dev, sizeof(*ltc));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	ltc =3D iio_priv(indio_dev);
> +
> +	ltc->vref =3D devm_regulator_get_optional(&pdev->dev, "vref");
> +	if (!IS_ERR(ltc->vref)) {
> +		ret =3D regulator_enable(ltc->vref);
> +		if (ret) {
> +			dev_err(&pdev->dev, "Can't enable vref regulator\n");

dev_err_probe() instead of dev_err()

> +			return ret;
> +		}
> +		ret =3D regulator_get_voltage(ltc->vref);
> +		if (ret < 0)
> +			return ret;
> +
> +		ltc->vref_mv =3D ret / 1000;

ret / (MICRO / MILLI)

> +		ret =3D devm_add_action_or_reset(&pdev->dev,
> +					       ltc2387_regulator_disable,
> +					       ltc->vref);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (PTR_ERR(ltc->vref) !=3D -ENODEV)
> +			return PTR_ERR(ltc->vref);
> +
> +		ltc->vref_mv =3D LTC2387_VREF; /* Internal vref is used */
> +	}
> +
> +	ltc->ref_clk =3D devm_clk_get(&pdev->dev, NULL);
> +	if (IS_ERR(ltc->ref_clk))
> +		return PTR_ERR(ltc->ref_clk);
> +
> +	ret =3D clk_prepare_enable(ltc->ref_clk);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, ltc2387_clk_disable,
> +				       ltc->ref_clk);
> +	if (ret)
> +		return ret;

+ blank line.

> +	ltc->ref_clk_rate =3D clk_get_rate(ltc->ref_clk);
> +
> +	ltc->clk_gate =3D devm_pwm_get(&pdev->dev, "clk_gate");
> +	if (IS_ERR(ltc->clk_gate))
> +		return PTR_ERR(ltc->clk_gate);
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, ltc2387_pwm_disable,
> +				       ltc->clk_gate);
> +	if (ret)
> +		return ret;
> +
> +	ltc->cnv =3D devm_pwm_get(&pdev->dev, "cnv");
> +	if (IS_ERR(ltc->cnv))
> +		return PTR_ERR(ltc->cnv);
> +
> +	ret =3D devm_add_action_or_reset(&pdev->dev, ltc2387_pwm_disable,
> +				       ltc->cnv);
> +
> +	if (ret)
> +		return ret;
> +
> +	ltc->device_info =3D device_get_match_data(&pdev->dev);
> +	if (!ltc->device_info)
> +		return -EINVAL;

return -ENODATA;

> +
> +	ltc->gain_milli =3D ltc->device_info->default_gain_milli;
> +	device_property_read_u32(&pdev->dev, "adi,gain-milli", &ltc->gain_milli=
);
> +	if (!ltc->gain_milli)
> +		return dev_err_probe(&pdev->dev, -EINVAL,
> +				     "adi,gain-milli must be nonzero\n");
> +
> +	indio_dev->channels =3D ltc->device_info->channels;
> +	indio_dev->num_channels =3D ltc->device_info->num_channels;
> +	indio_dev->dev.parent =3D &pdev->dev;
> +	indio_dev->name =3D ltc->device_info->name;
> +	indio_dev->info =3D &ltc2387_info;
> +
> +	ltc->back =3D devm_iio_backend_get(&pdev->dev, NULL);
> +	if (IS_ERR(ltc->back))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(ltc->back),
> +				     "failed to get IIO backend\n");
> +
> +	ret =3D devm_iio_backend_request_buffer(&pdev->dev, ltc->back, indio_de=
v);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D devm_iio_backend_enable(&pdev->dev, ltc->back);
> +	if (ret)
> +		return ret;
> +
> +	/* axi_ltc2387 has a single capture channel carrying every scan element=
. */
> +	ret =3D iio_backend_chan_enable(ltc->back, 0);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D ltc2387_setup(indio_dev);
> +	if (ret < 0) {
> +		dev_err(&pdev->dev, "\nltc2387 setup failed\n");

Why the additional \n at the beginning.
> +		return ret;
> +	}
> +
> +	return devm_iio_device_register(&pdev->dev, indio_dev);
> +}
> +
> +static struct platform_driver ltc2387_driver =3D {
> +	.probe          =3D ltc2387_probe,
> +	.driver         =3D {
> +		.name   =3D "ltc2387",
> +		.of_match_table =3D ltc2387_of_match,
> +	},
> +};
> +module_platform_driver(ltc2387_driver);
> +
> +MODULE_AUTHOR("Sergiu Cuciurean <sergiu.cuciurean@analog.com>");
> +MODULE_DESCRIPTION("Linear Technology LTC2387 ADC");

The description should be the same as what's in the Kconfig tristate entry.

> +MODULE_LICENSE("Dual BSD/GPL");
> +MODULE_IMPORT_NS("IIO_BACKEND");



--=20
Kind regards,
Joshua Crofts
