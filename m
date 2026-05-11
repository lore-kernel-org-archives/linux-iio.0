Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82F4C3F9F48;
	Mon, 11 May 2026 14:23:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778509435; cv=none; b=A7Jb/R8PEeCeAFVaBdxVV0yZL/RmsyQ1txtUd1ZTYCaFnaKo1lk2gA9W8Q4SCd6/Hv7GZvOV4n6RZZ7WgoRobWIzvi9FrtsbcmyRVui+GYshWgPzv0D+FQgEJUt/hUlY9LJzUktCiq9A6L+3eytQED/v5/5uuagXTAXE63Dhi4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778509435; c=relaxed/simple;
	bh=jZbt3yxabD4k1PRKtlqaDEtqvU9Ft3tXU6fQFvvjiKs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KiD4g1xszF4TnjhAPDLtDvZ6EwL27WCxhc9mlSUn5cK+8qnJjtVI3WuCOEzplK4+Lt0uah31AYb9bID+tY7m7mIfb05GghM20+yjutYwUGesfFtzJdtC1svuajR9ANWlXczgrU30Su4myHFZaEAbBegRCxbr7/JeBPnyNF7Dlyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KZdReWG3; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KZdReWG3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60919C2BCB0;
	Mon, 11 May 2026 14:23:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778509435;
	bh=jZbt3yxabD4k1PRKtlqaDEtqvU9Ft3tXU6fQFvvjiKs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=KZdReWG3eJAmnNGmhWNQsijJHg/sRoskRg2exb17D9EsawjI6e2UqKC0vmJPNVYmB
	 4RwDZ/aJYHuqlBrSPJ5SOZ9AcWY2p+uJXNjHpMW8b0nbIGyyRmUrli33iecNLLmWVN
	 VgLbve0gZG3Fqv78ngvtJ0IxOguQ/BhtRRkgfuScLlSQkeWhj7Z0kGrwsyevXvQ5E1
	 NZIxJKxF9FWnlFBntyorJLi4pnteGUXCxkQ3PBVP1Ct7KNj51eNKP2UBbs1JJI2zxA
	 ZRLF+LkSzyXGHUBpqTMUFzjSAk1YKeHCCOhycfdVj/D771ixMo7V8KZNydGqNGw1P/
	 Rrt8khGqNqZmw==
Date: Mon, 11 May 2026 15:23:46 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Nikhil Gautam <nikhilgtr@gmail.com>
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org,
 robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] iio: magnetometer: add support for Melexis
 MLX90393
Message-ID: <20260511152346.14d9bf49@jic23-huawei>
In-Reply-To: <20260510191010.155380-3-nikhilgtr@gmail.com>
References: <20260510191010.155380-1-nikhilgtr@gmail.com>
	<20260510191010.155380-3-nikhilgtr@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 11 May 2026 00:40:10 +0530
Nikhil Gautam <nikhilgtr@gmail.com> wrote:

> Add Industrial I/O subsystem support for the Melexis
> MLX90393 3-axis magnetometer and temperature sensor.
>=20
> The driver currently supports:
>=20
> raw magnetic field measurements
> raw temperature measurements
> configurable gain/scale selection
> configurable oversampling ratio
> direct mode operation
>=20
> The MLX90393 supports both I2C and SPI interfaces. This
> initial implementation adds support for the I2C interface.
>=20
> The driver is structured around a shared sensor core with
> a small transport abstraction layer to simplify future SPI
> support without duplicating sensor logic.
>=20
> Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>

Hi Nikhil

Quick process reminder - even though I've reviewed this the day you
sent it out (coincidence of when I am catching up with backlog!),
wait to send a v2 for at least a week so there is plenty of time
for others to review.

Various comments inline,

Thanks,

Jonathan

