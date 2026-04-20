Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BED9395261;
	Mon, 20 Apr 2026 10:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776679996; cv=none; b=fETEVa0DrKTwLs/vmWtzWMnjGGNKmqz6uSe2kD/VFNojJXhJSjcZuhjGo9KPVyg81cXGQG/Xh4axw09SFAFrKxMLN8e1b/MMYKzkDincppvjQvKfi+D4TXWA8iKm2tSIxr+aDlz8i9KqUoSsEXRkzXoJ1uVfwyxrsWAxpDMR3zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776679996; c=relaxed/simple;
	bh=/4Y9pzx7oYTQwQAmIxokFFfTssf0T7vORfnBYNtCr0g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2AbKjyIw5nFBOS4xXU8BjSSy0d6n63uhKkv6iiJx4DceWh4R/4NeSxVeaBlpnlkv/pXz/t9dWQPFL9J5Kme2hitHsKmh8ZuLPh4mvZMpUdnuOc3mSdMjewIxJQeTOfVhrKVB7nNcu8ceZGBy5COnlD56qkwHJa1Zqazu47DI1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nZVS2f34; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nZVS2f34"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63K5jS443102985;
	Mon, 20 Apr 2026 06:12:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sc0MV
	yCKVNwguSKcqwo+nYuh5AVwgLhjxW0346eYdI0=; b=nZVS2f34Nm3z5lrReG8/1
	H5A6SV3rmRN0YsvY+KbvwnEP9aIWL99OVBtExXP2Akw+PiqVELWmy/LvJZaqTtwn
	Q1h0wwFM3+XJsrM+OQhV1G6OV0Uk/s+fTrA8NhldwJaXkjauBa12MEVPb4DRl750
	MEY1Zi8IJ1sDmkSYssYK4YcoWKLQWog2mpjGHwEHgshWJFCO9UgHX7oEy21mgb0p
	dcVjRY7qdBwC32Be2LqI9s4Zfw8oCDk0LUdV8l6KoQb9tEEmq7ViqYWSKPoas6Jj
	6aVkv27rc2X/+qV6YyMd6OEONH00t3U3gkRc8r7VGeeh3a1wKW/R7/EVY1iakVek
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4dm6v1da97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 06:12:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 63KACrSu007722
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 20 Apr 2026 06:12:53 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Apr 2026 06:12:53 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 20 Apr 2026 06:12:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 20 Apr 2026 06:12:53 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.213])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 63KACUKQ006189;
	Mon, 20 Apr 2026 06:12:45 -0400
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Rob Herring
	<robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v9 3/3] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Mon, 20 Apr 2026 13:12:25 +0300
Message-ID: <20260420101225.4173-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260420101225.4173-1-antoniu.miclaus@analog.com>
References: <20260420101225.4173-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDA5OSBTYWx0ZWRfX5j1zUuFYBtTu
 ch3HNnSzYBruzqt0wwSBSov3Q3KoRy2VPkxeikAEGTvL8Lr99h7wOO/mMqSTIUXyozQKL2YTCg9
 2uhmjFzAN5/oI2uTkD7vnHfAr4XYHg+7KXE0xig88z+/9HLeWMm/fDEopOBpOvU2k+kRXQpReXu
 6tvIF6L7Gd06UJZJcNsuQ14RyR8fPKjb9yrNO8NoDuZnOzjRad1tBgsCx9EYwC89fyI+btlUIp8
 Cbsh6BxxANmYGHHOZT6F/NWIP+vwbO+8+LfMLu8Y0ysHGYHfQUzKCqeARYKDU0OBAnWQ9sHtxTS
 bfIRsE5Tt2BQ/1l2y7qHgAt7uivET0zivwX2ou5DCwFm4km88xNgFrVWohuoqw5cy6DaaTFM5Nv
 PekZNXpD1p2Bg2kldIi5b6jnOVIHEjTsixGMKziQYxjhiKTCicjL+0V6vlmy7W+eplfho3IBvP4
 dXb2Ui+bxzqyI+afcvg==
X-Authority-Analysis: v=2.4 cv=Oo1/DS/t c=1 sm=1 tr=0 ts=69e5fc26 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=tTZA3VM7F9AdKBy-ZqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: LfaLtC1iUgCeOJpAYcFWR3qQ0ffOaV_w
X-Proofpoint-GUID: LfaLtC1iUgCeOJpAYcFWR3qQ0ffOaV_w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 spamscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200099

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. The driver uses spi_new_ancillary_device() to
create an additional SPI device for the second channel, allowing both
channels to share the same SPI bus with different chip selects.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
Changes in v9:
  - No changes

 drivers/iio/adc/ad4080.c | 257 +++++++++++++++++++++++++++++----------
 1 file changed, 195 insertions(+), 62 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 204ad198342b..265d85ac171a 100644
