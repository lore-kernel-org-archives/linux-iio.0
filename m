Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from 132.79-246-81.adsl-static.isp.belgacom.be ([81.246.79.132]:35234
	"EHLO viper.mind.be" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752997AbbBYPzt (ORCPT
	<rfc822;linux-iio@vger.kernel.org>); Wed, 25 Feb 2015 10:55:49 -0500
From: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>
To: linux-iio@vger.kernel.org, Peter Meerwald <pmeerw@pmeerw.net>
Cc: =?UTF-8?q?Vianney=20le=20Cl=C3=A9ment=20de=20Saint-Marcq?=
	<vianney.leclement@essensium.com>,
	"Arnout Vandecappelle (Essensium/Mind)" <arnout@mind.be>
Subject: [PATCH 7/7] iio: mlx90614: Provide raw IR value for object channels
Date: Wed, 25 Feb 2015 16:55:12 +0100
Message-Id: <1424879712-28304-8-git-send-email-vianney.leclement@essensium.com>
In-Reply-To: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
References: <1424879712-28304-1-git-send-email-vianney.leclement@essensium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The unit and interpretation of the raw IR value is unspecified.

Signed-off-by: Vianney le Clément de Saint-Marcq <vianney.leclement@essensium.com>
Cc: Arnout Vandecappelle (Essensium/Mind) <arnout@mind.be>

---

This patch is a RFC.  The raw IR value could be used to implement custom
signal processing in userspace if sampled at a high enough rate.  Not
sure whether it is relevant for mainline though.
---
 drivers/iio/temperature/mlx90614.c | 40 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/iio/temperature/mlx90614.c b/drivers/iio/temperature/mlx90614.c
index 49c517a..b3771c5 100644
--- a/drivers/iio/temperature/mlx90614.c
+++ b/drivers/iio/temperature/mlx90614.c
@@ -214,6 +214,36 @@ static int mlx90614_read_raw(struct iio_dev *indio_dev,
 	}
 }
 
+static ssize_t mlx90614_read_raw_ir(struct iio_dev *indio_dev,
+				    uintptr_t priv,
+				    struct iio_chan_spec const *channel,
+				    char *buf)
+{
+	struct mlx90614_data *data = iio_priv(indio_dev);
+	u8 cmd;
+	s32 ret;
+
+	switch (channel->channel) {
+	case 0:
+		cmd = MLX90614_RAW1;
+		break;
+	case 1:
+		cmd = MLX90614_RAW2;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	mlx90614_power_get(data, true);
+	ret = i2c_smbus_read_word_data(data->client, cmd);
+	mlx90614_power_put(data);
+
+	if (ret < 0)
+		return ret;
+
+	return scnprintf(buf, PAGE_SIZE, "0x%04x\n", ret);
+}
+
 static ssize_t mlx90614_show_emissivity(struct device *dev,
 					struct device_attribute *devattr,
 					char *buf)
@@ -318,6 +348,14 @@ out:
 	return count;
 }
 
+static const struct iio_chan_spec_ext_info mlx90614_channel_obj_ext[] = {
+	{
+		.name = "raw_ir",
+		.read = mlx90614_read_raw_ir,
+	},
+	{ }
+};
+
 static const struct iio_chan_spec mlx90614_channels[] = {
 	{
 		.type = IIO_TEMP,
@@ -336,6 +374,7 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		    BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
+		.ext_info = mlx90614_channel_obj_ext,
 	},
 	{
 		.type = IIO_TEMP,
@@ -358,6 +397,7 @@ static const struct iio_chan_spec mlx90614_channels[] = {
 		    BIT(IIO_CHAN_INFO_PROCESSED),
 		.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_OFFSET) |
 		    BIT(IIO_CHAN_INFO_SCALE),
+		.ext_info = mlx90614_channel_obj_ext,
 	},
 };
 
-- 
2.3.0

