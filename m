Return-Path: <SRS0=wbiz=B2=pmeerw.net=pmeerw@kernel.org>
From: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
To: Jonathan Cameron <jic23@kernel.org>
Cc: linux-iio@vger.kernel.org,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Matt Ranostay <matt@ranostay.consulting>
Subject: [PATCH 11/13] iio: health: max30102: Prepare for copying varying number of measurements
Date: Fri, 27 Oct 2017 21:29:51 +0200
Message-Id: <1509132593-1815-17-git-send-email-pmeerw@pmeerw.net>
In-Reply-To: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
References: <1509132593-1815-1-git-send-email-pmeerw@pmeerw.net>
List-ID: <linux-iio@vger.kernel.org>

Current code assumes always 2 measurements (6 bytes) have to be copied,
prepare for more flexibility

Signed-off-by: Peter Meerwald-Stadler <pmeerw@pmeerw.net>
Cc: Matt Ranostay <matt@ranostay.consulting>
---
 drivers/iio/health/max30102.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/health/max30102.c b/drivers/iio/health/max30102.c
index 1c7fe63..86058f0 100644
--- a/drivers/iio/health/max30102.c
+++ b/drivers/iio/health/max30102.c
@@ -58,7 +58,7 @@ enum max3012_led_idx {
 #define MAX30102_REG_FIFO_OVR_CTR		0x05
 #define MAX30102_REG_FIFO_RD_PTR		0x06
 #define MAX30102_REG_FIFO_DATA			0x07
-#define MAX30102_REG_FIFO_DATA_ENTRY_LEN	6
+#define MAX30102_REG_FIFO_DATA_BYTES		3
 
 #define MAX30102_REG_FIFO_CONFIG		0x08
 #define MAX30102_REG_FIFO_CONFIG_AVG_4SAMPLES	BIT(1)
@@ -198,6 +198,11 @@ static inline int max30102_fifo_count(struct max30102_data *data)
 	return 0;
 }
 
+#define MAX30102_COPY_DATA(i) \
+	memcpy(&data->processed_buffer[(i)], \
+	       &buffer[(i) * MAX30102_REG_FIFO_DATA_BYTES], \
+	       MAX30102_REG_FIFO_DATA_BYTES)
+
 static int max30102_read_measurement(struct max30102_data *data)
 {
 	int ret;
@@ -205,13 +210,13 @@ static int max30102_read_measurement(struct max30102_data *data)
 
 	ret = i2c_smbus_read_i2c_block_data(data->client,
 					    MAX30102_REG_FIFO_DATA,
-					    MAX30102_REG_FIFO_DATA_ENTRY_LEN,
+					    2 * MAX30102_REG_FIFO_DATA_BYTES,
 					    buffer);
 
-	memcpy(&data->processed_buffer[0], &buffer[0], 3);
-	memcpy(&data->processed_buffer[1], &buffer[3], 3);
+	MAX30102_COPY_DATA(0);
+	MAX30102_COPY_DATA(1);
 
-	return (ret == MAX30102_REG_FIFO_DATA_ENTRY_LEN) ? 0 : -EINVAL;
+	return (ret == 2 * MAX30102_REG_FIFO_DATA_BYTES) ? 0 : -EINVAL;
 }
 
 static irqreturn_t max30102_interrupt_handler(int irq, void *private)
-- 
2.7.4
