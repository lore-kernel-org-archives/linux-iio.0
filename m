Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 11/14] staging:iio:light:tsl2563 remove use of IIO_CHAN macro and make use modifier defines.
Date: Tue, 30 Aug 2011 12:41:16 +0100
Message-Id: <1314704479-15956-12-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
References: <1314704479-15956-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

This avoids issues in the new event code introduced shortly + makes
moving this one out of staging easier.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/light/tsl2563.c |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/light/tsl2563.c b/drivers/staging/iio/light/tsl2563.c
index bd879ad..3493d93 100644
--- a/drivers/staging/iio/light/tsl2563.c
+++ b/drivers/staging/iio/light/tsl2563.c
@@ -528,16 +528,26 @@ error_ret:
 	return ret;
 }
 
-#define INFO_MASK (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE)
-#define EVENT_MASK (IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_RISING) | \
-		    IIO_EV_BIT(IIO_EV_TYPE_THRESH, IIO_EV_DIR_FALLING))
-#define IIO_CHAN_2563(type, mod, proc, chan, imask, emask) \
-	IIO_CHAN(type, mod, 1, proc, NULL, chan, 0, imask, 0, 0, {}, emask)
-
 static const struct iio_chan_spec tsl2563_channels[] = {
-	IIO_CHAN_2563(IIO_LIGHT,     0, 1, 0, 0, 0),
-	IIO_CHAN_2563(IIO_INTENSITY, 1, 0, 0, INFO_MASK, EVENT_MASK),
-	IIO_CHAN_2563(IIO_INTENSITY, 1, 0, 1, INFO_MASK, 0),
+	{
+		.type = IIO_LIGHT,
+		.indexed = 1,
+		.channel = 0,
+	}, {
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE),
+		.event_mask = (IIO_EV_BIT(IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_RISING) |
+			       IIO_EV_BIT(IIO_EV_TYPE_THRESH,
+					  IIO_EV_DIR_FALLING)),
+	}, {
+		.type = IIO_INTENSITY,
+		.modified = 1,
+		.channel2 = IIO_MOD_LIGHT_BOTH,
+		.info_mask = (1 << IIO_CHAN_INFO_CALIBSCALE_SEPARATE),
+	}
 };
 
 static int tsl2563_read_thresh(struct iio_dev *indio_dev,
-- 
1.7.3.4
