Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:52851 "EHLO
	19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751902AbbHRWLj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 18 Aug 2015 18:11:39 -0400
From: Greg Wilson-Lindberg <GWilson@sakuraus.com>
To: Michael Welling <mwelling@ieee.org>
CC: Daniel Baluta <daniel.baluta@gmail.com>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 18 Aug 2015 15:11:13 -0700
Subject: RE: BBB IIO ADC access not working
Message-ID: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4340@sfamail.SAKURAUS.LOCAL>
References: <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD4046@sfamail.SAKURAUS.LOCAL>
 <20150814183950.GA22068@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD40FB@sfamail.SAKURAUS.LOCAL>
 <20150814204016.GA7070@deathstar> <20150814234606.GA4286@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42B1@sfamail.SAKURAUS.LOCAL>
 <20150818162851.GA27380@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42C4@sfamail.SAKURAUS.LOCAL>
 <20150818173703.GA5096@deathstar>
 <782E3A02C2EB2347BEA6DEA69DC7AB86021D3CBD42D8@sfamail.SAKURAUS.LOCAL>
 <20150818181324.GC5096@deathstar>
In-Reply-To: <20150818181324.GC5096@deathstar>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

 

> -----Original Message-----
> From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf 
> Of Michael Welling
> Sent: Tuesday, August 18, 2015 11:13 AM
> To: Greg Wilson-Lindberg
> Cc: Daniel Baluta; linux-iio@vger.kernel.org
> Subject: Re: BBB IIO ADC access not working
> 
> On Tue, Aug 18, 2015 at 10:40:44AM -0700, Greg Wilson-Lindberg wrote:
> >  
> > 
> > > -----Original Message-----
> > > From: Michael Welling [mailto:mwelling79@gmail.com] On Behalf Of 
> > > Michael Welling
> > > Sent: Tuesday, August 18, 2015 10:37 AM
> > > To: Greg Wilson-Lindberg
> > > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > > Subject: Re: BBB IIO ADC access not working
> > > 
> > > On Tue, Aug 18, 2015 at 09:54:47AM -0700, Greg 
> Wilson-Lindberg wrote:
> > > >  
> > > > 
> > > > > -----Original Message-----
> > > > > From: Michael Welling [mailto:mwelling79@gmail.com] 
> On Behalf Of 
> > > > > Michael Welling
> > > > > Sent: Tuesday, August 18, 2015 9:29 AM
> > > > > To: Greg Wilson-Lindberg
> > > > > Cc: Daniel Baluta; linux-iio@vger.kernel.org
> > > > > Subject: Re: BBB IIO ADC access not working
> > > > > 
> > > > > On Tue, Aug 18, 2015 at 09:06:20AM -0700, Greg
> > > Wilson-Lindberg wrote:
> > > > > >  
> > > > > > 
> > > > > > > On Fri, Aug 14, 2015 at 03:40:18PM -0500, Michael
> > > Welling wrote:
> > > > > > > > On Fri, Aug 14, 2015 at 11:43:52AM -0700, Greg
> > > > > > > Wilson-Lindberg wrote:
> > > > > > > > > Thank you very much,
> > > > > > > > > Regards, Greg
> > > > > > > > >
> > > > > > > > 
> > > > > > > > To replicate the issue I did the following:
> > > > > > > > 
> > > > > > > > - Started a touchscreen enabled application ts_test
> > > > > > > > 
> > > > > > > > - In another terminal started a dump of
> > > > > /dev/iio:device0 hexdump
> > > > > > > > -C /dev/iio\:device0
> > > > > > > > 
> > > > > > > > - In yet another terminal enable the buffer cd 
> > > > > > > > /sys/bus/iio/devices/iio\:device0 echo 1 > 
> > > > > > > > scan_elements/in_voltage4_en echo 1 > buffer/enable
> > > > > > > > 
> > > > > > > > Once the buffer is enabled the hexdump window starts
> > > > > spewing out
> > > > > > > > readings as expected. The touchscreen is unresponsive
> > > > > as expected.
> > > > > > > > 
> > > > > > > > Then I started occassionally enabling and disabling the
> > > > > buffer and
> > > > > > > > noticed something very off. When enabling the buffer
> > > > > sometimes the
> > > > > > > > readings from the hexdump would start and 
> abruptly stop. 
> > > > > > > > In
> > > > > > > this state
> > > > > > > > the entire system is nonresponsive. None of the
> > > terminals are
> > > > > > > > excepting input and the system is in complete deadlock.
> > > > > > > Then I touched
> > > > > > > > the screen and the deadlock is lifted and readings
> > > > > started again.
> > > > > > > > 
> > > > > > > > As if the behavior was not weird enough, occassionally
> > > > > after the
> > > > > > > > buffer is disabled, the touchscreen readings 
> are mangled.
> > > > > > > > 
> > > > > > > > Next step, figure out what is going wrong.
> > > > > > > >
> > > > > > > 
> > > > > > > It seems the drivers are being flooded with IRQENB_EOS 
> > > > > > > interrupts causing the lockup.
> > > > > > > 
> > > > > > > By adding the following to the tiadc_irq_h function the
> > > > > lockup stops.
> > > > > > > 
> > > > > > > .
> > > > > > > .
> > > > > > >         if (status & IRQENB_EOS) {
> > > > > > >                 tiadc_writel(adc_dev, REG_IRQCLR, 
> IRQENB_EOS);
> > > > > > >                 return IRQ_HANDLED;
> > > > > > >         }
> > > > > > > .
> > > > > > > .
> > > > > > > 
> > > > > > > Now the IRQENB_EOS is also handled in the touchscreen
> > > > > driver so this
> > > > > > > is may not be an appropriate fix but at least it
> > > fixes the lockup.
> > > > > > > 
> > > > > > > Try adding the snippet above to ti_am335x_adc.c and see
> > > > > if it makes
> > > > > > > your program stop locking up.
> > > > > > > 
> > > > > > > Then we need to find a solution that makes the
> > > maintainers happy.
> > > > > > > 
> > > > > > > 
> > > > > > 
> > > > > > I've applied this to the ti_am335x_adc.c driver in both the
> > > > > 3.14.49-ti-r62 & 3.14.49-ti-r73 kernels from RCN and 
> they both 
> > > > > suffered touch screen lockups over night.
> > > > > 
> > > > > This is disturbing. Do you have any idea how long it takes 
> > > > > before the lockup occurs?
> > > > 
> > > > I don't know how long the system runs before lockup. The
> > > -r73 kernel
> > > > locked up Sometime over the weekend, I had run it for an
> > > hour or two before I left Saturday.
> > > > The -r62 kernel again, ran for a couple of hours yesterday
> > > afternoon before I went home, it was locked up this morning.
> > > > 
> > > > > 
> > > > > Previously it was in a few seconds so there is obviously some 
> > > > > improvement.
> > > > 
> > > > I've seen uptimes of a few hours before depending on the
> > > config-delay setting, which I think that I have set to <0xB000>.
> > > > 
> > > > > 
> > > > > Is the mouse locked as well after the overnight test?
> > > > 
> > > > Yes the mouse is locked up for touches, but it does still
> > > move. The GUI loop for the program is still running. I've 
> got some 
> > > indicators on the screen that are still updating.
> > > >
> > > 
> > > Does the cursor jump to a specific place on the screen 
> when you stop 
> > > moving the mouse?
> > 
> > No, it follows movement and stays at the last location it 
> was moved to.
> >
> 
> I found that handling the IRQENB_EOS interrupt in the ADC is 
> causing an undesired effect. After enabling the ADC buffer 
> mode and disabling it the coordinate readings work but the 
> touch release is no longer detected.

