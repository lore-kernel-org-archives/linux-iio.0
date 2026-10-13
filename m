Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 410265208A0;
	Tue, 13 Oct 2026 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791908888; cv=none; b=nfVUvdOq3vmL6m9lUw5bpsqNCPOB0bY98IAWrHzoJy8FWYDGhqXvE3fC6bCQv1jepSyuvhuqDeYyjffoyLkqOc7FSekOqIFo2ZA7S2YPlS86lPYY10FhADnmYnfnIlPd04CivgInIncFTvzQGMXSZ8u+/dyQ+GoQYVaOQLxwuto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791908888; c=relaxed/simple;
	bh=ry1zMcfYwKFFs/NdI1mzS9damOmuJGURuz21CLKVnsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WJGfFX7YeMgJ14wf9r4DVa2yT8vXe2/rk+bESGYnfDupgwDTzVK8Zdh4amIfS7MXIEduhlPiLQajOc7ZkmmmWuObOwI0ixcJn8/stLxRIfE9Jb9qy8LJDwVMQco81lfN+ANBO9JH5HTjM+sCsZpWuoHurytjFeDUzpUEtAzFItE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lHnqvybe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lHnqvybe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88B901F000FF;
	Tue, 13 Oct 2026 16:28:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791908886;
	bh=4qECQLBZag2Z6hnsQn+EA+w/xPg1/6d82FsVEqu9mG4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=lHnqvybeUm68HtG0je9hHehQZb1iLVcY8LX/J9SX3k+HW+8U8w430Fcs7sX4q06bW
	 AfmKm8zZmQFVMGq4CpZ282GvKj9wkQe8RLCEbjtvI2npp4qlvVR9Po3ckajrny29Z5
	 bFrrz9zQVWF3c6SNKuFoV84wATd5LW9+aXaVz1im4uhPx9uJzyzd6CsheXWNjofVLc
	 MG2ZQ5lB5IOU8Wg4aprhq8foSZTy3GMG56EntshrsBoY8vSAGQ+WU51/Fghd6jVgIR
	 DBvpEvu7dKYH2dHFtYBaWbJDz/BC/2QMbLll2jyGn33eXBXpw+T7yQqxz2MmBbnwOt
	 TnfjHgPBeYlZQ==
Date: Tue, 13 Oct 2026 17:28:02 +0100
From: Conor Dooley <conor@kernel.org>
To: Neil Armstrong <neil.armstrong@linaro.org>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org
Subject: Re: [PATCH v3 1/3] dt-bindings: iio: add: document the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Message-ID: <20261013-subtract-oblong-cc6cd3d9cee2@spud>
References: <20261013-topic-sm8x50-iio-max34417-adc-v3-0-d3604ae4a229@linaro.org>
 <20261013-topic-sm8x50-iio-max34417-adc-v3-1-d3604ae4a229@linaro.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="olTPtcV1frKmgnZT"
Content-Disposition: inline
In-Reply-To: <20261013-topic-sm8x50-iio-max34417-adc-v3-1-d3604ae4a229@linaro.org>

--olTPtcV1frKmgnZT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 13, 2026 at 04:07:11PM +0200, Neil Armstrong wrote:
> Document the Maxim MAX34417 Four-Channel High Dynamic Range Power
> Accumulator used to monitor power consumption of portable systems.
>=20
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

Previous review still applies?
https://lore.kernel.org/all/20260924-circling-punk-e75ea71e60b0@spud/

pw-bot: changes-requested

Thanks,
Conor.

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
> +
> +  "#address-cells":
> +    const: 1
> +
> +  "#size-cells":
> +    const: 0
> +
> +  reg:
> +    maxItems: 1
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

--olTPtcV1frKmgnZT
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCas5cEgAKCRB4tDGHoIJi
0jYtAQDG/Kdajpu4lXNcTYJNmvR0ro/5maQnxMwQuxIRbf88EQD/Uq+r1EcahyWw
CUFXkn1dVvJ/uVGHOLSwm4kEvAchUww=
=iQGf
-----END PGP SIGNATURE-----

--olTPtcV1frKmgnZT--
