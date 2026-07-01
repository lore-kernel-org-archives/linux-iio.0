Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B70C3317164
	for <linux-iio@vger.kernel.org>; Wed,  1 Jul 2026 10:01:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782900110; cv=pass; b=teL8c+GuN3iCGEpB1+Nkk4Cg9Q/MQD1qcuDwBRQonSFiwmnMQUUBulSxhuroA4BSSL9nDXyBbtkfPPTaFOvubXyG0MZBEtpM0YXYd/FQMGBfMdBuSaLJ6LTeF05N2at88wiiguFW0ooL09fxeOqJ4nghUPY89oae1lgfrOrbBXM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782900110; c=relaxed/simple;
	bh=NqRmgIDfn8JlBVxfbI6Meg6G6wYP2KKDJWJAgquFHVo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VcVTZUTl8H/gTlEc/kDfqBLywLa9ew2ViMmSah2QMwgibF2x6kHboXDoyMzXcYxYsUFNt0227sJ5f5aLQ03/ZYObca1ycPJV92802xbbmG6yjVBIuyjfUJhr7nGTuUt62FkHiZ5l5O6BtLsZZEFoWuZ7UUMKubj30+lh07CM/tc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=luhcVtIx; arc=pass smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="luhcVtIx"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6983f20a8bfso867831a12.1
        for <linux-iio@vger.kernel.org>; Wed, 01 Jul 2026 03:01:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782900107; cv=none;
        d=google.com; s=arc-20260327;
        b=p/0vFDa755XeWPZA6nAtb5mJyGRTIc8iGRWj2DmyJDCVarPzz2M4z445rFDcpHZvME
         RncDVEBlX3WwA7EjNtUGsA1xP/oKHZDVrzTEHsdtOPo7NimAKSt9ptzVSwzXHpGI1y/1
         qwnsSXSKMZhJd1RhFkBRk+wD2kDFj74aRICHlcp2m8ACH5G1mkhcP6lrJ+/usaZX+6c1
         DCxTwAXHjH0vKxMiS5BQi9dbkyOCO3CZoAZDM+aspbFTgcj4obCwuPnvlRcjLEoHOozM
         d6MzEZlactdVYXHOv/ZHCbfkXAmN/Gl+vEAfeQOQGL7+etaFV3RbKNeH2q/ojS62bV27
         /+VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NqRmgIDfn8JlBVxfbI6Meg6G6wYP2KKDJWJAgquFHVo=;
        fh=/6QC03A+SZyRSYR1Q/T5o9ungeORmuPAxSYWrhruHz4=;
        b=XG8c7X0qt9gH7YxnvG/ZXzBhrCkRF9OgGgvE8vdDF62f4ZGJYN0pM8wbTcawBcv62G
         We+St1jfzgo31V3JzfXlBchN5c/3QZOW1UUX61OvDRaprxGlJQsUNO0Bo91RxwS1/8us
         f7virKUwISCgUE6MWglyjrHbLAqOwy4DSB6w8HbiofYyPPtECRWoSNZtMDgP9+GDYMO3
         wtT+gTM2qV5G/xdCEXMq3SFRlUPsgH7v97P9+TjtzPEkfYWkiiDMZ+LhNaUaoLjgEpAO
         A9sEs/OrNdE9QbjOu/jNiik2uBvsl1SpuDD/+Mg0VWXmM/H3kDwW8uyk58BCj12hrqu0
         9Ksg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782900107; x=1783504907; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NqRmgIDfn8JlBVxfbI6Meg6G6wYP2KKDJWJAgquFHVo=;
        b=luhcVtIxtXDBoC5Se65QYH/Vd6YU0Id1WuYpLuLNfpZBMWEoL4kMwRi8j3syUsn3Dg
         1MjgATDpW0X07i2O+IgMiiXB0f9WEcwUre31vcqBwBHDl0Ts7RJw9R94iqFBMm6Hn/6b
         Lp2GJtsAlD5gj2Aj7AvdfMKVRiKn/inwjX/Ct1uu7Ln7wYIdRMegDBUeNKKDX0CHjh9e
         tJCBZ9zW7ll94ele9mlSXTJclf73jepdYY1u5aSs6syX5NKskqZI9VTTpViEB957vvmW
         LrLbPtPnP+MqbNOfWAZyRV6mA+LTKZPnfvflF5XWRCAa/24ru0ROYFIoHTSbsSFxZ+f/
         8wxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782900107; x=1783504907;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NqRmgIDfn8JlBVxfbI6Meg6G6wYP2KKDJWJAgquFHVo=;
        b=T2j/jFSCEgRRGzIYtHKXIOmkQ4cQN/8xhgDB1TbLCAEq73OqN4BlpGYG6rzlFyAnUt
         /G/yCnNlkXTiCJYFjGb7RBpm+RH9QoFMO8HH/hqgG4bseG8szBlOh8NhlxmMh4GbT1xj
         MwCYZD22NLd1ntxtB7a4RinY3g57v1Pwn6jk+ji5r/gPYF5EpLYlqpgR1oZpHfpdBJAc
         IeuKraEbhIYBz+8/43Q00x+Wx71m8Gmag4BSg+PDOJc38zwNjmBfX9wddxIKkYAlSs31
         Qto+tqRObCoYVYHFQqboCy8kXCvhawhqCnE30ARV//wtLLm4aw281ppC+GWTNWZrmyE6
         ZEMw==
