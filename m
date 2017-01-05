Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.free-electrons.com ([62.4.15.54]:34425 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762845AbdAEQqy (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Thu, 5 Jan 2017 11:46:54 -0500
Date: Thu, 5 Jan 2017 17:46:51 +0100
From: Maxime Ripard <maxime.ripard@free-electrons.com>
To: Quentin Schulz <quentin.schulz@free-electrons.com>
Cc: Chen-Yu Tsai <wens@csie.org>, Jonathan Cameron <jic23@kernel.org>,
        knaack.h@gmx.de, Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Sebastian Reichel <sre@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Lee Jones <lee.jones@linaro.org>, linux-iio@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "open list:THERMAL" <linux-pm@vger.kernel.org>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Icenowy Zheng <icenowy@aosc.xyz>,
        Bruno =?iso-8859-1?Q?Pr=E9mont?= <bonbons@linux-vserver.org>
Subject: Re: [PATCH 03/22] iio: adc: add support for X-Powers AXP20X and
 AXP22X PMICs ADCs
Message-ID: <20170105164651.tk5e3rhdthtpn4lc@lukather>
References: <20170102163723.7939-1-quentin.schulz@free-electrons.com>
 <20170102163723.7939-4-quentin.schulz@free-electrons.com>
 <CAGb2v67S==AG=jZA=mO-bB4u1F2TOwhmBXg385W1xhUa3RAFbA@mail.gmail.com>
 <9acfe5e0-dc56-bd63-02b4-7bf34d49d62c@free-electrons.com>
 <CAGb2v66n46KQAzQBUrDwx7sYADkRm3_XyCHf9imN+FiDkHfP1w@mail.gmail.com>
 <cf4590d1-5381-f1da-7271-e6e7fee0c479@free-electrons.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="shktkrd5emwedjwp"
In-Reply-To: <cf4590d1-5381-f1da-7271-e6e7fee0c479@free-electrons.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


--shktkrd5emwedjwp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 05, 2017 at 10:50:33AM +0100, Quentin Schulz wrote:
> >>>> +static int axp20x_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +       struct axp20x_adc_iio *info;
> >>>> +       struct iio_dev *indio_dev =3D platform_get_drvdata(pdev);
> >>>> +
> >>>> +       info =3D iio_priv(indio_dev);
> >>>
> >>> Nit: you could just reverse the 2 declarations above and join this
> >>> line after struct axp20x_adc_iio *info;
> >>>
> >>>> +       regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
> >>>> +       regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
> >>>
> >>> The existing VBUS power supply driver enables the VBUS ADC bits itsel=
f,
> >>> and does not check them later on. This means if one were to remove th=
is
> >>> axp20x-adc module, the voltage/current readings in the VBUS power sup=
ply
> >>> would be invalid. Some sort of workaround would be needed here in this
> >>> driver of the VBUS driver.
> >>>
> >>
> >> That would be one reason to migrate the VBUS driver to use the IIO
> >> channels, wouldn't it?
> >=20
> > It is, preferably without changing the device tree.
> >=20
>=20
> Yes, of course.

Note that you can have something like a test for the iio channel
property in the VBUS driver, and keep the old behaviour in the case
where we wouldn't have it.

Maxime

--=20
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com

--shktkrd5emwedjwp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCAAGBQJYbnh3AAoJEBx+YmzsjxAg1B0QAJUr7iV7NoatEyLL3tVoe1tb
b4gImcq8bN/bkBBjfMIIJbUj/R1zekMW5MyCdIfe+QFWGWHzwZduebnxAez57S8y
NGiSODOXgDoU6/tbMqxehTwhrsad9xEd4Xd7Q+W2Swj04RvFAx4D1jjrusHRv3/T
f0xmE08TkGZWWKb9O78Ti7iTM2gT986t5PSIdEE3JCMg04Yd7h62khO6f+x3lxsE
ZdvZuppxYfJcZjRenj3tJW0y9XyRqmEGKflUoojz4rCY67++XP5BIw9pKv8+Eq1h
LA5D5mp82ioIX7hzkB0f+uJtNG6TNtyC3kzL7xmuJoJHkBANuVPXlOsLcyn5j/gV
v8U1Rw5K6WJS74YXDjGXc+GtPz3NHTwFwcPEhM6aRiBHPIK+el7Ee2RuQNSuYCKJ
1X3l3cRh6Tq90fI/0yWDEYOdj1pnC6m12jeo2jPwUrJEPE4qTQh6OzK9hkFXaJKn
jxCGY9XAxtvboc+ft3P+B8iH8Z4Shq4LyxHHZPx8JtCMaq47QM0t9fow+NRqmbWk
odpe0YPYAMmci9vPWrDfVYsQ8k+1xcS8ufhss5iUTACPhiZ1bceyb6m5cOt7pUW/
C7NxHUPt79pwWUFeqQdP8rckyEgOOhw8FmLXtkRK3nQ/F5I3tUTfRLLAc3xbo51U
b+R7GUAYJE0S7CkxYyVF
=ZfBu
-----END PGP SIGNATURE-----

--shktkrd5emwedjwp--
