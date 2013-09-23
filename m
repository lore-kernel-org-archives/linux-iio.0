Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:58646 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753498Ab3IWKec convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 23 Sep 2013 06:34:32 -0400
From: =?iso-8859-1?q?J=FCrgen_Beisert?= <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCHv5] staging/iio/adc: change the MXS touchscreen driver implementation
Date: Mon, 23 Sep 2013 12:35:56 +0200
Cc: Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org, fabio.estevam@freescale.com,
	jic23@cam.ac.uk,
	Lothar =?iso-8859-1?q?Wa=DFmann?= <LW@karo-electronics.de>
References: <1379593369-22010-1-git-send-email-jbe@pengutronix.de> <201309230155.04914.marex@denx.de> <201309230955.58828.jbe@pengutronix.de>
In-Reply-To: <201309230955.58828.jbe@pengutronix.de>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201309231235.56309.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi Marek,

On Monday 23 September 2013 09:55:58 Jürgen Beisert wrote:
> On Monday 23 September 2013 01:55:04 Marek Vasut wrote:
> > > The following series replaces the current busy loop touchscreen
> > > implementation for i.MX28/i.MX23 SoCs by a fully interrupt driven
> > > implementation.
> > >
> > > Since i.MX23 and i.MX28 silicon differs, the existing implementation
> > > can be used for the i.MX28 SoC only.
> > >
> > > So, the first two patches of this series move the i.MX28 specific
> > > definitions out of the way. The third patch simplifies the register
> > > access to make it easier to add the i.MX23 support. Then the i.MX23
> > > specific definitions are added, also the code to distinguish both SoCs
> > > at run-time. Up to here the existing touchscreen driver will now run on
> > > an i.MX23 Soc as well.
> > >
> > > When the i.MX23 SoC is running from battery it seems not to be a good
> > > idea to run a busy loop to detect touches and their location. The
> > > fourth patch adds a fully interrupt driven implementation which makes
> > > use of the built-in delay and multiple sample features of the
> > > touchscreen controller. This will reduce the interrupt load to a
> > > minimum.
> > >
> > > The next to last patch in this series just removes the existing busy
> > > loop implementation.
> > >
> > > The last patch adds a devicetree bindings proposal (to be discussed).
> > >
> > > Some restrictions/questions:
> > >
> > > - the touchscreen part is yet tested on i.MX23 SoC only
> > > - has someone a good idea how to implement a reliable pressure
> > > measurement if the resistances of the touchscreen's plates are unknown?
> > >
> > > Changes since v4:
> > >
> > > - honor Jonathan's comments about function names
> > > - honor Dmitry's comments about workqueue canceling and interrupts
> > > - adding devicetree bindings proposal
> > >
> > > Changes since v3:
> > >
> > > - split adding register access functions and i.MX23 support into two
> > > patches
> > >
> > > Changes since v2:
> > >
> > > - useless debug output removed
> > >
> > > Changes since v1:
> > >
> > > - adding register access functions to make the existing code more
> > > readable - adding some functions to distinguish the SoCs at run-time to
> > > avoid if-else contructs whenever differences in the register layout
> > > between i.MX23 and i.MX28 must be handled
> >
> > Just tested this on M28EVK, the touchscreen is dead. I do not get any
> > touch events when I use ts_calibrate and when I hd /dev/input/eventX , I
> > get nothing either.
> >
> > Right now, I'm somehow on a tight schedule, but I'd like to see this
> > resolved ASAP. Do you have any hint for me ?
>
> Seems the very first touch detection does not work. A colleague just told
> me, we have an i.MX28 based hardware here and maybe a touchscreen from a
> different platform which maybe can be used with the i.MX28 platform. Stay
> tuned...

I also found an MX28EVK with a touchscreen here and: yes it does not work with 
the modified driver. But now I'm confused, because of Lothar's statement about 
the TX28 platform.

@Lothar: What kernel revision did you use? I had to go back to 3.9 to get a 
working kernel on the MX28EVK. More recent vanilla kernels stop working (MMC 
and network fail here).

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
