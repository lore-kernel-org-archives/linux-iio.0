Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5B474B049E;
	Fri,  7 Aug 2026 00:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786062499; cv=none; b=lr87W29SfEzB8Pzmyrx3PLQDHGbJHoagwX3r12Jy5VR+1kcaHy5M/YNpHU9Q0wU5XHAQRcDwqZH448GAydwaua2aNUl6CeacW2MQ5cQ/bbWnGyO41F267nmR/ySd0jNi2HJwDdRqwNxDr6I6lenth+K8RUbfQd/ht5AuhDCuov8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786062499; c=relaxed/simple;
	bh=fAgGaE7Bge7S6Gvxnw+mbjQTtNJx336SuDBx1Mmjl5o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GvvEVYBKZ1drmDhyNuy75r+3v8eNlTvJ1WVJvDrB/dIeKMidWIaabchCM8RzqvHrZjDxM/F4T+38Zj3w0Uy8C/qgIfGuUX99gf/iOSHDoDf4M2uH4EqOU8wxkFY7Z0hYW4mlZogSA/zLUPUJ4pt32FL6dLmu+kh9aBTngkkqriw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Rg+TQJFY; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Rg+TQJFY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1786062496; x=1817598496;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=fAgGaE7Bge7S6Gvxnw+mbjQTtNJx336SuDBx1Mmjl5o=;
  b=Rg+TQJFYj96zOcSGq1E3WwPKphcI6n0RuOFaEa/poLkg6vLpF+lYSu/B
   XTs1yjJT6uzNq2ABVaftiqGJbncwIH9RoGk+j0qecnSfF6ddUn3L2Jhvy
   uE2uBFNUtePuXhEYMkIO5AADEvEIy4us7wIyTFZM5uOChNU/rSrkC+rbK
   cvs88SExvnYvu0dKUM/KwLl0ek74ee15ApPTnlYK2MHfjFhxi8BmDJK5D
   Wqt6RDYT2K/b8tsj2Tw0DRilD7vleNakHKdd0KLZW1LCrcnKyS5tIj+JN
   r2db+v8d/19op6GXFWTlhWedku/J157tqpYGV0C7km1AzNhbOEnCqkc2m
   Q==;
X-CSE-ConnectionGUID: /YGsjPOXTFO19Tb+3X+PgA==
X-CSE-MsgGUID: EAQ8Qv7lQAGBENwDRqHaAQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11867"; a="86698543"
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="86698543"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:28:16 -0700
X-CSE-ConnectionGUID: VdCM8yGyT0GEhqCkxTkFiQ==
X-CSE-MsgGUID: bX2hfQQfS9yLhbIgVnb5zw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,209,1779174000"; 
   d="scan'208";a="266088332"
Received: from ettammin-mobl3.ger.corp.intel.com (HELO localhost) ([10.245.245.50])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2026 17:28:10 -0700
Date: Fri, 7 Aug 2026 03:28:08 +0300
From: Andy Shevchenko <andriy.shevchenko@intel.com>
To: Janani Sunil <janani.sunil@analog.com>
Cc: Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Olivier Moysan <olivier.moysan@foss.st.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Michael Walle <mwalle@kernel.org>, linux@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>
Subject: Re: [PATCH v2 4/7] iio: adc: Add AD7768 IIO Driver support
Message-ID: <anUmmKFMEJyc5tW7@ashevche-desk.local>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
 <20260806-ad7768-driver-v2-4-027ac5e2a641@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260806-ad7768-driver-v2-4-027ac5e2a641@analog.com>
Organization: Intel Finland Oy - BIC 0357606-4 - c/o Alberga Business Park, 6
 krs, Bertel Jungin Aukio 5, 02600 Espoo

On Thu, Aug 06, 2026 at 05:41:23PM +0200, Janani Sunil wrote:
> Add support for AD7768 4/8 channel,simultaneous sampling Sigma-Delta
> ADCs. The driver supports configurable decimation filters, per-channel
> conversion delay, VCM regulation, runtime PM and IIO backend data
> capture.

Can you split this to the basic minimum + patch per feature?

1.7k LoC is too much for a review, the usual size is ~750±150 per patch.
Here sounds like 3+ patches.

