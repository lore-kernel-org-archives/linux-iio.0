Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: greg@kroah.com
CC: linux-iio@vger.kernel.org, drivers@analog.com, jic23@cam.ac.uk,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] staging: iio: dac: more consistent DAC sysfs attributes naming
Date: Fri, 19 Nov 2010 13:32:38 +0100
Message-ID: <1290169958-30951-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Align DAC sysfs attributes naming with the convention used by ADC

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/dac/dac.h |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/dac/dac.h b/drivers/staging/iio/dac/dac.h
index 55005ee..d9384c9 100644
--- a/drivers/staging/iio/dac/dac.h
+++ b/drivers/staging/iio/dac/dac.h
@@ -2,5 +2,9 @@
  * dac.h - sysfs attributes associated with DACs
  */

+/* Deprecated */
 #define IIO_DEV_ATTR_DAC(_num, _store, _addr)			\
 	IIO_DEVICE_ATTR(dac_##_num, S_IWUSR, NULL, _store, _addr)
+
+#define IIO_DEV_ATTR_OUT_RAW(_num, _store, _addr)				\
+	IIO_DEVICE_ATTR(out##_num##_raw, S_IWUSR, NULL, _store, _addr)
--
1.6.0.2
