Return-Path: <zengzhaoxiu@163.com>
From: zengzhaoxiu@163.com
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	knaack.h@gmx.de,
	pmeerw@pmeerw.net
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Subject: [PATCH v2 27/30] iio: use parity32 in adxrs450
Date: Wed,  6 Apr 2016 18:16:16 +0800
Message-Id: <1459937776-8438-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <57031D9D.801@gmail.com>
References: <57031D9D.801@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
---
 drivers/iio/gyro/adxrs450.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/gyro/adxrs450.c b/drivers/iio/gyro/adxrs450.c
index a330d42..307f55b 100644
--- a/drivers/iio/gyro/adxrs450.c
+++ b/drivers/iio/gyro/adxrs450.c
@@ -109,7 +109,7 @@ static int adxrs450_spi_read_reg_16(struct iio_dev *indio_dev,
 	mutex_lock(&st->buf_lock);
 	tx = ADXRS450_READ_DATA | (reg_address << 17);
 
-	if (!(hweight32(tx) & 1))
+	if (!parity32(tx))
 		tx |= ADXRS450_P;
 
 	st->tx = cpu_to_be32(tx);
@@ -145,7 +145,7 @@ static int adxrs450_spi_write_reg_16(struct iio_dev *indio_dev,
 	mutex_lock(&st->buf_lock);
 	tx = ADXRS450_WRITE_DATA | (reg_address << 17) | (val << 1);
 
-	if (!(hweight32(tx) & 1))
+	if (!parity32(tx))
 		tx |= ADXRS450_P;
 
 	st->tx = cpu_to_be32(tx);
-- 
2.5.0
