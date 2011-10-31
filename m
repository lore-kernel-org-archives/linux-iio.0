Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:56614 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932704Ab1JaLQJ (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 31 Oct 2011 07:16:09 -0400
Message-ID: <4EAE8574.2050900@cam.ac.uk>
Date: Mon, 31 Oct 2011 11:24:36 +0000
From: Jonathan Cameron <jic23@cam.ac.uk>
MIME-Version: 1.0
To: Dan Carpenter <dan.carpenter@oracle.com>
CC: linux-iio@vger.kernel.org
Subject: Re: linux-next: build error from iio_simple_dummy_buffer.c
References: <20111028112910.GB14881@longonot.mountain>
In-Reply-To: <20111028112910.GB14881@longonot.mountain>
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

On 10/28/11 12:29, Dan Carpenter wrote:
> I get a compile error in linux-next:
>=20
>   CC [M]  drivers/staging/iio/iio_simple_dummy_buffer.o
>   drivers/staging/iio/iio_simple_dummy_buffer.c: In function =E2=80=98=
iio_simple_dummy_configure_buffer=E2=80=99:
>   drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: error: =E2=80=
=98THIS_MODULE=E2=80=99 undeclared (first use in this function)
>   drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: note: each un=
declared identifier is reported only once for each function it appears =
in
>   make[1]: *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error =
1
>   make: *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 2
>=20
> We could just include <linux/module.h> I guess?
Yup, my bad.  Do you want to do the patch, or shall I do it and
credit it to you?
>=20
> regards,
> dan carpenter
>=20

