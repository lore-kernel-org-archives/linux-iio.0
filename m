Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-51.csi.cam.ac.uk ([131.111.8.151]:37167 "EHLO
	ppsw-51.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753295Ab1KYI61 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 25 Nov 2011 03:58:27 -0500
References: <1322210566-16841-1-git-send-email-abogani@kernel.org>
In-Reply-To: <1322210566-16841-1-git-send-email-abogani@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Subject: Re: [PATCH] iio: Fix build error
From: Jonathan Cameron <jic23@cam.ac.uk>
Date: Fri, 25 Nov 2011 08:57:48 +0000
To: Alessio Igor Bogani <abogani@kernel.org>
CC: linux-iio@vger.kernel.org
Message-ID: <2ffbe9ce-930c-4d1e-b5fb-6a789bba7f8b@email.android.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

=46ix number 5. Thanks but fix already on its way=20

Alessio Igor Bogani <abogani@kernel.org> wrote:

>drivers/staging/iio/industrialio-core.c: In function
>=E2=80=98iio_event_getfd=E2=80=99:
>drivers/staging/iio/industrialio-core.c:262:17:
>error: =E2=80=98ev_int=E2=80=99 undeclared (first use in this function=
)
>drivers/staging/iio/industrialio-core.c:262:17: note: each undeclared
>identifier is reported only once for each function it appears in
>
>Signed-off-by: Alessio Igor Bogani <abogani@kernel.org>
>---
> drivers/staging/iio/industrialio-core.c |   17 +++++++++--------
> 1 files changed, 9 insertions(+), 8 deletions(-)
>
>diff --git a/drivers/staging/iio/industrialio-core.c
>b/drivers/staging/iio/industrialio-core.c
>index 2656409..da17136 100644
>--- a/drivers/staging/iio/industrialio-core.c
>+++ b/drivers/staging/iio/industrialio-core.c
>@@ -242,25 +242,26 @@ static const struct file_operations
>iio_event_chrdev_fileops =3D {
>=20
> static int iio_event_getfd(struct iio_dev *indio_dev)
> {
>+	struct iio_event_interface *ev_int =3D indio_dev->event_interface;
> 	int fd;
>=20
>-	if (indio_dev->event_interface =3D=3D NULL)
>+	if (ev_int =3D=3D NULL)
> 		return -ENODEV;
>=20
>-	mutex_lock(&indio_dev->event_interface->event_list_lock);
>+	mutex_lock(&ev_int->event_list_lock);
> 	if (test_and_set_bit(IIO_BUSY_BIT_POS,
>-			     &indio_dev->event_interface->flags)) {
>-		mutex_unlock(&indio_dev->event_interface->event_list_lock);
>+			     &ev_int->flags)) {
>+		mutex_unlock(&ev_int->event_list_lock);
> 		return -EBUSY;
> 	}
>-	mutex_unlock(&indio_dev->event_interface->event_list_lock);
>+	mutex_unlock(&ev_int->event_list_lock);
> 	fd =3D anon_inode_getfd("iio:event",
> 				&iio_event_chrdev_fileops,
>-				indio_dev->event_interface, O_RDONLY);
>+				ev_int, O_RDONLY);
> 	if (fd < 0) {
>-		mutex_lock(&indio_dev->event_interface->event_list_lock);
>+		mutex_lock(&ev_int->event_list_lock);
> 		clear_bit(IIO_BUSY_BIT_POS, &ev_int->flags);
>-		mutex_unlock(&indio_dev->event_interface->event_list_lock);
>+		mutex_unlock(&ev_int->event_list_lock);
> 	}
> 	return fd;
> }
>--=20
>1.7.4.1

--=20
Sent from my Android phone=20
with K-9 Mail. Please excuse my brevity.
