Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtpo.poczta.interia.pl ([217.74.65.208]:58793 "EHLO
        smtpo.poczta.interia.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727519AbeJ3Bgf (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 29 Oct 2018 21:36:35 -0400
Date: Mon, 29 Oct 2018 17:47:24 +0100
From: Slawomir Stepien <sst@poczta.fm>
To: Jonathan Cameron <jic23@kernel.org>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181029164724.GA11876@x220.localdomain>
References: <20181019182013.GC20587@x220.localdomain>
 <20181021142632.2838a361@archlinux>
 <20181023133234.GA9359@x220.localdomain>
 <20181028121646.5e12814f@archlinux>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20181028121646.5e12814f@archlinux>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Hi

On paź 28, 2018 12:16, Jonathan Cameron wrote:
> > > >  static int ad7280_remove(struct spi_device *spi)
> > > > @@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_device *spi)
> > > >  	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> > > >  	struct ad7280_state *st = iio_priv(indio_dev);
> > > >  
> > > > -	if (spi->irq > 0)
> > > > -		free_irq(spi->irq, indio_dev);
> > > > -	iio_device_unregister(indio_dev);
> > > > -
> > > >  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> > > >  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);  
> > > So here, you need to think very carefully about what the various
> > > steps are doing.  By moving to devm_iio_device_unregister
> > > what difference has it made to the sequence of calls in remove?
> > > 
> > > The upshot is you just turned the device off before removing the
> > > interfaces which would allow userspace / kernel consumers to
> > > access the device.  A classic race condition that 'might' open
> > > up opportunities for problems.
> > > 
> > > Often the reality is that these sorts of races have very minimal
> > > impact, but they do break the cardinal rule that code should be
> > > obviously right (if possible).  Hence you can't do this sort
> > > of conversion so simply.  You can consider using the devm_add_action
> > > approach to ensure the tear down is in the right order though...  
> > 
> > Yes I understand the problem here. I have some questions regarding
> > devm_add_action that might solve the problem here:
> > 
> > 1. My understanding is that the action has to be added on the devres list before
> > the devm_iio_device_register call, so during unwinding the action will be called
> > after the call to devm_iio_device_unreg. Other order will be still not correct.
> > Am I thinking correctly here?
> Yes.  That's correct.
> > 
> > Please note that doing the action from probe is changing the current behaviour
> > of the driver - we will put the device into power-down software state also from
> > probe() (if irq setup fails).
> True. In the case an irq being specified but not probing successfully we will
> fail the probe and put the device into a power down state.  However, to my
> mind that's the right thing to do anyway.  I can't see why we would want
> the device powered up having decided to abandon the attempt to load a driver
> for it?  (am I missing something?)

I'll send a patch with this action.

> The more 'interesting' question is why we are registering the interrupts
> after iio_device_register in the first place.  We have exposed our userspace
> interfaces, but not yet an interrupt that I assume has something to do with them?
> 
> iio_device_register should almost always be the last thing run in probe.

I've looked at the data sheet and the code and concluded that the order is OK.
Why? The irq handler can only fire after conversion is completed. The conversion
can start only in two ways:

(1) falling edge of CNVST input (default) which we don't control
(2) rising edge of CS, which we control

Since we only using the 2nd option, then it is wise to allow users to have CNVST
connected and going down, before any readout of the values using this driver
(this will change the CS). This way we will not loose any alert about UV or OV.

In case we have irq handler ready before iio_device_register, then I assume that
we might loose alert change event. Maybe it's hard (timing), but I think it's
possible.

What do you think?

> > 2. devm_iio_device_unregister from what I see could be used here in place of
> > iio_device_unregister. Maybe that is the best way to go?
> > 
> Definitely not this one.  The only rare case for manually using the
> counter parts to the devm_ setup functions is to replace some data or
> configuration rather to manually unwind the steps for some error path.

OK, got it!

-- 
Slawomir Stepien
