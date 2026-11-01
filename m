Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793571934;
	b=Oz4HLMHDNQ+BvJSuXzkHxehyK+4GKBRKSqIKmVtWigZeA+XlUMwhDaHKpn+uSAuQ6BQH
	 bSJcKgzvDxVdx8sO805AJRepd7q7FaPp/MVIgyd2OhS5bo8sr0DCIJHHqtonqBFb273Ta
	 ENcHLSiy4ZdVIGn9fHxkedouv0GlTSC0flYRlDWoD+A7FHaATICc5x3biIfRl5RlIEUeO
	 cHW20HHtId2Jgs3z1dQDKd+AKkqIPQVT5Jrf4mOPotIVL9yRZHZWrNiYhSSgEwUlhmUEQ
	 IMtBf4/ARNz8zAJLHZBbW1fYkD3An2djdeYV4LCxJ2njWz1pH8gR+FSNy7ETpE+mxdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793571934;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8sOoVCRcZN/x0LMY6dgWZjebg2CSDJGW78WD2Rp9JOk=;
	b=N+PtyQnTs9UoV5pFk0e0DesmKIjuCP1ovD5Ou+UDuHG8gzhB632Z0tawLpPod1DG+9gC
	 3qOghmha/lcPwkVzQivGljWnM++i8KZXZFDMeP6KBlGGzLoUgHK94ovdiATqp09h15w1w
	 jsKUhi4YvMgdf6nPacE0o8987ZCoyAqPkwWffrOWQfcvWebVyTA2syGy+4Fk1Og646G1I
	 G4cxl3zElc+2IEJibnSdPUIala69XJpsaoIlkkyIiTnklYXgVB4G2yJ0ojYVV3p9XJXtG
	 pZJWBFyCWdcJn5BAQcYN1zGaQINzXrCZev1mRs/l8vbm9ilOSLOu3ON3QozdrXeOUxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8rmNcVY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2063F606E527;
	Sun,  1 Nov 2026 22:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V8rmNcVY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3915E1F000C1;
	Sun,  1 Nov 2026 22:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793571933;
	bh=8sOoVCRcZN/x0LMY6dgWZjebg2CSDJGW78WD2Rp9JOk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=V8rmNcVYviQJAu7eXwfrG/iy4DFzgdzimOFhPCKd3jsOWvGYdXk0J4xxkhSesTnvv
	 C5tXKm85R6al635JtY3Me14qQlMBoOS1B9N1BCKd+23ppkJMGogryE4wbmoxF/K9Mj
	 nNb0mRZ+2hAW6NfWQTQXtU2UPrmcgGKRoDReGE5V1A5yklvDW+YYMDog2CMnk0W+Ju
	 /25jRTtShkYlWY8E05dlkU7xnjTO62ZSe/lkp9i383NI/KNkod7MIF383PnTeXROjJ
	 26B0C7kcYuWcBrtg06s+yOZqqaBTK/NKr8Q1MNfkI2nniE3Y6+FBvUFu2+bMkqajzg
	 //56bQgv/+1pQ==
Date: Sun, 1 Nov 2026 22:25:28 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 "Jean-Baptiste Maneyrol" <jean-baptiste.maneyrol@tdk.com>, Joshua Crofts
 <joshua.crofts1@gmail.com>, Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
 Chris Morgan <macromorgan@hotmail.com>, <kernel@axis.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, Jonathan Cameron
 <jonathan.cameron@oss.qualcomm.com>, Krzysztof Kozlowski
 <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v7 7/7] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <20261101222528.4ee16a59@jic23-hlaptop>
In-Reply-To: <20261026-b4-inv_icm42370p-v7-7-222e296ac1e0@axis.com>
References: <20261026-b4-inv_icm42370p-v7-0-222e296ac1e0@axis.com>
	<20261026-b4-inv_icm42370p-v7-7-222e296ac1e0@axis.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 26 Oct 2026 12:02:55 +0100
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> registers are stored in MREG1. The calibration bias is written to
> OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
> limit calibbias values instead of clamping it.
>=20
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370=
-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
Minor thing inline given you are going to be doing a v8

Thanks,

Jonathan

