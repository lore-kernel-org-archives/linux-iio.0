Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923E13955C6;
	Tue, 29 Sep 2026 19:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790710163; cv=none; b=XyOdzrMnSow1OsUeu62r82IjmpXRQb9JmzL61uAGq8g3KoOPz8I6uzKhbizn+7/1Ua6qKKMttKI+f+GukqksHwtitGcSHlO7p5xzouCkdyjtmU/3/t4xBd4BvoSyd64K+RW7wljwSW3huXJXv5/9j1Hdko7ExverFrJ6wC6V89s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790710163; c=relaxed/simple;
	bh=bYKlQJL8BbKjM9cR+yVfNtQdWsmLrVz34kECEfdXCKM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jQ2NbA3nH9PL+AZHquDSjMzn5eo57PMBMaJWFxDtjNXTdZ2xTEIioathELg1qoHF9Tn8nwOLsMu4z1lt5jAnC80s/jHgw68pxns0jeKRbhJk2TqBbLG9NPIUoFO3JHyg2vZIFtqWagboLoEr1gSagg79kthyMjjDvZ+7pgC9288=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fkXmv38u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fkXmv38u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14C771F000FF;
	Tue, 29 Sep 2026 19:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790710162;
	bh=zFeIx1YWIhw9HoxDMmB/id+d+114GqebHjnPRMzX0Bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fkXmv38uL/DfHJwsGwkTlrxonIOT2GdZMuavxsXBmH/6wILmmz37ixjylixdGUPcg
	 c0FMuHHdtmzDmnu1L8nYQUuooS/C/JLtaYm+V1EfJ0oHF+KfhyRpuw/BEuDTKpeIdC
	 wwC8PohdUxTUZLTtPfgU9nTzqcUJg7XLTKYZ3qemQADDvM8e+Cq+zlwh2k0RRQxTlJ
	 acAy9THqmXz/kq5bqBlVVGZszOABqegylOgVLbnhTeHIr27Ue0zGv6QVs0NPyc3NAB
	 Z8zcyYOQxw4vUDD717t5CA5HxVeo4l1zjfC0aR26qAdFN5LAxK2IR2P+0i4H48SGV+
	 E5gNmQmXRjd2w==
Date: Tue, 29 Sep 2026 20:29:17 +0100
From: Conor Dooley <conor@kernel.org>
To: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, dlechner@baylibre.com,
	nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 1/2] dt-bindings: iio: pressure: add Sensirion SDP31
Message-ID: <20260929-decompose-skinless-6133ddff9e67@spud>
References: <20260928215422.3720-1-m.abubakar365@yahoo.com>
 <20260928215422.3720-2-m.abubakar365@yahoo.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="cCHyIRYFvmMYQQ4j"
Content-Disposition: inline
In-Reply-To: <20260928215422.3720-2-m.abubakar365@yahoo.com>

--cCHyIRYFvmMYQQ4j
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 29, 2026 at 02:54:21AM +0500, Muhammad Abu Bakar wrote:
> Add device tree bindings for the Sensirion SDP3x family of differential
> pressure sensors (SDP31, SDP32 and SDP33), I2C devices that also report
> temperature.
>=20
> Signed-off-by: Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> ---
>  .../iio/pressure/sensirion,sdp31.yaml         | 48 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 53 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/sensir=
ion,sdp31.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp=
31.yaml b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.ya=
ml
> new file mode 100644
> index 000000000..b9d3c6441
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> @@ -0,0 +1,48 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/sensirion,sdp31.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sensirion SDP31, SDP32 and SDP33 differential pressure sensors
> +
> +maintainers:
> +  - Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +
> +description: |
> +  Differential pressure sensors from Sensirion with an I2C interface.
> +  The SDP31, SDP32 and SDP33 differ only in their measurement range.
> +
> +properties:
> +  compatible:
> +    enum:
> +      - sensirion,sdp31
> +      - sensirion,sdp32
> +      - sensirion,sdp33

Given a skim of the driver, it does not seem like the difference in
measurement range affects the programming model? In that case, you
should probably pick sdp31 as a fallback compatible for the other
devices.

Otherwise, looks fine to me.
pw-bot: changes-requested

> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply: true
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
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +      pressure@21 {
> +        compatible =3D "sensirion,sdp31";
> +        reg =3D <0x21>;
> +        vdd-supply =3D <&vdd_3v3>;
> +      };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 214aeee76..e285147be 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24855,6 +24855,11 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/chemical/sensirion,scd4x.yaml
>  F:	drivers/iio/chemical/scd4x.c
> =20
> +SENSIRION SDP31 DIFFERENTIAL PRESSURE SENSOR DRIVER
> +M:	Muhammad Abu Bakar <m.abubakar365@yahoo.com>
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/pressure/sensirion,sdp31.yaml
> +
>  SENSIRION SDP500 DIFFERENTIAL PRESSURE SENSOR DRIVER
>  M:	Petar Stoykov <petar.stoykov@prodrive-technologies.com>
>  S:	Maintained
> --=20
> 2.43.0
>=20

--cCHyIRYFvmMYQQ4j
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCarwRjQAKCRB4tDGHoIJi
0twqAQCn2SQWz5kAytZDWAGrACXaePEQa98BZzyBzUamw/SboQD/WnpkfT8rsm2N
d+OpD09JLgRBjCO0iACx6wbq1mEDTQw=
=fONC
-----END PGP SIGNATURE-----

--cCHyIRYFvmMYQQ4j--
