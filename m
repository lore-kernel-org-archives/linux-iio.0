Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14F0830B529;
	Sat, 15 Aug 2026 22:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786832119; cv=none; b=oPsMs4h5EB8s+bavnWPZ8kdlQLG/yWi+/C+xWZKmxEoP+OL9QkR7D2IvfitKC0W9O8wRveW32xbhvxLvgH9GC3Jp1u3uTdFJtsSe7vtP//Guj8WHelwzyP+cbjqxy35Nm8AqOzINdvXqvY5iZQFUEDt3StV1w4jiz+EKIpBJYCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786832119; c=relaxed/simple;
	bh=Ni5cUvVnRzyECvv7n0sjYxZWArVIB4s30bPnMQA3xU0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOz5tZNvrgxXlhqigQ6P4agC8MpW4c0rTZ1reHCJUOF/rQW2gBcqEzPyRtmp1d+eLwQMOmNImm91oITWqfDWtstFrnQ+Q5CPm/BMLWK5lbozNbEjpL7MVanJpgdhND0epo9AOO9OULkEIhALXl3g8MtL0LOdPLPT5ZpK2RwXZ5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NY949yAk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NY949yAk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD1101F00A3A;
	Sat, 15 Aug 2026 22:15:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786832117;
	bh=kqE1afumisvpdiTkCENJzRQ798Rycw+kpbhIZtpVzvA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=NY949yAkMJYcZKqtPZA2Y0FSOaPQ6cHKYKJ5roM02WuCYRAgMVEzvsLuFEdyBbR4G
	 AoFixWMjJPfDN94oEDDiPLH8fmYcP9Rem/6aWTubcXEs+bQe+m1u/avXtq9g/+9+8r
	 5UyVK19VkKn8vX3TEZZNu2ff1oK04JEErxh1Q8HasxPFuCqx1OPK+OOQqU6fIfyJiq
	 2Bi5N96wPyxglrgyd48d5EUuE7Dl1mxVs3ThSYw6kEHitnilkVugR+plCX8ECThc+X
	 VLADgqZcfGWaXa8mhdaAkAwZ1M19IU4amkBVbgqQpncuVks5Hkc6Q75uiFnEi5MmVn
	 i0fukNZudRqLg==
Date: Sat, 15 Aug 2026 23:15:13 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andrei Stancovici <andrei.stancovici@analog.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, <linux@analog.com>,
 <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/3] iio: adc: ltc2497: add LTC2499 internal
 temperature channel
Message-ID: <20260815231513.3a72146a@jic23-huawei>
In-Reply-To: <20260813160139.70000-3-andrei.stancovici@analog.com>
References: <20260813160139.70000-1-andrei.stancovici@analog.com>
	<20260813160139.70000-3-andrei.stancovici@analog.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 13 Aug 2026 19:01:36 +0300
Andrei Stancovici <andrei.stancovici@analog.com> wrote:

> The LTC2499 has an internal PTAT (proportional to absolute temperature)
> sensor that is activated by a second I2C configuration byte (EN2 | IM).
> Expose it as an IIO_TEMP channel providing raw, scale and offset so the
> standard IIO formula
>=20
> 	T[m=C2=B0C] =3D (raw + offset) * scale
>=20
> reconstructs the temperature.
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
>=20
> The scale and offset are derived from the reference voltage returned by
> regulator_get_voltage(); its error is propagated as before, so a board
> that fails to describe vref-supply gets a clear read error instead of a
> silently wrong temperature. No board-specific reference value is assumed
> in the driver.
>=20
> The single temperature channel is appended as the last entry of the
> shared channel array and excluded via num_channels for parts without an
> internal sensor, so the existing LTC2497 channel layout and device name
> are unchanged.
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
>=20
> Send two-byte commands for all conversions on parts that have the sensor
> (has_temp):
>=20
> 	temperature:	EN2 | IM
> 	voltage:	EN2			(IM =3D 0 -> external input)
>=20
> The LTC2497 and LTC2496, which lack the second-byte mechanism, keep using
> the original single-byte channel select and are unchanged.
>=20
> Signed-off-by: Andrei Stancovici <andrei.stancovici@analog.com>
Hi Andrei

A question inline on why this needs a DMA safe buffer given i2c
still bounced everything unless we opt in.

Thanks,

Jonathan

> diff --git a/drivers/iio/adc/ltc2497.c b/drivers/iio/adc/ltc2497.c
> index c1668b5a351e..57a5406977ed 100644
> --- a/drivers/iio/adc/ltc2497.c
> +++ b/drivers/iio/adc/ltc2497.c
> @@ -84,6 +84,40 @@ static int ltc2497_result_and_measure(struct ltc2497co=
re_driverdata *ddata,
>  			return 0;
>  	}
> =20
> +	/*
> +	 * Parts with the internal PTAT sensor (LTC2499) latch their converter
> +	 * configuration via a second command byte and only re-evaluate it when
> +	 * that byte has EN2 set; a single byte, or a second byte with EN2 =3D =
0,
> +	 * means "keep previous". A one-byte channel select therefore cannot pu=
ll
> +	 * the device back out of temperature mode, so a voltage read after a
> +	 * temperature read would keep returning the PTAT result. Always drive =
the
> +	 * second byte with EN2 set on these parts: IM =3D 1 for a temperature =
read,
> +	 * EN2 alone (IM =3D 0) to (re)select an external input. FA =3D FB =3D =
0 keeps
> +	 * the power-on simultaneous 50/60Hz rejection, whose worst-case
> +	 * conversion time the driver's wait already covers.
> +	 *
> +	 * The two bytes are assembled in the DMA-safe st->data buffer rather t=
han
> +	 * on the stack, so the pointer handed to i2c_master_send() stays valid=
 on
> +	 * adapters that DMA the transfer (e.g. with CONFIG_VMAP_STACK).

I'm confused by this (as is sashiko ;)  You aren't using i2c_master_send_dm=
asafe()
so the i2c core will bounce the data anyway.  Generally I2C is too slow to =
care
about copying a few bytes so we tend not to use that infrastructure unless
the copy that would be needed is much bigger.

In the wider set of devices supported, the ltc2496 uses SPI and there
we do need something to ensure we have dma safe buffers.

> +	 */
> +	if (ddata->chip_info->has_temp) {
> +		if (address =3D=3D LTC2497_TEMP_ADDR) {
> +			st->data.d8[0] =3D LTC2497_ENABLE | LTC2497_CONFIG_DEFAULT;
> +			st->data.d8[1] =3D LTC2499_EN2 | LTC2499_IM;
> +		} else {
> +			st->data.d8[0] =3D LTC2497_ENABLE | address;
> +			st->data.d8[1] =3D LTC2499_EN2;
> +		}
> +
> +		ret =3D i2c_master_send(st->client, (char *)st->data.d8, 2);
> +		if (ret < 0) {
> +			dev_err(&st->client->dev, "i2c transfer failed: %pe\n",
> +				ERR_PTR(ret));
> +			return ret;
> +		}
> +		return 0;
> +	}
> +
