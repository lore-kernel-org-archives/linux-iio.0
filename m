Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F23373F23C0;
	Sun, 18 Oct 2026 18:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792349437; cv=none; b=Jd7byMCWSh/7XYI7PKQCKd5SspqLe1/RctVSDg0Hczd8RvGU4cLA1PipAL2HAO76PW6rWIoFmhh8vUwM16Si/I83l7DRZ+euGOsEHxaur1Zp4Hss6pdYyvd6ABPESbMUB/cFUJuQPtix3RV3SbDIEBKY9PJ6EE6BwMMclGPhlPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792349437; c=relaxed/simple;
	bh=ujufb1hsN+idDb+vBcB3cB6Jxmd7uHUq8KKZNzTcgc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N3jmyuWHan1nfaH0Y26l4ACJGMpaQDA7gYL6/KfcdHfyVz40am7jQ+f9Fbi74+HihabYdbdVKIonOsfs900fagWNBFYklVqERfc1xLZ3aw7EjICngtwi3okCOrQx7vScjcBEbmKRqqwq8htyYn4LSUcbKKB+43B2QYift4YG9Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZHEI+AC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZHEI+AC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD2B91F000C4;
	Sun, 18 Oct 2026 18:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792349436;
	bh=RMwpf0KMhGlsmAsma1velbB+PsLjkn1Z8ybJYZMeYUo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nZHEI+ACoaQ1CoG7DYretXyau9ldDUaNwf9AvT8S/+O6GrHSSahpvqSRzLG6eYDYT
	 IXvU0/qf/1NakNt1XnIiw0ivgCIvwIMoyVpCjYBB2+thB7luJTDmaomq7TA7bwyT16
	 Pzhd4EsqMckE7zianpkD8fcjfHswtgO6DqI3Sz7wLgHbISIgT5JZS/lclhHbAl0J5s
	 ZuBWgiTvydWn4gfri9wmv44VEkUK1anBc/MtP/x+b1RHfddxrV7gF0K5dPzf8tCICY
	 IaK247G8YcK2LQIodU0FE0L0Z17rRwbXOMkqth9TAub5TUout6ynDTfSXSIDTRz9m9
	 4+9RrVHoZEToA==
Date: Sun, 18 Oct 2026 19:50:31 +0100
From: Conor Dooley <conor@kernel.org>
To: Christoph Rudorff <chris@rudorff.com>
Cc: Linus Walleij <linusw@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
	linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: light: gp2ap002: add vled
Message-ID: <20261018-giggly-reminder-4404507f3f23@spud>
References: <20261017-iio-light-gp2ap002-v2-0-d6879767a446@rudorff.com>
 <20261017-iio-light-gp2ap002-v2-1-d6879767a446@rudorff.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+Mn879I/TmKW1p6b"
Content-Disposition: inline
In-Reply-To: <20261017-iio-light-gp2ap002-v2-1-d6879767a446@rudorff.com>

--+Mn879I/TmKW1p6b
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 07:27:41PM +0200, Christoph Rudorff wrote:
> According to datasheet page 8 "Recommended external circuit",
> it can have tree supplies: vio, vdd and vled. As vdd and vled wants the
> same voltage, they may be connected to a single supply.
>=20
> Signed-off-by: Christoph Rudorff <chris@rudorff.com>

Valid comments from Jonathan here,
pw-bot: changes-requested

Thanks,
COnor.

> ---
>  Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.y=
aml b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> index 99bddf31cbed..f5b2c6a4d7e3 100644
> --- a/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> +++ b/Documentation/devicetree/bindings/iio/light/sharp,gp2ap002.yaml
> @@ -33,6 +33,10 @@ properties:
>    vio-supply:
>      description: VIO power supply a phandle to a regulator
> =20
> +  vled-supply:
> +    description: LED power supply a phandle to a regulator
> +      Optional. It may already be connected to VDD.
> +
>    io-channels:
>      maxItems: 1
>      description: ALSOUT ADC channel to read the ambient light
>=20
> --=20
> 2.39.5
>=20

--+Mn879I/TmKW1p6b
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCatUU8gAKCRB4tDGHoIJi
0ublAQDq52TunNmV5wm29HeKs/ujJmoXxHkPditf6vJE+X+6xgEAoWmSd8+sREvm
zoS7VRUp+0o9gvF5GqtidQdz3M0TxQk=
=hIke
-----END PGP SIGNATURE-----

--+Mn879I/TmKW1p6b--
