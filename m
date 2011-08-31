Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 01/12] iio: ad7291: fix channel mapping
Date: Wed, 31 Aug 2011 12:57:29 +0200
Message-ID: <1314788260-5791-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

ideally in_voltageX_raw should map to AD7291 VINX.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7291.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7291.c b/drivers/staging/iio/adc/ad7291.c
index b6be672..32944f3 100644
--- a/drivers/staging/iio/adc/ad7291.c
+++ b/drivers/staging/iio/adc/ad7291.c
@@ -434,7 +434,7 @@ static int ad7291_read_raw(struct iio_dev *indio_dev,
 			}
 			/* Enable this channel alone */
 			regval = chip->command & (~AD7291_VOLTAGE_MASK);
-			regval |= 1 << (chan->channel + 8);
+			regval |= 1 << (15 - chan->channel);
 			ret = ad7291_i2c_write(chip, AD7291_COMMAND, regval);
 			if (ret < 0) {
 				mutex_unlock(&chip->state_lock);
-- 
1.7.0.4
