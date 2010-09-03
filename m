Return-Path: <AChew@nvidia.com>
From: Andrew Chew <AChew@nvidia.com>
To: 'Jonathan Cameron' <jic23@cam.ac.uk>
CC: Laxman Dewangan <ldewangan@nvidia.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Date: Fri, 3 Sep 2010 13:03:12 -0700
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Message-ID: <643E69AA4436674C8F39DCC2C05F763816B85AD09E@HQMAIL03.nvidia.com>
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>
	<20100902231942.21375cc0@lxorguk.ukuu.org.uk>
	<643E69AA4436674C8F39DCC2C05F763816B85AD096@HQMAIL03.nvidia.com>
 <20100902234124.584b9bf7@lxorguk.ukuu.org.uk> <4C80300C.1010300@cam.ac.uk>
 <643E69AA4436674C8F39DCC2C05F763816B85AD09A@HQMAIL03.nvidia.com>
 <4C80A173.3030205@cam.ac.uk>
In-Reply-To: <4C80A173.3030205@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> if I understand your comment correctly userspace needs to know that
> number to convert from the magn_raw values to standard units.
> Hence it must be exported.  My point is that the calib attributes
> are used for devices that do their calibration offsets and scales
> internally.  If it is a value userspace needs to apply then the
> correct parameters are scale and offset. In the majority of devices
> see so far these are fixed for all instances of the same part. That
> isn't true here.
> >=20
> > And if we were to emit non-raw values (or provide the scale
> > attributes), what's theexact name of the attributes?  And=20
> what units are we expecting?  Gauss?  Tesla?  I don't see=20
> that documented anywhere.
> That is documented.  Gauss is the chosen standard for=20
> magnetometers.  I'll assume the
> conversion factors are channel dependent in which case you need
>=20
> magn_x_raw, magn_x_scale, magn_x_offset
>=20
> note again, we have documented everything for some device types.
> At the time, repeating for all of them was considered redundant, but
> perhaps we do need to do this for the added clarity.
>=20
> The value in Gauss =3D (magn_x_raw + magn_x_offset)*magn_x_scale

The conversion formula doesn't have an offset, actually, so the order in =
which the offset and scale are applied don't really matter to me.

In any case, I think I got it now.  I'm going to report the raw sensor va=
lue, and the scale factor for each axis to convert to gauss.

I assume when you say magn_x_scale, you really mean magn_x_gain?  Because=
=20I don't see magn_x_scale defined in magnet.h.  Or should I call the at=
tribute magn_x_scale anyway, and not use the IIO_DEV_ATTR macro for gain?=

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
