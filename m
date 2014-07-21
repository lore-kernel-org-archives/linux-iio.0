Return-Path: <himangi774@gmail.com>
MIME-Version: 1.0
Date: Mon, 21 Jul 2014 13:54:15 +0530
Message-ID: <CAB78YHyh88+j-knC1HZQinnLU=9wbVPXrYRF81LeOtrV1oGmZA@mail.gmail.com>
Subject: questions regarding drivers/staging/iio/accel/sca3000_core.c
From: Himangi Saraogi <himangi774@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: Julia Lawall <julia.lawall@lip6.fr>
Content-Type: multipart/alternative; boundary=f46d044403b8263ac104feafd5a6
List-ID: <linux-iio@vger.kernel.org>

--f46d044403b8263ac104feafd5a6
Content-Type: text/plain; charset=UTF-8

Hi,

I was looking at the possibility of using a managed interface for
iio_device_register in sca3000_probe. But this will lead to the
iio_device_unregisterfunction being called after sca3000_unconfigure_ring
in the remove function. I have a few queries:

1. Is it safe to move the unregister function over the
sca3000_unconfigure_ring?

2. Is it correct that on failure the probe function does not call
sca3000_unconfigure_ring?

3. If it is fine moving unregister after sca3000_unconfigure_ring, I
propose to add a devm counterpart of iio_buffer_unregister. Is it a good
idea?

Thanks,
Himangi

--f46d044403b8263ac104feafd5a6
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div>Hi,<br><br>I was looking at the possibility=
 of using a managed interface for iio_device_register in sca3000_probe. But=
 this will lead to the iio_device_unregisterfunction being called after sca=
3000_unconfigure_ring in the remove function. I have a few queries:<br>
<br>1. Is it safe to move the unregister function over the sca3000_unconfig=
ure_ring?<br>
<br>
2. Is it correct that on failure the probe function does not call sca3000_u=
nconfigure_ring?<br><br></div>3. If it is fine moving unregister after sca3=
000_unconfigure_ring, I propose to add a devm counterpart of iio_buffer_unr=
egister. Is it a good idea?<br>
<br></div>Thanks,<br></div>Himangi<br></div>

--f46d044403b8263ac104feafd5a6--
