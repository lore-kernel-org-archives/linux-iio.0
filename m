Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail-db5eur01on0097.outbound.protection.outlook.com ([104.47.2.97]:22545
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S932183AbcKHTgv (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Tue, 8 Nov 2016 14:36:51 -0500
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Peter Meerwald-Stadler" <pmeerw@pmeerw.net>,
        Rob Herring <robh+dt@kernel.org>,
        "Mark Rutland" <mark.rutland@arm.com>,
        Daniel Baluta <daniel.baluta@intel.com>,
        Slawomir Stepien <sst@poczta.fm>,
        Thomas Gleixner <tglx@linutronix.de>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v4 3/8] iio: mcp4531: provide range of available raw values
Date: Tue, 8 Nov 2016 12:58:53 +0100
Message-ID: <1478606339-31253-4-git-send-email-peda@axentia.se>
In-Reply-To: <1478606339-31253-1-git-send-email-peda@axentia.se>
References: <1478606339-31253-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Example:

$ cat '/sys/bus/iio/devices/iio:device0/out_resistance_raw_available'
[0 1 256]

Meaning: min 0, step 1 and max 256.

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 .../testing/sysfs-bus-iio-potentiometer-mcp4531    |   8 ++
 MAINTAINERS                                        |   1 +
 drivers/iio/potentiometer/mcp4531.c                | 104 ++++++++++++---------
 3 files changed, 71 insertions(+), 42 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531

diff --git a/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531 b/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
new file mode 100644
index 000000000000..2a91fbe394fc
--- /dev/null
+++ b/Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
@@ -0,0 +1,8 @@
+What:		/sys/bus/iio/devices/iio:deviceX/out_resistance_raw_available
+Date:		October 2016
+KernelVersion:	4.9
+Contact:	Peter Rosin <peda@axentia.se>
+Description:
+		The range of available values represented as the minimum value,
+		the step and the maximum value, all enclosed in square brackets.
+		Example: [0 1 256]
diff --git a/MAINTAINERS b/MAINTAINERS
index 411e3b87b8c2..2409e1d79cb6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -7707,6 +7707,7 @@ MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVER
 M:	Peter Rosin <peda@axentia.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/ABI/testing/sysfs-bus-iio-potentiometer-mcp4531
 F:	drivers/iio/potentiometer/mcp4531.c
 
 MEASUREMENT COMPUTING CIO-DAC IIO DRIVER
diff --git a/drivers/iio/potentiometer/mcp4531.c b/drivers/iio/potentiometer/mcp4531.c
index 13b6ae2fcf7b..0d1bcf89ae17 100644
--- a/drivers/iio/potentiometer/mcp4531.c
+++ b/drivers/iio/potentiometer/mcp4531.c
@@ -38,7 +38,7 @@
 
 struct mcp4531_cfg {
 	int wipers;
-	int max_pos;
+	int avail[3];
 	int kohms;
 };
 
@@ -78,38 +78,38 @@ enum mcp4531_type {
 };
 
 static const struct mcp4531_cfg mcp4531_cfg[] = {
-	[MCP453x_502] = { .wipers = 1, .max_pos = 128, .kohms =   5, },
-	[MCP453x_103] = { .wipers = 1, .max_pos = 128, .kohms =  10, },
-	[MCP453x_503] = { .wipers = 1, .max_pos = 128, .kohms =  50, },
-	[MCP453x_104] = { .wipers = 1, .max_pos = 128, .kohms = 100, },
-	[MCP454x_502] = { .wipers = 1, .max_pos = 128, .kohms =   5, },
-	[MCP454x_103] = { .wipers = 1, .max_pos = 128, .kohms =  10, },
-	[MCP454x_503] = { .wipers = 1, .max_pos = 128, .kohms =  50, },
-	[MCP454x_104] = { .wipers = 1, .max_pos = 128, .kohms = 100, },
-	[MCP455x_502] = { .wipers = 1, .max_pos = 256, .kohms =   5, },
-	[MCP455x_103] = { .wipers = 1, .max_pos = 256, .kohms =  10, },
-	[MCP455x_503] = { .wipers = 1, .max_pos = 256, .kohms =  50, },
-	[MCP455x_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
-	[MCP456x_502] = { .wipers = 1, .max_pos = 256, .kohms =   5, },
-	[MCP456x_103] = { .wipers = 1, .max_pos = 256, .kohms =  10, },
-	[MCP456x_503] = { .wipers = 1, .max_pos = 256, .kohms =  50, },
-	[MCP456x_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
-	[MCP463x_502] = { .wipers = 2, .max_pos = 128, .kohms =   5, },
-	[MCP463x_103] = { .wipers = 2, .max_pos = 128, .kohms =  10, },
-	[MCP463x_503] = { .wipers = 2, .max_pos = 128, .kohms =  50, },
-	[MCP463x_104] = { .wipers = 2, .max_pos = 128, .kohms = 100, },
-	[MCP464x_502] = { .wipers = 2, .max_pos = 128, .kohms =   5, },
-	[MCP464x_103] = { .wipers = 2, .max_pos = 128, .kohms =  10, },
-	[MCP464x_503] = { .wipers = 2, .max_pos = 128, .kohms =  50, },
-	[MCP464x_104] = { .wipers = 2, .max_pos = 128, .kohms = 100, },
-	[MCP465x_502] = { .wipers = 2, .max_pos = 256, .kohms =   5, },
-	[MCP465x_103] = { .wipers = 2, .max_pos = 256, .kohms =  10, },
-	[MCP465x_503] = { .wipers = 2, .max_pos = 256, .kohms =  50, },
-	[MCP465x_104] = { .wipers = 2, .max_pos = 256, .kohms = 100, },
-	[MCP466x_502] = { .wipers = 2, .max_pos = 256, .kohms =   5, },
-	[MCP466x_103] = { .wipers = 2, .max_pos = 256, .kohms =  10, },
-	[MCP466x_503] = { .wipers = 2, .max_pos = 256, .kohms =  50, },
-	[MCP466x_104] = { .wipers = 2, .max_pos = 256, .kohms = 100, },
+	[MCP453x_502] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms =   5, },
+	[MCP453x_103] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms =  10, },
+	[MCP453x_503] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms =  50, },
+	[MCP453x_104] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms = 100, },
+	[MCP454x_502] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms =   5, },
+	[MCP454x_103] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms =  10, },
+	[MCP454x_503] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms =  50, },
+	[MCP454x_104] = { .wipers = 1, .avail = { 0, 1, 128 }, .kohms = 100, },
+	[MCP455x_502] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms =   5, },
+	[MCP455x_103] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms =  10, },
+	[MCP455x_503] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms =  50, },
+	[MCP455x_104] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms = 100, },
+	[MCP456x_502] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms =   5, },
+	[MCP456x_103] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms =  10, },
+	[MCP456x_503] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms =  50, },
+	[MCP456x_104] = { .wipers = 1, .avail = { 0, 1, 256 }, .kohms = 100, },
+	[MCP463x_502] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms =   5, },
+	[MCP463x_103] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms =  10, },
+	[MCP463x_503] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms =  50, },
+	[MCP463x_104] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms = 100, },
+	[MCP464x_502] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms =   5, },
+	[MCP464x_103] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms =  10, },
+	[MCP464x_503] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms =  50, },
+	[MCP464x_104] = { .wipers = 2, .avail = { 0, 1, 128 }, .kohms = 100, },
+	[MCP465x_502] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms =   5, },
+	[MCP465x_103] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms =  10, },
+	[MCP465x_503] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms =  50, },
+	[MCP465x_104] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms = 100, },
+	[MCP466x_502] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms =   5, },
+	[MCP466x_103] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms =  10, },
+	[MCP466x_503] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms =  50, },
+	[MCP466x_104] = { .wipers = 2, .avail = { 0, 1, 256 }, .kohms = 100, },
 };
 
 #define MCP4531_WRITE (0 << 2)
