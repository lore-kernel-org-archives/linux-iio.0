Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:41769 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751586Ab2GJK0a (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jul 2012 06:26:30 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: Marek Vasut <marex@denx.de>
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Tue, 10 Jul 2012 12:26:20 +0200
Cc: linux-arm-kernel@lists.infradead.org, linux-iio@vger.kernel.org
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207101149.13908.jbe@pengutronix.de> <201207101208.51168.marex@denx.de>
In-Reply-To: <201207101208.51168.marex@denx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201207101226.20602.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Marek Vasut wrote:
> Dear Juergen Beisert,
>
> > Hi Marek,
> >
> > Marek Vasut wrote:
> > > > > > When I try to compile
> > > > > > your code I get:
> > > > > >
> > > > > > drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> > > > > > linux/iio/triggered_buffer.h: No such file or directory
> > > > >
> > > > > You need this patches:
> > > > >     iio:kfifo_buf Take advantage of the fixed record size used in
> > > > > IIO iio: kfifo - add poll support.
> > > > >
> > > > > And use latest -next.
> > > >
> > > > Thanks for the hints. Now it compiles and the driver seems to work.
> > > >
> > > > One thing I do not understand: It does not matter what channel I read
> > > > ('in_voltage*_raw'), only interrupt 16 ('mxs-lradc-channel0') counts
> > > > up. Intended?
> > > > Or did I a mistake by adding interrupt numbers "<13 14 15 16 17 18 19
> > > > 20 21 22 23 24 25>" to the corresponding device tree entry?
> > >
> > > They're wrong
> > >
> > > lradc@80050000 {
> > >
> > >         compatible = "fsl,imx28-lradc";
> > >         reg = <0x80050000 2000>;
> > >         interrupts = <10 14 15 16 17 18 19
> > >
> > >                         20 21 22 23 24 25>;
> > >
> > >         status = "disabled";
> > >
> > > };
> >
> > Ups, thanks. But still the same behaviour:
> >
> > $ cat /proc/interrupts
> > [...]
> >  10:          0         -  mxs-lradc-touchscreen
> >  14:          0         -  mxs-lradc-thresh0
> >  15:          0         -  mxs-lradc-thresh1
> >  16:          0         -  mxs-lradc-channel0
> >  17:          0         -  mxs-lradc-channel1
> >  18:          0         -  mxs-lradc-channel2
> >  19:          0         -  mxs-lradc-channel3
> >  20:          0         -  mxs-lradc-channel4
> >  21:          0         -  mxs-lradc-channel5
> >  22:          0         -  mxs-lradc-channel6
> >  23:          0         -  mxs-lradc-channel7
> >  24:          0         -  mxs-lradc-button0
> >  25:          0         -  mxs-lradc-button1
> > [...]
> >
> > $ cat in_voltage0_raw
> > 524
> > $ cat in_voltage1_raw
> > 96
> > $ cat in_voltage2_raw
> > 1261
> >
> > $ cat /proc/interrupts
> > [...]
> >  10:          0         -  mxs-lradc-touchscreen
> >  14:          0         -  mxs-lradc-thresh0
> >  15:          0         -  mxs-lradc-thresh1
> >  16:          3         -  mxs-lradc-channel0
> >  17:          0         -  mxs-lradc-channel1
> >  18:          0         -  mxs-lradc-channel2
> >  19:          0         -  mxs-lradc-channel3
> >  20:          0         -  mxs-lradc-channel4
> >  21:          0         -  mxs-lradc-channel5
> >  22:          0         -  mxs-lradc-channel6
> >  23:          0         -  mxs-lradc-channel7
> >  24:          0         -  mxs-lradc-button0
> >  25:          0         -  mxs-lradc-button1
> > [...]
> >
> > Intended in this way?
>
> But wait, you're getting interrupts on channel 0. Doesn't seem quite right.
> Did you happen to poke into the code and see where the issue might be?

No yet. But if you think this is not the intended behaviour of your driver I 
will do a deeper look.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
