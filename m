Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCF4833A9EB;
	Fri, 29 May 2026 10:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780050584; cv=none; b=E4gXRGiQ2JAHPbfHncqeFaSexQWwRH98+21oPi0yN/Cfs4m9OMJ+eVwSqvxzx/pH3iiAqgiOVfZydZJ3qIKdm8DPDV55GxlCfmtjKWK9Jyvzjp/NwjEYnKlHk93zvio3Vke5GuxOzGWkKUZP8b4qX+vR8TlFo0/CnY8jIV5iSho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780050584; c=relaxed/simple;
	bh=uPPk8HPZo2/6u2Ih4Nik3LguWGm8Fjg6HkB3EzfhQAA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=O7IzVVd4tFGn0gjD1aV1AkRmVwVI3oyJz+3k7VOZECM1DH3sFAjtssjKSYnJ3WV5LHI1Qx8FpT9bQ8HjocIr0a6+hK0TqxfFR+MhcXSKTIBm43ocaaKE9TzawvUcg5bxSAEaDeKoqVt9nEilFtTKOkSTBQlCOwzP/cwCiW5TDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DQe9qv1p; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DQe9qv1p"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED9561F00893;
	Fri, 29 May 2026 10:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780050582;
	bh=fKC2Ha6tQXpwEpeHnMFXb50seEhffqIgcv2ixfthvpg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=DQe9qv1p+QhyQ3jLTkkswQBxaMCiYfxS3BT/NpTKzFlmIopR0s+XGcHzna6g2NPEo
	 05veAoNdILZA3tQI/SbYGCLnbub03fW1dnM+V43bPdMge5oWJv9Y5/eMxnigQ3xFtT
	 qqcxdbt/ivpILegLdQmHWFwvRiVYt8gnpqF8/8stF0NJ9wchwXbJiZImoWFMGohRZb
	 dzDee6ZeLQtXfQ3IIbxKNlPdIqe7Vrwo88NrXttR0pvPET1jlpFxG/Dd/bOX8mRWI5
	 bhiTwAqAZ7J7tfSGsFm75rtYeCi2S1cWabOW2UZmmc3BtlBdZTYdNAlUPLoQP6e6bn
	 kEfV7tsKmEVSA==
Date: Fri, 29 May 2026 11:29:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt@analog.com>
Cc: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <dlechner@baylibre.com>, <andy@kernel.org>,
 <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
 <pop.ioan-daniel@analog.com>, <marcelo.schmitt1@gmail.com>
Subject: Re: [PATCH v2 3/4] iio: adc: ltc2378: Enable high-speed data
 capture
Message-ID: <20260529112932.30f95d55@jic23-huawei>
In-Reply-To: <e04a432efb6536f93bbe7f410964aa877370de36.1779976379.git.marcelo.schmitt@analog.com>
References: <cover.1779976379.git.marcelo.schmitt@analog.com>
	<e04a432efb6536f93bbe7f410964aa877370de36.1779976379.git.marcelo.schmitt@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 28 May 2026 12:04:12 -0300
Marcelo Schmitt <marcelo.schmitt@analog.com> wrote:

> Make use of SPI transfer offloading to speed up data capture, enabling da=
ta
> acquisition at faster sample rates (up to 2 MSPS).
>=20
> Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
> ---
> Change log v1 -> v2:
> - Set loop count to prevent CPU stall when calculating PWM parameters.
> - Hardcode set specific offload supported amount of data element bits.
> - Fixed devm_spi_offload_get() error path.
> - Initialize init scan_type according to buffer selection.
> - Offload attributes now are channel based instead of device based.
> - Wrapped comments close to 80 columns.
>=20
> I haven't manage to code an is_visible() filter for device attributes spe=
cific
> of offload usage.
> Using DEFINE_SYSFS_GROUP_VISIBLE() didn't work out as the
> sampling_frequency_available attribute would still appear even without of=
fload.
> Using DEFINE_SYSFS_GROUP_VISIBLE() and sysfs attribute specific visibility
> function resulted in kernel error (Invalid permissions 01).
> Instead, I made them channel shared by all attributes.

Yeah, we don't provide a way to do is_visible for those attribute groups be=
cause
may of the ones the driver provides undergo non trivial transformations.
Normal solution is to just provide two versions of the structure that has t=
he
attributes pointer and pick between them.

