Return-Path: <lars@metafoo.de>
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org,
	Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 2/5] staging:iio:adis16201: Set self_test_no_autoclear flag
Date: Fri, 15 Apr 2016 16:59:39 +0200
Message-Id: <1460732382-6840-2-git-send-email-lars@metafoo.de>
In-Reply-To: <1460732382-6840-1-git-send-email-lars@metafoo.de>
References: <1460732382-6840-1-git-send-email-lars@metafoo.de>
List-ID: <linux-iio@vger.kernel.org>

The ADIS16201 does not automatically clear the self test flag bit the self
test has been, so clear it manually. Otherwise we'll see a offset caused by
the self-test bias on the output values during normal operation.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/staging/iio/accel/adis16201_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/staging/iio/accel/adis16201_core.c b/drivers/staging/iio/accel/adis16201_core.c
index 06c0b75..6f3f8ff 100644
--- a/drivers/staging/iio/accel/adis16201_core.c
+++ b/drivers/staging/iio/accel/adis16201_core.c
@@ -167,6 +167,7 @@ static const struct adis_data adis16201_data = {
 	.diag_stat_reg = ADIS16201_DIAG_STAT,
 
 	.self_test_mask = ADIS16201_MSC_CTRL_SELF_TEST_EN,
+	.self_test_no_autoclear = true,
 	.startup_delay = ADIS16201_STARTUP_DELAY,
 
 	.status_error_msgs = adis16201_status_error_msgs,
-- 
2.1.4
