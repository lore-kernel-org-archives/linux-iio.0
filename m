Received: from mail-24429.protonmail.ch (mail-24429.protonmail.ch [109.224.244.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF3723BE635;
	Mon, 15 Jun 2026 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.224.244.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781565035; cv=none; b=aOcozwIfgXAaDiihIS+cwVurmapevOUJ6dXsCkeoDlASft7Op0v13b9pKLgY5dOl9u+lCQwv/chjYr9KdprT/bzUBMFa9hcQOCK0WzuXAjxQFDqt1EhZMooiZdnMGYH1XaUpYP+hZW7hBOl48QdGM3QTYBafb7B8eAnBSzV0Y0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781565035; c=relaxed/simple;
	bh=hbHVIkwcbFkz9MPv+duQJkasWp3O14EJ/lbKHL2f1F4=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGTaNIngfd3fC9CF0CFlvXaf3KLVFVfnRqo9JkwikTEPPushC47HRXC71CP9g+1r0WkQGeJsMqAUUvaF695jl2WcSR0/WY5jgF60SYRCAWa42cmEqHfd4nzRyxBKDFdkzjU8es6oFyvKyruWwJlnRg/sn9yuI+7fQ8eKKbKPons=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com; spf=pass smtp.mailfrom=protonmail.com; dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b=ihtlWpy5; arc=none smtp.client-ip=109.224.244.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=protonmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=protonmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=protonmail.com header.i=@protonmail.com header.b="ihtlWpy5"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=protonmail.com;
	s=protonmail3; t=1781565025; x=1781824225;
	bh=HkBQfJ5TxwQinnF2S5Nb1OwyL2FsUW+lAQB1x+AgnVc=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=ihtlWpy52uFD/PcKYtX0bwhDVrPMOQVTrn4j23/qRLTnFvUE9KEr3rvvYRkmFIBzS
	 U5ZD8uxPvPZoogWGtS4pEY5TH60k6pe2kWDytm7X4u2Y3qfkYTV0NseUbTYiwzG/K7
	 g4PbtS46MUk9J6kXchKsNYhOeDPb8QDXdVcqUxiGsKUqz45zU99mpOEUDNji2KNRlP
	 g2eJAxBAMMTkoA5EhBWCppM9hIwqi5MXNHf5wTjhTuH4oWXysMPeMtxn7Iu5vyzGoJ
	 ZuIR7HHXvovo2Dh2PCgSz8px0MFus0qO9141fKTQo6sh+OE2C1v7BUR3uRdZ+5duXO
	 mFAA8E4dzBNXw==
Date: Mon, 15 Jun 2026 23:10:20 +0000
To: Lee Jones <lee@kernel.org>
From: Roman Vivchar <rva333@protonmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, =?utf-8?Q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Matthias Brugger <matthias.bgg@gmail.com>, AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org, Ben Grisdale <bengris32@protonmail.ch>
Subject: Re: [PATCH 3/4] mfd: mt6397-core: add mt6323 AUXADC support
Message-ID: <ycj3k-vV_tQv6u9OfCTP9G9kkeeE-_dbzg_oeHPXn2pb1oZe_Sa1BH6GUGuSd_gD6uPSJiTX7tz6MTlFcqGdWX-f3GMfyW2sLgAOCw6YeNE=@protonmail.com>
In-Reply-To: <20260611163748.GB1212816@google.com>
References: <20260602-mt6323-adc-v1-0-68ec737508ee@protonmail.com> <20260602-mt6323-adc-v1-3-68ec737508ee@protonmail.com> <20260611163748.GB1212816@google.com>
Feedback-ID: 173184497:user:proton
X-Pm-Message-ID: 182c5d52f74017e86f4085f21809f8879f8a1b6b
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi Lee,

On Thursday, June 11th, 2026 at 7:37 PM, Lee Jones <lee@kernel.org> wrote:
> Interesting.  Has this been considered?
>=20
> /* Sashiko Automation: Issues Found (1 Findings) */
>=20
> On Tue, 02 Jun 2026, Roman Vivchar via B4 Relay wrote:
>=20
> > From: Roman Vivchar <rva333@protonmail.com>
> >
> > The mt6323 PMIC includes an AUXADC. Register the AUXADC in the mt6323
> > devices array to allow the corresponding driver to probe using compatib=
le
> > string.
> >
> > Tested-by: Ben Grisdale <bengris32@protonmail.ch> # Amazon Echo Dot (2n=
d Generation)
> > Signed-off-by: Roman Vivchar <rva333@protonmail.com>
> > ---
> >  drivers/mfd/mt6397-core.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/mfd/mt6397-core.c b/drivers/mfd/mt6397-core.c
> > index 3e58d0764c7e..013b0857fb54 100644
> > --- a/drivers/mfd/mt6397-core.c
> > +++ b/drivers/mfd/mt6397-core.c
> > @@ -125,6 +125,9 @@ static const struct resource mt6323_pwrc_resources[=
] =3D {
> >
> >  static const struct mfd_cell mt6323_devs[] =3D {
> >  =09{
> > +=09=09.name =3D "mt6323-auxadc",
> > +=09=09.of_compatible =3D "mediatek,mt6323-auxadc",
>=20
> [Severity: High]
> Does adding this compatible string expose an unhandled edge case in the
> auxadc driver?
>=20
> If this device is instantiated directly from a Device Tree without an MFD
> parent (e.g., at the DT root), dev->parent could be the platform bus
> (which has a NULL parent) or NULL itself.
>=20
> Looking at mt6323_auxadc_probe() in drivers/iio/adc/mt6323-auxadc.c:
>=20
>     regmap =3D dev_get_regmap(dev->parent->parent, NULL);
>=20
> Could blindly dereferencing dev->parent->parent here, or passing a NULL
> device to dev_get_regmap() (which calls devres_find()), result in a
> kernel oops if probed as a root node?

This is intended behavior, ADC always should be probed as a child of
the mt6323 MFD because it doesn't have own MMIO space. Otherwise the
devicetree is malformed. Recent mt6359 ADC driver has same thing with
dev->parent->parent regmap.

Best regards,
Roman
