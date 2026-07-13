Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5683B32E143;
	Mon, 13 Jul 2026 16:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783958802; cv=none; b=o5iqWDz1yL1xSIomi9sxVlfw4Zj8koJ7BOwwMAogaLcN6j6eUaJzbkg6fTu4L2hQO0TIk4O3wFVPcHUFLIrbsa6e80I53CggD+kYPtMy8N3rqArXNx4ssqetx0+wv2p1ZawHBBR9ADQXCBrwPicF+0gjt0Th36nMGvsv7+TSndU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783958802; c=relaxed/simple;
	bh=dzQkBHjL/FtR8QllNPe8o9U8TczNI5iO5kaT4lxjkfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tctbs/e+LHbuILNbT20+9ATYyl71lwKnjAMtm+8+GYDiiFoSaXQS6t1edCrkhHsTNNVbqMMeUslFs+ibjEqlBqr50wrN2SeC/2Tkc1S2Gb/JrBh49vO37IneVgEFF8RvhWJAxtkpQF6oeBYBSnvOl+NdAHnUUDt8QWC1aPMSJT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XjSmcapF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XjSmcapF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4796A1F000E9;
	Mon, 13 Jul 2026 16:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783958794;
	bh=6b/b0iCQ8u0d/xirpr5FlphcFcR2Fxw7lno3LhHQoZM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=XjSmcapFRwjs/tLpAgncYLYQQrQxUZjQXEdQdxoCSU9zsZrx8Ca7imc7zGbGLa8++
	 o4BC+RHNmsv596OuZJtyeXyep+jNFCx6v2VqsvKlE/XN1DryZTXYJRnAN6qjIZknhu
	 GgUHB6sEEINVQjrWNhd7Nsa0VwyN6YK70Yajs7PYYQ54ZFr3X7JYmBB/XjhhwCDyal
	 +Zk58h3qt7GxxotwQBaoaboFaQO4N/0mbplBLfZaPyOVBKHm54nco1U3Xkb4IxXN23
	 dPMiKcKwcRY+QuFVzxnWf5dOzA8g2Jqy+6kO2M7ab37WWm3o5eAnATbhvAsIpyFzBN
	 MqoIAR1KYRgxg==
Date: Mon, 13 Jul 2026 17:06:29 +0100
From: Conor Dooley <conor@kernel.org>
To: Stefan Popa <stefan.popa@analog.com>
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	David Lechner <dlechner@baylibre.com>, Nuno Sa <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Siratul Islam <siratul.islam@linux.dev>,
	Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>,
	Ciprian Hegbeli <ciprian.hegbeli@analog.com>,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: adc: add maxim,max40080
Message-ID: <20260713-pelican-crevice-208c7f86c3df@spud>
References: <20260703102941.1141341-1-stefan.popa@analog.com>
 <20260713120226.90303-1-stefan.popa@analog.com>
 <20260713120226.90303-2-stefan.popa@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="YFFJB9i+AcD1BeiK"
Content-Disposition: inline
In-Reply-To: <20260713120226.90303-2-stefan.popa@analog.com>

--YFFJB9i+AcD1BeiK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 13, 2026 at 03:02:25PM +0300, Stefan Popa wrote:
> Add device tree bindings for the Maxim MAX40080 bidirectional
> current-sense amplifier with a 12-bit ADC and an I2C/SMBus interface.
>=20
> Signed-off-by: Stefan Popa <stefan.popa@analog.com>
> ---
>  .../bindings/iio/adc/maxim,max40080.yaml      | 62 +++++++++++++++++++
>  1 file changed, 62 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/adc/maxim,max40=
080.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yam=
l b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> new file mode 100644
> index 0000000000000..8a57075a7d273
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max40080.yaml
> @@ -0,0 +1,62 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max40080.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX40080 bidirectional current-sense amplifier
> +
> +maintainers:
> +  - Ciprian Hegbeli <ciprian.hegbeli@analog.com>
> +  - Stefan Popa <stefan.popa@analog.com>
> +
> +description: |
> +  The MAX40080 is a high-precision, bidirectional current-sense amplifie=
r with
> +  an integrated 12-bit ADC and an I2C/SMBus interface. It measures the v=
oltage
> +  across an external shunt resistor and the input bus voltage, and store=
s the
> +  results in an internal FIFO.
> +
> +  Datasheet:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
MAX40080.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max40080
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Power supply for the device.
> +
> +  interrupts:
> +    maxItems: 1
> +    description: ALERT output for overcurrent/undervoltage threshold eve=
nts.
> +
> +  "#io-channel-cells":
> +    const: 1
> +
> +  shunt-resistor-micro-ohms:
> +    description:
> +      Value of the current-sense shunt resistor connected between the IN=
+ and
> +      IN- inputs. Used to scale the reported current.
> +
> +required:
> +  - compatible
> +  - reg

The supply should be made required.
pw-bot: changes-requested

Otherwise, this seems okay.

Cheers,
Conor.

> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        adc@20 {
> +            compatible =3D "maxim,max40080";
> +            reg =3D <0x20>;
> +            #io-channel-cells =3D <1>;
> +            shunt-resistor-micro-ohms =3D <100000>;
> +        };
> +    };
> --=20
> 2.53.0
>=20

--YFFJB9i+AcD1BeiK
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCalUNBQAKCRB4tDGHoIJi
0jvGAP4oQIUY1Iw86jOmkAwE/f5oYtbvVRvlbJvNWFLkI0r6cQEA6z3iuGeRYRY6
yYFS7MCb8Ab7ZLUwfj7roZEVrcpN1Q8=
=ROTY
-----END PGP SIGNATURE-----

--YFFJB9i+AcD1BeiK--
