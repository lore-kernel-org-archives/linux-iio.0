Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:45390 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726767AbeLBCai (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Sat, 1 Dec 2018 21:30:38 -0500
Date: Sat, 1 Dec 2018 15:17:47 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: "Ardelean, Alexandru" <alexandru.Ardelean@analog.com>
Cc: "giuliano.belinassi@gmail.com" <giuliano.belinassi@gmail.com>,
        "Popa, Stefan Serban" <StefanSerban.Popa@analog.com>,
        "kernel-usp@googlegroups.com" <kernel-usp@googlegroups.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "knaack.h@gmx.de" <knaack.h@gmx.de>,
        "Hennerich, Michael" <Michael.Hennerich@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "devel@driverdev.osuosl.org" <devel@driverdev.osuosl.org>,
        "pmeerw@pmeerw.net" <pmeerw@pmeerw.net>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Subject: Re: [PATCH] staging: iio: ad7780: Add gain & filter gpio support
Message-ID: <20181201151747.16522ff4@archlinux>
In-Reply-To: <a71bb89842260368353ebb66dff66b8f0583755b.camel@analog.com>
References: <20181121180443.tjgcpu2webrq53rh@smtp.gmail.com>
        <CAG4RSAHcEYj5bUpxT8apwXZZpWkPowFJ333tZiTHhb9VVn4m7g@mail.gmail.com>
        <1543316945.22768.35.camel@analog.com>
        <a71bb89842260368353ebb66dff66b8f0583755b.camel@analog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On Thu, 29 Nov 2018 12:19:08 +0000
"Ardelean, Alexandru" <alexandru.Ardelean@analog.com> wrote:

> On Tue, 2018-11-27 at 06:11 -0500, Popa, Stefan Serban wrote:
> > On Lu, 2018-11-26 at 17:24 -0200, Giuliano Belinassi wrote:
> > Hi, please see bellow
> >  =20
>=20
> One note from me here.
>=20
> > > Hi, thank you for the review
> > >  =20
> > > >=20
> > > > On Thu, 22 Nov 2018 11:01:00 +0000
> > > > "Popa, Stefan Serban" <StefanSerban.Popa@analog.com> wrote: =20
> > > > >=20
> > > > > I think that instead of setting the gain directly, we should use
> > > > > the IIO_CHAN_INFO_SCALE attribute. At page 12 of the ad7780
> > > > > datasheet
> > > > > there
> > > > > is a formula from which the output code can be calculated:
> > > > > Code =3D 2^(N =E2=88=92 1)
> > > > > =C3=97 [(AIN =C3=97 Gain /VREF) + 1]. So, by setting the scale fr=
om user
> > > > > space,
> > > > > the
> > > > > driver can calculate the correct gain by using the formula above.
> > > > > Also, it
> > > > > would be useful to introduce scale available.
> > > > > Furthermore, there is a new
> > > > > ad7124 adc driver which does this exact thing. Take a look here:
> > > > > http
> > > > > s://gi
> > > > > thub.com/analogdevicesinc/linux/blob/master/drivers/iio/adc/ad712=
4.
> > > > > c#
> > > > > L337. =20
> > >=20
> > > We have some questions about the code you provided to us:
> > >   1-) What is exactly the inputs for the write_raw function? =20
> >=20
> > In your write_raw() function you need to add IIO_CHAN_INFO_SCALE case.
> > Setting the scale from user space looks something like this: =20
> > root:/sys/bus/iio/devices/iio:device0> echo 0.000298 > in_voltage_scale=
 . =20
> > Furthermore, in your write_raw() function, val=3D0 and val2=3D298.
> > Knowing that full_scale_voltage =3D Vref / (gain * scale), we can calcu=
late
> > the gain =3D Vref / (full_scale_voltage * scale). We only support two g=
ains
> > (1 and 128), so we need to determine which one fits better with the
> > desired
> > scale. Finally, all we have left to do is to set the gain.=20
> >   =20
> > >   2-) Could you give more details about the math around lines 346-348?
> > > Is it correct to assume that the multiplication at line 346 won't
> > > overflow? (vref is an uint) =20
> >=20
> > It is correct that Vref is in microvolts, so for example, Vref of 2.5V =
 =3D
> > 2500000000uV. It won't overflow since we use the Vref as nominator, whi=
le
> > full_scale_voltage and scale are the denominators.
> >  =20
>=20
> [Regarding the AD7124] I guess I should be noted that the code can
> overflow, but in this case it shouldn't, because (according to the device
> datasheet) the maximum VREF can be 3600 mV.
> A user could specify (in the devicetree) something larger than 4300 mV (a=
nd
> that would overflow) but that would also make the readings useless as the
> external VREF would be invalid ; and there is also the risk of frying the
> chip in that case [something you really can't protect the user against].

Thanks Alex and Stefan for great detail here (glad you got to this before
I did ;)  One thing to add though is that if we have constraints like
this that would mess up the readings, it is sensible to check them
in the driver and at the very least put out a loud warning about the
problem, possibly even refuse to probe the driver.

The number of times I've spent hours chasing configuration problems
only to discover I was doing something stupid and the kernel silently
carried on regardlessly make me very keen on such commonsense protections.

I'm not going to review every driver to ensure they do this, but I'm keen
on them being checked where a possible problem has been identified!

Jonathan
>=20
> The internal VREF however is 2500 mV, so things should be fine from that
> point of view.
>=20
> Typically, in datasheets (at least from Analog Devices) it's good to take=
 a
> look at the specifications sections.
> [For AD7124] You will see that the internal VREF [page 8] is 2.5V (with
> approximation of +/-0.2%) and for external reference it goes all the way =
up
> to AVDD, which has typical values of 2.9V - 3.6V.
> So, for u32 this code should be fine and not overflow.
>=20
> One small thing that can be confusing about that code in AD7124 is that it
> gets multiplied with 1000000LL (which is signed long-long), but that shou=
ld
> be fine, since the operation should be converted to u32 (unsigned int)
> representation [by being assigned to vref], which ends up being fine in t=
he
> end.
>=20
> > >=20
> > > And regarding our code:
> > >   1-) The val in our write_raw function should be, in case of GAIN, a
> > > number that best approximate the actual gain value of 1 or 128? For
> > > instance, if the user inputs 126, we should default to 128? =20
> >=20
> > We should not allow the the user to input the gain, he needs to input t=
he
> > scale (see the mail from Jonathan and the above explanation). However, =
if
> > the calculated gain is one that is not supported, such as 126, we will
> > set
> > the closest matching value, in this case 128.
> >  =20
> > >   2-) In the case of FILTER, is it the same? Is the user sending the
> > > value in mHz (milihertz)? =20
> >=20
> > Yes, it is the same with the FILTER. You need to add
> > a IIO_CHAN_INFO_SAMP_FREQ case in your write_raw() function. From user
> > space, the input value should be in Hz, something like this: =20
> > root:/sys/bus/iio/devices/iio:device0> echo 10 > =20
> > in_voltage_sampling_frequency
> >  =20
> > >=20
> > > Thank you =20
