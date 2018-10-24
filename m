Return-Path: <SRS0=9Nc3=NE=konsulko.com=matt.ranostay@kernel.org>
From: Matt Ranostay <matt.ranostay@konsulko.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	Matt Ranostay <matt.ranostay@konsulko.com>
Subject: [PATCH 2/2] iio: potentiometer: tpl0102: add IIO_AVAIL_RANGE support
Date: Wed, 24 Oct 2018 11:38:58 +0100
Message-Id: <20181024103858.28201-3-matt.ranostay@konsulko.com>
In-Reply-To: <20181024103858.28201-1-matt.ranostay@konsulko.com>
References: <20181024103858.28201-1-matt.ranostay@konsulko.com>
List-ID: <linux-iio@vger.kernel.org>

Report back the step range of the respective potentiometers that are
possible back to userspace.

Signed-off-by: Matt Ranostay <matt.ranostay@konsulko.com>
---
 drivers/iio/potentiometer/tpl0102.c | 33 +++++++++++++++++++++++------
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/potentiometer/tpl0102.c b/drivers/iio/potentiometer/tpl0102.c
index 8e8adabe672b..d5aedf358fc2 100644
--- a/drivers/iio/potentiometer/tpl0102.c
+++ b/drivers/iio/potentiometer/tpl0102.c
@@ -15,7 +15,7 @@
 
 struct tpl0102_cfg {
 	int wipers;
-	int max_pos;
+	int avail[3];
 	int kohms;
 };
 
@@ -28,11 +28,11 @@ enum tpl0102_type {
 
 static const struct tpl0102_cfg tpl0102_cfg[] = {
 	/* on-semiconductor parts */
-	[CAT5140_503] = { .wipers = 1, .max_pos = 256, .kohms = 50, },
-	[CAT5140_104] = { .wipers = 1, .max_pos = 256, .kohms = 100, },
+	[CAT5140_503] = { .wipers = 1, .avail = { 0, 1, 255 }, .kohms = 50, },
+	[CAT5140_104] = { .wipers = 1, .avail = { 0, 1, 255 }, .kohms = 100, },
 	/* ti parts */
-	[TPL0102_104] = { .wipers = 2, .max_pos = 256, .kohms = 100 },
-	[TPL0401_103] = { .wipers = 1, .max_pos = 128, .kohms = 10, },
+	[TPL0102_104] = { .wipers = 2, .avail = { 0, 1, 255 }, .kohms = 100 },
+	[TPL0401_103] = { .wipers = 1, .avail = { 0, 1, 127 }, .kohms = 10, },
 };
 
 struct tpl0102_data {
@@ -73,13 +73,31 @@ static int tpl0102_read_raw(struct iio_dev *indio_dev,
 	}
 	case IIO_CHAN_INFO_SCALE:
 		*val = 1000 * data->cfg->kohms;
-		*val2 = data->cfg->max_pos;
+		*val2 = data->cfg->avail[2] + 1;
 		return IIO_VAL_FRACTIONAL;
 	}
 
 	return -EINVAL;
 }
 
+static int tpl0102_read_avail(struct iio_dev *indio_dev,
+			      struct iio_chan_spec const *chan,
+			      const int **vals, int *type, int *length,
+			      long mask)
+{
+	struct tpl0102_data *data = iio_priv(indio_dev);
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
 static int tpl0102_write_raw(struct iio_dev *indio_dev,
 			     struct iio_chan_spec const *chan,
 			     int val, int val2, long mask)
@@ -89,7 +107,7 @@ static int tpl0102_write_raw(struct iio_dev *indio_dev,
 	if (mask != IIO_CHAN_INFO_RAW)
 		return -EINVAL;
 
-	if (val >= data->cfg->max_pos || val < 0)
+	if (val > data->cfg->avail[2] || val < 0)
 		return -EINVAL;
 
 	return regmap_write(data->regmap, chan->channel, val);
@@ -97,6 +115,7 @@ static int tpl0102_write_raw(struct iio_dev *indio_dev,
 
 static const struct iio_info tpl0102_info = {
 	.read_raw = tpl0102_read_raw,
+	.read_avail = tpl0102_read_avail,
 	.write_raw = tpl0102_write_raw,
 };
 
-- 
2.17.1
