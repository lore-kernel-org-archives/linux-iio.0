Return-Path: <mopsfelder@gmail.com>
From: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
To: linux-iio@vger.kernel.org,
	devel@driverdev.osuosl.org,
	linux-kernel@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	jic23@kernel.org,
	Murilo Opsfelder Araujo <mopsfelder@gmail.com>
Subject: [PATCH 1/8] staging: iio: accel: adis16203_core.c: fix coding style
Date: Thu, 31 Jul 2014 19:34:51 -0300
Message-Id: <1406846098-19866-2-git-send-email-mopsfelder@gmail.com>
In-Reply-To: <1406846098-19866-1-git-send-email-mopsfelder@gmail.com>
References: <1406846098-19866-1-git-send-email-mopsfelder@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

This patch adds missing blank line after declarations.

Signed-off-by: Murilo Opsfelder Araujo <mopsfelder@gmail.com>
---
 drivers/staging/iio/accel/adis16203_core.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/staging/iio/accel/adis16203_core.c b/drivers/staging/iio/accel/adis16203_core.c
index f472137..fbbe93f 100644
--- a/drivers/staging/iio/accel/adis16203_core.c
+++ b/drivers/staging/iio/accel/adis16203_core.c
@@ -37,6 +37,7 @@ static int adis16203_write_raw(struct iio_dev *indio_dev,
 	struct adis *st = iio_priv(indio_dev);
 	/* currently only one writable parameter which keeps this simple */
 	u8 addr = adis16203_addresses[chan->scan_index];
+
 	return adis_write_reg_16(st, addr, val & 0x3FFF);
 }
 
@@ -50,6 +51,7 @@ static int adis16203_read_raw(struct iio_dev *indio_dev,
 	int bits;
 	u8 addr;
 	s16 val16;
+
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
 		return adis_single_conversion(indio_dev, chan,
-- 
1.7.10.4
