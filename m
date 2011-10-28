Return-Path: <dan.carpenter@oracle.com>
Date: Fri, 28 Oct 2011 14:29:10 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org
Subject: linux-next: build error from iio_simple_dummy_buffer.c
Message-ID: <20111028112910.GB14881@longonot.mountain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-iio@vger.kernel.org>

I get a compile error in linux-next:

  CC [M]  drivers/staging/iio/iio_simple_dummy_buffer.o
  drivers/staging/iio/iio_simple_dummy_buffer.c: In function =E2=80=98iio=
_simple_dummy_configure_buffer=E2=80=99:
  drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: error: =E2=80=98T=
HIS_MODULE=E2=80=99 undeclared (first use in this function)
  drivers/staging/iio/iio_simple_dummy_buffer.c:154:18: note: each undecl=
ared identifier is reported only once for each function it appears in
  make[1]: *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 1
  make: *** [drivers/staging/iio/iio_simple_dummy_buffer.o] Error 2

We could just include <linux/module.h> I guess?

regards,
dan carpenter
