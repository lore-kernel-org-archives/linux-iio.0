Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 244DE23A99F;
	Fri, 15 May 2026 14:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855597; cv=none; b=iG0pwMCI1zNZVIMUQccbP/pCO5dUh4BVn0gzbvVPWSgCb77R/OH8o68ED5Rms02ZObwJENTOsEbNgD4hC1HbRCeS5WgDHV5ubQ0m//p8/QylDiyFB0iBF1ddWKluz4tHkFKJT5t0nT5MCgMDbZ4nSVUoDHMOpuZmRepE2E4ZxTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855597; c=relaxed/simple;
	bh=b7K22fBrDRjX+dFafBF2IkKKKy3zgtXAEFFW0KHMvJo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hZ/OAdZIYufu3NepE+M2U37hZebU3EAcT1WdxVP4FPbxHSebHF9+erBsnkO3jJ9roDBcKYm0GGIbsNf5X4eHqYLmSu7v0E+2Oj0Ta6VlYvXUwGFt5ZOvTqNkJevuWWlBjs/n1WLZFVP/jrosuIqrpJs/FIdUhYnrGJLbA7ZuPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W7jQTq/b; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W7jQTq/b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 372EFC2BCB0;
	Fri, 15 May 2026 14:33:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778855596;
	bh=b7K22fBrDRjX+dFafBF2IkKKKy3zgtXAEFFW0KHMvJo=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=W7jQTq/bcboPWQDCcakZwTX44IUXl64cVaKCTolg9WxBIuzXTP6cz5TvCoajdfHJB
	 AvDez7BUo1g355WqiHFG4ntN5Yumf9TztCt8Md30QhUh73jqihrKG7+NmWDegEfNhF
	 njQy7hF4useaY4w7uiV9NHQuJThcZoA7xieT4mJiLBKG2D0W+kexMWry7gsl1ReGsz
	 lTO+ZRKizHNfEjcbxqeP2f7myTlYPblLo09UUp9jJhnOUkDTOorOL+noLhJmUe7hYd
	 4y3zbWLs1U1xbUZgHYEg2n2jOKBU360L7z0S/PsLG0laIOGdnncIYzAVLYfhye5pLQ
	 RczTPKuySWS3Q==
Date: Fri, 15 May 2026 15:33:07 +0100
From: Jonathan Cameron <jic23@kernel.org>
To: "Javier Carrasco" <javier.carrasco.cruz@gmail.com>
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
 <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Sam Daly"
 <sam@samdaly.ie>, "stable" <stable@kernel.org>, "David Lechner"
 <dlechner@baylibre.com>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, "Andy
 Shevchenko" <andy@kernel.org>
Subject: Re: [PATCH 2/3] iio: light: veml6075: add bounds check to
 veml6075_it_ms index
Message-ID: <20260515153236.1acf1ca4@jic23-huawei>
In-Reply-To: <DIIN3H0YMILE.3PFQWDK2BULIT@gmail.com>
References: <2026051420-strudel-graves-f6cd@gregkh>
	<2026051422-hungry-dolly-0250@gregkh>
	<DIIN3H0YMILE.3PFQWDK2BULIT@gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 May 2026 08:17:18 +1300
"Javier Carrasco" <javier.carrasco.cruz@gmail.com> wrote:

> On Fri May 15, 2026 at 5:23 AM +13, Greg Kroah-Hartman wrote:
> > From: Sam Daly <sam@samdaly.ie>
> >
> > veml6075_it_ms has 5 elements but VEML6075_CONF_IT can yield
> > values 0-7. If it returns a value >=3D 5, this causes an
> > out-of-bounds array access. Add a bounds check and return
> > -EINVAL if the index is out of range.

I'd prefer it if this sort of change called out that we don't expect
to ever see those values except when we have bus corruption or
a broken device.  Good to protect against but that info might help
folk decide whether to backport or not.

I'll add a note whilst applying.  Applied to the fixes-togreg
branch of iio.git.  I also rewrapped the description as 60 chars
is rather short.

Applied

Jonathan

> >
> > Assisted-by: gkh_clanker_2000
> > Cc: stable <stable@kernel.org>
> > Cc: Javier Carrasco <javier.carrasco.cruz@gmail.com>
> > Cc: Jonathan Cameron <jic23@kernel.org>
> > Cc: David Lechner <dlechner@baylibre.com>
> > Cc: "Nuno S=C3=A1" <nuno.sa@analog.com>
> > Cc: Andy Shevchenko <andy@kernel.org>
> > Signed-off-by: Sam Daly <sam@samdaly.ie>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >  drivers/iio/light/veml6075.c | 8 ++++++--
> >  1 file changed, 6 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/iio/light/veml6075.c b/drivers/iio/light/veml6075.c
> > index edbb43407054..f7eb159e5cb4 100644
> > --- a/drivers/iio/light/veml6075.c
> > +++ b/drivers/iio/light/veml6075.c
> > @@ -100,7 +100,7 @@ static const struct iio_chan_spec veml6075_channels=
[] =3D {
> >
> >  static int veml6075_request_measurement(struct veml6075_data *data)
> >  {
> > -	int ret, conf, int_time;
> > +	int ret, conf, int_time, int_index;
> >
> >  	ret =3D regmap_read(data->regmap, VEML6075_CMD_CONF, &conf);
> >  	if (ret < 0)
> > @@ -117,7 +117,11 @@ static int veml6075_request_measurement(struct vem=
l6075_data *data)
> >  	 * time for all possible configurations. Using a 1.50 factor simplifi=
es
> >  	 * operations and ensures reliability under all circumstances.
> >  	 */
> > -	int_time =3D veml6075_it_ms[FIELD_GET(VEML6075_CONF_IT, conf)];
> > +	int_index =3D FIELD_GET(VEML6075_CONF_IT, conf);
> > +	if (int_index >=3D ARRAY_SIZE(veml6075_it_ms))
> > +		return -EINVAL;
> > +
> > +	int_time =3D veml6075_it_ms[int_index];
> >  	msleep(int_time + (int_time / 2));
> >
> >  	/* shutdown again, data registers are still accessible */ =20
>=20
> Reviewed-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>

