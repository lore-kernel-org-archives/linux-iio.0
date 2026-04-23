Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64E642AA6;
	Thu, 23 Apr 2026 17:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776965566; cv=none; b=Xv8VJ1f5Oyk1yTLmoVQA6IfqQYsf01zJ1vEn6WmrvY1DxceEENPqS00Q2SKzqP9xnR+yfWzl+LCcDwfnoYyEWHsPs5mzXa/eoteZg9oi9fz2hpmzSeWNMQfACD6Tfeeiry0taH72yKJoj97Y6lcGvCPjrKlMceqiP7DPeMIQNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776965566; c=relaxed/simple;
	bh=vkPOFYfSPifxKhUNTdyucTn5zfeEOsAW2W7a4O0DrdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RtAzuqUtPpZaQj7jkkkjVjQISUSnaEKP7GOeLOIjhdtoPT3WspjGDjsBlsbOLrOB9b/vR2FzdfuvdRrK9CPFSGaGU1PTsPdvSOzWH9NNDVCqDYqnROCunS6Wn/1rL5txpc3ugGTEXQebLwMC4O1+L5mht5UHI4Yc1Wea/eG6beo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3TXmBV2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3TXmBV2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E22AC2BCAF;
	Thu, 23 Apr 2026 17:32:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776965566;
	bh=vkPOFYfSPifxKhUNTdyucTn5zfeEOsAW2W7a4O0DrdU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3TXmBV2HXKD1XIf+dWiJDo7nYZa6ycLviyKIziJO2BxrR8s2SG9OYlzfaKmaUZ+m
	 sfP7kVAuPX/iloUkq7xDG7JXkcht5XbcxyeFI+dKxNzCVRVla1F7s7fqvvDDl+jKvO
	 3UaNIMQh0xyqlH6eGiDRTi/7Pmozru7bj1JLW6HoRKszwfjMHvPSZMtp03bdZhoWQV
	 Ic0s25DPadINY4CBDMHg2nyrOqm74+5I0/P0SRqndNKzxqA/92xmjV2lom4QL6L5qf
	 L368nCP1uTMeW833YKLFUEXVqEB/R2+Db3vTDgs7NSmRF+cwzuFkxvH3fVtC/V1304
	 KySfK7t1XTbDA==
Date: Thu, 23 Apr 2026 18:32:40 +0100
From: Conor Dooley <conor@kernel.org>
To: rodrigo.alencar@analog.com
Cc: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	Michael Auchter <michael.auchter@ni.com>,
	linux-hardening@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Subject: Re: [PATCH 06/22] dt-bindings: iio: dac: ad5686: rework on power
 supplies
Message-ID: <20260423-revenue-sensation-c62f759e457a@spud>
References: <20260422-ad5313r-iio-support-v1-0-ed7dca001d1b@analog.com>
 <20260422-ad5313r-iio-support-v1-6-ed7dca001d1b@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="0YNEvVT2+/MPyOSF"
Content-Disposition: inline
In-Reply-To: <20260422-ad5313r-iio-support-v1-6-ed7dca001d1b@analog.com>


--0YNEvVT2+/MPyOSF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 03:45:40PM +0100, Rodrigo Alencar via B4 Relay wrot=
e:
> From: Rodrigo Alencar <rodrigo.alencar@analog.com>
>=20
> Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
> property is deprecated. Certain devices require vref-supply to be

Why is it deprecated? Is the naming incorrect?

> available once an internal reference voltage is absent. Still, this patch
> does not add those as 'required' so that the ABI is not broken.
>=20
> Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
> ---
>  .../devicetree/bindings/iio/dac/adi,ad5686.yaml      | 20 ++++++++++++++=
++++--
>  1 file changed, 18 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml b/=
Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> index 543ee181f7b3..3292d5190b70 100644
> --- a/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5686.yaml
> @@ -40,8 +40,22 @@ properties:
>    reg:
>      maxItems: 1
> =20
> +  vdd-supply:
> +    description: Input power supply.
> +
> +  vlogic-supply:
> +    description:
> +      Digital power supply. If not supplied, it is assumed to be the sam=
e as
> +      vdd-supply. VLOGIC may be hardwired to VDD in some board designs or
> +      internally connected in small packages.
> +
> +  vref-supply:
> +    description:
> +      Reference voltage supply. If not supplied the internal reference i=
s used.
> +
>    vcc-supply:
> -    description: If not supplied the internal reference is used.
> +    deprecated: true
> +    description: Use vref-supply instead.
> =20
>    reset-gpios:
>      description: Active-low RESET pin to reset the device.
> @@ -89,7 +103,9 @@ examples:
>          dac@0 {
>              reg =3D <0>;
>              compatible =3D "adi,ad5310r";
> -            vcc-supply =3D <&dac_vref0>;
> +            vdd-supply =3D <&dac_vdd>;
> +            vlogic-supply =3D <&dac_vlogic>;
> +            vref-supply =3D <&dac_vref>;
>              reset-gpios =3D <&gpio0 0 GPIO_ACTIVE_LOW>;
>              ldac-gpios =3D <&gpio0 1 GPIO_ACTIVE_LOW>;
>          };
>=20
> --=20
> 2.43.0
>=20
>=20

--0YNEvVT2+/MPyOSF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaepXuAAKCRB4tDGHoIJi
0p3dAPkBqSMXCX2CsYMrapm//aUW6NgaJWVhTVD9bnHV26zYngD/XFHL/z2OqDIT
KLIZFuJfsoLbnfvH6CMg5RNJ7DsocQ8=
=fNjo
-----END PGP SIGNATURE-----

--0YNEvVT2+/MPyOSF--
