Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:40669 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753840Ab1HLPro (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Fri, 12 Aug 2011 11:47:44 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 08/12] staging:iio:accel:adis16201 overflow tx buffer.
Date: Fri, 12 Aug 2011 16:55:34 +0100
Message-Id: <1313164538-1769-9-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
References: <1313164538-1769-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Smatch caught bug.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/adis16201_ring.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/iio/accel/adis16201_ring.c b/drivers/staging/iio/accel/adis16201_ring.c
index 66e708d..a745d5de 100644
--- a/drivers/staging/iio/accel/adis16201_ring.c
+++ b/drivers/staging/iio/accel/adis16201_ring.c
@@ -38,10 +38,12 @@ static int adis16201_read_ring_data(struct iio_dev *indio_dev, u8 *rx)
 		xfers[i].cs_change = 1;
 		xfers[i].len = 2;
 		xfers[i].delay_usecs = 20;
-		xfers[i].tx_buf = st->tx + 2 * i;
-		st->tx[2 * i] = ADIS16201_READ_REG(ADIS16201_SUPPLY_OUT +
-						   2 * i);
-		st->tx[2 * i + 1] = 0;
+		if (i < ADIS16201_OUTPUTS) {
+			xfers[i].tx_buf = st->tx + 2 * i;
+			st->tx[2 * i] = ADIS16201_READ_REG(ADIS16201_SUPPLY_OUT +
+							   2 * i);
+			st->tx[2 * i + 1] = 0;
+		}
 		if (i >= 1)
 			xfers[i].rx_buf = rx + 2 * (i - 1);
 		spi_message_add_tail(&xfers[i], &msg);
-- 
1.7.3.4

