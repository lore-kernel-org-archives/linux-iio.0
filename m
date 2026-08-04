Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBCA46A5F4
	for <linux-iio@vger.kernel.org>; Tue,  4 Aug 2026 15:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856272; cv=none; b=nN/nLHwanE6iZdaOQhDmql4Ey+4o0NKrue4ptMeVMk+SDKAn1N/8bEAIw7o7OcUN/wf0q/UM2ChLDndRSFqw9pPV1H+hTzHHlH79AgJIzxxF6KMSOil/kc6+NEn28q3Qv3U5aacW1Q6XZ2nkkHzvCmkoNNNr2C4pq9S0+WtHtYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856272; c=relaxed/simple;
	bh=2SlnJHmPlDuK+fgBtBrvFTOHEH6WEGiqTrqh+qG1sxA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q1K0wF63qd/GapIAd2uKj+I1FlvBN7f52z4FqmD4zy+uvbOQpm513Vl2d3OnpiweZEL8Duodp+8sdUNfxTES4nreSwGXL/5RVN+8zJqw1MlusCrijgBD/vWukAWhRqou71WE769+KOR5CIrqtIQL7hCKDhN6MxSKaAJxV4/13XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dlByWcti; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dlByWcti"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-495437bb891so9755775e9.1
        for <linux-iio@vger.kernel.org>; Tue, 04 Aug 2026 08:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785856259; x=1786461059; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ByiV0EcJiWFn6vK/aEt02/DqNaTeEHfokj1WgdHKi5s=;
        b=dlByWctij2+koF91gYB8UXWm+5FhlUX2A12X7kR0B2DyGU/17bcK0Zuu2ToGG98xsI
         VfzV4u8eDYxaQn8Rz17ZD0BmKgsXahmMR1U838iuew9WA98snqfKO5dL3MZDWlU9SvGK
         OKbTzjyNimPv6edvMk4EBxi7GRmNQEDBmRA215UEggf5EH3zrIgNNsIARBLUq1W8ZlS2
         ZjIUSlYTDmVAOALEcsZ0dU+Mgq9fAKrjq2eUFGibR77iPRpe7kAjz8Yx41SDDsaK0gix
         JdXSnfpLRRsFpQQVO5DD+y6N9GGoxz0SYKQcPJ2J49q1UIHNtla/vNh07irT7C48mnqY
         tb4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785856259; x=1786461059;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ByiV0EcJiWFn6vK/aEt02/DqNaTeEHfokj1WgdHKi5s=;
        b=BtXIzWc6ukrAX4TBq+aIaycGaE7zvlWuOWxiH7fwrGW6zFEAQib0Q+fY8MH7rx1taq
         FHz/tCZ2ZkVt/qBUHBC79jImvAOCjX27DxxkT3mvyAl+ZqwQ0mzzzAdyANFm1aBDp4gc
         UDPq5vm2p9kvH7EkukRtYjmW5we/qL8iVAD80fcXeQfqSHWoyk8NmKX6B3E7i3TGbUA2
         OViLM0qJDXf9ftAnM1bytpl+WqF73yZtsKdS1v4ILRPWu5fJLXmgrHAC/DcEytd1aR/+
         u2wrJu3B5WWcyPnHpnvgDtgJkiZyHd9jgArl9xjWvHfMhRntLTZ4lgjcA3005CqJGYbq
         OgfQ==
X-Gm-Message-State: AOJu0Yyi680k6iQZg5EFrcEj6ug0gzhTy/+yQIwR/9/GjF5C6Bbbhipp
	7UZEZdJQ8NRxRvbegSv8iFk4u0mB2Z6N0Y9TNk1/pNpMD93q6Qv5qsoo
X-Gm-Gg: AR+sD11oUYCixyyq9qnsAqnX9MCR4fjwBZdgowqjfvbzt6qULb4ZWqlT+ozwOExToHk
	CO3JcGuioPyDE687MreeHNOWLov1w2KzEgUEnNdiIVs4pAKAi67lCgJNCK1jI3p4sYcW+CP9VF+
	wXTjMJPYNyQmqrLYHT4TsdVuB/R+kNhEudthO37GJIfQcWtXfIuQ74HbW90weMTPFnGhaPcsWPJ
	KTtfdvWi+TiOMAkferl6xGXQOZ9C4T3IYBRpaPY2nw53hSVa/UAdlfI+XQgnFNmvIjQOyCuvNy/
	28Mv6ZG7LeiKzpMeHqqcp9NWq7q5cm99iDHwYn3x1Jo4rY90kARYEZVEH5u/v852RMi7ZkCpDhT
	fDmCauwibiz7+vMs5vILYZyEaJTlFUAXwy4i4ijyP6rndCiDl8+lte/nBZcY9JkDtdNI68p82EM
	et7QX6ySK0c1Wtet2UQH36imBme8tcN10v899rVdG59sUXnSk05FLa
