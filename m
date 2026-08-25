Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86ED221257F
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 19:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787686688; cv=none; b=tk5hb53J3Gygd1N6w93i46fZCCA28nz+1MMeaFdmlAoduJtzmbIoGkcfFpJRRwZuSEoWu47PpMWV6BEvoxM9MXsJ7L571msR3ZN6WAEfkuBtewYJc948rlnPWciY367fiHpaiPrILfgVUzKFS3XaZxdYz4VYr5gaP2MpGHmpLR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787686688; c=relaxed/simple;
	bh=SWbroc8/MCw9vxVlYl/4VAEoP9c1A5tAlEz8D7j9fsw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Aa+kknxTFIO8AXWC9vhQJZSeiKXSmKtlaYECfyQP3pBxRQ8tJS64VWsfLUcxbaa9M7E5vSLthp2BO0nuQt321qxf39+CgMp2cVBpgSC40oHZIqNndasRaujcXeN/I6zQ5hnl2ze7HORT2+v4ooXfq0wD3fANLekaXzlcxbh/ISQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=E7eOTiF4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="E7eOTiF4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3411A1F00AC4
	for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 19:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787686687;
	bh=CyOe2SnaXiEdwTEOdz+tYif2V73DTIK8sHaSwuCYEzg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=E7eOTiF4Rjfo2TkLyaA8nTES3PRdQMoEKhTpd2kOLMOB7pjnunJZ9ZqwQfn/UBFMW
	 uKsHljLEK1rVim0TAgTRvNBJVW6Yp4pGk0BUw2m776vX+hMNqFZUujBVG9bQnjKBiZ
	 7npWPVdOnHwdt9Q9psgTWTv7vs9g4we03TMlqU69qUrzG//0JG62HjN4+6oOYdRIFI
	 YGjz6Hi2ystxn5D2xJNV9sEBAYIFW1wcGru97/uq4bcnnCXgpgyt2NmtVUQqb6p/qk
	 2ha5B0S7EtVqpZVyazWMa8l5wi5y4cbBK1oMwE03IUSd4pIpyWqamhUQyFfY572JoX
	 DJqcr64ArYUVQ==
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5b01146b205so100967e87.2
        for <linux-iio@vger.kernel.org>; Tue, 25 Aug 2026 12:38:07 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rp9jfW6KYWsxT1BaadmNwVoWeJtBmMm/5uMWjqafzQxCUVjgmnNzIdBpvgq5H80vJMCSDC7GuzOZ7o=@vger.kernel.org
X-Gm-Message-State: AFuF++lie9obdKlgDhUVrzaxzIa+SDPRACMxsc3yWOH6WtkB4wDanB4U
	4Rthx8ht+utuu/pXpZpBlNqQIWeEInGW9u4iRiCCbzyJGEN9/WrtTgqcEmZtwPDOTxVOafrrAsw
	Y9zo31wC+shqlWMhUjjmzHa40OrTTODI=
X-Received: by 2002:ac2:51cc:0:b0:5ae:b88f:311e with SMTP id
 2adb3069b0e04-5b4a9076950mr171817e87.15.1787686685898; Tue, 25 Aug 2026
 12:38:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
 <20260821-ad7768-driver-v4-13-bb8fbd06d4eb@analog.com> <20260823203947.3ecdc448@jic23-huawei>
In-Reply-To: <20260823203947.3ecdc448@jic23-huawei>
From: Linus Walleij <linusw@kernel.org>
Date: Tue, 25 Aug 2026 21:37:53 +0200
X-Gmail-Original-Message-ID: <CAD++jLkXErT=xuZuztni-bBEiJwOQ3Vn1v3xFP8GhvVwQN+cxA@mail.gmail.com>
X-Gm-Features: AcwNN1Wfn_GPyNETadGJ9VzNg32pC-dhgPaQs1CtffZnbkHUT2dj_VE2DJo6QJk
Message-ID: <CAD++jLkXErT=xuZuztni-bBEiJwOQ3Vn1v3xFP8GhvVwQN+cxA@mail.gmail.com>
Subject: Re: [PATCH v4 13/14] gpio: ad7768: Add AD7768 GPIO auxiliary driver
To: Jonathan Cameron <jic23@kernel.org>
Cc: Janani Sunil <janani.sunil@analog.com>, =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, David Lechner <dlechner@baylibre.com>, 
	Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Olivier Moysan <olivier.moysan@foss.st.com>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Michael Walle <mwalle@kernel.org>, linux@analog.com, linux-iio@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux-doc@vger.kernel.org, 
	jananisunil.dev@gmail.com, =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= <u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Aug 23, 2026 at 9:39=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:

> Linus W, for I think that (when you are happy) you can pick up this
> and the previous two enabling patches via the gpio tree and I'll take
> the rest via IIO.  One small wrinkle around the maintainers entry that
> we can fudge in various ways.

Bartosz merges the GPIO tree, but yeah, he'll probably
pick it! (I'll review it for sure.)

Yours,
Linus Walleij
