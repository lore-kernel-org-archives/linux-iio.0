Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:49504 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726711AbeKCT3x (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 3 Nov 2018 15:29:53 -0400
Date: Sat, 3 Nov 2018 10:18:58 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181103101858.228656f1@archlinux>
In-Reply-To: <20181029164724.GA11876@x220.localdomain>
References: <20181019182013.GC20587@x220.localdomain>
        <20181021142632.2838a361@archlinux>
        <20181023133234.GA9359@x220.localdomain>
        <20181028121646.5e12814f@archlinux>
        <20181029164724.GA11876@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Mon, 29 Oct 2018 17:47:24 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> Hi
>=20
> On pa=C5=BA 28, 2018 12:16, Jonathan Cameron wrote:
> > > > >  static int ad7280_remove(struct spi_device *spi)
> > > > > @@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_device *=
spi)
> > > > >  	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > > > >  	struct ad7280_state *st =3D iio_priv(indio_dev);
> > > > > =20
> > > > > -	if (spi->irq > 0)
> > > > > -		free_irq(spi->irq, indio_dev);
> > > > > -	iio_device_unregister(indio_dev);
> > > > > -
> > > > >  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB, 1,
> > > > >  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);   =20
> > > > So here, you need to think very carefully about what the various
> > > > steps are doing.  By moving to devm_iio_device_unregister
> > > > what difference has it made to the sequence of calls in remove?
> > > >=20
> > > > The upshot is you just turned the device off before removing the
> > > > interfaces which would allow userspace / kernel consumers to
> > > > access the device.  A classic race condition that 'might' open
> > > > up opportunities for problems.
> > > >=20
> > > > Often the reality is that these sorts of races have very minimal
> > > > impact, but they do break the cardinal rule that code should be
> > > > obviously right (if possible).  Hence you can't do this sort
> > > > of conversion so simply.  You can consider using the devm_add_action
> > > > approach to ensure the tear down is in the right order though...   =
=20
> > >=20
> > > Yes I understand the problem here. I have some questions regarding
> > > devm_add_action that might solve the problem here:
> > >=20
> > > 1. My understanding is that the action has to be added on the devres =
list before
> > > the devm_iio_device_register call, so during unwinding the action wil=
l be called
> > > after the call to devm_iio_device_unreg. Other order will be still no=
t correct.
> > > Am I thinking correctly here? =20
> > Yes.  That's correct. =20
> > >=20
> > > Please note that doing the action from probe is changing the current =
behaviour
> > > of the driver - we will put the device into power-down software state=
 also from
> > > probe() (if irq setup fails). =20
> > True. In the case an irq being specified but not probing successfully w=
e will
> > fail the probe and put the device into a power down state.  However, to=
 my
> > mind that's the right thing to do anyway.  I can't see why we would want
> > the device powered up having decided to abandon the attempt to load a d=
river
> > for it?  (am I missing something?) =20
>=20
> I'll send a patch with this action.
>=20
> > The more 'interesting' question is why we are registering the interrupts
> > after iio_device_register in the first place.  We have exposed our user=
space
> > interfaces, but not yet an interrupt that I assume has something to do =
with them?
> >=20
> > iio_device_register should almost always be the last thing run in probe=
. =20
>=20
> I've looked at the data sheet and the code and concluded that the order i=
s OK.
> Why? The irq handler can only fire after conversion is completed. The con=
version
> can start only in two ways:
>=20
> (1) falling edge of CNVST input (default) which we don't control
That's a potential problem.  We shouldn't start by default in a mode where
interrupts can occur before we are potentially ready for them.  They should
only be enabled by a specific request from userspace.
A quick at the datasheet suggests this is easily done by writing 0 to the
alert register and only enabling it on demand.

> (2) rising edge of CS, which we control
>=20
> Since we only using the 2nd option, then it is wise to allow users to hav=
e CNVST
> connected and going down, before any readout of the values using this dri=
ver
> (this will change the CS). This way we will not loose any alert about UV =
or OV.
I agree we are looking at theoretical race, but as I mentioned it's about
obviously correct (and general correct ordering) rather than anthing else.
In theory we can have very long delay between exposing the interfaces and
setting up the interrupt.  So it's possible to hit case 2 before we get
the interrupt set up.

>=20
> In case we have irq handler ready before iio_device_register, then I assu=
me that
> we might loose alert change event. Maybe it's hard (timing), but I think =
it's
> possible.
>=20
> What do you think?
>=20
> > > 2. devm_iio_device_unregister from what I see could be used here in p=
lace of
> > > iio_device_unregister. Maybe that is the best way to go?
> > >  =20
> > Definitely not this one.  The only rare case for manually using the
> > counter parts to the devm_ setup functions is to replace some data or
> > configuration rather to manually unwind the steps for some error path. =
=20
>=20
> OK, got it!
>=20
