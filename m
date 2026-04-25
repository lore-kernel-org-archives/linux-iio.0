Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6542FD69D;
	Sat, 25 Apr 2026 16:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777134851; cv=none; b=aRMqcKDEmlIHkNOniwOKMHWM0Yj0F1C7zrofCq+6MkkxbNEaMZsWHtjb7ck+1QrT80Kc/sOPSPvIgiQ5KUC4MRoXzVwMmh17E1mZH3caXQrorNERCBFsRM+rc7iX1+8TRR631c2HsvWCPZ2EKb65UEzbDM4s8CYOoVSzub8EJGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777134851; c=relaxed/simple;
	bh=mfXSGObnf2bZC5OMGB3S2CF9JKHi+7vE2rX71ANM8r8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LlhYA4yPiiqD4oET7blgECk8pj2klXvz3gA2rGK/5habeyudmiW1muljw6s4YQV+N7SvF0+FkaGxlJdspArqyVvARChvqjPaaThbjDe+EzKqYXDsJK2KHZQNK0koFg1Hf4d9mG5ZQhFyjiRC0uPgPDJIbXkPejGNUhoD0U09TZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EW2OlU3b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EW2OlU3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33039C2BCB0;
	Sat, 25 Apr 2026 16:34:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777134851;
	bh=mfXSGObnf2bZC5OMGB3S2CF9JKHi+7vE2rX71ANM8r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EW2OlU3b2OoT5Ly7THWzSzCPQgsw7qL2kQf/IZmRd4AuasIt5ximF94y04W7umhJr
	 iunHW14qgl6muG4cY5BcB2Ml5Ds0FYbT460rAk6Tiets17gbL2Q4n+ONFb2nFqzhNS
	 Uy/xkW8nRslEIn/4Qmli5xVz4dzZ76KRQZaDkvBxJ9le6oOLu++Qd5IfzmG58iMqZo
	 HF7qvfFItBAPtX7it+6vVMTfWAfLxku4OQB25pFCcd6vsmBEAeK27FkCUmylsezvF+
	 ZJo0RQ3rSe4yOOt/2kcTgp/TjFEsnXnGEH5lxE5wBM+qruXYlaceWsfHhlPHLhzgWY
	 K4t5VmCLIQeDw==
Date: Sat, 25 Apr 2026 17:33:55 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Rodrigo Alencar via B4 Relay
 <devnull+rodrigo.alencar.analog.com@kernel.org>
Cc: rodrigo.alencar@analog.com, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-doc@vger.kernel.org, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>, Michael
 Hennerich <Michael.Hennerich@analog.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Mladek <pmladek@suse.com>, Steven Rostedt
 <rostedt@goodmis.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, Sergey Senozhatsky
 <senozhatsky@chromium.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH v10 07/11] iio: frequency: adf41513: driver
 implementation
Message-ID: <20260425173355.464f6899@jic23-huawei>
In-Reply-To: <20260415-adf41513-iio-driver-v10-7-df61046d5457@analog.com>
References: <20260415-adf41513-iio-driver-v10-0-df61046d5457@analog.com>
	<20260415-adf41513-iio-driver-v10-7-df61046d5457@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 15 Apr 2026 10:51:50 +0100
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
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Hi Rodrigo

I was thinking the only thing that was still under possible discussion
was the parsing code and related tests, but given that's been quiet
I took what I was thinking would be the final look at this.

Found a few bits of code that are unnecessarily general.
Other stuff is all trivial.

Anyhow, sashiko is now running on linux-iio so please also take a look
at what it thinks of your v11. It's been finding some subtle bugs but
obviously take into account it might be making things up ;)

Thanks,

Jonathan

> diff --git a/drivers/iio/frequency/Makefile b/drivers/iio/frequency/Makef=
ile
> index 70d0e0b70e80..53b4d01414d8 100644
> --- a/drivers/iio/frequency/Makefile
> +++ b/drivers/iio/frequency/Makefile
> @@ -5,6 +5,7 @@
> =20
>  # When adding new entries keep the list in alphabetical order
>  obj-$(CONFIG_AD9523) +=3D ad9523.o
> +obj-$(CONFIG_ADF41513) +=3D adf41513.o
>  obj-$(CONFIG_ADF4350) +=3D adf4350.o
>  obj-$(CONFIG_ADF4371) +=3D adf4371.o
>  obj-$(CONFIG_ADF4377) +=3D adf4377.o
> diff --git a/drivers/iio/frequency/adf41513.c b/drivers/iio/frequency/adf=
41513.c
> new file mode 100644
> index 000000000000..bf2d6c941082
> --- /dev/null
> +++ b/drivers/iio/frequency/adf41513.c

