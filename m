Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:35199 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750735AbbHNUk0 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 14 Aug 2015 16:40:26 -0400
Received: by iodt126 with SMTP id t126so97264944iod.2
        for <linux-iio@vger.kernel.org>; Fri, 14 Aug 2015 13:40:26 -0700 (PDT)
Date: Fri, 14 Aug 2015 15:40:18 -0500
From: Michael Welling <mwelling@ieee.org>
To: Greg Wilson-Lindberg <GWilson@sakuraus.com>
Cc: Michael Welling <mwelling@ieee.org>,
	Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: BBB IIO ADC access not working
Message-ID: <20150814204016.GA7070@deathstar>
References: <20150806180730.GA1360@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB0937F@sfamail.SAKURAUS.LOCAL>
 <20150810223338.GA23548@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DB3@sfamail.SAKURAUS.LOCAL>
 <20150811170233.GA1872@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD3DD8@sfamail.SAKURAUS.LOCAL>
 <20150811174347.GA7777@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4046@sfamail.SAKURAUS.LOCAL>
 <20150814183950.GA22068@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD40FB@sfamail.SAKURAUS.LOCAL>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD40FB@sfamail.SAKURAUS.LOCAL>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, Aug 14, 2015 at 11:43:52AM -0700, Greg Wilson-Lindberg wrote:
> Thank you very much,
> Regards, Greg 
>

To replicate the issue I did the following:

- Started a touchscreen enabled application
ts_test

- In another terminal started a dump of /dev/iio:device0
hexdump -C /dev/iio\:device0

- In yet another terminal enable the buffer
cd /sys/bus/iio/devices/iio\:device0
echo 1 > scan_elements/in_voltage4_en
echo 1 > buffer/enable

Once the buffer is enabled the hexdump window starts spewing out readings as
expected. The touchscreen is unresponsive as expected.

Then I started occassionally enabling and disabling the buffer and noticed
something very off. When enabling the buffer sometimes the readings from
the hexdump would start and abruptly stop. In this state the entire system
is nonresponsive. None of the terminals are excepting input and the system is
in complete deadlock. Then I touched the screen and the deadlock is lifted
and readings started again.

As if the behavior was not weird enough, occassionally after the buffer is
disabled, the touchscreen readings are mangled.

Next step, figure out what is going wrong.

> > -----Original Message-----
> > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> > Of Michael Welling
> > Sent: Friday, August 14, 2015 11:40 AM
> > To: Greg Wilson-Lindberg
> > Cc: Michael Welling; Daniel Baluta; linux-iio@vger.kernel.org
> > Subject: Re: BBB IIO ADC access not working
> > 
> > On Thu, Aug 13, 2015 at 04:00:08PM -0700, Greg Wilson-Lindberg wrote:
> > > Hello Michael,
> > > 
> > > I tried a current debian release from RCN with kernel 4.1, touch 
> > > screen and mouse still locked up.
> > >
> > 
> > I will do my best to replicate the issue on a target here.
> >  
> > > Regards,
> > > Greg
> > > 
> > 
