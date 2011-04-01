Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: jic23@cam.ac.uk
CC: linux-iio@vger.kernel.org, drivers@analog.com,
        device-drivers-devel@blackfin.uclinux.org,
        Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 1/2] IIO: sysfs: add IIO_EV_CLASS_OUT
Date: Fri, 1 Apr 2011 16:07:31 +0200
Message-ID: <1301666852-11078-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/sysfs.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/sysfs.h b/drivers/staging/iio/sysfs.h
index 24b74dd..9e3b784 100644
--- a/drivers/staging/iio/sysfs.h
+++ b/drivers/staging/iio/sysfs.h
@@ -266,6 +266,7 @@ struct iio_const_attr {
 #define IIO_EV_CLASS_MAGN		4
 #define IIO_EV_CLASS_LIGHT		5
 #define IIO_EV_CLASS_PROXIMITY		6
+#define IIO_EV_CLASS_OUT		7
 
 #define IIO_EV_MOD_X			0
 #define IIO_EV_MOD_Y			1
-- 
1.6.0.2
