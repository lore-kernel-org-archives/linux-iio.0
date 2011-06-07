Return-Path: <Michael.Hennerich@analog.com>
From: "Hennerich, Michael" <Michael.Hennerich@analog.com>
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Date: Tue, 7 Jun 2011 12:19:06 +0100
Subject: RE: naming IIO_IN_DIFF in-in
Message-ID: <544AC56F16B56944AEC3BD4E3D5917713AAF3C9ABC@LIMKCMBX1.ad.analog.com>
References: <4DEDE8A2.7030803@analog.com> <4DEDEEFF.3030600@cam.ac.uk>
In-Reply-To: <4DEDEEFF.3030600@cam.ac.uk>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-ID: <linux-iio@vger.kernel.org>

Jonathan Cameron wrote on 2011-06-07:
> On 06/07/11 10:00, Michael Hennerich wrote:
>> Hi Jonathan,
>>
>> I wonder if naming IIO_IN_DIFF in-in is really a good idea.
>> Declaring the attribute in a conventional fashion doesn't work.
>>
>> static IIO_DEVICE_ATTR(in-in_scale_available, S_IRUGO, \
>> ad7793_show_scale_available, NULL, 0);
> Yup, that's why we have IIO_DEVICE_ATTR_NAMED.
>
> static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available, in-
> in_scale_available, S_IRUGO, ad7793_show_scale_available, NULL, 0)
>
> should give you an iio_dev_attr_in_m_in_scale_available to use in the
> attribute table.  It will show up in sysfs as in-in_scale_available.


Hi Jonathan,

Thanks!


>>
>> static struct attribute *ad7793_attributes[] =3D {
>> &iio_dev_attr_sampling_frequency.dev_attr.attr,
>> &iio_const_attr_sampling_frequency_available.dev_attr.attr,
>> &iio_dev_attr_in-in_scale_available.dev_attr.attr,
>> NULL
>> };
>>
>> drivers/staging/iio/adc/ad7793.c:681: error: expected '=3D', ',', ';',
>> 'asm' or '__attribute__' before '-' token
>> drivers/staging/iio/adc/ad7793.c:688: error: 'iio_dev_attr_in'
>> undeclared here (not in a function)
>> drivers/staging/iio/adc/ad7793.c:688: error: 'in_scale_available'
>> undeclared here (not in a function)
>>
>

Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368; Gesch=
aeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin, Margaret=
 Seif
