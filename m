Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail02.prevas.se ([62.95.78.10]:29413 "EHLO mail02.prevas.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932725AbcA0OtI (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Wed, 27 Jan 2016 09:49:08 -0500
From: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
To: <linux-iio@vger.kernel.org>
CC: Sean Nyekjaer <sean.nyekjaer@prevas.dk>, <lars@metafoo.de>
Subject: [PATCH] iio:dac:ad5755 fixed SPI_MODE
Date: Wed, 27 Jan 2016 15:39:07 +0100
Message-ID: <1453905547-27938-1-git-send-email-sean.nyekjaer@prevas.dk>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

According to datasheet data is latched on the falling edge of the SCK.

I agree it works in SPI_MODE_0 on the eval kit, but in other configurations
with optic isolators (that adds a small delay). We are falling out of spec.

Signed-off-by: Sean Nyekjaer <sean.nyekjaer@prevas.dk>
---
 drivers/iio/dac/ad5755.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/iio/dac/ad5755.c b/drivers/iio/dac/ad5755.c
index bfb350a..189d29a 100644
--- a/drivers/iio/dac/ad5755.c
+++ b/drivers/iio/dac/ad5755.c
@@ -573,6 +573,8 @@ static int ad5755_probe(struct spi_device *spi)
 	st = iio_priv(indio_dev);
 	spi_set_drvdata(spi, indio_dev);
 
+	spi->mode = SPI_MODE_1;
+
 	st->chip_info = &ad5755_chip_info_tbl[type];
 	st->spi = spi;
 	st->pwr_down = 0xf;
-- 
2.7.0

