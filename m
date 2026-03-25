Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1E682F12D4;
	Wed, 25 Mar 2026 20:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774470774; cv=none; b=U5VOvRTZA5JPzSpa++fD0ClSubACm7BMmxqkXqGtKKSgzJa23HJtkV4Uw10zifUR9ZhLAXYu/AzwqPnXpnv0n+8aMQtcYSLYbN9M7+63J+zjrJz/Iz86w6azt+KeFPFUjtp+lOOghrfzpezZ3KjpgUs1uH87TXwu6eLLaoDQNyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774470774; c=relaxed/simple;
	bh=E/3YOiRVR/Ko4BXJ7e1Ey4/UFr4wUyZbVc/+utgGg6Q=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z0ubYQlUpIBbZX2XyKYR/YKetpjwRfzl3KHBLpwi1qYNzqsNeDAQcw8vkjlSnTGFsn1HBB9ozNIkNCjTJbxYI8vvZgNlY/xMKDwIuYaqjffpZ2GCCMa4oe88/eBDjKDh3fpZHIRtX5tDyWFlET6if+FY1ACAuVg3s0o08qGZB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TyBma3Bb; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TyBma3Bb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83120C19423;
	Wed, 25 Mar 2026 20:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774470774;
	bh=E/3YOiRVR/Ko4BXJ7e1Ey4/UFr4wUyZbVc/+utgGg6Q=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=TyBma3BbOvTR3G8GBmiynZhGd4ikgMWkL+nqi/ItEZxH/1cKPEl42gAYEWMFot5CV
	 v8prhhcb67doTqPNqM+gUfQxXFVXcPC2j1ZeFR82kCC4WV9Dfuvu5nBdRCYBIIQSib
	 bf9yDcmMX+GknBbA9r7NXZ8p6gNAXlOzXkVyfF7S6zbHz4Bez/39BHPg90YkO2u4V0
	 Ip8xTiqu8f8KezQMNEvnaqu1xK6MHynGffsCT/RdP4i3F6cOjr4gPZLmghwcKqlyea
	 uT0+XXsz0VO1MuILy9r/P1cYdqX/KNy1OgsQzXFuaD1O0nGJduG+V06KwntRoQ7way
	 cF8CgRyCDv6fg==
Date: Wed, 25 Mar 2026 20:32:44 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Matheus Giarola <matheustpgiarola@gmail.com>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, matheusgiarola@usp.br, arthurpilone@usp.br,
 davidbtadokoro@ime.usp.br
Subject: Re: [PATCH] iio: adc: ad7280a: replace mutex_lock() with
 guard(mutex)
Message-ID: <20260325203244.4dac3788@jic23-huawei>
In-Reply-To: <CABGH8=az2T+GMy55_zX-C-9=rMauaWvqGBF=+VCoRBSCDTmnHQ@mail.gmail.com>
References: <20260319184615.10970-1-matheusgiarola@usp.br>
	<20260321155530.27751a72@jic23-huawei>
	<CABGH8=az2T+GMy55_zX-C-9=rMauaWvqGBF=+VCoRBSCDTmnHQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 25 Mar 2026 16:21:04 -0300
Matheus Giarola <matheustpgiarola@gmail.com> wrote:

> On Sat, Mar 21, 2026 at 12:55=E2=80=AFPM Jonathan Cameron <jic23@kernel.o=
rg> wrote:
> >
> > On Thu, 19 Mar 2026 15:46:15 -0300
> > Matheus Giarola <matheustpgiarola@gmail.com> wrote:
> > =20
> > > Use guard(mutex) instead of mutex_lock()/mutex_unlock(),
> > > ensuring the mutex is released automatically when leaving
> > > the function scope. The change improves error handling and
> > > avoids issues such as missing unlocks. It also simplifies the
> > > code by removing 'err_unlock' label and several mutex_unlock()
> > > calls.
> > >
> > > Signed-off-by: Matheus Giarola <matheusgiarola@usp.br> =20
> > Hi Matheus.
> >
> > =20
> > > @@ -885,13 +875,12 @@ static int ad7280_read_raw(struct iio_dev *indi=
o_dev,
> > >
> > >       switch (m) {
> > >       case IIO_CHAN_INFO_RAW:
> > > -             mutex_lock(&st->lock);
> > > +             guard(mutex)(&st->lock); =20
> >
> > Scope missing...
> >
> > Thanks,
> >
> > Jonathan =20
>=20
> Hi Jonathan,
>=20
> Thank you for the review and pointing out the missing scope, I'll fix
> it by using
> scoped_guard() to ensure the lock is released at the right time.
nope.  Whilst that would be correct it's not the nicest solution.
Instead do what you'd do if there was a variable declared in a case
block..
	case IIO_CHAN_INFO_RAW: {
		guard(...)(..);
...



	}

Under the hood guard is declaring a local variable.

>=20
> I'm a bit busy with university work this week, so at most by next week I'=
ll send
> a v2 of this patch.
>=20
> Best regards,
>=20
> Matheus
> > =20
> > >               if (chan->address =3D=3D AD7280A_ALL_CELLS)
> > >                       ret =3D ad7280_read_all_channels(st, st->scan_c=
nt, NULL);
> > >               else
> > >                       ret =3D ad7280_read_channel(st, chan->address >=
> 8,
> > >                                                 chan->address & 0xFF);
> > > -             mutex_unlock(&st->lock);
> > >
> > >               if (ret < 0)
> > >                       return ret; =20
> > =20

