Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from ppsw-50.csi.cam.ac.uk ([131.111.8.150]:47517 "EHLO
	ppsw-50.csi.cam.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755438Ab1F2Ln4 (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 29 Jun 2011 07:43:56 -0400
From: Jonathan Cameron <jic23@cam.ac.uk>
To: linux-iio@vger.kernel.org
Cc: device-drivers-devel@blackfin.uclinux.org, ldewangan@nvidia.com,
	shubhrajyoti@ti.com, Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 12/24] staging:iio:gyro:adis16130 fix adis16130_spi_read which was never selecting the channel
Date: Wed, 29 Jun 2011 12:51:44 +0100
Message-Id: <1309348316-7699-13-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
References: <1309348316-7699-1-git-send-email-jic23@cam.ac.uk>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/gyro/adis16130_core.c |   15 ++++++++++++---
 1 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/iio/gyro/adis16130_core.c b/drivers/staging/iio/gyro/adis16130_core.c
index c80e908..caf067c 100644
--- a/drivers/staging/iio/gyro/adis16130_core.c
+++ b/drivers/staging/iio/gyro/adis16130_core.c
@@ -75,15 +75,24 @@ static int adis16130_spi_read(struct device *dev, u8 reg_addr,
 	int ret;
 	struct iio_dev *indio_dev = dev_get_drvdata(dev);
 	struct adis16130_state *st = iio_priv(indio_dev);
+	struct spi_message msg;
+	struct spi_transfer xfer = {
+		.tx_buf = st->buf,
+		.rx_buf = st->buf,
+	};
 
 	mutex_lock(&st->buf_lock);
 
 	st->buf[0] = ADIS16130_CON_RD | reg_addr;
+	st->buf[1] = st->buf[2] = st->buf[3] = 0;
+
 	if (st->mode)
-		ret = spi_read(st->us, st->buf, 4);
+		xfer.len = 4;
 	else
-		ret = spi_read(st->us, st->buf, 3);
-
+		xfer.len = 3;
+	spi_message_init(&msg);
+	spi_message_add_tail(&xfer, &msg);
+	ret = spi_sync(st->us, &msg);
 	if (ret == 0) {
 		if (st->mode)
 			*val = (st->buf[1] << 16) |
-- 
1.7.3.4

