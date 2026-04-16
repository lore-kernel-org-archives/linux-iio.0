Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4EB33346A8;
	Thu, 16 Apr 2026 15:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776352564; cv=none; b=I0i20bSrgeFYUtyeRKkDA7bVhdP9Y8FbNuNOZxtGr1ultz1+gzyjjvyYn5do6vf3G0NTwbPckqXk3XVAFZIxYbxz2CcEWGX9AQHnrS9ojddt/+g3arFtVIniAZUYrHlZDJcFlM5NBMUJsj/1LBsmaSow/UT569fONo7P0VFxJtE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776352564; c=relaxed/simple;
	bh=l6bkkSP7Cmuntn0/tS/mtGEL2aXlh377Zwdwnpd9BdE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rVzdX6OHn9yeOF+bhiO4EVtx8XpJt6BVdE0dpW++UPlxIZZu8+v7uCUz4dDHXfv21Oli6ywZ6f/OccJgqcAzp/oTtT9rsVwhF9SKoaq0UqhA+AD+Wu8v8hXgSLoPMTwGOt5aUSsHAiBvNkh+qu8KQfowdwbqc91QEJxFxgxMtb4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D+jR5nKe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D+jR5nKe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC40DC2BCB3;
	Thu, 16 Apr 2026 15:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776352564;
	bh=l6bkkSP7Cmuntn0/tS/mtGEL2aXlh377Zwdwnpd9BdE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=D+jR5nKeynY2aEyqnc6T5ILVfh1jl10pceofGTAJcAzW01jV9lG7uN7nhD0DQIVDb
	 6k4z/TZ2wGTlmAWi57GlVb7Bet0wnraauU6ahNGWJ5+6KZWNmHaKyOzrdCY65e2HBc
	 G/hvdt1PhIwal753iipUzIYaYqprT2l+/dSIgSbS9so+LGTfpAs4PJOD1XJrbm+4m7
	 D0WznRIpBHl/NC9GECVnJI/ePiZ9kXO+zoV1F72Q2XMdoERowD2wKSK/z8g3V/ZVxh
	 WKzQK0KQhtPRj9lrB9/eofXdWiQgoQ7ZdIwPihFO6tW1CN7icWHMzn/dHFEAtvFogl
	 qA2d8/YLGbd8w==
Date: Thu, 16 Apr 2026 16:15:59 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: iio: dac: mcp47feb02: Fix binding issues
Message-ID: <20260416-primate-robust-c9de03e50946@spud>
References: <20260416-mcp47feb02-fix5-v1-1-9656c2fed6d2@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JQ4o0TT4kWMfmrhu"
Content-Disposition: inline
In-Reply-To: <20260416-mcp47feb02-fix5-v1-1-9656c2fed6d2@microchip.com>


--JQ4o0TT4kWMfmrhu
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hey,

On Thu, Apr 16, 2026 at 04:33:36PM +0300, Ariana Lazar wrote:
> Change maxItems value from 8 to 1 for the channel number reg property.
> Change example reg value from 0 to 0x60.
> Fix a few typos in property descriptions.
> Sort the part numbers in the enum list lexicographically.

Hmm, this looks like 3 or 4 patches to me. The maxItems change probably
qualifies for a fixes tag, none of the rest do.

