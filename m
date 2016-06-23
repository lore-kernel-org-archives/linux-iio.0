Return-Path: <gregor.boirie@parrot.com>
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald-Stadler
	<pmeerw@pmeerw.net>, Linus Walleij <linus.walleij@linaro.org>, Denis Ciocca
	<denis.ciocca@st.com>, Giuseppe Barba <giuseppe.barba@st.com>, Crestez Dan
 Leonard <leonard.crestez@intel.com>, Gregor Boirie <gregor.boirie@parrot.com>
Subject: [PATCH v1 2/7] iio:st_sensors: align on storagebits boundaries
Date: Thu, 23 Jun 2016 15:49:44 +0200
Message-ID: <5d5e3633e111079e78e2387915ae01de6cd82781.1466687364.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1466687364.git.gregor.boirie@parrot.com>
References: <cover.1466687364.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Ensure triggered buffering memory accesses are properly aligned on per
channel storagebits boundaries.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 37 +++++++++++------------
 drivers/iio/common/st_sensors/st_sensors_core.c   |  2 +-
 2 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index 4ccc438..c1fc205c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -24,30 +24,29 @@
 
 static int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
-	int i, len;
-	int total = 0;
+	int i;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
 	unsigned int num_data_channels = sdata->num_data_channels;
 
-	for (i = 0; i < num_data_channels; i++) {
-		unsigned int bytes_to_read;
-
-		if (test_bit(i, indio_dev->active_scan_mask)) {
-			bytes_to_read = indio_dev->channels[i].scan_type.storagebits >> 3;
-			len = sdata->tf->read_multiple_byte(&sdata->tb,
-				sdata->dev, indio_dev->channels[i].address,
-				bytes_to_read,
-				buf + total, sdata->multiread_bit);
-
-			if (len < bytes_to_read)
-				return -EIO;
-
-			/* Advance the buffer pointer */
-			total += len;
-		}
+	for_each_set_bit(i, indio_dev->active_scan_mask, num_data_channels) {
+		const struct iio_chan_spec *channel = &indio_dev->channels[i];
+		unsigned int bytes_to_read = channel->scan_type.realbits >> 3;
+		unsigned int storage_bytes =
+			channel->scan_type.storagebits >> 3;
+
+		buf = PTR_ALIGN(buf, storage_bytes);
+		if (sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
+						  channel->address,
+						  bytes_to_read, buf,
+						  sdata->multiread_bit) <
+		    bytes_to_read)
+			return -EIO;
+
+		/* Advance the buffer pointer */
+		buf += storage_bytes;
 	}
 
-	return total;
+	return 0;
 }
 
 irqreturn_t st_sensors_trigger_handler(int irq, void *p)
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index 00078b5..286f28c 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -482,7 +482,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	int err;
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
+	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
 
 	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
 	if (!outdata)
-- 
2.1.4
