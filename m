Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792724513;
	b=lS0D4YZ6RDrrRXKOHQu8PflJHWE/9FqfomsliaEhx1PiMVMlC83kkICAyfOR8vvMWSqh
	 C5z9NexZ64NcSmbujybMAFmz//3nA0D0Q3BL8Ms5Ssa+sL9I8tiamH4zcw5mymErDSID8
	 BJxXcUc2vY2IMEiC+sZ9IKQvLzQ5rt/j7UtYtcLm9mrQrG//vWwNsCGYx3AxOAZy3J1A2
	 Ii2k4ASHmebJAx5hSl9kYFYr3cY3LsAOmkALP+49TYAa6eWpbPRgLRBfcoIo482Q56LOQ
	 FlZ/q337MiZ4+Mow3EbgHSNe1izM7NhIBZZ4sKX1BYMqfFEcw2Tgo7lTF6OC+xbBcLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792724513;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=fyN3YGhoEzyR7+SpeP2cdjLZpY8iu+5woA/+8YNT2XU=;
	b=STVpGguyZYJuPmIIwjvFEaui5J3c1F7n9lfLazIiCZGROhSCmn0HDMr5grtpm/8phs9J
	 aaHF8No978mGgHsQngWk8renZG9wfA2Kn+LhMwCEYqAC05VWhe1AnC/qVRyrKBDW234dm
	 pBB+3Ntva1NT/ecFda8xPA/VJFhnqVRlT86PxA8Nqsw1aRf/1tDiT9q/HK1tATwz2jDCz
	 BlcT0g/aumHJ5VUJPJp05Rf80wb1fKzxtP5g7m0HMmhWpZjJ1/Gks+iL1AyhT3aA+IBrp
	 7m+qYEME+3RdVntjjickzQPJMhNUrW5c8slmE0gems7XBxw3mL809p8R0E1HmVtvmqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Plu2V/YT";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE114606A319;
	Fri, 23 Oct 2026 03:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Plu2V/YT
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4C8B1F01825;
	Fri, 23 Oct 2026 03:01:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792724512;
	bh=fyN3YGhoEzyR7+SpeP2cdjLZpY8iu+5woA/+8YNT2XU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Plu2V/YTUrTHCGbGHUXv51UNUccE476XVHxwbhbvCfRDlVEFVzr9AhZMVBwcaDxEs
	 SsYH2Awbwu3bgqcj6I7jsd44AznS99bxwOj1xYZ/b0KTCORPXEISv1nPDDYvPgwIFh
	 ejNIuEpF/Xcd0PIaytEn6FSrPDA2ra+I0M4+srFeZbExEKjU15Ghn6F9yrZm1IlJeC
	 dmkB67nCismT3VOeODWBpVecfj+bxGt/VC9BFlDw8Pf8MKNATlCac0c88HRv0bDCXH
	 HDgwQnzHtbSPofYRGMffFg+4hsj9irCZNvbw73iaeABTKjbiZlXyP7Bp9Sso4RvNRg
	 frLnvsuc1TAUw==
Date: Fri, 23 Oct 2026 04:01:43 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Victor Chernyakin <chernyakin.victor.j@outlook.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] iio: cdc: add Texas Instruments FDC1004 driver
Message-ID: <20261023040143.2e7043bc@jic23-hlaptop>
In-Reply-To: <SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
References: <SN1PR12MB25286BE4E1EA3B75F8E563A9A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
	<SN1PR12MB25288BF227D6555AEE60DF73A5652@SN1PR12MB2528.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 22 Oct 2026 18:40:32 -0500
Victor Chernyakin <chernyakin.victor.j@outlook.com> wrote:

Hi Victor and welcome to IIO.


> The FDC1004 is a high-precision 4-channel capacitive sensor that talks
> over I2C. It can report the values of each of its 4 channels individually,
> as well as the difference between any two of them.
> 
> This initial driver allows performing single reads and configuring
> the sensor's various settings (sample frequency, calibration
> gain/offset, etc.). It could be extended with support for triggered
> buffers, repeated measurement mode, and/or power management.

Whilst I think I follow the reasoning for the very large units,
calibbias and calibscale are generally consider unitless tweak factors.
You'll see there are no units expressed anywhere in ABI.
This mostly because they tend to rather value defined at best on 
many parts.  So we tend to just go with whatever units feel
fairly user friendly.

Putting that aside, the base unit of capacitance in the ABI
is a nano farad. The part is documented at 0.5 femto farad
resolution so I'd kind of expect a scale of only 0.5e-6.

