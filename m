Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3E2194C96;
	Mon, 21 Sep 2026 03:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789960645; cv=none; b=I+1L1Z0oh4n7UQyHe4L10uQ35r3l1pL+US7FGEGVuUR+DEGO2TKaB4M4EWm4OWsJB+0/O4k0PnKo0zKMtPgtW1WUxpXdbMm3AbU+RcnkDHE8BK8fud9m/R4eZCatdImhiUOzm4OlSadLxNWbZbuJY1LTwDkGtldh/dBDWd6q2gU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789960645; c=relaxed/simple;
	bh=FbU4u87YBtEtqra4Ro3tZTiAi07OG8qg7CLx6bEEPgw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I0o8wJdxTnYNz6jdf0t5ONtzwjzX003T7oStYZy5ant/faflbie8IM2dwKr4KUEQEUey6HkNCM6IrqJK4dLCjmyXQOdX4AjVtrz7i2i3QIdl5iSXmgA3Bho4nw/b96a0cKF1FCigHcbPTZcTQhGLj4+8obGIUgT93Sp5MyZfA6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmKB9wSh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmKB9wSh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 927911F000FF;
	Mon, 21 Sep 2026 03:17:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789960644;
	bh=yz4V0ASGqQx8wQ3hbOXUNjDxyfBR4VVRbKDacNTfN4I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lmKB9wSh/TjLvN3BAvUgKjNyy7WkdFLoaN/KSc7GG7NyKKBa9kRzYjYvBycl7L/Qs
	 QA7Kq9eGQJEJOTuDZXBhPwB9602md9EU+umAny1vyhS9X6E5BkLb3UmIZ6kYjYckHv
	 hGFR/gq3nJ5dhInNZXS9EeXXazNXw5o/bRBLt6Lnw0oxii/U2Jkb+Yar6rIhmOVcLq
	 fByizTWWaMFXrhq5+62F+EA92VWKHAobE2dTdxGx0jylkgq5zGCCQP+kmhcIKum4iQ
	 LpDl1kOhpNPud7Zcc98P2VqOj5zKTrD0ZH+dFdQpvWnQaMhd2/SpBwfGfr/1VFRiR+
	 1YT2IyuesQGmQ==
Date: Mon, 21 Sep 2026 04:17:18 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Salah Triki <salah.triki@gmail.com>
Cc: Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Michael Hennerich
 <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, Andy
 Shevchenko <andy@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] iio: adc: ad4030: fix invalid oversampling_ratio
 validation
Message-ID: <20260921041718.568b6b64@jic23-hlaptop>
In-Reply-To: <20260906191112.7d554140@jic23-huawei>
References: <20260903114337.63541-1-salah.triki@gmail.com>
	<20260906191112.7d554140@jic23-huawei>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Sun, 6 Sep 2026 19:11:12 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Thu,  3 Sep 2026 12:43:09 +0100
> Salah Triki <salah.triki@gmail.com> wrote:
>=20
> > In ad4030_set_avg_frame_len(), the logarithm is calculated before input
> > validation. Passing zero or negative values leads to an undefined result
> > from ilog2().
> >=20
> > Validate that the input is strictly positive prior to computing its
> > logarithm.
> >=20
> > Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
> > Assisted-by: Claude:claude-sonnet-5
> > Signed-off-by: Salah Triki <salah.triki@gmail.com> =20
>=20
> Given it is an Analog Devices part and Nuno is usually quick to reply
> I'm going to wait for a tag from them before picking this up.

Nuno had looked at v4 and I don't think raised any particular
problems so I've applied this one to the fixes-togreg branch of iio.git
and marked it for stable.

Thanks
Jonathan

>=20
> Thanks
>=20
> Jonathan
>=20
> > ---
> > Changes in v5:
> >   - Split validation into two distinct checks with explanatory comments
> >   (per Andy Shevchenko and Nuno S=C3=A1).
> >   - Used 'avg_val < 1' to explicitly reject invalid values for ilog2()
> >   (per Andy Shevchenko and Nuno S=C3=A1).
> >   - Tightened commit log description.
> >=20
> > Changes in v4:
> >   - Reordered local variables to enforce strict reversed Christmas tree=
 layout
> >   (per Andy Shevchenko).
> >   - Rephrased commit log in plain English without C-specific terms
> >   (per Andy Shevchenko).
> >   - Converted AI assistance note into a formal Assisted-by tag
> >   (per Andy Shevchenko).
> >=20
> > Changes in v3:
> >   - Dropped the !is_power_of_2() check to preserve standard IIO attribu=
te
> >    rounding behavior, per feedback from David Lechner and Jonathan Came=
ron.
> >=20
> > Changes in v2:
> >   - Added note stating the issue was identified with assistance from
> >   Claude AI and verified manually.
> >   - Removed initialization of avg_log2 at declaration.
> >=20
> >  drivers/iio/adc/ad4030.c | 11 +++++++++--
> >  1 file changed, 9 insertions(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
> > index 9c5f19321e3b..f1499b4792b5 100644
> > --- a/drivers/iio/adc/ad4030.c
> > +++ b/drivers/iio/adc/ad4030.c
> > @@ -746,14 +746,21 @@ static int ad4030_set_chan_calibbias(struct iio_d=
ev *indio_dev,
> >  static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
> >  {
> >  	struct ad4030_state *st =3D iio_priv(dev);
> > -	unsigned int avg_log2 =3D ilog2(avg_val);
> >  	unsigned int last_avg_idx =3D ARRAY_SIZE(ad4030_average_modes) - 1;
> > +	unsigned int avg_log2;
> >  	int freq_hz;
> >  	int ret;
> > =20
> > -	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
> > +	/* Reject unsupported modes */
> > +	if (avg_val > ad4030_average_modes[last_avg_idx])
> > +		return -EINVAL;
> > +
> > +	/* Avoid invalid values for logarithm since it's undefined */
> > +	if (avg_val < 1)
> >  		return -EINVAL;
> > =20
> > +	avg_log2 =3D ilog2(avg_val);
> > +
> >  	if (st->offload_trigger) {
> >  		/*
> >  		 * The sample averaging and sampling frequency configurations =20
>=20
>=20