--- a/drivers/iio/adc/ad4080.c
+++ b/drivers/iio/adc/ad4080.c
@@ -16,6 +16,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
@@ -134,6 +135,9 @@
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
 #define AD4088_CHIP_ID						0x0058
+#define AD4880_CHIP_ID						0x0750
+
+#define AD4080_MAX_CHANNELS					2
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -179,8 +183,9 @@ struct ad4080_chip_info {
 };
 
 struct ad4080_state {
-	struct regmap			*regmap;
-	struct iio_backend		*back;
+	struct spi_device		*spi[AD4080_MAX_CHANNELS];
+	struct regmap			*regmap[AD4080_MAX_CHANNELS];
+	struct iio_backend		*back[AD4080_MAX_CHANNELS];
 	const struct ad4080_chip_info	*info;
 	/*
 	 * Synchronize access to members the of driver state, and ensure
@@ -189,7 +194,7 @@ struct ad4080_state {
 	struct mutex			lock;
 	unsigned int			num_lanes;
 	unsigned long			clk_rate;
-	enum ad4080_filter_type		filter_type;
+	enum ad4080_filter_type		filter_type[AD4080_MAX_CHANNELS];
 	bool				lvds_cnv_en;
 };
 
@@ -206,9 +211,9 @@ static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	struct ad4080_state *st = iio_priv(indio_dev);
 
 	if (readval)
-		return regmap_read(st->regmap, reg, readval);
+		return regmap_read(st->regmap[0], reg, readval);
 
-	return regmap_write(st->regmap, reg, writeval);
+	return regmap_write(st->regmap[0], reg, writeval);
 }
 
 static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
@@ -229,8 +234,9 @@ static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
 	struct ad4080_state *st = iio_priv(dev);
 	int ret;
 	unsigned int data;
+	unsigned int ch = chan->channel;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -242,13 +248,14 @@ static int ad4080_set_dec_rate(struct iio_dev *dev,
 			       unsigned int mode)
 {
 	struct ad4080_state *st = iio_priv(dev);
+	unsigned int ch = chan->channel;
 
 	guard(mutex)(&st->lock);
 
-	if ((st->filter_type >= SINC_5 && mode >= 512) || mode < 2)
+	if ((st->filter_type[ch] >= SINC_5 && mode >= 512) || mode < 2)
 		return -EINVAL;
 
-	return regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
+	return regmap_update_bits(st->regmap[ch], AD4080_REG_FILTER_CONFIG,
 				  AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
 				  FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
 					     (ilog2(mode) - 1)));
@@ -268,15 +275,15 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
 		dec_rate = ad4080_get_dec_rate(indio_dev, chan);
 		if (dec_rate < 0)
 			return dec_rate;
-		if (st->filter_type == SINC_5_COMP)
+		if (st->filter_type[chan->channel] == SINC_5_COMP)
 			dec_rate *= 2;
-		if (st->filter_type)
+		if (st->filter_type[chan->channel])
 			*val = DIV_ROUND_CLOSEST(st->clk_rate, dec_rate);
 		else
 			*val = st->clk_rate;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE) {
+		if (st->filter_type[chan->channel] == FILTER_NONE) {
 			*val = 1;
 		} else {
 			*val = ad4080_get_dec_rate(indio_dev, chan);
@@ -297,7 +304,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE && val > 1)
+		if (st->filter_type[chan->channel] == FILTER_NONE && val > 1)
 			return -EINVAL;
 
 		return ad4080_set_dec_rate(indio_dev, chan, val);
@@ -306,23 +313,23 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
 	}
 }
 
-static int ad4080_lvds_sync_write(struct ad4080_state *st)
+static int ad4080_lvds_sync_write(struct ad4080_state *st, unsigned int ch)
 {
-	struct device *dev = regmap_get_device(st->regmap);
+	struct device *dev = regmap_get_device(st->regmap[ch]);
 	int ret;
 
-	ret = regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+	ret = regmap_set_bits(st->regmap[ch], AD4080_REG_ADC_DATA_INTF_CONFIG_A,
 			      AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
 	if (ret)
 		return ret;
 
-	ret = iio_backend_interface_data_align(st->back, 10000);
+	ret = iio_backend_interface_data_align(st->back[ch], 10000);
 	if (ret)
 		return dev_err_probe(dev, ret,
 				     "Data alignment process failed\n");
 
 	dev_dbg(dev, "Success: Pattern correct and Locked!\n");
-	return regmap_clear_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+	return regmap_clear_bits(st->regmap[ch], AD4080_REG_ADC_DATA_INTF_CONFIG_A,
 				 AD4080_ADC_DATA_INTF_CONFIG_A_INTF_CHK_EN);
 }
 
@@ -331,9 +338,10 @@ static int ad4080_get_filter_type(struct iio_dev *dev,
 {
 	struct ad4080_state *st = iio_priv(dev);
 	unsigned int data;
+	unsigned int ch = chan->channel;
 	int ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -345,6 +353,7 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
 				  unsigned int mode)
 {
 	struct ad4080_state *st = iio_priv(dev);
+	unsigned int ch = chan->channel;
 	int dec_rate;
 	int ret;
 
@@ -357,18 +366,18 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
 	if (mode >= SINC_5 && dec_rate >= 512)
 		return -EINVAL;
 
-	ret = iio_backend_filter_type_set(st->back, mode);
+	ret = iio_backend_filter_type_set(st->back[ch], mode);
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
+	ret = regmap_update_bits(st->regmap[ch], AD4080_REG_FILTER_CONFIG,
 				 AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
 				 FIELD_PREP(AD4080_FILTER_CONFIG_FILTER_SEL_MSK,
 					    mode));
 	if (ret)
 		return ret;
 
-	st->filter_type = mode;
+	st->filter_type[ch] = mode;
 
 	return 0;
 }
@@ -382,14 +391,14 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		switch (st->filter_type) {
+		switch (st->filter_type[chan->channel]) {
 		case FILTER_NONE:
 			*vals = ad4080_dec_rate_none;
 			*length = ARRAY_SIZE(ad4080_dec_rate_none);
 			break;
 		default:
 			*vals = ad4080_dec_rate_avail;
-			*length = st->filter_type >= SINC_5 ?
+			*length = st->filter_type[chan->channel] >= SINC_5 ?
 				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
 				  ARRAY_SIZE(ad4080_dec_rate_avail);
 			break;
@@ -401,6 +410,28 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4880_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	int ret;
+
+	for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {
+		/*
+		 * Each backend has a single channel (channel 0 from the
+		 * backend's perspective), so always use channel index 0.
+		 */
+		if (test_bit(ch, scan_mask))
+			ret = iio_backend_chan_enable(st->back[ch], 0);
+		else
+			ret = iio_backend_chan_disable(st->back[ch], 0);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 static const struct iio_info ad4080_iio_info = {
 	.debugfs_reg_access = ad4080_reg_access,
 	.read_raw = ad4080_read_raw,
@@ -408,6 +439,19 @@ static const struct iio_info ad4080_iio_info = {
 	.read_avail = ad4080_read_avail,
 };
 
+/*
+ * AD4880 needs update_scan_mode to enable/disable individual backend channels.
+ * Single-channel devices don't need this as their backends may not implement
+ * chan_enable/chan_disable operations.
+ */
+static const struct iio_info ad4880_iio_info = {
+	.debugfs_reg_access = ad4080_reg_access,
+	.read_raw = ad4080_read_raw,
+	.write_raw = ad4080_write_raw,
+	.read_avail = ad4080_read_avail,
+	.update_scan_mode = ad4880_update_scan_mode,
+};
+
 static const struct iio_enum ad4080_filter_type_enum = {
 	.items = ad4080_filter_type_iio_enum,
 	.num_items = ARRAY_SIZE(ad4080_filter_type_iio_enum),
@@ -422,17 +466,28 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 	{ }
 };
 
-#define AD4080_CHANNEL_DEFINE(bits, storage) {				\
+/*
+ * AD4880 needs per-channel filter configuration since each channel has
+ * its own independent ADC with separate SPI interface.
+ */
+static struct iio_chan_spec_ext_info ad4880_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4080_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
+			   &ad4080_filter_type_enum),
+	{ }
+};
+
+#define AD4080_CHANNEL_DEFINE(bits, storage, idx) {			\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
-	.channel = 0,							\
+	.channel = (idx),						\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),			\
 	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.info_mask_shared_by_all_available =				\
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.ext_info = ad4080_ext_info,					\
-	.scan_index = 0,						\
+	.scan_index = (idx),						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = (bits),					\
@@ -440,23 +495,51 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 	},								\
 }
 
