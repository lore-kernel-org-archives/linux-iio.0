Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222332FB97B;
	Mon, 27 Jul 2026 14:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785161274; cv=none; b=RvbNYoKA5z1K209h4dbgf8SmlSvH90/YuJgH7etqQxo4nor1h2oaR3pOA46sOW53qbErzQFOgsEuXIuRcWO5wiCxK1jXsQe+CbYqILNlGjmXLYLdsiTcgMl6fx1Wpqe8mU2ve4A56uwZc+8EzGKfLbwEfXPWLLKQT4D++jli70c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785161274; c=relaxed/simple;
	bh=e4cDXtFkEDPXdANVSDJpdDqWb1ANgIXxCmnVMwtinmA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=cqCvbHXjxSm7LJr7KKIcjewfv17XaWZbl9sGIgeg2TFmABiyEM8hWgj75t5r9+gAwEkwGhcimBKYb8OeWLn/6q39o+GiytK1vrxlhiheasphi4iQJ6nKsFmxxt+qmwVYY198GU++O9CkBNQ+cXvTXgz2dZvNzSHw1I4ZFwFmXGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=RlNUpprJ; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="RlNUpprJ"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 63A361A1293;
	Mon, 27 Jul 2026 14:07:49 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 26A46601BE;
	Mon, 27 Jul 2026 14:07:49 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 460E311C12035;
	Mon, 27 Jul 2026 16:07:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785161263; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=e4cDXtFkEDPXdANVSDJpdDqWb1ANgIXxCmnVMwtinmA=;
	b=RlNUpprJeR6vOwiT6tKc8DZzQRxRZyDCum0+rLaY+ARgBJYRydAgu/myRaV6dQBwMR6TVv
	7BfDhU8HeUD9/fC9LzydFHMXUYFhnPhI8aBqWumEGgkNY80qRqI7yhnlC4Bc/w/KNIsEH7
	X3d6WJV38ZtuP+gSQa5GPCtBOHM7k9wCXD2JshvsRnZEWlb8DV9uCfK8kLatJET240F2WP
	zHbSSuhSHoM7pLpVYq+6mMzmbK8CgLZ3J9Vx5UqoUvvszq5zmQd8Itf6F0L/dVeGXUEZwD
	EXnR0dsuumoRdbfI+AQjk5fXPnOCqODiGO7ZlfJXTZz8ZDHz4VerrUlok/1s9A==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 16:07:37 +0200
Message-Id: <DK9EUOC80S34.2D56HD6OJQ3IN@bootlin.com>
Subject: Re: [PATCH v8 9/9] gpio: realtek: Add driver for Realtek DHC
 RTD1625 SoC
Cc: <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <dlechner@baylibre.com>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>, <stanley_chang@realtek.com>, "Yu-Chun Lin"
 <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <mwalle@kernel.org>, <tychang@realtek.com>,
 <wbg@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
 <jic23@kernel.org>, <andy@kernel.org>, <o-takashi@sakamocchi.jp>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Bartosz Golaszewski" <brgl@kernel.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
 <20260726125209.140307-10-eleanor.lin@realtek.com>
 <DK97GYVRUA1Q.2JUNL4U3HPGX@bootlin.com>
 <CAMRc=MffrnN3awvAB2Ov2h=pLPNpvmZcwU=v9HBFrjLaotjskA@mail.gmail.com>
 <DK9BCXS5YATK.30EPJ4G8Y72OT@bootlin.com>
 <CAMRc=McWcFUgDP4fDs4xru1fxJMQ1JfA+k-DG7GxrN=KLMVYng@mail.gmail.com>
In-Reply-To: <CAMRc=McWcFUgDP4fDs4xru1fxJMQ1JfA+k-DG7GxrN=KLMVYng@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 27, 2026 at 3:04 PM CEST, Bartosz Golaszewski wrote:
> On Mon, 27 Jul 2026 13:23:24 +0200, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> said:
>> On Mon Jul 27, 2026 at 1:10 PM CEST, Bartosz Golaszewski wrote:
>>> On Mon, 27 Jul 2026 10:20:35 +0200, Mathieu Dubois-Briand
>>> <mathieu.dubois-briand@bootlin.com> said:
>>>> On Sun Jul 26, 2026 at 2:52 PM CEST, Yu-Chun Lin wrote:
>>>>> From: Tzuyi Chang <tychang@realtek.com>
>>>>>
>>>>> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs=
.
>>>>>
>>>>> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
>>>>> which manages pins via shared bank registers, the RTD1625 introduces
>>>>> a per-pin register architecture. Each GPIO line now has its own
>>>>> dedicated 32-bit control register to manage configuration independent=
ly,
>>>>> including direction, output value, input value, interrupt enable, and
>>>>> debounce. Therefore, this distinct hardware design requires a separat=
e
>>>>> driver.
>>>>>
>>>>> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
>>>>> and 'de-assert' interrupts are fired simultaneously on any edge toggl=
e.
>>>>> The driver works around this quirk to correctly handle edge interrupt=
s.
>>>>>
>>>>> Interrupt support is optional for this device, matching the dt-bindin=
gs.
>>>>> If the interrupts property is not provided, the driver simply skips I=
RQ
>>>>> initialization and operates purely as a basic GPIO controller.
>>>>>
>>>>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>>>>> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
>>>>> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>>>>> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>>>>> ---
>>>>> Changes in v8:
>>>>> - Add error handlers in td1625_gpio_irq_handle().
>>>>> - Move the direction-checking logic from the core to our custom
>>>>> reg_mask_xlate() callback.
>>>>> - Add Reviewed-by tag from Linus.
>>>>> ---
>>>>
>>>> Thanks for the fixes.
>>>>
>>>> Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>>>>
>>>
>>> Hi!
>>>
>>> Please leave series-wide tags under the cover letter, otherwise b4 will=
 only
>>> apply it to the specific patch under which you commented.
>>>
>>> Bart
>>
>> Sorry, this was a patch-specific review, but the way I sent it was a bit
>> misleading.
>>
>
> Ah, no worries then. Is this series good to go now?
>
> Bart

It is good to go on my side, I made the comments I had.

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

