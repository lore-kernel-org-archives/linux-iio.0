Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:51662 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726406AbeJ1VBU (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 28 Oct 2018 17:01:20 -0400
Date: Sun, 28 Oct 2018 12:16:46 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181028121646.5e12814f@archlinux>
In-Reply-To: <20181023133234.GA9359@x220.localdomain>
References: <20181019182013.GC20587@x220.localdomain>
        <20181021142632.2838a361@archlinux>
        <20181023133234.GA9359@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Tue, 23 Oct 2018 15:32:34 +0200
Slawomir Stepien <sst@poczta.fm> wrote:

> On pa=C5=BA 21, 2018 14:26, Jonathan Cameron wrote:
> > On Fri, 19 Oct 2018 20:20:13 +0200
> > Slawomir Stepien <sst@poczta.fm> wrote:
> >  =20
> > > devm_* APIs are device managed and make code simpler.
> > >=20
> > > Signed-off-by: Slawomir Stepien <sst@poczta.fm> =20
> >=20
> > Hi Slawomir,
> >=20
> > There are some complexities in using the managed allocators, almost
> > always around possible race conditions.  See inline. =20
>=20
> Thank you so much for pointing the problems!
>=20
> > > @@ -692,7 +691,8 @@ static irqreturn_t ad7280_event_handler(int irq, =
void *private)
> > >  	unsigned int *channels;
> > >  	int i, ret;
> > > =20
> > > -	channels =3D kcalloc(st->scan_cnt, sizeof(*channels), GFP_KERNEL);
> > > +	channels =3D devm_kcalloc(&st->spi->dev, st->scan_cnt, sizeof(*chan=
nels),
> > > +				GFP_KERNEL);
> > >  	if (!channels)
> > >  		return IRQ_HANDLED;
> > > =20
> > > @@ -744,7 +744,7 @@ static irqreturn_t ad7280_event_handler(int irq, =
void *private)
> > >  	}
> > > =20
> > >  out:
> > > -	kfree(channels);
> > > +	devm_kfree(&st->spi->dev, channels); =20
> >=20
> > Now this I really don't want to see.
> > Using the managed framework is far from free. Please don't do it when t=
he
> > normal path is to free the buffer like this... =20
>=20
> OK
>=20
> > >  	return IRQ_HANDLED;
> > >  }
> > >  static int ad7280_remove(struct spi_device *spi)
> > > @@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_device *spi)
> > >  	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > >  	struct ad7280_state *st =3D iio_priv(indio_dev);
> > > =20
> > > -	if (spi->irq > 0)
> > > -		free_irq(spi->irq, indio_dev);
> > > -	iio_device_unregister(indio_dev);
> > > -
> > >  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> > >  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb); =20
> > So here, you need to think very carefully about what the various
> > steps are doing.  By moving to devm_iio_device_unregister
> > what difference has it made to the sequence of calls in remove?
> >=20
> > The upshot is you just turned the device off before removing the
> > interfaces which would allow userspace / kernel consumers to
> > access the device.  A classic race condition that 'might' open
> > up opportunities for problems.
> >=20
> > Often the reality is that these sorts of races have very minimal
> > impact, but they do break the cardinal rule that code should be
> > obviously right (if possible).  Hence you can't do this sort
> > of conversion so simply.  You can consider using the devm_add_action
> > approach to ensure the tear down is in the right order though... =20
>=20
> Yes I understand the problem here. I have some questions regarding
> devm_add_action that might solve the problem here:
>=20
> 1. My understanding is that the action has to be added on the devres list=
 before
> the devm_iio_device_register call, so during unwinding the action will be=
 called
> after the call to devm_iio_device_unreg. Other order will be still not co=
rrect.
> Am I thinking correctly here?
Yes.  That's correct.
>=20
> Please note that doing the action from probe is changing the current beha=
viour
> of the driver - we will put the device into power-down software state als=
o from
> probe() (if irq setup fails).
True. In the case an irq being specified but not probing successfully we wi=
ll
fail the probe and put the device into a power down state.  However, to my
mind that's the right thing to do anyway.  I can't see why we would want
the device powered up having decided to abandon the attempt to load a driver
for it?  (am I missing something?)

The more 'interesting' question is why we are registering the interrupts
after iio_device_register in the first place.  We have exposed our userspace
interfaces, but not yet an interrupt that I assume has something to do with=
 them?

iio_device_register should almost always be the last thing run in probe.

>=20
> 2. devm_iio_device_unregister from what I see could be used here in place=
 of
> iio_device_unregister. Maybe that is the best way to go?
>=20
Definitely not this one.  The only rare case for manually using the
counter parts to the devm_ setup functions is to replace some data or
configuration rather to manually unwind the steps for some error path.

Thanks,

Jonathan
