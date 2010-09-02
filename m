Return-Path: <AChew@nvidia.com>
From: Andrew Chew <AChew@nvidia.com>
To: 'Jonathan Cameron' <jic23@cam.ac.uk>
CC: Laxman Dewangan <ldewangan@nvidia.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, 'Alan Cox' <alan@lxorguk.ukuu.org.uk>
Date: Thu, 2 Sep 2010 16:57:50 -0700
Subject: RE: [PATCH 1/1] iio: ak8975: Add Ak8975 magnetometer sensor
Message-ID: <643E69AA4436674C8F39DCC2C05F763816B85AD09A@HQMAIL03.nvidia.com>
References: <1283463351-15816-1-git-send-email-achew@nvidia.com>
	<20100902231942.21375cc0@lxorguk.ukuu.org.uk>
	<643E69AA4436674C8F39DCC2C05F763816B85AD096@HQMAIL03.nvidia.com>
 <20100902234124.584b9bf7@lxorguk.ukuu.org.uk> <4C80300C.1010300@cam.ac.uk>
In-Reply-To: <4C80300C.1010300@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

> >>>> +static IIO_DEVICE_ATTR(mode, S_IRUGO | S_IWUSR, show_mode,=20
> >>> store_mode, 0);
> >>>> +static IIO_DEVICE_ATTR(magn_x_calibscale, S_IRUGO,=20
> >>> show_calibscale, NULL, 0);
> >>>> +static IIO_DEVICE_ATTR(magn_y_calibscale, S_IRUGO,=20
> >>> show_calibscale, NULL, 1);
> >>>> +static IIO_DEVICE_ATTR(magn_z_calibscale, S_IRUGO,=20
> >>> show_calibscale, NULL, 2);
> >>>> +static IIO_DEV_ATTR_MAGN_X(show_raw, AK8975_REG_HXL);
> >>>> +static IIO_DEV_ATTR_MAGN_Y(show_raw, AK8975_REG_HYL);
> >>>> +static IIO_DEV_ATTR_MAGN_Z(show_raw, AK8975_REG_HZL);
> >>>
> >>> This seems odd as an interface as it's raw when the maths=20
> to provide
> >>> non-raw (and thus abstract and easy for user space) data=20
> is trivial
> >>> enough to do in kernel
> >>
> >> IIO guys want to do normalization maths above the=20
> kernel-level magnetometer IIO layer.=20
> >>This interface came before me, so I'm just following=20
> current conventions.
> >=20
> > That will make a generic IIO <-> input bridge very hard to=20
> do right. I
> > can see why IIO wants to do that but you need both if so=20
> and this also
> > needs discussion.
>=20
> Note that, though there are few drivers using it (just the=20
> tsl2563 iirc)
> we do allow the hwmon style _input syntax for values in the=20
> standard units
> for the device type.  If you are going to use the raw option then,
> assuming linear conversion, at the very least magn_scale=20
> should be provided
> to tell userspace how to do the conversion.  If the bridge to input
> is done in userspace then it is trivial to apply this before passing
> into uinput.  For background info, the bridge approach currently
> relies on implementation of the 'buffered' iio interface which uses
> chrdevs rather than the hwmon like 'simple' interface provided here.
> It would be a bit of a nightmare to bridge from sysfs (if it could
> even be done?)  Typically all drivers start with the sysfs interface
> and the buffered one is only added if needed by someone.
>=20
> Note calibscale is meant for internally applied values.  That=20
> is ones applied
> actually on the device (looking at what you have here, my=20
> choice of naming
> wasn't ideal, anyone have a better naming suggestion).  The=20
> value used to do raw to
> standard unit conversion in userspace is magn_x_scale or equivalent.
> I think based on the comment in your code that you also need=20
> to provide
> magn_x_offset.  Looks like our documentation could do to be a=20
> little clearer.
> Rather tediously these are both computed floating point=20
> values here.  Perhaps
> we will need to think further on that interface (this is the=20
> first time
> we have hit this particular situation)
>=20
> The raw option is principally there because we share the=20
> attributes with the
> buffer access (there performance dictates doing as little as=20
> possible to the
> data on the way through.) Admittedly our overheads are way=20
> too high at the
> moment for other reasons but the intent is there.  If you are=20
> intending to
> add this interface later then keeping to the _raw attributes=20
> makes for a
> more consistent choice (though as long as the scale and bias=20
> are there for
> the buffer you could use the processed value...)

Yes, the little documentation that's there in sysfs-class-iio doesn't giv=
e me very much guidance on how to do this properly.

So what I'm getting from your comments is that I'm using the calib attrib=
ute wrong (I wasn't even sure I named this correctly...can we publish ALL=
=20known attributes in magnet.h, so we can standardize on these attribute=
=20names through the magnet.h macros?).  The ASA sensitivity adjustment, =
then, should be left completely internal to the driver, and not emitted t=
hrough any known attribute?

And if we were to emit non-raw values (or provide the scale attributes), =
what's the exact name of the attributes?  And what units are we expecting=
?  Gauss?  Tesla?  I don't see that documented anywhere.
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
