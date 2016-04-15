Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 1/5] iio:adis: Add support for manual self-test flag clear
Date: Fri, 15 Apr 2016 16:59:38 +0200
Message-Id: <1460732382-6840-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

Some variants of the devices from the ADIS family don't auto-clear the
self-test bit after the self-test has completed. Instead we have to
manually clear. Add support for this to the ADIS library.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
I think we can get away without applying this to stable since the drivers
have been broken since forever and so this is more of a new feature rather
than a regression fix.
---
 drivers/iio/imu/adis.c       | 7 ++++++-
 include/linux/iio/imu/adis.h | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/imu/adis.c b/drivers/iio/imu/adis.c
index 911255d..ad6f91d 100644
--- a/drivers/iio/imu/adis.c
+++ b/drivers/iio/imu/adis.c
@@ -324,7 +324,12 @@ static int adis_self_test(struct adis *adis)
 
 	msleep(adis->data->startup_delay);
 
-	return adis_check_status(adis);
+	ret = adis_check_status(adis);
+
+	if (adis->data->self_test_no_autoclear)
+		adis_write_reg_16(adis, adis->data->msc_ctrl_reg, 0x00);
+
+	return ret;
 }
 
 /**
diff --git a/include/linux/iio/imu/adis.h b/include/linux/iio/imu/adis.h
index fa2d01e..360da7d 100644
--- a/include/linux/iio/imu/adis.h
+++ b/include/linux/iio/imu/adis.h
@@ -41,6 +41,7 @@ struct adis_data {
 	unsigned int diag_stat_reg;
 
 	unsigned int self_test_mask;
+	bool self_test_no_autoclear;
 	unsigned int startup_delay;
 
 	const char * const *status_error_msgs;
-- 
2.1.4
