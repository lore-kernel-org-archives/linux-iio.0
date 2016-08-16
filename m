Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-qk0-f170.google.com ([209.85.220.170]:36213 "EHLO
	mail-qk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753631AbcHPNeb (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Tue, 16 Aug 2016 09:34:31 -0400
Received: by mail-qk0-f170.google.com with SMTP id l2so70464589qkf.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Aug 2016 06:34:31 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 06/17] iio: accel: kxsd9: Do away with the write2 helper
Date: Tue, 16 Aug 2016 15:33:32 +0200
Message-Id: <1471354423-19186-7-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
References: <1471354423-19186-1-git-send-email-linus.walleij@linaro.org>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

This is just a masquerading register write function, so use the
register write function instead.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/iio/accel/kxsd9-spi.c | 10 ----------
 drivers/iio/accel/kxsd9.c     |  4 ++--
 drivers/iio/accel/kxsd9.h     |  2 --
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index 0789695c89e1..332b7664233e 100644
--- a/drivers/iio/accel/kxsd9-spi.c
+++ b/drivers/iio/accel/kxsd9-spi.c
@@ -25,15 +25,6 @@ static int kxsd9_spi_writereg(struct kxsd9_transport *tr, u8 address, u8 val)
 	return spi_write(spi, tr->tx, 2);
 }
 
-static int kxsd9_spi_write2(struct kxsd9_transport *tr, u8 b1, u8 b2)
-{
-	struct spi_device *spi = tr->trdev;
-
-	tr->tx[0] = b1;
-	tr->tx[1] = b2;
-	return spi_write(spi, tr->tx, 2);
-}
-
 static int kxsd9_spi_readval(struct kxsd9_transport *tr, u8 address)
 {
 	struct spi_device *spi = tr->trdev;
@@ -70,7 +61,6 @@ static int kxsd9_spi_probe(struct spi_device *spi)
 	transport->trdev = spi;
 	transport->readreg = kxsd9_spi_readreg;
 	transport->writereg = kxsd9_spi_writereg;
-	transport->write2 = kxsd9_spi_write2;
 	transport->readval = kxsd9_spi_readval;
 	spi->mode = SPI_MODE_0;
 	spi_setup(spi);
diff --git a/drivers/iio/accel/kxsd9.c b/drivers/iio/accel/kxsd9.c
index efa9ba665f6e..7c94a0d3464a 100644
--- a/drivers/iio/accel/kxsd9.c
+++ b/drivers/iio/accel/kxsd9.c
@@ -184,10 +184,10 @@ static int kxsd9_power_up(struct kxsd9_state *st)
 {
 	int ret;
 
-	ret = st->transport->write2(st->transport, 0x0d, 0x40);
+	ret = st->transport->writereg(st->transport, KXSD9_REG_CTRL_B, 0x40);
 	if (ret)
 		return ret;
-	return st->transport->write2(st->transport, 0x0c, 0x9b);
+	return st->transport->writereg(st->transport, KXSD9_REG_CTRL_C, 0x9b);
 };
 
 static const struct iio_info kxsd9_info = {
diff --git a/drivers/iio/accel/kxsd9.h b/drivers/iio/accel/kxsd9.h
index c260a54e00fe..32f86c9b33c7 100644
--- a/drivers/iio/accel/kxsd9.h
+++ b/drivers/iio/accel/kxsd9.h
@@ -11,7 +11,6 @@ struct kxsd9_transport;
  * @trdev: transport device such as SPI or I2C
  * @readreg(): function to read a byte from an address in the device
  * @writereg(): function to write a byte to an address in the device
- * @write2(): function to write two consecutive bytes to the device
  * @readval(): function to read a 16bit value from the device
  * @rx: cache aligned read buffer
  * @tx: cache aligned write buffer
@@ -20,7 +19,6 @@ struct kxsd9_transport {
 	void *trdev;
 	int (*readreg) (struct kxsd9_transport *tr, u8 address);
 	int (*writereg) (struct kxsd9_transport *tr, u8 address, u8 val);
-	int (*write2) (struct kxsd9_transport *tr, u8 b1, u8 b2);
 	int (*readval) (struct kxsd9_transport *tr, u8 address);
 	u8 rx[KXSD9_STATE_RX_SIZE] ____cacheline_aligned;
 	u8 tx[KXSD9_STATE_TX_SIZE];
-- 
2.7.4

