Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 553D034D4F9;
	Tue, 28 Apr 2026 15:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777390508; cv=none; b=pBiJRepbt0w/1AyQeOyYRoxB9TH2b3Kz0/9gb+oQZbk3qWK0aC2kMpWI/jixiZ8imzEGMNkX27pA2hDUfUoiIZZgu2BtVrbAJaJ9hwA3Kaeb0c7LpY1PLJR9tadSHP7l/AOTtJ8zDtZWjnS3ieXc6SwmFPuOm8yLft/95W0moIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777390508; c=relaxed/simple;
	bh=AeItuMByaJLTfbEfuesE2DDl8aGK29D6ug5rxZH7mXg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IeovAAi4wypklpoAfDv5zd7ayX8svuuMRBG0LJrgt33IWlpwwPLTO4xtYhahyZVlVvelfRSRribWth+ffgwtRzHQFPfD4nS9eTAL3oT+HEFpp4kYZvZ5otzlVmhy/wltZIcEArorudsoGZA+e316CJPil3RGgROZ67P5pAUMRNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AZC9qT20; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AZC9qT20"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E714C2BCAF;
	Tue, 28 Apr 2026 15:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777390507;
	bh=AeItuMByaJLTfbEfuesE2DDl8aGK29D6ug5rxZH7mXg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=AZC9qT20OcjvNWtrfM2Zlom5RO/dq3khRDwHrz9120Bm1y7HwCdP9Xv19tpmUGaMa
	 LIPwlh2h3zF5A3mkYljJRjjW2Qcy2+fs2O/8Y9tDRJ1ur9zPsil6Q+ap6jwYNz8oy3
	 Nqf4q0vjzk+gHnOac7HJNI+A0JVGGx6n7u3QrxBVDqqIGBuU41APrRwsUkJtP98JV2
	 NvAf3CB45xmfZ3YWqQQCP3nvLtxIXf3FSq4RPir0lMdETi2kQAQV4OEIPsOUrmH7TT
	 hkucUI8zIPBx/wdreMxP38KfSVO2uWiWVA9QBfbUJR2hfQ1nq8KhMk6BQo6WJFTnie
	 CqX7zWGKYHGrg==
Date: Tue, 28 Apr 2026 16:34:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: max30208: fix wrong scale value
Message-ID: <20260428163458.477eda9b@jic23-huawei>
In-Reply-To: <afC3wHzcwWMMgt3i@pc>
References: <20260428085415.52858-1-salah.triki@gmail.com>
	<afCTYDYCRXoxi37r@ashevche-desk.local>
	<afC3wHzcwWMMgt3i@pc>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 14:36:00 +0100
Salah Triki <salah.triki@gmail.com> wrote:

> On Tue, Apr 28, 2026 at 02:00:48PM +0300, Andy Shevchenko wrote:
> > On Tue, Apr 28, 2026 at 09:54:15AM +0100, Salah Triki wrote: =20
> > > The driver currently returns a scale of 5 for IIO_CHAN_INFO_SCALE, wh=
ich
> > > leads to incorrect temperature readings.
> > >=20
> > > According to the MAX30208 datasheet, the temperature resolution is 0.=
005=C2=B0C
> > > per LSB. Using IIO_VAL_FRACTIONAL with 5/1000 correctly represents th=
is
> > > 16-bit resolution.
> > >=20
> > > Fix the scale value to ensure user space tools report the temperature
> > > correctly in Celsius. =20
> >  =20
> > > Fixes: 9ee95ae4cffd ("iio: temperature: Add driver support for Maxim
> > > MAX30208") =20
> >=20
> > The tags should go with 1 tag per one (single) line. Do not wrap them. =
=20
>=20
> Sorry about that, I will fix the tag wrapping in v2.
>=20
> >  =20
> > > Signed-off-by: Salah Triki <salah.triki@gmail.com> =20
> >=20
> > ...
> >  =20
> > >  	case IIO_CHAN_INFO_SCALE:
> > >  		*val =3D 5;
> > > -		return IIO_VAL_INT;
> > > +		*val2 =3D 1000;
> > > +		return IIO_VAL_FRACTIONAL; =20
> >=20
> > Isn't it an ABI change?
> >  =20
>=20
> Yes, it technically changes the value exposed to user space. However, the
> current scale (5) is objectively incorrect according to the datasheet=20
> (0.005=C2=B0C per LSB).
>=20
> With the current scale, a raw reading of 5000 (25=C2=B0C) is reported as=
=20
> 25000=C2=B0C by user space tools. This makes the driver practically unusa=
ble=20
> for standard IIO consumers without custom workarounds. Since the driver is
> relatively recent, I believe fixing it now to match the hardware=20
> specification is preferable to keeping a broken ABI.
>=20

Yes.  It's fine to fix completely wrong ABI like this.  It can get messier
in more subtle corners but out by a factor of 1000 is an easy one!

Jonathan

> What do you think?
>=20
> Best regards,
> --
> Salah Triki
>=20

