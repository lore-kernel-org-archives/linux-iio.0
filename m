Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:36605 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1760679Ab2BNOfp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 14 Feb 2012 09:35:45 -0500
From: Danny Kukawka <danny.kukawka@bisect.de>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Danny Kukawka <dkukawka@suse.de>,
	Michael Hennerich <michael.hennerich@analog.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] adis16080: fix compiler -Wuninitialized
Date: Tue, 14 Feb 2012 15:35:36 +0100
Message-Id: <1329230136-26576-1-git-send-email-danny.kukawka@bisect.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

=46ix for:
drivers/staging/iio/gyro/adis16080_core.c: In function
  =E2=80=98adis16080_read_raw=E2=80=99:
drivers/staging/iio/gyro/adis16080_core.c:99:8: warning: =E2=80=98ut=E2=
=80=99
  may be used uninitialized in this function [-Wuninitialized]

Initialize ut and change error handling from adis16080_read_raw().

Signed-off-by: Danny Kukawka <danny.kukawka@bisect.de>
---
 drivers/staging/iio/gyro/adis16080_core.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16080_core.c b/drivers/stagin=
g/iio/gyro/adis16080_core.c
index 1815490..e0b2a29 100644
--- a/drivers/staging/iio/gyro/adis16080_core.c
+++ b/drivers/staging/iio/gyro/adis16080_core.c
@@ -82,7 +82,7 @@ static int adis16080_read_raw(struct iio_dev *indio_d=
ev,
 			     long mask)
 {
 	int ret =3D -EINVAL;
-	u16 ut;
+	u16 ut =3D 0;
 	/* Take the iio_dev status lock */
=20
 	mutex_lock(&indio_dev->mlock);
@@ -94,7 +94,7 @@ static int adis16080_read_raw(struct iio_dev *indio_d=
ev,
 		if (ret < 0)
 			break;
 		ret =3D adis16080_spi_read(indio_dev, &ut);
-		if (ret < 0)
+		if (ret)
 			break;
 		*val =3D ut;
 		ret =3D IIO_VAL_INT;
--=20
1.7.7.3

