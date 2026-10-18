Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8F1239E9B;
	Sun, 18 Oct 2026 03:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792293482; cv=none; b=eGTCdhOyGOIAlSwgxgpADzWF5rtz9cPeo4zw/vDodCYBGNuEBt+FMsYHX4bMUQdPaBdVT/M7ZYhTeawoSk/jU5n9nqWy3dHO7rNEo3V/Aa3S2TsxDj3h6UQgQVGnXUpZFtz7422zebJnEtB2UpPUYS4Igv73u5WVFZFdWfTCIfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792293482; c=relaxed/simple;
	bh=RZLo7gb7dFPUw6DZYGh/8tduzGYYdV9V+nIiX9yWAq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0CsWLi6li3oQT7C2kgfzyYaD/oRnhnFeYZDU+nyEVTRMKmRWsh8rgOQ+MJRNoXSuyqm3PQrOyQLV/sL8XXDEKdPCYb3WLRwuwiSNEJ9DOIqgrnEKnBrDGA1hzuEf66Y0RY5bFLsYwZ2tJVWi4Y+yKxZ7/VfMn3KFCuDfupEvhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hlA7633Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hlA7633Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 527B21F000C4;
	Sun, 18 Oct 2026 03:17:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792293481;
	bh=HNn3/KT9tSQHLzm7+Y2Ab67rw4QSxXEByt4Xj6gyGsk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=hlA7633Z3R8s3puphPNLEFixp/MfxhFJ/M98g61KA2C4DMJh/uDaZuXSqIYruzlIH
	 7mmzavLaDpN0nsZA4K57Vb9vtdmAPtrxcFmRhsBjpz4GJNFn7pEfJFPnaRHiM4WQgz
	 q+Crslnf4sZ5ExROjVwf3bg0VkbIDMVZdMPBbBFZ+W/W7XHAJS6CWRC7i8h6PUUB1K
	 q4GQ1v3Ux1iTunY7/vzE09R7+2xD5v9c4DSPX2bPbGbI073CvV7sniJhpN/IIjwrE5
	 UM3Agdf6Bh5olgRl8GYV3n+QgDyWilRBL5uS4lrdDzK5cyNO/U2M7D/XZRbVatXJ2k
	 ZSCBh5C1iJjlQ==
Date: Sun, 18 Oct 2026 04:17:53 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andrei Stancovici
 <andrei.stancovici@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Liam
 Beguin <liambeguin@gmail.com>, linux@analog.com, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/6] iio: adc: ltc2497: add LTC2493 support and
 line-frequency rejection
Message-ID: <20261018041753.695951a0@jic23-hlaptop>
In-Reply-To: <as5MLkl3pSyR3Q46@ashevche-desk.local>
References: <20261009-submission-ltc2493-support-v1-v1-0-3dad1d4b152a@analog.com>
	<179189735509.1005940.16593087405634433360.b4-review@b4>
	<as45F3tHGzTc6lMk@ashevche-desk.local>
	<as5IbgaDG3FWby3G@nsa>
	<as5MLkl3pSyR3Q46@ashevche-desk.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 13 Oct 2026 18:20:14 +0300
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Tue, Oct 13, 2026 at 04:09:46PM +0100, Nuno S=C3=A1 wrote:
> > On Tue, Oct 13, 2026 at 04:58:47PM +0300, Andy Shevchenko wrote: =20
> > > On Tue, Oct 13, 2026 at 02:15:55PM +0100, Nuno S=C3=A1 wrote: =20
> > > > On Fri, 09 Oct 2026 11:43:33 +0300, Andrei Stancovici <andrei.stanc=
ovici@analog.com> wrote: =20
>=20
> [...]
>=20
> > > > > - pyadi-iio hardware test suites: 41/41 on the LTC2493, 36/36 on =
the
> > > > >   LTC2499.
> > > > >=20
> > > > > The series was rebased onto the base commit below after those run=
s. The
> > > > > rebase left all four touched files byte-identical, so the code po=
sted
> > > > > here is the code that was tested. =20
> > > >=20
> > > > Not sure I agree with how you split the series. To me, patch 2, 3, =
4 and
> > > > 6 could be very well just one (adding support for the new chip). Pa=
tch 5
> > > > becomes preliminary patch which is adding a new feature the new chip
> > > > will also take advantage on. =20
> > >=20
> > > But they are sound like a good feature-wise split. I would leave that=
 as is
> > > currently. =20
> >=20
> > Yeah but all of those features are things already supported in the
> > driver. I would agree if we needed substantial changes for the new chip
> > being added. But that's not the case, just a few lines (or even one
> > liner in one IIRC). To me it really makes no sense adding a new chip to
> > a driver and in a following patch on the same series just setting one
> > more chip_info boolean to true. =20
>=20
> Fair point.
>=20
> > Have no strong feelings though but not how things are usually done. =20
>=20
> Okay, meaning let Jonathan to decide.

Current break down does leave us with the oddity of a chip_info
structure that suggests the chip only supports a subset of
stuff that then grows.  I agree with Nuno that first bunch of
patches would look better combined. Normally I'd ask for the
channel number thing I just asked as a precursor but seems it
will be ugly like that, so throwing that in as well is fine.

Jonathan

>=20

