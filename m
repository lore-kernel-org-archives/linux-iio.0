Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479653FC5BC;
	Tue, 19 May 2026 17:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779211824; cv=none; b=bsfpCDEG2YFsKzZnt3cPh2chDxcEoBc21g5RrOTwU90+Fyhe5dwkZ2CiH3/oWnWmv9JyCLVCp9WFWIB656Fgbbo+P9lKj79kqdoFxIaXqSPCXJy/JGP6J7yvlRJ0lRvvz+/DxBB2nVgasSWip/Z8tFNPjCQzM2zm1brrVJUcS50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779211824; c=relaxed/simple;
	bh=1Hngtuvji026UtpbR4cijfhOjd1RM/qoNXf0Ci2GrEY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JMA6HMKP+fvyUwirQectg56/oabFOXD03WjepQoXTzoXbH5cXCTdDY7npKPv78D1C134AnGs6kKQf12B5xwmI1wCT5Z3dUFVHeVczAqPxfzcoL6E5Y/C/6w6obsYnVo1knalCiCo5lcbLhHu6WFYLIRH51+rT8fLqLitVujyOOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oXhVRCRE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oXhVRCRE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 963A0C2BCB3;
	Tue, 19 May 2026 17:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779211823;
	bh=1Hngtuvji026UtpbR4cijfhOjd1RM/qoNXf0Ci2GrEY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=oXhVRCREENOMw1BIcEkB5pc5hNtkTVZafssr0z56Trvat89vdWdAxos2vAFQuv53d
	 Y81JzakPlVp6D9ZyWRJtWHg/26rNeQLUktgNH41GkNd7LFKuEWouIlT7Iyr7EWnNPi
	 jAuJHE4mEchxbnySl52gvoIRdNGlr7na5UBv5YVRh9ARlDOM51IU2hikoGH4pGWbvw
	 wU08x9nbTjz2ZoUWo8Tr6YwwALdj+vzXlIwVXi5EAnX43YU45mDcWUr3/NqT4OLhSD
	 DGMGFM/r1bFvtL8Enp2EOUGy0N0bKO4GOTgjp3ffWLGZSTnb724UAszFW/c7ijFA4d
	 J+gdeb91yHmnQ==
Date: Tue, 19 May 2026 18:30:20 +0100
From: Conor Dooley <conor@kernel.org>
To: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	devicetree@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: iio: light: add Broadcom APDS9999
Message-ID: <20260519-overdrawn-cofounder-59752aa87d4f@spud>
References: <cover.1779181370.git.azpijr@gmail.com>
 <12b145839a1a9c5381946a9e5237bfe6fe0ae9a7.1779181370.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="fo0hn6NU+KpHuZ5l"
Content-Disposition: inline
In-Reply-To: <12b145839a1a9c5381946a9e5237bfe6fe0ae9a7.1779181370.git.azpijr@gmail.com>


--fo0hn6NU+KpHuZ5l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 19, 2026 at 11:23:13AM +0200, Jose A. Perez de Azpillaga wrote:
> Add Device Tree binding for the Broadcom APDS9999 ambient light
> and proximity sensor. A separate binding file is used rather
> than merging with avago,apds9300.yaml because the APDS9999
> has an additional vled-supply for the VCSEL.
>=20
> The APDS9999 features individual R, G, B, and IR channels with
> a green channel that uses optical coating to approximate the
> human eye spectral response for ALS/lux measurements. Calibrated
> RGB color sensing is not yet implemented in the driver.
>=20
> Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
> ---
>  .../bindings/iio/light/brcm,apds9999.yaml     | 54 +++++++++++++++++++
>  MAINTAINERS                                   |  6 +++
>  2 files changed, 60 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds=
9999.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9999.ya=
ml b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> new file mode 100644
> index 000000000000..4d9e9aff8894
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> @@ -0,0 +1,54 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/brcm,apds9999.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +title: Broadcom APDS-9999 Digital Proximity and RGB Sensor
> +
> +maintainers:
> +  - Jose A. Perez de Azpillaga <azpijr@gmail.com>
> +
> +description: |
> +  Broadcom APDS-9999 is a digital proximity and RGB sensor with
> +  ambient light sensing (ALS) capability. The device uses individual
> +  R, G, B, and IR channels plus a Vertical Cavity Surface Emitting
> +  Laser (VCSEL) for proximity detection.
> +
> +  Datasheet: https://docs.broadcom.com/docs/APDS-9999-DS
> +
> +properties:
> +  compatible:
> +    enum:
> +      - brcm,apds9999
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply: true
> +
> +  vled-supply:
> +    description: VCSEL power supply

Why does the name in the description disagree with the name in the
property? If the pin is called vcsel, please call the property that.

Cheers,
Conor.

> +
> +  interrupts:
> +    maxItems: 1
> +
> +additionalProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        light-sensor@52 {
> +            compatible =3D "brcm,apds9999";
> +            reg =3D <0x52>;
> +            vdd-supply =3D <&vdd_reg>;
> +            vled-supply =3D <&vled_reg>;
> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1aa9c989973f..2d8d4e2eab6e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -5000,6 +5000,12 @@ S:	Maintained
>  F:	Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
>  F:	drivers/iio/light/apds9160.c
>=20
> +BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
> +M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
> +L:	linux-iio@vger.kernel.org
> +S:	Maintained
> +F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
> +
>  BROADCOM ASP 2.0 ETHERNET DRIVER
>  M:	Justin Chen <justin.chen@broadcom.com>
>  M:	Florian Fainelli <florian.fainelli@broadcom.com>
>=20
>=20

pw-bot: changes-requested

--fo0hn6NU+KpHuZ5l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCagyeLAAKCRB4tDGHoIJi
0kTuAP4iStldexlbRq5hLYN5WNkTQCwerz5uV4LUwZC6MbKouAD9HGRPWcFQTESc
FNHYGs8Ah85UaO0SbxHTLZICJjecCQ8=
=eWJU
-----END PGP SIGNATURE-----

--fo0hn6NU+KpHuZ5l--
