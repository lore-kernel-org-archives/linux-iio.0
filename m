Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD05B4E323C;
	Fri,  2 Oct 2026 17:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790961136; cv=none; b=UoqYkccm3jou2jpT5kL4mUWWZqITYeAJFE/S+A9xoQfk6/muuCtaaq72iiZntCTvYF4F3dCt9OV5vrSFA9LILAUOby5wgNv98LzmNjv6WmVRs1pkSj+SWkdip2DEpowzYj6xhWtnBXd8gqPHg2RKfAdC1d6wEEE5cBLa302h/z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790961136; c=relaxed/simple;
	bh=1eDp+KLRfkEMEiliyzfTlBbMZpudbmnz+wWUolATmP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KP2Bgm4ZYq+h5p/gIKJ22RUn91384KfK6pBjII+dnSBOuiuo3IsixI2bCcOV7/F3Rg4ajTe9p2F0YPiVyQTguzvDxWHiJ4e1oo1Mn48DeTpdZVESgpF1ZYB1oRnx4FXFTV1jmrsnwmTIC6f+kQUo2wPMta2p18q1rc8cdhuuNw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvt8O64m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvt8O64m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C40C1F0089B;
	Fri,  2 Oct 2026 17:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790961121;
	bh=gKHsYxZSNrboNG7wTgtMiArfAuiOuFgFalc3IJZIPF4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=hvt8O64mz4PU2bYHKtD2VApAyQxjl+s0Xlx2bRON2QTFpyuYoW/kY5XNXJ2GpayKB
	 K+bu5SZRxjlgmVv8X4ei0hpbR3w9e7gcB63tRTdW8smAmGDYMEL/RV8x3Ktau13MoA
	 mfas5lqW1kCqd5AIi6makp9hc3xiVe7EJidz1WhH/PnYbVDmMLA5ftJzOvw2lVt0PM
	 TFFtcTGrgQ/tYjRxFSRrThFvBRYhbAN03ceiw5xcwVMuXBuCJZWci2TzVzGYqJe+GA
	 yjcVP7iIa2JQ6qwW24joj0/RL+g2aVQrP9H8pxNjhIrBnyYokGyEqGfxEr2FmfE8tg
	 pr6WR1BV+u1zg==
Date: Fri, 2 Oct 2026 18:11:56 +0100
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
Message-ID: <20261002-stoppable-ecology-33276b1244e3@spud>
References: <20261002-b4-inv_icm42370p-v5-0-c65281b745c9@axis.com>
 <20261002-b4-inv_icm42370p-v5-1-c65281b745c9@axis.com>
 <20261002-waviness-washed-5332bdae4e7f@spud>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="96vobJaStlC33hWO"
Content-Disposition: inline
In-Reply-To: <20261002-waviness-washed-5332bdae4e7f@spud>

--96vobJaStlC33hWO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 02, 2026 at 06:11:00PM +0100, Conor Dooley wrote:
> On Fri, Oct 02, 2026 at 01:54:25PM +0200, Kanak Shilledar wrote:
> > TDK Invensense, ICM-42670-P is a 3-axis accelerometer. The device can
> > support I2C, SPI and I3C. This device has very similar properties as
> > that of the icm42607/p. Add this device to the existing dt-binding and
> > update the description to match the devices.
>=20
> Reading this it's not clear to me why a fallback cannot be used.
>=20
> You say "similar properties", but what I see below is slotting into an
> existing enum, without differing restrictions.

The lack of a gyroscope is probably why? Please note that here.

pw-bot: changes-requested

>=20
> Thanks,
> Conor.
>=20
> >=20
> > Datasheet: https://www.invensense.tdk.com/en-us/products/3-axis/icm-423=
70-p
> > Signed-off-by: Kanak Shilledar <kanak.shilledar@axis.com>
> > ---
> >  Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml | 6=
 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42=
600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.ya=
ml
> > index 9e22b603d47fb..c79eb0a1a890e 100644
> > --- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > +++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
> > @@ -11,10 +11,10 @@ maintainers:
> > =20
> >  description: |
> >    6-axis MotionTracking device that combines a 3-axis gyroscope and a =
3-axis
> > -  accelerometer.
> > +  accelerometer. Some devices only have a 3-axis accelerometer.
> > =20
> >    It has a configurable host interface that supports I3C, I2C and SPI =
serial
> > -  communication, features a 2kB FIFO and 2 programmable interrupts with
> > +  communication, features up to 2.25kB FIFO and 2 programmable interru=
pts with
> >    ultra-low-power wake-on-motion support to minimize system power cons=
umption.
> > =20
> >    Other industry-leading features include InvenSense on-chip APEX Moti=
on
> > @@ -28,6 +28,7 @@ properties:
> >    compatible:
> >      oneOf:
> >        - enum:
> > +          - invensense,icm42370p
> >            - invensense,icm42600
> >            - invensense,icm42602
> >            - invensense,icm42605
> > @@ -81,6 +82,7 @@ allOf:
> >          compatible:
> >            contains:
> >              enum:
> > +              - invensense,icm42370p
> >                - invensense,icm42600
> >                - invensense,icm42602
> >                - invensense,icm42605
> >=20
> > --=20
> > 2.43.0
> >=20



--96vobJaStlC33hWO
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCar/l3AAKCRB4tDGHoIJi
0qAyAPsE89tduNSVmIE1d3pkoPTj7Sxapq51S6k5SeQieTGnegEAlpj8T2lM0cC2
LVjyvKPq/ByAWr6mC65FPoU2zZF55gY=
=CyhV
-----END PGP SIGNATURE-----

--96vobJaStlC33hWO--
