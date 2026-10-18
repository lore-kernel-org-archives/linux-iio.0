Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A5B8352027;
	Sun, 18 Oct 2026 02:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792291304; cv=none; b=bbwUgCicTlhLDDHg4nqtP7Ma8V94eNFiUCtfWj5YiBz92xeWiLBMFBDZ6M/6ULNbIfbipXhZNuNTFrbsvoIJQ2ic2KmerBZPQijgkDzIM64hbVdvV8PrJ1884iG0g4lLwL+BJ6tMAHs6wp6SNKUC53WTu7ex7GJa1mnXF0ANN8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792291304; c=relaxed/simple;
	bh=DyN7kBUeI6JP6feNT5L7rLls7eIxItlqOow+9Du6A00=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NmVhvnLNmqEYGxc5kLga1TaSGOxnkRnsTTCvKfrWZVKyXEqNcSyUDekvUfGn5rDXh7gErowHk1J9Y1YV/u4wPll1RWeOYIovUTK96CJ/hn0MC6VP2b4iTv9DUlHDOj/xPImHoSM47OK5RIdkALT8mntvXEE5eUH7dxAWxIAmxUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EOAb385U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EOAb385U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8DED1F000C4;
	Sun, 18 Oct 2026 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792291302;
	bh=KrrmPH4dW1W5z8AQR7z2PPMQM1A2Z4v4Z50cRvZMCtU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=EOAb385U2MBMYpydmztfheJW+hfdA7lCTOrjg098xP8IEiuprMgqAn8ibQ8INJX5a
	 Yh+V1UzJBlIApmCOc3xuqrOCwNSgvVWp2hxc/z5K+KHYluhoDfDeBMow0I6Kk/AjMF
	 1YMZo8+HO6Ic3VXXEPuoo8IlKCHhg+M5Ua3nUkKJAAz7AwmAXCyHqF2hZVOalpaTLy
	 X6O00frysLwG5LkqVwoSnbQgAFSRmXP30cUtxFm3ii5mRjjwUamTSjCH/yk5trpveO
	 2DXBv/O6s/ZnkORgvLf74Dw7kwNvmR5gQBZMm16qiPANBTvywuwYe1mG9/XTILcFIK
	 rKxDtyR2M+UUQ==
Date: Sun, 18 Oct 2026 03:41:34 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Kanak Shilledar <Kanak.Shilledar@axis.com>
Cc: "marcelo.schmitt1@gmail.com" <marcelo.schmitt1@gmail.com>,
 "Jean-Baptiste.Maneyrol@tdk.com" <Jean-Baptiste.Maneyrol@tdk.com>,
 "krzk@kernel.org" <krzk@kernel.org>, "joshua.crofts1@gmail.com"
 <joshua.crofts1@gmail.com>, "dlechner@baylibre.com"
 <dlechner@baylibre.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "nuno.sa@analog.com" <nuno.sa@analog.com>,
 Henrik Grimler <Henrik.Grimler@axis.com>, "devicetree@vger.kernel.org"
 <devicetree@vger.kernel.org>, "robh@kernel.org" <robh@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "andy@kernel.org" <andy@kernel.org>, Kernel <Kernel@axis.com>,
 "macromorgan@hotmail.com" <macromorgan@hotmail.com>, "conor+dt@kernel.org"
 <conor+dt@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>
Subject: Re: [PATCH v6 1/6] dt-bindings: iio: imu: icm42600: Add ICM-42670-P
Message-ID: <20261018034134.2bf170a0@jic23-hlaptop>
In-Reply-To: <1804b94e69b11377a912ab82dd00303cf0f60e8b.camel@axis.com>
References: <20261009-b4-inv_icm42370p-v6-0-e53884f185ff@axis.com>
	<20261009-b4-inv_icm42370p-v6-1-e53884f185ff@axis.com>
	<20261012-adventurous-corgi-of-fury-01219b@quoll>
	<fd4181c7e2f48e3c64530340ae1a02adde1f342e.camel@axis.com>
	<da8b6047-419b-4c3d-8416-e5c871ea4dec@kernel.org>
	<as1ZPOocclBgYkko@debian-BULLSEYE-live-builder-AMD64>
	<BE1P281MB142642474354814F0785CB97CE9E2@BE1P281MB1426.DEUP281.PROD.OUTLOOK.COM>
	<1804b94e69b11377a912ab82dd00303cf0f60e8b.camel@axis.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 16 Oct 2026 07:18:49 +0000
Kanak Shilledar <Kanak.Shilledar@axis.com> wrote:

> Hi,
> > > >  =20
> [...]
> > > > That's misleading or confusing. Either the device works or does
> > > > not
> > > > without interrupt hooked up. Consult hardware datasheet if in
> > > > doubts.
> > > >=20
> > > > Driver support is different thing here and you cannot make it
> > > > required
> > > > later, because that would be unjustified ABI break. =20
> > >=20
> > > I looked into icm42605 data sheet and saw no clear statement about
> > > the interrupts
> > > being required. The timing diagrams only show protocol specific
> > > lines and it
> > > looks like the interrupt sources can even be disabled (not routed
> > > out to any
> > > interrupt pin). Maybe I'm missing something and the interrupts are
> > > required for
> > > some sort of reset function or so? Otherwise, I don't see how the
> > > interrupts are
> > > required.
> > >=20
> > > Kanak, do you have access to any of those other chips to test
> > > whether they work
> > > without interrupts? If possible, can you also check the data sheets
> > > for the other
> > > parts besides icm42370p and icm42605?
> > >=20
> > > Maybe
> > > =C2=A0- if:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 properties:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 compatible:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 contains:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 enum:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42600
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42602
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42605
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42622
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42631
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42686
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 - invensense,icm42688
> > > =C2=A0=C2=A0 then:
> > > =C2=A0=C2=A0=C2=A0=C2=A0 required:
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - interrupts
> > > was a documentation mistake?
> > >=20
> > > With best regards,
> > > Marcelo
> > >=20
> > >  =20
> >=20
> > Hello,
> >=20
> > I can confirm that all icm426xx chips can work without interrupt by
> > just polling
> > the data.
> >=20
> > Interrupts were declared as required at the time only because the
> > driver doesn't
> > work without interrupt (probe will fails).
> >=20
> > Hardware speaking only, this is indeed a documentation mistake. =20
>=20
> Thank you for confirming the requirement for interrupts. I will cleanup
> the documentation in a separate commit not part of this series and the
> driver should be updated to not fail if the interrupt property is
> absent in the devicetree.

Two different things. =20
1) Update the DT to reflect hardware requirements and it is vanishingly
   rare for an IIO part to require interrupts.  The only case I can
   immediately think is comparators which don't have any other interface.
2) Possibly update the driver to support polling. Not a requirement as
   we can choose not to support particular DT in a driver - that has
   nothing to do with the binding which is documenting the hardware.

I'd put 1 as a precursor patch in your series simply because otherwise
we will get some fuzz due to stuff moving in the binding + maybe
forget to tidy this up!

Jonathan

>=20
> Best Regards,
> Kanak Shilledar
>=20

