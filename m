Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36A734D90C6;
	Fri,  5 Jun 2026 11:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780660779; cv=none; b=AZUKEDesfLVAG4SOgXeaSYywDPvuD99PfnDOxe9cQUzaOn1GN0OS+HBYBRTF8LZggfCw04vQgFHYwrMDeB/iFSG4KFddSCI4JGuf30+eg8Ay1bmGTZvwVtZ7dtc8TBEakpDttxEnk0S4/sLrZhOP2zM30SyexCmByi22M6C+CNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780660779; c=relaxed/simple;
	bh=MHeDkHVNARep1rGSu9K1dTE7HHROrEwzMv+R8TsmWIE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C6B25BFQVkSPmFbZLCATwOzGynEoZCvHCzAiiIDJipB9CTkXehnCUeSwuGSYX43zulGPmlqEPy/m/uKhLx/bKYenqCyBSjqHhH4SAAi9YRqQ8IgABr3oWjkV54vjnNOynwdyoafzPSp46hG/ucvdVuqf/9H6Rm+Lp4Pcghr2F78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cay+2PVe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cay+2PVe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6E8701F00893;
	Fri,  5 Jun 2026 11:59:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780660777;
	bh=YOfhuG5v3SYO58NXAlFPpt999HG8o3JtyTYa1ygEBR4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cay+2PVe/O1jYP3b5q7Yxbwjq5/YZr3nL3WROhIWKTYV7pBEn5fpta8DgWuWZjMMq
	 4xttfUmFix4J9NwKXb8ADEYubUxp4JHCXemzaQzM9IOFfnonQddrLyMy9KQbPnOQzl
	 YBlF7AHZ3jAzUFsR5TGDqj3u4QkykI5Jj2h3xCpv+pSFCDzFtIG9bn1oCBZJzzijZJ
	 P/wyPQ9jA3vItcAmrOtLUh893uaypcx0rZTLAtMliABcp77MNntJ511Y805359a+eP
	 ee2qxY0S2mHTf/t9D64xa9kcSv7iHGtoRzFXmMsMbstArkoKo3ZXHQS33Ma4UfZ9tR
	 hPSlww+d5RSGQ==
Date: Fri, 5 Jun 2026 12:59:29 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: David Lechner <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, "open list:IIO
 SUBSYSTEM AND DRIVERS" <linux-iio@vger.kernel.org>, open list
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: chemical: scd30: Use devm_mutex_init() over
 non-devm mutex_init()
Message-ID: <20260605125929.2082dfc2@jic23-huawei>
In-Reply-To: <CAKqfh0FU5g96PjcXcz_hPafZR2uLq3xX2V-yyraHqPXX8RBRDw@mail.gmail.com>
References: <20260604131518.27323-2-m32285159@gmail.com>
	<CAMknhBGKHdUV10mLz3P_eH3mg9WU5kHw-pGqoRWfVGyvD2HwOA@mail.gmail.com>
	<CAKqfh0FU5g96PjcXcz_hPafZR2uLq3xX2V-yyraHqPXX8RBRDw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 4 Jun 2026 11:21:07 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Thu, Jun 4, 2026 at 11:20=E2=80=AFAM David Lechner <dlechner@baylibre.=
com> wrote:
> >
> > On Thu, Jun 4, 2026 at 3:17=E2=80=AFPM Maxwell Doose <m32285159@gmail.c=
om> wrote: =20
> > >
> > > The current code uses mutex_init() instead of devm_mutex_init(), which
> > > is incorrect as the rest of the file uses the devm automatic resource
> > > management API. Fix this so that the mutex is set up in the same way =
as
> > > the rest of the device data structure.
> > >
> > > Signed-off-by: Maxwell Doose <m32285159@gmail.com>
> > > ---
> > >  v2:
> > >  - Drop fixes tag per Jonathan's suggestion.
> > >  - Replace dev_err_probe() with return -ENOMEM per Jonathan and Andy's
> > >    suggestions.
> > >
> > >  drivers/iio/chemical/scd30_core.c | 5 ++++-
> > >  1 file changed, 4 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical=
/scd30_core.c
> > > index db5cc295aeab..198add58affd 100644
> > > --- a/drivers/iio/chemical/scd30_core.c
> > > +++ b/drivers/iio/chemical/scd30_core.c
> > > @@ -714,7 +714,10 @@ int scd30_probe(struct device *dev, int irq, con=
st char *name, void *priv,
> > >         state->pressure_comp =3D SCD30_PRESSURE_COMP_DEFAULT;
> > >         state->meas_interval =3D SCD30_MEAS_INTERVAL_DEFAULT;
> > >         state->command =3D command;
> > > -       mutex_init(&state->lock);
> > > +       ret =3D devm_mutex_init(dev, &state->lock);
> > > +       if (ret)
> > > +               return -ENOMEM; =20
> >
> > Why are we ignoring ret?
> >
> > I would expect:
> >
> >               return ret;
> > =20
>=20
> Gah, I must've Jonathan's + Andy's comments get to my head (He said it
> should likely only return -ENOMEM) :(
> I don't know if he'll want to tweak while applying or if I should just
> go back and resubmit.

IIO is effectively closed for this cycle so plenty of time and I'm lazy
so please send a v3.

Jonathan
