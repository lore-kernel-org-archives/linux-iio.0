Return-Path: <SRS0=gG0f=FY=gmail.com=shreeya.patel23498@kernel.org>
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net,
	gregkh@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org,
	daniel.baluta@gmail.com
Cc: Shreeya Patel <shreeya.patel23498@gmail.com>
Subject: [PATCH 2/6] Staging: iio: adis16209: Change the definition name
Date: Fri,  2 Mar 2018 18:53:41 +0530
Message-Id: <646c1e2ac1311db1879a5cae58f5f0a0c07114a5.1519995673.git.shreeya.patel23498@gmail.com>
In-Reply-To: <cover.1519995673.git.shreeya.patel23498@gmail.com>
References: <cover.1519995673.git.shreeya.patel23498@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The change in the definition name makes it then obvious
what the units are throughout the driver and there will
be no need of the comment.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/accel/adis16209.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209.c b/drivers/staging/iio/accel/adis16209.c
index 58f604d..830c278 100644
--- a/drivers/staging/iio/accel/adis16209.c
+++ b/drivers/staging/iio/accel/adis16209.c
@@ -20,7 +20,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/imu/adis.h>
 
-#define ADIS16209_STARTUP_DELAY	220 /* ms */
+#define ADIS16209_STARTUP_DELAY_MS	220
 
 /* Flash memory write count */
 #define ADIS16209_FLASH_CNT      0x00
@@ -303,7 +303,7 @@ static const struct adis_data adis16209_data = {
 
 	.self_test_mask = ADIS16209_MSC_CTRL_SELF_TEST_EN,
 	.self_test_no_autoclear = true,
-	.startup_delay = ADIS16209_STARTUP_DELAY,
+	.startup_delay = ADIS16209_STARTUP_DELAY_MS,
 
 	.status_error_msgs = adis16209_status_error_msgs,
 	.status_error_mask = BIT(ADIS16209_DIAG_STAT_SELFTEST_FAIL_BIT) |
-- 
2.7.4