Perhaps the issue here is desire for a very high degree of
precision on the scale factors?  I don't mind that if it
is useful but with a documented 0.2% gain error I'm not
sure it is.  For next version add some reasoning for
why such high precision is useful.

We frequently round scale factors as often they are swamped
by error / noise.  Perhaps that doesn't apply here.


> 
> Signed-off-by: Victor Chernyakin <chernyakin.victor.j@outlook.com>
> ---
>  MAINTAINERS               |   1 +
>  drivers/iio/cdc/Kconfig   |  10 +
>  drivers/iio/cdc/Makefile  |   1 +
>  drivers/iio/cdc/fdc1004.c | 460 ++++++++++++++++++++++++++++++++++++++
>  4 files changed, 472 insertions(+)
>  create mode 100644 drivers/iio/cdc/fdc1004.c

> diff --git a/drivers/iio/cdc/Makefile b/drivers/iio/cdc/Makefile
> index 41db756d8020..88253f33c5a7 100644
> --- a/drivers/iio/cdc/Makefile
> +++ b/drivers/iio/cdc/Makefile
> @@ -5,3 +5,4 @@
>  
>  obj-$(CONFIG_AD7150) += ad7150.o
>  obj-$(CONFIG_AD7746) += ad7746.o
> +obj-$(CONFIG_FDC1004) += fdc1004.o
> diff --git a/drivers/iio/cdc/fdc1004.c b/drivers/iio/cdc/fdc1004.c
> new file mode 100644
> index 000000000000..852a3723e200
> --- /dev/null
> +++ b/drivers/iio/cdc/fdc1004.c
> @@ -0,0 +1,460 @@
> +// SPDX-License-Identifier: GPL-2.0+
> +/*
> + * Texas Instruments FDC1004 capacitive sensor driver
> + *
> + * Copyright (c) 2026 Victor Chernyakin <chernyakin.victor.j@outlook.com>
> + *
> + * Datasheet: https://www.ti.com/lit/gpn/FDC1004
> + */
> +
> +#include <linux/array_size.h>
> +#include <linux/bitfield.h>
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/delay.h>
> +#include <linux/i2c.h>
> +#include <linux/iopoll.h>
> +#include <linux/math.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/types.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#define FDC1004_REG_MEASn_MSB(n) (2 * (n))
> +#define FDC1004_REG_MEASn_LSB(n) (2 * (n) + 1)
> +#define FDC1004_REG_CONF_MEASn(n) (0x08 + (n))
> +#define FDC1004_REG_FDC_CONF 0x0C
> +#define FDC1004_REG_OFFSET_CAL_CINn(n) (0x0D + (n))
> +#define FDC1004_REG_GAIN_CAL_CINn(n) (0x11 + (n))
> +
> +#define FDC1004_CONF_MEAS_CHA_MASK GENMASK(15, 13)
> +#define FDC1004_CONF_MEAS_CHB_MASK GENMASK(12, 10)
> +#define FDC1004_CONF_MEAS_CHB_CAPDAC 0b100
> +#define FDC1004_CONF_MEAS_CAPDAC_MASK GENMASK(9, 5)
> +
> +#define FDC1004_FDC_CONF_DONE_n_MASK(n) BIT(3 - (n))
> +#define FDC1004_FDC_CONF_MEAS_n_MASK(n) BIT(7 - (n))
> +#define FDC1004_FDC_CONF_RATE_MASK GENMASK(11, 10)
> +#define FDC1004_FDC_CONF_RST_MASK BIT(15)
> +
> +static const int fdc1004_samp_freqs[] = { 100, 200, 400 };
> +
> +/*
> + * MEASn_{MSB,LSB}: 24 bits, signed. Format: IIO_VAL_DECIMAL64_YOCTO.
> + * 1 step = 1/(2^19) pF = 1/(1000 * 2^19) nF = 0.000000001907348632812500 nF.
> + */
> +static const s64 fdc1004_scale = 1907348632812500;
> +
> +/*
> + * CAPDAC field: 5 bits, unsigned. Format: IIO_VAL_INT.
> + * 1 step = 3.125 pF = 100/(2^5) pF.

Given offset is applied prior to scale. Is this in appropriate
units?  I'm not following that description.

> + */
> +static const int fdc1004_offset[] = {
> +	0x00 * (100 << (19 - 5)), /* min */
> +	0x01 * (100 << (19 - 5)), /* step */
> +	0x1F * (100 << (19 - 5)), /* max */
> +};
> +
> +/*
> + * OFFSET_CAL_CINn: 16 bits, signed. Format: IIO_VAL_DECIMAL64_FEMTO.
> + * 1 step = 1/(2^11) pF = 1/(1000 * 2^11) nF = 0.000000488281250 nF.
> + */
> +static const s64 fdc1004_calibbias[] = {
> +	-0x8000 * 488281250UL, /* min */
> +	+0x0001 * 488281250UL, /* step */
> +	+0x7FFF * 488281250UL, /* max */
> +};
> +
> +/*
> + * GAIN_CAL_CINn: 16 bits, unsigned. Format: IIO_VAL_DECIMAL64_FEMTO.
> + * 1 step = 1/(2^14) pF/pF = 0.000061035156250 pF/pF.
> + */
> +static const s64 fdc1004_calibscale[] = {
> +	0x0000 * 61035156250UL, /* min */
> +	0x0001 * 61035156250UL, /* step */
> +	0xFFFF * 61035156250UL, /* max */
> +};
> +
> +struct fdc1004_data {
> +	struct i2c_client *client;
> +	struct mutex lock;

Add a comment on what data the lock is actually protecting.

> +	u8 samp_freq_index;
> +	u8 offsets[4];
> +};
> +
> +static int fdc1004_soft_reset(struct i2c_client *client)
> +{
> +	int ret;
> +
> +	ret = i2c_smbus_write_word_swapped(client, FDC1004_REG_FDC_CONF,
> +					   FDC1004_FDC_CONF_RST_MASK);
> +	if (ret)
> +		return ret;
> +
> +	return poll_timeout_us(
> +		{
> +			ret = i2c_smbus_read_word_swapped(client,
> +							  FDC1004_REG_FDC_CONF);
> +			if (ret < 0)
> +				return ret;
> +		},
> +		!(ret & FDC1004_FDC_CONF_RST_MASK), USEC_PER_MSEC,
> +		200 * USEC_PER_MSEC, false);
> +}
> +
> +static int fdc1004_wait_until_measurement_is_ready(struct i2c_client *client,
> +						   int meas)
> +{
> +	int ret;
> +
> +	/*
> +	 * The slowest sampling frequency the chip supports is 100 SPS,
> +	 * i.e. 1 sample every 10 ms, so our timeout can't be shorter than
> +	 * that. Go with 40 ms to be safe.
> +	 */
> +	return poll_timeout_us(
> +		{
> +			ret = i2c_smbus_read_word_swapped(client,
> +							  FDC1004_REG_FDC_CONF);
> +			if (ret < 0)
> +				return ret;

common convention to add the error condition to the exit one rather than do it
in here.  Then check ret after the exit from teh poll.
Tends to give nice code to read.

> +		},
> +		ret & FDC1004_FDC_CONF_DONE_n_MASK(meas), USEC_PER_MSEC,
> +		40 * USEC_PER_MSEC, false);
> +}

