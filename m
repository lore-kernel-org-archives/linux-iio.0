Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mail.kapsi.fi ([217.30.184.167]:35646 "EHLO mail.kapsi.fi"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752954AbdDFGiY (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Thu, 6 Apr 2017 02:38:24 -0400
From: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
To: jic23@kernel.org
Cc: pmeerw@pmeerw.net, knaack.h@gmx.de, lars@metafoo.de,
        linux-iio@vger.kernel.org,
        Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
Subject: [PATCH 4/6] iio: light: rpr0521 proximity offset read/write added
Date: Thu,  6 Apr 2017 09:37:05 +0300
Message-Id: <1491460627-18685-4-git-send-email-mikko.koivunen@fi.rohmeurope.com>
In-Reply-To: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
References: <1491460627-18685-1-git-send-email-mikko.koivunen@fi.rohmeurope.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Added sysfs read/write proximity offset feature. Offset is read/write from
sensor registers. Values are proximity raw 10-bit values. After applying
offset value, output values will be (measured_raw - offset_value). Output
values are unsigned so offset value doesn't make output negative.

Tested on LeMaker HiKey with AOSP7.1 kernel 4.4.
Builds OK with torvalds/linux 4.9
checkpatch.pl OK.

Signed-off-by: Mikko Koivunen <mikko.koivunen@fi.rohmeurope.com>
---
 drivers/iio/light/rpr0521.c | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/drivers/iio/light/rpr0521.c b/drivers/iio/light/rpr0521.c
index 13e2f9a..579bf6d 100644
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
@@ -214,7 +217,9 @@ struct rpr0521_data {
 		.type = IIO_PROXIMITY,
 		.address = RPR0521_CHAN_PXS,
 		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
+			BIT(IIO_CHAN_INFO_OFFSET) |
 			BIT(IIO_CHAN_INFO_SCALE),
+
 		.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ),
 	}
 };
@@ -400,6 +405,42 @@ static int rpr0521_write_samp_freq_common(struct rpr0521_data *data,
 		i);
 }
 
+int rpr0521_read_ps_offset(struct rpr0521_data *data, int *offset)
+{
+	int ret;
+	u8 buffer[2];
+
+	ret = regmap_bulk_read(data->regmap,
+		RPR0521_PS_OFFSET_LSB, &buffer, 2);
+
+	if (ret < 0) {
+		dev_err(&data->client->dev, "Failed to read PS OFFSET register\n");
+		return ret;
+	}
+	*offset = buffer[0] + (buffer[1] << 8);
+
+	return ret;
+}
+
+int rpr0521_write_ps_offset(struct rpr0521_data *data, int offset)
+{
+	int ret;
+	u8 buffer[2];
+
+	buffer[0] = offset & 0xff;
+	buffer[1] = (offset >> 8) & (BIT(0) | BIT(1));
+
+	ret = regmap_raw_write(data->regmap,
+		RPR0521_PS_OFFSET_LSB, &buffer, 2);
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
@@ -456,6 +497,14 @@ static int rpr0521_read_raw(struct iio_dev *indio_dev,
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
@@ -483,6 +532,12 @@ static int rpr0521_write_raw(struct iio_dev *indio_dev,
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
1.9.1

