Return-Path: <jin88.feng@gmail.com>
From: Jin Feng <jin88.feng@gmail.com>
To: jic23@cam.ac.uk
Cc: linux-iio@vger.kernel.org,
	Jin Feng <jin88.feng@gmail.com>
Subject: [PATCH] staging:iio:dummy: Fix mismatch and export sysfs entry
Date: Fri,  5 Apr 2013 12:51:15 +0800
Message-Id: <1365137475-38970-1-git-send-email-jin88.feng@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

Correct the mismatch bewteen calibscale and calibbias, and export
the in_accel_calibscale sysfs entry

Signed-off-by: Jin Feng <jin88.feng@gmail.com>
---
 drivers/staging/iio/iio_simple_dummy.c |    9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/iio_simple_dummy.c b/drivers/staging/iio/iio_simple_dummy.c
index aee76c7..4f2e876 100644
--- a/drivers/staging/iio/iio_simple_dummy.c
+++ b/drivers/staging/iio/iio_simple_dummy.c
@@ -168,6 +168,7 @@ static const struct iio_chan_spec iio_dummy_channels[] = {
 		.channel2 = IIO_MOD_X,
 		.info_mask =
 		IIO_CHAN_INFO_RAW_SEPARATE_BIT |
+		IIO_CHAN_INFO_CALIBSCALE_SHARED_BIT |
 		/*
 		 * Internal bias correction value. Applied
 		 * by the hardware or driver prior to userspace
@@ -314,7 +315,7 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 		st->dac_val = val;
 		mutex_unlock(&st->lock);
 		return 0;
-	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		mutex_lock(&st->lock);
 		/* Compare against table - hard matching here */
 		for (i = 0; i < ARRAY_SIZE(dummy_scales); i++)
@@ -327,6 +328,12 @@ static int iio_dummy_write_raw(struct iio_dev *indio_dev,
 			st->accel_calibscale = &dummy_scales[i];
 		mutex_unlock(&st->lock);
 		return ret;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		mutex_lock(&st->lock);
+		st->accel_calibbias = val;
+		mutex_unlock(&st->lock);
+		return 0;
+
 	default:
 		return -EINVAL;
 	}
-- 
1.7.9.5