> +
> +static int fdc1004_read_raw(struct iio_dev *indio_dev,
> +			    const struct iio_chan_spec *chan, int *val,
> +			    int *val2, long mask)
> +{
> +	struct fdc1004_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		iio_val_s64_decompose(fdc1004_scale, val, val2);
> +		return IIO_VAL_DECIMAL64_YOCTO;
> +	case IIO_CHAN_INFO_RAW: {
> +		guard(mutex)(&data->lock);
> +
> +		/* Configure the measurement we want. */
> +		ret = i2c_smbus_write_word_swapped(
> +			client, FDC1004_REG_CONF_MEASn(0),
> +			chan->address |
> +				FIELD_PREP(FDC1004_CONF_MEAS_CAPDAC_MASK,
> +					   data->offsets[chan->channel]));
> +		if (ret)
> +			return ret;
> +
> +		/* Start the measurement. */
> +		ret = i2c_smbus_write_word_swapped(
> +			client, FDC1004_REG_FDC_CONF,
> +			FDC1004_FDC_CONF_MEAS_n_MASK(0) |
> +				/* "+ 1" because the chip wants a 1-indexed value. */
> +				FIELD_PREP(FDC1004_FDC_CONF_RATE_MASK,
> +					   data->samp_freq_index + 1));

For some of these more complex values I'd use a local variable and build them
up in steps.

> +		if (ret)
> +			return ret;
> +
> +		ret = fdc1004_wait_until_measurement_is_ready(client, 0);
> +		if (ret)
> +			return ret;
> +
> +		ret = fdc1004_read_measurement(client, 0, val);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_SAMP_FREQ: {
> +		guard(mutex)(&data->lock);
> +		*val = fdc1004_samp_freqs[data->samp_freq_index];
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_OFFSET: {
> +		guard(mutex)(&data->lock);
> +		*val = data->offsets[chan->channel] * fdc1004_offset[1];
> +		return IIO_VAL_INT;
> +	}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		ret = i2c_smbus_read_word_swapped(
> +			client, FDC1004_REG_OFFSET_CAL_CINn(chan->channel));
Wrap this sort of thing as:

> +		ret = i2c_smbus_read_word_swapped(client,
						  FDC1004_REG_OFFSET_CAL_CINn(chan->channel));
The long line is fine as it is worth it for readability.



> +		if (ret < 0)
> +			return ret;
> +
> +		iio_val_s64_decompose(
> +			sign_extend64(ret, 15) * fdc1004_calibbias[1],
> +			val, val2);
> +		return IIO_VAL_DECIMAL64_FEMTO;

As below.  I'm not following why the very small units.

> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		ret = i2c_smbus_read_word_swapped(
> +			client, FDC1004_REG_GAIN_CAL_CINn(chan->channel));
> +		if (ret < 0)
> +			return ret;
> +
> +		iio_val_s64_decompose(ret * fdc1004_calibscale[1], val, val2);
> +		return IIO_VAL_DECIMAL64_FEMTO;
> +	default:
> +		return -EINVAL;
> +	}

> +
> +static int fdc1004_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				     const struct iio_chan_spec *chan,
> +				     long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +	case IIO_CHAN_INFO_OFFSET:
> +		return IIO_VAL_INT;
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		return IIO_VAL_DECIMAL64_FEMTO;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int fdc1004_write_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan, int val,
> +			     int val2, long mask)
> +{
> +	struct fdc1004_data *data = iio_priv(indio_dev);
> +	struct i2c_client *client = data->client;
> +	s64 val64 = iio_val_s64_compose(val, val2);

Only do this in paths where it is used.  Leads to a bit of duplication
but less confusing code.

> +	int i;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SAMP_FREQ:
> +		for (i = 0; i < ARRAY_SIZE(fdc1004_samp_freqs); ++i) {
		for (unsigned int i = 0; i < ARRAY_SIZE(fdc1004_samp_freq); i++) {

Fine to go a bit over 80 chars to help readability and I think that applies here.


> +			if (fdc1004_samp_freqs[i] == val) {
> +				guard(mutex)(&data->lock);
> +				data->samp_freq_index = i;
> +				return 0;
> +			}
> +		}
> +
> +		return -EINVAL;
> +	case IIO_CHAN_INFO_OFFSET: {
> +		if (val < fdc1004_offset[0] || val > fdc1004_offset[2] ||
> +		    val % fdc1004_offset[1])
> +			return -EINVAL;
> +
> +		guard(mutex)(&data->lock);
> +		data->offsets[chan->channel] = val / fdc1004_offset[1];
> +		return 0;
> +	}
> +	case IIO_CHAN_INFO_CALIBBIAS:
> +		if (val64 < fdc1004_calibbias[0] || val64 > fdc1004_calibbias[2])
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_word_swapped(
> +			client, FDC1004_REG_OFFSET_CAL_CINn(chan->channel),
> +			DIV_ROUND_CLOSEST(val64, fdc1004_calibbias[1]));
> +	case IIO_CHAN_INFO_CALIBSCALE:
> +		if (val64 < fdc1004_calibscale[0] || val64 > fdc1004_calibscale[2])
> +			return -EINVAL;
> +
> +		return i2c_smbus_write_word_swapped(
> +			client, FDC1004_REG_GAIN_CAL_CINn(chan->channel),
> +			DIV_ROUND_CLOSEST(val64, fdc1004_calibscale[1]));
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +#define FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(_index, _channel)         \
> +	{                                                                  \
> +		.type = IIO_CAPACITANCE,                                   \
> +		.indexed = true,                                           \
> +		.channel = _channel,                                       \
> +		.address = FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHA_MASK,    \
> +					    _channel) |                    \
> +			   FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHB_MASK,    \
> +					    FDC1004_CONF_MEAS_CHB_CAPDAC), \
> +		.scan_index = _index,                                      \
> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |             \
> +				      BIT(IIO_CHAN_INFO_OFFSET) |          \
> +				      BIT(IIO_CHAN_INFO_CALIBBIAS) |       \
> +				      BIT(IIO_CHAN_INFO_CALIBSCALE),       \

Interesting that you have these only for the single ends.  I guess they
are tweaks on the analog side?

> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),      \
> +		.info_mask_shared_by_type_available =                      \
> +			BIT(IIO_CHAN_INFO_OFFSET) |                        \
> +			BIT(IIO_CHAN_INFO_CALIBBIAS) |                     \
> +			BIT(IIO_CHAN_INFO_CALIBSCALE),                     \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),   \
> +		.info_mask_shared_by_all_available =                       \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),                      \
> +	}
> +
> +#define FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(_index, _chan1, _chan2)       \
> +	{                                                                      \
> +		.type = IIO_CAPACITANCE,                                       \
> +		.indexed = true,                                               \
> +		.differential = true,                                          \
> +		.channel = _chan1,                                             \
> +		.channel2 = _chan2,                                            \
> +		.address =                                                     \
> +			FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHA_MASK, _chan1) | \
> +			FIELD_PREP_CONST(FDC1004_CONF_MEAS_CHB_MASK, _chan2),  \

