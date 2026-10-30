Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793393416;
	b=qinaGOaJN7R+PYH9R+s2oKab2FBBjpVaqBHe0MjgJsU2BiXP3rGCXo+TchojZlcgbTsb
	 TRzUW+KtGG4B4F6s+AIBtypRK4VyzMI47iGO3EsYecrfOy/Zu2KpNjoVukVJMhnakHG2D
	 z8l8VveVS7K7XOPk0xGKm5IHXayL53saKlx/c/0sVNuY1dMzb+moFszT9kRFf58iCMK4u
	 uvejnQUT/xOxtPwCWrt+9WMFPO/wzkILoenN2QDGlDUPVuAngF660NFRg8yTdX/jbT52z
	 P61G/TL5DmMD4ds4ee5ntWQrcYW+CdLdiZ/It71Obujl1hn6KxtqCLXuQH8TMUybT1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793393416;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=8UQfLMqON5p9ekAUB7Y3vPF1E10i6/apVL01RDKA+Kg=;
	b=ipHNgOiFQNX6gFkpZjrdqBP4R0LarARU1VCHx0zRfWPRpDWjcohP+w7sO7nlXho3AZaq
	 EYort17o8rQFFDQtDYGLMQnrESZ+T1vZRKtUx5UJurvuT1xsuNsCuYmpFEfhpOjoRn3FV
	 lRqtkDBqlCjnyEXS54wow7UkX0XIyMIelTok46ZKEkhDYB1svseSDU7vloylNcZq++kpQ
	 WOnc/vRrFWqXIuXHIBqy6oJjFXYlPJXz9CjEopC7wuByLK881Vce7DXmm6meJ0H4rjGTl
	 +09IfLCw9ROgg2jzKVFqBTb7x75AqLqhEQu8AlCDHNNmh+MgYGAfu9ts89Oa1UBwz2Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jawp8oRp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE43606A31C;
	Fri, 30 Oct 2026 20:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jawp8oRp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A71861F0093A;
	Fri, 30 Oct 2026 20:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793393416;
	bh=8UQfLMqON5p9ekAUB7Y3vPF1E10i6/apVL01RDKA+Kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=jawp8oRpq1WL06JzKEhpmxNHNXrWNVgEeMA5zOR6qX9ipJ11xiOaghlRu4h9WT/43
	 dCdjlQ4xGlC9orKn/e5XdNamymg4R2tprNRF4STYwZS55QJkFmbcvSoK6Ihbnyz9yb
	 SmiVIZDnrWN6iO9+T8rAw8XsX5e1bt0j3QsrNYJGwNIy59Nr33vihmaA0JmO3I6GUY
	 ssgJ5A3nxKimbVwfnqzuAudA9IgceKo4PKAwMnVWLBoXVTY6Ddufs3x86rpHSZUeHi
	 z/lOaNItIPqNjD8CwWq8vLtgGLiDkIqdvODe963ciHT7zS02jDjdHQhLrSs3siO4jf
	 ILWTpAb24lqeA==
Date: Fri, 30 Oct 2026 20:50:11 +0000
From: Conor Dooley <conor@kernel.org>
To: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
Cc: sergiu.cuciurean@analog.com, jic23@kernel.org, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, robh@kernel.org,
	krzk+dt@kernel.org, conor+dt@kernel.org, ukleinek@kernel.org,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: iio: adc: add lltc,ltc2387
Message-ID: <20261030-scientist-puzzle-ab2c668b6e27@spud>
References: <20261027-attic-collector-cb4ffdb5cf82@spud>
 <20261030120205.269090-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="1kUioFkg2UPifayy"
Content-Disposition: inline
In-Reply-To: <20261030120205.269090-1-Nicolae-daniel.Deaconescu@analog.com>

--1kUioFkg2UPifayy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 30, 2026 at 02:02:05PM +0200, Nicolae-Daniel Deaconescu wrote:
> On Tue, Oct 27, 2026 at 18:28:34 +0000, Conor Dooley wrote:
> > Why are we getting new devices with linear vendor prefixes?
>=20
> I'll fix this in v2. The binding file will be adi,ltc2387.yaml.
> The -x4 compatibles will also be dropped, because they described
> four devices sharing one AXI ADC.

Please retain more context than this, it's not enough to just have what
you're replying to. I see so many patches that I will have completely
forgotten what you're doing by the time I get to the next day.

> > Hmm, ltc2387-16 does not appear to have these signals?
> > Well, it has "cnv" but "cnv" has "sample clock" as the input name so is
> > the clocks property above and pwm-clock can be used if the provider is a
> > pwm?
>=20
> The LTC2387-16 datasheet has these pins: CNV+/CNV- (pins 27/28), which
> is the conversion-start input; CLK+/CLK- (pins 23/24), which is an

Ahh, I see that now. The symbolic diagram on page one confused me and I
didn't look much further.

> externally applied clock that shifts out the result; and DCO+/DCO-,
> the echoed clock. There is no clk_gate pin.

Then there should not be a clk_gate pwm for this device.

> The part needs a burst of 8 CLK pulses per conversion in one-lane mode
> (4 in two-lane), starting t_FIRSTCLK =3D 65 ns after CNV and ending
> within t_LASTCLK =3D 49 ns of the next CNV. So the CLK input cannot run
> freely: the clk_gate PWM gates the host clock into that burst. That is
> why the clock needs a PWM and not a plain pwm-clock, which would give
> a continuous clock. The clocks property is the reference clock the PWM
> generator runs from, and the driver needs its rate to compute the
> waveforms.

Then you've got a "layering" violation of some kind here. If this clock
is consumed by the PWM generator, it should be an input to the pwm
generator not this adc.

The second pwm should then just be called "clk", because that's the
input(s) that it represents.

I want to see what the dts you have for a complete setup of this device
looks like, including the backend and pwm generator.

>=20
> > Please explain how this is not determinable from the compatible.
>=20
> TWOLANES is a digital input on the chip. High selects two-lane output,
> two bits per clock on DA and DB; low selects one-lane output. Both
> modes exist on every part, and the pin is set by how the board is
> wired, so the compatible does not say which mode is used.
> v2 will contain more detail in the description.
>=20
> Thanks,
> Daniel

--1kUioFkg2UPifayy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCauUDAwAKCRB4tDGHoIJi
0tQoAP4izLcxISMIO9hhxqgUNHToGy/iMA8wqihVLgj2tQ+KFgEAqbqokbXFRrNP
n5wXUsHpOWS1rTi4qsuPBHNsU0LWCA0=
=NVgP
-----END PGP SIGNATURE-----

--1kUioFkg2UPifayy--