X-Received: by 2002:a7b:ce08:0:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49949f89850mr87767925e9.0.1785856258277;
        Tue, 04 Aug 2026 08:10:58 -0700 (PDT)
Received: from nsa ([148.63.225.166])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49949fc2b98sm102143605e9.2.2026.08.04.08.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2026 08:10:57 -0700 (PDT)
Date: Tue, 4 Aug 2026 16:12:07 +0100
From: Nuno =?utf-8?B?U8Oh?= <noname.nuno@gmail.com>
To: rodrigo.alencar@analog.com
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, linux-hardening@vger.kernel.org, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Philipp Zabel <p.zabel@pengutronix.de>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Kees Cook <kees@kernel.org>, 
	"Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH v10 10/17] iio: frequency: ad9910: initial driver
 implementation
Message-ID: <anIA101fhQ4BIdmp@nsa>
References: <20260729-ad9910-iio-driver-v10-0-aa1f6167729e@analog.com>
 <20260729-ad9910-iio-driver-v10-10-aa1f6167729e@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260729-ad9910-iio-driver-v10-10-aa1f6167729e@analog.com>

Hi Rodrigo,

Just a late small nit...

On Wed, Jul 29, 2026 at 09:25:37AM +0100, Rodrigo Alencar via B4 Relay wrote:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
> 
> Add the core AD9910 DDS driver infrastructure with single tone mode
> support. This includes SPI register access, profile management via GPIO
> pins, PLL/DAC configuration from firmware properties, and single tone
> frequency/phase/amplitude control through IIO attributes.
> 
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> +
> +static inline int ad9910_spi_read(struct ad9910_state *st, u8 reg, void *data,
> +				  size_t len)
> +{
> +	u8 inst = AD9910_SPI_READ_MSK | FIELD_PREP(AD9910_SPI_ADDR_MSK, reg);
> +
> +	return spi_write_then_read(st->spi, &inst, sizeof(inst), data, len);
> +}
> +
> +static inline int ad9910_spi_write(struct ad9910_state *st, u8 reg, size_t len,
> +				   bool update)
> +{
> +	int ret;
> +
> +	st->tx_buf[0] = FIELD_PREP(AD9910_SPI_ADDR_MSK, reg);
> +	ret = spi_write(st->spi, st->tx_buf, AD9910_SPI_DATA_IDX + len);
> +	if (ret)
> +		return ret;
> +
> +	if (update)
> +		return ad9910_io_update(st);
> +
> +	return 0;
> +}

I would really drop the inline here. It adds no value. Basically just an
hint and the compiler is smart enough to decide whether it should inline
the above or not.

- Nuno Sá

