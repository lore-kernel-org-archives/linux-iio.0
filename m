Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:50006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbeKLBP4 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sun, 11 Nov 2018 20:15:56 -0500
Date: Sun, 11 Nov 2018 15:27:00 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Slawomir Stepien <sst@poczta.fm>
Cc: lars@metafoo.de, Michael.Hennerich@analog.com, knaack.h@gmx.de,
        pmeerw@pmeerw.net, linux-iio@vger.kernel.org,
        gregkh@linuxfoundation.org
Subject: Re: [PATCH v3 1/1] staging: iio: adc: ad7280a: use devm_* APIs
Message-ID: <20181111152700.15d10ccd@archlinux>
In-Reply-To: <20181109182351.GC25135@x220.localdomain>
References: <20181019182013.GC20587@x220.localdomain>
        <20181021142632.2838a361@archlinux>
        <20181023133234.GA9359@x220.localdomain>
        <20181028121646.5e12814f@archlinux>
        <20181029164724.GA11876@x220.localdomain>
        <20181103101858.228656f1@archlinux>
        <20181109182351.GC25135@x220.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Fri, 9 Nov 2018 19:23:51 +0100
Slawomir Stepien <sst@poczta.fm> wrote:

> On lis 03, 2018 10:18, Jonathan Cameron wrote:
> > On Mon, 29 Oct 2018 17:47:24 +0100
> > Slawomir Stepien <sst@poczta.fm> wrote: =20
> > > On pa=C5=BA 28, 2018 12:16, Jonathan Cameron wrote: =20
> > > > > > >  static int ad7280_remove(struct spi_device *spi)
> > > > > > > @@ -958,16 +948,9 @@ static int ad7280_remove(struct spi_devi=
ce *spi)
> > > > > > >  	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> > > > > > >  	struct ad7280_state *st =3D iio_priv(indio_dev);
> > > > > > > =20
> > > > > > > -	if (spi->irq > 0)
> > > > > > > -		free_irq(spi->irq, indio_dev);
> > > > > > > -	iio_device_unregister(indio_dev);
> > > > > > > -
> > > > > > >  	ad7280_write(st, AD7280A_DEVADDR_MASTER, AD7280A_CONTROL_HB=
, 1,
> > > > > > >  		     AD7280A_CTRL_HB_PWRDN_SW | st->ctrl_hb);     =20
> > > > > > So here, you need to think very carefully about what the various
> > > > > > steps are doing.  By moving to devm_iio_device_unregister
> > > > > > what difference has it made to the sequence of calls in remove?
> > > > > >=20
> > > > > > The upshot is you just turned the device off before removing the
> > > > > > interfaces which would allow userspace / kernel consumers to
> > > > > > access the device.  A classic race condition that 'might' open
> > > > > > up opportunities for problems.
> > > > > >=20
> > > > > > Often the reality is that these sorts of races have very minimal
> > > > > > impact, but they do break the cardinal rule that code should be
> > > > > > obviously right (if possible).  Hence you can't do this sort
> > > > > > of conversion so simply.  You can consider using the devm_add_a=
ction
> > > > > > approach to ensure the tear down is in the right order though..=
.     =20
> > > > >=20
> > > > > Yes I understand the problem here. I have some questions regarding
> > > > > devm_add_action that might solve the problem here:
> > > > >=20
> > > > > 1. My understanding is that the action has to be added on the dev=
res list before
> > > > > the devm_iio_device_register call, so during unwinding the action=
 will be called
> > > > > after the call to devm_iio_device_unreg. Other order will be stil=
l not correct.
> > > > > Am I thinking correctly here?   =20
> > > > Yes.  That's correct.   =20
> > > > >=20
> > > > > Please note that doing the action from probe is changing the curr=
ent behaviour
> > > > > of the driver - we will put the device into power-down software s=
tate also from
> > > > > probe() (if irq setup fails).   =20
> > > > True. In the case an irq being specified but not probing successful=
ly we will
> > > > fail the probe and put the device into a power down state.  However=
, to my
> > > > mind that's the right thing to do anyway.  I can't see why we would=
 want
> > > > the device powered up having decided to abandon the attempt to load=
 a driver
> > > > for it?  (am I missing something?)   =20
> > >=20
> > > I'll send a patch with this action.
> > >  =20
> > > > The more 'interesting' question is why we are registering the inter=
rupts
> > > > after iio_device_register in the first place.  We have exposed our =
userspace
> > > > interfaces, but not yet an interrupt that I assume has something to=
 do with them?
> > > >=20
> > > > iio_device_register should almost always be the last thing run in p=
robe.   =20
> > >=20
> > > I've looked at the data sheet and the code and concluded that the ord=
er is OK.
> > > Why? The irq handler can only fire after conversion is completed. The=
 conversion
> > > can start only in two ways:
> > >=20
> > > (1) falling edge of CNVST input (default) which we don't control =20
> > That's a potential problem.  We shouldn't start by default in a mode wh=
ere
> > interrupts can occur before we are potentially ready for them.  They sh=
ould
> > only be enabled by a specific request from userspace.
> > A quick at the datasheet suggests this is easily done by writing 0 to t=
he
> > alert register and only enabling it on demand. =20
>=20
> Do I understand this correctly: the interrupts should be enabled on user
> request, for example by writing 1 to additional iio_dev_attr, and disable=
d when
> writing 0 to that file?
We should move explicitly from a safe mode (software triggered) to this rem=
ote
mode.  It's a form of trigger, be it one we can't 'see' in software.  There
are other instances of such hardware triggers (stm32 drivers have some).
It isn't a problem, but you need to provide the validation functions to
ensure they can't be used to trigger other devices etc.


> Should that also be like this when using device tree node with interupt
> properties (e.g. interrupts) for that device (also working on that)?
The default should never be to trigger capture on a remote signal.  That sh=
ould
only be enabled once the driver is ready for it, but a deliberate action fr=
om
userspace.

>=20
> > > (2) rising edge of CS, which we control
> > >=20
> > > Since we only using the 2nd option, then it is wise to allow users to=
 have CNVST
> > > connected and going down, before any readout of the values using this=
 driver
> > > (this will change the CS). This way we will not loose any alert about=
 UV or OV. =20
> > I agree we are looking at theoretical race, but as I mentioned it's abo=
ut
> > obviously correct (and general correct ordering) rather than anthing el=
se.
> > In theory we can have very long delay between exposing the interfaces a=
nd
> > setting up the interrupt.  So it's possible to hit case 2 before we get
> > the interrupt set up. =20
>=20
