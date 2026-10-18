Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD3E92C21D8;
	Sun, 18 Oct 2026 03:01:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792292488; cv=none; b=piJz3kFteTkB5NWNZ0Wl0Rvm8sKa96WxSZGtbWUIQb4Fb8v5rd7by3X8vi+5ugz0uuv8PCeb8cl12NTb8L1wUqGHSgZ0xGdcDII5400+Cc8TrVWYX01UpXJe4wjrG7gwI1cm+DP42nNPostqgT4gFpRc9gyv8RuSeq9Me91483k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792292488; c=relaxed/simple;
	bh=Lmsjoh8UIFUpUQXizL2oNfvxpyB3IZX8IjubtEvtIkU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AGlJ0jspjK4KXzbxKGTKPuHGL38Ou4mXXwX1hiZZyWS2ozggEhuGiFjBxOHiSOVldt7FWgVHi9te1Q5B20ygSjWfe3jqL3Ku8wGYNaRGsA4NIV21JTirg9pUA1NPS1pIle8db2CAwrir7Nvo+SGQDeyDIA0NbwtXJHLu6FhVW7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nfohei4h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nfohei4h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3DB81F000C4;
	Sun, 18 Oct 2026 03:01:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792292487;
	bh=96j1+7Gq4xGSW3f14VDoE2SlvoRfO3Rvy+gD/XIxceI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nfohei4hGdgpHxDsRZaMIiXN+4MgLrmCJlDgoX2BaziVwy1CfuTuR6el+Nj1KPKCR
	 JnAqdwl48YKUBMMc+PJ2CSOFX6AbwsznrzvMVhgQK5Ekm5je8z+rZtTI0TJMxlX8Lu
	 GUGTfl3S12Mg7meaGj8B0aiXvOTbmMxLdyksM47G2Y2Lu1K2yp5lPSHNs2vqqwyHv4
	 dd0lsXQL3OLoyEMMG2cgVny9hldVwxVHHW6+dj/xU6NrasBa4jcJNiu+r4a7YoK2Jg
	 fQgdgbqIha3ofBJPb8v9p6+ylHB0z2q/9S8lyNMw5GXrlXgq7DR39vWDCxFPI4U6nw
	 VTOzaGSRxb+Bg==
Date: Sun, 18 Oct 2026 04:01:22 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
Cc: Kanak Shilledar <kanak.shilledar@axis.com>, Henrik Grimler
 <henrik.grimler@axis.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jean-Baptiste Maneyrol
 <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts <joshua.crofts1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 6/6] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <20261018040122.27de8bf4@jic23-hlaptop>
In-Reply-To: <as1XY5EfKwfnb2DX@debian-BULLSEYE-live-builder-AMD64>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
	<20261009-b4-inv_icm42370p-v6-6-e53884f185ff@axis.com>
	<as1XY5EfKwfnb2DX@debian-BULLSEYE-live-builder-AMD64>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 12 Oct 2026 18:55:47 -0300
Marcelo Schmitt <marcelo.schmitt1@gmail.com> wrote:

> On 10/09, Kanak Shilledar wrote:
> > Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> > registers are stored in MREG1. The calibration bias is written to
> > OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
> > limit calibbias values instead of clamping it.
> >=20
> > Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-423=
70-p
> > Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> > --- =20
> ...
> > +static int inv_icm42607_accel_read_offset(struct inv_icm42607_state *s=
t,
> > +		struct iio_chan_spec const *chan, int *val, int *val2)
> > +{
> > +	struct device *dev =3D regmap_get_device(st->map);
> > +	unsigned int msb_reg, lsb_reg, nib, byte;
> > +	int offset;
> > +	s64 val64;
> > +	s32 bias;
> > +	int ret;
> > +	u32 raw;
> > +
> > +	if (chan->type !=3D IIO_ACCEL)
> > +		return -EINVAL;
> > +
> > +	switch (chan->channel2) {
> > +	case IIO_MOD_X:
> > +		msb_reg =3D INV_ICM42607_REG_OFFSET_USER4;
> > +		lsb_reg =3D INV_ICM42607_REG_OFFSET_USER5;
> > +		break;
> > +	case IIO_MOD_Y:
> > +		msb_reg =3D INV_ICM42607_REG_OFFSET_USER7;
> > +		lsb_reg =3D INV_ICM42607_REG_OFFSET_USER6;
> > +		break;
> > +	case IIO_MOD_Z:
> > +		msb_reg =3D INV_ICM42607_REG_OFFSET_USER7;
> > +		lsb_reg =3D INV_ICM42607_REG_OFFSET_USER8;
> > +		break;
> > +	default:
> > +		return -EINVAL;
> > +	}
> > +
> > +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> > +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> > +	if (ret)
> > +		return ret;
> > +
> > +	guard(mutex)(&st->lock);
> > +
> > +	ret =3D regmap_read(st->map, msb_reg, &nib);
> > +	if (ret)
> > +		return ret;
> > +
> > +	ret =3D regmap_read(st->map, lsb_reg, &byte);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* 12 bits signed value */
> > +	if (chan->channel2 =3D=3D IIO_MOD_Y)
> > +		raw =3D FIELD_PREP(INV_ICM42607_OFFSET_MSB,
> > +				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_LO, nib));
> > +	else
> > +		raw =3D FIELD_PREP(INV_ICM42607_OFFSET_MSB,
> > +				 FIELD_GET(INV_ICM42607_OFFSET_USER_NIBBLE_HI, nib));
> > +
> > +	raw |=3D FIELD_PREP(INV_ICM42607_OFFSET_LSB, byte);
> > +	offset =3D sign_extend32(raw, 11);
> > +
> > +	/*
> > +	 * Convert raw offset to g then to m/s=C2=B2
> > +	 * 12 bits signed raw step 0.5mg to g: 5 / 10000
> > +	 * g to m/s=C2=B2: 9.806650
> > +	 * Result in micro (1000000)
> > +	 * (offset * 5 * 9.806650 * 1000000) / 10000
> > +	 */ =20
> Maybe add a comment here highlighting that this is an exception among IIO=
 ABI
