Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB4CC3CB8FF
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 21:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781903326; cv=none; b=rRrOkq+ut90Ooygl9+59JWMGJWJhWijBHbEB3WpkOWnwhpOpQURd4xoXNC4dtP6gNAz4y7CjkO2wAHhc+g1tWatw+kaetWncoUlYr49uzJguYoBl/O663KxclylZ55g/IKLPCmEBj9SLzH5+fUhAeThEcwJIda8NLN9y14tHn8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781903326; c=relaxed/simple;
	bh=FMSWI+gloufB0h0HTiPPqBp7P4ZIS2lTWu/Igajet9s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RmP3Tt10kFRb6PPBnH61YU/ipmJ4UysVKcZ1wW+k6Ly5hH5Aj0h4iuAaN8/7QbnM5yEaVQEm+/BCKeGmOwV4zajX+CVQDu8zni/zYAwZuWGO9e1w2FTfm8ubUmCXbjVh9jV0D6sdsIJyyHPlQQgX84njA0O+68TAw33m8SeeymY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cMmbUbYf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cMmbUbYf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A2E31F01564
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 21:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781903324;
	bh=FMSWI+gloufB0h0HTiPPqBp7P4ZIS2lTWu/Igajet9s=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=cMmbUbYfwQO5CI8iSeh+6t2SUNKHya5glLSJCb8DV6CntMMsxIktcwYeUmvlKQvmO
	 ybB8ISM0w+kC9HyTbwLa3hR8N8oPyCXMMxYGJGAiV7pG7cRvGlNmk/oM+gZQ0C7IqG
	 VFgAGvVR0MMXgLVZKqm2tfLtf7KYNqnzBOd6lNvphwkuSLkrZuKbfwzhVKfDWh8Jin
	 +qFWl5S01GulWeCaSveSolV7YyO8Mm4k8Zqag5H1SPHluISqIep7t8/+5DRRKL5u8R
	 HD0uaF/HZibyqylXS6ZVwDwDuUOnQSO+bUVjQvD+rNyE50XfyOX95o1K9oWDnB4LpI
	 ZAwBSrYj+sajw==
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5aa624ff3cbso2733809e87.3
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 14:08:44 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ90MKaE3dtXqtW1XcUdIdwO2Jh6frq7ITwwDo4XYKpfYfXNan73BllgkgTBfS6enioNCyfv9IejOME=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9h9cUIEOE2iGUgPduMFsbvdZZQnYgTqRaMS405XllUlNP2MF7
	fAxU6/NAImYY0YypJjyfGMAhbGw4kJ7WxwF5PWivE6cDFokNBektjFo4ZAb2uwBJ+CuxH4KGQAw
	cMBbjEqHuf/Gaw2sYx17/5N6aRCbmV0U=
X-Received: by 2002:a05:6512:239d:b0:5ad:4eac:f6d2 with SMTP id
 2adb3069b0e04-5ad58f3506amr1312078e87.23.1781903323139; Fri, 19 Jun 2026
 14:08:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260512033317.1602537-1-eleanor.lin@realtek.com>
 <20260512033317.1602537-3-eleanor.lin@realtek.com> <agMM9soiqpG-TRSb@ashevche-desk.local>
 <adff3a2d21a64d3ea3b408d62157ee1e@realtek.com> <ah92oEavMu4QRn8y@ashevche-desk.local>
 <CAMRc=MdA24z-tB_D8CTw68Di8e4OVQJ1QH4+rDskFzq=xjJ5BQ@mail.gmail.com> <DJ3QVMZ6XLW9.1M9W541O92QWJ@kernel.org>
In-Reply-To: <DJ3QVMZ6XLW9.1M9W541O92QWJ@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 19 Jun 2026 23:08:30 +0200
X-Gmail-Original-Message-ID: <CAD++jLncD2ZjH3aedOkGNYP3FyZ=i7Pb0OcKKZKuMOPGNjM_nQ@mail.gmail.com>
X-Gm-Features: AVVi8CciIShnYrkvWiar3ZeR88iI32EVeKlpP07bMr3Ga2S3qThBGTGjlcJfumA
Message-ID: <CAD++jLncD2ZjH3aedOkGNYP3FyZ=i7Pb0OcKKZKuMOPGNjM_nQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip() accessor
To: Michael Walle <mwalle@kernel.org>
Cc: Bartosz Golaszewski <brgl@kernel.org>, Andy Shevchenko <andriy.shevchenko@intel.com>, 
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>, 
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "afaerber@suse.com" <afaerber@suse.com>, 
	"wbg@kernel.org" <wbg@kernel.org>, 
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

On Mon, Jun 8, 2026 at 4:41=E2=80=AFPM Michael Walle <mwalle@kernel.org> wr=
ote:

> >>> Without an accessor like gpio_regmap_get_gpiochip(), we cannot retrie=
ve the
> >>> gpio_chip instantiated inside gpio-regmap.c to fulfill these requirem=
ents in our
> >>> map() function.
>
> Why is gpiochip_irq_reqres() called in the first place? Isn't that
> only called if the irq handling is set up via gc->irq.chip and not
> via gpiochip_irqchip_add_domain() like in gpio-regmap?

Not really, the gpiochip_irq_reqres() is called to mark that a
GPIO line is used for IRQ, so the gpiolib cannot turn this
GPIO into an output line, gpiod_direction_out() will fail
on lines used for IRQ. So it's a failsafe.

You can live without it of course, but then you don't get
this failsafe.

Yours,
Linus Walleij
