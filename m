Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Tue, 9 Mar 2010 15:13:15 +0000
Subject: [PATCH] IIO:sysfs.h: Use static declaration
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97D2@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Shouldn't those be better declared 'static'?


Index: drivers/staging/iio/sysfs.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/sysfs.h (revision 8430)
+++ drivers/staging/iio/sysfs.h (working copy)
@@ -95,16 +95,16 @@
                        .val2 =3D _val2 }

 #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)    \
-       struct iio_dev_attr iio_dev_attr_##_name                \
+       static struct iio_dev_attr iio_dev_attr_##_name         \
        =3D IIO_ATTR(_name, _mode, _show, _store, _addr)


 #define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr, _val2)   \
-       struct iio_dev_attr iio_dev_attr_##_name                        \
+       static struct iio_dev_attr iio_dev_attr_##_name                 \
        =3D IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)

 #define IIO_CONST_ATTR(_name, _string)                                 \
-       struct iio_const_attr iio_const_attr_##_name                    \
+       static struct iio_const_attr iio_const_attr_##_name                =
     \
        =3D { .string =3D _string,                                         =
 \
            .dev_attr =3D __ATTR(_name, S_IRUGO, iio_read_const_attr, NULL)=
}


------------------------------------------------------------------
********* Analog Devices GmbH              Open Platform Solutions
**  *****
**     ** Wilhelm-Wagenfeld-Strasse 6
**  ***** D-80807 Munich
********* Germany
Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel, W=
illiam A. Martin, Margaret K. Seif
