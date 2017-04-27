Return-Path: <SRS0=18F/=4D=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH] iio: proximity: as3935: move storm out of range check
Date: Wed, 26 Apr 2017 22:30:00 -0700
Message-Id: <20170427053000.31792-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

Move out of storm check to apply to IIO_CHAN_INFO_RAW so the reported
results are constant between the former and the IIO_CHAN_INFO_PROCESSED

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/proximity/as3935.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/proximity/as3935.c b/drivers/iio/proximity/as3935.c
index ddf9bee89f77..aa0d0be1a608 100644
--- a/drivers/iio/proximity/as3935.c
+++ b/drivers/iio/proximity/as3935.c
@@ -176,13 +176,13 @@ static int as3935_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		if (m == IIO_CHAN_INFO_RAW)
-			return IIO_VAL_INT;
-
 		/* storm out of range */
 		if (*val == AS3935_DATA_MASK)
 			return -EINVAL;
 
+		if (m == IIO_CHAN_INFO_RAW)
+			return IIO_VAL_INT;
+
 		if (m == IIO_CHAN_INFO_PROCESSED)
 			*val *= 1000;
 		break;
-- 
2.11.0
