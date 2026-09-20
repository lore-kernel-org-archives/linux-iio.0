Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02B28400E0C;
	Sun, 20 Sep 2026 23:55:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789948547; cv=none; b=rrfo82pbYaujeRmGDvC/nxIUsMg1I0OAWO30GvpnoguRmR7TGwSVfhLHl1IqSu5Nh91dUbqzfFnR52JULr7CAa7fiVd9oxqYaXcU2K3GIu9oobjTIDOsZLwGQE0Ams9AV9ILreLgQpO6r0ejerKHwBP9bP5gwUNqq0l/0wCDDac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789948547; c=relaxed/simple;
	bh=AAMlDQGtL1onyOJB2KHN4gmseQhVKtGqnCwD19Ispgc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nujxPlKUUlTdbHVbvgVTgVAhNaMoc4x6aNWC5ZHJybVcZ0GVqc7WVYeBTQVd6nAz30fYKJGd64WGumQ3LEEdl3dvVCUe/ryRArp+e86BhANkPW6AfbOCy6w2PmXhTlGeB4SB/hGDSCSraditzj0sjhOZ0UsQxud+GDBcz2OhDfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MllexO/s; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MllexO/s"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7D5B1F00898;
	Sun, 20 Sep 2026 23:55:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789948545;
	bh=v5GEN9oONH9+NMi/TakmCZGcZjwoQKOh3txGhDWuPHs=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MllexO/so3qw1Jz6JXvemvB5aU1OPulnG139AHhKT4yfIufb7suYbfX27esmOWC2M
	 K7/bq/niD85+a8jgBWPRyQLw3yNchyVh5Oi1vqWU5UijeAE+5Yo2KSoGLOd4Nj+hAR
	 ezrm9UBsEeUby653mB9O0GO38G3U9fo3sT2Vmr9XhkoNs/JfsEQamXEgISAZ8OtH/z
	 JTOTlhx8IKF1CTA7Uj0IeI/wKRW/xGlfm6Goj5ty3ApWren218+JK/6P9gkfTJRdEn
	 9XN34DWHzey409uKaGlU0w8gYj4Tci9UqqokLRSEIQCVHRlMjXq5PYGBtPih6FT3J3
	 ByqD4+2mWuHiw==
Date: Mon, 21 Sep 2026 00:55:38 +0100
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
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 5/5] iio: imu: inv_icm42607: Add accelerometer
 calibbias support
Message-ID: <20260921005538.41e600b9@jic23-hlaptop>
In-Reply-To: <20260917-b4-inv_icm42370p-v4-5-fd9373f123c9@axis.com>
References: <20260917-b4-inv_icm42370p-v4-0-fd9373f123c9@axis.com>
	<20260917-b4-inv_icm42370p-v4-5-fd9373f123c9@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 17 Sep 2026 15:38:20 +0200
Kanak Shilledar <kanak.shilledar@axis.com> wrote:

> Expose IIO_CHAN_INFO_CALIBBIAS on the accelerometer channels. The
> registers are stored in MREG1. The calibration bias is written to
> OFFSET_USER4 to OFFSET_USER8 registers in MREG1. Reject the out of
> limit calibbias values instead of clamping it.
>=20
> Note: The accelerometer functionality is tested with Invensense,
> ICM42370-P development board.
>=20
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370=
-p
> Datasheet: https://www.lcsc.com/product-detail/C5129967.html
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>

A few comments from me this time.


> +
> +static int inv_icm42607_accel_write_offset(struct iio_dev *indio_dev,
> +					   struct iio_chan_spec const *chan,
> +					   int val, int val2)
> +{
> +	struct inv_icm42607_state *st =3D iio_device_get_drvdata(indio_dev);
> +	struct device *dev =3D regmap_get_device(st->map);
> +	s32 min, max;
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
> +	val64 =3D (s64)val * (s64)MEGA;

Shouldn't need to cast them both I think.

> +	if (val >=3D 0)
> +		val64 +=3D (s64)val2;

These casts are looking excessive.  Check all the other casts
in here.

> +	else
> +		val64 -=3D (s64)val2;
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
> +	val64 =3D val64 * 10000LL;
	val64 *=3D 10000;

should be enough unless I'm missing something.

> +
> +	/* For rounding, add + or - divisor (9806650 * 5) divided by 2 */
> +	if (val64 >=3D 0)
> +		val64 +=3D 9806650 * 5 / 2;
> +	else
