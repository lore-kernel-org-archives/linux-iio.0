Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794704979;
	b=14TSXLyHfuF88MMEAYKXqts1Y0Ij7WOuFAKtpUDHjBy46C0Lt46ZW/uTQ58QM/3KZgfz
	 Ee7U5ghQp7IimVm1u96s5otPM+yoW/HH+F5tgFNlhUpi8WsWpdk4y8ADP4epKhVz1uJQP
	 2BUxNrQmRYw9d7d+sMnALsmdp/c4Sd0QMpW6FE1S85ia1G6+FNpimhZYKQtZd0UeIQ1aY
	 eWqaRIqDRDLgFaa4OW1G1KJwJIJ0g4LUSiVwsdcByaD3XXhTorV/EnFMr4GlwKnysxGts
	 H7s7nY/+t74/XSODLZYoHDfHcOdo8YkpS0V3Ej9nrRiQ3DlJv/+4Wzsz5tgz32HnBxw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794704979;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=svpEi0HS4YJE5nsDpTP/KMKZMCJ2JXKCnWaboHf80CY=;
	b=WeSUukEIy/aDG9F4RupTgouVY03KshWdB1yPSA3ClFdIImBqBCeyEILxAPsf/5pBLquL
	 3Mn18EXrfaVY4JE0NPSarQ+Ios4ZtzXu58979TuDV5gR/JS2EPpOaQjkqOiO8nb/wHLVx
	 X1fvrilxcNRx6umWn3MgL9CSDQcQZ4WQzVkrVieyTdrm7INw0TRSMS172y0GKDVbz82ms
	 rosUZjq2trrk3SW+E6AnuMZbe6VuMNNeHzG/F3XfhYA3c++n8T0KE2Vv7An3fjrpRSdoU
	 IqgevuiyYvrpizo1XBbX7HWafR0TEy0O4T5TJ+t0Mzs3iAhV+6Z5g0RhYxknn+E7nDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY1GzaeP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B23606A329;
	Sun, 15 Nov 2026 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jY1GzaeP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71F1A1F000C4;
	Sun, 15 Nov 2026 01:09:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794704979;
	bh=svpEi0HS4YJE5nsDpTP/KMKZMCJ2JXKCnWaboHf80CY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=jY1GzaePZizjRqOefyBJ4GMGCqY+2fpjShHHPX0sIyevABUK30EnshdqUzrfapr8q
	 wVTaJkwOmPy64OpeuZ3Rh/RZxfJ4D2ONn4I9ZV/bZH21r8ke9wkYNiMOSjga8LDS8X
	 sq3T/3kNQ4RblY/Z2d3Pav7Krc9kKg3SqihdeqeF545UJkFsOjwDT78MpAj6Y0iJn1
	 MKdaXbN8dEOp/b0CsnD1N8IajZRafzBLIQDLq27CVGa38HTHAM8MNYrbx8VF8AakTd
	 zboUasZ78TtdUgQ9CldzfwtFPRGG+F60gm0YMCR81gp35WFlAFfK2ENr3NVgHe/nce
	 ulQqa95ahGgNg==
Date: Sun, 15 Nov 2026 01:09:31 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jernej =?UTF-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
Cc: linux-sunxi@lists.linux.dev, linux-iio@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Andy Shevchenko <andy@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>, David
 Lechner <dlechner@baylibre.com>, Giorgi Tchankvetadze
 <giorgitchankvetadze1997@gmail.com>, Michal Piekos
 <michal.piekos@mmpsystems.pl>, Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
 Philipp Zabel <p.zabel@pengutronix.de>, Samuel Holland
 <samuel@sholland.org>, Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?=
 <u.kleine-koenig@baylibre.com>, Markus Elfring <Markus.Elfring@web.de>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Felix
 Gu <ustc.gu@gmail.com>
Subject: Re: [PATCH] iio: adc: sun20i-gpadc: Use
 devm_reset_control_get_exclusive_deasserted() in sun20i_gpadc_probe()
Message-ID: <20261115010931.6c3fc69f@jic23-hlaptop>
In-Reply-To: <lGotwwBTRaeZcOCAphaQBQ@gmail.com>
References: <368d548f-2b86-4da5-857a-6ee9473a8d0e@web.de>
	<lGotwwBTRaeZcOCAphaQBQ@gmail.com>
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

On Sat, 14 Nov 2026 18:19:12 +0100
Jernej =C5=A0krabec <jernej.skrabec@gmail.com> wrote:

> Dne sobota, 14. november 2026 ob 18:08:10 Srednjeevropski standardni =C4=
=8Das je Markus Elfring napisal(a):
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Sat, 14 Nov 2026 17:55:16 +0100
> >=20
> > Use devm_reset_control_get_exclusive_deasserted() to replace the
> > explicit reset acquisition, deassertion, and cleanup action registered
> > with devm_add_action_or_reset().
> > Simplify reset handling and remove the custom reset assertion callback
> > while preserving reset assertion during cleanup.
> >=20
> > The source code was transformed by using the Coccinelle software.
> >=20
> > Signed-off-by: Markus Elfring <elfring@users.sourceforge.net> =20
>=20
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
>=20
Like for like swap as far as I can tell, so applied to the testing
branch of iio.git

Thanks,

Jonathan

> Best regards,
> Jernej
>=20
> > ---
> >  drivers/iio/adc/sun20i-gpadc-iio.c | 20 +++-----------------
> >  1 file changed, 3 insertions(+), 17 deletions(-)
> >=20
> > diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/sun20=
i-gpadc-iio.c
> > index baa7661db13b..070d061572c6 100644
> > --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> > +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> > @@ -157,13 +157,6 @@ static const struct iio_info sun20i_gpadc_iio_info=
 =3D {
> >  	.fwnode_xlate =3D sun20i_gpadc_fwnode_xlate,
> >  };
> > =20
> > -static void sun20i_gpadc_reset_assert(void *data)
> > -{
> > -	struct reset_control *rst =3D data;
> > -
> > -	reset_control_assert(rst);
> > -}
> > -
> >  static const struct iio_chan_spec sun20i_gpadc_chan_template =3D {
> >  	.type =3D IIO_VOLTAGE,
> >  	.indexed =3D 1,
> > @@ -225,17 +218,10 @@ static int sun20i_gpadc_probe(struct platform_dev=
ice *pdev)
> >  	if (ret =3D=3D 0)
> >  		return dev_err_probe(dev, -ENODEV, "needs at least one clocks\n");
> > =20
> > -	rst =3D devm_reset_control_get_exclusive(dev, NULL);
> > +	rst =3D devm_reset_control_get_exclusive_deasserted(dev, NULL);
> >  	if (IS_ERR(rst))
> > -		return dev_err_probe(dev, PTR_ERR(rst), "failed to get reset control=
\n");
> > -
> > -	ret =3D reset_control_deassert(rst);
> > -	if (ret)
> > -		return dev_err_probe(dev, ret, "failed to deassert reset\n");
> > -
> > -	ret =3D devm_add_action_or_reset(dev, sun20i_gpadc_reset_assert, rst);
> > -	if (ret)
> > -		return ret;
> > +		return dev_err_probe(dev, PTR_ERR(rst),
> > +				     "failed to get and deassert reset\n");
> > =20
> >  	irq =3D platform_get_irq(pdev, 0);
> >  	if (irq < 0)
> >  =20
>=20
>=20
>=20
>=20

