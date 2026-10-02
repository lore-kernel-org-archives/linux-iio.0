Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7221B4E01E2;
	Fri,  2 Oct 2026 17:11:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961076; cv=none; b=obwzfGqrmF+ETstquccX+Ji3KQQ6Vgxe0nzBPgmPdsdZipR3P6KJwMHS/A51Qp4g8n5v2/F/Dmbov0TzkHN4CRNGCjuLeaIhc54/7fiv8xScpDcwEhEoQre5S+bZ2eYx4/qbk8Mfp1yjWdv3s0O0P8LY+EMI5b8ph95JXojvIJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961076; c=relaxed/simple;
	bh=rgy7GkQjU+7QHjPyg48bdRKuFU5Wau6NidOfk05YMcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NGKBXS64YNNUutl+3zwbbVNAmUVlp8z8W+tTuz5AilHHp5FwDfrHbC3R1PEhBJe8OLLA9m34xhOwXYsGUw6SaOvW0OFND0ovqTE9KlOuhkLaQKIwS2IdjBoin0i9iQt7dyC8qjMGtmKfryAyS0LbYCDlrHXSSWkUWuEcL5UKh+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CQakxyiw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CQakxyiw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D7F11F000FF;
	Fri,  2 Oct 2026 17:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790961066;
	bh=Sy4s9MNMOwtn7nS954XZC2r7oY3nkSfsIilKeDzS+dI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=CQakxyiw4R3JlJBfbR/vxD6CraSabRjJ0/cQQNM1YL5dLOBHE6ObzleMZxxaMQxYC
	 UjwzRm/CYZrv5eUKg1haR+bQQ+WJ7fs3vuzBgoPNqbSpKJh6hvJZbKAmDVefVDCw1M
	 hqUQyOxQCmeUklnWkUGuA5ugJ1UaCp0N4O1wtEfJMcph/ppiC+9Ui9DTETEmdKFm9T
	 6MW0Y/7GJfJsnaa4VwqUr74o/aolUFeK2O+Fp1RQNq0xeS60VW/B6pm++stmOnaXXy
	 RKyw/OtxfQ7y5oo46jtlx3A3UpgqYXN/kCRqDo5DlMvHj8TazjnDqOXTA+5oeDq+pb
	 etR4+VNdVB1ZQ==
Date: Fri, 2 Oct 2026 18:11:00 +0100
From: Conor Dooley <conor@kernel.org>
To: Kanak Shilledar <kanak.shilledar@axis.com>
Cc: Henrik Grimler <henrik.grimler@axis.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
	Chris Morgan <macromorgan@hotmail.com>, kernel@axis.com,
	linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Message-ID: <20261002-waviness-washed-5332bdae4e7f@spud>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-1-c65281b745c9@axis.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="p/nYM0YS+SNVP3BF"
Content-Disposition: inline
In-Reply-To: <20261002-b4-inv_icm42370p-v5-1-c65281b745c9@axis.com>

--p/nYM0YS+SNVP3BF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 01:54:25PM +0200, Kanak Shilledar wrote:
> TDK Invensense, ICM-42670-P is a 3-axis accelerometer. The device can
> support I2C, SPI and I3C. This device has very similar properties as
> that of the icm42607/p. Add this device to the existing dt-binding and
> update the description to match the devices.

Reading this it's not clear to me why a fallback cannot be used.

You say "similar properties", but what I see below is slotting into an
existing enum, without differing restrictions.

Thanks,
Conor.

>=20
> Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-42370=
-p
> Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> ---
>  Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6 +=
+++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm4260=
0.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> index 9e22b603d47fb..c79eb0a1a890e 100644
> --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> @@ -11,10 +11,10 @@ maintainers:
> =20
>  description: |
>    6-axis MotionTracking device that combines a 3-axis gyroscope and a 3-=
axis
> -  accelerometer.
> +  accelerometer. Some devices only have a 3-axis accelerometer.
> =20
>    It has a configurable host interface that supports I3C, I2C and SPI se=
rial
> -  communication, features a 2kB FIFO and 2 programmable interrupts with
> +  communication, features up to 2.25kB FIFO and 2 programmable interrupt=
s with
>    ultra-low-power wake-on-motion support to minimize system power consum=
ption.
> =20
>    Other industry-leading features include InvenSense on-chip APEX Motion
> @@ -28,6 +28,7 @@ properties:
>    compatible:
>      oneOf:
>        - enum:
> +          - invensense,icm42370p
>            - invensense,icm42600
>            - invensense,icm42602
>            - invensense,icm42605
> @@ -81,6 +82,7 @@ allOf:
>          compatible:
>            contains:
>              enum:
> +              - invensense,icm42370p
>                - invensense,icm42600
>                - invensense,icm42602
>                - invensense,icm42605
>=20
> --=20
> 2.43.0
>=20

--p/nYM0YS+SNVP3BF
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar/lpAAKCRB4tDGHoIJi
0vLLAP9PaLWThV+gZ5BidMWSNLowb7mSoo5kjc5Ax94xh/ud8AD8DQbrz0LhTPM1
9nIbrKDGbq5TH6cvsXVNWoqOJ6RqtQA=
=uDac
-----END PGP SIGNATURE-----

--p/nYM0YS+SNVP3BF--