>=20
> I tried a lib-like code arrangement like ADIS IMU but didn't manage to ge=
t it
> to work. Separated the code into ltc2378.h, ltc2378.c (lib), ltc2378-core=
.c
> (base driver), and ltc2378-offload.c with lib and core built as module and
> offload.c builtin. Though, I ran into different build and linkage errors
> depending on how ltc2378-offload.c utilities were encapsulated. Having re=
ad
> through IMU ADIS code, I now think LTC2378 is different and doesn't requi=
re
> a code design that much elaborated. Differently from the separate code for
> supporting specific adis devices, all ltc2378-like devices can be support=
ed
> by the same set of functions from ltc2378.c. We can maybe have an ops str=
uct
> with pointers to buffer specific routines (e.g. offload vs triggered). Th=
at
> might be worth it if we would want to switch between buffer types at runt=
ime.
> For v2, I'm keeping the module design similar to v1. I appreciate additio=
nal
> examples if a module redesign is still recommended.

For the module design just make sure every combination builds as expected.
Sashiko has some views on this. I haven't checked if they are right or not.


A few comments from me + some comments on sashiko's feedback:
https://sashiko.dev/#/patchset/cover.1779976379.git.marcelo.schmitt%40analo=
g.com
> diff --git a/drivers/iio/adc/ltc2378-offload-buffer.c b/drivers/iio/adc/l=
tc2378-offload-buffer.c
> new file mode 100644
> index 000000000000..8ad2d319f669
> --- /dev/null
> +++ b/drivers/iio/adc/ltc2378-offload-buffer.c

> + */
> +static int ltc2378_update_conversion_rate(struct ltc2378_state *st, int =
freq_Hz)
> +{
> +	struct spi_offload_trigger_config *config =3D &st->offload_trigger_conf=
ig;
> +	unsigned int min_read_offset, offload_period_ns;
> +	struct pwm_waveform cnv_wf =3D { };
> +	u64 target =3D LTC2378_TCNV_HIGH_NS;
> +	unsigned int count =3D 0;
> +	u64 offload_offset_ns;
> +	int ret;
> +
> +	if (freq_Hz =3D=3D 0)
> +		return -EINVAL;
> +
> +	if (freq_Hz < 1 || freq_Hz > st->info->max_sample_rate_hz)
> +		return -ERANGE;
> +
> +	/* Configure CNV PWM waveform */
> +	cnv_wf.period_length_ns =3D DIV_ROUND_CLOSEST(NSEC_PER_SEC, freq_Hz);
> +
> +	/*
> +	 * Ensure CNV high time meets minimum requirement (20ns). The PWM
> +	 * hardware may round the duty cycle, so iterate until we get at least
> +	 * the minimum required high time.
> +	 */
> +	do {
> +		cnv_wf.duty_length_ns =3D target;
> +		ret =3D pwm_round_waveform_might_sleep(st->cnv_trigger, &cnv_wf);
> +		if (ret)
> +			return ret;
> +		target +=3D 10;  /* Increment by PWM duty cycle period */
> +	} while (cnv_wf.duty_length_ns < LTC2378_TCNV_HIGH_NS || count++ < 100);

Sashiko is confused by the loop condition.  If the intent is not && count++=
 < 100
add a comment on why.

> +
> +	/*
> +	 * Configure SPI offload PWM trigger.
> +	 * The trigger should fire after tBUSYLH + tCONV + tDSDOBUSYL.
> +	 * Minimum time needed: TBUSYLH (13ns) + TCONV (part-specific) + TDSDOB=
USYL (5ns)
> +	 *
> +	 * Use the same period as CNV PWM to avoid timing issues.
> +	 * Convert back from period to frequency for the SPI offload API.
> +	 */
> +	offload_period_ns =3D cnv_wf.period_length_ns;
> +	config->periodic.frequency_hz =3D DIV_ROUND_UP(HZ_PER_GHZ, offload_peri=
od_ns);
> +	min_read_offset =3D LTC2378_TBUSYLH_NS + st->info->tconv_ns + LTC2378_T=
DSDOBUSYL_NS;
> +	offload_offset_ns =3D min_read_offset;
> +	count =3D 0;
> +	do {
> +		config->periodic.offset_ns =3D offload_offset_ns;
> +		ret =3D spi_offload_trigger_validate(st->offload_trigger, config);
> +		if (ret)
> +			return ret;
> +		offload_offset_ns +=3D 10;
> +	} while (config->periodic.offset_ns < min_read_offset || count++ < 100);
Same here.
> +
> +	st->cnv_wf =3D cnv_wf;
> +	st->cnv_Hz =3D DIV_ROUND_CLOSEST_ULL(HZ_PER_GHZ, cnv_wf.period_length_n=
s);
> +
> +	return 0;
> +}


