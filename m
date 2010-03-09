Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Date: Tue, 9 Mar 2010 15:39:41 +0000
Subject: RE: [PATCH] IIO:sysfs.h: Use static declaration
Message-ID: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97E9@LIMKCMBX1.ad.analog.com>
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97D2@LIMKCMBX1.ad.analog.com>
 <4B966962.7010104@cam.ac.uk>
In-Reply-To: <4B966962.7010104@cam.ac.uk>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

Jonathan Cameron wrote on 2010-03-09:
> On 03/09/10 15:13, Hennerich, Michael wrote:
>> Shouldn't those be better declared 'static'?
>
> No. Convention is to do that when calling the macro as then it is
> explicit in the relevant place.  Now if any of the calls are missing
> the static keyword, that would be an error.

I don't mind - as long as they are declared static.
Because I'm seeing collisions with your driver - that doesn't declare it's =
common attributes static.

What about this patch?

Index: drivers/staging/iio/adc/max1363_core.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- drivers/staging/iio/adc/max1363_core.c      (revision 8430)
+++ drivers/staging/iio/adc/max1363_core.c      (working copy)
@@ -446,12 +446,12 @@
        return ret;
 }

-IIO_DEV_ATTR_AVAIL_SCAN_MODES(max1363_show_av_scan_modes);
-IIO_DEV_ATTR_SCAN_MODE(S_IRUGO | S_IWUSR,
+static IIO_DEV_ATTR_AVAIL_SCAN_MODES(max1363_show_av_scan_modes);
+static IIO_DEV_ATTR_SCAN_MODE(S_IRUGO | S_IWUSR,
                       max1363_show_scan_mode,
                       max1363_store_scan_mode);

-IIO_DEV_ATTR_SCAN(max1363_scan);
+static IIO_DEV_ATTR_SCAN(max1363_scan);

 static ssize_t max1363_show_name(struct device *dev,
                                 struct device_attribute *attr,
@@ -462,7 +462,7 @@
        return sprintf(buf, "%s\n", st->chip_info->name);
 }

-IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);
+static IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);

 /*name export */

-Michael


>
> I've cheated a bit on the event equivalent as they define a pair of
> structures.  Keep meaning to ask on how to do things like that
> properly (don't suppose anyone knows?)
>
> On another note, I'm getting increasingly tempted to drop the device
> specific headers and move over to a more hwmon like fix naming at
> review.  With new api they are huge and sometimes actually add code
> rather than saving it.  Not that it effects these particularly macros.
>
>
>
>>
>>
>> Index: drivers/staging/iio/sysfs.h
>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>> --- drivers/staging/iio/sysfs.h (revision 8430)
>> +++ drivers/staging/iio/sysfs.h (working copy)
>> @@ -95,16 +95,16 @@
>>                         .val2 =3D _val2 }
>>  #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)    \
>> -       struct iio_dev_attr iio_dev_attr_##_name                \
>> +       static struct iio_dev_attr iio_dev_attr_##_name         \
>>         =3D IIO_ATTR(_name, _mode, _show, _store, _addr)
>>
>>  #define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr,
>> _val2) \ -       struct iio_dev_attr iio_dev_attr_##_name \ +
>> static struct iio_dev_attr iio_dev_attr_##_name
> \
>>         =3D IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)
>>  #define IIO_CONST_ATTR(_name, _string)
> \
>> -       struct iio_const_attr iio_const_attr_##_name \ +       static
>> struct iio_const_attr iio_const_attr_##_name
> \
>>         =3D { .string =3D _string,
> \
>>             .dev_attr =3D __ATTR(_name, S_IRUGO, iio_read_const_attr,
>> NULL)}
>>
>>
>> ------------------------------------------------------------------
>> ********* Analog Devices GmbH              Open Platform Solutions
>> **  *****
>> **     ** Wilhelm-Wagenfeld-Strasse 6
>> **  ***** D-80807 Munich
>> ********* Germany
>> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas Wessel=
,
>> William A. Martin, Margaret K. Seif
>>
>>
Greetings,
Michael

Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Geschaeft=
sfuehrer Thomas Wessel, William A. Martin, Margaret Seif
