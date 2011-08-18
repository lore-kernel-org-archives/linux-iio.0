Return-Path: <Michael.Hennerich@analog.com>
From: <michael.hennerich@analog.com>
To: <jic23@cam.ac.uk>
CC: <linux-iio@vger.kernel.org>, <device-drivers-devel@blackfin.uclinux.org>,
	<drivers@analog.com>, Michael Hennerich <michael.hennerich@analog.com>
Subject: [PATCH] iio: capfun: fix inverted logic of ThrFixed
Date: Thu, 18 Aug 2011 17:00:21 +0200
Message-ID: <1313679621-5347-1-git-send-email-michael.hennerich@analog.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

From: Michael Hennerich <michael.hennerich@analog.com>

Bit 7 of the AD7150 configuration register needs to be set for
fixed threshold modes.

Signed-off-by: Michael Hennerich <michael.hennerich@analog.com>
---
 drivers/staging/iio/adc/ad7150.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/adc/ad7150.c b/drivers/staging/iio/adc/ad7150.c
index 9e01614..fdf4da8 100644
--- a/drivers/staging/iio/adc/ad7150.c
+++ b/drivers/staging/iio/adc/ad7150.c
@@ -349,7 +349,7 @@ static int ad7150_write_event_config(struct iio_dev *indio_dev,
 		goto error_ret;
 	};
 
-	cfg |= (adaptive << 7) | (thresh_type << 5);
+	cfg |= (!adaptive << 7) | (thresh_type << 5);
 
 	ret = i2c_smbus_write_byte_data(chip->client, AD7150_CFG, cfg);
 	if (ret < 0)
-- 
1.7.0.4