> +
> +static int adf41513_sync_config(struct adf41513_state *st, u16 sync_mask)
> +{
> +	__be32 d32;
> +	int ret, i;
> +
> +	/* write registers in reverse order (R13 to R0)*/
> +	for (i =3D ADF41513_REG13; i >=3D ADF41513_REG0; i--) {
Maybe
	for (int i =3D ..
given that's now considered fine in kernel code.
You could reduce the scope of d32 and ret but that doesn't bring much advan=
tage here.
> +		if (st->regs_hw[i] =3D=3D st->regs[i] && !(sync_mask & BIT(i)))
> +			continue;
> +
> +		d32 =3D cpu_to_be32(st->regs[i] | i);
> +		ret =3D spi_write_then_read(st->spi, &d32, sizeof(d32), NULL, 0);
> +		if (ret < 0)
> +			return ret;
> +		st->regs_hw[i] =3D st->regs[i];
> +		dev_dbg(&st->spi->dev, "REG%d <=3D 0x%08X\n", i, st->regs[i] | i);
> +	}
> +
> +	return 0;
> +}


> +
> +static int adf41513_calc_variable_mod(struct adf41513_state *st,
> +				      struct adf41513_pll_settings *result)
> +{
> +	u64 freq_error_uhz, mod2;
> +	u32 frac1, frac2;
> +	u16 int_value =3D div64_u64_rem(result->target_frequency_uhz,
> +				      result->pfd_frequency_uhz,
> +				      &freq_error_uhz);
> +
> +	if (st->chip_info->has_prescaler_8_9 && int_value >=3D ADF41513_MIN_INT=
_FRAC_8_9 &&
> +	    int_value <=3D ADF41513_MAX_INT_8_9)
> +		result->prescaler =3D 1;
> +	else if (int_value >=3D ADF41513_MIN_INT_FRAC_4_5 && int_value <=3D ADF=
41513_MAX_INT_4_5)
> +		result->prescaler =3D 0;
> +	else
> +		return -ERANGE;
See below for this value getting switched at caller.

> +
> +	/* calculate required mod2 based on target resolution / 2 */
> +	mod2 =3D DIV64_U64_ROUND_CLOSEST(result->pfd_frequency_uhz << 1,
> +				       st->data.freq_resolution_uhz * ADF41513_FIXED_MODULUS);
> +	/* ensure mod2 is at least 2 for meaningful operation */
> +	mod2 =3D clamp(mod2, 2, ADF41513_MAX_MOD2);
> +
> +	/* calculate frac1 and frac2 */
> +	frac1 =3D mul_u64_u64_div_u64(freq_error_uhz, ADF41513_FIXED_MODULUS,
> +				    result->pfd_frequency_uhz);
> +	freq_error_uhz -=3D mul_u64_u32_div(result->pfd_frequency_uhz, frac1,
> +					  ADF41513_FIXED_MODULUS);
> +	frac2 =3D mul_u64_u64_div_u64(freq_error_uhz, mod2 * ADF41513_FIXED_MOD=
ULUS,
> +				    result->pfd_frequency_uhz);
> +
> +	/* integer part */
> +	result->actual_frequency_uhz =3D (u64)int_value * result->pfd_frequency=
_uhz;
> +	/* fractional part */
> +	result->actual_frequency_uhz +=3D mul_u64_u64_div_u64(mod2 * frac1 + fr=
ac2,
> +							    result->pfd_frequency_uhz,
> +							    mod2 * ADF41513_FIXED_MODULUS);
> +	result->mode =3D ADF41513_MODE_VARIABLE_MODULUS;
> +	result->int_value =3D int_value;
> +	result->frac1 =3D frac1;
> +	result->frac2 =3D frac2;
> +	result->mod2 =3D mod2;
> +
> +	return 0;
> +}
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
> +	if (adf41513_calc_integer_n(st, result) =3D=3D 0)
> +		return 0;
> +
> +	/* try fractional-N: recompute pfd frequency if necessary */
> +	pfd_freq_limit_uhz =3D min(div_u64(rf_out_uhz, ADF41513_MIN_INT_FRAC_4_=
5),
> +				 ADF41513_MAX_PFD_FREQ_FRAC_N_UHZ);
> +	if (pfd_freq_limit_uhz < result->pfd_frequency_uhz) {
> +		ret =3D adf41513_calc_pfd_frequency(st, result, pfd_freq_limit_uhz);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	/* fixed-modulus attempt */
> +	if (adf41513_calc_fixed_mod(st, result) =3D=3D 0)
> +		return 0;
> +
> +	/* variable-modulus attempt */
> +	ret =3D adf41513_calc_variable_mod(st, result);
> +	if (ret < 0) {
> +		dev_err(&st->spi->dev,
> +			"no valid PLL configuration found for %llu uHz\n",
> +			rf_out_uhz);
> +		return -EINVAL;

Why eat value of ret?  If that does make sense add a comment so
this doesn't get 'cleaned up' in future.

I can sort of see it making sense as all this is a case of all
sorts of different cases failed rather than just this last one.
> +	}
> +
> +	return 0;
> +}


> +
> +static ssize_t adf41513_read_resolution(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					const struct iio_chan_spec *chan,
> +					char *buf)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	int vals[2];
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case ADF41513_FREQ_RESOLUTION:
See below.

> +		iio_val_s64_array_populate(st->data.freq_resolution_uhz, vals);
> +		return iio_format_value(buf, IIO_VAL_DECIMAL64_MICRO,
> +					ARRAY_SIZE(vals), vals);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t adf41513_read_powerdown(struct iio_dev *indio_dev,
> +				       uintptr_t private,
> +				       const struct iio_chan_spec *chan,
> +				       char *buf)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u32 val;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (private) {
> +	case ADF41513_POWER_DOWN:
See below.

> +		val =3D FIELD_GET(ADF41513_REG6_POWER_DOWN_MSK,
> +				st->regs_hw[ADF41513_REG6]);
> +		return sysfs_emit(buf, "%u\n", val);
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t adf41513_write_resolution(struct iio_dev *indio_dev,
> +					 uintptr_t private,
> +					 const struct iio_chan_spec *chan,
> +					 const char *buf, size_t len)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	u64 freq_uhz;
> +	int ret;
> +
> +	ret =3D kstrtoudec64(buf, ADF41513_HZ_DECIMAL_SCALE, &freq_uhz);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {
> +	case ADF41513_FREQ_RESOLUTION:
See below.

> +		if (freq_uhz =3D=3D 0 || freq_uhz > ADF41513_MAX_FREQ_RESOLUTION_UHZ)
> +			return -EINVAL;
> +		st->data.freq_resolution_uhz =3D freq_uhz;
> +		return len;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static ssize_t adf41513_write_powerdown(struct iio_dev *indio_dev,
> +					uintptr_t private,
> +					const struct iio_chan_spec *chan,
> +					const char *buf, size_t len)
> +{
> +	struct adf41513_state *st =3D iio_priv(indio_dev);
> +	unsigned long readin;
> +	int ret;
> +
> +	ret =3D kstrtoul(buf, 10, &readin);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch ((u32)private) {
> +	case ADF41513_POWER_DOWN:
Silly question. How do we get a different value of this?

I'm going to guess this is either a code evolution thing where
we have reached a silly state, or you have other code that goes
on top of this series that needs this.  If it's the 'more code'
case then do a refactor at start of that series and keep this simple for no=
w.

Similar applies for the resolution functions.


> +		if (readin)
> +			ret =3D adf41513_suspend(st);
> +		else
> +			ret =3D adf41513_resume(st);
> +		break;
Really trivial but I'd prefer.

		if (ret)
			return ret;

		break;

Then unconditionally return len below.  Tends to make things a bit
simpler to read if we get more elements in the switch in the longer term
as no need to go look for what happens in the error path.

> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return ret ?: len;
> +}
> +
> +#define _ADF41513_EXT_PD_INFO(_name, _ident) { \
> +	.name =3D _name, \
> +	.read =3D adf41513_read_powerdown, \
> +	.write =3D adf41513_write_powerdown, \
> +	.private =3D _ident, \
> +	.shared =3D IIO_SEPARATE, \
> +}
> +
> +#define _ADF41513_EXT_RES_INFO(_name, _ident) { \
> +	.name =3D _name, \
> +	.read =3D adf41513_read_resolution, \
> +	.write =3D adf41513_write_resolution, \
> +	.private =3D _ident, \
> +	.shared =3D IIO_SEPARATE, \
> +}
> +
> +static const struct iio_chan_spec_ext_info adf41513_ext_info[] =3D {
> +	_ADF41513_EXT_RES_INFO("frequency_resolution", ADF41513_FREQ_RESOLUTION=
),
> +	_ADF41513_EXT_PD_INFO("powerdown", ADF41513_POWER_DOWN),
IF these only occur once - which I think is the case, drop the macros.

> +	{ }
> +};
> +
>=20
