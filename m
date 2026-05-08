Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3700C2F8EA7;
	Fri,  8 May 2026 15:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778252801; cv=none; b=ekCDmRFDE3KFOzEmVJNRAbbVaTKdZxIsTsUBPoEb4qN0d6C9Lf4rut+0DkgkhNsTvCOQMud89WXra9JXGiNjLo1vDlxsgGDehsVNGl2aG9+gAkpjftL1JCvJIXwWr0bjhXElGtvS9baoGma4wKHNzOYeMGMIXQXWIWyocvtt6No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778252801; c=relaxed/simple;
	bh=wQDajVEQ6wfWEfjC1ABAbqLCIKdBeZ74w76HpmmH/yo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fdn6O0SEZx01LLfPYaYSVVMy7snjWC2BKSeGtqahMvPXkmIr54cyW3RtKkaVUYfHx0gAum+uWR2e5skkx68pwIRo94S3cC/IgerUEqLj0iFrDNP+rVtE5B+xgNwWSB6YiXkRL9SqVq4dXKmYCzItXgs57AiTIQp84C1+I7DQB2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTwSBoW9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTwSBoW9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD618C2BCB0;
	Fri,  8 May 2026 15:06:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778252800;
	bh=wQDajVEQ6wfWEfjC1ABAbqLCIKdBeZ74w76HpmmH/yo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZTwSBoW9XG+ukfQfLvfzoaLaoaSG2mEv3AN5IPm3EPPWX/JxLvIYWaWzQl9sC78wM
	 rZBJRSS95UJPkIF42IDxIrfeedOw94e67caML5dnS1zr7dhK3VN7PfTufaNpG5v7zY
	 jfv0c0two9toGPFKJiN2uR42wgQ4aAhIetZhJoWqTHS240V3C3z7A8eCCficKubIv7
	 cdOwYWPqQaqylut1bq27csYBZWBogXgW7bEshCZyX9iIUR55QFcFtUPhdY+fRlzbfg
	 zYtTq/b4RxfRS6YiK1q3SBtn82jtmyJdGQtnGF3g4dg5emuu7GD7w+ZHeIUbBjEZPu
	 /OQ8C0fcOKVdA==
Date: Fri, 8 May 2026 16:06:36 +0100
From: Conor Dooley <conor@kernel.org>
To: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
Cc: jic23@kernel.org, dlechner@baylibre.com, nuno.sa@analog.com,
	andy@kernel.org, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: magnetometer: add MEMSIC
 MMC5983MA
Message-ID: <20260508-kitchen-decimal-654cc0b98c26@spud>
References: <20260507205033.951990-1-vlad.kulikov.c@gmail.com>
 <20260507205033.951990-2-vlad.kulikov.c@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KWve6slpxHppLGEe"
Content-Disposition: inline
In-Reply-To: <20260507205033.951990-2-vlad.kulikov.c@gmail.com>


--KWve6slpxHppLGEe
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, May 07, 2026 at 08:50:31PM +0000, Vladislav Kulikov wrote:
> Add a Devicetree binding for the MEMSIC MMC5983MA 3-axis
> magnetometer.
>=20
> MMC5983MA is not register-compatible with the existing MEMSIC
> magnetometer drivers. It has a different register map, 18-bit output
> data format, and I2C/SPI transport support.
>=20
> Signed-off-by: Vladislav Kulikov <vlad.kulikov.c@gmail.com>
> ---

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

>  .../iio/magnetometer/memsic,mmc5983.yaml      | 65 +++++++++++++++++++
>  MAINTAINERS                                   |  6 ++
>  2 files changed, 71 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/me=
msic,mmc5983.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mm=
c5983.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5=
983.yaml
> new file mode 100644
> index 000000000000..e144b4d9b0ca
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.y=
aml
> @@ -0,0 +1,65 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5983.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: MEMSIC MMC5983MA 3-axis magnetic sensor
> +
> +maintainers:
> +  - Vladislav Kulikov <vlad.kulikov.c@gmail.com>
> +
> +properties:
> +  compatible:
> +    const: memsic,mmc5983
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +  vddio-supply:
> +    description: Regulator that provides power to the digital interface =
and INT pin
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - $ref: /schemas/spi/spi-peripheral-props.yaml#
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    // Example for I2C
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        magnetometer@30 {
> +            compatible =3D "memsic,mmc5983";
> +            reg =3D <0x30>;
> +            vdd-supply =3D <&vdd_3v3_reg>;
> +            vddio-supply =3D <&vdd_3v3_reg>;
> +        };
> +    };
> +  - |
> +    // Example for SPI
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        magnetometer@0 {
> +            compatible =3D "memsic,mmc5983";
> +            reg =3D <0>;
> +            spi-max-frequency =3D <10000000>;
> +            vdd-supply =3D <&vdd_3v3_reg>;
> +            vddio-supply =3D <&vdd_3v3_reg>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 882214b0e7db..952fbf3020a4 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -17170,6 +17170,12 @@ F:	drivers/mtd/
>  F:	include/linux/mtd/
>  F:	include/uapi/mtd/
> =20
> +MEMSIC MMC5983 MAGNETOMETER DRIVER
> +M:	Vladislav Kulikov <vlad.kulikov.c@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5983.yaml
> +
>  MEN A21 WATCHDOG DRIVER
>  M:	Johannes Thumshirn <morbidrsa@gmail.com>
>  L:	linux-watchdog@vger.kernel.org
> --=20
> 2.43.0
>=20

--KWve6slpxHppLGEe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaf37/AAKCRB4tDGHoIJi
0spqAP4lF2HiLvMhxLm6BeOHoc3pfanCK7ACpyFEvBR1gLKIYwEAxjH4UzMa1Lgr
0Ym9eddO5aosB+FxGj2RRYEY+JgmZgA=
=r1ie
-----END PGP SIGNATURE-----

--KWve6slpxHppLGEe--
