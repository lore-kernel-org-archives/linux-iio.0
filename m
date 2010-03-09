Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-7.csi.cam.ac.uk ([131.111.8.137]:53789 "EHLO
	ppsw-7.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752154Ab0CIPod (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 9 Mar 2010 10:44:33 -0500
Message-ID: <4B966D65.8050100@cam.ac.uk>
Date: Tue, 09 Mar 2010 15:46:45 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: "Hennerich, Michael" <Michael.Hennerich@analog.com>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>
Subject: Re: [PATCH] IIO:sysfs.h: Use static declaration
References: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97D2@LIMKCMBX1.ad.analog.com> <4B966962.7010104@cam.ac.uk> <544AC56F16B56944AEC3BD4E3D5917712D6B1D97E9@LIMKCMBX1.ad.analog.com>
In-Reply-To: <544AC56F16B56944AEC3BD4E3D5917712D6B1D97E9@LIMKCMBX1.ad.analog.com>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 03/09/10 15:39, Hennerich, Michael wrote:
> Hi Jonathan,
>=20
> Jonathan Cameron wrote on 2010-03-09:
>> On 03/09/10 15:13, Hennerich, Michael wrote:
>>> Shouldn't those be better declared 'static'?
>>
>> No. Convention is to do that when calling the macro as then it is
>> explicit in the relevant place.  Now if any of the calls are missing
>> the static keyword, that would be an error.
>=20
> I don't mind - as long as they are declared static.
> Because I'm seeing collisions with your driver - that doesn't declare=
 it's common attributes static.
>=20
> What about this patch?
That's where they should be.... Actually I have a vague recollection th=
at
there is already a patch doing these in Greg's tree.  Also, not
worth pushing upstream as huge changes going into this driver shortly.
Of these, only name still exists.

Jonathan
>=20
> Index: drivers/staging/iio/adc/max1363_core.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- drivers/staging/iio/adc/max1363_core.c      (revision 8430)
> +++ drivers/staging/iio/adc/max1363_core.c      (working copy)
> @@ -446,12 +446,12 @@
>         return ret;
>  }
>=20
> -IIO_DEV_ATTR_AVAIL_SCAN_MODES(max1363_show_av_scan_modes);
> -IIO_DEV_ATTR_SCAN_MODE(S_IRUGO | S_IWUSR,
> +static IIO_DEV_ATTR_AVAIL_SCAN_MODES(max1363_show_av_scan_modes);
> +static IIO_DEV_ATTR_SCAN_MODE(S_IRUGO | S_IWUSR,
>                        max1363_show_scan_mode,
>                        max1363_store_scan_mode);
>=20
> -IIO_DEV_ATTR_SCAN(max1363_scan);
> +static IIO_DEV_ATTR_SCAN(max1363_scan);
>=20
>  static ssize_t max1363_show_name(struct device *dev,
>                                  struct device_attribute *attr,
> @@ -462,7 +462,7 @@
>         return sprintf(buf, "%s\n", st->chip_info->name);
>  }
>=20
> -IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);
> +static IIO_DEVICE_ATTR(name, S_IRUGO, max1363_show_name, NULL, 0);
>=20
>  /*name export */
>=20
> -Michael
>=20
>=20
>>
>> I've cheated a bit on the event equivalent as they define a pair of
>> structures.  Keep meaning to ask on how to do things like that
>> properly (don't suppose anyone knows?)
>>
>> On another note, I'm getting increasingly tempted to drop the device
>> specific headers and move over to a more hwmon like fix naming at
>> review.  With new api they are huge and sometimes actually add code
>> rather than saving it.  Not that it effects these particularly macro=
s.
>>
>>
>>
>>>
>>>
>>> Index: drivers/staging/iio/sysfs.h
>>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>>> --- drivers/staging/iio/sysfs.h (revision 8430)
>>> +++ drivers/staging/iio/sysfs.h (working copy)
>>> @@ -95,16 +95,16 @@
>>>                         .val2 =3D _val2 }
>>>  #define IIO_DEVICE_ATTR(_name, _mode, _show, _store, _addr)    \
>>> -       struct iio_dev_attr iio_dev_attr_##_name                \
>>> +       static struct iio_dev_attr iio_dev_attr_##_name         \
>>>         =3D IIO_ATTR(_name, _mode, _show, _store, _addr)
>>>
>>>  #define IIO_DEVICE_ATTR_2(_name, _mode, _show, _store, _addr,
>>> _val2) \ -       struct iio_dev_attr iio_dev_attr_##_name \ +
>>> static struct iio_dev_attr iio_dev_attr_##_name
>> \
>>>         =3D IIO_ATTR_2(_name, _mode, _show, _store, _addr, _val2)
>>>  #define IIO_CONST_ATTR(_name, _string)
>> \
>>> -       struct iio_const_attr iio_const_attr_##_name \ +       stat=
ic
>>> struct iio_const_attr iio_const_attr_##_name
>> \
>>>         =3D { .string =3D _string,
>> \
>>>             .dev_attr =3D __ATTR(_name, S_IRUGO, iio_read_const_att=
r,
>>> NULL)}
>>>
>>>
>>> ------------------------------------------------------------------
>>> ********* Analog Devices GmbH              Open Platform Solutions
>>> **  *****
>>> **     ** Wilhelm-Wagenfeld-Strasse 6
>>> **  ***** D-80807 Munich
>>> ********* Germany
>>> Registergericht M=FCnchen HRB 40368,  Gesch=E4ftsf=FChrer: Thomas W=
essel,
>>> William A. Martin, Margaret K. Seif
>>>
>>>
> Greetings,
> Michael
>=20
> Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
> Sitz der Gesellschaft Muenchen, Registergericht Muenchen HRB 4036 Ges=
chaeftsfuehrer Thomas Wessel, William A. Martin, Margaret Seif
>=20
>=20

