Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFC23CC9E9;
	Mon,  7 Sep 2026 21:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788818379; cv=none; b=ACNbbvKg6PZt+BGiIcGAHAB1dcQ++eHSj8BSkzRt0rj9u4gT9ts3flk1s1ynSo8vof+wLMHBoo0+C1/G0+yyk+jEhzNNsaAyDMt9vcpYVSkiJJ5+F2wPA/M6KK8Cwul77iJ04uzGAq9DRBcMBFFV+L1E9LmegaPj1P9DYXpsLIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788818379; c=relaxed/simple;
	bh=ffmh4eVSFBbzvFer9KzlYpVJ0BrNlIkw7mTFr9zalEc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QOQoJp9Ix3rnP334LMbcRj4tceU6+RlSBSwHivJs8Dq1d294LX6i9e+tVfBdDCrZ58olpVal7VS7OM3djigBKstVsv5eQjJ2R61/kgMg0661cKSccnc6+oV02FgTnxLSdrSS39YEWYtba/Ju97rliN/CCFcCF7TgvwyFbWSqtyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=COcJI5Y3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="COcJI5Y3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B871F00A3A;
	Mon,  7 Sep 2026 21:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788818377;
	bh=S2ZJsjqnYTkLtoyd/zDVU3r+C9XVkuesXEwBjISCpVU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=COcJI5Y3OHwfEPOIVdPCU1d4GeyBurvEoTG8R97BxJ4fzGaGO35Qehl78qjRe6FOb
	 Grqes9g8toLVtAJ5jlzcKF2Q3pV1hXaiaBfkof8pbtpzsdEc2EvH3CfFP96c+EEHRs
	 Jp0ISTMg3Q6N/vOPiguQMk7X3ZRCrR/aEbVD3kzyZcyuwUsrRXcoDvyGhqV2ph60Sb
	 1WuyqxsmpS6hYUPam5slevDZDMw4P01Xsepc80DmCgiz1lMj8VnBlSLPaMIK465l3D
	 troBBLB5ckRf1FynhA4tMYchjuIxkIp/ptZYb3k20I7CaJecyGNVcqCzl4zn9hjwLU
	 vpsXi4+Gz0FVA==
Date: Mon, 7 Sep 2026 22:59:30 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc: rodrigo.alencar@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, Lars-Peter
 Clausen <lars@metafoo.de>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Philipp
 Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, Shuah
 Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <20260907225930.44b90a2f@jic23-huawei>
In-Reply-To: <anIA101fhQ4BIdmp@nsa>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
	<20260729-ad9910-iio-driver-v10-10-aa1f6167729e@analog.com>
	<anIA101fhQ4BIdmp@nsa>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Aug 2026 16:12:07 +0100
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> Hi Rodrigo,
>=20
> Just a late small nit...
>=20
> On Wed, Jul 29, 2026 at 09:25:37AM +0100, Rodrigo Alencar via B4 Relay wr=
ote:
> > From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> >=20
> > Add the core AD9910 DDS driver infrastructure with single tone mode
> > support. This includes SPI register access, profile management via GPIO
> > pins, PLL/DAC configuration from firmware properties, and single tone
> > frequency/phase/amplitude control through IIO attributes.
> >=20
> > Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> > +
> > +static inline int ad9910_spi_read(struct ad9910_state *st, u8 reg, voi=
d *data,
> > +				  size_t len)
> > +{
> > +	u8 inst =3D AD9910_SPI_READ_MSK | FIELD_PREP(AD9910_SPI_ADDR_MSK, reg=
);
> > +
> > +	return spi_write_then_read(st->spi, &inst, sizeof(inst), data, len);
> > +}
> > +
> > +static inline int ad9910_spi_write(struct ad9910_state *st, u8 reg, si=
ze_t len,
> > +				   bool update)
> > +{
> > +	int ret;
> > +
> > +	st->tx_buf[0] =3D FIELD_PREP(AD9910_SPI_ADDR_MSK, reg);
> > +	ret =3D spi_write(st->spi, st->tx_buf, AD9910_SPI_DATA_IDX + len);
> > +	if (ret)
> > +		return ret;
> > +
> > +	if (update)
> > +		return ad9910_io_update(st);
> > +
> > +	return 0;
> > +} =20
>=20
> I would really drop the inline here. It adds no value. Basically just an
> hint and the compiler is smart enough to decide whether it should inline
> the above or not.

I think all the inline markings in here make limited sense as the compiler
should figure out the best trade off.  So I removed a bunch of them.

diff --git a/drivers/iio/frequency/ad9910.c b/drivers/iio/frequency/ad9910.c
index b41b011af281..095b3c644125 100644                                    =
 =20