Why not build these of channel and channel 2 at the place where you need them?
This feels unnecessarily complex in this structure. Much better where we can
see the reason to do this used.
> +		.scan_index = _index,                                          \

Don't add scan index until you have buffer support.

> +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),                  \
> +		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),          \
> +		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),       \
> +		.info_mask_shared_by_all_available =                           \
> +			BIT(IIO_CHAN_INFO_SAMP_FREQ),                          \
> +	}
> +
> +static const struct iio_chan_spec fdc1004_channels[] = {
> +	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(0, 0),
> +	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(1, 1),
> +	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(2, 2),
> +	FDC1004_SINGLE_ENDED_CAPACITANCE_CHANNEL(3, 3),
> +
> +	/* The sensor only supports differential measurements where CHA < CHB. */

For a capacitance channel I'm going to guess that expectation is
wiring is such that only a subset of channels matter for a given
configuration?  It may be more user friendly to put that in
dt (see how we do it in adc/adc.yaml for instance).

> +	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(4, 0, 1),
> +	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(5, 0, 2),
> +	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(6, 0, 3),
> +
> +	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(7, 1, 2),
> +	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(8, 1, 3),
> +
> +	FDC1004_DIFFERENTIAL_CAPACITANCE_CHANNEL(9, 2, 3),
> +};
> +
> +static const struct iio_info fdc1004_info = {
> +	.read_raw = fdc1004_read_raw,
> +	.read_avail = fdc1004_read_avail,
> +	.write_raw = fdc1004_write_raw,
> +	.write_raw_get_fmt = fdc1004_write_raw_get_fmt,
> +};
> +
> +static int fdc1004_probe(struct i2c_client *client)
> +{
> +	struct iio_dev *indio_dev;
> +	struct fdc1004_data *data;
> +	int ret;
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_SMBUS_WORD_DATA))

