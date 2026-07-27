Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E353DC4BC;
	Mon, 27 Jul 2026 08:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785140446; cv=none; b=D2DU6kjhJK98fafYh/wDbNjodbPHhPhlK38ild0Zn2VQC0VqIkTXyocbD2lUPaAb3l+R3dgcU6EVTcNRT+8V4ilIWKoteYFaC9zh/yTdEGJpesNnN9P9VtF/zE3yr/ovteCRNlQA6wtsuf/ZZxojBCHJtUzEJJQBrExoQX4mbCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785140446; c=relaxed/simple;
	bh=4lV3MuJSK+GCy9bYJYj1uxxJLnCM62+BK0vVOW3fu3w=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:From:To:
	 References:In-Reply-To; b=SnjBKAoeqz8u30c32+njLRXHakHHc91khXJj5KRg07gb61tdi6WXMZ3sWSZLzKShuY8oBdlgrdkHNQzA5V3FXQ2E3JInEdb4MElWwp1knB+Z+eCTVOW7VigxNGSmxcx7V6FRdcoprM0wrC3GPazVxqxcz7C+r8Gt7I++xl1+FeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=IPqP7Mha; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="IPqP7Mha"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 980321A1283;
	Mon, 27 Jul 2026 08:20:42 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6716C601BE;
	Mon, 27 Jul 2026 08:20:42 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8D32A11C12257;
	Mon, 27 Jul 2026 10:20:36 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785140441; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=4lV3MuJSK+GCy9bYJYj1uxxJLnCM62+BK0vVOW3fu3w=;
	b=IPqP7MhakrqOpAnk2q6D0BHbPShaE4CIvNH9SESDbZqEGCFQZJ8hE1mKhCAX0WS386PR9A
	SWCCamYd+flDdQf9a3Jzzt0oOXfd23sYsqnmSNyrrCjhxT26DCU+R+I898Zt0jXR2KPHsi
	fTN+JngXwKm5U4o7XcLBMuBx8jbHAN4zVI8EadP+vhpKUttdhwLRcFrbsFhANAXEBiy79Q
	0v8K2+4KoOV7MlCT1ASczHMqte3HlNnuwciswj1QLNXGsdPP9Gwi3tHfnXJSu61uCLvqXk
	Q36GGQVX+gYZb1smEN4tjDRX/4ZHDHENI0r86/yXFj96w/8/aFUbFEqVPGmRwA==
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 27 Jul 2026 10:20:35 +0200
Message-Id: <DK97GYVRUA1Q.2JUNL4U3HPGX@bootlin.com>
Subject: Re: [PATCH v8 9/9] gpio: realtek: Add driver for Realtek DHC
 RTD1625 SoC
Cc: <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>,
 <bhelgaas@google.com>, <dlechner@baylibre.com>,
 <linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
 <linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
 <james.tai@realtek.com>, <stanley_chang@realtek.com>
From: "Mathieu Dubois-Briand" <mathieu.dubois-briand@bootlin.com>
To: "Yu-Chun Lin" <eleanor.lin@realtek.com>, <linusw@kernel.org>,
 <andriy.shevchenko@intel.com>, <mwalle@kernel.org>, <brgl@kernel.org>,
 <tychang@realtek.com>, <wbg@kernel.org>, <nuno.sa@analog.com>,
 <Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
 <o-takashi@sakamocchi.jp>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
 <20260726125209.140307-10-eleanor.lin@realtek.com>
In-Reply-To: <20260726125209.140307-10-eleanor.lin@realtek.com>
X-Last-TLS-Session-Version: TLSv1.3

On Sun Jul 26, 2026 at 2:52 PM CEST, Yu-Chun Lin wrote:
> From: Tzuyi Chang <tychang@realtek.com>
>
> Add support for the GPIO controller found on Realtek DHC RTD1625 SoCs.
>
> Unlike the existing Realtek GPIO driver (drivers/gpio/gpio-rtd.c),
> which manages pins via shared bank registers, the RTD1625 introduces
> a per-pin register architecture. Each GPIO line now has its own
> dedicated 32-bit control register to manage configuration independently,
> including direction, output value, input value, interrupt enable, and
> debounce. Therefore, this distinct hardware design requires a separate
> driver.
>
> The RTD1625 GPIO controller has a hardware quirk where both 'assert'
> and 'de-assert' interrupts are fired simultaneously on any edge toggle.
> The driver works around this quirk to correctly handle edge interrupts.
>
> Interrupt support is optional for this device, matching the dt-bindings.
> If the interrupts property is not provided, the driver simply skips IRQ
> initialization and operates purely as a basic GPIO controller.
>
> Reviewed-by: Linus Walleij <linusw@kernel.org>
> Signed-off-by: Tzuyi Chang <tychang@realtek.com>
> Co-developed-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
> ---
> Changes in v8:
> - Add error handlers in td1625_gpio_irq_handle().
> - Move the direction-checking logic from the core to our custom
> reg_mask_xlate() callback.
> - Add Reviewed-by tag from Linus.
> ---

Thanks for the fixes.

Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>

--=20
Mathieu Dubois-Briand, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