> diff --git a/drivers/iio/magnetometer/mlx90393.h b/drivers/iio/magnetomet=
er/mlx90393.h
> new file mode 100644
> index 000000000000..f3e04aed67de
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393.h
> @@ -0,0 +1,76 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * MLX90393 magnetometer & temperature sensor driver
> + *
> + * Copyright (c) 2026 Nikhil Gautam <nikhilgtr@gmail.com>
> + */
> +
> +#ifndef MLX90393_H
> +#define MLX90393_H
> +
> +#include <linux/bitops.h>
> +#include <linux/bits.h>
> +#include <linux/device.h>
As below - generally don't want to see device.h included in a new driver.

> +#include <linux/types.h>
> +
> +#define MLX90393_AXIS_MAX		2
> +#define MLX90393_GAIN_MAX		8
> +#define MLX90393_RES_MAX		4
> +#define MLX90393_OSR2_MAX		4
> +#define MLX90393_OSR_MAX		4
> +
> +#define MLX90393_CMD_MASK	GENMASK(7, 4)
> +
> +/* Commands */
> +#define MLX90393_CMD_SB		0x10
> +#define MLX90393_CMD_SW		0x20
> +#define MLX90393_CMD_SM		0x30
> +#define MLX90393_CMD_RM         0x40
> +#define MLX90393_CMD_RR         0x50
> +#define MLX90393_CMD_WR         0x60
> +#define MLX90393_CMD_EX         0x80
> +#define MLX90393_CMD_HR         0xD0
> +#define MLX90393_CMD_HS         0xE0
> +#define MLX90393_CMD_RT         0xF0

Maybe use a few more characters as those are pretty opaque acronyms!
Fair enough if they are straight from the datasheet but in that case can we=
 have
some comments.


> diff --git a/drivers/iio/magnetometer/mlx90393_core.c b/drivers/iio/magne=
tometer/mlx90393_core.c
> new file mode 100644
> index 000000000000..c79f2b8c20d8
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393_core.c
> @@ -0,0 +1,724 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * MLX90393 magnetometer & temperature sensor driver
> + *
> + * Copyright (c) 2026 Nikhil Gautam <nikhilgtr@gmail.com>
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/device.h>
Generally not needed - try and find more specific relevant includes.

Check to see if you need more - this is a very short set for a driver
and we generally try to follow include what you use principles in IIO.

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/unaligned.h>
> +#include <linux/units.h>
> +
> +#include <linux/iio/iio.h>
> +
> +#include "mlx90393.h"
> +
> +struct mlx90393_data {
> +	struct device *dev;
> +	struct mutex lock;
Locks should always have a comment saying what data they are protecting.

> +	void *bus_context;
> +	const struct mlx90393_transfer_ops *ops;
> +	u8 gain_sel;
> +	u8 hallconf;
> +
> +	u8 res_xy;
> +	u8 res_z;
> +
> +	u8 dig_filt;
> +	u8 osr;
> +	u8 osr2;
> +};

> +
> +/* Datasheet: Table no.17 */
> +static const int mlx90393_scale_table[MLX90393_AXIS_MAX]
> +				[MLX90393_GAIN_MAX]
> +				[MLX90393_RES_MAX] =3D {
> +	/* XY axis */
> +	{
> +		{751, 1502, 3004, 6009},
		{ 751, 1502, 3004, 6009 },
etc
As noted below I'd prefer this reformatted so you don't have
to copy it into that local static array.  That way we can greatly
simplify avoiding some race conditions.

> +		{601, 1202, 2403, 4840},
> +		{451, 901, 1803, 3605},
> +		{376, 751, 1502, 3004},
> +		{300, 601, 1202, 2403},
> +		{250, 501, 1001, 2003},
> +		{200, 401, 801, 1602},
> +		{150, 300, 601, 1202},
> +	},
> +	/* Z axis */
> +	{
> +		{1210, 2420, 4840, 9680},
> +		{968, 1936, 3872, 7744},
> +		{726, 1452, 2904, 5808},
> +		{605, 1210, 2420, 4840},
> +		{484, 968, 1936, 3872},
> +		{403, 807, 1613, 3227},
> +		{323, 645, 1291, 2581},
> +		{242, 484, 968, 1936},
> +	}
> +};

