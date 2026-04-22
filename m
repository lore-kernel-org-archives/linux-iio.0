Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 952F3175A79;
	Wed, 22 Apr 2026 16:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776876870; cv=none; b=KI+RLA3zx3DKJKPvexLg+Fp0dfSb83wRerl2ROA9gntdIsb6O+46lrNtb0oNVtrkwNG8yO9qaUcbFSbg8RaUO+wCRvoYRK6Sn/y035kWO1fe9o3mSY7XKwTspeM2xgGomBVycgNVOOwo0F7XPqHnQcCnvEjEEe34fXWUqusLMB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776876870; c=relaxed/simple;
	bh=QQPD2Vyj4pRqkAtMmuilFBL0rovt27YTEJ7MtMCBN7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SUlPVHipN78XI9AnWv0fQeFQq3u6M1Ageu7D29GlVRTJGi4Fdo7fQVhPOtkaUDttUhL9mintmkXrojJDT0+1M2ywSoUP8Xl77NNVP+05vpaIt4bX4PJDCt7FVwEi3Pcg8RtlXVCbJUEnyKCZgAXJrB4/mXFJtq8CvK4JT0W/tpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XHSM2/qe; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XHSM2/qe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB084C19425;
	Wed, 22 Apr 2026 16:54:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776876870;
	bh=QQPD2Vyj4pRqkAtMmuilFBL0rovt27YTEJ7MtMCBN7o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XHSM2/qecfS2weBZPhDb45mJgMTe4+gHf8Y3a7Z5ojZZ7ruIEkX1TdfG8WULKaFj/
	 qCDS0yXOL56apxG8DaU20TJsJo+67/a0lyOm+9vEZsSYAGNF3pWiYiEgeh12nwIVMl
	 ECmYbRCDIsDB/RF/YIXrq/z9VMJyJTWKfy0z9D5dHlVgWkTjDp6GRJGPee6+/n6B+w
	 pLqvbJWACLsXmC+QGY22SqJWMYoItXCIC2S7IqvdYOd3T8cXa4BxkXc2OfH2GpilAT
	 a27CZwdzOe+t7JvTTN+qn5GQ8rxCBYiZQKN1NjtEZT64Z2gPt8YsxN9bi9qibuW0Vb
	 /6OL5TUtvME5A==
Date: Wed, 22 Apr 2026 17:54:25 +0100
From: Conor Dooley <conor@kernel.org>
To: Ariana Lazar <ariana.lazar@microchip.com>
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] dt-bindings: iio: dac: mcp47feb02: Fix I2C address in
 example
Message-ID: <20260422-magnitude-improve-0266ea916c36@spud>
References: <20260422-mcp47feb02-fix6-v2-1-4ca4d5cfab07@microchip.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="7fymxECsY65Lxcmd"
Content-Disposition: inline
In-Reply-To: <20260422-mcp47feb02-fix6-v2-1-4ca4d5cfab07@microchip.com>


--7fymxECsY65Lxcmd
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2026 at 02:56:59PM +0300, Ariana Lazar wrote:
> Change example reg value from 0 to 0x60 in order to use a valid I2C addre=
ss
>=20
> Signed-off-by: Ariana Lazar <ariana.lazar@microchip.com>
> ---
> Changes in v2:
> - drop fixes from commit message
> - keep just the address fix
> - Link to v1: https://lore.kernel.org/r/20260420-mcp47feb02-fix6-v1-1-ae1=
808fea11d@microchip.com

Acked-by: Conor Dooley <conor.dooley@microchip.com>
pw-bot: not-applicable

This really should be in series with your other patches, so that
Jonathan doesn't have to figure out which order they apply in.

> ---
>  Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml | 4 =
++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb=
02.yaml b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.ya=
ml
> index d2466aa6bda2106a8b695347a0edf38462294d03..350e80e4dbe05dd10e3c6fb00=
f74d58c56c54bc8 100644
> --- a/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/microchip,mcp47feb02.yaml
> @@ -280,9 +280,9 @@ examples:
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
>=20
> ---
> base-commit: d2a4ec19d2a2e54c23b5180e939994d3da4a6b91
> change-id: 20260417-mcp47feb02-fix6-bd6694d84750
>=20
> Best regards,
> --=20
> Ariana Lazar <ariana.lazar@microchip.com>
>=20

--7fymxECsY65Lxcmd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaej9QQAKCRB4tDGHoIJi
0uWvAQD4K0oz6XxyJ26Sr+zCtQ4TRUHhMqqt0R4tJTWT3ybdHgD+MNntaWUN3xzw
54kmC4jSCPLw3CRhuZ7+Syh7aKpdUgc=
=z8gI
-----END PGP SIGNATURE-----

--7fymxECsY65Lxcmd--
