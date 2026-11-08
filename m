Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794178981;
	b=RveM6g0n40I9Ezhb61C9V+KeuyHG8yUvWnjgccG3IIjyDKvAwMrwm0YJRkSiYPqzpQqs
	 J1X0My1frksx4MdMebTCMxxs6SovS2rlW1Nl/rwjHJSx1+y52JIrzxdafrNc3V+xkfQDe
	 Ec3BlE4ORLuR418SCZf/ogobqKIE1jUDPN8xdDxiAaqMQ2tbQDTxHfa84ct1kQH7SC5YW
	 BB/l9B0qIED2kw1NmeQ8Wj9jl6gFTFLC0y5zHs5ijQ3ibuz57Z2Q+0Zj6/I+2ft2e0dYG
	 epwH+Tpy623f7AuqfyjRIynLhHMQ1dcHXsieXeD41a75Sr0CuDcRye2mnxrtCyhTCbA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794178981;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:In-Reply-To;
	bh=7lRipA1U3Vpr3W1XgShy4/lSpEPy2KcuVCNI6tVZLPM=;
	b=EfhO4yALfmyQaW7pnJMGkX/iBgtyME9gDJHkipC7EcDtU5tVOB3Aacft0MgeUa/fvpnX
	 bjcLeILmEo2KxeGGcVMPcR2v9E7iomzhrGbvq7PIapHCjNU1I6iIElNdN4URv91LidmbB
	 qfq7jBYXgzcGX/+qA/ylokhAF8opf7B3vH7q4n6us3n3POgMskO4AivH7al9Lqf3PKfGS
	 oXIRQ2C1zU6xGCYhIsKEZFcGy0mLVXrxI8RuZs6i43IZ0clC4HLIEcew87+j9Gst1fPob
	 AjlQm6Z60GOjdmncTCG58hclmoeQM/ZjHWJ+ZvK/gi7lEggM/Oyc8kYBn0mQBJZIxiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KW4avC1O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC660606A31C;
	Sun,  8 Nov 2026 23:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KW4avC1O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAA871F0089F;
	Sun,  8 Nov 2026 23:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794178980;
	bh=7lRipA1U3Vpr3W1XgShy4/lSpEPy2KcuVCNI6tVZLPM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KW4avC1Oy7f9fYLC0CwIcCL61e9F/iM0JHkURcTzMGWEJuQpl94GKC9AsuSMi3LJ8
	 b2M98SuhcyUyS43870lM9KPtzQQpx3r1EUSN+DoG/SkrrRw9TeX6WFIeyxrZqJcyFB
	 lOUopIOie5P3vneIvOiBvfTkZLdRDWuFrwxRxl2UuSjJ7nBnCcaQkoZmWnOfJqBe7U
	 my1C7FtW/TAKIv5ZOZz/mWG/cAAlZveYdgNhzveoFKENVRTANjAHkhzavNVbG4nvvE
	 CkGVOgV2N5vEsEWKAjVTi5Y2kgIONf0bFMMps460v6/aE7n3gU2eGhxshhp7rEer+Q
	 ArlOEEJ/y9xzg==
Date: Sun, 8 Nov 2026 23:02:55 +0000
From: Conor Dooley <conor@kernel.org>
To: admin@tsv-stahl-riesa.de
Cc: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Kevin Tsai <ktsai@capellamicro.com>,
	Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: light: Add Capella CM3217
Message-ID: <20261108-diploma-profound-df9901bb55f6@spud>
References: <20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de>
 <20261106-upstream-iio-cm3217-v2-1-d97adde9171c@tsv-stahl-riesa.de>
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
	protocol="application/pgp-signature"; boundary="iTafg9FVNCC4/vZk"
Content-Disposition: inline
In-Reply-To: <20261106-upstream-iio-cm3217-v2-1-d97adde9171c@tsv-stahl-riesa.de>

--iTafg9FVNCC4/vZk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 06, 2026 at 09:56:29PM +0100, Patrick Fischer via B4 Relay wrot=
e:
> From: Patrick Fischer <admin@tsv-stahl-riesa.de>
>=20
> The Capella CM3217 is an ambient light sensor with an I2C interface but
> without registers and without an interrupt line. It always answers on
> the two addresses 0x10 and 0x11. The node describes the first address;
> the second one is fixed.
>=20
> The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
> Tablet.
>=20
> Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
> ---
>  .../bindings/iio/light/capella,cm3217.yaml         | 51 ++++++++++++++++=
++++++
>  1 file changed, 51 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.y=
aml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> new file mode 100644
> index 000000000000..7f2a0d5d0243
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/iio/light/capella,cm3217.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Capella CM3217 ambient light sensor
> +
> +maintainers:
> +  - Patrick Fischer <admin@tsv-stahl-riesa.de>
> +
> +description:
> +  The CM3217 is an I2C ambient light sensor without registers or interru=
pt
> +  line.
> +
> +properties:
> +  compatible:
> +    const: capella,cm3217
> +
> +  reg:
> +    description:
> +      The sensor always occupies the two fixed I2C addresses 0x10 and 0x=
11.
> +      Writing a byte to 0x10 sets command byte 1 (shutdown and IT_T), re=
ading
> +      a byte from it returns the high byte of the light count. Writing a=
 byte
> +      to 0x11 sets command byte 2 (FD_IT), reading a byte from it return=
s the
> +      low byte. Only the first address is given here, the second one is
> +      implied.
> +    const: 0x10

I think this should actually contain both addresses, the i2c-controller
binding permits children with "one or many i2c target addresses".


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
> +        #address-cells =3D <1>;
> +        #size-cells =3D <0>;
> +
> +        light-sensor@10 {
> +            compatible =3D "capella,cm3217";
> +            reg =3D <0x10>;
> +            vdd-supply =3D <&vdd_2v85_sen>;
> +        };
> +    };
> +...
>=20
> --=20
> 2.56.0
>=20
>=20

--iTafg9FVNCC4/vZk
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCavD/nwAKCRB4tDGHoIJi
0t57AQDK4maf/RAmwAOplIx96ejSTOlAFhIoFS2LwLIGDZZTyAEAhEcFFs0JdsKK
EZsNHK083RmofibAX2Ik7eUBl8PGdgU=
=6wfh
-----END PGP SIGNATURE-----

--iTafg9FVNCC4/vZk--
