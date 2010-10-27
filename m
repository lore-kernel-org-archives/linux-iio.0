Return-Path: <vapier@gentoo.org>
From: Mike Frysinger <vapier@gentoo.org>
To: linux-iio@vger.kernel.org,
	Jonathan Cameron <jic23@cam.ac.uk>
Cc: device-drivers-devel@blackfin.uclinux.org,
	Barry Song <barry.song@analog.com>
Subject: [PATCH] staging: iio: adis16209: tuning spi delay to make hardware more stable
Date: Wed, 27 Oct 2010 10:19:00 -0400
Message-Id: <1288189140-5820-1-git-send-email-vapier@gentoo.org>
List-ID: <linux-iio@vger.kernel.org>

From: Barry Song <barry.song@analog.com>

Looks like one spot was missed in the previous spi tune patch.

Signed-off-by: Barry Song <barry.song@analog.com>
Signed-off-by: Mike Frysinger <vapier@gentoo.org>
---
 drivers/staging/iio/accel/adis16209_ring.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16209_ring.c b/drivers/staging/iio/accel/adis16209_ring.c
index 033135c..8eba0af 100644
--- a/drivers/staging/iio/accel/adis16209_ring.c
+++ b/drivers/staging/iio/accel/adis16209_ring.c
@@ -105,7 +105,7 @@ static int adis16209_read_ring_data(struct device *dev, u8 *rx)
 		xfers[i].bits_per_word = 8;
 		xfers[i].cs_change = 1;
 		xfers[i].len = 2;
-		xfers[i].delay_usecs = 20;
+		xfers[i].delay_usecs = 30;
 		xfers[i].tx_buf = st->tx + 2 * i;
 		st->tx[2 * i]
 			= ADIS16209_READ_REG(ADIS16209_SUPPLY_OUT + 2 * i);
-- 
1.7.3.2