> +
> +#define AD9910_REG_READ_FN(nb)						\
> +static int ad9910_reg##nb##_read(struct ad9910_state *st, u8 reg,	\
> +				 u##nb * data)				\
> +{									\
> +	__be##nb be_data;						\
> +	int ret;							\
> +									\
> +	ret = ad9910_spi_read(st, reg, &be_data, sizeof(be_data));	\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	*data = be##nb##_to_cpu(be_data);				\
> +	return ret;							\
> +}
> +
> +AD9910_REG_READ_FN(16)
> +AD9910_REG_READ_FN(32)
> +AD9910_REG_READ_FN(64)
> +
> +#define AD9910_REG_WRITE_FN(nb)						\
> +static int ad9910_reg##nb##_write(struct ad9910_state *st, u8 reg,	\
> +				  u##nb data, bool update)		\
> +{									\
> +	int ret;							\
> +									\
> +	put_unaligned_be##nb(data, &st->tx_buf[AD9910_SPI_DATA_IDX]);	\
> +	ret = ad9910_spi_write(st, reg, sizeof(data), update);		\
> +	if (ret)							\
> +		return ret;						\
> +									\
> +	st->reg[reg].val##nb = data;					\
> +	return ret;							\
> +}
> +
> +AD9910_REG_WRITE_FN(16)
> +AD9910_REG_WRITE_FN(32)
> +AD9910_REG_WRITE_FN(64)
> +
> +#define AD9910_REG_UPDATE_FN(nb)					\
> +static int ad9910_reg##nb##_update(struct ad9910_state *st,		\
> +				   u8 reg, u##nb mask,			\
> +				   u##nb data, bool update)		\
> +{									\
> +	u##nb reg_val = (st->reg[reg].val##nb & ~mask) | (data & mask);	\
> +									\
> +	if (reg_val == st->reg[reg].val##nb && !update)			\
> +		return 0;						\
> +									\
> +	return ad9910_reg##nb##_write(st, reg, reg_val, update);	\
> +}
> +
> +AD9910_REG_UPDATE_FN(16)
> +AD9910_REG_UPDATE_FN(32)
> +AD9910_REG_UPDATE_FN(64)
> +
> +static int ad9910_set_dac_current(struct ad9910_state *st, u32 val_uA,
> +				  bool update)
> +{
> +	u32 code;
> +
> +	/* FSC = (86.4 / Rset) * (1 + CODE/96) where Rset = 10k ohms */
> +	val_uA = clamp(val_uA, AD9910_DAC_IOUT_MIN_uA, AD9910_DAC_IOUT_MAX_uA);
> +	code = DIV_ROUND_CLOSEST(val_uA - AD9910_DAC_IOUT_MIN_uA, 90);
> +	st->data.output_current_uA = AD9910_DAC_IOUT_MIN_uA + code * 90;
> +
> +	return ad9910_reg32_write(st, AD9910_REG_AUX_DAC, code, update);
> +}
> +
> +static int ad9910_set_sysclk_freq(struct ad9910_state *st, u32 freq_hz,
> +				  bool update)
> +{
> +	struct device *dev = &st->spi->dev;
> +	unsigned long refclk_freq_hz;
> +	u32 sysclk_freq_hz;
> +	u32 tmp32, vco_sel;
> +	int ret;
> +
> +	if (!freq_hz || freq_hz > AD9910_MAX_SYSCLK_HZ)
> +		return -EINVAL;
> +
> +	refclk_freq_hz = clk_get_rate(st->refclk);
> +	if (st->data.pll_enabled) {
> +		if (refclk_freq_hz < AD9910_PLL_IN_MIN_FREQ_HZ ||
> +		    refclk_freq_hz > AD9910_PLL_IN_MAX_FREQ_HZ) {
> +			dev_err(dev,
> +				"REF_CLK freq %lu Hz is out of PLL input range\n",
> +				refclk_freq_hz);
> +			return -ERANGE;
> +		}
> +
> +		tmp32 = DIV_ROUND_CLOSEST(freq_hz, refclk_freq_hz);
> +		tmp32 = clamp(tmp32, DIV_ROUND_UP(AD9910_PLL_OUT_MIN_FREQ_HZ, refclk_freq_hz),
> +			      AD9910_PLL_OUT_MAX_FREQ_HZ / refclk_freq_hz);
> +		tmp32 = clamp(tmp32, AD9910_PLL_MIN_N, AD9910_PLL_MAX_N);
> +		sysclk_freq_hz = refclk_freq_hz * tmp32;
> +
> +		if (sysclk_freq_hz <= AD9910_VCO0_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 0;
> +		else if (sysclk_freq_hz <= AD9910_VCO1_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 1;
> +		else if (sysclk_freq_hz <= AD9910_VCO2_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 2;
> +		else if (sysclk_freq_hz <= AD9910_VCO3_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 3;
> +		else if (sysclk_freq_hz <= AD9910_VCO4_RANGE_AUTO_MAX_HZ)
> +			vco_sel = 4;
> +		else
> +			vco_sel = 5;
> +
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR3,
> +					  AD9910_CFR3_N_MSK | AD9910_CFR3_VCO_SEL_MSK,
> +					  FIELD_PREP(AD9910_CFR3_N_MSK, tmp32) |
> +					  FIELD_PREP(AD9910_CFR3_VCO_SEL_MSK, vco_sel),
> +					  update);
> +		if (ret)
> +			return ret;
> +	} else {
> +		if (refclk_freq_hz < AD9910_REFDIV2_MIN_FREQ_HZ ||
> +		    refclk_freq_hz > AD9910_REFDIV2_MAX_FREQ_HZ) {
> +			dev_err(dev,
> +				"REF_CLK freq %lu Hz is out of divider range\n",
> +				refclk_freq_hz);
> +			return -ERANGE;
> +		}
> +
> +		tmp32 = DIV_ROUND_CLOSEST(refclk_freq_hz, freq_hz);
> +		tmp32 = clamp(tmp32, 1U, 2U);
> +		sysclk_freq_hz = refclk_freq_hz / tmp32;
> +		tmp32 = AD9910_CFR3_VCO_SEL_MSK |
> +			FIELD_PREP(AD9910_CFR3_REFCLK_DIV_BYPASS_MSK, tmp32 % 2);
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR3,
> +					  AD9910_CFR3_VCO_SEL_MSK |
> +					  AD9910_CFR3_REFCLK_DIV_BYPASS_MSK,
> +					  tmp32, update);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	st->data.sysclk_freq_hz = sysclk_freq_hz;
> +
> +	return 0;
> +}
> +
> +static int ad9910_profile_set(struct ad9910_state *st, u8 profile)
> +{
> +	DECLARE_BITMAP(values, BITS_PER_TYPE(profile));
> +
> +	st->profile = profile;
> +	values[0] = profile;
> +	gpiod_multi_set_value_cansleep(st->gpio_profile, values);
> +
> +	return 0;
> +}
> +
> +static inline bool ad9910_sw_powerdown_get(struct ad9910_state *st)
> +{
> +	return FIELD_GET(AD9910_CFR1_SW_POWER_DOWN_MSK,
> +			 st->reg[AD9910_REG_CFR1].val32) ? true : false;
> +}
> +
> +static int ad9910_sw_powerdown_set(struct ad9910_state *st, bool enable)
> +{
> +	int ret;
> +
> +	if (ad9910_sw_powerdown_get(st) == enable)
> +		return 0;
> +
> +	/*
> +	 * When powering down, the DAC and AUX_DAC (SW1) must be powered down
> +	 * first, as they require an I/O update to take effect. The opposite is
> +	 * true when powering up, the DAC and AUX_DAC must be powered up last,
> +	 * i.e., after the DIGITAL and REFCLK_INPUT (SW0) power up.
> +	 */
> +	if (enable) {
> +		ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> +					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> +					  AD9910_CFR1_SW1_POWER_DOWN_MSK,
> +					  true);
> +		if (ret)
> +			return ret;
> +
> +		return ad9910_reg32_update(st, AD9910_REG_CFR1,
> +					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> +					   AD9910_CFR1_SW0_POWER_DOWN_MSK,
> +					   false);
> +	}
> +
> +	ret = ad9910_reg32_update(st, AD9910_REG_CFR1,
> +				  AD9910_CFR1_SW0_POWER_DOWN_MSK, 0, false);
> +	if (ret)
> +		return ret;
> +
> +	return ad9910_reg32_update(st, AD9910_REG_CFR1,
> +				   AD9910_CFR1_SW1_POWER_DOWN_MSK, 0, true);
> +}
> +
> +static ssize_t ad9910_ext_info_read(struct iio_dev *indio_dev,
> +				    uintptr_t private,
> +				    const struct iio_chan_spec *chan,
> +				    char *buf)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	int val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case AD9910_POWERDOWN:
> +		val = ad9910_sw_powerdown_get(st);
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return iio_format_value(buf, IIO_VAL_INT, 1, &val);
> +}
> +
> +static ssize_t ad9910_ext_info_write(struct iio_dev *indio_dev,
> +				     uintptr_t private,
> +				     const struct iio_chan_spec *chan,
> +				     const char *buf, size_t len)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u32 val32;
> +	int ret;
> +
> +	ret = kstrtou32(buf, 10, &val32);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case AD9910_POWERDOWN:
> +		ret = ad9910_sw_powerdown_set(st, val32 ? true : false);
> +		if (ret)
> +			return ret;
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return len;
> +}
> +
> +static const struct iio_chan_spec_ext_info ad9910_phy_ext_info[] = {
> +	{
> +		.name = "powerdown",
> +		.read = ad9910_ext_info_read,
> +		.write = ad9910_ext_info_write,
> +		.private = AD9910_POWERDOWN,
> +		.shared = IIO_SEPARATE,
> +	},
> +	{ }
> +};
> +
> +#define AD9910_PROFILE_CHAN(idx) {				\
> +	.type = IIO_ALTCURRENT,					\
> +	.indexed = 1,						\
> +	.output = 1,						\
> +	.channel = AD9910_CHANNEL_PROFILE_ ## idx,		\
> +	.address = AD9910_CHAN_IDX_PROFILE_ ## idx,		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_ENABLE) |	\
> +			      BIT(IIO_CHAN_INFO_FREQUENCY) |	\
> +			      BIT(IIO_CHAN_INFO_PHASE) |	\
> +			      BIT(IIO_CHAN_INFO_RAW),		\
> +	.parent = &ad9910_channels[AD9910_CHAN_IDX_PHY],	\
> +}
> +
> +static const struct iio_chan_spec ad9910_channels[] = {
> +	[AD9910_CHAN_IDX_PHY] = {
> +		.type = IIO_ALTCURRENT,
> +		.indexed = 1,
> +		.output = 1,
> +		.channel = AD9910_CHANNEL_PHY,
> +		.address = AD9910_CHAN_IDX_PHY,
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),
> +		.ext_info = ad9910_phy_ext_info,
> +	},
> +	[AD9910_CHAN_IDX_PROFILE_0] = AD9910_PROFILE_CHAN(0),
> +	[AD9910_CHAN_IDX_PROFILE_1] = AD9910_PROFILE_CHAN(1),
> +	[AD9910_CHAN_IDX_PROFILE_2] = AD9910_PROFILE_CHAN(2),
> +	[AD9910_CHAN_IDX_PROFILE_3] = AD9910_PROFILE_CHAN(3),
> +	[AD9910_CHAN_IDX_PROFILE_4] = AD9910_PROFILE_CHAN(4),
> +	[AD9910_CHAN_IDX_PROFILE_5] = AD9910_PROFILE_CHAN(5),
> +	[AD9910_CHAN_IDX_PROFILE_6] = AD9910_PROFILE_CHAN(6),
> +	[AD9910_CHAN_IDX_PROFILE_7] = AD9910_PROFILE_CHAN(7),
> +};
> +
> +static int ad9910_read_raw(struct iio_dev *indio_dev,
> +			   struct iio_chan_spec const *chan,
> +			   int *val, int *val2, long info)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u64 tmp64;
> +	u32 tmp32;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			if (ad9910_sw_powerdown_get(st)) {
> +				*val = 0;
> +			} else {
> +				tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +				*val = (tmp32 == st->profile);
> +			}
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_FTW_MSK,
> +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		tmp64 *= st->data.sysclk_freq_hz;
> +		*val = tmp64 >> 32;
> +		*val2 = ((tmp64 & GENMASK_ULL(31, 0)) * MICRO) >> 32;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_PHASE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_GET(AD9910_PROFILE_ST_POW_MSK,
> +					  st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			break;
> +		default:
> +			return -EINVAL;
> +		}
> +		tmp32 = (tmp64 * AD9910_MAX_PHASE_MICRORAD) >> 16;
> +		*val = tmp32 / MICRO;
> +		*val2 = tmp32 % MICRO;
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			*val = FIELD_GET(AD9910_PROFILE_ST_ASF_MSK,
> +					 st->reg[AD9910_REG_PROFILE(tmp32)].val64);
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PHY:
> +			*val = st->data.sysclk_freq_hz;
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		case AD9910_CHAN_IDX_PHY:
> +			tmp64 = (u64)st->data.output_current_uA *
> +				AD9910_NANO_MILLIAMP_PER_MICROAMP;
> +			*val = 0;
> +			*val2 = tmp64 >> 14;
> +			return IIO_VAL_INT_PLUS_NANO;
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad9910_write_raw(struct iio_dev *indio_dev,
> +			    struct iio_chan_spec const *chan,
> +			    int val, int val2, long info)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	u64 tmp64;
> +	u32 tmp32;
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (info) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			if (!val) {
> +				if (tmp32 != st->profile)
> +					return 0; /* nothing to do */
> +
> +				return ad9910_sw_powerdown_set(st, true);
> +			}
> +
> +			ret = ad9910_sw_powerdown_set(st, false);
> +			if (ret)
> +				return ret;
> +
> +			return ad9910_profile_set(st, tmp32);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_FREQUENCY:
> +		if (val < 0 || val2 < 0 || val >= st->data.sysclk_freq_hz / 2)
> +			return -EINVAL;
> +
> +		tmp64 = ad9910_rational_scale((u64)val * MICRO + val2, BIT_ULL(32),
> +					      (u64)MICRO * st->data.sysclk_freq_hz);
> +		tmp64 = min_t(u64, tmp64, U32_MAX);
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_FTW_MSK, tmp64);
> +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
> +						   AD9910_PROFILE_ST_FTW_MSK,
> +						   tmp64, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_PHASE:
> +		if (val < 0 || val2 < 0)
> +			return -EINVAL;
> +
> +		tmp64 = (u64)val * MICRO + val2;
> +		if (tmp64 >= AD9910_MAX_PHASE_MICRORAD)
> +			return -EINVAL;
> +
> +		tmp64 = DIV_U64_ROUND_CLOSEST(tmp64 << 16, AD9910_MAX_PHASE_MICRORAD);
> +		tmp64 = min(tmp64, AD9910_POW_MAX);
> +
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_POW_MSK, tmp64);
> +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
> +						   AD9910_PROFILE_ST_POW_MSK,
> +						   tmp64, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			if (val < 0)
> +				return -EINVAL;
> +
> +			tmp32 = chan->channel - AD9910_CHANNEL_PROFILE_0;
> +			tmp64 = FIELD_PREP(AD9910_PROFILE_ST_ASF_MSK,
> +					   min_t(u64, val, AD9910_ASF_MAX));
> +			return ad9910_reg64_update(st, AD9910_REG_PROFILE(tmp32),
> +						   AD9910_PROFILE_ST_ASF_MSK,
> +						   tmp64, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return ad9910_set_sysclk_freq(st, val, true);
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->address) {
> +		case AD9910_CHAN_IDX_PHY:
> +			if (val != 0 || val2 < 0)
> +				return -EINVAL;
> +
> +			tmp32 = DIV_U64_ROUND_CLOSEST((u64)val2 << 14,
> +						      AD9910_NANO_MILLIAMP_PER_MICROAMP);
> +			return ad9910_set_dac_current(st, tmp32, true);
> +		default:
> +			return -EINVAL;
> +		}
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad9910_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				    struct iio_chan_spec const *chan,
> +				    long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_ENABLE:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_FREQUENCY:
> +	case IIO_CHAN_INFO_PHASE:
> +		return IIO_VAL_INT_PLUS_MICRO;
> +	case IIO_CHAN_INFO_RAW:
> +		switch (chan->channel) {
> +		case AD9910_CHANNEL_PROFILE_0 ... AD9910_CHANNEL_PROFILE_7:
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int ad9910_debugfs_reg_access(struct iio_dev *indio_dev,
> +				     unsigned int reg, u64 writeval,
> +				     u64 *readval)
> +{
> +	struct ad9910_state *st = iio_priv(indio_dev);
> +	union ad9910_reg tmp;
> +	int ret;
> +
> +	if (reg >= AD9910_REG_RAM)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (reg) {
> +	case AD9910_REG_DRG_LIMIT:
> +	case AD9910_REG_DRG_STEP:
> +	case AD9910_REG_PROFILE0 ... AD9910_REG_PROFILE7:
> +		if (!readval)
> +			return ad9910_reg64_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg64_read(st, reg, &tmp.val64);
> +		if (ret)
> +			return ret;
> +		*readval = tmp.val64;
> +		return 0;
> +	case AD9910_REG_POW:
> +		if (!readval)
> +			return ad9910_reg16_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg16_read(st, reg, &tmp.val16);
> +		if (ret)
> +			return ret;
> +		*readval = tmp.val16;
> +		return 0;
> +	default:
> +		if (!readval)
> +			return ad9910_reg32_write(st, reg, writeval, true);
> +
> +		ret = ad9910_reg32_read(st, reg, &tmp.val32);
> +		if (ret)
> +			return ret;
> +		*readval = tmp.val32;
> +		return 0;
> +	}
> +}
> +
> +static const char * const ad9910_channel_str[] = {
> +	[AD9910_CHAN_IDX_PHY] = "phy",
> +	[AD9910_CHAN_IDX_PROFILE_0] = "profile0",
> +	[AD9910_CHAN_IDX_PROFILE_1] = "profile1",
> +	[AD9910_CHAN_IDX_PROFILE_2] = "profile2",
> +	[AD9910_CHAN_IDX_PROFILE_3] = "profile3",
> +	[AD9910_CHAN_IDX_PROFILE_4] = "profile4",
> +	[AD9910_CHAN_IDX_PROFILE_5] = "profile5",
> +	[AD9910_CHAN_IDX_PROFILE_6] = "profile6",
> +	[AD9910_CHAN_IDX_PROFILE_7] = "profile7",
> +};
> +
> +static int ad9910_read_label(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     char *label)
> +{
> +	return sysfs_emit(label, "%s\n", ad9910_channel_str[chan->address]);
> +}
> +
> +static const struct iio_info ad9910_info = {
> +	.read_raw = ad9910_read_raw,
> +	.write_raw = ad9910_write_raw,
> +	.write_raw_get_fmt = ad9910_write_raw_get_fmt,
> +	.read_label = ad9910_read_label,
> +	.debugfs_reg64_access = &ad9910_debugfs_reg_access,
> +};
> +
> +static int ad9910_cfg_sysclk(struct ad9910_state *st, bool update)
> +{
> +	u32 cfr3 = AD9910_CFR3_OPEN_MSK;
> +	u32 tmp32;
> +
> +	cfr3 |= FIELD_PREP(AD9910_CFR3_DRV0_MSK, st->data.refclk_out_drv);
> +
> +	if (st->data.pll_enabled) {
> +		tmp32 = st->data.pll_charge_pump_current - AD9910_ICP_MIN_uA;
> +		tmp32 = DIV_ROUND_CLOSEST(tmp32, AD9910_ICP_STEP_uA);
> +		cfr3 |= FIELD_PREP(AD9910_CFR3_ICP_MSK, tmp32) |
> +			AD9910_CFR3_PLL_EN_MSK;
> +	} else {
> +		cfr3 |= AD9910_CFR3_ICP_MSK |
> +			AD9910_CFR3_REFCLK_DIV_RESETB_MSK |
> +			AD9910_CFR3_PFD_RESET_MSK;
> +	}
> +	st->reg[AD9910_REG_CFR3].val32 = cfr3;
> +
> +	return ad9910_set_sysclk_freq(st, AD9910_MAX_SYSCLK_HZ, update);
> +}
> +
> +static int ad9910_parse_fw(struct ad9910_state *st)
> +{
> +	static const char * const refclk_out_drv0[] = {
> +		"disabled", "low", "medium", "high",
> +	};
> +	struct device *dev = &st->spi->dev;
> +	const char *prop;
> +	u32 tmp;
> +	int ret;
> +
> +	st->data.pll_enabled = device_property_read_bool(dev, "adi,pll-enable");
> +	if (st->data.pll_enabled) {
> +		prop = "adi,charge-pump-current-microamp";
> +		if (device_property_present(dev, prop)) {
> +			ret = device_property_read_u32(dev, prop, &tmp);
> +			if (ret)
> +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> +
> +			if (tmp < AD9910_ICP_MIN_uA || tmp > AD9910_ICP_MAX_uA)
> +				return dev_err_probe(dev, -ERANGE,
> +						     "invalid charge pump current %u\n", tmp);
> +		} else {
> +			tmp = AD9910_ICP_MIN_uA;
> +		}
> +		st->data.pll_charge_pump_current = tmp;
> +
> +		prop = "adi,refclk-out-drive-strength";
> +		if (device_property_present(dev, prop)) {
> +			ret = device_property_match_property_string(dev, prop,
> +								    refclk_out_drv0,
> +								    ARRAY_SIZE(refclk_out_drv0));
> +			if (ret < 0)
> +				return dev_err_probe(dev, ret, "property read: %s\n", prop);
> +
> +			st->data.refclk_out_drv = ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static void ad9910_sw_powerdown_action(void *data)
> +{
> +	ad9910_sw_powerdown_set(data, true);
> +}
> +
> +static void ad9910_hw_powerdown_action(void *data)
> +{
> +	struct ad9910_state *st = data;
> +
> +	gpiod_set_value_cansleep(st->gpio_pwdown, 1);
> +}
> +
> +static int ad9910_setup(struct device *dev, struct ad9910_state *st,
> +			struct reset_control *dev_rst)
> +{
> +	int ret;
> +
> +	ret = reset_control_assert(dev_rst);
> +	if (ret)
> +		return ret;
> +
> +	fsleep(AD9910_RESET_DELAY_us);
> +
> +	ret = reset_control_deassert(dev_rst);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR1,
> +				 (st->spi->mode & SPI_3WIRE ? 0 :
> +				 AD9910_CFR1_SDIO_INPUT_ONLY_MSK), false);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_add_action_or_reset(dev, ad9910_sw_powerdown_action, st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_reg32_write(st, AD9910_REG_CFR2,
> +				 AD9910_CFR2_AMP_SCALE_SINGLE_TONE_MSK |
> +				 AD9910_CFR2_SYNC_TIMING_VAL_DISABLE_MSK |
> +				 AD9910_CFR2_DRG_NO_DWELL_MSK |
> +				 AD9910_CFR2_DATA_ASM_HOLD_LAST_MSK |
> +				 AD9910_CFR2_SYNC_CLK_EN_MSK |
> +				 AD9910_CFR2_PDCLK_ENABLE_MSK, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_cfg_sysclk(st, false);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_set_dac_current(st, AD9910_DAC_IOUT_DEFAULT_uA, false);
> +	if (ret)
> +		return ret;
> +
> +	return ad9910_io_update(st);
> +}
> +
> +static int ad9910_probe(struct spi_device *spi)
> +{
> +	static const char * const supplies[] = {
> +		"dvdd-io33", "avdd33", "dvdd18", "avdd18",
> +	};
> +	struct device *dev = &spi->dev;
> +	struct reset_control *dev_rst;
> +	struct gpio_desc *io_rst_gpio;
> +	struct iio_dev *indio_dev;
> +	struct ad9910_state *st;
> +	int ret;
> +
> +	indio_dev = devm_iio_device_alloc(dev, sizeof(*st));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	st = iio_priv(indio_dev);
> +	st->spi = spi;
> +
> +	indio_dev->name = "ad9910";
> +	indio_dev->info = &ad9910_info;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->channels = ad9910_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(ad9910_channels);
> +
> +	ret = devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(supplies), supplies);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to get regulators\n");
> +
> +	st->refclk = devm_clk_get_enabled(dev, "ref_clk");
> +	if (IS_ERR(st->refclk))
> +		return dev_err_probe(dev, PTR_ERR(st->refclk),
> +				     "Failed to get reference clock\n");
> +
> +	dev_rst = devm_reset_control_get_optional_exclusive(dev, NULL);
> +	if (IS_ERR(dev_rst))
> +		return dev_err_probe(dev, PTR_ERR(dev_rst),
> +				     "failed to get device reset control\n");
> +
> +	/*
> +	 * The IO RESET pin is not used in this driver, as we assume that all
> +	 * SPI transfers are complete, but if it is wired up, we need to make
> +	 * sure it is not floating. We can use either a reset controller or a
> +	 * GPIO for this.
> +	 */
> +	io_rst_gpio = devm_gpiod_get_optional(dev, "io-reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(io_rst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(io_rst_gpio),
> +				     "failed to get io reset gpio\n");
> +
> +	st->gpio_update = devm_gpiod_get_optional(dev, "update", GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_update))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_update),
> +				     "failed to get update gpio\n");
> +
> +	st->gpio_profile = devm_gpiod_get_array_optional(dev, "profile",
> +							 GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_profile))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_profile),
> +				     "failed to get profile gpios\n");
> +
> +	if (st->gpio_profile && st->gpio_profile->ndescs != 3)
> +		return dev_err_probe(dev, -EINVAL,
> +				     "invalid number of profile gpios\n");
> +
> +	st->gpio_pwdown = devm_gpiod_get_optional(dev, "powerdown",
> +						  GPIOD_OUT_LOW);
> +	if (IS_ERR(st->gpio_pwdown))
> +		return dev_err_probe(dev, PTR_ERR(st->gpio_pwdown),
> +				     "failed to get powerdown gpio\n");
> +
> +	ret = devm_add_action_or_reset(dev, ad9910_hw_powerdown_action, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to add hw powerdown action\n");
> +
> +	fsleep(AD9910_WAKEUP_DELAY_us);
> +
> +	ret = ad9910_parse_fw(st);
> +	if (ret)
> +		return ret;
> +
> +	ret = ad9910_setup(dev, st, dev_rst);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "device setup failed\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}
> +
> +static const struct spi_device_id ad9910_id[] = {
> +	{ .name = "ad9910" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, ad9910_id);
> +
> +static const struct of_device_id ad9910_of_match[] = {
> +	{ .compatible = "adi,ad9910" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, ad9910_of_match);
> +
> +static struct spi_driver ad9910_driver = {
> +	.driver = {
> +		.name = "ad9910",
> +		.of_match_table = ad9910_of_match,
> +	},
> +	.probe = ad9910_probe,
> +	.id_table = ad9910_id,
> +};
> +module_spi_driver(ad9910_driver);
> +
> +MODULE_AUTHOR("Rodrigo Alencar <rodrigo.alencar@analog.com>");
> +MODULE_DESCRIPTION("Analog Devices AD9910 DDS driver");
> +MODULE_LICENSE("GPL");
> 
> -- 
> 2.43.0
> 
> 
