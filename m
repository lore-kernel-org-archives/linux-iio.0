Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72D141C308
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782825677; cv=none; b=snnPyX0LDglzNtDqDwsDtIAChJKRarUoC1VR8U8lS1UxmTBZb2/A8xGckQ4UZub3rC2nokb43npMSUlHRiVJgULud9vLV+eKu6Q1hZvJMuiSuXqLgA3jaboqZi8PQjoymeCE752ysMa94ZgVe3+qU4l2g1533lMq+pVeHEinq0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782825677; c=relaxed/simple;
	bh=MVY7OPuBtDDWoGVmZzYJMH+zngqc4Ts/svjtm9TV7xA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=M3WsnJHO3Q0f8DkDNFPdDGU9pJ2qDf7NttDqNZjzyunQ5cyAn5j9ryGabCBpdNwLoV1iuK08esBehprWmwgyORnYdlIUFWbU9tJKz4vlt0v3fzpYVpsoAWbHz+bYNqXIP4H0mQUmlN+NPurDKUli5xiuKSFquLtlrCKzIJUQb1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iOyhgDJM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iOyhgDJM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B05B81F00ADB
	for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782825675;
	bh=MVY7OPuBtDDWoGVmZzYJMH+zngqc4Ts/svjtm9TV7xA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=iOyhgDJMUazn9ljrXYNdCvg1zL422zS4FttNWGhdvnMmlXUssySEPNAITYjTS8B2c
	 e0x/xa7PwM3CmCldqJHaNdeKzhqlDPDsYRrj5nlcG+wqJtaKqS7e7SwP+s7aM8GJa6
	 K+1zmqgPQWyqCDX8mH+vtAtFUP+x4m2BoYG7zXxtS24IhPJXzDTuGDnmuJEW0ZdBGu
	 BUwj/Xkb7nNS7nMzu7mgTJC1/JUdev7TQmFd2s67DOl7khiQLBgYpHuLEquTNtX3yN
	 RGpHp7fSnBxYRmv8dvcFmRogh4EqEuZr4t0K5ZI9FTV7LxSYAm0pvyIFQSu9LIzp70
	 ZkhNVU4yfc6DQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aeb91c003eso2152785e87.3
        for <linux-iio@vger.kernel.org>; Tue, 30 Jun 2026 06:21:15 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RohvFdAA3Fi9j8xqis4wG6FzL2g/p8yhB0FMcsL8jXJx44fn65OFT5nFS/ry6G6goK6dlmzZFiyXl8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqwLOOtY1C4pfWjutE/Jv81UXJlmT9e/rB45PVIK4qW5//aZSa
	y1yKiPIFgCN+ZGORMT1bHQdcu9kvhWxNc/apORNACeyp9RSUhYaDIwh9q7hxTkSwJ0PMgU4Fwtq
	hLa7BRGF9yRdm/u5jAtsHhcYRFxWallM=
X-Received: by 2002:a05:6512:4019:b0:5ae:b728:df28 with SMTP id
 2adb3069b0e04-5aebdbd6442mr872848e87.49.1782825674488; Tue, 30 Jun 2026
 06:21:14 -0700 (PDT)
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
 <ajkP4DHN4JPjr6yb@ashevche-desk.local>
In-Reply-To: <ajkP4DHN4JPjr6yb@ashevche-desk.local>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 30 Jun 2026 14:21:01 +0100
X-Gmail-Original-Message-ID: <CAD++jLmHk=efdbz9LgXJiuNzTjM7-K2d3v5TPck_-NJpBp+QkQ@mail.gmail.com>
X-Gm-Features: AVVi8CeSmNt49CsRH7ooO8TtoFwH2cGZrVPIEEBlGKP4NblkyzQpSIYZPriLS8c
Message-ID: <CAD++jLmHk=efdbz9LgXJiuNzTjM7-K2d3v5TPck_-NJpBp+QkQ@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip() accessor
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Michael Walle <mwalle@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, 
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

On Mon, Jun 22, 2026 at 11:35=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@intel.com> wrote:

> So, when we instantiate our own domain in regmap GPIO, we should have tho=
se
> callbacks be defined somewhere?

Domains are just translators, but if you create an irq chip it should
ideally have these callbacks.

Yours,
Linus Walleij
