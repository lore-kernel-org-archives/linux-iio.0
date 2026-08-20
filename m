Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DCE38D402;
	Thu, 20 Aug 2026 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787249621; cv=none; b=N4XflxnFfio1hV4cakI5NacKw/M1WYMV1yb3coqiytuB4arK1tfOrD2ha4RE9VFI2lPb4PnkZqWIMzx+NIgDtFLlaBCmt5EYhkhIxXs3zEzR/ljJr6v0aXKE+bJSiFk3j7JKFHLq59zY2+O2odX0e0sIldY2X36ShVJFRFEHRJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787249621; c=relaxed/simple;
	bh=ILAlAk/fQng0Ui/pz1uS2DHdyds9RPVGbNZbF2/IuUo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bugpHyS/11vb8xEPORTEQWYbAILzppIAqg2A+smZkkVjMsrY9DP637+3vcW4Dw3fahBCDokA3/UnoR84RyIQ1+q0g4aTTgjR7e09zJIRlV9mtlisLaVvqmdMi3fi6e2/03aZ7Wc9dMJRQymyBOTMA/25gw6gYLFR+zc6dCorJ64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZIkjggBi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZIkjggBi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1E311F000E9;
	Thu, 20 Aug 2026 18:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787249619;
	bh=2AUCdM/qgP+/RZltQocOTsJDjsXqlcQ7EGSaSr0M1vY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZIkjggBi4v1q+gWSHr7v4xwRltPAOsIuA6rgScDJZqB5T2pnIfRcHTbYJ0EzAGCgo
	 ARLSYlejfUaiy5GIGXNFICFoq+SVlwL6vQZdQVrEsIaE8MumNcEKfhDSFY9ElBt2Hq
	 2Jd8WmZSc2rQ0zOeRITV5jFW3pz+D9gjcP/FqIKpE/hITK41RBDRgnR4yrON0btzA9
	 mpBev9OW6J4kO57/I5fvl5MQQy26Q15KLbGb8BKpV+Bpqm5pJ/fNCryyJL9MyQAnJ7
	 7zMCMEMNqXcnvdcsgZ0U473u2975zCu+ahyLwGDNl7FKPTbFd20VA2hCv8Ls9jtkDb
	 vStuf5xgKhjUg==
Date: Thu, 20 Aug 2026 19:13:35 +0100
From: Conor Dooley <conor@kernel.org>
To: Louis Adamian <adamianlouis@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/5] dt-bindings: iio: pressure: Add MS5637
Message-ID: <20260820-affection-opacity-7f6531562b88@spud>
References: <20260820141224.23730-1-adamianlouis@gmail.com>
 <20260820141224.23730-4-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="mH9foQAtx56LUlHg"
Content-Disposition: inline
In-Reply-To: <20260820141224.23730-4-adamianlouis@gmail.com>

--mH9foQAtx56LUlHg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 20, 2026 at 10:12:18AM -0400, Louis Adamian wrote:
> Create meas,ms5637 devicetree binding and move existing devices from
> trivial-devices.yaml. Explicit compatible strings are added for the
> different sub-variants because each requires different constants for the
> second-order temperature compensation formulas. Previously, the driver
> exposed the generic compatibles for the ms5637, MS5803, MS5805
> and MS5837 families and applied the MS5637-02BA compensation to all of
> them. To preserve the DT ABI the existing compatibles are retained and
> mapped to the -02BA variant of each family (ms5637-02ba, ms5803-02ba,
> ms5837-02ba).
>=20
> Signed-off-by: Louis Adamian <adamianlouis@gmail.com>

Firstly, please CC everyone on all the mails - or at least all the dt
maintainers on all mails, so we don't have to go look at the context on
lore.

Additionally, lore didn't even get your cover letter:
https://lore.kernel.org/all/20260820141224.23730-1-adamianlouis@gmail.com/

The patch itself seems okay. You could probably have made the
ms5637-02ba fall back to the ms5637, but that's more a matter of taste I
think than a technical thing.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

Thanks,
Conor.

