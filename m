Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:56909 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932601AbdDGMHq (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Fri, 7 Apr 2017 08:07:46 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH v2 4/7] iio: light: rpr0521 proximity offset read/write added
Date: Fri,  7 Apr 2017 15:07:16 +0300
Message-Id: <1491566839-3925-4-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1491566839-3925-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added sysfs read/write proximity offset feature. Offset is read/write from
sensor registers. Values are proximity raw 10-bit values. After applying
offset value, output values will be (measured_raw - offset_value). Output
values are unsigned so offset value doesn't make output negative.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
Builds OK with torvalds/linux 4.9
checkpatch.pl OK.

Patch v1->v2 changes:
read/write_ps_offset() rewritten with:
 -  static, __le16, cpu_to_le16(), sizeof()

 drivers/iio/light/rpr0521.c |   53 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 53 insertions(+)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index e92a8bb..35c759b 100644
--- a/drivers/iio/light/rpr0521.c
+++ b/drivers/iio/light/rpr0521.c
@@ -30,6 +30,9 @@
 #define RPR0521_REG_PXS_DATA		0x44 /* 16-bit, little endian */
 #define RPR0521_REG_ALS_DATA0		0x46 /* 16-bit, little endian */
 #define RPR0521_REG_ALS_DATA1		0x48 /* 16-bit, little endian */
+#define RPR0521_PS_OFFSET_LSB		0x53
+#define RPR0521_PS_OFFSET_MSB		0x54
+
 #define RPR0521_REG_ID			0x92
 
 #define RPR0521_MODE_ALS_MASK		BIT(7)
@@ -215,7 +218,9 @@ static const struct iio_chan_spec rpr0521_channels[] = {
 		.type = IIO_PROXIMITY,
 		.address = RPR0521_CHAN_PXS,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
 			BIT(IIO_CHAN_INFO_SCALE),
+
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}
 };
@@ -402,6 +407,40 @@ static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
 		i);
 }
 
+static int rpr0521_read_ps_offset(struct rpr0521_data *data, int *offset)
+{
+	int ret;
+	__le16 buffer;
+
+	ret = regmap_bulk_read(data->regmap,
+		RPR0521_PS_OFFSET_LSB, &buffer, sizeof(buffer));
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to read PS OFFSET register\n");
+		return ret;
+	}
+	*offset = le16_to_cpu(buffer);
+
+	return ret;
+}
+
+static int rpr0521_write_ps_offset(struct rpr0521_data *data, int offset)
+{
+	int ret;
+	__le16 buffer;
+
+	buffer = cpu_to_le16(offset & 0x3ff);
+	ret = regmap_raw_write(data->regmap,
+		RPR0521_PS_OFFSET_LSB, &buffer, sizeof(buffer));
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to write PS OFFSET register\n");
+		return ret;
+	}
+
+	return ret;
+}
+
 static int rpr0521_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -458,6 +497,14 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
 			return ret;
 		return IIO_VAL_INT_PLUS_MICRO;
 
+	case IIO_CHAN_INFO_OFFSET:
+		mutex_lock(&data->lock);
+		ret = rpr0521_read_ps_offset(data, val);
+		mutex_unlock(&data->lock);
+		if (ret < 0)
+			return ret;
+		return IIO_VAL_INT;
+
 	default:
 		return -EINVAL;
 	}
@@ -485,6 +532,12 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
 		mutex_unlock(&data->lock);
 		return ret;
 
+	case IIO_CHAN_INFO_OFFSET:
+		mutex_lock(&data->lock);
+		ret = rpr0521_write_ps_offset(data, val);
+		mutex_unlock(&data->lock);
+		return ret;
+
 	default:
 		return -EINVAL;
 	}
-- 
1.7.9.5

