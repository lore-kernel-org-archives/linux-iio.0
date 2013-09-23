Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:51943 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753518Ab3IWNjX convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 09:39:23 -0400
From: =?utf-8?q?J=C3=BCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 23 Sep 2013 15:40:46 +0200
Cc: Marek Vasut <marex@denx.de>, devel@driverdev.osuosl.org,
	fabio.estevam@freescale.com, linux-iio@vger.kernel.org,
	jic23@cam.ac.uk,
	Lothar =?utf-8?q?Wa=C3=9Fmann?= <LW@karo-electronics.de>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de> <21056.12306.714098.398250@ipc1.ka-ro> <201309231524.38008.jbe@pengutronix.de>
In-Reply-To: <201309231524.38008.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="utf-8"
Message-Id: <201309231540.46470.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


On Monday 23 September 2013 15:24:37 Jürgen Beisert wrote:
> Hi Lothar,
>
> On Monday 23 September 2013 14:12:02 Lothar Waßmann wrote:
> > [...]
> >
> > > @Lothar: What kernel revision did you use? I had to go back to 3.9 to
> > > get a
> >
> > Current linux-next (3.12-rc1).
>
> Okay.
>
> > > working kernel on the MX28EVK. More recent vanilla kernels stop working
> > > (MMC and network fail here).
> >
> > I'm seeing some messages:
> > |mxs-mmc 80010000.ssp: dummy supplies not allowed
> > |fec 800f0000.ethernet: dummy supplies not allowed
>
> It was my fault. I'm also working with 3.12-rc1 now.
>
> > But without any apparent consequences. Maybe that's a problem with the
> > MX28EVK?
>
> It seems the LRADC delay feature does not work. The touch detection
> interrupt happens and the driver switches to the Y plate measurement, arms
> the LRADC delay unit ... and nothing more happens. The LRADC delay unit
> should start a conversion on ADC channel 4. But it does not. Never.
>
> The i.MX28 manual says the LRADC delay unit is driven by a 2 kHz clock, but
> does not say what kind of clock it is (or is derived from). I guess now,
> this clock isn't enabled and thus the delay unit can't work. At least on
> the MX28EVK. On your TX28 platform the clock seems enabled and the delay
> unit can do its job and drive the state machine.

Hmmm: 24 MHz / 750  = CLK_32K / 16 = CLK_LRADC2K

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | Phone: +49-5121-206917-5128 |
Peiner Str. 6-8, 31137 Hildesheim, Germany    | Fax:   +49-5121-206917-5555 |
Amtsgericht Hildesheim, HRA 2686              | http://www.pengutronix.de/  |