> ---
>  .../bindings/iio/pressure/meas,ms5637.yaml    | 93 +++++++++++++++++++
>  .../devicetree/bindings/trivial-devices.yaml  | 10 --
>  2 files changed, 93 insertions(+), 10 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,m=
s5637.yaml
>=20
> diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.y=
aml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
> new file mode 100644
> index 000000000000..befd81d1907b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
> @@ -0,0 +1,93 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/pressure/meas,ms5637.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +title: Measurement Specialties ms5637 and similar pressure sensors
> +
> +maintainers:
> +  - Louis Adamian <adamianlouis@gmail.com>
> +
> +description:
> +  Measurement Specialties pressure and temperature sensors. The MS5803
> +  family supports both I2C and SPI interfaces. All other variants are I2=
C only.
> +
> +properties:
> +  compatible:
> +    oneOf:
> +      - enum:
> +          - meas,ms5637-02ba
> +          - meas,ms5637-30ba
> +          - meas,ms5803-01ba
> +          - meas,ms5803-02ba
> +          - meas,ms5803-05ba
> +          - meas,ms5803-14ba
> +          - meas,ms5803-30ba
> +          - meas,ms5805
> +          - meas,ms5837-02ba
> +          - meas,ms5837-30ba
> +          - meas,ms8607-temppressure
> +      # These generic compatible strings do not identify the sub-variant=
s of
> +      # the part. They are retained so that existing device trees contin=
ue
> +      # to bind, and each is treated as the -02BA variant of its family.
> +      - enum:
> +          - meas,ms5637
> +          - meas,ms5803
> +          - meas,ms5837
> +        deprecated: true
> +
> +  reg:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description: Regulator that provides power to the sensor
> +
> +required:
> +  - compatible
> +  - reg
> +  - vdd-supply
> +
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            enum:
> +              - meas,ms5803
> +              - meas,ms5803-01ba
> +              - meas,ms5803-02ba
> +              - meas,ms5803-05ba
> +              - meas,ms5803-14ba
> +              - meas,ms5803-30ba
> +    then:
> +      $ref: /schemas/spi/spi-peripheral-props.yaml#
> +      properties:
> +        spi-max-frequency:
> +          maximum: 20000000
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pressure@76 {
> +            compatible =3D "meas,ms5637-02ba";
> +            reg =3D <0x76>;
> +            vdd-supply =3D <&vcc_3v3>;
> +        };
> +    };
> +  - |
> +    spi {
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        pressure@0 {
> +            compatible =3D "meas,ms5803-14ba";
> +            reg =3D <0>;
> +            vdd-supply =3D <&vcc_3v3>;
> +            spi-max-frequency =3D <20000000>;
> +        };
> +    };
> diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Doc=
umentation/devicetree/bindings/trivial-devices.yaml
> index 435c4baab436..2671040e8802 100644
> --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> @@ -240,18 +240,8 @@ properties:
>            - meas,htu21
>              # Measurement Specialities I2C temperature and humidity sens=
or
>            - meas,htu31
> -            # Measurement Specialities I2C pressure and temperature sens=
or
> -          - meas,ms5637
> -            # Measurement Specialities I2C pressure and temperature sens=
or
> -          - meas,ms5803
> -            # Measurement Specialities I2C pressure and temperature sens=
or
> -          - meas,ms5805
> -            # Measurement Specialities I2C pressure and temperature sens=
or
> -          - meas,ms5837
>              # Measurement Specialities temp and humidity part of ms8607 =
device
>            - meas,ms8607-humidity
> -            # Measurement Specialities temp and pressure part of ms8607 =
device
> -          - meas,ms8607-temppressure
>              # Measurement Specialties temperature sensor
>            - meas,tsys01
>              # MEMSIC magnetometer
> --=20
> 2.55.0
>=20

--mH9foQAtx56LUlHg
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaodDzwAKCRB4tDGHoIJi
0vGSAQCMCkYvN8Witjjv2FF1iKVX1LBegECqHTH0lemOoU6IHQD/VFWCxfhor4Py
sR9nUIrTZaBhXBmJV9LDJoct/pw1fQQ=
=den8
-----END PGP SIGNATURE-----

--mH9foQAtx56LUlHg--
