Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1021274670;
	Tue, 26 May 2026 18:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779819710; cv=none; b=VRhLzU3N8Qn4Q2WmYE19G2010rz8F/NfikppHoQyVqCZgC8uuWZxzYbBROhybjAtrmXFJ97MSwzQGKO3+xdUlvOgiXBEerEl69mVqL9foTKD9TSQuH1DPGezURtUUeA6egDzFd46wGqcrjt5WE3vE92NHhT3ECY45AVZNOqHaug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779819710; c=relaxed/simple;
	bh=84DZTzMaewhFxz17leVJ09TeiuoMr47kK5qqsJqGnPc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h+x4YdAkTg0lYIUJhq+BUvhVNWL1XpjRf+DQdGKIF+P8+/jaSUlAW2xUBcyaJhgpASWhrFrdrwaSc/kQjUg9Vy/ycIZScnHy8xT25lnk1nOr5wKOGXYCzmvZLHwm/0yi7vMB2czbeBgVwY3pvWEFrq/HNmPYA/tyFjpIRuR7K+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CHYAq1Te; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CHYAq1Te"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A9E21F000E9;
	Tue, 26 May 2026 18:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779819708;
	bh=mwDURcH29UNrrhhFUNb4ohgokTlp7du4uQWiKso3qSM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CHYAq1TeCE2XCrSS5PKmBpOmb9Bnoj+ClF7PmZ66xFbrr3T0ytD0wmdi9pS+7kCa4
	 cbzjjM5JztNpHupVVRowhexQ38N20Hk8R85HDfWRNHBs7ntqbZ5i3+TluwtImpdgtj
	 otv3bi4W4uPu4y5cinBBkFEriurRt6JPdSJE71x2NeliaO1DPkv6IZVvpgmfb/peol
	 JM5hCr7Tceeo/zsnxJUMlZ0gG0v7ASKsH+Y/B8rD/YTKNagmWcrMxEeYdCCH6m0+1a
	 FluT0P4VkrmZH7mlBuB2Y0il8HChR7G4TjB6x9LPNBky37GAwP1Zx6+JvCg+C8srG0
	 /e6m0vNxv0D8w==
Date: Tue, 26 May 2026 19:21:41 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Dan Carpenter <error27@gmail.com>, Nuno =?UTF-8?B?U8Oh?=
 <nuno.sa@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] iio: core: fix uninitialized data in debugfs
Message-ID: <20260526192141.542015a9@jic23-huawei>
In-Reply-To: <CAKqfh0EEHCGct8F0VP1G+wv_NYUhqT3Bdfjos3NVGGbeAs09qw@mail.gmail.com>
References: <ahP3S9nOYN3pG-Fp@stanley.mountain>
	<CAKqfh0H0Z0xr4bAjctr9h95QTuEUTF1eCgBsRZVHn_KrkZZX3g@mail.gmail.com>
	<ahR1CUxzMkYDwVvO@stanley.mountain>
	<CAKqfh0EEHCGct8F0VP1G+wv_NYUhqT3Bdfjos3NVGGbeAs09qw@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 25 May 2026 15:08:14 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Mon, May 25, 2026 at 11:13=E2=80=AFAM Dan Carpenter <error27@gmail.com=
> wrote:
> >
> > On Mon, May 25, 2026 at 08:17:28AM -0500, Maxwell Doose wrote: =20
> > > Hi Dan,
> > >
> > > On Mon, May 25, 2026 at 2:19=E2=80=AFAM Dan Carpenter <error27@gmail.=
com> wrote: =20
> > > >
> > > > If *ppos is non-zero then simple_write_to_buffer() will not initial=
ize
> > > > the start of buf[].  Non zero values for *ppos aren't going to work
> > > > anyway.  Test for them at the start of the function and return -EIN=
VAL.
> > > >
> > > > Fixes: 6d5dd486c715 ("iio: core: make use of simple_write_to_buffer=
()")
> > > > Signed-off-by: Dan Carpenter <error27@gmail.com>
> > > > ---
> > > > The original copy_from_user() code was better:
> > > > https://staticthinking.wordpress.com/2026/05/23/simple_write_to_buf=
fer-is-complicated/
> > > > ---
> > > >  drivers/iio/industrialio-core.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > =20
> > >
> > > Codewise looks good but often times people will prefer
> > >
> > > if (*ppos || count >=3D sizeof(buf))
> > >
> > > over
> > >
> > > if (*ppos !=3D 0 || count >=3D sizeof(buf)) =20
> >
> > In this context, I feel like either is acceptable since zero
> > represents the number zero.  I have a blog about that which I have
> > been trying to promote.  #SEO
> >
> > https://staticthinking.wordpress.com/2024/02/20/when-to-use-0/
> > =20
>=20
> Interesting article, and I do agree that either is appropriate, just
> wanted to give you a heads up in case Jonathan or Andy ask you to
> change it.
>=20
> best regards,
> max
>=20
Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan

> > =20
> > >
> > > Regardless,
> > >
> > > Reviewed-by: Maxwell Doose <m32285159@gmail.com>
> > > =20
> >
> > Thanks.  And you're other comments with regards to -EINVAL and
> > -ENOSPC are obviously correct.
> >
> > regards,
> > dan carpenter
> > =20

