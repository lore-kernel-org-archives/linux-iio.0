Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.aswsp.com ([193.34.35.150]:10891 "EHLO mail.aswsp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752966AbcDSJST (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Tue, 19 Apr 2016 05:18:19 -0400
From: Gregor Boirie <gregor.boirie@parrot.com>
To: <linux-iio@vger.kernel.org>
CC: Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Denis Ciocca <denis.ciocca@st.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Giuseppe Barba <giuseppe.barba@st.com>,
	Gregor Boirie <gregor.boirie@parrot.com>
Subject: [RFC PATCH v1 4/9] iio:st_sensors: align on storagebits boundaries
Date: Tue, 19 Apr 2016 11:18:35 +0200
Message-ID: <6b0ff9259418de8dacf125f642f2737ffcb62065.1461056711.git.gregor.boirie@parrot.com>
In-Reply-To: <cover.1461056711.git.gregor.boirie@parrot.com>
References: <cover.1461056711.git.gregor.boirie@parrot.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Triggered buffering memory accesses are not aligned on per channel
storagebits boundaries. Fix this by reading each channel individually to
ensure proper alignment.
Note that this patch drops the earlier optimisation that packs multiple
channels reading into a single data block transaction when their
respective I2C register addresses are contiguous.

Signed-off-by: Gregor Boirie <gregor.boirie@parrot.com>
---
 drivers/iio/common/st_sensors/st_sensors_buffer.c | 38 ++++++++++-------------
 drivers/iio/common/st_sensors/st_sensors_core.c   |  2 +-
 2 files changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/iio/common/st_sensors/st_sensors_buffer.c b/drivers/iio/common/st_sensors/st_sensors_buffer.c
index c558985..a7f1ced 100644
--- a/drivers/iio/common/st_sensors/st_sensors_buffer.c
+++ b/drivers/iio/common/st_sensors/st_sensors_buffer.c
@@ -21,33 +21,29 @@
 
 #include <linux/iio/common/st_sensors.h>
 
-
 int st_sensors_get_buffer_element(struct iio_dev *indio_dev, u8 *buf)
 {
-	int i, len;
-	int total = 0;
+	unsigned int cid;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	unsigned int num_data_channels = sdata->num_data_channels;
-
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
 
-			/* Advance the buffer pointer */
-			total += len;
-		}
+	for_each_set_bit(cid, indio_dev->active_scan_mask,
+			 sdata->num_data_channels) {
+		const struct iio_chan_spec *chan = &indio_dev->channels[cid];
+		int sb = chan->scan_type.storagebits / 8;
+		int rb = chan->scan_type.realbits / 8;
+		int err;
+
+		buf = PTR_ALIGN(buf, sb);
+		err = sdata->tf->read_multiple_byte(&sdata->tb, sdata->dev,
+						    chan->address, rb, buf,
+						    sdata->multiread_bit);
+		if (err != rb)
+			return (err < 0) ? err : -EIO;
+
+		buf += sb;
 	}
 
-	return total;
+	return 0;
 }
 EXPORT_SYMBOL(st_sensors_get_buffer_element);
 
diff --git a/drivers/iio/common/st_sensors/st_sensors_core.c b/drivers/iio/common/st_sensors/st_sensors_core.c
index dffe006..6901c7f 100644
--- a/drivers/iio/common/st_sensors/st_sensors_core.c
+++ b/drivers/iio/common/st_sensors/st_sensors_core.c
@@ -463,7 +463,7 @@ static int st_sensors_read_axis_data(struct iio_dev *indio_dev,
 	int err;
 	u8 *outdata;
 	struct st_sensor_data *sdata = iio_priv(indio_dev);
-	unsigned int byte_for_channel = ch->scan_type.storagebits >> 3;
+	unsigned int byte_for_channel = ch->scan_type.realbits >> 3;
 
 	outdata = kmalloc(byte_for_channel, GFP_KERNEL);
 	if (!outdata)
-- 
2.1.4