>=20
> Fixes: 4ba12d304175 ("dt-bindings: iio: dac: adding support for Microchip=
 MCP47FEB02")

> Reported-by: Conor Dooley <conor@kernel.org>
> Closes: https://lore.kernel.org/all/20260403-speed-childless-1360de358229=
@spud/

I didn't report anything, I just commented on something that you had
already "reported" when you fixed it yourself.

> Reported-by: David Lechner <dlechner@baylibre.com>
> Closes: https://lore.kernel.org/all/dd0dbadb-604b-4f12-8674-268b7db096fd@=
baylibre.com/

David didn't report anything either, he just gave you review feedback on
the change you made to the example.

> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
>  .../bindings/iio/dac/microchip,mcp47feb02.yaml     | 57 +++++++++++-----=
------
>  1 file changed, 28 insertions(+), 29 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb=
02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.ya=
ml
> index d2466aa6bda2106a8b695347a0edf38462294d03..88a1495f2967a3d821ada7e7e=
9a7fbb466401040 100644
> --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -61,29 +61,29 @@ properties:
>    compatible:
>      enum:
>        - microchip,mcp47feb01
> -      - microchip,mcp47feb11
> -      - microchip,mcp47feb21
>        - microchip,mcp47feb02
> +      - microchip,mcp47feb04
> +      - microchip,mcp47feb08
> +      - microchip,mcp47feb11
>        - microchip,mcp47feb12
> +      - microchip,mcp47feb14
> +      - microchip,mcp47feb18
> +      - microchip,mcp47feb21
>        - microchip,mcp47feb22
> +      - microchip,mcp47feb24
> +      - microchip,mcp47feb28
>        - microchip,mcp47fvb01
> -      - microchip,mcp47fvb11
> -      - microchip,mcp47fvb21
>        - microchip,mcp47fvb02
> -      - microchip,mcp47fvb12
> -      - microchip,mcp47fvb22
>        - microchip,mcp47fvb04
> -      - microchip,mcp47fvb14
> -      - microchip,mcp47fvb24
>        - microchip,mcp47fvb08
> +      - microchip,mcp47fvb11
> +      - microchip,mcp47fvb12
> +      - microchip,mcp47fvb14
>        - microchip,mcp47fvb18
> +      - microchip,mcp47fvb21
> +      - microchip,mcp47fvb22
> +      - microchip,mcp47fvb24
>        - microchip,mcp47fvb28
> -      - microchip,mcp47feb04
> -      - microchip,mcp47feb14
> -      - microchip,mcp47feb24
> -      - microchip,mcp47feb08
> -      - microchip,mcp47feb18
> -      - microchip,mcp47feb28
> =20
>    reg:
>      maxItems: 1
> @@ -111,13 +111,13 @@ properties:
>          - for single-channel device: Vout0;
>          - for dual-channel device: Vout0, Vout1;
>          - for quad-channel device: Vout0, Vout2;
> -        - for octal-channel device: Vout0, Vout2, Vout6, Vout8;
> +        - for octal-channel device: Vout0, Vout2, Vout4, Vout6;
> =20
>    vref1-supply:
>      description: |
>        Vref1 pin may be used as a voltage reference when this supply is s=
pecified.
>        The internal reference will be taken into account for voltage refe=
rence
> -      beside VDD if this supply does not exist.
> +      besides VDD if this supply does not exist.

ngl, I don't think this is a typo, the sentence doesn't make sense
either before or after the change. Should this be something like "The
internal reference and VDD will be used as the voltage reference if this
supply does not exist?

> =20
>        This supply will be voltage reference for the following outputs:
>          - for quad-channel device: Vout1, Vout3;
> @@ -141,7 +141,7 @@ properties:
>      description:
>        Enable buffering of the external Vref/Vref0 pin in cases where the
>        external reference voltage does not have sufficient current capabi=
lity in
> -      order not to drop it=E2=80=99s voltage when connected to the inter=
nal resistor
> +      order not to drop its voltage when connected to the internal resis=
tor
>        ladder circuit.
> =20
>    microchip,vref1-buffered:
> @@ -149,7 +149,7 @@ properties:
>      description:
>        Enable buffering of the external Vref1 pin in cases where the exte=
rnal
>        reference voltage does not have sufficient current capability in o=
rder not
> -      to drop it=E2=80=99s voltage when connected to the internal resist=
or ladder
> +      to drop its voltage when connected to the internal resistor ladder
>        circuit.
> =20
>  patternProperties:
> @@ -161,8 +161,7 @@ patternProperties:
>      properties:
>        reg:
>          description: The channel number.
> -        minItems: 1
> -        maxItems: 8
> +        maxItems: 1
> =20
>        label:
>          description: Unique name to identify which channel this is.
> @@ -227,12 +226,12 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - microchip,mcp47fvb04
> -              - microchip,mcp47fvb14
> -              - microchip,mcp47fvb24
>                - microchip,mcp47feb04
>                - microchip,mcp47feb14
>                - microchip,mcp47feb24
> +              - microchip,mcp47fvb04
> +              - microchip,mcp47fvb14
> +              - microchip,mcp47fvb24
>      then:
>        patternProperties:
>          "^channel@[0-3]$":
> @@ -245,12 +244,12 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - microchip,mcp47fvb08
> -              - microchip,mcp47fvb18
> -              - microchip,mcp47fvb28
>                - microchip,mcp47feb08
>                - microchip,mcp47feb18
>                - microchip,mcp47feb28
> +              - microchip,mcp47fvb08
> +              - microchip,mcp47fvb18
> +              - microchip,mcp47fvb28
>      then:
>        patternProperties:
>          "^channel@[0-7]$":
> @@ -280,9 +279,9 @@ examples:
> =20
>          #address-cells =3D <1>;
>          #size-cells =3D <0>;
> -        dac@0 {
> +        dac@60 {
>            compatible =3D "microchip,mcp47feb02";
> -          reg =3D <0>;
> +          reg =3D <0x60>;
>            vdd-supply =3D <&vdac_vdd>;
>            vref-supply =3D <&vref_reg>;
> =20
> @@ -297,6 +296,6 @@ examples:
>              reg =3D <0x1>;
>              label =3D "Adjustable_voltage_ch1";
>            };
> -      };
> +        };
>      };

