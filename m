Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8759F3B3BEB;
	Tue, 28 Apr 2026 15:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777389908; cv=none; b=nq/xbVlR69i2Uj9RTNlCERZSCkVbEKcTXJCkCtMYdeIAR4nDpjoJfdqgrLMLZ5BHN2jBZAuosh0EBmo7+3m/TS2vqKOlF03BKM6sxBqfeyM13P03kn9/d+Y7DMOYRq8/5Q/s4WNA6pD4t0Yjwzuey9rxNz2IojMoOwZGhxxPLdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777389908; c=relaxed/simple;
	bh=gjsJokhJuKLrlSoOvvzPJEffQvsEfvzJOVIwfA2jOjw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZOb4vmxExYlLo/pOkeO8QfVhoofkaPxCLZarjAsWpCKEZStjhYhFy6VbGUOH/HlGDAj3XBkXEEg6QHe11jsD7QS1fMsMGJWhtvTyG7GAw5VNoz4RA0WoJTZI1+oZ8WSQZxgVyPRC0/XOwnvexFUD31kZxvf7WTUVtI+Box2bb6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jaulDkL6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jaulDkL6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C40ECC2BCAF;
	Tue, 28 Apr 2026 15:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777389908;
	bh=gjsJokhJuKLrlSoOvvzPJEffQvsEfvzJOVIwfA2jOjw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=jaulDkL6dMsbsqEfefahJe4+t/aCGz5uxV6ckXn9Vr2wxZ1yyrzk9CGG0OAQerU3t
	 oCYKtDWgqnwp+xwjTaAW6Yu1KXwgJkR/+5moNza4xkDvOMNTI2RnRQNZakAYXvTSqi
	 QFkxmm9+WZ6n3fY09+0YwMo217UMOQMIE4b10yYcZYlr7W9lv38AW+e/TOSxSfTsor
	 LnYJzb+epAXW6/UHwICnSNvNyuVoTr6920uEegiQyrstML4MM030buPDysMx33sJc2
	 Vuz8qcya1BF+MyT5VzWb7CunbPcyNC2CeyiGOXg5U6mnhSxWGTyp971r5CGS3CYn9x
	 8SK9jXbtwKCKQ==
Date: Tue, 28 Apr 2026 16:24:58 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: Maxwell Doose <m32285159@gmail.com>
Cc: Andy Shevchenko <andriy.shevchenko@intel.com>,
 songqiang1304521@gmail.com, dlechner@baylibre.com, nuno.sa@analog.com,
 andy@kernel.org, linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] iio: magnetometer: rm3100: Use scoped_guard() in
 rm3100_get_samp_freq()
Message-ID: <20260428162458.09f28de7@jic23-huawei>
In-Reply-To: <CAKqfh0HfbUkAFDpf6vmBba+JGRafemoP0HeVy5hzzQB4=Y94Ag@mail.gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
	<20260428124644.49707-3-m32285159@gmail.com>
	<afC1mdCZGZKHQx5V@ashevche-desk.local>
	<CAKqfh0HfbUkAFDpf6vmBba+JGRafemoP0HeVy5hzzQB4=Y94Ag@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Tue, 28 Apr 2026 08:59:48 -0500
Maxwell Doose <m32285159@gmail.com> wrote:

> On Tue, Apr 28, 2026 at 8:26=E2=80=AFAM Andy Shevchenko
> <andriy.shevchenko@intel.com> wrote:
>=20
> > > -     mutex_lock(&data->lock);
> > > -     ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
> > > -     mutex_unlock(&data->lock);
> > > -     if (ret < 0)
> > > -             return ret;
> > > +     scoped_guard(mutex, &data->lock) {
> > > +             ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp=
); =20
> > =20
> > > + =20
> >
> > Redundant blank line as ret is defined elsewhere. =20
>=20
> Shoot. I'm away right now but once I get back I can fix that.

Given the function is:
static int rm3100_get_samp_freq(struct rm3100_data *data, int *val, int *va=
l2)
{
	unsigned int tmp;
	int ret;

	mutex_lock(&data->lock);
	ret =3D regmap_read(data->regmap, RM3100_REG_TMRC, &tmp);
	mutex_unlock(&data->lock);
	if (ret < 0)
		return ret;
	*val =3D rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][0];
	*val2 =3D rm3100_samp_rates[tmp - RM3100_TMRC_OFFSET][1];

	return IIO_VAL_INT_PLUS_MICRO;
}

I'd just use a guard and not worry about two value lookups from static cons=
t data
being under the guard()

Why is this series broken up into lots of patches doing same type of change
in different places?  This could definitely be combined with the previous p=
atch.

Thanks,

Jonathan

>=20
> best regards,
> maxwell

