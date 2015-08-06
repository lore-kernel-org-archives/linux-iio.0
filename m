Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:47240 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbbHFPnA convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Thu, 6 Aug 2015 11:43:00 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Daniel Baluta <daniel.baluta@gmail.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Thu, 6 Aug 2015 08:42:21 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB09132@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CB08DDB@sfamail.SAKURAUS.LOCAL>
 <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
In-Reply-To: <CAEnQRZAwD+s0C4et9OTeWrwaq3ZDy3+g0YT_KKMUst_PM31DyA@mail.gmail.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hello Daniel,
See my comments in, line 

> -----Original Message-----
> From: Daniel Baluta [mailto:daniel.baluta@gmail.com] 
> Sent: Thursday, August 06, 2015 12:36 AM
> To: Greg Wilson-Lindberg
> Cc: linux-iio@vger.kernel.org
> Subject: Re: BBB IIO ADC access not working
> 
> Hi Greg,
> 
> On Sat, Aug 1, 2015 at 12:15 AM, Greg Wilson-Lindberg 
> <GWilson@sakuraus.com> wrote:
> > Hi Jonathan,
> > To recap my current problems, we are using all 3 of the ADC 
> channels that are unused by the BBB for our system. One 
> channel has an analog mux on it to allow selecting between 2 
> input pots. The other two channels are hooked up to pressure 
> transducers.
> 
> What devices and drivers are you exactly using?

The pressure transducers are a MPXV7007GP and a MPXV7002GP. I'm 
not using any driver, just reading that analog input and processing
in my application.

> 
> >
> > I'm processing the channels in a routine that gets called 
> from a timer every 100ms. I enable the IIO buffer to collect 
> data and 100ms later read the samples and turn the buffer off 
> again. I leave the buffer off for 400 ms and then go through 
> the process again.  I do this enable, read, disable cycle to 
> allow the touch screen enough time to gather data to properly 
> handle touch screen events.
> >
> > With this setup the system will work properly for a few 
> seconds, and then the buffer/adc read process slows down so 
> that it takes more than 2 seconds to process the two enable, 
> read, disable cycles in my read state machine. When the slow 
> down happens, the touch screen stops responding, and even 
> mouse presses stop working, although the mouse pointer did 
> continue to follow mouse movements and the screen continued 
> to update properly.
> >
> > Because of the size of the code I've posted it on pastebin: 
> > http://pastebin.com/TDRS1nu7 instead of including it here.
> >
> > This is running on a Jessie debian system build from Robert 
> C. Nelson, based on the 3.18 kernel.
> >
> > I hope that you or someone else on the list can help me 
> understand what is going on.
> 
> Could you provide your dmesg output and also cat /proc/interrupts.

Because of the length I've posted the dmesg to: http://pastebin.com/v8kSbSAw
There aren't any new messages at the end of the dmesg output after the 
touch screen lockup.

cat /proc/interrupts:
            CPU0       
 23:          0      INTC   7  tps65217
 28:       7149      INTC  12  edma
 30:        155      INTC  14  edma_error
 32:      35030      INTC  16  TI-am335x-tsc, TI-am335x-adc
 33:        348      INTC  17  47400000.dma-controller
 34:          0      INTC  18  musb-hdrc.0.auto
 35:        203      INTC  19  musb-hdrc.1.auto
 36:          0      INTC  20  4a300000.pruss
 37:          0      INTC  21  4a300000.pruss
 38:          0      INTC  22  4a300000.pruss
 39:          0      INTC  23  4a300000.pruss
 40:          0      INTC  24  4a300000.pruss
 41:          0      INTC  25  4a300000.pruss
 42:          0      INTC  26  4a300000.pruss
 43:          0      INTC  27  4a300000.pruss
 44:       1790      INTC  28  mmc1
 46:          0      INTC  30  4819c000.i2c
 52:    3600215      INTC  36  tilcdc
 56:          0      INTC  40  4a100000.ethernet
 57:    1750286      INTC  41  4a100000.ethernet
 58:       1114      INTC  42  4a100000.ethernet
 59:          0      INTC  43  4a100000.ethernet
 80:      21331      INTC  64  mmc0
 84:   11923739      INTC  68  gp_timer
 86:    4399997      INTC  70  44e0b000.i2c
 88:        453      INTC  72  serial
 90:        951      INTC  74  serial
 91:          0      INTC  75  rtc0
 92:          0      INTC  76  rtc0
 93:          0      INTC  77  wkup_m3
 94:          1      INTC  78  wkup_m3_txev
125:          0      INTC 109  53100000.sham
127:          0      INTC 111  48310000.rng
150:          0  44e07000.gpio   6  mmc0
IPI0:          0  CPU wakeup interrupts
IPI1:          0  Timer broadcast interrupts
IPI2:          0  Rescheduling interrupts
IPI3:          0  Function call interrupts
IPI4:          0  Single function call interrupts
IPI5:          0  CPU stop interrupts
IPI6:          0  IRQ work interrupts
IPI7:          0  completion interrupts
Err:          0 

Please let me know if there is any thing else that I can provide.
Regards,
Greg

> 
> thanks,
> Daniel.
> 