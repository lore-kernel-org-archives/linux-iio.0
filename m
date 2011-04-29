Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 6/6] IIO: GYRO: ADXRS450: Don't exit probe, in case the power on default is not met.
Date: Fri, 29 Apr 2011 12:58:41 +0200
Message-ID: <1304074721-18159-6-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
References: <1304074721-18159-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

If the part get's probed twice without hard reset in between, the power on default
register read-back can't be met. This shouldn't cause the second probe to fail.
So warn but don't exit.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    8 +++-----
 1 files changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index e71b91c..7a9d7c2 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -278,11 +278,9 @@ static int adxrs450_initial_setup(struct adxrs450_state *st)
 	ret = adxrs450_spi_initial(st, &t, 1);
 	if (ret)
 		return ret;
-	if (t != 0x01) {
-		dev_err(&st->us->dev, "The initial response is not correct!\n");
-		return -ENODEV;
-
-	}
+	if (t != 0x01)
+		dev_warn(&st->us->dev, "The initial power on response "
+			 "is not correct! Restart without reset?\n");
 
 	msleep(ADXRS450_STARTUP_DELAY);
 	ret = adxrs450_spi_initial(st, &t, 0);
-- 
1.6.0.2