...

> +#define   AD7768_PICO_PER_SEC			1000000000000ULL

Don't we have this in time.h (beneath it somewhere)?

...

> +struct ad7768_freq_config {
> +	unsigned int freq;

freq_Hz?

> +	unsigned int dec_rate;
> +};

...

> +struct ad7768_avail_freq {
> +	unsigned int n_freqs;
> +	int freqs[MAX_FREQ_PER_MODE];

Negative frequency?

> +	struct ad7768_freq_config freq_cfg[MAX_FREQ_PER_MODE];
> +};

...

> +struct ad7768_state {
> +	struct spi_device *spi;
> +	struct regmap *regmap;

One of them seems redundant. Is regmap created out from &spi->dev?

> +	struct mutex lock; /* Protects device register access and configuration */
> +	struct clk *mclk;
> +	unsigned int datalines;
> +	enum ad7768_power_modes power_mode;
> +	const struct ad7768_chip_info *chip_info;
> +	struct ad7768_avail_freq avail_freq[AD7768_NUM_POWER_MODES];
> +	unsigned int n_freqs;
> +	int freqs[AD7768_MAX_FREQS];
> +	unsigned int chn_mode[AD7768_MAX_CHANNEL];
> +	unsigned int ch_freq[AD7768_MAX_CHANNEL];
> +	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
> +	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
> +	struct iio_backend *back;
> +	struct regulator_dev *vcm_rdev;
> +	unsigned int avdd1_uv;

_uV

> +
> +	__be16 d16 __aligned(IIO_DMA_MINALIGN);
> +};

...

> +static const unsigned int ad7768_vcm_voltage_table[] = {
> +	0, 1650000, 2500000, 2140000

In this case, keep trailing comma.

> +};

...

> +static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
> +{
> +	struct ad7768_state *st = rdev_get_drvdata(rdev);
> +	unsigned int val;
> +	int ret;
> +
> +	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(&st->spi->dev, pm);
> +	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_read(st->regmap, AD7768_REG_GENERAL_CONFIG, &val);
> +	if (ret)
> +		return ret;
> +
> +	return !(val & AD7768_GEN_CONFIG_VCM_PD);

regmap_test_bits() ?

> +}

...

> +static const int ad7768_dec_rate[MAX_FREQ_PER_MODE] = {
> +	32, 64, 128, 256, 512, 1024

Even in the very same page you have inconsistent approach. Make sure your code
is consistent in every aspect. Two+ people wrote the driver?

> +};
> +
> +static const int ad7768_mclk_div[3] = {
> +	32, 8, 4
> +};
> +
> +static const unsigned int ad7768_available_datalines[] = {
> +	1, 2, 8,
> +};
> +
> +static const unsigned int ad7768_4_available_datalines[] = {
> +	1, 4,
> +};
> +
> +static const u8 ad7768_chan_map[] = {
> +	0, 1, 2, 3, 4, 5, 6, 7,
> +};
> +
> +static const u8 ad7768_4_chan_map[] = {
> +	0, 1, 4, 5,
> +};

...

> +static int ad7768_set_power_mode(struct ad7768_state *st, unsigned int mode);

Can forward decl be avoided?

...

> +static u8 ad7768_all_channels_mask(const struct ad7768_state *st)
> +{
> +	u8 mask = 0;
> +	unsigned int ch;
> +
> +	for (ch = 0; ch < st->chip_info->num_channels; ch++)

	for (unsigned int ch = 0; ch < st->chip_info->num_channels; ch++)

> +		mask |= ad7768_channel_mask(st, ch);
> +
> +	return mask;
> +}

...

