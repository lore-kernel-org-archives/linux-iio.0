Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205E633120D;
	Sat,  7 Feb 2026 17:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770484916; cv=none; b=rzXrSphWB7MUb9yEG9IrpFwfBTG/Zg1n8nXxNbdJtpmCT4gydYXKTtx0WLYMhagKJpdgPdlAUrZa9iOceSybGNvOz4Yt2qmFi1Xn4nn7JwrBLPmuwd9WgSHZb3Jqp4TI8nl73NcxtZvNih58i9Hw9sOotx7eB8kfD9+zKjwcYpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770484916; c=relaxed/simple;
	bh=Aqpo56yk+mxHb8J1mIsr07bTon0Kq4cNgEgu5WcNQz0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qe6wydxgDKl2koZi5HwTSJIZQbOk2rUStRZ8FSZKSoLqcA1AvGV00hSWzkWDqDmOj35v0otXKuHN40yjm/DdW2e1jkxEG845uvCB1+/RvNjYBWzVo6USuZrHxv8YamDdpOKMzT0pcNjPsiv5HphBUiRN9+UcfSgEC+0nEg5GeJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNfI52V2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNfI52V2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74EC2C116D0;
	Sat,  7 Feb 2026 17:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770484915;
	bh=Aqpo56yk+mxHb8J1mIsr07bTon0Kq4cNgEgu5WcNQz0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=tNfI52V2WgNu+x7JPzuCkMQCeVE5rxkBPku163NmM4ZLF1LPRTtDPgzujP0jp4hqf
	 h7pOxWtzTSU0Zl71S1BjDtBj2WR6McdxmnkqCSaRSJOMhroiTakC8OoXF5QlqWv8/p
	 2Y/20tZPhcIV9cKKesZC5UlVY/nSr2H15In4WHTGaNKQ8t9jtu+uu+lS8hmd29ey4i
	 YHBGmGwb0e4R6ZukKeEjG733i5yzLo8G214YsyB9Kil6TRDyQaddAICtuJ/XCAUCtr
	 //96mjkqE/qHuLnY7Jxcj3QLt0Iz5WrZ7GI1nZIMpsV1NACntyT09ePQfxH9+QpUX4
	 REtNh+CDGukpA==
Date: Sat, 7 Feb 2026 17:21:45 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>
Subject: Re: [PATCH v6 4/8] iio: frequency: adf41513: driver implementation
Message-ID: <20260207172145.3e69ac06@jic23-huawei>
In-Reply-To: <20260130-adf41513-iio-driver-v6-4-cf46239026bc@analog.com>
References: <20260130-adf41513-iio-driver-v6-0-cf46239026bc@analog.com>
	<20260130-adf41513-iio-driver-v6-4-cf46239026bc@analog.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 30 Jan 2026 10:06:45 +0000
Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org=
> wrote:

> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> The driver is based on existing PLL drivers in the IIO subsystem and
> implements the following key features:
>=20
> - Integer-N and fractional-N (fixed/variable modulus) synthesis modes
> - High-resolution frequency calculations using microhertz (=C2=B5Hz) prec=
ision
>   to handle sub-Hz resolution across multi-GHz frequency ranges
> - IIO debugfs interface for direct register access
> - FW property parsing from devicetree including charge pump settings,
>   reference path configuration and muxout options
> - Power management support with suspend/resume callbacks
> - Lock detect GPIO monitoring
>=20
> The driver uses 64-bit microhertz values throughout PLL calculations to
> maintain precision when working with frequencies that exceed 32-bit Hz
> representation while requiring fractional Hz resolution.
>=20
> When merging, ADF41513_HZ_PER_GHZ must be dropped in favor of
> HZ_PER_GHZ defined in linux/units.h.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

A few minor suggestions inline from a reread.

Thanks

Jonathan

> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf=
41513.c
> new file mode 100644
> index 000000000000..b2efd545c885
> --- /dev/null
> +++ b/drivers/iio/frequency/adf41513.c

> +
> +struct adf41513_state {
> +	const struct adf41513_chip_info *chip_info;
> +	struct spi_device *spi;
> +	struct gpio_desc *lock_detect;
> +	struct gpio_desc *chip_enable;
> +	struct clk *ref_clk;
> +	u32 ref_freq_hz;
> +
> +	/*
> +	 * Lock for accessing device registers. Some operations require
> +	 * multiple consecutive R/W operations, during which the device
> +	 * shouldn't be interrupted. The buffers are also shared across
> +	 * all operations so need to be protected on stand alone reads and
> +	 * writes.
> +	 */
> +	struct mutex lock;
> +
> +	/* Cached register values */
> +	u32 regs[ADF41513_REG_NUM];
> +	u32 regs_hw[ADF41513_REG_NUM];
> +
> +	struct adf41513_data data;
> +	struct adf41513_pll_settings settings;
> +
> +	/*
> +	 * DMA (thus cache coherency maintenance) may require that
> +	 * transfer buffers live in their own cache lines.
> +	 */
> +	__be32 buf __aligned(IIO_DMA_MINALIGN);

Given this is very small, you could just use spi_write_the_read() with=20
zero length reads. That bounces the data anyway so doesn't need a DMA safe =
buffer.

> +};


