Return-Path: <jic23@kernel.org>
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
	Linux Input <linux-input@vger.kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 36/38] input: tsc2007 - drop the driver_module assignment in iio interface.
Date: Mon, 29 May 2017 16:51:52 +0100
Message-Id: <20170529155154.22580-37-jic23@kernel.org>
In-Reply-To: <20170529155154.22580-1-jic23@kernel.org>
References: <20170529155154.22580-1-jic23@kernel.org>
List-ID: <linux-iio@vger.kernel.org>

This is now handled via some macro magic during the register.  The
field in iio_info will be removed shortly.

Cc: Linux Input <linux-input@vger.kernel.org>
Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/input/touchscreen/tsc2007_iio.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/input/touchscreen/tsc2007_iio.c b/drivers/input/touchscreen/tsc2007_iio.c
index 27b25a9fce83..e27a956f5f2b 100644
--- a/drivers/input/touchscreen/tsc2007_iio.c
+++ b/drivers/input/touchscreen/tsc2007_iio.c
@@ -104,7 +104,6 @@ static int tsc2007_read_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tsc2007_iio_info = {
 	.read_raw = tsc2007_read_raw,
-	.driver_module = THIS_MODULE,
 };
 
 int tsc2007_iio_configure(struct tsc2007 *ts)
-- 
2.13.0
