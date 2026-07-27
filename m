Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E85288C0E;
	Mon, 27 Jul 2026 11:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785151421; cv=none; b=t9bsMNYC0D7STUMWjMqC7q4qyMHd9S5HPiuixYianatQg4UFDQ7+3OKe/gqvF78BBOZCaEGb6x2jlTwKsFSahjXnFohL+MpM/uypTjLzhJHHUNuEicct+TNDDIxQtg62yJbL4ILUSjXlACUS6rSC0fK61sfGHmAC2QBot+FvKLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785151421; c=relaxed/simple;
	bh=1G7JnOokAfJ3DXBl85FdZBKXYz2pC54z3bm1DIaVnZY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=a10UI9UtvN2ZVx8s2nUH/OmrRe2eTQlcF11al1ijoCMsuYTmVXJ0574+H9sr8xJO6NdZd7JkfkhYJ0JQbU8CeTNLVyivDa54N6cM9mjitbMKlYwh0I3LQC14QB1rqkqRXH+xvR0q9qXiC1qlwMYnCHKuhsbAXGKlEYIE18cEzWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=O+G44hZA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="O+G44hZA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id DBBE04E40F98;
	Mon, 27 Jul 2026 11:23:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 91648601BE;
	Mon, 27 Jul 2026 11:23:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC68F11C1328E;
	Mon, 27 Jul 2026 13:23:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785151410; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1G7JnOokAfJ3DXBl85FdZBKXYz2pC54z3bm1DIaVnZY=;
	b=O+G44hZAhfXms7j7J9rcu43c2So7+RadMvuHBc2gokOnIw9KEg2bRmF8PCtgcKswRksKPY
	Qw3NTicGiqFziz5HoAZ0ZAePg+1ab0QUh/U+Js4OSw4gKj/BQMF5jryOqNDegvQYOF2LsB
	NogkDflsvg0t7zqdwOYrGBVy5eFxVUmJhDCuqwODdC2SZB/ZukEY7PsaHwkhhzf0ehfbgX
	Aiy7DKNlC8sTejbg2ZM6Cs1M8nfygMgzpgpNyHq261ydNz5eRkbMkpjMGpB/UYITA/dZl6
	19F0402CdSBxPaju9C1JCgvwjJtgjT43T3R2GL+gNxutU1NoFek9TKFFCWUf/Q==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 13:23:24 +0200
Message-Id: <DK9BCXS5YATK.30EPJ4G8Y72OT@bootlin.com>
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
In-Reply-To: <CAMRc=MffrnN3awvAB2Ov2h=pLPNpvmZcwU=v9HBFrjLaotjskA@mail.gmail.com>
X-Last-TLS-Session-Version: TLSv1.3

On Mon Jul 27, 2026 at 1:10 PM CEST, Bartosz Golaszewski wrote:
> On Mon, 27 Jul 2026 10:20:35 +0200, Mathieu Dubois-Briand
> <mathieu.dubois-briand@bootlin.com> said:
>> On Sun Jul 26, 2026 at 2:52 PM CEST, Yu-Chun Lin wrote:
>>> From: Tzuyi Chang <tychang@realtek.com>
>>>
>>> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs.
>>>
>>> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
>>> which manages pins via shared bank registers, the RTD1625 introduces
>>> a per-pin register architecture. Each GPIO line now has its own
>>> dedicated 32-bit control register to manage configuration independently=
,
>>> including direction, output value, input value, interrupt enable, and
>>> debounce. Therefore, this distinct hardware design requires a separate
>>> driver.
>>>
>>> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
>>> and 'de-assert' interrupts are fired simultaneously on any edge toggle.
>>> The driver works around this quirk to correctly handle edge interrupts.
>>>
>>> Interrupt support is optional for this device, matching the dt-bindings=
.
>>> If the interrupts property is not provided, the driver simply skips IRQ
>>> initialization and operates purely as a basic GPIO controller.
>>>
>>> Reviewed-by: Linus Walleij <linusw@kernel.org>
>>> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
>>> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>>> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
>>> ---
>>> Changes in v8:
>>> - Add error handlers in td1625_gpio_irq_handle().
>>> - Move the direction-checking logic from the core to our custom
>>> reg_mask_xlate() callback.
>>> - Add Reviewed-by tag from Linus.
>>> ---
>>
>> Thanks for the fixes.
>>
>> Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
>>
>
> Hi!
>
> Please leave series-wide tags under the cover letter, otherwise b4 will o=
nly
> apply it to the specific patch under which you commented.
>
> Bart

Sorry, this was a patch-specific review, but the way I sent it was a bit
misleading.

Thanks,
Mathieu

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

