Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from smtp-out-069.synserver.de ([212.40.185.69]:1091 "EHLO
	smtp-out-069.synserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753077Ab3APMsa (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 16 Jan 2013 07:48:30 -0500
From: Lars-Peter Clausen <lars@metafoo.de>
To: Jonathan Cameron <jic23@cam.ac.uk>
Cc: linux-iio@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 13/15] iio:adis16400: Add support for the 52.85 Hz base sampling rate
Date: Wed, 16 Jan 2013 13:48:49 +0100
Message-Id: <1358340531-31350-13-git-send-email-lars@metafoo.de>
In-Reply-To: <1358340531-31350-1-git-send-email-lars@metafoo.de>
References: <1358340531-31350-1-git-send-email-lars@metafoo.de>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The adis16400 and similar have two different base sampling rate available, from
which the actual sampling rate is derived. 1638 Hz and 52.85 Hz, switching to
the lower base sampling rate allows to support lower sampling rates.

This patch adds support for switching to the lower base sampling rate if the
requested sampling frequency is outside of the range which can be supported by
the higher base sampling rate.

The function which is used to read the current sampling rate already has support
for the lower sampling rate, so no changes are required there.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 drivers/iio/imu/adis16400_core.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/adis16400_core.c b/drivers/iio/imu/adis16400_core.c
index 8551fde..58699ac 100644
--- a/drivers/iio/imu/adis16400_core.c
+++ b/drivers/iio/imu/adis16400_core.c
@@ -92,18 +92,26 @@ static int adis16400_get_freq(struct adis16400_state *st)
 static int adis16400_set_freq(struct adis16400_state *st, unsigned int freq)
 {
 	unsigned int t;
+	uint8_t val = 0;
 
 	t = 1638404 / freq;
-	if (t > 0)
+	if (t >= 128) {
+		val |= ADIS16400_SMPL_PRD_TIME_BASE;
+		t = 52851 / freq;
+		if (t >= 128)
+			t = 127;
+	} else if (t != 0) {
 		t--;
-	t &= ADIS16400_SMPL_PRD_DIV_MASK;
+	}
+
+	val |= t;
 
-	if ((t & ADIS16400_SMPL_PRD_DIV_MASK) >= 0x0A)
+	if (t >= 0x0A || (val & ADIS16400_SMPL_PRD_TIME_BASE))
 		st->adis.spi->max_speed_hz = ADIS16400_SPI_SLOW;
 	else
 		st->adis.spi->max_speed_hz = ADIS16400_SPI_FAST;
 
-	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, t);
+	return adis_write_reg_8(&st->adis, ADIS16400_SMPL_PRD, val);
 }
 
 static ssize_t adis16400_read_frequency(struct device *dev,
-- 
1.8.0

