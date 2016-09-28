Return-Path: <lorenzo.bianconi83@gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com,
	denis.ciocca@st.com
Subject: [PATCH] iio: common: st_sensors: fix channel data parsing
Date: Wed, 28 Sep 2016 22:06:01 +0200
Message-Id: <1475093161-7239-1-git-send-email-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Using realbits as i2c/spi read len, when that value is not byte aligned
(e.g 12 bits), lead to skip msb part of out data registers.
Fix this using storagebits as read length

Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index fe7775b..d01aa34 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -30,16 +30,15 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 
 	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
 		const struct iio_chan_spec *channel = &indio_dev->channels[i];
-		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
 		unsigned int storage_bytes =
 			channel->scan_type.storagebits >> 3;
 
 		buf = PTR_ALIGN(buf, storage_bytes);
 		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
 						  channel->address,
-						  bytes_to_read, buf,
+						  storage_bytes, buf,
 						  sdata->multiread_bit) <
-		    bytes_to_read)
+		    storage_bytes)
 			return -EIO;
 
 		/* Advance the buffer pointer */
-- 
2.7.4
