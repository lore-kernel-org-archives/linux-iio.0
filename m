Return-Path: <irina.tirdea@intel.com>
From: Irina Tirdea <irina.tirdea@intel.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald <pmeerw@pmeerw.net>,
	Irina Tirdea <irina.tirdea@intel.com>
Subject: [PATCH v2 1/1] iio: gyro: bmg160: fix endianness when reading axes
Date: Tue, 29 Mar 2016 15:37:30 +0300
Message-Id: <1459255050-2142-1-git-send-email-irina.tirdea@intel.com>
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

This is also partially fixed in commit 82d8e5da1a33 ("iio:
accel: bmg160: optimize transfers in trigger handler").

Signed-off-by: Irina Tirdea <irina.tirdea@intel.com>
---

Changes from v1:
 - pass sizeof(raw_val) to regmap_bulk_read instead of
hardcoded value

 drivers/iio/gyro/bmg160_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index bbce3b0..8d3f0b3 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -452,7 +452,7 @@ static int bmg160_get_temp(struct bmg160_data *data, int *val)
 static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 {
 	int ret;
-	unsigned int raw_val;
+	__le16 raw_val;
 
 	mutex_lock(&data->mutex);
 	ret = bmg160_set_power_state(data, true);
@@ -462,7 +462,7 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 	}
 
 	ret = regmap_bulk_read(data->regmap, BMG160_AXIS_TO_REG(axis), &raw_val,
-			       2);
+			       sizeof(raw_val));
 	if (ret < 0) {
 		dev_err(data->dev, "Error reading axis %d\n", axis);
 		bmg160_set_power_state(data, false);
@@ -470,7 +470,7 @@ static int bmg160_get_axis(struct bmg160_data *data, int axis, int *val)
 		return ret;
 	}
 
-	*val = sign_extend32(raw_val, 15);
+	*val = sign_extend32(le16_to_cpu(raw_val), 15);
 	ret = bmg160_set_power_state(data, false);
 	mutex_unlock(&data->mutex);
 	if (ret < 0)
@@ -733,6 +733,7 @@ static const struct iio_event_spec bmg160_event = {
 		.sign = 's',						\
 		.realbits = 16,					\
 		.storagebits = 16,					\
+		.endianness = IIO_LE,					\
 	},								\
 	.event_spec = &bmg160_event,					\
 	.num_event_specs = 1						\
-- 
1.9.1
