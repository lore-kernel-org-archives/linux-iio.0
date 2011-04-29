Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <greg@kroah.com>
CC: <linux-iio@vger.kernel.org>, <drivers@analog.com>, <jic23@cam.ac.uk>,
	<device-drivers-devel@blackfin.uclinux.org>, Michael Hennerich
	<michael.hennerich@analog.com>
Subject: [PATCH 4/6] IIO: GYRO: ADXRS450: enforce sequential transfer delay of at least 0.1ms
Date: Fri, 29 Apr 2011 14:17:02 +0200
Message-ID: <1304079424-18506-4-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
References: <1304079424-18506-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
Acked-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 5671276..d73acff 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -116,6 +116,7 @@ static int adxrs450_spi_write_reg_16(struct device *dev,
 	if (ret)
 		dev_err(&st->us->dev, "problem while writing 16 bit register 0x%02x\n",
 				reg_address);
+	msleep(1); /* enforce sequential transfer delay 0.1ms */
 	mutex_unlock(&st->buf_lock);
 	return ret;
 }
--
1.6.0.2
