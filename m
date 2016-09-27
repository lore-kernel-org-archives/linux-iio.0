Return-Path: <masneyb@onstation.org>
From: Brian Masney <masneyb@onstation.org>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	gregkh@linuxfoundation.org
Subject: [PATCH v3 5/5] staging: iio: isl29018: check if the chip is in a suspended state
Date: Mon, 26 Sep 2016 20:20:20 -0400
Message-Id: <1474935620-13151-5-git-send-email-masneyb@onstation.org>
In-Reply-To: <1474935620-13151-1-git-send-email-masneyb@onstation.org>
References: <20160926075935.GA25938@kroah.com>
 <1474935620-13151-1-git-send-email-masneyb@onstation.org>
In-Reply-To: <20160926075935.GA25938@kroah.com>
References: <20160926075935.GA25938@kroah.com>
List-ID: <linux-iio@vger.kernel.org>

Add a check to isl29018_write_raw() to ensure that the chip is not in a
suspended state. This makes the code consistent with what is present
in isl29018_read_raw().

Signed-off-by: Brian Masney <masneyb@onstation.org>
---
 drivers/staging/iio/light/isl29018.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/iio/light/isl29018.c b/drivers/staging/iio/light/isl29018.c
index 3a4d79d..51226bd 100644
--- a/drivers/staging/iio/light/isl29018.c
+++ b/drivers/staging/iio/light/isl29018.c
@@ -355,6 +355,10 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 	int ret = -EINVAL;
 
 	mutex_lock(&chip->lock);
+	if (chip->suspended) {
+		ret = -EBUSY;
+		goto write_done;
+	}
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
 		if (chan->type == IIO_LIGHT) {
@@ -374,8 +378,9 @@ static int isl29018_write_raw(struct iio_dev *indio_dev,
 	default:
 		break;
 	}
-	mutex_unlock(&chip->lock);
 
+write_done:
+	mutex_unlock(&chip->lock);
 	return ret;
 }
 
-- 
2.7.4
