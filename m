Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084C243367;
	Fri, 15 May 2026 14:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778857049; cv=none; b=UN1T+Nwa3DPn+xHYFrpJz578APbmqp62Ya7OnN1yk40Rec9KmKWmUN49wk/iDOsp+XlNgsyRe8jS5eRr+df42CzjanyD2KCIY/aHqudgqNgOi0cZQvCVHVItESobuh8F+JvQchdX4NT7HDf3tdupS/BxQ5hwNO/q10DGHYfXNKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778857049; c=relaxed/simple;
	bh=JZzKxJ1r+qlZ7vK3C1/mrOJqGcqM26bJHDsFFeepuz4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qYhGZpe8iHqjlxXaF5g+roCL+ftStu7Gvfo/+HLTAC9JlfQlwshjIjrVErVxu2RyRs961UyjBTNFPsJBUgj7ikKJiucq2i0sCXk56v6DDM/i+whkZ/XijN5UOQROTdeoc5b9S9cQoTlRuPzOPRG0MU6IU0B8jmcMCH+Ehw6HXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FLDkn/L7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FLDkn/L7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6260BC2BCB0;
	Fri, 15 May 2026 14:57:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778857049;
	bh=JZzKxJ1r+qlZ7vK3C1/mrOJqGcqM26bJHDsFFeepuz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=FLDkn/L7D1/Ok1ZZ+Kn98Rq6IZbv+ACdXGAeDBvOELrJZJFA/gjfxI+b6Ppfgs2IK
	 gTdUzLcOJ4m9bZMtVRiWXxLiu/hBRVbwQ5WsDLS3SE52QqGGVWUvAOzy7mlyEKdlde
	 XDELOiXwvQibXuhb++5H+X9R9EK5Wl0rZVcedZzQsDXuALVquZHQduPg+jbKy36XPT
	 B5U15lhdOvAssfKS2QYz9yy2MoJUDZzv/A+qw1cUUIFF1Fb/4dPSqoP99dPjzdAik2
	 R17ArTrh1UgKzH+BDh9PDqTFKDmvzAB22NYP4q/OSQ9xINGfApnpXzTVKlNqG6uRWo
	 m6AsbirhRV0XA==
Date: Fri, 15 May 2026 15:57:21 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Tomasz Duszynski <tduszyns@gmail.com>, David Lechner
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy
 Shevchenko <andy@kernel.org>, "open list:IIO SUBSYSTEM AND DRIVERS"
 <linux-iio@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] iio: chemical: sps30: Replace manual locking with
 RAII locking
Message-ID: <20260515155721.0097be34@jic23-huawei>
In-Reply-To: <CAKqfh0Fi3+jDP_UeKuTvdc2QkB3jttgRa=mjhgPPppc9sMkc4A@mail.gmail.com>
References: <20260515031343.56039-1-m32285159@gmail.com>
	<20260515151840.48a42705@jic23-huawei>
	<CAKqfh0Fi3+jDP_UeKuTvdc2QkB3jttgRa=mjhgPPppc9sMkc4A@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 09:35:03 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Fri, May 15, 2026 at 9:18=E2=80=AFAM Jonathan Cameron <jic23@kernel.or=
g> wrote:
> >
> > On Thu, 14 May 2026 22:13:42 -0500
> > Maxwell Doose <m32285159@gmail.com> wrote:
> > =20
> > > Replace manual mutex_lock() and mutex_unlock() calls with the much ne=
wer
> > > guard(mutex)() and scoped_guard() macros to enable RAII patterns,
> > > modernize the driver, and to increase readability.
> > >
> > > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > > ---
> > > v2:
> > >  - Switch over some scoped_guard()s to guard(mutex)() per David's
> > >    suggestion.
> > >  - Remove redundant whitespace per Andy's suggestion.
> > >  - Add new wrapper sps30_do_meas() per Andy's suggestion (see commit
> > >    message).
> > >  - Add Joshua's RB
> > >    (link: https://lore.kernel.org/linux-iio/CAKqfh0FWig8mRR-xhvnfcFeS=
inR6RySyPaf9Gbpb6WU+diiiUQ@mail.gmail.com/T/#t)
> > >
> > > v3:
> > >  - Remove sps30_do_meas() wrapper per Andy's suggestion. =20
> > I think this wasn't what Andy meant. I think he meant just
> > push the guard into the the function you were wrapping.
> > =20
>=20
> TBH I'm fairly confused on what Andy wanted in terms of "what do I
> wrap". If he wants me to put the guard()() into the function call
> itself I can do that but see the (ps) in my other email.

I guess you mean:
Andy:
"Ah, I was under impression that this is (unlocked version) is used somewhe=
re
else. Since it's not the case, the wrapper is not needed, just use guard()()
in the original code."

Could be read either way but I think he'll be fine with it in sps30_do_meas=
()
even if the other direction was what he was thinking of.

J


>=20
> > >  - Remove Joshua's RB (major changes).
> > >
> > >  drivers/iio/chemical/sps30.c | 29 +++++++++++++----------------
> > >  1 file changed, 13 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/drivers/iio/chemical/sps30.c b/drivers/iio/chemical/sps3=
0.c
> > > index a934bf0298dd..9cb201cf0f15 100644
> > > --- a/drivers/iio/chemical/sps30.c
> > > +++ b/drivers/iio/chemical/sps30.c
> > > @@ -5,6 +5,7 @@
> > >   * Copyright (c) Tomasz Duszynski <tduszyns@gmail.com>
> > >   */
> > >
> > > +#include <linux/cleanup.h>
> > >  #include <linux/crc8.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/i2c.h>
> > > @@ -111,9 +112,8 @@ static irqreturn_t sps30_trigger_handler(int irq,=
 void *p)
> > >               aligned_s64 ts;
> > >       } scan;
> > >
> > > -     mutex_lock(&state->lock);
> > > -     ret =3D sps30_do_meas(state, scan.data, ARRAY_SIZE(scan.data));
> > > -     mutex_unlock(&state->lock);
> > > +     scoped_guard(mutex, &state->lock)
> > > +             ret =3D sps30_do_meas(state, scan.data, ARRAY_SIZE(scan=
.data)); =20
> > Every call to sps30_do_meas() is done with the lock held just over that=
 call.
> >
> > So just move the lock (as a guard) into sps30_do_meas().
> >
> > I think that's what Andy was suggesting in v2 review, but maybe not!
> > =20
>=20
> Perhaps, we'll see I suppose.
>=20
> best regards,
> max
>=20
>=20
> > =20
> > >       if (ret)
> > >               goto err;
> > > =20
>=20