> and provide an additional patch extending the note on in_accel_x_calibbia=
s ABI
> doc to include icm42370. Having to amend the ABI doc that way looks to ha=
ve been
> an unfortunate need (also according to commit 69c93a7df74b).
>=20
> icm42370 seems to be similar to icm42600 so extending the exception might=
 be
> okay in this case. Creating new ABI is probably too much.

I'm a little unsure why scaling matters that much.
_calibbias is usual considered a 'pot twiddler' type of control
so unit less.  Obviously it's nice to have units from a useability
point of view but often these are actually controlling an analog
front end circuit with unknown and sometimes non linear behaviour.

So it would be acceptable to not worry about units at all and
just expose the offset value.  Putting it another way the
scaling is driver specific.  I think the existing special case
in the ABI docs might have been a result of cleaning up an entry
that was a duplicate after that stopped working (due to the
ABI getting built into the main docs and duplicates being detected.)

Jonathan

>=20
> > +	val64 =3D (s64)offset * 5LL * 9806650LL;
> > +	/* For rounding, add + or - divisor (10000) divided by 2 */
> > +	bias =3D DIV_S64_ROUND_CLOSEST(val64, 10000L);
> > +	*val =3D bias / (long)MEGA;
> > +	*val2 =3D bias % (long)MEGA;
> > +
> > +	return IIO_VAL_INT_PLUS_MICRO;
> > +}
> > +
> > +static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
> > +					   struct iio_chan_spec const *chan,
> > +					   int val, int val2)
> > +{
> > +	struct inv_icm42607_state *st =3D iio_device_get_drvdata(indio_dev);
> > +	struct device *dev =3D regmap_get_device(st->map);
> > +	s32 min, max;
> > +	u8 msb, lsb;
> > +	s16 offset;
> > +	s64 val64;
> > +	int ret;
> > +
> > +	if (chan->type !=3D IIO_ACCEL)
> > +		return -EINVAL;
> > +
> > +	/* inv_icm42607_accel_calibbias: min - step - max in micro */
> > +	min =3D inv_icm42607_accel_calibbias[0] * (long)MEGA -
> > +	      inv_icm42607_accel_calibbias[1];
> > +	max =3D inv_icm42607_accel_calibbias[4] * (long)MEGA +
> > +	      inv_icm42607_accel_calibbias[5];
> > +
> > +	val64 =3D val * (s64)MEGA;
> > +	if (val >=3D 0)
> > +		val64 +=3D val2;
> > +	else
> > +		val64 -=3D val2;
> > +
> > +	if (val64 < min || val64 > max)
> > +		return -EINVAL;
> > +
> > +	/*
> > +	 * Convert m/s=C2=B2 to g then to raw value
> > +	 * m/s=C2=B2 to g: 1 / 9.806650
> > +	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
> > +	 * val in micro (1000000)
> > +	 * val * 10000 / (9.806650 * 1000000 * 5)
> > +	 */ =20
> Unless Jonathan thinks it to be too verbose, we can also have an ABI comm=
ent here.
>=20
> With the ABI exception somehow highlighted,
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
>=20
> > +	val64 *=3D 10000LL;
> > +	offset =3D DIV_S64_ROUND_CLOSEST(val64, 9806650 * 5); =20
>=20
> With best regards,
> Marcelo

