Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Markus Pargmann <mpa@pengutronix.de>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH 1/1] iio: accel: bmc150: fix endianness when reading axes
Date: Mon, 28 Mar 2016 20:12:21 +0300
Message-Id: <1459185141-18319-1-git-send-email-irina.tirdea@intel.com>
List-ID: <linux-iio@vger.kernel.org>

For big endian platforms, reading the axes will return
invalid values.

The device stores each axis value in a 16 bit little
endian register. The driver uses regmap_read_bulk to get
the axis value, resulting in a 16 bit little endian value.
This needs to be converted to cpu endianness to work
on big endian platforms.

Fix endianness for big endian platforms by converting
the values for the axes read from little endian to
cpu.

This is also partially fixed in commit b6fb9b6d6552 ("iio:
accel: bmc150: optimize transfers in trigger handler").

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index c73331f7..5b64c3e 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -547,7 +547,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 {
 	int ret;
 	int axis = chan->scan_index;
-	unsigned int raw_val;
+	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmc150_accel_set_power_state(data, true);
@@ -564,7 +564,7 @@ static int bmc150_accel_get_axis(struct bmc150_accel_data *data,
 		mutex_unlock(&data->mutex);
 		return ret;
 	}
-	*val = sign_extend32(raw_val >> chan->scan_type.shift,
+	*val = sign_extend32(le16_to_cpu(raw_val) >> chan->scan_type.shift,
 			     chan->scan_type.realbits - 1);
 	ret = bmc150_accel_set_power_state(data, false);
 	mutex_unlock(&data->mutex);
@@ -988,6 +988,7 @@ static const struct iio_event_spec bmc150_accel_event = {
 		.realbits = (bits),					\
 		.storagebits = 16,					\
 		.shift = 16 - (bits),					\
+		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &bmc150_accel_event,				\
 	.num_event_specs = 1						\
-- 
1.9.1
