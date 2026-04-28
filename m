Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE5D142E000;
	Tue, 28 Apr 2026 15:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777391824; cv=none; b=Fn+B0HZvWlH0BUhwcNutxoOKgFymudOha43alelxLZLcaKxAfVF9u8IdEsF3TrZXkInwQqhO3ukSEMglcXyJNiy2ZDUpStyTZmaQQNUC0sfEL/BecXlv3SyzAMknwZ3KWnPY3cOoH9rrRN/xaFdKyNyx8UuHd+yLZwFp+N1wX20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777391824; c=relaxed/simple;
	bh=dvKI+AdkPjcs5A26s9UQDTvEjNg+DDDGu7kr5vP39Us=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhUEa1zob79doKJujvyf/CnZTwYNhU2X3lyjaC8hZ3TDgVeWPJTi5RcE3Y+pXp/JnWOGV6c9EsiLPrKV7V3Lz0jE3582Obe5EXir5hZI9L7Yuu+4/ceTOvJPk9YS30ztODQ6qbDQvJBMkZjzcxW95UmYmYRkdEHHCQzmRVByUUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RleJosni; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RleJosni"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34B4EC2BCB8;
	Tue, 28 Apr 2026 15:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777391823;
	bh=dvKI+AdkPjcs5A26s9UQDTvEjNg+DDDGu7kr5vP39Us=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=RleJosnioXvHimovFLQzg3B1gA06yONo2xxPR9W04Co4WlAwV3e1I0pgvMCgDdWHu
	 0mmR8jSmFv0ogllfR5q8ntS+BLHPjrBRYzMFcDjHIHpoMBkXJbyjJawKzPRtpYXKpR
	 OldCyZPdKQeXv4vm5kZkXr2tbbRuFgF7/E4kCoL9aaD/MfLOK0IKxpcBjT6RYoD42C
	 2x0Qy3yiBlNIMWVMv8sK2IByonv/6zKBtaU+vX8msOAExdF3v79sBUpg4k/Q014Iv9
	 awqN0h6WDNTD8uHuoaKo3Yuo1jf/N/3mj5bVxhQiCX6OUWwaFCPpU/PvZ9cqUM1vwP
	 HU7v3OUyCkvTg==
Date: Tue, 28 Apr 2026 16:56:54 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>, Marcelo Schmitt
 <marcelo.schmitt@analog.com>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: temperature: max30208: fix wrong scale value
Message-ID: <20260428165654.2badd010@jic23-huawei>
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
It should be reporting in milli degrees C.

There are a few IIO units that are a bit odd like this because long long
ago in a galaxy far away, I decided to start from the scaling hwmon uses.
It turned out that gets really messy as you add more unit types so we
later standardized any new units on SI without a multiplier.  However
having to maintain ABI compatibility meant we were stuck with milli for
several units including temperature.

So I think this driver is correct as it stands.



> for standard IIO consumers without custom workarounds. Since the driver is
> relatively recent, I believe fixing it now to match the hardware=20
> specification is preferable to keeping a broken ABI.
>=20
> What do you think?
>=20
> Best regards,
> --
> Salah Triki
>=20

