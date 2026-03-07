Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C548A1799F;
	Sat,  7 Mar 2026 12:11:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772885500; cv=none; b=GuLp8HfZmuuhbS2rOes/SeAFknqK2j+1jMYqMJrUstyO1uMuBczUkbmjnwA2s0Xv7b9Bv2YyiYGgN4PT+0crfGMnLhPlWRfMhSkRtUFjTPqDd13GGXHbFfirBy8bVxBFLW+qIXY5SD7f5N2HAou1CW3oAqXT3MTp1y228KMxF+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772885500; c=relaxed/simple;
	bh=tlwKVK7jqrNSc7XJVY6om1k8H4oL5gmn0vdYMB0iG8o=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h356phpCa1iELEs6rp+ix5K0d+o8WH2sVSaUR2C3f6eiIjEyFU/S1iVaHUfe/Gf3rs+G6f4yjpIip3d7kP7U/WzDtnpknRok0NKVEJyJCk8JZr7vSFR8H5GF09LSb8exjSHY+QoAIwC25TUAtvRZnYbmbwLZWCJdTkJ0BrERkfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEYXN09f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEYXN09f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9982AC2BC87;
	Sat,  7 Mar 2026 12:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772885500;
	bh=tlwKVK7jqrNSc7XJVY6om1k8H4oL5gmn0vdYMB0iG8o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=nEYXN09fjPRjU9JX7Ioauq3OkfakcnliolrqvzK5+xnzEIIK0Lysm+0kF6U6lwbjX
	 p3+rRnubDIbqgOzLCA1ejQfCcoYGdVAKFnB10uk7UX90XaIHjYwgQx19ybG4Pu/UyT
	 5l6GWR2ZittyENi86IzRCR18vSC2MS6o/kiJo5I3k7PDu1lrplvSlbGynXB5hU0osK
	 7rxHPQAwdG1x6lhk9XmGZC3UzMGsgzkOOq002eIYbL48AvEr7wQ+JKZeRYciT853CJ
	 qWKRG3ARMTThRg1pUqFcIYA4sQ8MLHxcw4yqmA8wcEtyzWgHOcINnAP8dNlUYKQgpM
	 z9NVcy0F/v14A==
Date: Sat, 7 Mar 2026 12:11:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: "Miclaus, Antoniu" <Antoniu.Miclaus@analog.com>, Andy Shevchenko
 <andy.shevchenko@gmail.com>, Lars-Peter Clausen <lars@metafoo.de>,
 "Hennerich, Michael" <Michael.Hennerich@analog.com>, David Lechner
 <dlechner@baylibre.com>, "Sa, Nuno" <Nuno.Sa@analog.com>, Andy Shevchenko
 <andy@kernel.org>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] iio: frequency: admv1013: fix NULL pointer
 dereference on str
Message-ID: <20260307121117.1429c342@jic23-huawei>
In-Reply-To: <aalSN21HiRi9g8x6@ashevche-desk.local>
References: <20260305091448.32052-1-antoniu.miclaus@analog.com>
	<CAHp75VdHz4SSyA78VYRvHrgUxGFAC6HeMmAuoxjS1twsTNTHkw@mail.gmail.com>
	<CY4PR03MB3399F7FB4FE82A606CCC333D9B7DA@CY4PR03MB3399.namprd03.prod.outlook.com>
	<aalSN21HiRi9g8x6@ashevche-desk.local>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 5 Mar 2026 11:51:51 +0200
Andy Shevchenko <andriy.shevchenko@intel.com> wrote:

> On Thu, Mar 05, 2026 at 09:44:35AM +0000, Miclaus, Antoniu wrote:
> > > -----Original Message-----
> > > From: Andy Shevchenko <andy.shevchenko@gmail.com>
> > > Sent: Thursday, March 5, 2026 11:36 AM
> > > On Thu, Mar 5, 2026 at 11:15=E2=80=AFAM Antoniu Miclaus
> > > <antoniu.miclaus@analog.com> wrote: =20
>=20
> ...
>=20
> > > > static int admv1013_init(struct admv1013_state *st, int vcm_uv) =20
> > >  =20
> > > > -       data =3D FIELD_PREP(ADMV1013_QUAD_SE_MODE_MSK, st-
> > > >quad_se_mode);
> > > > +       switch (st->quad_se_mode) {
> > > > +       case ADMV1013_SE_MODE_POS:
> > > > +               data =3D 6;
> > > > +               break;
> > > > +       case ADMV1013_SE_MODE_NEG:
> > > > +               data =3D 9;
> > > > +               break;
> > > > +       case ADMV1013_SE_MODE_DIFF:
> > > > +               data =3D 12;
> > > > +               break;
> > > > +       default:
> > > > +               return -EINVAL;
> > > > +       } =20
> > >=20
> > > Oh, I haven't realised that it can be done like this. I have in mind
> > > just to have a switch in the probe, so we don't need to do that again
> > > and again. Otherwise looks good to me. =20
> >=20
> > Hmm, the _init() function is called only in the probe. =20
>=20
> Ah, missed that. Then we are good.
>=20
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

Unfortunately we have some cleanup quite a way back in my tree for this cyc=
le
and I'm not keen to rebase to drop it all.  So we'll need to manually back =
port
this after it merges in the next merge window.

If we need to do it more urgently I'll need a patch against togreg-fixes. L=
et me know
if you think this is necessary.  For now I've applied it on the testing bra=
nch.

Jonathan

>=20
> > I think it makes a bit more sense to be here where we handle all the in=
itial
> > register configurations. =20
>=20
> Agree.
>=20

