Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@kernel.org>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH 2/3] iio: gyro: ADXRS450: Add missing read support for calibbias attribute
Date: Wed, 14 Dec 2011 13:12:51 +0100
Message-ID: <1323864772-24051-2-git-send-email-michael.hennerich@analog.com>
In-Reply-To: <1323864772-24051-1-git-send-email-michael.hennerich@analog.com>
References: <1323864772-24051-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>


Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/gyro/adxrs450_core.c |    7 +++++++
 1 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/drivers/staging/iio/gyro/adxrs450_core.c b/drivers/staging/iio/gyro/adxrs450_core.c
index 9d33628..a146d55 100644
--- a/drivers/staging/iio/gyro/adxrs450_core.c
+++ b/drivers/staging/iio/gyro/adxrs450_core.c
@@ -308,6 +308,13 @@ static int adxrs450_read_raw(struct iio_dev *indio_dev,
 		*val = t;
 		ret = IIO_VAL_INT;
 		break;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		ret = adxrs450_spi_read_reg_16(indio_dev, ADXRS450_DNC1, &t);
+		if (ret)
+			break;
+		*val = t;
+		ret = IIO_VAL_INT;
+		break;
 	default:
 		ret = -EINVAL;
 		break;
-- 
1.7.0.4
