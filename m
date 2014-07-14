Return-Path: <himangi774@gmail.com>
MIME-Version: 1.0
Date: Tue, 15 Jul 2014 02:01:59 +0530
Message-ID: <CAB78YHwneVuVBPujeKE=rEygvtyn=VvtLtd75+pvwqxPxYcB6g@mail.gmail.com>
Subject: question regarding drivers/staging/iio/adc/ad7280a.c
From: Himangi Saraogi <himangi774@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Content-Type: multipart/alternative; boundary=f46d0418255cd42f9804fe2d2ec1
List-ID: <linux-iio@vger.kernel.org>

--f46d0418255cd42f9804fe2d2ec1
Content-Type: text/plain; charset=UTF-8

Hi,

The code seems to have a memory leak. The function ad7280_attr_init calls
kasprintf a number of times, which calls kmalloc (or more precisely
kmalloc_track_caller), but this data does not ever seem to be freed. I
propose to introduce a devm_  version of kasprintf, which will be useful
for other files also. I am not very sure that will it be useful to
introduce a bunch of kfrees, just to remove the memory leaks immediately,
but I think it would be safer just to devm
everything, so then one is sure that everything is freed as it should be,
in the right order.

Thanks
Himangi

--f46d0418255cd42f9804fe2d2ec1
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br></div>The code seems to have a m=
emory leak. The function ad7280_attr_init calls kasprintf a number of times=
, which calls kmalloc (or more precisely kmalloc_track_caller), but this da=
ta does not ever seem to be freed. I propose to introduce a devm_=C2=A0 ver=
sion of kasprintf, which will be useful for other files also. I am not very=
 sure that will it be useful to introduce a bunch of kfrees, just to remove=
 the memory leaks immediately, but I think  it would be safer just to devm<=
br>

everything, so then one is sure that everything is freed as it should be,<b=
r>
in the right order.<br><br></div>Thanks<br></div>Himangi<br></div>

--f46d0418255cd42f9804fe2d2ec1--