This whitespace change looks odd. You've aligned the opening and closing
braces, but the indent is not consistent as there's mixed 4- and 2-space
indentation used in this example. I think you need to do:
diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02=
=2Eyaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.ya=
ml
index d2466aa6bda21..a36874c4ae276 100644
--- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
@@ -278,25 +278,25 @@ examples:
   - |
     i2c {
=20
+      #address-cells =3D <1>;
+      #size-cells =3D <0>;
+      dac@0 {
+        compatible =3D "microchip,mcp47feb02";
+        reg =3D <0>;
+        vdd-supply =3D <&vdac_vdd>;
+        vref-supply =3D <&vref_reg>;
+
         #address-cells =3D <1>;
         #size-cells =3D <0>;
-        dac@0 {
-          compatible =3D "microchip,mcp47feb02";
+        channel@0 {
           reg =3D <0>;
-          vdd-supply =3D <&vdac_vdd>;
-          vref-supply =3D <&vref_reg>;
+          label =3D "Adjustable_voltage_ch0";
+        };
=20
-          #address-cells =3D <1>;
-          #size-cells =3D <0>;
-          channel@0 {
-            reg =3D <0>;
-            label =3D "Adjustable_voltage_ch0";
-          };
-
-          channel@1 {
-            reg =3D <0x1>;
-            label =3D "Adjustable_voltage_ch1";
-          };
+        channel@1 {
+          reg =3D <0x1>;
+          label =3D "Adjustable_voltage_ch1";
+        };
       };
     };
 ...

Cheers,
Conor.

>  ...
>=20
> ---
> base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
> change-id: 20260416-mcp47feb02-fix5-26994c5b428c
>=20
> Best regards,
> --=20
> Ariana Lazar <ariana.lazar@microchip.com>
>=20

--JQ4o0TT4kWMfmrhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeD9LwAKCRB4tDGHoIJi
0gFcAP9TedHY+84n7m1trbDiJ7xC2ULT4pkNyU53avTjzYo1EQD/T0yjOB9fivEM
H0SAkgv5TL4VytP9I5cQsZjb7rhv9ws=
=QboO
-----END PGP SIGNATURE-----

--JQ4o0TT4kWMfmrhu--