-static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
+/*
+ * AD4880 has per-channel attributes (filter_type, oversampling_ratio,
+ * sampling_frequency) since each channel has its own independent ADC
+ * with separate SPI configuration interface.
+ */
+#define AD4880_CHANNEL_DEFINE(bits, storage, idx) {		\
+	.type = IIO_VOLTAGE,						\
+	.indexed = 1,							\
+	.channel = (idx),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.info_mask_separate_available =					\
+			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
+	.ext_info = ad4880_ext_info,				\
+	.scan_index = (idx),						\
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = (bits),					\
+		.storagebits = (storage),				\
+	},								\
+}
 
-static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
+static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4082_channel = AD4080_CHANNEL_DEFINE(20, 32);
+static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4082_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4085_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4085_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
 
-static const struct iio_chan_spec ad4088_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
+
+static const struct iio_chan_spec ad4088_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
+
+static const struct iio_chan_spec ad4880_channels[] = {
+	AD4880_CHANNEL_DEFINE(20, 32, 0),
+	AD4880_CHANNEL_DEFINE(20, 32, 1),
+};
 
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
@@ -548,25 +631,34 @@ static const struct ad4080_chip_info ad4088_chip_info = {
 	.lvds_cnv_clk_cnt_max = 8,
 };
 
-static int ad4080_setup(struct iio_dev *indio_dev)
+static const struct ad4080_chip_info ad4880_chip_info = {
+	.name = "ad4880",
+	.product_id = AD4880_CHIP_ID,
+	.scale_table = ad4080_scale_table,
+	.num_scales = ARRAY_SIZE(ad4080_scale_table),
+	.num_channels = 2,
+	.channels = ad4880_channels,
+	.lvds_cnv_clk_cnt_max = AD4080_LVDS_CNV_CLK_CNT_MAX,
+};
+
+static int ad4080_setup_channel(struct ad4080_state *st, unsigned int ch)
 {
-	struct ad4080_state *st = iio_priv(indio_dev);
-	struct device *dev = regmap_get_device(st->regmap);
+	struct device *dev = regmap_get_device(st->regmap[ch]);
 	__le16 id_le;
 	u16 id;
 	int ret;
 
-	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
+	ret = regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
 			   AD4080_INTERFACE_CONFIG_A_SW_RESET);
 	if (ret)
 		return ret;
 