> +static int ad7768_regmap_read(void *context, const void *reg_buf,
> +			      size_t reg_size, void *val_buf, size_t val_size)
> +{
> +	struct spi_device *spi = context;
> +	struct ad7768_state *st = spi_get_drvdata(spi);
> +	u8 *data_val = val_buf;
> +	unsigned int reg;
> +	int ret;
> +	struct spi_transfer t[] = {
> +		{
> +			.tx_buf = &st->d16,
> +			.len = 2,
> +			.cs_change = 1,
> +		}, {
> +			/*
> +			 * The second transfer clocks out the readback data, so
> +			 * we must provide dummy TX bytes while receiving the
> +			 * response. The device ignores MOSI in this phase, so
> +			 * reuse st->d16 for both TX and RX.
> +			 */
> +			.tx_buf = &st->d16,
> +			.rx_buf = &st->d16,
> +			.len = 2,
> +		},
> +	};
> +
> +	reg = *(const u8 *)reg_buf;
> +
> +	st->d16 = cpu_to_be16(AD7768_SPI_READ_CMD |
> +			      FIELD_PREP(AD7768_SPI_REG_MASK, reg));

be16_replace_bits() ?

> +	ret = spi_sync_transfer(spi, t, ARRAY_SIZE(t));
> +	if (ret)
> +		return ret;
> +
> +	*data_val = FIELD_GET(AD7768_SPI_DATA_MASK, be16_to_cpu(st->d16));

be16_get_bits()?

> +	return ret;
> +}

...

> +static int ad7768_read_calib_value(struct ad7768_state *st,
> +				   unsigned int base_reg, unsigned int *val)
> +{
> +	u8 data[3];
> +	int ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_bulk_read(st->regmap, base_reg, data, ARRAY_SIZE(data));
> +	if (ret)
> +		return ret;
> +
> +	*val = (data[0] << 16) | (data[1] << 8) | data[2];

get_unaligned_be24()

> +	return 0;
> +}

> +static int ad7768_write_calib_value(struct ad7768_state *st,
> +				    unsigned int base_reg, unsigned int val)
> +{
> +	int ret;
> +
> +	if (val > AD7768_CALIB_REG_MSK)
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);
> +
> +	ret = regmap_write(st->regmap, base_reg,
> +			   FIELD_GET(AD7768_CALIB_REG_MSB_MSK, val));
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_write(st->regmap, base_reg + 1,
> +			   FIELD_GET(AD7768_CALIB_REG_MID_MSK, val));
> +	if (ret)
> +		return ret;
> +
> +	return regmap_write(st->regmap, base_reg + 2,
> +			    FIELD_GET(AD7768_CALIB_REG_LSB_MSK, val));

Can you prepare value and use bulk write? Probably you want
put_unaligned_be24().

> +}

...

> +static int ad7768_set_clk_divs(struct ad7768_state *st,
> +			       unsigned int freq)
> +{
> +	unsigned int mclk, dclk, dclk_div, i;
> +	struct ad7768_freq_config f_cfg = {};
> +	unsigned int chan_per_doutx;
> +
> +	mclk = clk_get_rate(st->mclk);
> +
> +	chan_per_doutx = st->chip_info->num_channels / st->datalines;
> +	if (!chan_per_doutx)
> +		return -EINVAL;
> +
> +	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
> +		f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
> +		if (freq == f_cfg.freq)
> +			break;
> +	}
> +
> +	if (i == st->avail_freq[st->power_mode].n_freqs)
> +		return -EINVAL;
> +
> +	dclk = f_cfg.freq * AD7768_SAMPLE_SIZE * chan_per_doutx;
> +	if (dclk > mclk)
> +		return -EINVAL;
> +
> +	/* Set dclk_div to the nearest power of 2 less than the original value */
> +	dclk_div = DIV_ROUND_CLOSEST_ULL(mclk, dclk);

_ULL for sure?! Please, use 32-bit arithmetics for 32-bit values (yes, 32-bit,
they never be 64 in real life).

> +	if (dclk_div > AD7768_MAX_DCLK_DIV)
> +		dclk_div = AD7768_MAX_DCLK_DIV;
> +	else if (dclk_div > 0 && hweight32(dclk_div) != 1)
> +		dclk_div = 1 << (fls(dclk_div) - 1);

rounddown_pow_of_two() ?

> +	return regmap_update_bits(st->regmap, AD7768_REG_INTERFACE_CFG,
> +				  AD7768_INTERFACE_CFG_DCLK_DIV_MSK,
> +				  AD7768_INTERFACE_CFG_DCLK_DIV_MODE(dclk_div));
> +}

...

