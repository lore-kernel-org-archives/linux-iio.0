Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pg1-f194.google.com ([209.85.215.194]:46859 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbeKUD1N (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Tue, 20 Nov 2018 22:27:13 -0500
From: Shreeya Patel <shreeya.patel23498@gmail.com>
To: lars@metafoo.de, Michael.Hennerich@analog.com, jic23@kernel.org,
        knaack.h@gmx.de, pmeerw@pmeerw.net, gregkh@linuxfoundation.org,
        linux-iio@vger.kernel.org, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/5] Staging: iio: adt7316: Switch irq_flags to a local variable
Date: Tue, 20 Nov 2018 22:26:58 +0530
Message-Id: <20181120165658.7259-1-shreeya.patel23498@gmail.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

There is no need to store irq_flags into the structure as it
is always set to the same thing. Hence switch irq_flags to a
local variable.

Signed-off-by: Shreeya Patel <shreeya.patel23498@gmail.com>
---
 drivers/staging/iio/addac/adt7316-i2c.c | 1 -
 drivers/staging/iio/addac/adt7316-spi.c | 1 -
 drivers/staging/iio/addac/adt7316.c     | 8 ++++----
 drivers/staging/iio/addac/adt7316.h     | 1 -
 4 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316-i2c.c b/drivers/staging/iio/addac/adt7316-i2c.c
index 41bc4ca008bc..ac91163656b5 100644
--- a/drivers/staging/iio/addac/adt7316-i2c.c
+++ b/drivers/staging/iio/addac/adt7316-i2c.c
@@ -104,7 +104,6 @@ static int adt7316_i2c_probe(struct i2c_client *client,
 	struct adt7316_bus bus = {
 		.client = client,
 		.irq = client->irq,
-		.irq_flags = IRQF_TRIGGER_LOW,
 		.read = adt7316_i2c_read,
 		.write = adt7316_i2c_write,
 		.multi_read = adt7316_i2c_multi_read,
diff --git a/drivers/staging/iio/addac/adt7316-spi.c b/drivers/staging/iio/addac/adt7316-spi.c
index 5cd22743e140..e75827e326a6 100644
--- a/drivers/staging/iio/addac/adt7316-spi.c
+++ b/drivers/staging/iio/addac/adt7316-spi.c
@@ -94,7 +94,6 @@ static int adt7316_spi_probe(struct spi_device *spi_dev)
 	struct adt7316_bus bus = {
 		.client = spi_dev,
 		.irq = spi_dev->irq,
-		.irq_flags = IRQF_TRIGGER_LOW,
 		.read = adt7316_spi_read,
 		.write = adt7316_spi_write,
 		.multi_read = adt7316_spi_multi_read,
diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index deb2f7b40f60..dfae22619287 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -2102,6 +2102,7 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 	struct adt7316_chip_info *chip;
 	struct iio_dev *indio_dev;
 	unsigned short *adt7316_platform_data = dev->platform_data;
+	int irq_flags = IRQF_TRIGGER_LOW;
 	int ret = 0;
 
 	indio_dev = devm_iio_device_alloc(dev, sizeof(*chip));
@@ -2146,19 +2147,18 @@ int adt7316_probe(struct device *dev, struct adt7316_bus *bus,
 
 	if (chip->bus.irq > 0) {
 		if (adt7316_platform_data[0])
-			chip->bus.irq_flags = adt7316_platform_data[0];
+			irq_flags = adt7316_platform_data[0];
 
 		ret = devm_request_threaded_irq(dev, chip->bus.irq,
 						NULL,
 						adt7316_event_handler,
-						chip->bus.irq_flags |
-						IRQF_ONESHOT,
+						irq_flags | IRQF_ONESHOT,
 						indio_dev->name,
 						indio_dev);
 		if (ret)
 			return ret;
 
-		if (chip->bus.irq_flags & IRQF_TRIGGER_HIGH)
+		if (irq_flags & IRQF_TRIGGER_HIGH)
 			chip->config1 |= ADT7316_INT_POLARITY;
 	}
 
diff --git a/drivers/staging/iio/addac/adt7316.h b/drivers/staging/iio/addac/adt7316.h
index ec40fbb698a6..fd7c5c92b599 100644
--- a/drivers/staging/iio/addac/adt7316.h
+++ b/drivers/staging/iio/addac/adt7316.h
@@ -17,7 +17,6 @@
 struct adt7316_bus {
 	void *client;
 	int irq;
-	int irq_flags;
 	int (*read)(void *client, u8 reg, u8 *data);
 	int (*write)(void *client, u8 reg, u8 val);
 	int (*multi_read)(void *client, u8 first_reg, u8 count, u8 *data);
-- 
2.17.1
