Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-5.csi.cam.ac.uk ([131.111.8.135]:36923 "EHLO
	ppsw-5.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab0CIP10 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2010 10:27:26 -0500
Message-ID: <4B966962.7010104@cam.ac.uk>
Date: Tue, 09 Mar 2010 15:29:38 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO:sysfs.h: Use static declaration
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97D2@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97D2@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/10 15:13, Hennerich, Michael wrote:
> Shouldn't those be better declared 'static'?

No. Convention is to do that when calling the macro as then=20
it is explicit in the relevant place.  Now if any of the calls
are missing the static keyword, that would be an error.

I've cheated a bit on the event equivalent as they define a pair
of structures.  Keep meaning to ask on how to do things like that
properly (don't suppose anyone knows?)

On another note, I'm getting increasingly tempted to drop the device
specific headers and move over to a more hwmon like fix naming at
review.  With new api they are huge and sometimes actually add code
rather than saving it.  Not that it effects these particularly macros.



>=20
>=20
> Index: drivers/staging/iio/sysfs.h
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/sysfs.h (revision 8430)
> +++ drivers/staging/iio/sysfs.h (working copy)
> @@ -95,16 +95,16 @@
>                         .val2 =3D _val2 }
>=20
>  #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)    \
> -       struct iio_dev_attr iio_dev_attr_##_name                \
> +       static struct iio_dev_attr iio_dev_attr_##_name         \
>         =3D IIO_ATTR(_name, _mode, _show, _store, _addr)
>=20
>=20
>  #define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr, _val2)=
   \
> -       struct iio_dev_attr iio_dev_attr_##_name                     =
   \
> +       static struct iio_dev_attr iio_dev_attr_##_name              =
   \
>         =3D IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)
>=20
>  #define IIO_CONST_ATTR(_name, _string)                              =
   \
> -       struct iio_const_attr iio_const_attr_##_name                 =
   \
> +       static struct iio_const_attr iio_const_attr_##_name          =
           \
>         =3D { .string =3D _string,                                   =
       \
>             .dev_attr =3D __ATTR(_name, S_IRUGO, iio_read_const_attr,=
 NULL)}
>=20
>=20
> ------------------------------------------------------------------
> ********* Analog Devices GmbH              Open Platform Solutions
> **  *****
> **     ** Wilhelm-Wagenfeld-Strasse 6
> **  ***** D-80807 Munich
> ********* Germany
> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wes=
sel, William A. Martin, Margaret K. Seif
>=20
>=20