X-Forwarded-Encrypted: i=1; AHgh+RrlPDp5u/3/CSELZ0GTUHGEabFTVZTFZcfvLRvZJ62pfyqDqNIPuuIW3xnyiQOYXzUz3y3sImmjWfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYHmJGprvFwAWGrQW6tEG5145oauBgT6rXoic+839e2m1FU9So
	GNS8sY08duoQ+oKrAH9Pa/aRxoAOajgWllnKykHf88T3NnH4bvj1SaVeT9a8L0lp7t9QBnwAca9
	WIuXCM1IRqXfJGhsZAKBnfg2vuNT8GKA=
X-Gm-Gg: AfdE7cl3MsrLj9kZmU8NEJWYmvP0B8E+zynIQOeiOkNZYUhV9ky+aZbnbtgF7FlF0pp
	g/XLKgMEy4hXBZCbd+hYYQcikJRN71n4JtOWNNLvZp3grqwwCG3cfkY1t2oj3r2W23JwFRXtVta
	+Nr4u8rsmb7Rv56qzGG7uSuACDeVWPnIngr56K4UoSnKiJIzeoiOsk4c4siXpsNTUlrvzmghzsS
	JxSMQotLP2ttR2e0kOnFGgO7t98yOkw8T1KZWild1FzYS2ns5dniAiz6M6paTGgEHU4w1jKjltC
	DaiIzk2g5nyaNT9cTHBKMhD4BQe8Z/0lb5MHzWFx0RNNqmf4B1hECBGqUWp51qAMiGfU2dMf3gh
	E6VQMMN4qhgNTzGnG5cENKb3z3CZXEm7Im1Z4nEwxeGKO3qvUfTtX1ugdzQ==
X-Received: by 2002:a17:906:b792:b0:c12:7eeb:d2d5 with SMTP id
 a640c23a62f3a-c12aa1affdamr33696466b.33.1782900106941; Wed, 01 Jul 2026
 03:01:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512033317.1602537-1-eleanor.lin@realtek.com>
 <20260512033317.1602537-3-eleanor.lin@realtek.com> <agMM9soiqpG-TRSb@ashevche-desk.local>
 <adff3a2d21a64d3ea3b408d62157ee1e@realtek.com> <ah92oEavMu4QRn8y@ashevche-desk.local>
 <CAMRc=MdA24z-tB_D8CTw68Di8e4OVQJ1QH4+rDskFzq=xjJ5BQ@mail.gmail.com>
 <DJ3QVMZ6XLW9.1M9W541O92QWJ@kernel.org> <CAD++jLncD2ZjH3aedOkGNYP3FyZ=i7Pb0OcKKZKuMOPGNjM_nQ@mail.gmail.com>
 <DJN3PDTPJ3L6.24P71OQFB6C98@kernel.org>
