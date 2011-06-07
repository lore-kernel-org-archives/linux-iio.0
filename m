Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-41.csi.cam.ac.uk ([131.111.8.141]:54404 "EHLO
	ppsw-41.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751834Ab1FGJTY (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 7 Jun 2011 05:19:24 -0400
Message-ID: <4DEDEEFF.3030600@cam.ac.uk>
Date: Tue, 07 Jun 2011 10:27:27 +0100
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: michael.hennerich@analog.com
CC: "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: Re: naming IIO_IN_DIFF in-in
References: <4DEDE8A2.7030803@analog.com>
In-Reply-To: <4DEDE8A2.7030803@analog.com>
Content-Type: text/plain; charset=windows-1252
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 06/07/11 10:00, Michael Hennerich wrote:
> Hi Jonathan,
>=20
> I wonder if naming IIO_IN_DIFF in-in is really a good idea.
> Declaring the attribute in a conventional fashion doesn't work.
>=20
> static IIO_DEVICE_ATTR(in-in_scale_available, S_IRUGO, \
> ad7793_show_scale_available, NULL, 0);
Yup, that's why we have IIO_DEVICE_ATTR_NAMED.

static IIO_DEVICE_ATTR_NAMED(in_m_in_scale_available, in-in_scale_avail=
able,
S_IRUGO, ad7793_show_scale_available, NULL, 0)

should give you an iio_dev_attr_in_m_in_scale_available to use in the
attribute table.  It will show up in sysfs as in-in_scale_available.

>=20
> static struct attribute *ad7793_attributes[] =3D {
> &iio_dev_attr_sampling_frequency.dev_attr.attr,
> &iio_const_attr_sampling_frequency_available.dev_attr.attr,
> &iio_dev_attr_in-in_scale_available.dev_attr.attr,
> NULL
> };
>=20
> drivers/staging/iio/adc/ad7793.c:681: error: expected =91=3D=92, =91,=
=92, =91;=92, =91asm=92 or =91__attribute__=92 before =91-=92 token
> drivers/staging/iio/adc/ad7793.c:688: error: =91iio_dev_attr_in=92 un=
declared here (not in a function)
> drivers/staging/iio/adc/ad7793.c:688: error: =91in_scale_available=92=
 undeclared here (not in a function)
>=20