I'd look at using regmap even though you only have a single bus. It provides
a rich set of helpers and the caching functionality that will save a bunch
of bus traffic.

> +		return -EOPNOTSUPP;
> +
> +	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data = iio_priv(indio_dev);
> +	data->client = client;
> +
> +	ret = devm_mutex_init(&client->dev, &data->lock);
> +	if (ret)
> +		return ret;
> +
> +	ret = devm_regulator_get_enable(&client->dev, "vdd");
> +	if (ret)
> +		return ret;
> +
> +	ret = fdc1004_soft_reset(client);
> +	if (ret)
> +		return ret;
> +
> +	indio_dev->name = "fdc1004";
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +	indio_dev->info = &fdc1004_info;
> +	indio_dev->channels = fdc1004_channels;
> +	indio_dev->num_channels = ARRAY_SIZE(fdc1004_channels);
> +
> +	return devm_iio_device_register(indio_dev->dev.parent, indio_dev);
> +}
> +
> +static const struct i2c_device_id fdc1004_id[] = {
> +	{ "fdc1004" },

Named initializer as below.

> +	{ }
> +};
> +
No line break here. We want visual coupling between the array and
the macro that uses it.
> +MODULE_DEVICE_TABLE(i2c, fdc1004_id);
> +
> +static const struct of_device_id fdc1004_of_match[] = {
> +	{ "ti,fdc1004" },

Use named initializers.  There is some rework of how these
IDs work currently going on that requires that + it is good practice
anyway.

> +	{ }
> +};
This should have a MODULE_DEVICE_TABLE as well.

> +