> +
> +static int adf41513_calc_pll_settings(struct adf41513_state *st,
> +				      struct adf41513_pll_settings *result,
> +				      u64 rf_out_uhz)
> +{
> +	u64 max_rf_freq_uhz =3D st->chip_info->max_rf_freq_hz * MICRO;
> +	u64 min_rf_freq_uhz =3D ADF41513_MIN_RF_FREQ_HZ * MICRO;
> +	u64 pfd_freq_limit_uhz;
> +	int ret;
> +
> +	if (rf_out_uhz < min_rf_freq_uhz || rf_out_uhz > max_rf_freq_uhz) {
> +		dev_err(&st->spi->dev, "RF frequency %llu uHz out of range [%llu, %llu=
] uHz\n",
> +			rf_out_uhz, min_rf_freq_uhz, max_rf_freq_uhz);
> +		return -EINVAL;
> +	}
> +
> +	result->target_frequency_uhz =3D rf_out_uhz;
> +
> +	/* try integer-N first (best phase noise performance) */
> +	pfd_freq_limit_uhz =3D min(div_u64(rf_out_uhz, ADF41513_MIN_INT_4_5),
> +				 ADF41513_MAX_PFD_FREQ_INT_N_UHZ);
> +	ret =3D adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D adf41513_calc_integer_n(st, result);

When we have a series of methods to try it can be cleaner to return early in
the good paths. Given you don't return early error values, but rther just
try the next method you can do.

	if (adf41513_calc_integer_n(st, result) =3D=3D 0)
		return 0;

	/* try fractional-N: recompute pfd frequency if necessary */
	pfd_freq_limit_uhz =3D min(div_u64(rf_out_uhz, ADF41513_MIN_INT_FRAC_4_5),
				 ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ);
	if (pfd_freq_limit_uhz < result->pfd_frequency_uhz) {
		ret =3D adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
		if (ret < 0)
			return ret;
	}

	/* fixed-modulus attempt */
	if (adf41513_calc_fixed_mod(st, result) =3D=3D 0)
		return 0;

	/* variable-modulus attempt */
	ret =3D adf41513_calc_variable_mod(st, result);
	if (ret < 0) {
		dev_err(&st->spi->dev,
			"no valid PLL configuration found for %llu uHz\n",
			rf_out_uhz);
		return -EINVAL;
	}

	return 0;
}
	=09
> +	if (ret < 0) {
> +		/* try fractional-N: recompute pfd frequency if necessary */
> +		pfd_freq_limit_uhz =3D min(div_u64(rf_out_uhz, ADF41513_MIN_INT_FRAC_4=
_5),
> +					 ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ);
> +		if (pfd_freq_limit_uhz < result->pfd_frequency_uhz) {
> +			ret =3D adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> +			if (ret < 0)
> +				return ret;
> +		}
> +
> +		/* fixed-modulus attempt */
> +		ret =3D adf41513_calc_fixed_mod(st, result);
> +		if (ret < 0) {
> +			/* variable-modulus attempt */
> +			ret =3D adf41513_calc_variable_mod(st, result);
> +			if (ret < 0) {
> +				dev_err(&st->spi->dev,
> +					"no valid PLL configuration found for %llu uHz\n",
> +					rf_out_uhz);
> +				return -EINVAL;
> +			}
> +		}
> +	}
> +
> +	return 0;
> +}
> +


> +
> +static int adf41513_parse_fw(struct adf41513_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +	int ret;

Trivial:
Where no other reason for a particular order of declarations, nice to just =
use
reverse xmas tree.

> +	u32 tmp, cp_resistance, cp_current;
> +

...

> +static int adf41513_probe(struct spi_device *spi)
> +{
...

> +	ret =3D devm_mutex_init(dev, &st->lock);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name =3D spi_get_device_id(spi)->name;

I'd prefer we avoided this look up in the the device_id and instead
just put the name string for each part in the chip_info structure.

We've had far too many odd bugs around mismatches between firmware
tables to try to use any of the match tables for this. Better to have
one source of truth that we can get form any match table.

> +	indio_dev->info =3D &adf41513_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D &adf41513_chan;
> +	indio_dev->num_channels =3D 1;
> +
> +	ret =3D adf41513_setup(st);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret, "failed to setup device\n");
> +
> +	ret =3D devm_add_action_or_reset(dev, adf41513_power_down, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to add power down action\n");
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

