Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F8873D3317
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784841273; cv=none; b=c52JYIXNxY0FD+TI9fOobwC6QDhyQto8tgVGINFEeKt1UKm1eudCg/C5FOUPSp82qqNpM/0nxeS3mvXQ0ZNC+MAtFjNK5NPfPSn1FukGJv3CEsnR5iDHgqxr4iws3B2/q5dhdaq13mKJPZWmmV/guYUWeAu0BJoaoWrxXkFWHfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784841273; c=relaxed/simple;
	bh=pKcrrPSvwFkIGGO8OgBGlAslHT0ekVIT3T+jPH3FWcM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PtLkZC3GZNV0gfOy95OUtMZ9YAN6WpN6P4UeIWRskwz0HYEPcDeTMWavKhDrDw07EpOD4MkIvO0+kVRk4AQQAFXw+PWIRjIEkl8KriDWJCGQnL5rSmz+9KoTsx8CTj2zWRDjKUDY18DImjQHLltAxVr/z8VIHXu9tibof8h6Pi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewwOrver; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewwOrver"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CB41F0155F
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 21:14:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784841272;
	bh=pKcrrPSvwFkIGGO8OgBGlAslHT0ekVIT3T+jPH3FWcM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=ewwOrvervehyS5jw2eTGWHWs7Pu42Dl0jjfbFsIL8JeS6PkEB6W1sHzsJZulRtVgC
	 HOOXZ94MsKwOUIw/pDrkUb/qGkrLN7ib7hBC0TNrcbbw3rRINTQ69cyenHuGd6ELgK
	 YhQZfZwy4YYMWR0gnshjOeiThrcSKpJc/nH4JLf+a5vKprfOPEBrhswH7eqNC//NjB
	 Lu6QIi5SjHc08PEZpV6vgjIheJvg6M/j9cmhn5wbz+kzy0cEQBky8iinSqjo16ru6B
	 6ATIWuW1dx/1MeymAoCOa9mbrShpavMKCrQVbKnTbBmHAkjccAMFX4JsBTBzn4gyOR
	 1g2k3ur+vqrIg==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b2aa3be376so799986e87.0
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 14:14:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RofJ+eLjeImYI9jL+iALrwNRngGwE9wCcHfNAcR/Ozr67YHRjYXRnee4LEYqM9sU7AJ3Gug5HQJ6LE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZiLxFjpAF3L5CddFimJEdvY6TydUIMz1oC/7hGvEm+8eG5rqt
	oqa/QYetQInSjuIfI/AJeFJGWfswLOtn+m8RKsg0C/bIORwJbulsiD8auPYwnh/GfTzTni5hTJ6
	pSdGQonj1XNq/d1CJCHPo/5UozN/xdTA=
X-Received: by 2002:ac2:46ea:0:b0:5ae:c8d9:dcf6 with SMTP id
 2adb3069b0e04-5b2b2f6847bmr701383e87.37.1784841271201; Thu, 23 Jul 2026
 14:14:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260723034237.2501507-1-eleanor.lin@realtek.com> <20260723034237.2501507-7-eleanor.lin@realtek.com>
In-Reply-To: <20260723034237.2501507-7-eleanor.lin@realtek.com>
From: Linus Walleij <linusw@kernel.org>
Date: Thu, 23 Jul 2026 23:14:19 +0200
X-Gmail-Original-Message-ID: <CAD++jLmP55T8Ti9kYWRMrO9s=U1+d35WByJdCMxGUv02cBvq2Q@mail.gmail.com>
X-Gm-Features: AUfX_mwMpXeHJMbubHUq8RrJYhbgx3kElg2c0B3B_zYw3yYfj2P1cBdwzG0Qy-4
Message-ID: <CAD++jLmP55T8Ti9kYWRMrO9s=U1+d35WByJdCMxGUv02cBvq2Q@mail.gmail.com>
Subject: Re: [PATCH v7 6/9] gpio: regmap: Add value_xlate callback
To: Yu-Chun Lin <eleanor.lin@realtek.com>
Cc: andriy.shevchenko@intel.com, mwalle@kernel.org, brgl@kernel.org, 
	tychang@realtek.com, wbg@kernel.org, mathieu.dubois-briand@bootlin.com, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, u.kleine-koenig@baylibre.com, dakr@kernel.org, 
	bhelgaas@google.com, o-takashi@sakamocchi.jp, dlechner@baylibre.com, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, linux@analog.com, 
	linux-iio@vger.kernel.org, cy.huang@realtek.com, james.tai@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 23, 2026 at 5:43=E2=80=AFAM Yu-Chun Lin <eleanor.lin@realtek.co=
m> wrote:

> Introduce a new optional 'value_xlate' callback. This routine allows driv=
ers
> to translate or modify the register value and mask immediately before a w=
rite
> operation. It is particularly useful for hardware that requires additiona=
l
> control bits, such as a write-enable bit, to be appended to the data
> dynamically.
>
> Suggested-by: Michael Walle <mwalle@kernel.org>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>

That's a neat patch!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
