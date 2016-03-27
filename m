Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-pa0-f65.google.com ([209.85.220.65]:36582 "EHLO
	mail-pa0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753375AbcC0Hmp (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Sun, 27 Mar 2016 03:42:45 -0400
Subject: [PATCH 28/31] iio: gyro: use parity32 in adxrs450.c
References: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>
From: "zhaoxiu.zeng" <zhaoxiu.zeng@gmail.com>
Message-ID: <56F78ED3.8080603@gmail.com>
Date: Sun, 27 Mar 2016 15:42:11 +0800
MIME-Version: 1.0
In-Reply-To: <1458788612-4367-1-git-send-email-zhaoxiu.zeng@gmail.com>
Content-Type: text/plain; charset=gbk
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

From: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zeng Zhaoxiu <zhaoxiu.zeng@gmail.com>
---
 drivers/iio/gyro/adxrs450.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index a330d42..f1f19fc20 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -108,9 +108,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->buf_lock);
 	tx = ADXRS450_READ_DATA | (reg_address << 17);
-
-	if (!(hweight32(tx) & 1))
-		tx |= ADXRS450_P;
+	tx |= !parity32(tx) * ADXRS450_P;
 
 	st->tx = cpu_to_be32(tx);
 	ret = spi_sync_transfer(st->us, xfers, ARRAY_SIZE(xfers));
@@ -144,9 +142,7 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 
 	mutex_lock(&st->buf_lock);
 	tx = ADXRS450_WRITE_DATA | (reg_address << 17) | (val << 1);
-
-	if (!(hweight32(tx) & 1))
-		tx |= ADXRS450_P;
+	tx |= !parity32(tx) * ADXRS450_P;
 
 	st->tx = cpu_to_be32(tx);
 	ret = spi_write(st->us, &st->tx, sizeof(st->tx));
-- 
2.5.5

