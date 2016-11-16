Return-Path: <lorenzo.bianconi83@gmail.com>
From: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	lorenzo.bianconi@st.com
Subject: [PATCH v2] iio: common: st_sensors: fix channel data parsing
Date: Wed, 16 Nov 2016 22:15:28 +0100
Message-Id: <1479330928-7208-1-git-send-email-lorenzo.bianconi@st.com>
List-ID: <linux-iio@vger.kernel.org>

Using realbits as i2c/spi read len, when that value is not byte aligned
(e.g 12 bits), lead to skip msb part of out data registers.
Fix this taking into account scan_type.shift in addition to
scan_type.realbits as read length:

read_len = DIV_ROUND_UP(realbits + shift, 8)

This fix has been tested on 8, 12, 16, 24 bit sensors

Fixes: e7385de5291e ("iio:st_sensors: align on storagebits boundaries")
Signed-off-by: Lorenzo Bianconi <lorenzo.bianconi@st.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 4 +++-
 drivers/iio/common/st_sensors/st_sensors_core.c   | 4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index fe7775b..df40452 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -30,7 +30,9 @@ static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 
 	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
 		const struct iio_chan_spec *channel = &indio_dev->channels[i];
-		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
+		unsigned int bytes_to_read =
+			DIV_ROUND_UP(channel->scan_type.realbits +
+				     channel->scan_type.shift, 8);
 		unsigned int storage_bytes =
 			channel->scan_type.storagebits >> 3;
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 975a1f1..d5cf7f3 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -483,8 +483,10 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	int err;
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
+	unsigned int byte_for_channel;
 
+	byte_for_channel = DIV_ROUND_UP(ch->scan_type.realbits +
+					ch->scan_type.shift, 8);
 	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
 	if (!outdata)
 		return -ENOMEM;
-- 
2.7.4
