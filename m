Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([92.198.50.35]:49815 "EHLO
	metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752678Ab2GJKli (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 10 Jul 2012 06:41:38 -0400
From: Juergen Beisert <jbe@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] IIO: Add basic MXS LRADC driver
Date: Tue, 10 Jul 2012 12:41:23 +0200
Cc: "Lars-Peter Clausen" <lars@metafoo.de>,
	Marek Vasut <marex@denx.de>, linux-iio@vger.kernel.org
References: <1341368129-20468-1-git-send-email-marex@denx.de> <201207101226.20602.jbe@pengutronix.de> <4FFC056B.7020106@metafoo.de>
In-Reply-To: <4FFC056B.7020106@metafoo.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <201207101241.24151.jbe@pengutronix.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Lars-Peter Clausen wrote:
> On 07/10/2012 12:26 PM, Juergen Beisert wrote:
> > Marek Vasut wrote:
> >> Dear Juergen Beisert,
> >>
> >>> Hi Marek,
> >>>
> >>> Marek Vasut wrote:
> >>>>>>> When I try to compile
> >>>>>>> your code I get:
> >>>>>>>
> >>>>>>> drivers/staging/iio/adc/mxs-lradc.c:42:40: fatal error:
> >>>>>>> linux/iio/triggered_buffer.h: No such file or directory
> >>>>>>
> >>>>>> You need this patches:
> >>>>>>     iio:kfifo_buf Take advantage of the fixed record size used in
> >>>>>> IIO iio: kfifo - add poll support.
> >>>>>>
> >>>>>> And use latest -next.
> >>>>>
> >>>>> Thanks for the hints. Now it compiles and the driver seems to work.
> >>>>>
> >>>>> One thing I do not understand: It does not matter what channel I read
> >>>>> ('in_voltage*_raw'), only interrupt 16 ('mxs-lradc-channel0') counts
> >>>>> up. Intended?
> >>>>> Or did I a mistake by adding interrupt numbers "<13 14 15 16 17 18 19
> >>>>> 20 21 22 23 24 25>" to the corresponding device tree entry?
> >>>>
> >>>> They're wrong
> >>>>
> >>>> lradc@80050000 {
> >>>>
> >>>>         compatible = "fsl,imx28-lradc";
> >>>>         reg = <0x80050000 2000>;
> >>>>         interrupts = <10 14 15 16 17 18 19
> >>>>
> >>>>                         20 21 22 23 24 25>;
> >>>>
> >>>>         status = "disabled";
> >>>>
> >>>> };
> >>>
> >>> Ups, thanks. But still the same behaviour:
> >>>
> >>> $ cat /proc/interrupts
> >>> [...]
> >>>  10:          0         -  mxs-lradc-touchscreen
> >>>  14:          0         -  mxs-lradc-thresh0
> >>>  15:          0         -  mxs-lradc-thresh1
> >>>  16:          0         -  mxs-lradc-channel0
> >>>  17:          0         -  mxs-lradc-channel1
> >>>  18:          0         -  mxs-lradc-channel2
> >>>  19:          0         -  mxs-lradc-channel3
> >>>  20:          0         -  mxs-lradc-channel4
> >>>  21:          0         -  mxs-lradc-channel5
> >>>  22:          0         -  mxs-lradc-channel6
> >>>  23:          0         -  mxs-lradc-channel7
> >>>  24:          0         -  mxs-lradc-button0
> >>>  25:          0         -  mxs-lradc-button1
> >>> [...]
> >>>
> >>> $ cat in_voltage0_raw
> >>> 524
> >>> $ cat in_voltage1_raw
> >>> 96
> >>> $ cat in_voltage2_raw
> >>> 1261
> >>>
> >>> $ cat /proc/interrupts
> >>> [...]
> >>>  10:          0         -  mxs-lradc-touchscreen
> >>>  14:          0         -  mxs-lradc-thresh0
> >>>  15:          0         -  mxs-lradc-thresh1
> >>>  16:          3         -  mxs-lradc-channel0
> >>>  17:          0         -  mxs-lradc-channel1
> >>>  18:          0         -  mxs-lradc-channel2
> >>>  19:          0         -  mxs-lradc-channel3
> >>>  20:          0         -  mxs-lradc-channel4
> >>>  21:          0         -  mxs-lradc-channel5
> >>>  22:          0         -  mxs-lradc-channel6
> >>>  23:          0         -  mxs-lradc-channel7
> >>>  24:          0         -  mxs-lradc-button0
> >>>  25:          0         -  mxs-lradc-button1
> >>> [...]
> >>>
> >>> Intended in this way?
> >>
> >> But wait, you're getting interrupts on channel 0. Doesn't seem quite
> >> right. Did you happen to poke into the code and see where the issue
> >> might be?
> >
> > No yet. But if you think this is not the intended behaviour of your
> > driver I will do a deeper look.
>
> I don't know the hardware, but from what I've seen in the driver this
> behavior looks correct. When reading a physical channel the channel will be
> mapped to the first free virtual channel, afterward it is unmapped again.

Makes sense.

> So if you are only reading a single channel it will always be mapped to
> first virtual channel. If you'd be using buffered mode and read multiple
> channels at once you'll probably get multiple interrupts on different
> virtual channels.

So, the driver's behaviour is intended. Sorry for the noise.

Regards,
Juergen

-- 
Pengutronix e.K.                              | Juergen Beisert             |
Linux Solutions for Science and Industry      | http://www.pengutronix.de/  |