-	ret = regmap_write(st->regmap, AD4080_REG_INTERFACE_CONFIG_A,
+	ret = regmap_write(st->regmap[ch], AD4080_REG_INTERFACE_CONFIG_A,
 			   AD4080_INTERFACE_CONFIG_A_SDO_ENABLE);
 	if (ret)
 		return ret;
 
-	ret = regmap_bulk_read(st->regmap, AD4080_REG_PRODUCT_ID_L, &id_le,
+	ret = regmap_bulk_read(st->regmap[ch], AD4080_REG_PRODUCT_ID_L, &id_le,
 			       sizeof(id_le));
 	if (ret)
 		return ret;
@@ -575,18 +667,18 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 	if (id != st->info->product_id)
 		dev_info(dev, "Unrecognized CHIP_ID 0x%X\n", id);
 
-	ret = regmap_set_bits(st->regmap, AD4080_REG_GPIO_CONFIG_A,
+	ret = regmap_set_bits(st->regmap[ch], AD4080_REG_GPIO_CONFIG_A,
 			      AD4080_GPIO_CONFIG_A_GPO_1_EN);
 	if (ret)
 		return ret;
 
-	ret = regmap_write(st->regmap, AD4080_REG_GPIO_CONFIG_B,
+	ret = regmap_write(st->regmap[ch], AD4080_REG_GPIO_CONFIG_B,
 			   FIELD_PREP(AD4080_GPIO_CONFIG_B_GPIO_1_SEL_MSK,
 				      AD4080_GPIO_CONFIG_B_GPIO_FILTER_RES_RDY));
 	if (ret)
 		return ret;
 
-	ret = iio_backend_num_lanes_set(st->back, st->num_lanes);
+	ret = iio_backend_num_lanes_set(st->back[ch], st->num_lanes);
 	if (ret)
 		return ret;
 
@@ -594,7 +686,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return 0;
 
 	/* Set maximum LVDS Data Transfer Latency */
-	ret = regmap_update_bits(st->regmap,
+	ret = regmap_update_bits(st->regmap[ch],
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
@@ -603,24 +695,38 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return ret;
 
 	if (st->num_lanes > 1) {
-		ret = regmap_set_bits(st->regmap, AD4080_REG_ADC_DATA_INTF_CONFIG_A,
+		ret = regmap_set_bits(st->regmap[ch], AD4080_REG_ADC_DATA_INTF_CONFIG_A,
 				      AD4080_ADC_DATA_INTF_CONFIG_A_SPI_LVDS_LANES);
 		if (ret)
 			return ret;
 	}
 
-	ret = regmap_set_bits(st->regmap,
+	ret = regmap_set_bits(st->regmap[ch],
 			      AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 			      AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_EN);
 	if (ret)
 		return ret;
 
-	return ad4080_lvds_sync_write(st);
+	return ad4080_lvds_sync_write(st, ch);
 }
 
-static int ad4080_properties_parse(struct ad4080_state *st)
+static int ad4080_setup(struct iio_dev *indio_dev)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	int ret;
+
+	for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {
+		ret = ad4080_setup_channel(st, ch);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static int ad4080_properties_parse(struct ad4080_state *st,
+				   struct device *dev)
 {
-	struct device *dev = regmap_get_device(st->regmap);
 
 	st->lvds_cnv_en = device_property_read_bool(dev, "adi,lvds-cnv-enable");
 
@@ -655,14 +761,28 @@ static int ad4080_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret,
 				     "failed to get and enable supplies\n");
 
-	st->regmap = devm_regmap_init_spi(spi, &ad4080_regmap_config);
-	if (IS_ERR(st->regmap))
-		return PTR_ERR(st->regmap);
+	/* Setup primary SPI device (channel 0) */
+	st->spi[0] = spi;
+	st->regmap[0] = devm_regmap_init_spi(spi, &ad4080_regmap_config);
+	if (IS_ERR(st->regmap[0]))
+		return PTR_ERR(st->regmap[0]);
 
 	st->info = spi_get_device_match_data(spi);
 	if (!st->info)
 		return -ENODEV;
 
+	/* Setup ancillary SPI devices for additional channels */
+	for (unsigned int ch = 1; ch < st->info->num_channels; ch++) {
+		st->spi[ch] = devm_spi_new_ancillary_device(spi, spi_get_chipselect(spi, ch));
+		if (IS_ERR(st->spi[ch]))
+			return dev_err_probe(dev, PTR_ERR(st->spi[ch]),
+					     "failed to register ancillary device\n");
+
+		st->regmap[ch] = devm_regmap_init_spi(st->spi[ch], &ad4080_regmap_config);
+		if (IS_ERR(st->regmap[ch]))
+			return PTR_ERR(st->regmap[ch]);
+	}
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -670,9 +790,10 @@ static int ad4080_probe(struct spi_device *spi)
 	indio_dev->name = st->info->name;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
-	indio_dev->info = &ad4080_iio_info;
+	indio_dev->info = st->info->num_channels > 1 ?
+			  &ad4880_iio_info : &ad4080_iio_info;
 
-	ret = ad4080_properties_parse(st);
+	ret = ad4080_properties_parse(st, dev);
 	if (ret)
 		return ret;
 
@@ -682,15 +803,25 @@ static int ad4080_probe(struct spi_device *spi)
 
 	st->clk_rate = clk_get_rate(clk);
 
-	st->back = devm_iio_backend_get(dev, NULL);
-	if (IS_ERR(st->back))
-		return PTR_ERR(st->back);
+	/* Get backends for all channels */
+	for (unsigned int ch = 0; ch < st->info->num_channels; ch++) {
+		st->back[ch] = devm_iio_backend_get_by_index(dev, ch);
+		if (IS_ERR(st->back[ch]))
+			return PTR_ERR(st->back[ch]);
 
-	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
-	if (ret)
-		return ret;
+		ret = devm_iio_backend_enable(dev, st->back[ch]);
+		if (ret)
+			return ret;
+	}
 
-	ret = devm_iio_backend_enable(dev, st->back);
+	/*
+	 * Request buffer from the first backend only. For multi-channel
+	 * devices (e.g., AD4880), the FPGA uses two axi_ad408x IP instances
+	 * (one per ADC channel) whose outputs are combined by a packer block
+	 * that interleaves all channel data into a single DMA stream routed
+	 * through the first backend's clock domain.
+	 */
+	ret = devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
 	if (ret)
 		return ret;
 
@@ -711,6 +842,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
 	{ "ad4088", (kernel_ulong_t)&ad4088_chip_info },
+	{ "ad4880", (kernel_ulong_t)&ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -725,6 +857,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
 	{ .compatible = "adi,ad4088", &ad4088_chip_info },
+	{ .compatible = "adi,ad4880", &ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