> diff --git a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c b/drivers/=
iio/imu/inv_icm42607/inv_icm42607_accel.c
> index 9a3ace3e7fcf9..2878e35d655d0 100644
> --- a/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> +++ b/drivers/iio/imu/inv_icm42607/inv_icm42607_accel.c
> @@ -4,6 +4,7 @@
>   */
> =20
>  #include <linux/array_size.h>
> +#include <linux/bitfield.h>
>  #include <linux/bits.h>
>  #include <linux/cleanup.h>
>  #include <linux/device/devres.h>
> @@ -13,6 +14,7 @@
>  #include <linux/pm_runtime.h>
>  #include <linux/regmap.h>
>  #include <linux/types.h>
> +#include <linux/units.h>
> =20
>  #include "inv_icm42607.h"
>  #include "inv_icm42607_temp.h"
> @@ -22,9 +24,11 @@
>  	.type =3D IIO_ACCEL,							\
>  	.modified =3D 1,								\
>  	.channel2 =3D _modifier,							\
> -	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),				\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW) |				\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
+			      BIT(IIO_CHAN_INFO_CALIBBIAS),			\
Is my preference for aligning the blocks of a load of bits.

>  	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),			\
> -	.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type_available =3D BIT(IIO_CHAN_INFO_SCALE) |	\
> +		BIT(IIO_CHAN_INFO_CALIBBIAS),					\
>  	.info_mask_shared_by_all =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),		\
>  	.info_mask_shared_by_all_available =3D BIT(IIO_CHAN_INFO_SAMP_FREQ),	\
>  	.scan_index =3D _index,							\
> @@ -56,6 +60,16 @@ static const struct iio_chan_spec inv_icm42607_accel_c=
hannels[] =3D {
>  	INV_ICM42607_TEMP_CHAN(INV_ICM42607_ACCEL_SCAN_TEMP),
>  };

> +
> +static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   int val, int val2)
> +{
> +	struct inv_icm42607_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->map);
> +	s32 min, max;
> +	u8 msb, lsb;
> +	s16 offset;
> +	s64 val64;
> +	int ret;
> +
> +	if (chan->type !=3D IIO_ACCEL)
> +		return -EINVAL;
> +
> +	/* inv_icm42607_accel_calibbias: min - step - max in micro */
> +	min =3D inv_icm42607_accel_calibbias[0] * (long)MEGA -
> +	      inv_icm42607_accel_calibbias[1];
> +	max =3D inv_icm42607_accel_calibbias[4] * (long)MEGA +
> +	      inv_icm42607_accel_calibbias[5];
> +
> +	val64 =3D val * (s64)MEGA;
> +	if (val >=3D 0)
> +		val64 +=3D val2;
> +	else
> +		val64 -=3D val2;
> +
> +	if (val64 < min || val64 > max)
> +		return -EINVAL;
> +
> +	/*
> +	 * Convert m/s=C2=B2 to g then to raw value
> +	 * m/s=C2=B2 to g: 1 / 9.806650
> +	 * g to raw 12 bits signed, step 0.5mg: 10000 / 5
> +	 * val in micro (1000000)
> +	 * val * 10000 / (9.806650 * 1000000 * 5)
> +	 */
> +	val64 *=3D 10000LL;
> +	offset =3D DIV_S64_ROUND_CLOSEST(val64, 9806650 * 5);
> +
> +	/* Value is limited to 12 bits signed, return -EINVAL if out of range */
> +	if (offset < -2048 || offset > 2047)
> +		return -EINVAL;
> +
> +	msb =3D FIELD_GET(INV_ICM42607_OFFSET_MSB, offset);
> +	lsb =3D FIELD_GET(INV_ICM42607_OFFSET_LSB, offset);
> +
> +	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(dev, pm);
> +	ret =3D PM_RUNTIME_ACQUIRE_ERR(&pm);
> +	if (ret)
> +		return ret;
> +
> +	guard(mutex)(&st->lock);
> +
> +	switch (chan->channel2) {
> +	case IIO_MOD_X:
> +		/* OFFSET_USER4 upper nibble is shared. */
> +		ret =3D regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER4,
> +				INV_ICM42607_OFFSET_USER_NIBBLE_HI,
Align after (
Don't worry about slightly long lines.

> +				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
> +		if (ret)
> +			return ret;
> +
> +		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER5, lsb);
> +	case IIO_MOD_Y:
> +		/* OFFSET_USER7 lower nibble is shared. */
> +		ret =3D regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
> +				INV_ICM42607_OFFSET_USER_NIBBLE_LO,
> +				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_LO, msb));
> +		if (ret)
> +			return ret;
> +
> +		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER6, lsb);
> +	case IIO_MOD_Z:
> +		/* OFFSET_USER7 upper nibble is shared. */
> +		ret =3D regmap_update_bits(st->map, INV_ICM42607_REG_OFFSET_USER7,
> +				INV_ICM42607_OFFSET_USER_NIBBLE_HI,
> +				FIELD_PREP(INV_ICM42607_OFFSET_USER_NIBBLE_HI, msb));
> +		if (ret)
> +			return ret;
> +
> +		return regmap_write(st->map, INV_ICM42607_REG_OFFSET_USER8, lsb);
> +	default:
> +		return -EINVAL;
> +	}
> +}


