Return-Path: <ldewangan@nvidia.com>
From: Laxman Dewangan <ldewangan@nvidia.com>
To: Andrew Chew <AChew@nvidia.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>
CC: "jic23@cam.ac.uk" <jic23@cam.ac.uk>, "gregkh@suse.de" <gregkh@suse.de>
Date: Fri, 10 Sep 2010 08:54:25 +0530
Subject: RE: [PATCH 1/2] iio: Change GAIN macros to SCALE.
Message-ID: <96C9D994977DD0439FB6D3FE3B13DD906A9D1B5465@BGMAIL01.nvidia.com>
References: <1284008537-14758-1-git-send-email-achew@nvidia.com>
In-Reply-To: <1284008537-14758-1-git-send-email-achew@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-ID: <linux-iio@vger.kernel.org>

Looks good to me.  Adding my signoff:

Signed-off-by: Laxman Dewangan <ldewangan@nvidia.com>

Thanks,
Laxman

-----Original Message-----
From: Andrew Chew=20
Sent: Thursday, September 09, 2010 10:32 AM
To: linux-iio@vger.kernel.org
Cc: jic23@cam.ac.uk; gregkh@suse.de; Laxman Dewangan; Andrew Chew
Subject: [PATCH 1/2] iio: Change GAIN macros to SCALE.

From: Andrew Chew <achew@nvidia.com>

Per email exchange with Jonathan Cameron, GAIN should instead be SCALE, t=
o
be consistent with documentation.

Resending, since this goes with the 2/2 patch.

Signed-off-by: Andrew Chew <achew@nvidia.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
=20drivers/staging/iio/magnetometer/magnet.h |   12 ++++++------
=201 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/magnetometer/magnet.h b/drivers/staging/=
iio/magnetometer/magnet.h
index 6433830..1260eb7 100644
--- a/drivers/staging/iio/magnetometer/magnet.h
+++ b/drivers/staging/iio/magnetometer/magnet.h
@@ -12,14 +12,14 @@
=20#define IIO_DEV_ATTR_MAGN_Z_OFFSET(_mode, _show, _store, _addr)	\
=20	IIO_DEVICE_ATTR(magn_z_offset, _mode, _show, _store, _addr)
=20
-#define IIO_DEV_ATTR_MAGN_X_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_x_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_MAGN_X_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(magn_x_scale, _mode, _show, _store, _addr)
=20
-#define IIO_DEV_ATTR_MAGN_Y_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_y_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_MAGN_Y_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(magn_y_scale, _mode, _show, _store, _addr)
=20
-#define IIO_DEV_ATTR_MAGN_Z_GAIN(_mode, _show, _store, _addr)		\
-	IIO_DEVICE_ATTR(magn_z_gain, _mode, _show, _store, _addr)
+#define IIO_DEV_ATTR_MAGN_Z_SCALE(_mode, _show, _store, _addr)		\
+	IIO_DEVICE_ATTR(magn_z_scale, _mode, _show, _store, _addr)
=20
=20#define IIO_DEV_ATTR_MAGN_X(_show, _addr)				\
=20	IIO_DEVICE_ATTR(magn_x_raw, S_IRUGO, _show, NULL, _addr)
--=20
1.7.0.4

-------------------------------------------------------------------------=
----------
This email message is for the sole use of the intended recipient(s) and m=
ay contain
confidential information.  Any unauthorized review, use, disclosure or di=
stribution
is prohibited.  If you are not the intended recipient, please contact the=
=20sender by
reply email and destroy all copies of the original message.
-------------------------------------------------------------------------=
----------