In-Reply-To: <DJN3PDTPJ3L6.24P71OQFB6C98@kernel.org>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Wed, 1 Jul 2026 13:01:10 +0300
X-Gm-Features: AVVi8CfOApAIask00J9b0BLe88oz7fAW8fQFHDlsxs93vuIf3dHnb0iovhmAtW4
Message-ID: <CAHp75VeTp4eYQ4QBoeH2VyVhUivxNn1CaC9jskmeg-1zTAOYLQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip() accessor
To: Michael Walle <mwalle@kernel.org>
Cc: Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, "robh@kernel.org" <robh@kernel.org>, 
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, 
	"afaerber@suse.com" <afaerber@suse.com>, "wbg@kernel.org" <wbg@kernel.org>, 
	"mathieu.dubois-briand@bootlin.com" <mathieu.dubois-briand@bootlin.com>, "lars@metafoo.de" <lars@metafoo.de>, 
	"Michael.Hennerich@analog.com" <Michael.Hennerich@analog.com>, "jic23@kernel.org" <jic23@kernel.org>, 
	"nuno.sa@analog.com" <nuno.sa@analog.com>, "andy@kernel.org" <andy@kernel.org>, 
	"dlechner@baylibre.com" <dlechner@baylibre.com>, =?UTF-8?B?VFlfQ2hhbmdb5by15a2Q6YC4XQ==?= <tychang@realtek.com>, 
	"linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>, 
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, 
	"linux-realtek-soc@lists.infradead.org" <linux-realtek-soc@lists.infradead.org>, 
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>, =?UTF-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>, 
	=?UTF-8?B?U3RhbmxleSBDaGFuZ1vmmIzogrLlvrdd?= <stanley_chang@realtek.com>, 
	=?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>, 
	=?UTF-8?B?WXUtQ2h1biBMaW4gW+ael+elkOWQm10=?= <eleanor.lin@realtek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jul 1, 2026 at 11:44=E2=80=AFAM Michael Walle <mwalle@kernel.org> w=
rote:
> On Fri Jun 19, 2026 at 11:08 PM CEST, Linus Walleij wrote:
> > On Mon, Jun 8, 2026 at 4:41=E2=80=AFPM Michael Walle <mwalle@kernel.org=
> wrote:
> >
> >> >>> Without an accessor like gpio_regmap_get_gpiochip(), we cannot ret=
rieve the
> >> >>> gpio_chip instantiated inside gpio-regmap.c to fulfill these requi=
rements in our
> >> >>> map() function.
> >>
> >> Why is gpiochip_irq_reqres() called in the first place? Isn't that
> >> only called if the irq handling is set up via gc->irq.chip and not
> >> via gpiochip_irqchip_add_domain() like in gpio-regmap?
> >
> > Not really, the gpiochip_irq_reqres() is called to mark that a
> > GPIO line is used for IRQ, so the gpiolib cannot turn this
> > GPIO into an output line, gpiod_direction_out() will fail
> > on lines used for IRQ. So it's a failsafe.
> >
> > You can live without it of course, but then you don't get
> > this failsafe.
>
> Thanks for the explanation! So did I make a mistake years ago by
> adding the gpiochip_irqchip_add_domain(), see commit 6a45b0e2589f
> ("gpiolib: Introduce gpiochip_irqchip_add_domain()")
>
> As Yu-Chun found, gpiochip_irq_reqres() expect the irq chip data
> to be a gpio_chip, which isn't the case (in general) for an
> externally allocated domain, is it?

So the whole issue comes from the fact that the IRQ chip is not marked
as immutable. For immutable IRQ chips (which all GPIO provides should
have) there is no such issue to begin with, id est there is no
gpiochip_irq_reqres() callback assigned (and respective _relres).


--
With Best Regards,
Andy Shevchenko