> +/*
> + * Calculate total conversion time in microseconds.
> + *
> + * Formula derived from datasheet timing equations.
> + */
> +
> +static int mlx90393_get_tconv_us(struct mlx90393_data *data)
> +{
> +	const int osr =3D data->osr;
> +	const int osr2 =3D data->osr2;
> +	const int df =3D data->dig_filt;
> +
> +	int tconvm;
> +	int tconvt;
> +
> +	int m =3D 3; /* X,Y,Z */
> +
> +	/*
> +	 * Datasheet:
> +	 *
> +	 * TCONVM =3D
> +	 * 67 + 64 * 2^OSR * (2 + 2^DIG_FILT)
> +	 */
> +	tconvm =3D 67 +
> +		(64 * BIT(osr) *
> +		 (2 + BIT(df)));
> +
> +	/*
> +	 * Datasheet:
> +	 *
> +	 * TCONVT =3D
> +	 * 67 + 192 * 2^OSR2
> +	 */
> +	tconvt =3D 67 +
> +		(192 * BIT(osr2));
> +	/*
> +	 * Total conversion time:
> +	 * TSTBY + TACTIVE + m * TCONVM +
> +	 * TCONVT + TCONV_END
> +	 */
> +	return 220 +
> +		360 +
> +		(m * tconvm) +
> +		tconvt +
> +		100;

If you are going to comment on the maths - match that layout in the
code rather than having so many line breaks.


> +}

> +
> +static int mlx90393_check_status(u8 cmd, u8 status)
> +{
> +	/* Always validate error bit */
> +	if (status & MLX90393_STATUS_ERROR)
> +		return -EIO;
> +
> +	switch (cmd & MLX90393_CMD_MASK) {
> +	case MLX90393_CMD_RM:
> +		/*
> +		 * D1:D0 indicates response availability
> +		 * 00 means invalid/no measurement
> +		 */
> +		if ((status & MLX90393_STATUS_RESP) =3D=3D 0)
> +			return -EIO;
> +		break;
return 0;
similar reasoning to comment below.
> +
> +	case MLX90393_CMD_RT:
> +		/* Reset acknowledge */
> +		if (!(status & MLX90393_STATUS_RT))
> +			return -EIO;
> +		break;
> +
> +	default:
> +		break;
> +	}
> +
> +	return 0;
> +}

> +
> +static int mlx90393_write_reg(struct mlx90393_data *data,
> +			      u8 reg, u16 val)
> +{
> +	u8 tx[4];
> +	u8 status;
> +	int ret;
> +
> +	tx[0] =3D MLX90393_CMD_WR;
> +	put_unaligned_be16(val, &tx[1]);
> +	/* Register address is encoded in bits [7:2] */
> +	tx[3] =3D reg << 2;
> +
> +	ret =3D mlx90393_xfer(data,
> +			    tx, sizeof(tx),
> +			    &status, 1);

Wrap much less!

> +	if (ret)
> +		return ret;
> +
> +	return mlx90393_check_status(tx[0], status);
> +}