Can we put your code in the touch screen handler? The tsc code is writing to the IRQSTATUS register, not the IRQCLR register.

>  
> > > 
> > > > > 
> > > > > > 
> > > > > > Here is what I did:
> > > > > > static irqreturn_t tiadc_irq_h(int irq, void *private) {
> > > > > > 	struct iio_dev *indio_dev = private;
> > > > > > 	struct tiadc_device *adc_dev = iio_priv(indio_dev);
> > > > > > 	unsigned int status, config;
> > > > > > 	status = tiadc_readl(adc_dev, REG_IRQSTATUS);
> > > > > > 
> > > > > > 	/*
> > > > > > 	 * ADC and touchscreen share the IRQ line.
> > > > > > 	 * FIFO0 interrupts are used by TSC. Handle
> > > FIFO1 IRQs here only
> > > > > > 	 */
> > > > > > 	if (status & IRQENB_FIFO1OVRRUN) {
> > > > > > 		/* FIFO Overrun. Clear flag. Disable/Enable ADC
> > > > > to recover */
> > > > > > 		config = tiadc_readl(adc_dev, REG_CTRL);
> > > > > > 		config &= ~(CNTRLREG_TSCSSENB);
> > > > > > 		tiadc_writel(adc_dev, REG_CTRL, config);
> > > > > > 		tiadc_writel(adc_dev, REG_IRQSTATUS,
> > > IRQENB_FIFO1OVRRUN
> > > > > > 				| IRQENB_FIFO1UNDRFLW |
> > > > > IRQENB_FIFO1THRES);
> > > > > > 		tiadc_writel(adc_dev, REG_CTRL, (config |
> > > > > CNTRLREG_TSCSSENB));
> > > > > > 		return IRQ_HANDLED;
> > > > > > 	} else if (status & IRQENB_FIFO1THRES) {
> > > > > > 		/* Disable irq and wake worker thread */
> > > > > > 		tiadc_writel(adc_dev, REG_IRQCLR,
> > > IRQENB_FIFO1THRES);
> > > > > > 		return IRQ_WAKE_THREAD;
> > > > > > 	}
> > > > > > 
> > > > > >     if (status & IRQENB_EOS) {
> > > > > >         tiadc_writel(adc_dev, REG_IRQCLR, IRQENB_EOS);
> > > > > >         return IRQ_HANDLED;
> > > > > >     }
> > > > > > 
> > > > > >     return IRQ_NONE;
> > > > > > }
> > > > > > 
> > > > > > Regards,
> > > > > > Greg
> > > > > 
> > > 
> 