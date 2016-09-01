Return-Path: <linus.walleij@linaro.org>
From: Linus Walleij <linus.walleij@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Linus Walleij <linus.walleij@linaro.org>
Subject: [PATCH 05/15 v2] iio: accel: kxsd9: Do away with the write2 helper
Date: Thu,  1 Sep 2016 11:44:39 +0200
Message-Id: <1472723089-25113-5-git-send-email-linus.walleij@linaro.org>
In-Reply-To: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
References: <1472723089-25113-1-git-send-email-linus.walleij@linaro.org>
List-ID: <linux-iio@vger.kernel.org>

This is just a masquerading register write function, so use the
register write function instead.

Tested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rebase on the rest of the series.
---
 drivers/iio/accel/kxsd9-spi.c | 10 ----------
 drivers/iio/accel/kxsd9.c     |  4 ++--
 drivers/iio/accel/kxsd9.h     |  2 --
 3 files changed, 2 insertions(+), 14 deletions(-)

diff --git a/drivers/iio/accel/kxsd9-spi.c b/drivers/iio/accel/kxsd9-spi.c
index ec9d00d5340f..a49c10cd7634 100644
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
index e2033374bfef..a787ec236608 100644
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
index 28845c3440e9..b6328e88b56f 100644
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
