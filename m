Return-Path: <zhengdi05@gmail.com>
Message-ID: <53B934A9.9090603@gmail.com>
Date: Sun, 06 Jul 2014 19:36:09 +0800
From: vv <zhengdi05@gmail.com>
MIME-Version: 1.0
To: linux-iio@vger.kernel.org
CC: jic23@kernel.org
Subject: [PATCH] staging: iio: iio_simple_dummy_events.c: fix coding style
Content-Type: multipart/mixed;
 boundary="------------090807030307090005050401"
List-ID: <linux-iio@vger.kernel.org>

This is a multi-part message in MIME format.
--------------090807030307090005050401
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit


--------------090807030307090005050401
Content-Type: text/x-patch;
 name="0001-staging-iio-iio_simple_dummy_events.c-fix-coding-sty.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename*0="0001-staging-iio-iio_simple_dummy_events.c-fix-coding-sty.pa";
 filename*1="tch"

>From c7ee09b8866d32960b2c6520d107504d70f9f7b5 Mon Sep 17 00:00:00 2001
From: vv1133 <zhengdi05@gmail.com>
Date: Sun, 6 Jul 2014 19:26:49 +0800
Subject: [PATCH] staging: iio: iio_simple_dummy_events.c: fix coding style

Signed-off-by: vv1133 <zhengdi05@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy_events.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/iio_simple_dummy_events.c b/drivers/staging/iio/iio_simple_dummy_events.c
index 812ebd0..64b45b0 100644
--- a/drivers/staging/iio/iio_simple_dummy_events.c
+++ b/drivers/staging/iio/iio_simple_dummy_events.c
@@ -148,6 +148,7 @@ int iio_simple_dummy_write_event_value(struct iio_dev *indio_dev,
 static irqreturn_t iio_simple_dummy_event_handler(int irq, void *private)
 {
 	struct iio_dev *indio_dev = private;
+
 	iio_push_event(indio_dev,
 		       IIO_EVENT_CODE(IIO_VOLTAGE, 0, 0,
 				      IIO_EV_DIR_RISING,
-- 
1.7.9.5


--------------090807030307090005050401--
