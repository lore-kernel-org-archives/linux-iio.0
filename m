Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436230CDB6;
	Wed, 18 Mar 2026 17:38:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773855490; cv=none; b=lVshsru5fyWAU3HTyHXg6v0zlkE3+vz+c9HSJTn8HCPn9gveI4A9HnLyuSHKAWOU9miKh5GHoJx9j9bj8zycx2osNxmzNg8/VKs1PrswGiHgggvb+7OCDK58ZTUOLUxTDSqqNcQ8IdEnnmyIL5gxIuAE9DxsfuI0EHtYlgtQ5Ts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773855490; c=relaxed/simple;
	bh=HPl+5k0VOQiOi37dHewPhIufg1R1qsuZGRuoSVJRbLg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q7F2ETr1BJASgFK/j6G0QN6KjhQH2EFwe5ZZPocAk02BggM0EpFaapz/yVnlSRld3IXST8sVbVVnwGuJaNRJHanl0XKNeti9BVwjYU7guYpzm7c1ywjLMueL9+VBrCll+M89NEZ51OybrIxjEWfDizvM+nO9Tj1zMs24mPTFxcs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qo/9MguC; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qo/9MguC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A999C19421;
	Wed, 18 Mar 2026 17:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773855489;
	bh=HPl+5k0VOQiOi37dHewPhIufg1R1qsuZGRuoSVJRbLg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qo/9MguCk2jSOcuQM5E82tSD79b0rJ+ZNkixOzIwCC2I7zbDnOLrxgt21ahKKxrMk
	 /gNqJcYC311pXfLXLz1gtYBNmbrUib+fK1EzVUrvRlUCCINJMC3CUsvj/wlVuan1Rr
	 yCndb3SvDaJA0Box9M9C4KfsWas0kKL1kBlZixp3u17YRuGDkyeUONIwO2463EcTDL
	 KdQm31YovClvRLCe0GrSAGnur+Q5XblxZFbfsEQShQB108qJm5D774O//zsB7/+Cei
	 lsXhrWRHqTMke3xBiuJAXZUoLtuEv3Ak2gfzUIW9AvN1ydIyVgnQAnowyjeFjsvmCR
	 ZaPE6LZQJ7NFw==
Date: Wed, 18 Mar 2026 17:38:04 +0000
From: Conor Dooley <conor@kernel.org>
To: David =?utf-8?Q?Marinovi=C4=87?= <david.marinovic@pupin.rs>
Cc: jic23@kernel.org, andriy.shevchenko@intel.com, dlechner@baylibre.com,
	nuno.sa@analog.com, robh@kernel.org, krzk+dt@kernel.org,
	conor+dt@kernel.org, michael.hennerich@analog.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] dt-bindings: iio: dac: ltc2632: add LTC2654
 compatible strings
Message-ID: <20260318-case-landslide-cdff9d99cd56@spud>
References: <5d4fb8998d9634c3e5a8ed17b80dae07@pupin.rs>
 <20260318135736.91564-1-david.marinovic@pupin.rs>
 <20260318135736.91564-3-david.marinovic@pupin.rs>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="UUFt2eb+o6gxv3mb"
Content-Disposition: inline
In-Reply-To: <20260318135736.91564-3-david.marinovic@pupin.rs>


--UUFt2eb+o6gxv3mb
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 18, 2026 at 02:57:31PM +0100, David Marinovi=C4=87 wrote:
> From: David Marinovic <david.marinovic@pupin.rs>
>=20
> The LTC2654 is a quad-channel, 16-/12-bit DAC with internal
> reference voltage and SPI interface, sharing the same 24-bit
> SPI protocol as the LTC2632/2634/2636 family.

What makes these devices incompatible from the existing ones in the
file?
Can you add a note about that please?

Thanks,
Conor.

>=20
> Add compatible strings for the following variants:
> - lltc,ltc2654-l16: 16-bit, 2.5V internal reference
> - lltc,ltc2654-l12: 12-bit, 2.5V internal reference
> - lltc,ltc2654-h16: 16-bit, 4.096V internal reference
> - lltc,ltc2654-h12: 12-bit, 4.096V internal reference
>=20
> Signed-off-by: David Marinovic <david.marinovic@pupin.rs>
> ---
>  .../devicetree/bindings/iio/dac/lltc,ltc2632.yaml    | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml =
b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> index 733edc7d6d17..b22df24dee07 100644
> --- a/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> +++ b/Documentation/devicetree/bindings/iio/dac/lltc,ltc2632.yaml
> @@ -4,14 +4,16 @@
>  $id: http://devicetree.org/schemas/iio/dac/lltc,ltc2632.yaml#
>  $schema: http://devicetree.org/meta-schemas/core.yaml#
> =20
> -title: Linear Technology LTC263x 12-/10-/8-Bit Rail-to-Rail DAC
> +title: Linear Technology LTC263x and LTC2654 Rail-to-Rail DAC
> =20
>  maintainers:
>    - Michael Hennerich <michael.hennerich@analog.com>
> =20
>  description: |
> -  Bindings for the Linear Technology LTC2632/2634/2636 DAC
> -  Datasheet can be found here: https://www.analog.com/media/en/technical=
-documentation/data-sheets/LTC263[246].pdf
> +  Bindings for the Linear Technology LTC2632/2634/2636/2654 DAC
> +  Datasheet can be found here:
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
LTC263[246].pdf
> +    https://www.analog.com/media/en/technical-documentation/data-sheets/=
2654f.pdf
> =20
>  properties:
>    compatible:
> @@ -34,6 +36,10 @@ properties:
>        - lltc,ltc2636-h12
>        - lltc,ltc2636-h10
>        - lltc,ltc2636-h8
> +      - lltc,ltc2654-l16
> +      - lltc,ltc2654-l12
> +      - lltc,ltc2654-h16
> +      - lltc,ltc2654-h12
> =20
>    reg:
>      maxItems: 1
> --=20
> 2.50.1
>=20

--UUFt2eb+o6gxv3mb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCabri/AAKCRB4tDGHoIJi
0pBIAP9RORlhRv+rtXxBd65FrAKSXHwlMibwlikrHN1jdZdYxwEAtxWPpFhgKynw
5UKK16RnBapFLp4/z+cEHSkCHyxGgAs=
=kFnl
-----END PGP SIGNATURE-----

--UUFt2eb+o6gxv3mb--
