Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F44E4D954C
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 16:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789577847; cv=none; b=t9DNBprBf/hARfeuRrZ1ucmnXABqhmSka5LpdVcsLfPtC6WmecUd7Yw+CqEE2nW6V+z7QxXQUG8eH+6y1Xacs/AgiS9TcreyhEYZ1PTHTx0wACBcqdO3aggQhbEfL5XCc0ZfkRQR8mQ21BvU8+Trf1zT8a8uMscfRoCM9iYiaTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789577847; c=relaxed/simple;
	bh=fuqbMSXmKaVksZQ0mp9Ucbs7t4/StAc7bwI5H6qAaCU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=m4LavoTVPZKy+FgsxnPQ3jcDihY7eePjynj0m5Eek5U6iRhKtg7kBB5RBFHq2BIAEoOUnHxRouqoSKL+RaiSDFTB+0RaeiVJAZXlY97Yj/OD8OOliy9pPvqQeteCN2DNfktlYM8Ixa+kPgPJF752Fvg4EBpso15kQVpiyZCMftI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Cg/A8+VC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Cg/A8+VC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB6961F00922
	for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 16:56:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789577791;
	bh=fuqbMSXmKaVksZQ0mp9Ucbs7t4/StAc7bwI5H6qAaCU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Cg/A8+VC9E080TzyvTpxu0YnPUmsHYmEPc7xtw8lOlwVWQFVXT213KsByPqqSIU2I
	 YKezTVvqkqyFj8RCV6X6z796z+cgGL3/V6KKfDg+c71b1lvwwgWiG1EI1uwu/m3Th0
	 3PiWWmOGjEHneUgz6Si80Fbz7NLf7VJpVq/lxnf4hkRztmLGONXApvwq5Bj6ihxbnh
	 2DEb0f9/ARGDI62c/9rCPp7kYe7gh6X3Np4O26+gdKgWFKq9/xbV2rRVt1oCMkC32O
	 lt6rPATnGQ4rlLkFzK27Q7Nts5BzFzoK5WLviocUhwMjzceCEZEyQbrc9KdJxu4ARU
	 QjSSuos16jzVg==
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5b5e4f15d00so1184162e87.2
        for <linux-iio@vger.kernel.org>; Wed, 16 Sep 2026 09:56:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBzApK3LQVZOWiCd5VEuHPg2g1uuIRF0XP1awHQoSDes479AX9pB/wSQg1VxgguBiGIz55by/Bslzxs=@vger.kernel.org
X-Gm-Message-State: AFuF++k+VFCZWpM3yVQH1PRg1WOmqLjj+Ge0qvwTODzAxu0SgdW7yJA2
	aR63LBALvmPtdvJGXcscRgLkWZHDx/QooJ2qAVAYlm55TwPavLx/i1hvD/6KVEinCbCnjBSaind
	OM/JvR3vuA7f0MF3cG5jLNJ3XLx4Vy+w=
X-Received: by 2002:a05:6512:3a96:b0:5b6:1a7c:59dc with SMTP id
 2adb3069b0e04-5b8b66504bdmr1056044e87.54.1789577790547; Wed, 16 Sep 2026
 09:56:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260909132153.1596191-1-arnd@kernel.org> <20260909132153.1596191-12-arnd@kernel.org>
In-Reply-To: <20260909132153.1596191-12-arnd@kernel.org>
From: Linus Walleij <linusw@kernel.org>
Date: Wed, 16 Sep 2026 18:56:17 +0200
X-Gmail-Original-Message-ID: <CAD++jL=LM2agPEcCxjtQuCNx4q7zqutFA6oDb61kKEDAADR4Vw@mail.gmail.com>
X-Gm-Features: AcwNN1Uahpnh6JEjJOB4HtYt7IIRQWlpnYcwXmBiixUkMQ8clPYYJyQ4xy80br8
Message-ID: <CAD++jL=LM2agPEcCxjtQuCNx4q7zqutFA6oDb61kKEDAADR4Vw@mail.gmail.com>
Subject: Re: [PATCH 11/14] mfd: remove unused wm8350 driver
To: Arnd Bergmann <arnd@kernel.org>
Cc: Lee Jones <lee@kernel.org>, mfd@lists.linux.dev, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>, 
	Daniel Thompson <danielt@kernel.org>, Jingoo Han <jingoohan1@gmail.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>, 
	Mark Brown <broonie@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Guenter Roeck <linux@roeck-us.net>, Bartosz Golaszewski <brgl@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, 
	Pavel Machek <pavel@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	Support Opensource <support.opensource@diasemi.com>, Sebastian Reichel <sre@kernel.org>, 
	Alexandre Belloni <alexandre.belloni@bootlin.com>, Helge Deller <deller@gmx.de>, 
	dri-devel@lists.freedesktop.org, linux-doc@vger.kernel.org, 
	linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-hwmon@vger.kernel.org, patches@opensource.cirrus.com, 
	linux-watchdog@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-iio@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-leds@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-rtc@vger.kernel.org, linux-fbdev@vger.kernel.org, 
	linux-sound@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 9, 2026 at 3:23=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wrot=
e:

> From: Arnd Bergmann <arnd@arndb.de>
>
> This driver was used on the i.MX31 ADS reference board from Freescale
> and the smdk6410 reference board from Samsung. Both used platform_data
> based driver probing and are now gone from the kernel.
>
> Since probing with devicetree has never been supported by wm8350,
> it is clear that nothing can use the driver on an upstream kernel,
> and it is unlikely that anyone is still interested in a devicetree
> conversion, so remove it.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
