Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794937441;
	b=YUgcgr+sJibw6HgheF/rKifz21il0531sf1kDZ2xJ76fVgppOeRH5hzhcL8CQwBL3V2K
	 vdBM5mdi0ZO8zj45TMeYdvq+DQ0sm8pdMHzObb5EM6ZIzDKimZ5TUb1ilKuHE720cu3wd
	 aCbbmEEV8actJAwcpKU50Wgs1HfjSVbXiQOCYcbS45RmFSfHPWDJHLhsddq0ybbjsSn9X
	 vAD7BE/wNHrKsZ1U5+8pBVOrAorrWI7Bh0KZGbRTaEsF5gGrUHjvYW4xinokA91Cl5qeW
	 wC4X//k91ULgxpoYFoKSCFqSLi5AGsmQ/qyWzbuxbh6dl9ZmsSN14ssD3TysGWAwbrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794937441;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=gZzKeqhqH2hRMxCkRHus6Rx5ByqjKAhbyrHLZlq6rzM=;
	b=f0BlrouW7Q9aZvo+MBIH7A//EyboidDob5OEDVWRdGi04rprrdOdx2YUKfAWhk+tKf3q
	 ygFuE5Id6qBRLNH2gbtR3TQbH1+kn0LZkgimLkVeFDEV0fKhCGBOt/ZAHDst5uS34TnFQ
	 ogtkpnfvdZ8yzrtc92Nb1u2LE+TBpRbsr03wmgjc/b+umpivZEPb4eLPwxt4NCaReW+oo
	 MCCLjd91pYbZfP81iOEV/PMiBsZPT7WcR4q+4z0Ss9+fx4v6WPLRPCH6xJ+Ic0JjcScs1
	 RGoqH/685o/HQqEjBcvErpyxekR5RZ9/z9jqPDEhjp1Vug8ff23XO7+WOyrIeMEQZdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEh9yTUp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58A99606A336;
	Tue, 17 Nov 2026 17:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nEh9yTUp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A0841F000CB;
	Tue, 17 Nov 2026 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794937441;
	bh=gZzKeqhqH2hRMxCkRHus6Rx5ByqjKAhbyrHLZlq6rzM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=nEh9yTUpS9lEM+z4b+s+p2hYWiaLnad5KguJEp6RDH/KSVawUXiwJZ+HR6AuatdoS
	 efFgP889Y+crzOGwlmRHji+VCV+n4mk643EsjbhjpNbFyrof8OxqkQUhzAU+w4Yn4o
	 z0j0WbQwkERWb5CmrkbVD1apYZUBHdXi3chomKj69lAY4QrY7tiNspbkZQK9DduGCt
	 eXyg0qL3e1BqS1t12Fp/XvHfUlXx63yD2od503y06bL7YLCVdwLO+czOMkUwFta7iD
	 7yJVgtGXxB7RhqhDR0LEaTQ9o4CC1oVZXSAfSwbPxcFKrymEfQDwonaYGeyp0/Y+Zt
	 mYSYEyYobPM/Q==
Date: Tue, 17 Nov 2026 17:43:56 +0000
From: Conor Dooley <conor@kernel.org>
To: Joseph Telaak <joseph@telaak.dev>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Peter Rosin <peda@lysator.liu.se>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux@analog.com,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 3/5] dt-bindings: iio: potentiometer: Add Analog Devices
 AD5246
Message-ID: <20261117-object-glutton-d948f8e36ae4@spud>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
 <20261116-iio-ad5246-v1-3-ef6b7c06d4b0@telaak.dev>
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
	protocol="application/pgp-signature"; boundary="BP2Pm9HSuSzzqzlh"
Content-Disposition: inline
In-Reply-To: <20261116-iio-ad5246-v1-3-ef6b7c06d4b0@telaak.dev>

--BP2Pm9HSuSzzqzlh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 16, 2026 at 05:59:52PM -0500, Joseph Telaak wrote:
> The AD5246 is a 128-position digital rheostat on I2C, in 5, 10, 50 and
> 100 kOhm versions. The compatible names the resistance in kOhm, as for
> the AD5272. It uses the same protocol as the MCP4017/18/19, and the
> mcp4018 driver supports it, so list the binding with that driver in
> MAINTAINERS.
>=20
> It gets its own binding rather than a trivial-devices entry so that it
> can describe its supply and be an IIO channel provider
> (#io-channel-cells) for a consumer such as dpot-dac. There is no
> fallback to the MCP4017 compatibles: its resistance step is 1/128 of
> the end-to-end value, not 1/127.

Why is there no fallback between devices? Do the different resistance
values affect the logic? Please note that.

>=20
> Signed-off-by: Joseph Telaak <joseph@telaak.dev>
> ---
>  .../bindings/iio/potentiometer/adi,ad5246.yaml     | 54 ++++++++++++++++=
++++++
>  MAINTAINERS                                        |  1 +
>  2 files changed, 55 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad52=
46.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.ya=
ml
> new file mode 100644
> index 000000000000..a6642746f002
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.yaml

Filename matching a compatible please.

pw-bot: changes-requested

Cheers,
Conor.

> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5246.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Analog Devices AD5246 digital rheostat
> +
> +maintainers:
> +  - Joseph Telaak <joseph@telaak.dev>
> +
> +description: |
> +  128-position digital rheostat with an I2C interface. The compatible
> +  names the end-to-end resistance in kOhm.
> +
> +  Datasheet: https://www.analog.com/en/products/ad5246.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - adi,ad5246-005
> +      - adi,ad5246-010
> +      - adi,ad5246-050
> +      - adi,ad5246-100
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  "#io-channel-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        potentiometer@2e {
> +            compatible =3D "adi,ad5246-010";
> +            reg =3D <0x2e>;
> +            vdd-supply =3D <&reg_3v3>;
> +            #io-channel-cells =3D <0>;
> +        };
> +    };
> +...
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9cb91ee8a56d..81069fdbd778 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -16680,6 +16680,7 @@ MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMET=
ER DRIVERS
>  M:	Peter Rosin <peda@lysator.liu.se>
>  L:	linux-iio@vger.kernel.org
>  S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.yaml
>  F:	drivers/iio/potentiometer/mcp4018.c
>  F:	drivers/iio/potentiometer/mcp4531.c
> =20
>=20
> --=20
> Git-155)
>=20

--BP2Pm9HSuSzzqzlh
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavySXAAKCRB4tDGHoIJi
0s3uAP9hG1Djlf2Z6iAebyFau6YFaTpu3WhrEAh3Qgyo4oplugEAyqaHBLk8tlFy
26QfAnVaPge9ksmYHSLOTvu8xtcB9g8=
=BVRf
-----END PGP SIGNATURE-----

--BP2Pm9HSuSzzqzlh--
