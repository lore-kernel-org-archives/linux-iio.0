Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7191548035F
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 13:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788356900; cv=none; b=aeVo2EqFbv8ahXHvXGhemsP0yBY47y7za6HR5jnSSrFm79F0LHsCycfTd4DHUjlwvo7pd84RzPndl3GZ+UMHUgPdQ6XT+16h9S+68Xh9T5li2wO4VQicvl5JKnYbw6ucbCE6n9/5R4Q5jeYM0zhSGrWsXf5VK22BMoN1ZdHGrUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788356900; c=relaxed/simple;
	bh=9EuOPgmnfyrHKd+9OQP+FNVSdmJb8FG0nWcY+bDD/s0=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CLniy15XW7lN1XIXyX37Y+7ugAYTbiUMw4xLecp9EPkJWepUrNwwyHw3OQIEOcTMxtrJSdpjw2wq1SFmZvROo5k+wume+8JCNOmosqMdqu9ZH2B76+ay5Qe1WpGrHTjZnso+rm8SHdesu6FydBjOCfdjzgpENveUmDly9XyWLpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YmNwzu80; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YmNwzu80"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B2FD1F01563
	for <linux-iio@vger.kernel.org>; Wed,  2 Sep 2026 13:48:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788356899;
	bh=9EuOPgmnfyrHKd+9OQP+FNVSdmJb8FG0nWcY+bDD/s0=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=YmNwzu80M45A7ALE/NOEix/ctUWcsxaJaXpBc215EfazHsvYGEKMGl1wpAoG8opX0
	 zKb3r/5B6nUhnatwPHh2xb7ZyOU/tbj6SPv+MSHENUONzutUM7Be1R7r6GvJiwnlWB
	 ihJy3aGydO3vCKJ8R5a2jUuxVTIG7YjsJkskUsvNRYoUhw7ORHD3EaoYqq9kgVnQJS
	 Zb4WtDLzHagrpbCfyLdaujL8L5qiLGvD5p14FpDo4h6qdSi3KBXJuX2W6fOHcrfFCl
	 u6Y/PndwT7wht8uwkhxbLy/SxiQWsNJHGt65do5IcYzJg00+C792+QMn2oVv5rnwky
	 lgzycDYxX0ppQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-3a2e9851ed7so8890411fa.0
        for <linux-iio@vger.kernel.org>; Wed, 02 Sep 2026 06:48:19 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBx0xfTYUcfaeihq3lWyOK28KTHumAfZJ0t2Vg7CNf85AwzHgxOj+/Tytd62HjCBDI4FgxRy7dzQE7A=@vger.kernel.org
X-Gm-Message-State: AFuF++mZO+elgXVwoW+vYcWy4O+REO6qSoFMI2R55PXazx4bmFdlRtOp
	BiYkkG4eF/QqS/1tv7uVvywcqdQu9kSLF+cNzp+9v183rK7+PszM/lZepxj+1ZKpxoTguEKNiRU
	oJtjvBQ733KZjvuwoN3AU2z3CyHU9IU4N7H3mVYqmgw==
X-Received: by 2002:a2e:a5c8:0:b0:39c:93ff:3672 with SMTP id
 38308e7fff4ca-3a34fd26f2fmr10707401fa.9.1788356897918; Wed, 02 Sep 2026
 06:48:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 06:48:16 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 2 Sep 2026 06:48:16 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260828-ad7768-driver-v5-17-e33ca6f841a2@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com> <20260828-ad7768-driver-v5-17-e33ca6f841a2@analog.com>
Date: Wed, 2 Sep 2026 06:48:16 -0700
X-Gmail-Original-Message-ID: <CAMRc=MfV+ziruvdyFU-RTbD09E_Jhpxgaab9T6bG=tuPg-jhLA@mail.gmail.com>
X-Gm-Features: AcwNN1VIYx-Pwsr2ZnZmucPqlPq-ujuSsS8_7HEMgNrQ4Gk14ysFMLOpgl5DH4g
Message-ID: <CAMRc=MfV+ziruvdyFU-RTbD09E_Jhpxgaab9T6bG=tuPg-jhLA@mail.gmail.com>
Subject: Re: [PATCH v5 17/20] gpio: regmap: Use regmap_test_bits() for single
 bit reads
To: Janani Sunil <janani.sunil@analog.com>
Cc: linux@analog.com, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org, 
	linux-doc@vger.kernel.org, jananisunil.dev@gmail.com, 
	=?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>, 
	Andy Shevchenko <andriy.shevchenko@intel.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Linus Walleij <linusw@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Michael Walle <mwalle@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 28 Aug 2026 17:30:40 +0200, Janani Sunil <janani.sunil@analog.com> said:
> Use regmap_test_bits() when reading a single GPIO value from a normal
> register and when reading the direction bit.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Reviewed-by: Michael Walle <mwalle@kernel.org>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
> Signed-off-by: Janani Sunil <janani.sunil@analog.com>
> ---

Janani: the GPIO patches don't apply on top of current gpio/for-next. Can you
rebase and resend just the GPIO bits separately?

Thanks,
Bartosz