-static inline u64 ad9910_rational_scale(u64 input, u64 scale, u64 referenc=
e)
+static u64 ad9910_rational_scale(u64 input, u64 scale, u64 reference)
 {
        return mul_u64_add_u64_div_u64(input, scale, reference >> 1, refere=
nce);
 }
@@ -298,16 +298,16 @@ static int ad9910_io_update(struct ad9910_state *st)
        return 0;
 }

-static inline int ad9910_spi_read(struct ad9910_state *st, u8 reg, void *d=
ata,
-                                 size_t len)
+static int ad9910_spi_read(struct ad9910_state *st, u8 reg, void *data,
+                          size_t len)
 {
        u8 inst =3D AD9910_SPI_READ_MSK | FIELD_PREP(AD9910_SPI_ADDR_MSK, r=
eg);

        return spi_write_then_read(st->spi, &inst, sizeof(inst), data, len);
 }

-static inline int ad9910_spi_write(struct ad9910_state *st, u8 reg, size_t=
 len,
-                                  bool update)
+static int ad9910_spi_write(struct ad9910_state *st, u8 reg, size_t len,
+                           bool update)
 {
        int ret;

@@ -476,7 +476,7 @@ static int ad9910_profile_set(struct ad9910_state *st, =
u8 profile)
        return 0;
 }

