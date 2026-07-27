Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 574BD3ED5A6
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785150663; cv=none; b=njV0GK21vDrB05Z2JaxLrb0F1WVAXlqjari4BuNewHl3fdeapLf9YK+mXx2LTgt2WFlNyYhvPj5v2PmXPcKsJNSDFDk/aveifhS1OF0F3kAoaZvZPg3PkgTBC1k2dHkK86Ag+xKLfdWORmxgVR0Kc7pBhh/udoKbzt3XD2M/UOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785150663; c=relaxed/simple;
	bh=yO6KjTz+TL97BceoIym3jAch/Lg0YVp2mfCYyR9CFlc=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eX8FlM+NRkDf5xsUwCZuTEb5HZDyvS7XefFoIPNhbjQWLty5SW9E5DhbpJ5XyuSpPWtxeAaBA74ZntxmJ5/cX92zHhQ65FvvzUUEXmh+DyYuT7RPuf/ikvcZrBNB8GeZOGEZCCSVzm3yr2x6kEaws7xc6Y73qwspbCVq7DQLbZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW8mCKgn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW8mCKgn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 144B81F00ADF
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:11:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785150662;
	bh=yO6KjTz+TL97BceoIym3jAch/Lg0YVp2mfCYyR9CFlc=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=fW8mCKgnrgpzyhQx+KgX44IaFiIKfZpmU7aKByfbXtKINfvc5BgFihoG59SoSt0HX
	 BBQ7fD7MUaiYdM1vvG1RH3wGvCoruGGY0tI9xzGKZcRAmKTCm8NZ5ePaR+WBy3ea9O
	 SLWs2yrotnD5LqQvUSZs9qNQHPEUUvgWGPdzbdqYeKtQPQRfkW5b1fWLzHkqKYYAk2
	 r/l/cgCpkjAVYT/fmCqHFxS5kfM1lHMLLHI8bnCymzTeCPx8AqiGLtRBic8nXQ84rb
	 sAapOh7UHeWc0o90/bJoGvlpmwYsQZc9FjrL3zI9rBnkbj/mZ8gLwZ/vD2VksN5jNk
	 wZBUcApEOAOUA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-39c9bb9d2fbso22193561fa.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 04:11:01 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RrzbIhZ19cRpAD7zS/qOUpa8AIYTx3o/HKuPDQ7a9dxe76E1UADDK5PYSvqz4QDJ5Lcdu6pZru6qa8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxTHQ9TkCsbT3xaVv8AsZ4Lz2+tM6Xys5OBW82N/UrAVlV3u2bi
	t5oxQa4rNMwgs4ZgayxJ7s7utvEe66vfukUx5nxSrU5VC3lzIzaswOyBmnhDHUWCpff3+FYfWnT
	paay1bKTxd+Lk5kLbqWCiGGjl5uMkQIHKhi/YLN9xlQ==
X-Received: by 2002:a05:6512:3a8e:b0:5b2:9a03:aa4d with SMTP id
 2adb3069b0e04-5b2c1b54887mr1593190e87.61.1785150660696; Mon, 27 Jul 2026
 04:11:00 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 04:10:58 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 04:10:58 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <DK97GYVRUA1Q.2JUNL4U3HPGX@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
 <20260726125209.140307-10-eleanor.lin@realtek.com> <DK97GYVRUA1Q.2JUNL4U3HPGX@bootlin.com>
Date: Mon, 27 Jul 2026 04:10:58 -0700
X-Gmail-Original-Message-ID: <CAMRc=MffrnN3awvAB2Ov2h=pLPNpvmZcwU=v9HBFrjLaotjskA@mail.gmail.com>
X-Gm-Features: AUfX_mxGYxGFmDfHEzLMuMha_HnGsqKsRuht2bgrxQav9IbY-x-37rzeszUt0HM
Message-ID: <CAMRc=MffrnN3awvAB2Ov2h=pLPNpvmZcwU=v9HBFrjLaotjskA@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] gpio: realtek: Add driver for Realtek DHC RTD1625 SoC
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com, 
	dlechner@baylibre.com, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
	cy.huang@realtek.com, james.tai@realtek.com, stanley_chang@realtek.com, 
	Yu-Chun Lin <eleanor.lin@realtek.com>, linusw@kernel.org, andriy.shevchenko@intel.com, 
	mwalle@kernel.org, brgl@kernel.org, tychang@realtek.com, wbg@kernel.org, 
	nuno.sa@analog.com, Michael.Hennerich@analog.com, jic23@kernel.org, 
	andy@kernel.org, o-takashi@sakamocchi.jp
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 10:20:35 +0200, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> said:
> On Sun Jul 26, 2026 at 2:52 PM CEST, Yu-Chun Lin wrote:
>> From: Tzuyi Chang <tychang@realtek.com>
>>
>> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs.
>>
>> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
>> which manages pins via shared bank registers, the RTD1625 introduces
>> a per-pin register architecture. Each GPIO line now has its own
>> dedicated 32-bit control register to manage configuration independently,
>> including direction, output value, input value, interrupt enable, and
>> debounce. Therefore, this distinct hardware design requires a separate
>> driver.
>>
>> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
>> and 'de-assert' interrupts are fired simultaneously on any edge toggle.
>> The driver works around this quirk to correctly handle edge interrupts.
>>
>> Interrupt support is optional for this device, matching the dt-bindings.
>> If the interrupts property is not provided, the driver simply skips IRQ
>> initialization and operates purely as a basic GPIO controller.
>>
>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
>> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>> ---
>> Changes in v8:
>> - Add error handlers in td1625_gpio_irq_handle().
>> - Move the direction-checking logic from the core to our custom
>> reg_mask_xlate() callback.
>> - Add Reviewed-by tag from Linus.
>> ---
>
> Thanks for the fixes.
>
> Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>

Hi!

Please leave series-wide tags under the cover letter, otherwise b4 will only
apply it to the specific patch under which you commented.

Bart
