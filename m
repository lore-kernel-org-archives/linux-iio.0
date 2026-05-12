Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F1C5385D6F;
	Tue, 12 May 2026 17:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778605849; cv=none; b=qpSkBnGyIc7vYzF9H0pqusre+YSrSILL+5bUvAbz4VHgCox1KAdZAshHI8IgwCaGQ/MMnTAQK7eIniRFJ4OLkGG1/YhXeEqZpSkXGjG0VdFEWe+Wq55wtMA2rMjlIg7xQzrS6lSpuxoVxbciNv+hxcQUGC6fMRp6vCxiR9DqrHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778605849; c=relaxed/simple;
	bh=x3SjhD8X8/iDJLZ2bMuDpjGHWfgxlc/e3gmmPSdZDnQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2dWU0vFlyxnTVIH9LBNg6aXet5vJhDiAM+KwOj/KR5sq0AH9IIWRhWhFI66L+tXoZGyeE6AR2aByBLQW+gU66HoHmiv37tTgYLiuL/x4WlousxrGmRUuTPH1ZILgNBeSX4FMwptCzWQeetjNhUJrZq5unFawNNdgUxzkuQ5mbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bnypsc6N; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bnypsc6N"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCA36C2BCB0;
	Tue, 12 May 2026 17:10:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778605849;
	bh=x3SjhD8X8/iDJLZ2bMuDpjGHWfgxlc/e3gmmPSdZDnQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bnypsc6NHATxHh6WFbKhURowap4JLB9wx7Fab0SHn2pM1xRmPSE3syZmHi2fwjcsA
	 yBn5fWYvP5E2aDCEnEmiINZGrhZ1I5ko5nI350Mmut9Q2AfF52Og14qA5zu0Z/BBQk
	 v9OWoW97+hsnkSFuUIiNTEqdPFvj0smPbNxYoZ/MNwom15ibeGM4mMXmJ+hEixfpTt
	 jxDFOjkXmqdMmru0C+enfJUg3uuo9/IXl7Zs/V9DRZc6FHPoJavEWaKsqSWAxw+Vtw
	 e+iUaTOb646iiGQKbeCSFUJcrsTQZaFOuHaNo1B2WeZkyYhgE2iWVnGU383Xxebax1
	 epXd0MLMUzLWw==
Date: Tue, 12 May 2026 18:10:40 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, Daniel Baluta <daniel.baluta@intel.com>,
 "open list:IIO SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open
 list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] iio: imu: kmx61: Fix TOCTOU race condition
Message-ID: <20260512181040.7578fbd0@jic23-huawei>
In-Reply-To: <CAKqfh0FyELOpgB1W+_nv4a1G1tuSjnVxbEFrUeR2+KCT2Q=-Ug@mail.gmail.com>
References: <20260512120356.40839-1-m32285159@gmail.com>
	<DIGSQPV2STJK.2S7C67L7I0RTJ@gmail.com>
	<CAHp75VdxUR0jdW2-k5SVGC22OK07VxHK2ORtVdSdniPWdcniPA@mail.gmail.com>
	<CAKqfh0FyELOpgB1W+_nv4a1G1tuSjnVxbEFrUeR2+KCT2Q=-Ug@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 12 May 2026 10:30:42 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, May 12, 2026 at 10:25=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> >
> > On Tue, May 12, 2026 at 6:17=E2=80=AFPM Maxwell Doose <m32285159@gmail.=
com> wrote: =20
> > >
> > > On Tue May 12, 2026 at 7:03 AM CDT, Maxwell Doose wrote: =20
> > > > A Time-of-check to Time-of-use race condition is present in
> > > > kmx61_write_event_config(). Move the mutex_lock() call above it to =
fix
> > > > it. =20
> >
> > I think you want to elaborate a bit more on this. Id est explain why
> > ev_enable_state needs to be protected. Not everybody is willing to go
> > to some site to read some AI reports and interpreted them.
> > =20
>=20
> Can do that for v2. I believe that it needs to be protected since
> later we set ev_enable_state to false (basically right after). Could
> be wrong of course, but Jonathan did confirm the TOCTOU.

I'd talk more about how we'd get a race.  If two calls enter the function
at the same time (which is easy to do) they may both pass this check before
getting to the lock.  Therefore we end up with at best pointless repeated
work, at worst a reference or similar count issue. You'd need to look close=
ly
at what is protected to be sure whether it benign waste of time or a real
bug.

Jonathan

>=20
> best regards,
> max
>=20
>=20
>=20
> > =20
> > > Reported-by: sashiko <sashiko-bot@kernel.org>
> > > Closes: https://sashiko.dev/#/patchset/20260507223337.48437-1-m322851=
59%40gmail.com =20
> >
> >
> > --
> > With Best Regards,
> > Andy Shevchenko =20

