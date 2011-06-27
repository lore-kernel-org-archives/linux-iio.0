Return-Path: <jic23@cam.ac.uk>
From: Jonathan Cameron <jic23@cam.ac.uk>
To: greg@kroah.com
Cc: linux-iio@vger.kernel.org,
	anish kumar <anish198519851985@gmail.com>,
	Jonathan Cameron <jic23@cam.ac.uk>
Subject: [PATCH 54/54] staging:iio:accel:kxsd9 replace kmallocs in power_up with use of already allocated buffer.
Date: Mon, 27 Jun 2011 11:05:04 +0100
Message-Id: <1309169104-22139-55-git-send-email-jic23@cam.ac.uk>
In-Reply-To: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
References: <1309169104-22139-1-git-send-email-jic23@cam.ac.uk>
List-ID: <linux-iio@vger.kernel.org>

From: anish kumar <anish198519851985@gmail.com>

Signed-off-by: anish kumar <anish198519851985@gmail.com>
Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/staging/iio/accel/kxsd9.c |   38 ++++++++----------------------------
 1 files changed, 9 insertions(+), 29 deletions(-)

diff --git a/drivers/staging/iio/accel/kxsd9.c b/drivers/staging/iio/accel/kxsd9.c
index c0b2b23..3789741 100644
--- a/drivers/staging/iio/accel/kxsd9.c
+++ b/drivers/staging/iio/accel/kxsd9.c
@@ -251,52 +251,32 @@ static const struct attribute_group kxsd9_attribute_group = {
 	.attrs = kxsd9_attributes,
 };
 
-static int __devinit kxsd9_power_up(struct spi_device *spi)
+static int __devinit kxsd9_power_up(struct kxsd9_state *st)
 {
-	int ret;
 	struct spi_transfer xfers[2] = {
 		{
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
+			.tx_buf = st->tx,
 		}, {
 			.bits_per_word = 8,
 			.len = 2,
 			.cs_change = 1,
+			.tx_buf = st->tx + 2,
 		},
 	};
 	struct spi_message msg;
-	u8 *tx2;
-	u8 *tx = kmalloc(2, GFP_KERNEL);
-
-	if (tx == NULL) {
-		ret = -ENOMEM;
-		goto error_ret;
-	}
-	tx2 = kmalloc(2, GFP_KERNEL);
-	if (tx2 == NULL) {
-		ret = -ENOMEM;
-		goto error_free_tx;
-	}
-	tx[0] = 0x0d;
-	tx[1] = 0x40;
-
-	tx2[0] = 0x0c;
-	tx2[1] = 0x9b;
+	st->tx[0] = 0x0d;
+	st->tx[1] = 0x40;
+	st->tx[2] = 0x0c;
+	st->tx[3] = 0x9b;
 
-	xfers[0].tx_buf = tx;
-	xfers[1].tx_buf = tx2;
 	spi_message_init(&msg);
 	spi_message_add_tail(&xfers[0], &msg);
 	spi_message_add_tail(&xfers[1], &msg);
-	ret = spi_sync(spi, &msg);
-
-	kfree(tx2);
-error_free_tx:
-	kfree(tx);
-error_ret:
-	return ret;
 
+	return spi_sync(st->us, &msg);
 };
 
 static const struct iio_info kxsd9_info = {
@@ -331,7 +311,7 @@ static int __devinit kxsd9_probe(struct spi_device *spi)
 
 	spi->mode = SPI_MODE_0;
 	spi_setup(spi);
-	kxsd9_power_up(spi);
+	kxsd9_power_up(st);
 
 	return 0;
 
-- 
1.7.3.4
