Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 78-11-180-123.static.ip.netia.com.pl ([78.11.180.123]:40538
        "EHLO rere.qmqm.pl" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1753979AbdHUWDd (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Mon, 21 Aug 2017 18:03:33 -0400
Date: Tue, 22 Aug 2017 00:03:31 +0200
Message-Id: <763b40e19a19f0d35944b2b4bc0dcf7634dd69b8.1503352742.git.mirq-linux@rere.qmqm.pl>
In-Reply-To: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
References: <cover.1503352742.git.mirq-linux@rere.qmqm.pl>
From: =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v2 4/7] iio: accel: kxcjk1013: rename motion direction bits
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Rename INT_SRC2 bits - detected motion direction. This will avoid
duplication when KXTF9's tap direction is implemented.

Signed-off-by: Michał Mirosław <mirq-linux@rere.qmqm.pl>
---
 drivers/iio/accel/kxcjk-1013.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/accel/kxcjk-1013.c b/drivers/iio/accel/kxcjk-1013.c
index 3022bc951dc2..252004640403 100644
--- a/drivers/iio/accel/kxcjk-1013.c
+++ b/drivers/iio/accel/kxcjk-1013.c
@@ -80,12 +80,12 @@
 #define KXCJK1013_REG_INT_SRC1_BIT_WUFS	BIT(1)
 #define KXCJK1013_REG_INT_SRC1_BIT_DRDY	BIT(4)
 
-#define KXCJK1013_REG_INT_SRC2_BIT_ZP	BIT(0)
-#define KXCJK1013_REG_INT_SRC2_BIT_ZN	BIT(1)
-#define KXCJK1013_REG_INT_SRC2_BIT_YP	BIT(2)
-#define KXCJK1013_REG_INT_SRC2_BIT_YN	BIT(3)
-#define KXCJK1013_REG_INT_SRC2_BIT_XP	BIT(4)
-#define KXCJK1013_REG_INT_SRC2_BIT_XN	BIT(5)
+#define KXCJK1013_DIRECTION_BIT_ZP	BIT(0)
+#define KXCJK1013_DIRECTION_BIT_ZN	BIT(1)
+#define KXCJK1013_DIRECTION_BIT_YP	BIT(2)
+#define KXCJK1013_DIRECTION_BIT_YN	BIT(3)
+#define KXCJK1013_DIRECTION_BIT_XP	BIT(4)
+#define KXCJK1013_DIRECTION_BIT_XN	BIT(5)
 
 #define KXCJK1013_DEFAULT_WAKE_THRES	1
 
@@ -1043,7 +1043,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 		return;
 	}
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XN)
+	if (ret & KXCJK1013_DIRECTION_BIT_XN)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1052,7 +1052,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_FALLING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_XP)
+	if (ret & KXCJK1013_DIRECTION_BIT_XP)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1061,7 +1061,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_RISING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YN)
+	if (ret & KXCJK1013_DIRECTION_BIT_YN)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1070,7 +1070,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_FALLING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_YP)
+	if (ret & KXCJK1013_DIRECTION_BIT_YP)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1079,7 +1079,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_RISING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZN)
+	if (ret & KXCJK1013_DIRECTION_BIT_ZN)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
@@ -1088,7 +1088,7 @@ static void kxcjk1013_report_motion_event(struct iio_dev *indio_dev)
 						  IIO_EV_DIR_FALLING),
 			       data->timestamp);
 
-	if (ret & KXCJK1013_REG_INT_SRC2_BIT_ZP)
+	if (ret & KXCJK1013_DIRECTION_BIT_ZP)
 		iio_push_event(indio_dev,
 			       IIO_MOD_EVENT_CODE(IIO_ACCEL,
 						  0,
-- 
2.11.0

