Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B40E1714AA;
	Mon,  7 Sep 2026 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743381; cv=none; b=abqrvLA68uzXbkU2zbus/iJc82+3DXzwX8xuovexmZbYme7mTg/HnTvkeEcmHQmGSb77INPfDdJoGibSM6OGe0G3azvxe1kPUtsT5LQGsb/mRhD7Z1M23O1PgCt0TIypx0hAT8NNJ9FaKNIsenHdqUMRcNB4vnoSEUkwWW4Ty9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743381; c=relaxed/simple;
	bh=iIpTN5b2N0XssK38X2TJy0NEhqrp8MgahtzizDZap20=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HaazzqjgtL+Yvmn4weT8E/rZAaEvBwuxMVRGR+uZWZcd/WTGO3UlbAnVisu1Fme6YJRswPMPtVNc5DCA6O0AswHe8u0eKIjlEbVgNsPprrRNOGlcWopnnR2tF+mlCYkPEEdbHkGYVaRtRbZ6yGgud7mH7o+2vaZWqkKyr1a0I2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ck/apwF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ck/apwF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A34921F00A3A;
	Mon,  7 Sep 2026 01:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788743379;
	bh=IPdLxEuyKna0csuR7jWKlIWbFwDNpYGlS2AZgesPbUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=ck/apwF6iq+LeVuhRZUdWUwxg96pITSAoHjnbwpTAtgxJi7hMCletZjOnNNTYHpp8
	 ui9UFF2JRj9zlcHl12ZUEhcb4kGdKLu5s3kStS4IfRn9zg5kXKnuEMbmfSE7T5EW3+
	 kK5HZUCFvcS1mEptj2wgbgTr33zD8J8e18EpTwn1SkZJWE5lgRmXjhjPKFnGxGxdSz
	 lf8WS1yyQuWopbDPLAoWKxeOsVTtX/YhtoVVBIAZObWeV6oFSIagExg5yvw5Bcy7En
	 hRWeSfLlC29rg1cuVyb1TScvzODzbpZ3on5B/064FnxSTSyseo8k9a2yrfN6zejDUF
	 jgUJvSHz2pIWg==
Date: Mon, 7 Sep 2026 02:09:32 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/3] iio: adc: ltc2497: add LTC2499 internal
 temperature channel
Message-ID: <20260907020810.3ff1713c@jic23-huawei>
In-Reply-To: <20260902064415.132588-3-andrei.stancovici@analog.com>
References: <20260902064415.132588-1-andrei.stancovici@analog.com>
	<20260902064415.132588-3-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 2 Sep 2026 09:44:11 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> The LTC2499 has an internal PTAT (proportional to absolute temperature)
> sensor that is activated by a second I2C configuration byte (EN2 | IM).
> Expose it as an IIO_TEMP channel providing raw, scale and offset so the
> standard IIO formula
>=20
> 	T[m=C2=B0C] =3D (raw + offset) * scale
>=20
> reconstructs the temperature.

Andy raised the point about too much description on the next patch and
it definitely applies here as well. Think about what matters to those
reading the patch. E.g. something like.

"The LTC2499 includes a temperatures sensor. Expose the raw reading and
appropriate scale and offset."


>=20
> The PTAT sensor yields the absolute temperature as
>=20
> 	T(K) =3D DATAOUT24 * Vref / 1570		(Vref in volts)
>=20
> The raw value exported here is sign-extended and normalised to
> 2^(resolution + 1) =3D=3D 2^25, i.e. raw =3D 2 * DATAOUT24, so on the IIO
> milli-degree-Celsius convention
>=20
> 	scale[m=C2=B0C/LSB] =3D Vref_uV / 3140000
> 	offset         =3D -273150 * 3140000 / Vref_uV

If this stuff belongs anywhere it is as comments where the maths is
in the code. You have it it there, no point in repeating here.

>=20
> The scale and offset are derived from the reference voltage returned by
> regulator_get_voltage(); its error is propagated as before, so a board
> that fails to describe vref-supply gets a clear read error instead of a
> silently wrong temperature. No board-specific reference value is assumed
> in the driver.
This bit is useful but focus on what matters a little more. Something like
"As scale and offset depend on the reference voltage, if no regulator
 is specified by firmware, reading them will return an error."
