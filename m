Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 338F93F7877;
	Thu, 24 Sep 2026 16:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790268208; cv=none; b=BVXZ+6uAP6y87v4iMoLJpbhMdyqau78ptafhuojCaK+OxrXUXdlT4uib3wbCAVcJanh2wOiwLGQRJ4veDUjqG4pJWZ+4UH2CA3cnhACPh2b3pt9KPkfUV5r+tkXoRIw9zeB6DbOzgX//6ZEz356LnqEjX/jrm+82C5c4llpLya4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790268208; c=relaxed/simple;
	bh=wdfoa2fFD1Ldu2rxTdXlcxcOl1ZtZVdRX+3itKuRkeI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R5T8vXxmHKDXjZj0k3YJWJC8iRIX/8jLHXXOWi1qFxj1xWfZePiq38XLnzVSVnH713ARKkbt6k7RezU3GyPGJ/aU/kk+5jywAaYk+n72yQARUYLZ9Q0pcIOFxENohZ4SJGyfYY3JMBjPYepnWGLzZnIDc52ZCDZSPm7PUkGhTZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fiY9qGl8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fiY9qGl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D91FB1F000FF;
	Thu, 24 Sep 2026 16:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790268207;
	bh=eeOMAfZ7gGE2yjVP9uWGI7wCNSoOiQ6bsy6YThTfOk8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fiY9qGl8dQ1VqZKKOjzg1yEChk436T4Mvo5vuja/CbJ0f/MJ5MbERsE1DC2mqMVL7
	 rE99QVxzvfJEzt0pPBNkEfMJQWONWzfHtD/+oGROsbUEjWEL1bAu0sqpLjKjIE0l7l
	 cqJA7s2H1lGPaARXtW5ZFxbKYZ0mi5Q0+NygDaK926t74YMDsVdT/G4JgqPjiAu50V
	 Ueft42wAh/M1ycBSo5lcVPkaVjqdF8V6vn5fmFpvYMogCM7Rmv3qw0XHWbKtWFuaKA
	 evPyXfZLzOT17tMCb0aQR0R64jmZF7g6YnXfU5N+Zk0rgt/vO9RFwFyEZXq/KiXmkX
	 kSBrKIcgidGSw==
Date: Thu, 24 Sep 2026 17:43:22 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: add: document the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20260924-circling-punk-e75ea71e60b0@spud>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
 <20260924-topic-sm8x50-iio-max34417-adc-v2-1-9a0609e72f5c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kJO3RZKdI1PbxmPX"
Content-Disposition: inline
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-1-9a0609e72f5c@linaro.org>

--kJO3RZKdI1PbxmPX
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 24, 2026 at 03:14:15PM +0200, Neil Armstrong wrote:
> Document the Maxim MAX34417 Four-Channel High Dynamic Range Power
> Accumulator used to monitor power consumption of portable systems.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/iio/adc/maxim,max34417.yaml           | 100 +++++++++++++++=
++++++
>  1 file changed, 100 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yam=
l b/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml
> new file mode 100644
> index 000000000000..058af61cc04e
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml
> @@ -0,0 +1,100 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/adc/maxim,max34417.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Maxim MAX34417 Four-Channel High Dynamic Range Power Accumulator
> +
> +maintainers:
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |
> +  The MAX34417 is a specialized current and voltage monitor used to dete=
rmine
> +  power consumption of portable systems. The device has a very wide dyna=
mic
> +  range (20,000:1) that allows for the accurate measurement of power in =
such
> +  systems. The device is configured and monitored with a standard I2C/SM=
Bus
> +  serial interface. The unidirectional current sensor offers precision
> +  high-side operation with a low full-scale sense voltage.
> +
> +  Specifications about the device can be found at:
> +  https://www.analog.com/media/en/technical-documentation/data-sheets/ma=
x34417.pdf
> +
> +properties:
> +  compatible:
> +    const: maxim,max34417

ADI wants people to use their prefix for newly added devices,
particularly if their release is after the maxim purchase.

> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1

Atypical ordering, usually reg is before these cells props.

> +
> +  vdd-supply: true
> +  vio-supply: true
> +
> +patternProperties:
> +  "^channel@[0-3]$":
> +    $ref: adc.yaml
> +    type: object
> +    description:
> +      Represents the internal channels of the sensor.
> +
> +    properties:
> +      reg:
> +        items:
> +          - minimum: 0
> +            maximum: 3
> +
> +      label: true

This doesn't do anything, when you have unevalatedProperties: false.
If these are the only valid properties, use additionalProperties: false
instead. Otherwise, you can just remove this line.

> +
> +      shunt-resistor-micro-ohms:
> +        description:
> +          Value in micro Ohms of the shunt resistor connected between th=
e RS+ and RS- inputs.
> +        minimum: 1000
> +        maximum: 100000
> +        default: 1000
> +
> +    required:
> +      - reg
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg

Typically in IIO, supplies are made required unless the device can
operate without them.

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
> +        sensor@10 {
> +              compatible =3D "maxim,max34417";
> +              reg =3D <0x10>;
> +
> +              #address-cells =3D <1>;
> +              #size-cells =3D <0>;
> +
> +              channel@0 {
> +                  reg =3D <0>;
> +                  label =3D "ch0";
> +                  shunt-resistor-micro-ohms =3D <5000>;
> +              };
> +
> +              channel@1 {
> +                  reg =3D <1>;
> +                  label =3D "ch1";
> +             };
> +
> +              channel@2 {
> +                  reg =3D <2>;
> +             };
> +        };
> +    };
>=20
> --=20
> 2.34.1
>=20

--kJO3RZKdI1PbxmPX
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarVTKgAKCRB4tDGHoIJi
0juJAQD+gZ7xrihX290uJSi/Goa9Sgv8OFftmneSvBsYIYzKmgEArTFrIH5WBmbD
RBAy2vdynMSVd7ziB1yw6RtJhcSsrwo=
=MH1t
-----END PGP SIGNATURE-----

--kJO3RZKdI1PbxmPX--
