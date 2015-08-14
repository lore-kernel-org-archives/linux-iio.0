Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37923 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751172AbbHNXqQ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2015 19:46:16 -0400
Received: by igfj19 with SMTP id j19so22382493igf.1
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2015 16:46:16 -0700 (PDT)
Date: Fri, 14 Aug 2015 18:46:07 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB IIO ADC access not working
Message-ID: <20150814234606.GA4286@deathstar>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
 <20150810223338.GA23548@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DB3@sfamail.SAKURAUS.LOCAL>
 <20150811170233.GA1872@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DD8@sfamail.SAKURAUS.LOCAL>
 <20150811174347.GA7777@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4046@sfamail.SAKURAUS.LOCAL>
 <20150814183950.GA22068@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD40FB@sfamail.SAKURAUS.LOCAL>
 <20150814204016.GA7070@deathstar>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150814204016.GA7070@deathstar>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 14, 2015 at 03:40:18PM -0500, Michael Welling wrote:
> On Fri, Aug 14, 2015 at 11:43:52AM -0700, Greg Wilson-Lindberg wrote:
> > Thank you very much,
> > Regards, Greg 
> >
> 
> To replicate the issue I did the following:
> 
> - Started a touchscreen enabled application
> ts_test
> 
> - In another terminal started a dump of /dev/iio:device0
> hexdump -C /dev/iio\:device0
> 
> - In yet another terminal enable the buffer
> cd /sys/bus/iio/devices/iio\:device0
> echo 1 > scan_elements/in_voltage4_en
> echo 1 > buffer/enable
> 
> Once the buffer is enabled the hexdump window starts spewing out readings as
> expected. The touchscreen is unresponsive as expected.
> 
> Then I started occassionally enabling and disabling the buffer and noticed
> something very off. When enabling the buffer sometimes the readings from
> the hexdump would start and abruptly stop. In this state the entire system
> is nonresponsive. None of the terminals are excepting input and the system is
> in complete deadlock. Then I touched the screen and the deadlock is lifted
> and readings started again.
> 
> As if the behavior was not weird enough, occassionally after the buffer is
> disabled, the touchscreen readings are mangled.
> 
> Next step, figure out what is going wrong.
>

It seems the drivers are being flooded with IRQENB_EOS interrupts causing
the lockup.

By adding the following to the tiadc_irq_h function the lockup stops.

.
.
        if (status & IRQENB_EOS) {
                tiadc_writel(adc_dev, REG_IRQCLR, IRQENB_EOS);
                return IRQ_HANDLED;
        }
.
.

Now the IRQENB_EOS is also handled in the touchscreen driver so this is
may not be an appropriate fix but at least it fixes the lockup.

Try adding the snippet above to ti_am335x_adc.c and see if it makes
your program stop locking up.

Then we need to find a solution that makes the maintainers happy.

