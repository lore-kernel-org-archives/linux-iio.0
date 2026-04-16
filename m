Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6E73E3C6F;
	Thu, 16 Apr 2026 15:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776354130; cv=none; b=ghOLsWt1CLUZE03SyP/JU30lE1kUBPotqbty2hD+L7VLsaL8du+ahwzQZMVDapVWrgIgkkRTBleenkPMmhDhG+WubHxMNKqsT8NPZMclY/n6CfIIXFFJpqy4oqAhlZdIxwtW43Dg37B4qexaHVkuSnPW+Dv3MZjZyCEAIET1X7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776354130; c=relaxed/simple;
	bh=O9FiysduB5fV+a0A/zd6Wme3+EHfrjUQ75s8UULF/Go=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sKCOI4XJ20o8YEF1u4vZcsz20KSY2CDEIFsPGP3dCnP35K7Y2+StPjZgHaswIWECWLxR++BM842M6zI645I0oQx187tWdunD3VMeesvlnfCHfu4bcK3niVFIsYsc2bkXleg3azH0uSFqEbLjS0WihrV4y229iroXZkWjvIjRcu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qqZr3TqA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qqZr3TqA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E60C2BCB3;
	Thu, 16 Apr 2026 15:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776354130;
	bh=O9FiysduB5fV+a0A/zd6Wme3+EHfrjUQ75s8UULF/Go=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qqZr3TqABCJf5789N9pCIFxAN7SXBz2CXqjMBzvidOCZtnji9KN6zHPFFNCGaGowK
	 zvpe9uZgrWSwGAoO+C0QaRXLuluseawvUU8BGwS3xlQQT2OrV/f6rbH//XJ2qYnZJA
	 H+CXo/kHBvOwm2MWB0il/FpdYuqyy9sa00lX5k1RVaQN1gFtv+Y6StyxUcfTrnoukX
	 1OcEkLKISsCrgNHZmH6kTPtZ4L9V2VdAzdtpUbfX1/zkRCe7H6jBDR8aBZBo+zP+D2
	 xIjXkvwq1nOcfdwtfdqSvfVItgXKHXag6V1eqWEF00UEUv4dXEdVBqYDij0Pz/tiOL
	 afmkXi4U8FhFg==
Date: Thu, 16 Apr 2026 16:42:05 +0100
From: Conor Dooley <conor@kernel.org>
To: vishwas.dev@vrajashkr.com
Cc: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	"H. Nikolaus Schaller" <hns@goldelico.com>,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, luca@lucaweiss.eu
Subject: Re: [PATCH v2] dt-bindings: iio: gyroscope: add mount-matrix for
 bmg160
Message-ID: <20260416-level-unbitten-eb3bf8d4a6c7@spud>
References: <20260416-bmg160-mount-matrix-dt-binding-v2-1-e66cf5cff8e8@vrajashkr.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="J6stNf8MGQxz7D2O"
Content-Disposition: inline
In-Reply-To: <20260416-bmg160-mount-matrix-dt-binding-v2-1-e66cf5cff8e8@vrajashkr.com>


--J6stNf8MGQxz7D2O
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 16, 2026 at 08:33:21PM +0530, Vishwas Rajashekar via B4 Relay w=
rote:
> From: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
>=20
> Adds mount-matrix as an optional property to dt-bindings
> for the bmg160 gyroscope as the driver reads this optional
> property during probe.

Ultimately, what the driver does is not relevant here. All that matters
is that the property is relevant to the hardware. Please come up with a
commit message that avoids mentioning linux drivers and instead explains
why it is relevant to the hardware.

pw-bot: changes-requested

Cheers,
Conor.

>=20
> Signed-off-by: Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
> ---
> The bmg160 driver reads an optional mount-matrix using
> "iio_read_mount_matrix" in "bmg160_core_probe" and stores
> this orientation data in "struct bmg160_data". As the "mount-matrix"
> property is used by the driver, this change proposes to add it to
> the corresponding dt-bindings.
> ---
> Changes in v2:
> - Addressed review feedback: add mount-matrix example for bmg160
> - Link to v1: https://patch.msgid.link/20260415-bmg160-mount-matrix-dt-bi=
nding-v1-1-0e2c85964ee6@vrajashkr.com
>=20
> To: Jonathan Cameron <jic23@kernel.org>
> To: David Lechner <dlechner@baylibre.com>
> To: Nuno S=E1 <nuno.sa@analog.com>
> To: Andy Shevchenko <andy@kernel.org>
> To: Rob Herring <robh@kernel.org>
> To: Krzysztof Kozlowski <krzk+dt@kernel.org>
> To: Conor Dooley <conor+dt@kernel.org>
> To: "H. Nikolaus Schaller" <hns@goldelico.com>
> Cc: linux-iio@vger.kernel.org
> Cc: devicetree@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml | 6 ++=
++++
>  1 file changed, 6 insertions(+)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160=
=2Eyaml b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> index 3c6fe74af0b8..ec97778cca78 100644
> --- a/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> +++ b/Documentation/devicetree/bindings/iio/gyroscope/bosch,bmg160.yaml
> @@ -22,6 +22,9 @@ properties:
>    vdd-supply: true
>    vddio-supply: true
> =20
> +  mount-matrix:
> +    description: an optional 3x3 mounting rotation matrix.
> +
>    spi-max-frequency:
>      maximum: 10000000
> =20
> @@ -52,6 +55,9 @@ examples:
>              reg =3D <0x69>;
>              interrupt-parent =3D <&gpio6>;
>              interrupts =3D <18 IRQ_TYPE_EDGE_RISING>;
> +            mount-matrix =3D "0", "1", "0",
> +                           "1", "0", "0",
> +                           "0", "0", "1";
>          };
>      };
>  ...
>=20
> ---
> base-commit: 591cd656a1bf5ea94a222af5ef2ee76df029c1d2
> change-id: 20260414-bmg160-mount-matrix-dt-binding-e76ddde94866
>=20
> Best regards,
> -- =20
> Vishwas Rajashekar <vishwas.dev@vrajashkr.com>
>=20
>=20

--J6stNf8MGQxz7D2O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCaeEDTQAKCRB4tDGHoIJi
0lrrAPsHImGa/S6LpMCAlJgw0EYS6WwjRmVGeROd2wyk5X3flwEApO3SCda+guxA
gQpPGaViQ4SykokScSE/Dlva04srBw0=
=ioG4
-----END PGP SIGNATURE-----

--J6stNf8MGQxz7D2O--
