Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ww0-f42.google.com ([74.125.82.42]:33000 "EHLO
	mail-ww0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854Ab1JJB3t convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 9 Oct 2011 21:29:49 -0400
Received: by wwn22 with SMTP id 22so3206814wwn.1
        for <linux-iio@vger.kernel.org>; Sun, 09 Oct 2011 18:29:48 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1318178172-7965-5-git-send-email-zoss@devai.org>
References: <1318178172-7965-1-git-send-email-zoss@devai.org>
	<1318178172-7965-5-git-send-email-zoss@devai.org>
Date: Mon, 10 Oct 2011 03:29:48 +0200
Message-ID: <CAKnu2MrAEbS-36YaU+i6+zhwH4KW7ST7-mkKT49tv7jhhSo2UQ@mail.gmail.com>
Subject: Re: [PATCH 4/9] ARM: SPMP8000: Add ADC driver
From: Linus Walleij <linus.walleij@linaro.org>
To: Zoltan Devai <zoss@devai.org>
Cc: linux-arm-kernel@lists.infradead.org,
	Arnd Bergmann <arnd@arndb.de>, linux-iio@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2011/10/9 Zoltan Devai <zoss@devai.org>:

> Signed-off-by: Zoltan Devai <zoss@devai.org>
> ---
> =A0arch/arm/mach-spmp8000/adc.c =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0| =A0465 +++++++++++++++++++++
> =A0arch/arm/mach-spmp8000/include/mach/spmp8000adc.h | =A0 29 ++

I think we stopped stuffing misc drivers under arch/arm/*

And stuffing them under drivers/misc/* won't be popular either.

IIO has some ADCs in drivers/staging/iio/adc
these seem all to be intended to be used from userspace.

There are a few in-kernel ADCs all over the kernel tree
for various specific purposes.

I don't know where we should go with this kind of stuff,
really :-/

Yours,
Linus Walleij
