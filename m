Return-Path: <Michael.Hennerich@analog.com>
Message-ID: <4DEDE8A2.7030803@analog.com>
Date: Tue, 7 Jun 2011 11:00:18 +0200
From: Michael Hennerich <michael.hennerich@analog.com>
Reply-To: <michael.hennerich@analog.com>
MIME-Version: 1.0
To: Jonathan Cameron <jic23@cam.ac.uk>
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: naming IIO_IN_DIFF in-in
Content-Type: text/plain; charset="windows-1252"; format=flowed
List-ID: <linux-iio@vger.kernel.org>

Hi Jonathan,

I wonder if naming IIO_IN_DIFF in-in is really a good idea.
Declaring the attribute in a conventional fashion doesn't work.

static IIO_DEVICE_ATTR(in-in_scale_available, S_IRUGO, \
ad7793_show_scale_available, NULL, 0);

static struct attribute *ad7793_attributes[] =3D {
&iio_dev_attr_sampling_frequency.dev_attr.attr,
&iio_const_attr_sampling_frequency_available.dev_attr.attr,
&iio_dev_attr_in-in_scale_available.dev_attr.attr,
NULL
};

drivers/staging/iio/adc/ad7793.c:681: error: expected =91=3D=92, =91,=92,=
 =91;=92,=20
=91asm=92 or =91__attribute__=92 before =91-=92 token
drivers/staging/iio/adc/ad7793.c:688: error: =91iio_dev_attr_in=92=20
undeclared here (not in a function)
drivers/staging/iio/adc/ad7793.c:688: error: =91in_scale_available=92=20
undeclared here (not in a function)

--=20
Greetings,
Michael

--
Analog Devices GmbH      Wilhelm-Wagenfeld-Str. 6      80807 Muenchen
Sitz der Gesellschaft: Muenchen; Registergericht: Muenchen HRB 40368;
Geschaeftsfuehrer:Dr.Carsten Suckrow, Thomas Wessel, William A. Martin,
Margaret Seif
