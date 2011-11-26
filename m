Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-52.csi.cam.ac.uk ([131.111.8.152]:49860 "EHLO
	ppsw-52.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752653Ab1KZJTm convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 26 Nov 2011 04:19:42 -0500
References: <CANFwon20C9NC6GmWnwfSHcWOSFe-7fdt_QbCQQNhegieNeDUNA@mail.gmail.com>
In-Reply-To: <CANFwon20C9NC6GmWnwfSHcWOSFe-7fdt_QbCQQNhegieNeDUNA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] fix build error of function iio_event_getfd
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Sat, 26 Nov 2011 09:19:34 +0000
To: Hui Zhu <teawater@gmail.com>, Greg Kroah-Hartman <gregkh@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Message-ID: <a3c3695e-8a13-4e44-9660-0df049d86003@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Thanks but this is 7th fix I have seen.

Hui Zhu <teawater@gmail.com> wrote:

>Got a build error:
>  CC [M]  drivers/staging/iio/industrialio-core.o
>/home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:
>In function =E2=80=98iio_event_getfd=E2=80=99:
>/home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:2=
62:32:
>error: =E2=80=98ev_int=E2=80=99 undeclared (first use in this function=
)
>/home/teawater/kernel2/linux/drivers/staging/iio/industrialio-core.c:2=
62:32:
>note: each undeclared identifier is reported only once for each
>function it appears in
>Not sure it is fixed or not.
>Post a patch for it.
>
>Signed-off-by: Hui Zhu <teawater@gmail.com>
>---
> drivers/staging/iio/industrialio-core.c |    1 +
> 1 file changed, 1 insertion(+)
>
>--- a/drivers/staging/iio/industrialio-core.c
>+++ b/drivers/staging/iio/industrialio-core.c
>@@ -243,6 +243,7 @@ static const struct file_operations iio_
> static int iio_event_getfd(struct iio_dev *indio_dev)
> {
> 	int fd;
>+	struct iio_event_interface *ev_int =3D indio_dev->event_interface;
>
> 	if (indio_dev->event_interface =3D=3D NULL)
> 		return -ENODEV;

--=20
Sent from my Android phone=20
with K-9 Mail. Please excuse my brevity.