-static inline bool ad9910_sw_powerdown_get(struct ad9910_state *st)
+static bool ad9910_sw_powerdown_get(struct ad9910_state *st)
 {
        return FIELD_GET(AD9910_CFR1_SW_POWER_DOWN_MSK,
                         st->reg[AD9910_REG_CFR1].val32) ? true : false;


>=20
> - Nuno S=C3=A1
>=20
> > +
> > +#define AD9910_REG_READ_FN(nb)						\
> > +static int ad9910_reg##nb##_read(struct ad9910_state *st, u8 reg,	\
> > +				 u##nb * data)				\
> > +{									\
> > +	__be##nb be_data;						\
> > +	int ret;							\
> > +									\
> > +	ret =3D ad9910_spi_read(st, reg, &be_data, sizeof(be_data));	\
> > +	if (ret)							\
> > +		return ret;						\
> > +									\
> > +	*data =3D be##nb##_to_cpu(be_data);				\
> > +	return ret;							\
> > +}
> > +
> > +AD9910_REG_READ_FN(16)
> > +AD9910_REG_READ_FN(32)
> > +AD9910_REG_READ_FN(64)
> > +
> > +#define AD9910_REG_WRITE_FN(nb)						\
> > +static int ad9910_reg##nb##_write(struct ad9910_state *st, u8 reg,	\
> > +				  u##nb data, bool update)		\
> > +{									\
> > +	int ret;							\
> > +									\
> > +	put_unaligned_be##nb(data, &st->tx_buf[AD9910_SPI_DATA_IDX]);	\
> > +	ret =3D ad9910_spi_write(st, reg, sizeof(data), update);		\
> > +	if (ret)							\
> > +		return ret;						\
> > +									\
> > +	st->reg[reg].val##nb =3D data;					\
> > +	return ret;							\
> > +}
> > +
> > +AD9910_REG_WRITE_FN(16)
> > +AD9910_REG_WRITE_FN(32)
> > +AD9910_REG_WRITE_FN(64)
> > +
> > +#define AD9910_REG_UPDATE_FN(nb)					\
> > +static int ad9910_reg##nb##_update(struct ad9910_state *st,		\
> > +				   u8 reg, u##nb mask,			\
> > +				   u##nb data, bool update)		\
> > +{									\
> > +	u##nb reg_val =3D (st->reg[reg].val##nb & ~mask) | (data & mask);	\
> > +									\
> > +	if (reg_val =3D=3D st->reg[reg].val##nb && !update)			\
> > +		return 0;						\
> > +									\
> > +	return ad9910_reg##nb##_write(st, reg, reg_val, update);	\
> > +}
> > +
> > +AD9910_REG_UPDATE_FN(16)
> > +AD9910_REG_UPDATE_FN(32)
> > +AD9910_REG_UPDATE_FN(64)
> > +
> > +static int ad9910_set_dac_current(struct ad9910_state *st, u32 val_uA,
> > +				  bool update)
> > +{
> > +	u32 code;
> > +
> > +	/* FSC =3D (86.4 / Rset) * (1 + CODE/96) where Rset =3D 10k ohms */
> > +	val_uA =3D clamp(val_uA, AD9910_DAC_IOUT_MIN_uA, AD9910_DAC_IOUT_MAX_=
uA);
> > +	code =3D DIV_ROUND_CLOSEST(val_uA - AD9910_DAC_IOUT_MIN_uA, 90);
> > +	st->data.output_current_uA =3D AD9910_DAC_IOUT_MIN_uA + code * 90;
> > +
> > +	return ad9910_reg32_write(st, AD9910_REG_AUX_DAC, code, update);
> > +}
> > +
> > +static int ad9910_set_sysclk_freq(struct ad9910_state *st, u32 freq_hz,
> > +				  bool update)
> > +{
> > +	struct device *dev =3D &st->spi->dev;
> > +	unsigned long refclk_freq_hz;
> > +	u32 sysclk_freq_hz;
> > +	u32 tmp32, vco_sel;
> > +	int ret;
> > +
> > +	if (!freq_hz || freq_hz > AD9910_MAX_SYSCLK_HZ)
> > +		return -EINVAL;
> > +
> > +	refclk_freq_hz =3D clk_get_rate(st->refclk);
> > +	if (st->data.pll_enabled) {
> > +		if (refclk_freq_hz < AD9910_PLL_IN_MIN_FREQ_HZ ||
> > +		    refclk_freq_hz > AD9910_PLL_IN_MAX_FREQ_HZ) {
> > +			dev_err(dev,
> > +				"REF_CLK freq %lu Hz is out of PLL input range\n",
> > +				refclk_freq_hz);
> > +			return -ERANGE;
> > +		}
> > +
> > +		tmp32 =3D DIV_ROUND_CLOSEST(freq_hz, refclk_freq_hz);
> > +		tmp32 =3D clamp(tmp32, DIV_ROUND_UP(AD9910_PLL_OUT_MIN_FREQ_HZ, refc=
lk_freq_hz),
> > +			      AD9910_PLL_OUT_MAX_FREQ_HZ / refclk_freq_hz);
> > +		tmp32 =3D clamp(tmp32, AD9910_PLL_MIN_N, AD9910_PLL_MAX_N);
> > +		sysclk_freq_hz =3D refclk_freq_hz * tmp32;
> > +
> > +		if (sysclk_freq_hz <=3D AD9910_VCO0_RANGE_AUTO_MAX_HZ)
> > +			vco_sel =3D 0;
> > +		else if (sysclk_freq_hz <=3D AD9910_VCO1_RANGE_AUTO_MAX_HZ)
> > +			vco_sel =3D 1;
> > +		else if (sysclk_freq_hz <=3D AD9910_VCO2_RANGE_AUTO_MAX_HZ)
> > +			vco_sel =3D 2;
> > +		else if (sysclk_freq_hz <=3D AD9910_VCO3_RANGE_AUTO_MAX_HZ)
> > +			vco_sel =3D 3;
> > +		else if (sysclk_freq_hz <=3D AD9910_VCO4_RANGE_AUTO_MAX_HZ)
> > +			vco_sel =3D 4;
> > +		else
> > +			vco_sel =3D 5;
> > +
> > +		ret =3D ad9910_reg32_update(st, AD9910_REG_CFR3,
> > +					  AD9910_CFR3_N_MSK | AD9910_CFR3_VCO_SEL_MSK,
> > +					  FIELD_PREP(AD9910_CFR3_N_MSK, tmp32) |
> > +					  FIELD_PREP(AD9910_CFR3_VCO_SEL_MSK, vco_sel),
> > +					  update);
> > +		if (ret)
> > +			return ret;
> > +	} else {
> > +		if (refclk_freq_hz < AD9910_REFDIV2_MIN_FREQ_HZ ||
> > +		    refclk_freq_hz > AD9910_REFDIV2_MAX_FREQ_HZ) {
> > +			dev_err(dev,
> > +				"REF_CLK freq %lu Hz is out of divider range\n",
> > +				refclk_freq_hz);
> > +			return -ERANGE;
> > +		}
> > +
> > +		tmp32 =3D DIV_ROUND_CLOSEST(refclk_freq_hz, freq_hz);
> > +		tmp32 =3D clamp(tmp32, 1U, 2U);
> > +		sysclk_freq_hz =3D refclk_freq_hz / tmp32;
> > +		tmp32 =3D AD9910_CFR3_VCO_SEL_MSK |
> > +			FIELD_PREP(AD9910_CFR3_REFCLK_DIV_BYPASS_MSK, tmp32 % 2);
> > +		ret =3D ad9910_reg32_update(st, AD9910_REG_CFR3,
> > +					  AD9910_CFR3_VCO_SEL_MSK |
> > +					  AD9910_CFR3_REFCLK_DIV_BYPASS_MSK,
> > +					  tmp32, update);
> > +		if (ret)
> > +			return ret;
> > +	}
> > +
> > +	st->data.sysclk_freq_hz =3D sysclk_freq_hz;
> > +
> > +	return 0;
> > +}
> > +
> > +static int ad9910_profile_set(struct ad9910_state *st, u8 profile)
> > +{
> > +	DECLARE_BITMAP(values, BITS_PER_TYPE(profile));
> > +
> > +	st->profile =3D profile;
> > +	values[0] =3D profile;
> > +	gpiod_multi_set_value_cansleep(st->gpio_profile, values);
> > +
> > +	return 0;
> > +}
> > +
> > +static inline bool ad9910_sw_powerdown_get(struct ad9910_state *st)
> > +{
> > +	return FIELD_GET(AD9910_CFR1_SW_POWER_DOWN_MSK,
> > +			 st->reg[AD9910_REG_CFR1].val32) ? true : false;
> > +}
> > +
> > +static int ad9910_sw_powerdown_set(struct ad9910_state *st, bool enabl=
e)
> > +{
> > +	int ret;
> > +
> > +	if (ad9910_sw_powerdown_get(st) =3D=3D enable)
> > +		return 0;
> > +
> > +	/*
> > +	 * When powering down, the DAC and AUX_DAC (SW1) must be powered down
> > +	 * first, as they require an I/O update to take effect. The opposite =
is
> > +	 * true when powering up, the DAC and AUX_DAC must be powered up last,
> > +	 * i.e., after the DIGITAL and REFCLK_INPUT (SW0) power up.
> > +	 */
> > +	if (enable) {
> > +		ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> > +					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> > +					  true);
> > +		if (ret)
> > +			return ret;
> > +
> > +		return ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> > +					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> > +					   false);
> > +	}
> > +
> > +	ret =3D ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +				  AD9910_CFR1_SW0_POWER_DOWN_MSK, 0, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ad9910_reg32_update(st, AD9910_REG_CFR1,
> > +				   AD9910_CFR1_SW1_POWER_DOWN_MSK, 0, true);
> > +}
> > +
> > +static ssize_t ad9910_ext_info_read(struct iio_dev *indio_dev,
> > +				    uintptr_t private,
> > +				    const struct iio_chan_spec *chan,
> > +				    char *buf)
> > +{
> > +	struct ad9910_state *st =3D iio_priv(indio_dev);
> > +	int val;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (private) {
> > +	case AD9910_POWERDOWN:
> > +		val =3D ad9910_sw_powerdown_get(st);
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> > +}
> > +
> > +static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
> > +				     uintptr_t private,
> > +				     const struct iio_chan_spec *chan,
> > +				     const char *buf, size_t len)
> > +{
> > +	struct ad9910_state *st =3D iio_priv(indio_dev);
> > +	u32 val32;
> > +	int ret;
> > +
> > +	ret =3D kstrtou32(buf, 10, &val32);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (private) {
> > +	case AD9910_POWERDOWN:
> > +		ret =3D ad9910_sw_powerdown_set(st, val32 ? true : false);
> > +		if (ret)
> > +			return ret;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	return len;
> > +}
> > +
> > +static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] =3D {
> > +	{
> > +		.name =3D "powerdown",
> > +		.read =3D ad9910_ext_info_read,
> > +		.write =3D ad9910_ext_info_write,
> > +		.private =3D AD9910_POWERDOWN,
> > +		.shared =3D IIO_SEPARATE,
> > +	},
> > +	{ }
> > +};
> > +
> > +#define AD9910_PROFILE_CHAN(idx) {				\
> > +	.type =3D IIO_ALTCURRENT,					\
> > +	.indexed =3D 1,						\
> > +	.output =3D 1,						\
> > +	.channel =3D AD9910_CHANNEL_PROFILE_ ## idx,		\
> > +	.address =3D AD9910_CHAN_IDX_PROFILE_ ## idx,		\
> > +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_ENABLE) |	\
> > +			      BIT(IIO_CHAN_INFO_FREQUENCY) |	\
> > +			      BIT(IIO_CHAN_INFO_PHASE) |	\
> > +			      BIT(IIO_CHAN_INFO_RAW),		\
> > +	.parent =3D &ad9910_channels[AD9910_CHAN_IDX_PHY],	\
> > +}
> > +
> > +static const struct iio_chan_spec ad9910_channels[] =3D {
> > +	[AD9910_CHAN_IDX_PHY] =3D {
> > +		.type =3D IIO_ALTCURRENT,
> > +		.indexed =3D 1,
> > +		.output =3D 1,
> > +		.channel =3D AD9910_CHANNEL_PHY,
> > +		.address =3D AD9910_CHAN_IDX_PHY,
> > +		.info_mask_separate =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),
> > +		.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),
> > +		.ext_info =3D ad9910_phy_ext_info,
> > +	},
> > +	[AD9910_CHAN_IDX_PROFILE_0] =3D AD9910_PROFILE_CHAN(0),
> > +	[AD9910_CHAN_IDX_PROFILE_1] =3D AD9910_PROFILE_CHAN(1),
> > +	[AD9910_CHAN_IDX_PROFILE_2] =3D AD9910_PROFILE_CHAN(2),
> > +	[AD9910_CHAN_IDX_PROFILE_3] =3D AD9910_PROFILE_CHAN(3),
> > +	[AD9910_CHAN_IDX_PROFILE_4] =3D AD9910_PROFILE_CHAN(4),
> > +	[AD9910_CHAN_IDX_PROFILE_5] =3D AD9910_PROFILE_CHAN(5),
> > +	[AD9910_CHAN_IDX_PROFILE_6] =3D AD9910_PROFILE_CHAN(6),
> > +	[AD9910_CHAN_IDX_PROFILE_7] =3D AD9910_PROFILE_CHAN(7),
> > +};
> > +
> > +static int ad9910_read_raw(struct iio_dev *indio_dev,
> > +			   struct iio_chan_spec const *chan,
> > +			   int *val, int *val2, long info)
> > +{
> > +	struct ad9910_state *st =3D iio_priv(indio_dev);
> > +	u64 tmp64;
> > +	u32 tmp32;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			if (ad9910_sw_powerdown_get(st)) {
> > +				*val =3D 0;
> > +			} else {
> > +				tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +				*val =3D (tmp32 =3D=3D st->profile);
> > +			}
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 =3D FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
> > +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		tmp64 *=3D st->data.sysclk_freq_hz;
> > +		*val =3D tmp64 >> 32;
> > +		*val2 =3D ((tmp64 & GENMASK_ULL(31, 0)) * MICRO) >> 32;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_PHASE:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 =3D FIELD_GET(AD9910_PROFILE_ST_POW_MSK,
> > +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> > +			break;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +		tmp32 =3D (tmp64 * AD9910_MAX_PHASE_MICRORAD) >> 16;
> > +		*val =3D tmp32 / MICRO;
> > +		*val2 =3D tmp32 % MICRO;
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			*val =3D FIELD_GET(AD9910_PROFILE_ST_ASF_MSK,
> > +					 st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PHY:
> > +			*val =3D st->data.sysclk_freq_hz;
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->address) {
> > +		case AD9910_CHAN_IDX_PHY:
> > +			tmp64 =3D (u64)st->data.output_current_uA *
> > +				AD9910_NANO_MILLIAMP_PER_MICROAMP;
> > +			*val =3D 0;
> > +			*val2 =3D tmp64 >> 14;
> > +			return IIO_VAL_INT_PLUS_NANO;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ad9910_write_raw(struct iio_dev *indio_dev,
> > +			    struct iio_chan_spec const *chan,
> > +			    int val, int val2, long info)
> > +{
> > +	struct ad9910_state *st =3D iio_priv(indio_dev);
> > +	u64 tmp64;
> > +	u32 tmp32;
> > +	int ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (info) {
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			if (!val) {
> > +				if (tmp32 !=3D st->profile)
> > +					return 0; /* nothing to do */
> > +
> > +				return ad9910_sw_powerdown_set(st, true);
> > +			}
> > +
> > +			ret =3D ad9910_sw_powerdown_set(st, false);
> > +			if (ret)
> > +				return ret;
> > +
> > +			return ad9910_profile_set(st, tmp32);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +		if (val < 0 || val2 < 0 || val >=3D st->data.sysclk_freq_hz / 2)
> > +			return -EINVAL;
> > +
> > +		tmp64 =3D ad9910_rational_scale((u64)val * MICRO + val2, BIT_ULL(32),
> > +					      (u64)MICRO * st->data.sysclk_freq_hz);
> > +		tmp64 =3D min_t(u64, tmp64, U32_MAX);
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 =3D FIELD_PREP(AD9910_PROFILE_ST_FTW_MSK, tmp64);
> > +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
> > +						   AD9910_PROFILE_ST_FTW_MSK,
> > +						   tmp64, true);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_PHASE:
> > +		if (val < 0 || val2 < 0)
> > +			return -EINVAL;
> > +
> > +		tmp64 =3D (u64)val * MICRO + val2;
> > +		if (tmp64 >=3D AD9910_MAX_PHASE_MICRORAD)
> > +			return -EINVAL;
> > +
> > +		tmp64 =3D DIV_U64_ROUND_CLOSEST(tmp64 << 16, AD9910_MAX_PHASE_MICROR=
AD);
> > +		tmp64 =3D min(tmp64, AD9910_POW_MAX);
> > +
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 =3D FIELD_PREP(AD9910_PROFILE_ST_POW_MSK, tmp64);
> > +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
> > +						   AD9910_PROFILE_ST_POW_MSK,
> > +						   tmp64, true);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			if (val < 0)
> > +				return -EINVAL;
> > +
> > +			tmp32 =3D chan->channel - AD9910_CHANNEL_PROFILE_0;
> > +			tmp64 =3D FIELD_PREP(AD9910_PROFILE_ST_ASF_MSK,
> > +					   min_t(u64, val, AD9910_ASF_MAX));
> > +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
> > +						   AD9910_PROFILE_ST_ASF_MSK,
> > +						   tmp64, true);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return ad9910_set_sysclk_freq(st, val, true);
> > +	case IIO_CHAN_INFO_SCALE:
> > +		switch (chan->address) {
> > +		case AD9910_CHAN_IDX_PHY:
> > +			if (val !=3D 0 || val2 < 0)
> > +				return -EINVAL;
> > +
> > +			tmp32 =3D DIV_U64_ROUND_CLOSEST((u64)val2 << 14,
> > +						      AD9910_NANO_MILLIAMP_PER_MICROAMP);
> > +			return ad9910_set_dac_current(st, tmp32, true);
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ad9910_write_raw_get_fmt(struct iio_dev *indio_dev,
> > +				    struct iio_chan_spec const *chan,
> > +				    long mask)
> > +{
> > +	switch (mask) {
> > +	case IIO_CHAN_INFO_ENABLE:
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_FREQUENCY:
> > +	case IIO_CHAN_INFO_PHASE:
> > +		return IIO_VAL_INT_PLUS_MICRO;
> > +	case IIO_CHAN_INFO_RAW:
> > +		switch (chan->channel) {
> > +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> > +			return IIO_VAL_INT;
> > +		default:
> > +			return -EINVAL;
> > +		}
> > +	case IIO_CHAN_INFO_SAMP_FREQ:
> > +		return IIO_VAL_INT;
> > +	case IIO_CHAN_INFO_SCALE:
> > +		return IIO_VAL_INT_PLUS_NANO;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +}
> > +
> > +static int ad9910_debugfs_reg_access(struct iio_dev *indio_dev,
> > +				     unsigned int reg, u64 writeval,
> > +				     u64 *readval)
> > +{
> > +	struct ad9910_state *st =3D iio_priv(indio_dev);
> > +	union ad9910_reg tmp;
> > +	int ret;
> > +
> > +	if (reg >=3D AD9910_REG_RAM)
> > +		return -EINVAL;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	switch (reg) {
> > +	case AD9910_REG_DRG_LIMIT:
> > +	case AD9910_REG_DRG_STEP:
> > +	case AD9910_REG_PROFILE0 ... AD9910_REG_PROFILE7:
> > +		if (!readval)
> > +			return ad9910_reg64_write(st, reg, writeval, true);
> > +
> > +		ret =3D ad9910_reg64_read(st, reg, &tmp.val64);
> > +		if (ret)
> > +			return ret;
> > +		*readval =3D tmp.val64;
> > +		return 0;
> > +	case AD9910_REG_POW:
> > +		if (!readval)
> > +			return ad9910_reg16_write(st, reg, writeval, true);
> > +
> > +		ret =3D ad9910_reg16_read(st, reg, &tmp.val16);
> > +		if (ret)
> > +			return ret;
> > +		*readval =3D tmp.val16;
> > +		return 0;
> > +	default:
> > +		if (!readval)
> > +			return ad9910_reg32_write(st, reg, writeval, true);
> > +
> > +		ret =3D ad9910_reg32_read(st, reg, &tmp.val32);
> > +		if (ret)
> > +			return ret;
> > +		*readval =3D tmp.val32;
> > +		return 0;
> > +	}
> > +}
> > +
> > +static const char * const ad9910_channel_str[] =3D {
> > +	[AD9910_CHAN_IDX_PHY] =3D "phy",
> > +	[AD9910_CHAN_IDX_PROFILE_0] =3D "profile0",
> > +	[AD9910_CHAN_IDX_PROFILE_1] =3D "profile1",
> > +	[AD9910_CHAN_IDX_PROFILE_2] =3D "profile2",
> > +	[AD9910_CHAN_IDX_PROFILE_3] =3D "profile3",
> > +	[AD9910_CHAN_IDX_PROFILE_4] =3D "profile4",
> > +	[AD9910_CHAN_IDX_PROFILE_5] =3D "profile5",
> > +	[AD9910_CHAN_IDX_PROFILE_6] =3D "profile6",
> > +	[AD9910_CHAN_IDX_PROFILE_7] =3D "profile7",
> > +};
> > +
> > +static int ad9910_read_label(struct iio_dev *indio_dev,
> > +			     struct iio_chan_spec const *chan,
> > +			     char *label)
> > +{
> > +	return sysfs_emit(label, "%s\n", ad9910_channel_str[chan->address]);
> > +}
> > +
> > +static const struct iio_info ad9910_info =3D {
> > +	.read_raw =3D ad9910_read_raw,
> > +	.write_raw =3D ad9910_write_raw,
> > +	.write_raw_get_fmt =3D ad9910_write_raw_get_fmt,
> > +	.read_label =3D ad9910_read_label,
> > +	.debugfs_reg64_access =3D &ad9910_debugfs_reg_access,
> > +};
> > +
> > +static int ad9910_cfg_sysclk(struct ad9910_state *st, bool update)
> > +{
> > +	u32 cfr3 =3D AD9910_CFR3_OPEN_MSK;
> > +	u32 tmp32;
> > +
> > +	cfr3 |=3D FIELD_PREP(AD9910_CFR3_DRV0_MSK, st->data.refclk_out_drv);
> > +
> > +	if (st->data.pll_enabled) {
> > +		tmp32 =3D st->data.pll_charge_pump_current - AD9910_ICP_MIN_uA;
> > +		tmp32 =3D DIV_ROUND_CLOSEST(tmp32, AD9910_ICP_STEP_uA);
> > +		cfr3 |=3D FIELD_PREP(AD9910_CFR3_ICP_MSK, tmp32) |
> > +			AD9910_CFR3_PLL_EN_MSK;
> > +	} else {
> > +		cfr3 |=3D AD9910_CFR3_ICP_MSK |
> > +			AD9910_CFR3_REFCLK_DIV_RESETB_MSK |
> > +			AD9910_CFR3_PFD_RESET_MSK;
> > +	}
> > +	st->reg[AD9910_REG_CFR3].val32 =3D cfr3;
> > +
> > +	return ad9910_set_sysclk_freq(st, AD9910_MAX_SYSCLK_HZ, update);
> > +}
> > +
> > +static int ad9910_parse_fw(struct ad9910_state *st)
> > +{
> > +	static const char * const refclk_out_drv0[] =3D {
> > +		"disabled", "low", "medium", "high",
> > +	};
> > +	struct device *dev =3D &st->spi->dev;
> > +	const char *prop;
> > +	u32 tmp;
> > +	int ret;
> > +
> > +	st->data.pll_enabled =3D device_property_read_bool(dev, "adi,pll-enab=
le");
> > +	if (st->data.pll_enabled) {
> > +		prop =3D "adi,charge-pump-current-microamp";
> > +		if (device_property_present(dev, prop)) {
> > +			ret =3D device_property_read_u32(dev, prop, &tmp);
> > +			if (ret)
> > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > +
> > +			if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> > +				return dev_err_probe(dev, -ERANGE,
> > +						     "invalid charge pump current %u\n", tmp);
> > +		} else {
> > +			tmp =3D AD9910_ICP_MIN_uA;
> > +		}
> > +		st->data.pll_charge_pump_current =3D tmp;
> > +
> > +		prop =3D "adi,refclk-out-drive-strength";
> > +		if (device_property_present(dev, prop)) {
> > +			ret =3D device_property_match_property_string(dev, prop,
> > +								    refclk_out_drv0,
> > +								    ARRAY_SIZE(refclk_out_drv0));
> > +			if (ret < 0)
> > +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> > +
> > +			st->data.refclk_out_drv =3D ret;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> > +
> > +static void ad9910_sw_powerdown_action(void *data)
> > +{
> > +	ad9910_sw_powerdown_set(data, true);
> > +}
> > +
> > +static void ad9910_hw_powerdown_action(void *data)
> > +{
> > +	struct ad9910_state *st =3D data;
> > +
> > +	gpiod_set_value_cansleep(st->gpio_pwdown, 1);
> > +}
> > +
> > +static int ad9910_setup(struct device *dev, struct ad9910_state *st,
> > +			struct reset_control *dev_rst)
> > +{
> > +	int ret;
> > +
> > +	ret =3D reset_control_assert(dev_rst);
> > +	if (ret)
> > +		return ret;
> > +
> > +	fsleep(AD9910_RESET_DELAY_us);
> > +
> > +	ret =3D reset_control_deassert(dev_rst);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ad9910_reg32_write(st, AD9910_REG_CFR1,
> > +				 (st->spi->mode & SPI_3WIRE ? 0 :
> > +				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK), false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_add_action_or_reset(dev, ad9910_sw_powerdown_action, st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ad9910_reg32_write(st, AD9910_REG_CFR2,
> > +				 AD9910_CFR2_AMP_SCALE_SINGLE_TONE_MSK |
> > +				 AD9910_CFR2_SYNC_TIMING_VAL_DISABLE_MSK |
> > +				 AD9910_CFR2_DRG_NO_DWELL_MSK |
> > +				 AD9910_CFR2_DATA_ASM_HOLD_LAST_MSK |
> > +				 AD9910_CFR2_SYNC_CLK_EN_MSK |
> > +				 AD9910_CFR2_PDCLK_ENABLE_MSK, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ad9910_cfg_sysclk(st, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ad9910_set_dac_current(st, AD9910_DAC_IOUT_DEFAULT_uA, false);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return ad9910_io_update(st);
> > +}
> > +
> > +static int ad9910_probe(struct spi_device *spi)
> > +{
> > +	static const char * const supplies[] =3D {
> > +		"dvdd-io33", "avdd33", "dvdd18", "avdd18",
> > +	};
> > +	struct device *dev =3D &spi->dev;
> > +	struct reset_control *dev_rst;
> > +	struct gpio_desc *io_rst_gpio;
> > +	struct iio_dev *indio_dev;
> > +	struct ad9910_state *st;
> > +	int ret;
> > +
> > +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*st));
> > +	if (!indio_dev)
> > +		return -ENOMEM;
> > +
> > +	st =3D iio_priv(indio_dev);
> > +	st->spi =3D spi;
> > +
> > +	indio_dev->name =3D "ad9910";
> > +	indio_dev->info =3D &ad9910_info;
> > +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> > +	indio_dev->channels =3D ad9910_channels;
> > +	indio_dev->num_channels =3D ARRAY_SIZE(ad9910_channels);
> > +
> > +	ret =3D devm_mutex_init(dev, &st->lock);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), sup=
plies);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> > +
> > +	st->refclk =3D devm_clk_get_enabled(dev, "ref_clk");
> > +	if (IS_ERR(st->refclk))
> > +		return dev_err_probe(dev, PTR_ERR(st->refclk),
> > +				     "Failed to get reference clock\n");
> > +
> > +	dev_rst =3D devm_reset_control_get_optional_exclusive(dev, NULL);
> > +	if (IS_ERR(dev_rst))
> > +		return dev_err_probe(dev, PTR_ERR(dev_rst),
> > +				     "failed to get device reset control\n");
> > +
> > +	/*
> > +	 * The IO RESET pin is not used in this driver, as we assume that all
> > +	 * SPI transfers are complete, but if it is wired up, we need to make
> > +	 * sure it is not floating. We can use either a reset controller or a
> > +	 * GPIO for this.
> > +	 */
> > +	io_rst_gpio =3D devm_gpiod_get_optional(dev, "io-reset", GPIOD_OUT_LO=
W);
> > +	if (IS_ERR(io_rst_gpio))
> > +		return dev_err_probe(dev, PTR_ERR(io_rst_gpio),
> > +				     "failed to get io reset gpio\n");
> > +
> > +	st->gpio_update =3D devm_gpiod_get_optional(dev, "update", GPIOD_OUT_=
LOW);
> > +	if (IS_ERR(st->gpio_update))
> > +		return dev_err_probe(dev, PTR_ERR(st->gpio_update),
> > +				     "failed to get update gpio\n");
> > +
> > +	st->gpio_profile =3D devm_gpiod_get_array_optional(dev, "profile",
> > +							 GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->gpio_profile))
> > +		return dev_err_probe(dev, PTR_ERR(st->gpio_profile),
> > +				     "failed to get profile gpios\n");
> > +
> > +	if (st->gpio_profile && st->gpio_profile->ndescs !=3D 3)
> > +		return dev_err_probe(dev, -EINVAL,
> > +				     "invalid number of profile gpios\n");
> > +
> > +	st->gpio_pwdown =3D devm_gpiod_get_optional(dev, "powerdown",
> > +						  GPIOD_OUT_LOW);
> > +	if (IS_ERR(st->gpio_pwdown))
> > +		return dev_err_probe(dev, PTR_ERR(st->gpio_pwdown),
> > +				     "failed to get powerdown gpio\n");
> > +
> > +	ret =3D devm_add_action_or_reset(dev, ad9910_hw_powerdown_action, st);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "failed to add hw powerdown action\n");
> > +
> > +	fsleep(AD9910_WAKEUP_DELAY_us);
> > +
> > +	ret =3D ad9910_parse_fw(st);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D ad9910_setup(dev, st, dev_rst);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret, "device setup failed\n");
> > +
> > +	return devm_iio_device_register(dev, indio_dev);
> > +}
> > +
> > +static const struct spi_device_id ad9910_id[] =3D {
> > +	{ .name =3D "ad9910" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(spi, ad9910_id);
> > +
> > +static const struct of_device_id ad9910_of_match[] =3D {
> > +	{ .compatible =3D "adi,ad9910" },
> > +	{ }
> > +};
> > +MODULE_DEVICE_TABLE(of, ad9910_of_match);
> > +
> > +static struct spi_driver ad9910_driver =3D {
> > +	.driver =3D {
> > +		.name =3D "ad9910",
> > +		.of_match_table =3D ad9910_of_match,
> > +	},
> > +	.probe =3D ad9910_probe,
> > +	.id_table =3D ad9910_id,
> > +};
> > +module_spi_driver(ad9910_driver);
> > +
> > +MODULE_AUTHOR("Rodrigo Alencar <rodrigo.alencar@analog.com>");
> > +MODULE_DESCRIPTION("Analog Devices AD9910 DDS driver");
> > +MODULE_LICENSE("GPL");
> >=20
> > --=20
> > 2.43.0
> >=20
> >  =20

