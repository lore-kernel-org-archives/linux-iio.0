Return-Path: <zengzhaoxiu@163.com>
From: zengzhaoxiu@163.com
To: linux-kernel@vger.kernel.org
Cc: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [patch V4 26/31] iio: use parity32 in adxrs450
Date: Wed, 11 May 2016 17:22:56 +0800
Message-Id: <1462958577-25941-1-git-send-email-zengzhaoxiu@163.com>
In-Reply-To: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
References: <1462955158-28394-1-git-send-email-zengzhaoxiu@163.com>
List-ID: <linux-iio@vger.kernel.org>

From: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>

Signed-off-by: Zhaoxiu Zeng <zhaoxiu.zeng@gmail.com>
Acked-by: Jonathan Cameron <jic23@kernel.org>
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
2.7.4