> +int ltc2378_read_avail(struct iio_dev *indio_dev, struct iio_chan_spec c=
onst *chan,
> +		       const int **vals, int *type, int *length, long mask)
> +{
> +	struct ltc2378_state *st =3D iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		*vals =3D st->sample_freq_range;
> +		*type =3D IIO_VAL_INT;

Sashiko comments on setting *length here. It's wrong.

> +		return IIO_AVAIL_RANGE;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +EXPORT_SYMBOL_NS_GPL(ltc2378_read_avail, "IIO_LTC2378");



> +
> +static int ltc2378_pwm_get(struct ltc2378_state *st)
> +{
> +	struct device *dev =3D &st->spi->dev;
> +
> +	st->cnv_trigger =3D devm_pwm_get(dev, NULL);
> +	if (IS_ERR(st->cnv_trigger))
> +		return dev_err_probe(dev, PTR_ERR(st->cnv_trigger),
> +				     "failed to get cnv pwm\n");
> +
> +	pwm_disable(st->cnv_trigger);
Why do we need to disable it?  I guess something else might have left it ru=
nning.
Perhaps a comment?
> +
> +	return 0;
> +}
> +
> +static const struct spi_offload_config ltc2378_offload_config =3D {
> +	.capability_flags =3D SPI_OFFLOAD_CAP_TRIGGER |
> +			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
> +};
> +
> +int ltc2378_offload_buffer_setup(struct iio_dev *indio_dev, struct spi_d=
evice *spi)
> +{
> +	struct ltc2378_state *st =3D iio_priv(indio_dev);
> +	struct device *dev =3D &spi->dev;
> +	int ret;
> +
> +	st->offload =3D devm_spi_offload_get(dev, spi, &ltc2378_offload_config);
> +	ret =3D PTR_ERR_OR_ZERO(st->offload);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to get offload\n");

Sashiko observes this may print which we probably don't want given we are f=
alling
back to no offload which is an entirely valid condition.

> +
> +	ret =3D ltc2378_spi_offload_setup(indio_dev, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +				     "failed to setup SPI offload\n");
> +
> +	ret =3D ltc2378_pwm_get(st);
> +	if (ret)
> +		return ret;
> +
> +	st->sample_freq_range[0] =3D 1; /* min */
> +	st->sample_freq_range[1] =3D 1; /* step */
> +	st->sample_freq_range[2] =3D st->info->max_sample_rate_hz; /* max */
> +
> +	/*
> +	 * Start with a slower sampling rate so there is some room for
> +	 * adjusting the sampling frequency without hitting the maximum
> +	 * conversion rate.
> +	 */
> +	ret =3D ltc2378_update_conversion_rate(st, st->info->max_sample_rate_hz=
 >> 4);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to sampling frequency\n");
> +
> +	ret =3D ltc2378_prepare_offload_message(&spi->dev, st);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to optimize SPI message\n");
> +
> +	return 0;
> +}
> +EXPORT_SYMBOL_NS_GPL(ltc2378_offload_buffer_setup, "IIO_LTC2378");
> +
> +MODULE_IMPORT_NS("IIO_LTC2378");
> diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
> index bdff98157979..6b01d8e96cc6 100644
> --- a/drivers/iio/adc/ltc2378.c
> +++ b/drivers/iio/adc/ltc2378.c

> =20
> @@ -190,7 +230,7 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
>  	int ret;
> =20
>  	switch (info) {
> -	case IIO_CHAN_INFO_RAW:
> +	case IIO_CHAN_INFO_RAW: {
>  		IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
>  		if (IIO_DEV_ACQUIRE_FAILED(claim))
>  			return -EBUSY;
> @@ -200,7 +240,7 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
>  			return ret;
> =20
>  		return IIO_VAL_INT;
> -
> +	}

Ah. There they are. Move back to previous patch.

>  	case IIO_CHAN_INFO_SCALE:

> =20
>  static int ltc2378_probe(struct spi_device *spi)
> @@ -261,10 +314,35 @@ static int ltc2378_probe(struct spi_device *spi)
>  	st->chans[0].type =3D IIO_VOLTAGE;
>  	st->chans[0].info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |
>  					  BIT(IIO_CHAN_INFO_SCALE);
> -	st->chans[0].scan_type.format =3D st->info->twos_comp ? IIO_SCAN_FORMAT=
_SIGNED_INT :
> -							      IIO_SCAN_FORMAT_UNSIGNED_INT;
> -	st->chans[0].scan_type.realbits =3D st->info->resolution;
> -	st->chans[0].scan_type.storagebits =3D st->info->resolution > 16 ? 32 :=
 16;
> +
> +	struct iio_scan_type ltc2378_scan;
=3D { };

Sashiko noted this - you only set some parts of this below. Or use...
> +
> +	ret =3D ltc2378_offload_buffer_setup(indio_dev, spi);
> +	if (ret =3D=3D -ENODEV) {
> +		/* SPI offloading is unavailable. Fall back to triggered buffer. */
> +		dev_dbg(dev, "triggered data capture not supported\n");
> +		ltc2378_scan.format =3D st->info->twos_comp ? IIO_SCAN_FORMAT_SIGNED_I=
NT :
> +							    IIO_SCAN_FORMAT_UNSIGNED_INT;
> +		ltc2378_scan.realbits =3D st->info->resolution;
> +		ltc2378_scan.storagebits =3D st->info->resolution > 16 ? 32 : 16;

		ltc2378_scan =3D (struct iio_scan_type) {
			.format =3D ...
		};
here and same below. That will both perhaps be more readable and also ensur=
e all elements
are set to what we want (appropriate defaults for some).

> +	} else if (ret) {
> +		return dev_err_probe(dev, ret, "error on SPI offload setup\n");
> +	} else {
> +		/*
> +		 * Currently, the available offload hardware + DMA configuration
> +		 * only supports pushing 32-bit data elements to IIO buffers in
> +		 * CPU endianness.
> +		 */
> +		st->chans[0].info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ);
> +		st->chans[0].info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_S=
AMP_FREQ);
So this is the thing you commented on above.   Hmm. Normally when sampling =
frequency
is effectively decoupled from that possible via direct read (if we assume n=
o software overhead)
then we do put this as a buffer attribute.

I'm not sure it matters particularly here though as we don't get to control=
 direct read
sampling frequency (which usually has something to do with integration time=
 or similar).
So I think this solution is ok.

> +
> +		ltc2378_scan.format =3D st->info->twos_comp ? IIO_SCAN_FORMAT_SIGNED_I=
NT :
> +							    IIO_SCAN_FORMAT_UNSIGNED_INT;
> +		ltc2378_scan.realbits =3D st->info->resolution;
> +		ltc2378_scan.storagebits =3D 32;
> +	}
> +
> +	st->chans[0].scan_type =3D ltc2378_scan;
> =20
>  	st->xfer.rx_buf =3D &st->scan.data;
>  	st->xfer.len =3D BITS_TO_BYTES(st->chans[0].scan_type.storagebits);
=46rom sashiko:
(adding some more context)
>  	st->xfer.bits_per_word =3D st->info->resolution > 16 ? 32 : 16;

