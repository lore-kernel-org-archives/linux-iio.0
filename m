Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:2372 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750723Ab3HSPP5 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Mon, 19 Aug 2013 11:15:57 -0400
From: "Pandruvada, Srinivas" <srinivas.pandruvada@intel.com>
To: Peter Meerwald <pmeerw@pmeerw.net>,
	"linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>
Subject: RE: [PATCH] iio: Remove unnecessary _write_raw_get_fmt() in several
 hid-sensor drivers
Date: Mon, 19 Aug 2013 15:15:34 +0000
Message-ID: <4FA419E87744DF4DAECD5BCE1214B7A9382CE537@ORSMSX109.amr.corp.intel.com>
References: <1376831236-4219-1-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1376831236-4219-1-git-send-email-pmeerw@pmeerw.net>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

If IIO_VAL_INT_PLUS_MICRO is by default, then this patch is fine.

-----Original Message-----
From: Peter Meerwald [mailto:pmeerw@pmeerw.net] 
Sent: Sunday, August 18, 2013 6:07 AM
To: linux-iio@vger.kernel.org
Cc: Peter Meerwald; Pandruvada, Srinivas
Subject: [PATCH] iio: Remove unnecessary _write_raw_get_fmt() in several hid-sensor drivers

IIO_VAL_INT_PLUS_MICRO is the default, no need to return it explicitly

Signed-off-by: Peter Meerwald <pmeerw@pmeerw.net>
Cc: srinivas pandruvada <srinivas.pandruvada@intel.com>
---
 drivers/iio/accel/hid-sensor-accel-3d.c       | 8 --------
 drivers/iio/gyro/hid-sensor-gyro-3d.c         | 8 --------
 drivers/iio/light/hid-sensor-als.c            | 8 --------
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 8 --------
 4 files changed, 32 deletions(-)

diff --git a/drivers/iio/accel/hid-sensor-accel-3d.c b/drivers/iio/accel/hid-sensor-accel-3d.c
index 68df341..46d22f3 100644
--- a/drivers/iio/accel/hid-sensor-accel-3d.c
+++ b/drivers/iio/accel/hid-sensor-accel-3d.c
@@ -175,18 +175,10 @@ static int accel_3d_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int accel_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       long mask)
-{
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
 static const struct iio_info accel_3d_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &accel_3d_read_raw,
 	.write_raw = &accel_3d_write_raw,
-	.write_raw_get_fmt = &accel_3d_write_raw_get_fmt,
 };
 
 /* Function to push data to buffer */
diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index 9cc8aa1..be95179 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -175,18 +175,10 @@ static int gyro_3d_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int gyro_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       long mask)
-{
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
 static const struct iio_info gyro_3d_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &gyro_3d_read_raw,
 	.write_raw = &gyro_3d_write_raw,
-	.write_raw_get_fmt = &gyro_3d_write_raw_get_fmt,
 };
 
 /* Function to push data to buffer */
diff --git a/drivers/iio/light/hid-sensor-als.c b/drivers/iio/light/hid-sensor-als.c
index 84cf004..e59d00c 100644
--- a/drivers/iio/light/hid-sensor-als.c
+++ b/drivers/iio/light/hid-sensor-als.c
@@ -154,18 +154,10 @@ static int als_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int als_write_raw_get_fmt(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       long mask)
-{
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
 static const struct iio_info als_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &als_read_raw,
 	.write_raw = &als_write_raw,
-	.write_raw_get_fmt = &als_write_raw_get_fmt,
 };
 
 /* Function to push data to buffer */
diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index 5a6162d..a98460b 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -176,18 +176,10 @@ static int magn_3d_write_raw(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int magn_3d_write_raw_get_fmt(struct iio_dev *indio_dev,
-			       struct iio_chan_spec const *chan,
-			       long mask)
-{
-	return IIO_VAL_INT_PLUS_MICRO;
-}
-
 static const struct iio_info magn_3d_info = {
 	.driver_module = THIS_MODULE,
 	.read_raw = &magn_3d_read_raw,
 	.write_raw = &magn_3d_write_raw,
-	.write_raw_get_fmt = &magn_3d_write_raw_get_fmt,
 };
 
 /* Function to push data to buffer */
-- 
1.8.3.4

