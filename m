Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:46048 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753493Ab3IWODo convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 10:03:44 -0400
From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
To: Lothar =?utf-8?q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
Subject: Re: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 23 Sep 2013 16:05:03 +0200
Cc: linux-arm-kernel@lists.infradead.org, Marek Vasut <marex@denx.de>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	fabio.estevam@freescale.com, jic23@cam.ac.uk
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de> <201309231524.38008.jbe@pengutronix.de> <21056.17602.24566.144289@ipc1.ka-ro>
In-Reply-To: <21056.17602.24566.144289@ipc1.ka-ro>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201309231605.03860.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Lothar,

On Monday 23 September 2013 15:40:18 Lothar Waßmann wrote:
> Jürgen Beisert writes:
> > The i.MX28 manual says the LRADC delay unit is driven by a 2 kHz clock,
> > but does not say what kind of clock it is (or is derived from). I guess
> > now, this clock isn't enabled and thus the delay unit can't work. At
> > least on the MX28EVK. On your TX28 platform the clock seems enabled and
> > the delay unit can do its job and drive the state machine.
>
> The i.MX28 Ref Manual states in chapter 38.5.14 LRADC Scheduling Delay:
> | This counter operates on a 2KHz clock derived from crystal clock.
>
> Thus the clock should always be enabled.

But it isn't always on. I have now added the correct clock_get() call to the 
LRADC driver and the touchscreen works again on the MX28EVK. New patch series 
will follow. Same is required for i.MX23.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
