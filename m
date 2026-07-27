Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFD0400998
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 13:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785157487; cv=none; b=pYfCwbSI9hBh8yrt4Yen+vrQAm1ssbBMwQd+GWhP6UwtWQdga/n++9s65brjQ/GxoAvJeYPih5fBVUM++Rbv859qsbA7zOb8l3K/t/yn8vmFjuds+uydJqEPR4Z9Yhs7Ps0b1Qxm4QR15/NvcyGdQmpvfYmBLZwVQCYM4t8inF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785157487; c=relaxed/simple;
	bh=FvvZMb8x9S1pAxv1JyWLAQwbcvNSxtZJFzzGvIDZH0o=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Xc3Le4dTDi9BQN3uffzDXWPNBEEULBw8NVFcsc7jJY2hWz45krDL+3HdOe04rvsy80B5eFq5vfiJUYORwEnBcgh0mAr2KpOl+zmyp++nIwJQ5ZSzZICw9eZjW2/3sADh1ORp68nfv+E6zxpzs4oOC6T9Xk1zlEIwPULrmz3nhek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j191yW5h; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j191yW5h"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 761DD1F00ACF
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 13:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785157485;
	bh=FvvZMb8x9S1pAxv1JyWLAQwbcvNSxtZJFzzGvIDZH0o=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=j191yW5hkvswCFrVvb33vU4VD6IEn98c6HDAWAll7cAlwU+ZoQ6fpOS5kgmbKrivo
	 7Xd/QfFQ4nuaeNCNYn7jCus1KtRQ0oX8HcyqSQgFEquESZrX18iYebWBA+m3W+Njee
	 QXBrItLmr27jVl1AMDKAMPq4qwX8qZJjG7dtKeh2f8RCTKvAVrokABeKgAeU0/C9dh
	 x3cpMPq+1T1hWnYNeeKhtz6CjgeuQ6NKLpwUl5cO5mkIem0Oud3nTULuQs8mTTFs2M
	 JIUZdVfjpb5K/gcvJQYPO9bndx65SCtMWwHs/wtxQx+F4MaK47o/dPVeBU6mQw3h+s
	 fFwJDEihkaeKg==
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5aeb59d54b1so2668148e87.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 06:04:45 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RruTWvYGadvhoKmjVC/eWxWXVCNLsCa4aYobZG9yLX6PsIjk3d4z7CIDf5GLrsqKuQjOd4Jif6CXg0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXNUehq9o/5GXKn22+yAxH8XSQQSwEG52cqy4kzfun1/ejMaCU
	9HndAhsVgCEXVorHfroQzfEh6ikCG4hpBuCZK3SRxtmvENslNzYWgwnkGl4JDZpCsa4eM0ZAFoS
	2eeTzU1jTMT9ExignIAYoVsEBjbwsqYrxMJAs7zvm7g==
X-Received: by 2002:a05:6512:3986:b0:5ae:a9ec:9fc4 with SMTP id
 2adb3069b0e04-5b2c1b49535mr1959125e87.63.1785157483940; Mon, 27 Jul 2026
 06:04:43 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 06:04:42 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 27 Jul 2026 06:04:42 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <DK9BCXS5YATK.30EPJ4G8Y72OT@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
 <20260726125209.140307-10-eleanor.lin@realtek.com> <DK97GYVRUA1Q.2JUNL4U3HPGX@bootlin.com>
 <CAMRc=MffrnN3awvAB2Ov2h=pLPNpvmZcwU=v9HBFrjLaotjskA@mail.gmail.com> <DK9BCXS5YATK.30EPJ4G8Y72OT@bootlin.com>
Date: Mon, 27 Jul 2026 06:04:42 -0700
X-Gmail-Original-Message-ID: <CAMRc=McWcFUgDP4fDs4xru1fxJMQ1JfA+k-DG7GxrN=KLMVYng@mail.gmail.com>
X-Gm-Features: AUfX_mzvIYnXX5m3Be1YUtTnZm7kR1IHALetYdwQlhjB2lN-Jk8KYGXfx6EDTIs
Message-ID: <CAMRc=McWcFUgDP4fDs4xru1fxJMQ1JfA+k-DG7GxrN=KLMVYng@mail.gmail.com>
Subject: Re: [PATCH v8 9/9] gpio: realtek: Add driver for Realtek DHC RTD1625 SoC
To: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Cc: u.kleine-koenig@baylibre.com, dakr@kernel.org, bhelgaas@google.com, 
	dlechner@baylibre.com, linux-kernel@vger.kernel.org, 
	linux-gpio@vger.kernel.org, linux@analog.com, linux-iio@vger.kernel.org, 
	cy.huang@realtek.com, james.tai@realtek.com, stanley_chang@realtek.com, 
	Yu-Chun Lin <eleanor.lin@realtek.com>, linusw@kernel.org, andriy.shevchenko@intel.com, 
	mwalle@kernel.org, tychang@realtek.com, wbg@kernel.org, nuno.sa@analog.com, 
	Michael.Hennerich@analog.com, jic23@kernel.org, andy@kernel.org, 
	o-takashi@sakamocchi.jp, Bartosz Golaszewski <brgl@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 27 Jul 2026 13:23:24 +0200, Mathieu Dubois-Briand
<mathieu.dubois-briand@bootlin.com> said:
> On Mon Jul 27, 2026 at 1:10 PM CEST, Bartosz Golaszewski wrote:
>> On Mon, 27 Jul 2026 10:20:35 +0200, Mathieu Dubois-Briand
>> <mathieu.dubois-briand@bootlin.com> said:
>>> On Sun Jul 26, 2026 at 2:52 PM CEST, Yu-Chun Lin wrote:
>>>> From: Tzuyi Chang <tychang@realtek.com>
>>>>
>>>> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs.
>>>>
>>>> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
>>>> which manages pins via shared bank registers, the RTD1625 introduces
>>>> a per-pin register architecture. Each GPIO line now has its own
>>>> dedicated 32-bit control register to manage configuration independently,
>>>> including direction, output value, input value, interrupt enable, and
>>>> debounce. Therefore, this distinct hardware design requires a separate
>>>> driver.
>>>>
>>>> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
>>>> and 'de-assert' interrupts are fired simultaneously on any edge toggle.
>>>> The driver works around this quirk to correctly handle edge interrupts.
>>>>
>>>> Interrupt support is optional for this device, matching the dt-bindings.
>>>> If the interrupts property is not provided, the driver simply skips IRQ
>>>> initialization and operates purely as a basic GPIO controller.
>>>>
>>>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>>>> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
>>>> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>>>> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>>>> ---
>>>> Changes in v8:
>>>> - Add error handlers in td1625_gpio_irq_handle().
>>>> - Move the direction-checking logic from the core to our custom
>>>> reg_mask_xlate() callback.
>>>> - Add Reviewed-by tag from Linus.
>>>> ---
>>>
>>> Thanks for the fixes.
>>>
>>> Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>>>
>>
>> Hi!
>>
>> Please leave series-wide tags under the cover letter, otherwise b4 will only
>> apply it to the specific patch under which you commented.
>>
>> Bart
>
> Sorry, this was a patch-specific review, but the way I sent it was a bit
> misleading.
>

Ah, no worries then. Is this series good to go now?

Bart
