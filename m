Return-Path: <balbi@ti.com>
Date: Thu, 7 Aug 2014 12:54:34 -0500
From: Felipe Balbi <balbi@ti.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: <balbi@ti.com>, <linux-iio@vger.kernel.org>
Subject: Re: [RFC/PATCH] iio: light: add support for TI's opt3001 ligth sensor
Message-ID: <20140807175434.GA31933@saruman.home>
Reply-To: <balbi@ti.com>
References: <1407341409-30284-1-git-send-email-balbi@ti.com>
 <53E34E60.80507@kernel.org>
 <20140807142829.GA24581@saruman.home>
 <53E3A8B4.70805@kernel.org>
 <20140807163509.GA29964@saruman.home>
 <53E3B051.4080705@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="x+6KMIRAuhnl3hBn"
In-Reply-To: <53E3B051.4080705@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

--x+6KMIRAuhnl3hBn
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

(your email setup is still messed up, I had to rewrap the whole email)

On Thu, Aug 07, 2014 at 05:58:57PM +0100, Jonathan Cameron wrote:
> >>> I can set low limit to 200 lux and high limit to 50 lux, then I'll
> >>> get a rising edge IRQ when I have more than 50 lux and a falling
> >>> edge when I get less than 200 lux.
> >>>=20
> >>> If Latch bit is set, however, then it's almost like it ignores
> >>> low/high limit altogether and I get an IRQ ever $int_time ms or
> >>> so.
> >> That would be similar to the motion triggers we have for
> >> accelerometers. They capture every sample as long as the threshold
> >> is met (during motion). No idea why you'd really want to do that on
> >> a light sensor though.  Perhaps not worth capturing light info if
> >> the cover is closed on a phone?
> >=20
> > Yeah, but that's something else altogether. This device doesn't
> > really care about a phone cover. Sounds like policy which should be
> > in userland, or part of an iio_gpio_trigger...
> Agreed.  Can you think of a use for the non latched version? :)

Sure, you might just want a notification when illuminance reaches a
certain level (rising) or drop below another (or the same) level
(falling).

> >>>>> +	ret =3D devm_iio_device_register(dev, iio);
> >>>>> +	if (ret) {
> >>>>> +		dev_err(dev, "failed to register IIO device\n");
> >>>>> +		return ret;
> >>>>> +	}
> >>>>> +
> >>>> Normally we'd expect the devm_iio_device_register (that provides
> >>>> the userspace interfaces) to be after the irq request.
> >>>=20
> >>> that's wrong. By the time the IRQ is requested, an IRQ can
> >>> actually fire and you better have a valid e.g.  iio_dev by then.
> >> Its very unusual to bring up a device with the IRQ already in a
> >> position to fire.  Normally that would require some enabling from
> >> userspace after the driver is loaded?  How can it fire here before
> >> that point?
> >=20
> > at the moment you call request_irq() (or any of its friends), that
> > IRQ line is unmasked and ready to fire. Remember that IRQ lines can
> > be shared and your IRQ handler will be called even if a separate
> > device triggered the IRQ. Heck, if you have a bad board design, even
> > noise can assert the IRQ line but let's not go there :-)
> IIRC Sharing is only possible if the device driver explicitly allows
> it?

not, necessarily. It can be set by the arch support code.

> Bad board design can get you in many many ways ;)
> >=20
> > In any case, you better have valid pointers around so that by the
> > time your IRQ is triggered, you don't crash the kernel. Another way
> > would be to mask the IRQ at your device level, but that still
> > doesn't solve shared IRQs.
> >=20
> > I usually request the IRQ as the last step for that very reason.
> Fair enough - easy way to be sure I guess.  Though by just before the
> register of the device all relevant pointers should be available.  It
> won't do anything particularly helpful but it should not crash. If it
> does then we have a bug we should probably close.

alright.

--=20
balbi

--x+6KMIRAuhnl3hBn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJT471aAAoJEIaOsuA1yqRElhgP/2DglkX8vtpq+5av54/VORqd
P9Y2Rvj77hKkCXj0hnoZMb+/2f3UX6VxzlIyow6J1/tlpl6dECt7I9Lp8RbU7tG7
18+0uhP4myLtwqrJ9AxpqK3cBZfMEqDXH8ldf+ALk0WmP33795Cv1BoLTWEib/bt
LICQb1/rphKOo9fGOmkz8YNok/lCfhHHx3mh7m5dk3boXSeekYw8Ufs+w8CIRdN+
dxRsuVw4Rm5A5cvgbpogpCvD/Zby7UkXLmQ0RzGo1XSJWH1MtFBp8++kGui29ll8
oDp6xaM0fpCJV7BaDqRbjuuPe7upMiemItavTCnN+t9IMQKxpWD10GEExpRefA4z
GsCd9eQ+TzQHrl08I5mA0h5LDpK2s6p06+S0GfivwecBfC64yIQWmBgsfEHXnkyG
TRsD17sNQ4JId0GYNZRJEBVhTDTfOc26l9lo7r0hL3vpvCDOWsbNYhl7u65Tse48
ZS9wjCU7WT7Xd2kI2lXSQ2pLkSgdho/881OxLuvIDIEDmzDfjCqgWyBGqnHAY0jR
yQh2HUkAHSuHNEpreOq/4l5DzidCvlb16uXcZoz86yoQHt23FdWqVNFu3/TfXNsv
uPiCn0c9tY8a1k3LjCQjKG3nWtitXeKuWrxNQVvxXZ5RF6pqoAQy+xpELafqYb9K
h6FF+6qMBPFuoMoSHlC1
=XyAT
-----END PGP SIGNATURE-----

--x+6KMIRAuhnl3hBn--
