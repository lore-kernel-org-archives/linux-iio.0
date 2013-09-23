Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.karo-electronics.de ([81.173.242.67]:61421 "EHLO
	mail.karo-electronics.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753505Ab3IWNlF (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 09:41:05 -0400
Message-ID: <21056.17602.24566.144289@ipc1.ka-ro>
Date: Mon, 23 Sep 2013 15:40:18 +0200
From: =?utf-8?Q?Lothar_Wa=C3=9Fmann?= <LW@KARO-electronics.de>
To: =?utf-8?Q?J=C3=BCrgen?= Beisert <jbe@pengutronix.de>
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	fabio.estevam@freescale.com, jic23@cam.ac.uk
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Subject: Re: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver implementation
In-Reply-To: <201309231524.38008.jbe@pengutronix.de>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de>
	<201309231235.56309.jbe@pengutronix.de>
	<21056.12306.714098.398250@ipc1.ka-ro>
	<201309231524.38008.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi,

Jürgen Beisert writes:
> The i.MX28 manual says the LRADC delay unit is driven by a 2 kHz clock, but 
> does not say what kind of clock it is (or is derived from). I guess now, this 
> clock isn't enabled and thus the delay unit can't work. At least on the 
> MX28EVK. On your TX28 platform the clock seems enabled and the delay unit can 
> do its job and drive the state machine.
>
The i.MX28 Ref Manual states in chapter 38.5.14 LRADC Scheduling Delay:
| This counter operates on a 2KHz clock derived from crystal clock.
Thus the clock should always be enabled.


Lothar Waßmann
-- 
___________________________________________________________

Ka-Ro electronics GmbH | Pascalstraße 22 | D - 52076 Aachen
Phone: +49 2408 1402-0 | Fax: +49 2408 1402-10
Geschäftsführer: Matthias Kaussen
Handelsregistereintrag: Amtsgericht Aachen, HRB 4996

www.karo-electronics.de | info@karo-electronics.de
___________________________________________________________