What happens if there are any direct reads when offload is in use.
You set the bpw to 16 for low res parts yet I think the offload
hardware always does 32 - so this probably wants an update just to keep
code and what the hardware is doing inline.

> @@ -340,3 +418,4 @@ MODULE_AUTHOR("Ioan-Daniel Pop <pop.ioan-daniel@analo=
g.com>");
>  MODULE_AUTHOR("Marcelo Schmitt <marcelo.schmitt@analog.com>");
>  MODULE_DESCRIPTION("Analog Devices LTC2378 ADC series driver");
>  MODULE_LICENSE("GPL");
> +MODULE_IMPORT_NS("IIO_LTC2378");
> diff --git a/drivers/iio/adc/ltc2378.h b/drivers/iio/adc/ltc2378.h
> index 399e8f67cd0e..e79619c12ce9 100644
> --- a/drivers/iio/adc/ltc2378.h
> +++ b/drivers/iio/adc/ltc2378.h

> +#else /* CONFIG_IIO_LTC2378_LIB_OFFLOAD_BUFFER */
> +
> +#define LTC2378_WRITE_RAW_PTR (NULL)

Not sure why you'd ever need brackets around the NULL.

> +
> +#define LTC2378_READ_AVAIL_PTR (NULL)


> +int ltc2378_get_sampling_frequency(struct ltc2378_state *st, int *val)
> +{
> +	return -EOPNOTSUPP;
> +}
> +
> +int ltc2378_set_sampling_frequency(struct ltc2378_state *st, int freq_Hz=
);
Sashiko noted this - which rather implies you didn't build with these stubs.
Stray ;
> +{
> +	return -EOPNOTSUPP;
> +}