@@ -124,13 +124,14 @@ struct mcp4531_data {
 	const struct mcp4531_cfg *cfg;
 };
 
-#define MCP4531_CHANNEL(ch) {					\
-	.type = IIO_RESISTANCE,					\
-	.indexed = 1,						\
-	.output = 1,						\
-	.channel = (ch),					\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
+#define MCP4531_CHANNEL(ch) {						\
+	.type = IIO_RESISTANCE,						\
+	.indexed = 1,							\
+	.output = 1,							\
+	.channel = (ch),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
+	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),	\
 }
 
 static const struct iio_chan_spec mcp4531_channels[] = {
@@ -156,13 +157,31 @@ static int mcp4531_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = data->cfg->max_pos;
+		*val2 = data->cfg->avail[2];
 		return IIO_VAL_FRACTIONAL;
 	}
 
 	return -EINVAL;
 }
 
+static int mcp4531_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct mcp4531_data *data = iio_priv(indio_dev);
+
+	switch (mask) {
+	case IIO_CHAN_INFO_RAW:
+		*length = ARRAY_SIZE(data->cfg->avail);
+		*vals = data->cfg->avail;
+		*type = IIO_VAL_INT;
+		return IIO_AVAIL_RANGE;
+	}
+
+	return -EINVAL;
+}
+
 static int mcp4531_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
@@ -172,7 +191,7 @@ static int mcp4531_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
-		if (val > data->cfg->max_pos || val < 0)
+		if (val > data->cfg->avail[2] || val < 0)
 			return -EINVAL;
 		break;
 	default:
@@ -186,6 +205,7 @@ static int mcp4531_write_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info mcp4531_info = {
 	.read_raw = mcp4531_read_raw,
+	.read_avail = mcp4531_read_avail,
 	.write_raw = mcp4531_write_raw,
 	.driver_module = THIS_MODULE,
 };
-- 
2.1.4

