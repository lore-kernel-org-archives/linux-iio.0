Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:53673 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752747AbcLUJJW (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 21 Dec 2016 04:09:22 -0500
Date: Wed, 21 Dec 2016 10:09:09 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: jic23@kernel.org, knaack.h@gmx.de, lars@metafoo.de,
        pmeerw@pmeerw.net, robh+dt@kernel.org, mark.rutland@arm.com,
        wens@csie.org, lee.jones@linaro.org, linux@armlinux.org.uk,
        stefan.mavrodiev@gmail.com, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@free-electrons.com
Subject: Re: [PATCH 3/7] iio: adc: sun4i-gpadc-iio: add support for A33
 thermal sensor
Message-ID: <20161221090909.e34jdythb4rsdu57@lukather>
References: <20161220102709.9504-1-quentin.schulz@free-electrons.com>
 <20161220102709.9504-4-quentin.schulz@free-electrons.com>
 <20161220144434.2u6ivige6kdto6an@lukather>
 <b668c7f1-99ac-f2ba-eaab-f3c0f9e1cfb2@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="sxgan5ms4fxhl5oy"
In-Reply-To: <b668c7f1-99ac-f2ba-eaab-f3c0f9e1cfb2@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--sxgan5ms4fxhl5oy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, Dec 20, 2016 at 04:20:04PM +0100, Quentin Schulz wrote:
> >> +	select MFD_SUN4I_GPADC if MACH_SUN4I || MACH_SUN5I || MACH_SUN6I
> >=20
> > Why did you change the depends on to a select?
> >=20
>=20
> The "depends on" does not have an if condition but "select" has. See:
> https://www.kernel.org/doc/Documentation/kbuild/kconfig-language.txt

I think something like that should work:

depends on (MFD_SUN4I_GPADC && MACH_SUN4I) || MACH_SUN8I

> >> +	depends on THERMAL_OF || MACH_SUN4I || MACH_SUN5I || MACH_SUN6I
> >=20
> > So you can't disable THERMAL_OF on MACH_SUN8I?
> >=20
>=20
> Not in the current state. devm_thermal_zone_of_sensor_register from
> sun4i_gpadc_probe_dt returns an error if THERMAL_OF is disabled and
> thus, the probe fails. Maybe it should rather fail silently and let the
> user choose whether (s)he wants the thermal framework to be able to read
> data from this driver?

I'm usually not a big fan of inconsistencies in the behaviour of
drivers, but let's wait for the second version to discuss that.

> >> +	depends on !TOUCHSCREEN_SUN4I
> >=20
> > This should be a different patch.
> >=20
> >> +	help
> >> +	  Say yes here to build support for Allwinner (A10, A13, A31 and A33)
> >> +	  SoCs GPADC.
> >> +
> >> +	  The ADC on A10, A13 and A31 provides 4 channels which can be used =
as
> >> +	  an ADC or as a touchscreen input and one channel for thermal senso=
r.
> >> +	  Their thermal sensor slows down ADC readings and can be disabled by
> >=20
> > Again, I'm not sure putting all those details in the Kconfig help
> > really helps. This is only going to grow with more and more cases, and
> > this isn't something really helpful anyway.
> >=20
>=20
> Are you suggesting to remove completely the paragraph on why it is
> possible to disable CONFIG_THERMAL_OF for the A10, A13 and A31 or only
> to remove the mention to SoCs?

Both actually :)

> >> @@ -246,6 +269,19 @@ static int sun4i_gpadc_adc_read(struct iio_dev *i=
ndio_dev, int channel,
> >>  static int sun4i_gpadc_temp_read(struct iio_dev *indio_dev, int *val)
> >>  {
> >>  	struct sun4i_gpadc_iio *info =3D iio_priv(indio_dev);
> >> +	int ret;
> >> +
> >> +	if (info->use_dt) {
> >> +		pm_runtime_get_sync(indio_dev->dev.parent);
> >> +
> >> +		ret =3D regmap_read(info->regmap, SUN4I_GPADC_TEMP_DATA, val);
> >> +		if (!ret)
> >> +			pm_runtime_mark_last_busy(indio_dev->dev.parent);
> >> +
> >> +		pm_runtime_put_autosuspend(indio_dev->dev.parent);
> >> +
> >> +		return 0;
> >> +	}
> >=20
> > Why is runtime_pm linked to the DT support or not?
> >=20
> >> =20
> >>  	return sun4i_gpadc_read(indio_dev, 0, val, info->temp_data_irq);
> >>  }
>=20
> The same runtime_pm functions are called when the driver is not probed
> from DT.
>=20
> sun4i_gpadc_read will call sun4i_prepare_for_irq which does a
> pm_runtime_get_sync and then at the end of sun4i_gpadc_read,
> pm_runtime_mark_last_busy and pm_runtime_put_autosuspend are called.
>=20
> I just noticed I forgot to add a comment on this one. The A33
> documentation tells us there is an interrupt for the thermal sensor but
> after struggling with it, it is just false. I validated my guess with
> Allwinner Linux kernel which does not wait an interrupt to read the data
> register of the thermal sensor.
>=20
> sun4i_gpadc_read always wait for an interrupt before reading data regs,
> so I'm just not calling it and doing the "logic" (reading the data reg
> and interfacing with runtime_pm) directly here in sun4i_gpadc_temp.
>=20
> I'll add a comment on this one. Maybe I should create a function just
> for the "logic" of the A33 thermal sensor, so it is less weird than
> currently.

Ok. So this is not really about using the DT or not, but rather
whether you're on an A33 or not. You could probably add a broken_irq
field to test against that.

You should probably share the pm_runtim calls too between the two
cases.

Thanks!
Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--sxgan5ms4fxhl5oy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYWkawAAoJEBx+YmzsjxAgix4P/2v/Oqpy3rF9Vs723MInJy2Z
9gqdkfs/RRg0raDg/8ajT4+yhaTm4lF8BD6KTebdhjs36FjVNRYd6+0LYoui6Ujn
K8VwEo7ECMhFo+owC1bIE9sxfIbCxMQ9kXi/Qcr2HCEyufz0efAq4y0hT1Esx5MV
o74d9I2e4rZUTQyyaV3l3uAxsoVfgU0+oQO+Io0yPFwAqvLS2sKwnY4IJINXDans
kr+/IFmih0f3t8PTlruimeK4hG4Q9fteQq7v2351DYWpBgV+rSgELYjp14dDw1RQ
M4YUrnkNRNSGwUjVpgMqvoJKI/bFj1dA+mv6V9NJLOvUO+Y4/UCvvwD2H9rvEv/X
sO8+YDNRk/NMIKb2lTYy0K5Uz6+nexwWw6ppQyCmvBzspr/UWHsMdHP82rxKm0Kz
asD/9Pozt/PIR6qZ7aqM3VqLBNb6zdkD3gajo0/1HBFjYHrGHR3v8LZdWQ2K6+BR
9a4iSgN1DC18Zcf7hi6Kh5GDbVbwxt0h0cEr74PDJUxkbSD2mZPlmSpBjWOLzA6K
EkQGil4dEAkohhvFG7eSxHD80hqzIlCKRdTWZCkdHiKALCUXsQXKkOPFtpP6vU9i
hDqmcGmEUO7+wj1AtZ4e6tIWOCKPv6D4Sq8jmgJYs1VD7psxMCTkAhFy9+CAnQP0
cRwLWtzCcYpMurS+r3YA
=e+BC
-----END PGP SIGNATURE-----

--sxgan5ms4fxhl5oy--
