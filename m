Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-gx0-f174.google.com ([209.85.161.174]:45489 "EHLO
	mail-gx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753918Ab1KCL13 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 3 Nov 2011 07:27:29 -0400
Received: by ggnb2 with SMTP id b2so1208766ggn.19
        for <linux-iio@vger.kernel.org>; Thu, 03 Nov 2011 04:27:28 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1319041134-19712-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-1-git-send-email-maxime.ripard@free-electrons.com>
	<1320315070-1700-2-git-send-email-maxime.ripard@free-electrons.com>
Date: Thu, 3 Nov 2011 12:27:28 +0100
Message-ID: <CAKnu2MqTVPxioKyr-F6JWcdF5SRZjzLSFPt5A-6CkZO7HyeHRw@mail.gmail.com>
Subject: Re: [PATCH 1/3] ARM: AT91: Add platform data for the ADCs
From: Linus Walleij <linus.ml.walleij@gmail.com>
To: Maxime Ripard <maxime.ripard@free-electrons.com>
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org,
	Nicolas Ferre <nicolas.ferre@atmel.com>,
	Patrice Vilchez <patrice.vilchez@atmel.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

2011/11/3 Maxime Ripard <maxime.ripard@free-electrons.com>:

> Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
> Cc: Patrice Vilchez <patrice.vilchez@atmel.com>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> =A0arch/arm/mach-at91/include/mach/board.h | =A0 22 +++++++++++++++++=
+++++
> =A01 files changed, 22 insertions(+), 0 deletions(-)

We're not supposed to have platform data dependent to stuff in
staging under arch/arm or anyplace else in the main kernel tree.

Please move this to
drivers/staging/iio/adc/at91adc-board.h
or so.

As for calling the at91_add_device_adc() function (which I guess
you want to do at some point) the pattern I followed for other
drivers is to declare a dummy function in arch/arm/mach-*
with __weak and let the staging driver override that. This way
the staging driver can go away without any compilation trouble
happening.

Yours,
Linus Walleij
