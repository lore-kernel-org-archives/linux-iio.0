Return-Path: <fabf@skynet.be>
From: Fabian Frederick <fabf@skynet.be>
To: linux-kernel@vger.kernel.org
Cc: Fabian Frederick <fabf@skynet.be>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH 1/1 linux-next] iio: common: remove unnecessary sizeof(u8)
Date: Sun, 16 Nov 2014 13:33:24 +0100
Message-Id: <1416141204-19989-1-git-send-email-fabf@skynet.be>
List-ID: <linux-iio@vger.kernel.org>

sizeof(u8) is always 1.

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/iio/common/st_sensors/st_sensors_spi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_spi.c b/drivers/iio/common/st_sensors/st_sensors_spi.c
index 78a6a1a..5b37737 100644
--- a/drivers/iio/common/st_sensors/st_sensors_spi.c
+++ b/drivers/iio/common/st_sensors/st_sensors_spi.c
@@ -54,7 +54,7 @@ static int st_sensors_spi_read(struct st_sensor_transfer_buffer *tb,
 	if (err)
 		goto acc_spi_read_error;
 
-	memcpy(data, tb->rx_buf, len*sizeof(u8));
+	memcpy(data, tb->rx_buf, len);
 	mutex_unlock(&tb->buf_lock);
 	return len;
 
-- 
1.9.3