> +
> +static int mlx90393_read_measurement(struct mlx90393_data *data,
> +				     enum mlx90393_channels chan, int *val)
> +{
> +	u8 cmd;
> +	u8 rx[9];
> +	int ret;
> +	int tconv_us =3D mlx90393_get_tconv_us(data);
> +
> +	/* Start measurement */
> +	cmd =3D MLX90393_CMD_SM | MLX90393_MEASURE_ALL;
> +
> +	ret =3D mlx90393_write_cmd(data, cmd);
> +	if (ret)
> +		return ret;
> +
> +	/* Wait conversion */
> +	usleep_range(tconv_us, tconv_us + 1000);

fsleep() for all 'fuzzy' ranges like this.

> +
> +	/* Read measurement */
> +	cmd =3D MLX90393_CMD_RM | MLX90393_MEASURE_ALL;
Even here I'd put that value inline in the call rather than
having a local variable for it.

> +
> +	ret =3D mlx90393_read_cmd(data, cmd, rx, sizeof(rx));
> +	if (ret)
> +		return ret;
> +	/*
> +	 * Measurement response layout:
> +	 * [status][temp][x][y][z]
> +	 */
> +
> +	switch (chan) {
> +	case MLX90393_CHAN_TEMP:
> +		*val =3D get_unaligned_be16(&rx[1]);
> +		break;
> +
> +	case MLX90393_CHAN_X:
> +		*val =3D sign_extend32(get_unaligned_be16(&rx[3]), 15);
> +		break;
> +
> +	case MLX90393_CHAN_Y:
> +		*val =3D sign_extend32(get_unaligned_be16(&rx[5]), 15);
> +		break;
> +
> +	case MLX90393_CHAN_Z:
> +		*val =3D sign_extend32(get_unaligned_be16(&rx[7]), 15);
> +		break;
> +
> +	default:
> +		return -EINVAL;
> +	}
> +
> +	return 0;
Maybe just return early instead of break.  Saves the reader scrolling
down to see what else is to be done.
> +}
> +
> +static int mlx90393_get_scale(struct mlx90393_data *data,
> +			      const struct iio_chan_spec *chan,
> +			      int *val, int *val2)
> +{
> +	enum mlx90393_axis_type axis;
> +	u8 res;
> +
> +	if (chan->channel2 =3D=3D IIO_MOD_Z) {
> +		axis =3D MLX90393_AXIS_TYPE_Z;
> +		res =3D data->res_z;
Be consistent - here you use an if / else, below to ternary operators.
I don't much mind which (slightly preference for this) but mixing
this sort of thing up just makes for harder code to review.



> +	} else {
> +		axis =3D MLX90393_AXIS_TYPE_XY;
> +		res =3D data->res_xy;
> +	}
> +
> +	/*
> +	 * Convert:
> +	 * =C2=B5T =C3=97 1000 =E2=86=92 nT
> +	 */
> +	*val =3D 0;
> +	*val2 =3D mlx90393_scale_table[axis][data->gain_sel][res];
> +
> +	return IIO_VAL_INT_PLUS_NANO;
> +}
> +
> +static int mlx90393_find_scale(struct mlx90393_data *data,
> +			       bool z_axis,
> +			       int val, int val2,
> +			       int *gain)
> +{
> +	int i;
> +	u8 res;
> +	enum mlx90393_axis_type axis;
> +
> +	axis =3D z_axis ? MLX90393_AXIS_TYPE_Z :
> +		MLX90393_AXIS_TYPE_XY;
Go long if it helps readability and here I think it does + it's under
80 chars anyway!

	axis =3D z_axis ? MLX90393_AXIS_TYPE_Z : MLX90393_AXIS_TYPE_XY;

> +
> +	res =3D z_axis ? data->res_z : data->res_xy;
> +
> +	if (val !=3D 0)
> +		return -EINVAL;
> +
> +	for (i =3D 0; i < ARRAY_SIZE(mlx90393_scale_table[0]); i++) {
> +		if (mlx90393_scale_table[axis][i][res]
> +				=3D=3D val2) {
Here readability is hurt and it fits on one line under 80 chars anyway!
		if (mlx90393_scale_table[axis][i][res] =3D=3D val2) {

> +			*gain =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}
> +
> +static int mlx90393_set_scale(struct mlx90393_data *data,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2)
> +{
> +	bool z_axis;
> +	int gain;
> +	int ret;
> +
> +	z_axis =3D chan->channel2 =3D=3D IIO_MOD_Z;
> +
> +	ret =3D mlx90393_find_scale(data, z_axis,
> +				  val, val2,
> +				  &gain);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D mlx90393_update_bits(data,
> +				   MLX90393_REG_CONF1,
> +				   MLX90393_CONF1_GAIN_SEL,
> +				   gain);
I'd wrap these less
	ret =3D mlx90393_update_bits(data, MLX90393_REG_CONF1,
> +				   MLX90393_CONF1_GAIN_SEL, gain);
For example. Same for other similar cases.

> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel =3D gain;
> +
> +	return 0;
> +}

> +static int mlx90393_find_osr(int val, int *osr)
> +{
> +	int i;
> +
> +	for (i =3D 0; i < MLX90393_OSR_MAX;  i++) {

For modern kernel code it's acceptable to do
	for (unsigned int i =3D 0; i < MLX....)
and avoid needing to define the local variable separately above.

> +		if (mlx90393_osr_avail[i] =3D=3D val) {
> +			*osr =3D i;
> +			return 0;
> +		}
> +	}
> +
> +	return -EINVAL;
> +}

> +static int mlx90393_write_raw_get_fmt(struct iio_dev *indio_dev,
> +				      struct iio_chan_spec const *chan,
> +				      long mask)
> +{
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		return IIO_VAL_INT_PLUS_NANO;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		return IIO_VAL_INT;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90393_write_raw(struct iio_dev *indio_dev,
> +			      const struct iio_chan_spec *chan,
> +			      int val, int val2,
> +			      long mask)
> +{
> +	struct mlx90393_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		mutex_lock(&data->lock);

Less useful but I'd use a guard() here as well just for consistency.

> +		ret =3D mlx90393_set_scale(data, chan, val, val2);
> +		mutex_unlock(&data->lock);
> +		return ret;
> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:

Similar use of guard() + {} to described below.  Then you can return
directly for each leg.

> +		mutex_lock(&data->lock);
> +		if (chan->type =3D=3D IIO_TEMP)
> +			ret =3D mlx90393_set_temp_osr2(data, val);
> +		else if (chan->type =3D=3D IIO_MAGN)
> +			ret =3D mlx90393_set_osr(data, val);
> +		else
> +			ret =3D -EINVAL;
> +		mutex_unlock(&data->lock);
> +		return ret;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90393_read_raw(struct iio_dev *indio_dev,
> +			     const struct iio_chan_spec *chan,
> +			     int *val, int *val2, long mask)
> +{
> +	struct mlx90393_data *data =3D iio_priv(indio_dev);
> +	int ret;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:

This is fine but maybe slightly nicer as:

	case IIO_CHAN_INFO_RAW: {
		guard(mutex)(&data->lock);
	=09
		ret =3D mlx90393_read_measurement(data, chan->addrss, val)
		if (ret)
			return ret;

		return IIO_VAL_INT;
	}
> +		mutex_lock(&data->lock);
> +		ret =3D mlx90393_read_measurement(data, chan->address, val);
> +		mutex_unlock(&data->lock);
> +		if (ret)
> +			return ret;
> +
> +		return IIO_VAL_INT;
> +
> +	case IIO_CHAN_INFO_SCALE:
> +		switch (chan->type) {
> +		case IIO_MAGN:
> +			return mlx90393_get_scale(data, chan, val, val2);
> +
> +		case IIO_TEMP:
> +			/* Datasheet: 22124 millidegC/LSB */
> +			*val =3D 0;
> +			*val2 =3D 22124;
> +			return IIO_VAL_INT_PLUS_MICRO;
> +
> +		default:
> +			return -EINVAL;
> +		}
> +
> +	case IIO_CHAN_INFO_OFFSET:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			/* Datasheet: temperature offset */
> +			*val =3D -45114;
> +			return IIO_VAL_INT;
> +		}
> +		return -EINVAL;
I'd flip the logic .
		if (chan->type !=3D IIO_TEMP)
			return -EINVAL;

> +
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (chan->type =3D=3D IIO_TEMP)

Maybe a switch statement would be nicer and consistent at leasts
with scale above.

> +			return mlx90393_get_temp_osr2(data, val);
> +		if (chan->type =3D=3D IIO_MAGN)
> +			return mlx90393_get_osr(data, val);
> +		return -EINVAL;
> +	default:
> +		return -EINVAL;
> +	}
> +}
> +
> +static int mlx90393_read_avail(struct iio_dev *indio_dev,
> +			       const struct iio_chan_spec *chan,
> +			       const int **vals,
> +			       int *type,
> +			       int *length,
> +			       long mask)
> +{
> +	struct mlx90393_data *data =3D iio_priv(indio_dev);
> +
> +	static int scale_avail[MLX90393_GAIN_MAX][MLX90393_AXIS_MAX];
> +	enum mlx90393_axis_type axis;
> +	int i;
> +	u8 res;
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_SCALE:
> +		axis =3D chan->channel2 =3D=3D IIO_MOD_Z;
> +		res =3D axis ? data->res_z : data->res_xy;
> +
> +		for (i =3D 0; i < MLX90393_GAIN_MAX; i++) {
> +			scale_avail[i][0] =3D 0;
> +			scale_avail[i][1] =3D
> +				mlx90393_scale_table[axis][i][res];
If you support changing rest this can tear mid table write and you
get half of one table and half of the other. Use a lock.

However, can you just make that mlx90393_scale_table have a datalayout
that lets you pick between parts of that rather than having to copy it
in here?

> +		}
> +
> +		*vals =3D &scale_avail[0][0];
> +		*type =3D IIO_VAL_INT_PLUS_NANO;
> +		*length =3D MLX90393_GAIN_MAX * MLX90393_AXIS_MAX;
> +		break;
> +	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
> +		if (chan->type =3D=3D IIO_TEMP) {
> +			*vals =3D mlx90393_osr2_avail;
> +			*type =3D IIO_VAL_INT;
> +			*length =3D MLX90393_OSR2_MAX;
> +		} else {
> +			*vals =3D mlx90393_osr_avail;
> +			*type =3D IIO_VAL_INT;
> +			*length =3D MLX90393_OSR_MAX;
> +		}
> +
> +		break;
> +	default:
> +		return -EINVAL;
> +	}
> +	return IIO_AVAIL_LIST;
> +}

> +
> +static int mlx90393_init(struct mlx90393_data *data)
> +{
> +	int ret;
> +	u8 cmd;
> +	u16 reg;
> +
> +	/* Exit mode */
> +	cmd =3D MLX90393_CMD_EX;

Seems little benefit in the local variable use over

	ret =3D mlx90393_write_cmd(data, MLX90393_CMD_EX);

> +	ret =3D mlx90393_write_cmd(data, cmd);
> +	if (ret)
> +		return ret;
> +
> +	usleep_range(1000, 1500);

fsleep() + a comment on why this particular sleep time.

> +
> +	/* Reset device */
> +	cmd =3D MLX90393_CMD_RT;
> +	ret =3D mlx90393_write_cmd(data, cmd);
Similar to above.
> +	if (ret)
> +		return ret;
> +
> +	/* Wait for device to reset */
> +	usleep_range(5000, 6000);
and similar to above.

> +
> +	ret =3D mlx90393_read_reg(data, MLX90393_REG_CONF1, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->gain_sel =3D FIELD_GET(MLX90393_CONF1_GAIN_SEL, reg);
> +	data->hallconf =3D FIELD_GET(MLX90393_CONF1_HALLCONF, reg);
> +
> +	ret =3D mlx90393_read_reg(data, MLX90393_REG_CONF3, &reg);
> +	if (ret)
> +		return ret;
> +
> +	data->res_xy =3D FIELD_GET(MLX90393_CONF3_RES_X, reg);
> +	data->res_z =3D FIELD_GET(MLX90393_CONF3_RES_Z, reg);
> +	data->dig_filt =3D FIELD_GET(MLX90393_CONF3_DIG_FILT, reg);
> +	data->osr =3D FIELD_GET(MLX90393_CONF3_OSR, reg);
> +	data->osr2 =3D FIELD_GET(MLX90393_CONF3_OSR2, reg);
> +
> +	return 0;
> +}
> +
> +int mlx90393_core_probe(struct device *dev,
> +			const struct mlx90393_transfer_ops *ops,
> +			void *context)
> +{
> +	struct iio_dev *indio_dev;
> +	struct mlx90393_data *data;
> +	int ret;
> +
> +	indio_dev =3D devm_iio_device_alloc(dev, sizeof(*data));
> +	if (!indio_dev)
> +		return -ENOMEM;
> +
> +	data =3D iio_priv(indio_dev);
> +	mutex_init(&data->lock);
	ret =3D devm_mutex_init(&data->lock);
	if (ret)
		return ret;

Small advantage for lock debugging but now it's near free with that helper
it's nicer to do the version that actually marks the lock as disabled on ex=
it.

> +
> +	data->dev =3D dev;
> +	data->ops =3D ops;
> +	data->bus_context =3D context;
> +
> +	indio_dev->name =3D "mlx90393";
> +	indio_dev->info =3D &mlx90393_info;
> +	indio_dev->modes =3D INDIO_DIRECT_MODE;
> +	indio_dev->channels =3D mlx90393_channels;
> +	indio_dev->num_channels =3D ARRAY_SIZE(mlx90393_channels);
> +
> +	ret =3D mlx90393_init(data);
> +	if (ret) {
> +		dev_err_probe(dev, ret, "failed to initialize device\n");
> +		return ret;
		return dev_err_probe();

> +	}
> +
> +	return devm_iio_device_register(dev, indio_dev);
> +}

> diff --git a/drivers/iio/magnetometer/mlx90393_i2c.c b/drivers/iio/magnet=
ometer/mlx90393_i2c.c
> new file mode 100644
> index 000000000000..09d533a96907
> --- /dev/null
> +++ b/drivers/iio/magnetometer/mlx90393_i2c.c
> @@ -0,0 +1,71 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +#include <linux/module.h>
> +#include <linux/i2c.h>

mod_devicetable.h for the id table structure definitions.

> +
> +#include "mlx90393.h"
> +
> +/*
> + * MLX90393 commands use repeated-start transfers where
> + * every command is followed by a status/data response.
> + */
> +static int mlx90393_i2c_xfer(void *context,
> +			     const u8 *tx, int tx_len,
> +			     u8 *rx, int rx_len)
> +{
> +	struct i2c_client *client =3D context;
> +	int ret;
> +	struct i2c_msg msgs[2];
> +
> +	msgs[0].addr =3D client->addr;
> +	msgs[0].flags =3D 0;
> +	msgs[0].len =3D tx_len;
> +	msgs[0].buf =3D (u8 *)tx;
> +
> +	msgs[1].addr =3D client->addr;
> +	msgs[1].flags =3D I2C_M_RD;
> +	msgs[1].len =3D rx_len;
> +	msgs[1].buf =3D rx;

	struct i2c_msg msgs[2] =3D {
		[0] =3D {
			.addr =3D client->addr,
			.len =3D tx_len,
			.buf =3D (u8 *)tx,=20
		},
		[1] =3D {
			.addr =3D client->addr,
			.flags =3D I2C_M_RD,
			.len =3D rx_len,
			.buf =3D rx,
		},
	};
> +
> +	ret =3D i2c_transfer(client->adapter, msgs, 2);

sizeof(msgs)

> +	if (ret !=3D 2)

sizeof(msgs)

> +		return ret < 0 ? ret : -EIO;
> +
> +	return 0;
> +}

> +static int mlx90393_i2c_probe(struct i2c_client *client)
> +{
> +	return mlx90393_core_probe(&client->dev,
> +				  &mlx90393_i2c_ops,
> +				  client);
	return mlx90393_core_probe(&client->dev, &mlx90393_i2c_ops, client);
Definitely wrap less than you have and I'd probably just go a bit long on
this one and have it all on one line.


> +}
> +
> +static const struct i2c_device_id mlx90393_id[] =3D {
> +	{ "mlx90393", 0 },
	{ "mlx90393" }

The , 0 doesn't add anything as if we do ever need to add
data it will be a pointer and not 0 anyway.

> +	{ }
> +};
> +MODULE_DEVICE_TABLE(i2c, mlx90393_id);

