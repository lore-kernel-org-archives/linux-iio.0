Return-Path: <peda@axentia.se>
From: Peter Rosin <peda@axentia.se>
To: <linux-kernel@vger.kernel.org>
CC: Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>,
	"Peter Meerwald-Stadler" <pmeerw@pmeerw.net>, Rob Herring
	<robh+dt@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
	<linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v2 2/7] iio: mcp4531: provide range of available raw values
Date: Sun, 23 Oct 2016 00:43:41 +0200
Message-ID: <1477176226-10566-3-git-send-email-peda@axentia.se>
In-Reply-To: <1477176226-10566-1-git-send-email-peda@axentia.se>
References: <1477176226-10566-1-git-send-email-peda@axentia.se>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-iio@vger.kernel.org>

Signed-off-by: Peter Rosin <peda@axentia.se>
---
 drivers/iio/potentiometer/mcp4531.c | 104 +++++++++++++++++++++---------------
 1 file changed, 62 insertions(+), 42 deletions(-)

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
