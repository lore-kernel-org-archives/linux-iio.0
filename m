Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:54164 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760748Ab3BIQJM (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sat, 9 Feb 2013 11:09:12 -0500
Received: by mail-ea0-f180.google.com with SMTP id c1so1922106eaa.25
        for <linux-iio@vger.kernel.org>; Sat, 09 Feb 2013 08:09:11 -0800 (PST)
From: Denis Ciocca <denis.ciocca@gmail.com>
To: jic23@kernel.org, lars@metafoo.de, linux-iio@vger.kernel.org
Cc: Denis Ciocca <denis.ciocca@st.com>
Subject: [PATCH] iio:common: Use spi_sync_transfer() in STMicroelectronics common library
Date: Sat,  9 Feb 2013 17:08:23 +0100
Message-Id: <1360426103-3333-1-git-send-email-denis.ciocca@st.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Use the new spi_sync_transfer() helper function instead of open-coding it.

Signed-off-by: Denis Ciocca <denis.ciocca@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_spi.c |   11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index f0aa2f1..251baf6 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -29,7 +29,6 @@ static unsigned int st_sensors_spi_get_irq(struct iio_dev *indio_dev)
 static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
 	struct device *dev, u8 reg_addr, int len, u8 *data, bool multiread_bit)
 {
-	struct spi_message msg;
 	int err;
 
 	struct spi_transfer xfers[] = {
@@ -51,10 +50,7 @@ static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
 	else
 		tb->tx_buf[0] = reg_addr | ST_SENSORS_SPI_READ;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers[0], &msg);
-	spi_message_add_tail(&xfers[1], &msg);
-	err = spi_sync(to_spi_device(dev), &msg);
+	err = spi_sync_transfer(to_spi_device(dev), xfers, ARRAY_SIZE(xfers));
 	if (err)
 		goto acc_spi_read_error;
 
@@ -83,7 +79,6 @@ static int st_sensors_spi_read_multiple_byte(
 static int st_sensors_spi_write_byte(struct st_sensor_transfer_buffer *tb,
 				struct device *dev, u8 reg_addr, u8 data)
 {
-	struct spi_message msg;
 	int err;
 
 	struct spi_transfer xfers = {
@@ -96,9 +91,7 @@ static int st_sensors_spi_write_byte(struct st_sensor_transfer_buffer *tb,
 	tb->tx_buf[0] = reg_addr;
 	tb->tx_buf[1] = data;
 
-	spi_message_init(&msg);
-	spi_message_add_tail(&xfers, &msg);
-	err = spi_sync(to_spi_device(dev), &msg);
+	err = spi_sync_transfer(to_spi_device(dev), &xfers, 1);
 	mutex_unlock(&tb->buf_lock);
 
 	return err;
-- 
1.7.9.5