I'd talk about why as well. e.g. "As this is a new feature simply failing
probe is not a option."
>=20
> The single temperature channel is appended as the last entry of the
> shared channel array and excluded via num_channels for parts without an
> internal sensor, so the existing LTC2497 channel layout and device name
> are unchanged.

Implementation detail this description shouldn't mention.

>=20
> The LTC2499 latches its converter configuration from the second command
> byte and only re-evaluates it when that byte has EN2 set. EN2 | IM
> selects the internal temperature sensor. Because a single-byte command,
> or a second byte with EN2 =3D 0, means "keep previous", a one-byte channel
> select cannot pull the device back out of temperature mode: after a
> temperature read every subsequent voltage read would keep returning the
> PTAT result instead of the selected input. Temperature support is
> therefore only correct if the voltage path also emits a second command
> byte that re-selects an external input.

What does this mean to the user? =20

>=20
> Send two-byte commands for all conversions on parts that have the sensor
> (has_temp):
>=20
> 	temperature:	EN2 | IM
> 	voltage:	EN2			(IM =3D 0 -> external input)
>=20
> The LTC2497 and LTC2496, which lack the second-byte mechanism, keep using
> the original single-byte channel select and are unchanged.

I'd not bother talking about what happens for those that are unaffected
(given it is the obvious answer of nothing!)

>=20
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
> ---
>  drivers/iio/adc/ltc2497-core.c | 58 +++++++++++++++++++++++++++++++---
>  drivers/iio/adc/ltc2497.c      | 33 +++++++++++++++++++
>  drivers/iio/adc/ltc2497.h      | 12 +++++++
>  3 files changed, 99 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ltc2497-core.c b/drivers/iio/adc/ltc2497-cor=
e.c
> index 2dc5c7044269..6df9c72bd8cf 100644
> --- a/drivers/iio/adc/ltc2497-core.c
> +++ b/drivers/iio/adc/ltc2497-core.c
> @@ -9,9 +9,11 @@

...

> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index c1668b5a351e..79c87bac05e1 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -84,6 +84,38 @@ static int ltc2497_result_and_measure(struct ltc2497co=
re_driverdata *ddata,
>  			return 0;
>  	}
> =20
> +	/*
> +	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
> +	 * configuration via a second command byte and only re-evaluate it when
> +	 * that byte has EN2 set; a single byte, or a second byte with EN2 =3D =
0,
> +	 * means "keep previous".  A one-byte channel select therefore cannot p=
ull
> +	 * the device back out of temperature mode, so a voltage read after a
> +	 * temperature read would keep returning the PTAT result.  Always drive=
 the
> +	 * second byte with EN2 set on these parts: IM =3D 1 for a temperature =
read,
> +	 * EN2 alone (IM =3D 0) to (re)select an external input.  FA =3D FB =3D=
 0 keeps
> +	 * the power-on simultaneous 50/60Hz rejection, whose worst-case
> +	 * conversion time the driver's wait already covers.

Say why it is 'always' done.  Seems you could do it only when the configura=
tion
needs to change.  Thus if someone keeps reading a particular channel don't =
send
the second byte?  Fine to just say it is for simplicity.

> +	 */
> +	if (ddata->chip_info->has_temp) {
> +		u8 cmd[2];
> +
> +		if (address =3D=3D LTC2497_TEMP_ADDR) {
> +			cmd[0] =3D LTC2497_ENABLE | LTC2497_CONFIG_DEFAULT;
> +			cmd[1] =3D LTC2499_EN2 | LTC2499_IM;
> +		} else {
> +			cmd[0] =3D LTC2497_ENABLE | address;
> +			cmd[1] =3D LTC2499_EN2;
> +		}
> +
> +		ret =3D i2c_master_send(st->client, cmd, sizeof(cmd));
> +		if (ret < 0) {
> +			dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
> +				ERR_PTR(ret));
> +			return ret;
> +		}
> +		return 0;
> +	}
> +


