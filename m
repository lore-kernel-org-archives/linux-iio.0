Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794620516;
	b=w1PP0LRbuQldW6D/0sWhjG+BZmbw9IZBP8QVQEUpFNiyx8jWgfqCxoCS1I+XXC6dSRiT
	 MZ+XRjitbYVSim7+UxLzd5Uj6FAtRJqYYuDXrGHtt5ZZA2dtvaL6yWLf2jGJKFzivIwhA
	 Yf1u3rIuyAyYMuRI7v4+J4rj/8af+hSnmyfn6diTTjhB2Dksn4+lUtlrgb6xiQeD/OnKn
	 Q06OkIYZs+LKZEM7EL9PVzOEjDO1Ojl3w3P7eqZrEpDxk1yTBLhM6FBSSx0eVWFqY1b8Z
	 865mwn9E2x7ucKTpZ//WEg6IS5JfrBcVUUl+50h9WmePAafL/XGUUfcxMrb8nRKk4Hg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794620516;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=/cwBNOHhCh9WkKodhyimKk096BYDm/xvZ76f3+IyMdk=;
	b=y95JTUaNQNK757Nm858cItXjs3haxNbQ//sk3PeP4ZvEUoIucmtYnU7usXXHEQ2T5qbS
	 f7Ka0lxGNxhKKg71WZE/9i5wzkWesMTZDeNZ+ik98FaaZdSW/uU711yscrtHYyRSRj03m
	 j+DxomJ8fqq5NEGW+kopAI3FiYplxJsNqAJlv965r9wKRG4z4Dbb36tg9JURsblTzAiK2
	 ww/nEVhNIhyzN2PXJE3IQ5EVLogS6ftY4Cbz/KPXYRunXg5QCV/qTF4oL0UoxXVYv/0aw
	 b6y8NU3r1WHLQP65Enas0O4lqWK/2AcvZNQem0ycr07HGnryo8wLnFC4B9j6ofP5h1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="XLW/sWfF";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C65606A323;
	Sat, 14 Nov 2026 01:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLW/sWfF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E30131F000C4;
	Sat, 14 Nov 2026 01:41:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794620515;
	bh=/cwBNOHhCh9WkKodhyimKk096BYDm/xvZ76f3+IyMdk=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=XLW/sWfFHdBoUFkRkVKGs4aSzLwUSH6gRiRV/42lAUUZ/5UV2ihGVUx1rD/p3gxlI
	 Od+ZMAMckPl+uqti6ARuMAeAXTpl1ut/B2oUympFuiWw402deupJKKYJBsAnsWFIND
	 cGUBYWI7GY0g84EEZ2sma/Zbo5eMk7fJpnJKNmKsubPrdxhkG7gidUEklbyEq7vO7j
	 U0eakItCafEBfAS3Dmfwf84zOup8jsDp+E/iiSld5KnK+XI7SDm3jXv/m/1tni7yvP
	 JJQEAvN/0Hjyl5kQqJGaieVL+Z8NaFTElXFDyN+Ss891UFzTamxBnUhBY9fWpYSjr9
	 SoyBIeKT+uP6A==
Date: Sat, 14 Nov 2026 01:41:49 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: Zhu Jun <zhujun2@cmss.chinamobile.com>, dlechner@baylibre.com,
 nuno.sa@analog.com, andy@kernel.org, linux-iio@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] iio: potentiostat: lmp91000: Handle configuration
 write errors
Message-ID: <20261114014149.21dbc4d2@jic23-hlaptop>
In-Reply-To: <CAHp75Vfy97JHMaURigbF92z7Eypfuny8PUk94=-43S6p6PhknQ@mail.gmail.com>
References: <20261113082546.176582-1-zhujun2@cmss.chinamobile.com>
	<CAHp75VeOjqWoEM36OMgtiiwu3XWiu5wfJf59vYFuGSApbWpPaA@mail.gmail.com>
	<CAHp75Vfy97JHMaURigbF92z7Eypfuny8PUk94=-43S6p6PhknQ@mail.gmail.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-pc-linux-gnu)
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 13 Nov 2026 10:47:32 +0200
Andy Shevchenko <andy.shevchenko@gmail.com> wrote:

> On Fri, Nov 13, 2026 at 10:41=E2=80=AFAM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Nov 13, 2026 at 10:25=E2=80=AFAM Zhu Jun <zhujun2@cmss.chinamob=
ile.com> wrote: =20
>=20
> ...
>=20
> > > Check the configuration writes and return the first error. After a
> > > successful unlock, attempt to restore write protection even if a
> > > configuration write fails. Return a relock error when both configurat=
ion
> > > writes succeeded.
> > >
> > > lmp91000_probe() returns either error before registering the IIO devi=
ce,
> > > so the caller does not need to distinguish their source. Preserve the
> > > configuration error if restoring write protection also fails. =20
>=20
> Btw, this is still unclear. See below.
>=20
> ...
>=20
> > > -       regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> > > -       regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> > > -       regmap_write(data->regmap, LMP91000_REG_REFCN,
> > > -                    LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_REFCN_=
50_ZERO);
> > > +       ret =3D regmap_write(data->regmap, LMP91000_REG_LOCK, 0);
> > > +       if (ret)
> > > +               return ret;
> > > +
> > > +       ret =3D regmap_write(data->regmap, LMP91000_REG_TIACN, reg);
> > > +       if (ret)
> > > +               goto relock;
> > > +
> > > +       ret =3D regmap_write(data->regmap, LMP91000_REG_REFCN,
> > > +                          LMP91000_REG_REFCN_EXT_REF | LMP91000_REG_=
REFCN_50_ZERO);
> > > +       if (ret)
> > > +               goto relock;
> > > +
> > > +       return regmap_write(data->regmap, LMP91000_REG_LOCK, 1);
> > > +
> > > +relock:
> > >         regmap_write(data->regmap, LMP91000_REG_LOCK, 1); =20
> >
> > What's the point of duplicating this?
> > Before label you can easily do
> >
> >   ret =3D 0;
> >
> > relock:
> >   ... =20
>=20
> Ah, okay, I see that the relock error is returned only on success of
> the configuration update. Why is this inconsistency? Really, you need
> to elaborate first on what the caller is suppose to do when
> 1) unlock failed;
> 2) unlock was successful, but configuration was failed;
> 3) unlock and configuration was successful, but relock failed.
>=20
> In all of these cases the user gets an error, but it doesn't know
> which stage was failed. What is the caller supposed to do?
>=20
> No need to send a new patch, let's keep discussion here to understand
> the code flow better.

I think I requested this flow.  I didn't like v1 doing some dance
with ret2 and only return that if ret wasn't set.  Argument of the patch is
that we must make sure to unlock even on error.


>=20
> > > -       return 0;
> > > +       return ret;
> > >  } =20
>=20
>=20