> +static bool ad7768_freq_supported(const struct ad7768_state *st,
> +				  unsigned int mode, unsigned int freq)
> +{
> +	unsigned int i;
> +
> +	for (i = 0; i < st->avail_freq[mode].n_freqs; i++) {

	for (unsigned int i = 0; i < st->avail_freq[mode].n_freqs; i++) {

> +		if (freq == st->avail_freq[mode].freq_cfg[i].freq)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +
> +static bool ad7768_freq_supported_in_any_mode(const struct ad7768_state *st,
> +					      unsigned int freq)
> +{
> +	unsigned int mode;
> +
> +	for (mode = 0; mode < AD7768_NUM_POWER_MODES; mode++) {

Ditto.

> +		if (ad7768_freq_supported(st, mode, freq))
> +			return true;
> +	}
> +
> +	return false;
> +}

...

> +static int ad7768_set_lowest_noise_mode(struct ad7768_state *st,
> +					const unsigned long *scan_mask)
> +{
> +	unsigned int channel;
> +	unsigned int mode;
> +
> +	/*
> +	 * The output data rate ranges overlap between the power modes. At a
> +	 * common ODR, the faster mode has lower noise, so prefer the fastest
> +	 * mode that supports every enabled channel.
> +	 */
> +	for (mode = AD7768_NUM_POWER_MODES; mode-- > 0;) {

	unsigned int mode = AD7768_NUM_POWER_MODES;
	...
	while (mode--) {

> +		for (channel = 0; channel < st->chip_info->num_channels; channel++) {
> +			if (test_bit(channel, scan_mask) &&
> +			    !ad7768_freq_supported(st, mode, st->ch_freq[channel]))
> +				break;
> +		}
> +
> +		if (channel == st->chip_info->num_channels)
> +			return ad7768_set_power_mode(st, mode);
> +	}
> +
> +	return -EINVAL;
> +}

...

> +	struct ad7768_state *st = iio_priv(indio_dev);
> +
> +	if (!freq)
> +		return -EINVAL;
> +
> +	if (!ad7768_freq_supported_in_any_mode(st, freq))
> +		return -EINVAL;
> +
> +	guard(mutex)(&st->lock);

+ blank line here.

> +	st->ch_freq[ch] = freq;
> +
> +	return 0;

...

> +static int ad7768_get_freq_cfg(struct ad7768_state *st, unsigned int freq,
> +			       struct ad7768_freq_config *f_cfg)
> +{
> +	unsigned int i;

Embed into for-loop.

> +	for (i = 0; i < st->avail_freq[st->power_mode].n_freqs; i++) {
> +		*f_cfg = st->avail_freq[st->power_mode].freq_cfg[i];
> +		if (freq == f_cfg->freq)
> +			return 0;
> +	}
> +
> +	return -EINVAL;
> +}

...

> +static void ad7768_filter_wait(const unsigned int *mode_freq,
> +			       const enum ad7768_filter_type *mode_filter,
> +			       const bool *mode_used)
> +{
> +	unsigned long t_settle_us = 0;
> +	unsigned int mode;
> +
> +	for (mode = 0; mode < AD7768_NUM_CHANNEL_MODES; mode++) {
> +		unsigned long t_mode_us;

Hmm... Are you sure about the type? Shouldn't it be always 64-bit (or 32-bit)?

> +		unsigned int settling_samples;
> +
> +		if (!mode_used[mode] || !mode_freq[mode])
> +			continue;
> +
> +		if (mode_filter[mode] == AD7768_FILTER_TYPE_SINC5)
> +			settling_samples = AD7768_SINC5_SETTLING_SAMPLES;
> +		else
> +			settling_samples = AD7768_WIDEBAND_SETTLING_SAMPLES;
> +
> +		t_mode_us = DIV_ROUND_UP_ULL((u64)settling_samples *
> +					     USEC_PER_SEC,
> +					     mode_freq[mode]);
> +		t_settle_us = max(t_settle_us, t_mode_us);
> +	}
> +
> +	if (t_settle_us)
> +		fsleep(t_settle_us);
> +}

...

I stopped here as this is too much and unreviewable bulk.

-- 
With Best Regards,
Andy Shevchenko


