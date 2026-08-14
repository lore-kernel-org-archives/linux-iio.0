Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 498713E4514
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 07:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786691136; cv=none; b=RWpC5uKZk68/ymBRHY8RYGwmabIlIuSjCZxCoSkrf/8tefsvTY4TF29p3vqEis7SSpCmJcFdsJVgGzj6lPU9r3zrb0h7J7sCSt+OigYDpGNg84Dq1exx7MC3SVwKsyJSC5iOI9TBMj2xkthSoDIxU/i1iHWhWqrhBQBOzAZJ++s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786691136; c=relaxed/simple;
	bh=SHaKcQbj5Ms1Lc5eCSHy10d/k1vnoMaVMbqTBfEnYc8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V8G5G51kl5AMJ8hJ/wF6tnsFMkd2wApYj4XwTWQGq1YLa263H90s5n/AhwDXG28Vu0NZhNH7z6izAaaKjPWcD9hPZYEn49/mfhI8AJTQKJewyYjvCxYNQRVpV35ay5ChQFvBRrafynVMe082R67b+iZyh7PI7BKZbAV1gvXJbFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MhZbb0Q3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MhZbb0Q3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8704A1F0155D
	for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 07:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786691131;
	bh=SHaKcQbj5Ms1Lc5eCSHy10d/k1vnoMaVMbqTBfEnYc8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=MhZbb0Q3ywA0FY3+QBtqKYKQaxCY+Ce0tkYZjtLlEUkecK5jITosq2GD2+uOyF3vk
	 mcb08fll/BKLOtYE+gB4X6QgfnoULphiztYnEWiCuyoD04YrWlW2H9nUKCu2ghWXeX
	 +aVXaqeF+5vthXvCpxr/QxIAA1k1Yokt3y+twrSSi/tIw27u95PP+OVR41LE3L5n/W
	 Yhws9O/447igZlMY9vV6i5vfWG4X/6M1/So45/aSxK1UmCDvNbN6d/QmwhJN4chBMT
	 xzOOFqmAbRElGtNOFNH7Y68+Y1IoLdhIKxkNMGW1a3unXql3reD6eMkdJWEExUPd+m
	 T0NuXGDitZKMQ==
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5b15dcaca31so639259e87.0
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2026 00:05:31 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp88MVAsQEGC7kO1Be52SvRIulkp8otHEjcF9wZO0TXsB7nEp8favDvHa6dk94a7jbvH0FKWB4WA5E=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzzoKSe5HkKjGzfcTh7NR4OtpLb57/sURzercHjCAY1btxXxEM
	H6PaSQ5qgmyxbByz8OyH9XRpi7PXGbfObGT2gVeful4H31zKGTDFvLz2HaLJeFrsUEcgfEaVVDI
	UaqvLXGVfeP7aiWHJFVbJjuZ69QiRNH0=
X-Received: by 2002:ac2:4c50:0:b0:5b0:1b0f:7a60 with SMTP id
 2adb3069b0e04-5b459164d8emr566977e87.32.1786691130309; Fri, 14 Aug 2026
 00:05:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com> <20260813-ad7768-driver-v3-13-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-13-cb554399ad26@analog.com>
From: Linus Walleij <linusw@kernel.org>
Date: Fri, 14 Aug 2026 09:05:16 +0200
X-Gmail-Original-Message-ID: <CAD++jL=LpUoV5k-2MO2MXuT1e4Vy2EMqkG6RQ=bgdpjDis3kXA@mail.gmail.com>
X-Gm-Features: AcwNN1VTqVz0xqQrypGS9VVD3jKrGAyvu3tLMCM9beWaeCIfb903pkp9sM6mhXs
Message-ID: <CAD++jL=LpUoV5k-2MO2MXuT1e4Vy2EMqkG6RQ=bgdpjDis3kXA@mail.gmail.com>
Subject: Re: [PATCH v3 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
To: Janani Sunil <janani.sunil@analog.com>
Cc: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michael Walle <mwalle@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	jananisunil.dev@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 3:58=E2=80=AFPM Janani Sunil <janani.sunil@analog.c=
om> wrote:

> The AD7768 provides five GPIOs controlled through registers shared
> with the parent IIO device. Register an auxiliary gpio-regmap driver
> and use the parent device for runtime PM.
>
> The device has separate input-state and output-latch registers. Add a
> reg_mask_xlate() callback that checks the line direction and reads the
> programmed output latch for output lines while retaining input-state
> reads for input lines.
>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>

Nice patch!
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
