Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A31D243847E
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 09:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791622829; cv=none; b=Y5Ja6yGltHB3Vk39/Y8BITs7HA/4Hr/B6P7ujuvotCe0nJ6D0BwueT2VH9mOaNvugQ5i4rCFRK5qst90acHruExlLn9LquN/oYqmQuQ/TiD0wmPNuGCR+Tnhp9S278Wc5DcYfUBcjsj4ALuBBeU5uVWFY8ZuelPN5d610o3Wifk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791622829; c=relaxed/simple;
	bh=Lte/nsLScDcBiY5yJmbxZYP+brdDPMqwgAjhfLPNHNo=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d+Ba2JbGGdDYvX9IY50YpoNP8zQCUdDyDG+Tzt9Pr/vxN6cjkNadUwHfVcMfuyBcS0dOb2Vms2FtFzS5UAX604hdMRXtQLo8blqqPxack2ABbao7AVHKDNej3OOu2AxobNE82v3hXlmuFRdd5wQ/0R1yEsNZg8CxK8qxvm/iz5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PGoFqEvc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PGoFqEvc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 500031F00893
	for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 09:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791622827;
	bh=Lte/nsLScDcBiY5yJmbxZYP+brdDPMqwgAjhfLPNHNo=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=PGoFqEvcXJKy1sWwaOv9spO53TdvTmJWhnhGPcKpPqI1e3GL2YdbL1YixPIguBzlT
	 uywJXLtEOa7IGThaDUCl5Mmf9T17WAocixGM5WNZg+8IdjqjCdvyFUB3aLiCW78D7n
	 e3h+TpUeJsr81MAshcgj1POPnbWeG5HQgvd5fMv2HzqUSHgN0BUk+juRI1sAC6rK7V
	 NtK3D5VQ0da6ToonJuI8fFy40PwDxAhBqaRRm7iT3FtcCXUZaCMfCO2trYA/cf3jUH
	 DX2I9cr2yzNkqE9hN9qY9thBka5okJyXkQv2FRW+43tsUO0KtEXgWD0LPH6LzB98dx
	 YRq0nUFwPDWIw==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3a98fc80925so4472891fa.0
        for <linux-iio@vger.kernel.org>; Sat, 10 Oct 2026 02:00:27 -0700 (PDT)
X-Gm-Message-State: AFq9FYKZrNT3EaYYkrqSpQfYywCgmndmWSUIrcp/nSD/gyAhyD9W720A
	I6oxpO2TggdxcEKTVu/+j/92fikRzdplJAto7vH60dj+hkzWytaVrubEGqFvFk9LP2XxExFa20M
	UfrG2OH+Ho4u5J7W8MWW8eOlD2Sy86YjZWEt5wMmQjg==
X-Received: by 2002:a05:651c:19a3:b0:3a9:c32c:fc7a with SMTP id
 38308e7fff4ca-3a9c5703e9cmr10521891fa.24.1791622825964; Sat, 10 Oct 2026
 02:00:25 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Oct 2026 02:00:24 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 10 Oct 2026 02:00:24 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20261009-iio-adc-ti-ads112c14-gpio-v2-1-3231a795fa63@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20261009-iio-adc-ti-ads112c14-gpio-v2-0-3231a795fa63@baylibre.com>
 <20261009-iio-adc-ti-ads112c14-gpio-v2-1-3231a795fa63@baylibre.com>
Date: Sat, 10 Oct 2026 02:00:24 -0700
X-Gmail-Original-Message-ID: <CAMRc=Me0drBY+Y25FCZ0wvoisd6+tBEJC=2hMQQuVs5e7vSCcg@mail.gmail.com>
X-Gm-Features: AclHuK8a_63JHyz-XaS5ghUYaXLV9_nnqQN8e9G35Uaw9iRdf52mufk5abPLkNQ
Message-ID: <CAMRc=Me0drBY+Y25FCZ0wvoisd6+tBEJC=2hMQQuVs5e7vSCcg@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] iio: adc: ti-ads112c14: parameterize GPIO register
 field macros
To: "David Lechner (TI)" <dlechner@baylibre.com>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, Chris Hall <c-hall@ti.com>, 
	Patrick Edwards <pedwards@ti.com>, Kurt Borja <kuurtb@gmail.com>, Jonathan Cameron <jic23@kernel.org>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Andy Shevchenko <andy@kernel.org>, Linus Walleij <linusw@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Sat, 10 Oct 2026 01:25:51 +0200, "David Lechner (TI)"
<dlechner@baylibre.com> said:
> Replace the per-pin GPIO register field macros with parameterized ones.
> This will be used in a later patch to access the fields by GPIO offset.
>
> Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
