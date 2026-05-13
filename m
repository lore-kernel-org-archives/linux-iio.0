Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1FF3BE623;
	Wed, 13 May 2026 21:35:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778708128; cv=none; b=fR3vpOk/RxKi5c3ismDfpJIQtpD2WLg2bh0TodzTVuOblCGZoHpTsCW7ybb3Q5oU0d31TmSyw7UlqQzoAIyFmuTg+vDp0yZtu3zHtp10rxWsCC760bhMigx/S2ytxb1mSHxKhSNHo5Yx/CZlAmf0WVDLg1ujR2DBHCTJpoKGLts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778708128; c=relaxed/simple;
	bh=V4Z9P+e2GyvMrVAC0rqhZI/HKDK4a0CYJ4lhRPYRqmU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EoakFGer74Y+Kbc+oZf6Sl1zr16tiGzG5gd/jIdShAZti6F5Hug3No/QVY90O6A6G4RY8mion7P9FapjuG0GOYqeVOkold4OTp+iYax+nzkG+HWtRZnw8QSXfpfdGv4UQiNaXHH3RIIkaly8j5RD69AB6y5XqmolSaIdws5JFew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=Kdc5qFLS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="Kdc5qFLS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 864ED1595;
	Wed, 13 May 2026 14:35:20 -0700 (PDT)
Received: from ryzen.lan (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D45333F836;
	Wed, 13 May 2026 14:35:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1778708125; bh=V4Z9P+e2GyvMrVAC0rqhZI/HKDK4a0CYJ4lhRPYRqmU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Kdc5qFLSoy7UP4qMQ1TYe6wOFSpqTGrPIVjQ0dmIODVJGPJO8opMmhOg3QJUZYVwE
	 YcuooyzWUOc+8Fh+i9StCkCB+DjYgIrQQeBbDZfFvzJ3xjtinPcapSwlhygdP749c4
	 jalwVuE4X0IDBxDUHBcNP3UmAAC6Mi1HeQAUMLPw=
Date: Wed, 13 May 2026 23:34:38 +0200
From: Andre Przywara <andre.przywara@arm.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Sanjay Chitroda <sanjayembeddedse@gmail.com>, Michal Piekos
 <michal.piekos@mmpsystems.pl>, David Lechner <dlechner@baylibre.com>, Nuno
 =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@kernel.org>, Jernej
 Skrabec <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>,
 Maksim Kiselev <bigunclemax@gmail.com>, linux-iio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: adc: sun20i-gpadc: add A523 gpadc support
Message-ID: <20260513233438.2715cfb5@ryzen.lan>
In-Reply-To: <20260513171638.77af3b24@jic23-huawei>
References: <20260513-sunxi-a523-gpadc-v2-0-d5efde151dac@mmpsystems.pl>
	<20260513-sunxi-a523-gpadc-v2-2-d5efde151dac@mmpsystems.pl>
	<A7772824-E704-4BFD-A796-BCD81197E5A2@gmail.com>
	<4248ac7e-3cce-4db8-a2c1-710f2c903490@arm.com>
	<20260513171638.77af3b24@jic23-huawei>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 13 May 2026 17:16:38 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

Hi,

> On Wed, 13 May 2026 13:53:49 +0200
> Andre Przywara <andre.przywara@arm.com> wrote:
>=20
> > Hi Sanjay,
> >=20
> > thanks for having a look!
> >=20
> > On 5/13/26 13:44, Sanjay Chitroda wrote: =20
> > >=20
> > >=20
> > > On 13 May 2026 10:29:43=E2=80=AFam IST, Michal Piekos <michal.piekos@=
mmpsystems.pl> wrote:   =20
> > >> A523 differs from existing sun20i-gpadc-iio by having two clocks; bus
> > >> clock and module clock.
> > >>
> > >> Change driver to enable all clocks.
> > >>
> > >> Signed-off-by: Michal Piekos <michal.piekos@mmpsystems.pl>
> > >> ---
> > >> drivers/iio/adc/sun20i-gpadc-iio.c | 11 +++++++----
> > >> 1 file changed, 7 insertions(+), 4 deletions(-)
> > >>
> > >> diff --git a/drivers/iio/adc/sun20i-gpadc-iio.c b/drivers/iio/adc/su=
n20i-gpadc-iio.c
> > >> index 861c14da75ad..3f1f07b3a385 100644
> > >> --- a/drivers/iio/adc/sun20i-gpadc-iio.c
> > >> +++ b/drivers/iio/adc/sun20i-gpadc-iio.c
> > >> @@ -180,7 +180,7 @@ static int sun20i_gpadc_probe(struct platform_de=
vice *pdev)
> > >> 	struct iio_dev *indio_dev;
> > >> 	struct sun20i_gpadc_iio *info;
> > >> 	struct reset_control *rst;
> > >> -	struct clk *clk;
> > >> +	struct clk_bulk_data *clks;
> > >> 	int irq;
> > >> 	int ret;
> > >>
> > >> @@ -205,9 +205,11 @@ static int sun20i_gpadc_probe(struct platform_d=
evice *pdev)
> > >> 	if (IS_ERR(info->regs))
> > >> 		return PTR_ERR(info->regs);
> > >>
> > >> -	clk =3D devm_clk_get_enabled(dev, NULL);
> > >> -	if (IS_ERR(clk))
> > >> -		return dev_err_probe(dev, PTR_ERR(clk), "failed to enable bus clo=
ck\n");
> > >> +	ret =3D devm_clk_bulk_get_all_enabled(dev, &clks);
> > >> +	if (ret <=3D 0)   =20
> > >=20
> > > Thank you Michal for the change.
> > >=20
> > > Have you validated the changes ?
> > > It looks while success ret would be 0 and it would give return error.=
   =20
> >=20
> > But devm_clk_bulk_get_all_enabled() returns the number of clocks found=
=20
> > and enabled. And since we need at least one, I think this is correct,=20
> > and the error message below reflects that. =20
>=20
> True but passing 0 to dev_err_probe() isn't going to do the right thing.
>=20
> Though from this function, 0 is an error you need to return an error code
> not 0 which to the caller looks like a success.

Ah, that's true - should have read your email first before answering to
Andy ;-)

So yeah, that needs a split handling, for =3D=3D 0, and for < 0.

Cheers,
Andre

>=20
>=20
>=20
> >=20
> > To me that change looks good:
> >=20
> > Reviewed-by: Andre Przywara <andre.przywara@arm.com>
> >=20
> > Cheers,
> > Andre
> >=20
> >  =20
> > >=20
> > > Thanks, Sanjay
> > >=20
> > >    =20
> > >> +		return dev_err_probe(
> > >> +			dev, ret,
> > >> +			"failed to enable clocks or no clocks defined\n");
> > >>
> > >> 	rst =3D devm_reset_control_get_exclusive(dev, NULL);
> > >> 	if (IS_ERR(rst))
> > >> @@ -243,6 +245,7 @@ static int sun20i_gpadc_probe(struct platform_de=
vice *pdev)
> > >>
> > >> static const struct of_device_id sun20i_gpadc_of_id[] =3D {
> > >> 	{ .compatible =3D "allwinner,sun20i-d1-gpadc" },
> > >> +	{ .compatible =3D "allwinner,sun55i-a523-gpadc" },
> > >> 	{ }
> > >> };
> > >> MODULE_DEVICE_TABLE(of, sun20i_gpadc_of_id);
> > >>   =20
> > >    =20
> >  =20
>=20
>=20

