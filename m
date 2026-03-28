Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C96637F759;
	Sat, 28 Mar 2026 11:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774698222; cv=none; b=FanjsyXfdMh714dL4y48bVVpChPuBpHQAG4bfLz7hdLcD9LqHkke13ofq2YbSjf/wfMSGawwH3AVGWbzlVQsyM+djhCs8lsqq5+mulhEbpRVRagazIVfyKu7idGbcVsl1bliXHW7YIA/82gMaeZ+3yZsXfx8kJjKh2wWIA8YrZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774698222; c=relaxed/simple;
	bh=SYtIOfPkN69PwbA3y5+8Gcoc8CaWIH5IvswXoujdxoQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=D3/Nyx3Tqo+o75zk6RJMKfu+dFo0rvGjEDN8b/hnkvQRM1JWNttc6xcJI3wJwAK3qAuqrmYRvab6wFCQLgWWaTqI9RxoSPx1+MfLQvaobY60QzhzuQ6XXlk6uaPqVGdwVJR3au2rsnGbhq0PYLLQJKUZB5REAJDDz/4PHzAGfdc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=qpCC0Uri; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="qpCC0Uri"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62S6BTfZ2019071;
	Sat, 28 Mar 2026 07:43:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=BbgQB
	qOnenZWMMwuXhw3joAKx9qVFkQCKKzyftgekZ0=; b=qpCC0Urib+w4Pr3pzTLhM
	isGVIrXhX0BNBowL3EQCGAJtPXk8tex5d7vRJ5yuTU841b68FbeuOGwYems1zS3U
	dDWz7UK1IoniTcBxuB/1+p871vy24UCHJpVTYBWXACadUWjjiaR/jb8mGtClggpc
	K+IPpKkoRperIHOuepwL6wBAV5NhzAQPuqlR5ciicL/fLZOLy6164hMleI7tBdBF
	4WouZgB4kDSVthhYwXBkmvQPeb017S/X7UJrlEL2Jn/i8v8H3Rfjzd0N+1gkZjRB
	zVeVFYPsJa2hcHWWHrWeRgMJqviaDOldJ1P7FGUvcD6bG8/r1OD4V5L+AwROd6Xz
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d4gyh5bmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 28 Mar 2026 07:43:16 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62SBhFOX037557
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sat, 28 Mar 2026 07:43:15 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Sat, 28 Mar
 2026 07:43:15 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Sat, 28 Mar 2026 07:43:14 -0400
Received: from HYB-b1tGeUj4GP1.ad.analog.com ([10.32.226.156])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62SBgofx013745;
	Sat, 28 Mar 2026 07:43:09 -0400
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
Subject: [PATCH v8 3/3] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Sat, 28 Mar 2026 13:40:50 +0200
Message-ID: <20260328114050.46848-4-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260328114050.46848-1-antoniu.miclaus@analog.com>
References: <20260328114050.46848-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI4MDA4NSBTYWx0ZWRfXwDSOb0UXobwX
 yeksHWdIre9sz3Mw5RXjJNS4ZmnjwisVCBxLhNwsitBLhSSTK3+Ils4t+vlM+Z5Uka1hgRUwNxW
 BO2ofXjtiPvrLvmZ47+qX5+e/zbyn8ahvrlUv9dly9cGX0ndma/mTRqC/iQU21Oag0XoEmfTzZX
 LjGRFzCPSHLVRLv7CzSSjcv1FQPrilsVcn/5rS020kfYhXTHk5JNvt4TrTD2sA7ylKIggE8kVwR
 UCAhs57OzOrbHKbJw5fTdtYqGz9bOyNTzRVlCCM4c8dhpl9N4y15ZE2I1r8kpm15s0an2efsdDL
 pvGWKpc+8e+pkE/ZZbIejgRjorEWJWDv4y/pfiqBleeskKhHhd6oc7zkXQkThYYK5zBMq0pLVMH
 vf1NoC57z/MjmIelTLVNENlz4Y1M4n7eYfCOmGhUvuXquYdmqh2FbNy6bDuvdXHcgay3LfPvjke
 Ya8vVUk04KKfeijqiBQ==
X-Authority-Analysis: v=2.4 cv=ZsTg6t7G c=1 sm=1 tr=0 ts=69c7bed4 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=tTZA3VM7F9AdKBy-ZqoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: S8CDtKC49AFkHSBhrXBVOzwGcbfDZOcX
X-Proofpoint-GUID: S8CDtKC49AFkHSBhrXBVOzwGcbfDZOcX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-27_02,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603280085

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
Changes in v8:
  - Clarify backend buffer comment to describe FPGA architecture
    (two axi_ad408x IP instances with a packer block)
  - Make filter_type a per-channel array instead of a single variable
  - Restore debugfs_reg_access for AD4880 (uses channel 0 regmap),
    based on sashiko's review

 drivers/iio/adc/ad4080.c | 251 ++++++++++++++++++++++++++++++---------
 1 file changed, 192 insertions(+), 59 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cf3b6ed7940..fcd29e94107f 100644
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
@@ -131,6 +132,9 @@
 #define AD4084_CHIP_ID						0x0054
 #define AD4086_CHIP_ID						0x0056
 #define AD4087_CHIP_ID						0x0057
+#define AD4880_CHIP_ID						0x0750
+
+#define AD4080_MAX_CHANNELS					2
 
 #define AD4080_LVDS_CNV_CLK_CNT_MAX				7
 
@@ -176,8 +180,9 @@ struct ad4080_chip_info {
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
@@ -187,7 +192,7 @@ struct ad4080_state {
 	unsigned int			num_lanes;
 	unsigned int			dec_rate;
 	unsigned long			clk_rate;
-	enum ad4080_filter_type		filter_type;
+	enum ad4080_filter_type		filter_type[AD4080_MAX_CHANNELS];
 	bool				lvds_cnv_en;
 };
 
@@ -204,9 +209,9 @@ static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 	struct ad4080_state *st = iio_priv(indio_dev);
 
 	if (readval)
-		return regmap_read(st->regmap, reg, readval);
+		return regmap_read(st->regmap[0], reg, readval);
 
-	return regmap_write(st->regmap, reg, writeval);
+	return regmap_write(st->regmap[0], reg, writeval);
 }
 
 static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
@@ -227,8 +232,9 @@ static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
 	struct ad4080_state *st = iio_priv(dev);
 	int ret;
 	unsigned int data;
+	unsigned int ch = chan->channel;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -240,13 +246,14 @@ static int ad4080_set_dec_rate(struct iio_dev *dev,
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
@@ -266,15 +273,15 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
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
@@ -295,7 +302,7 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE && val > 1)
+		if (st->filter_type[chan->channel] == FILTER_NONE && val > 1)
 			return -EINVAL;
 
 		return ad4080_set_dec_rate(indio_dev, chan, val);
@@ -304,23 +311,23 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
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
 
@@ -329,9 +336,10 @@ static int ad4080_get_filter_type(struct iio_dev *dev,
 {
 	struct ad4080_state *st = iio_priv(dev);
 	unsigned int data;
+	unsigned int ch = chan->channel;
 	int ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -343,6 +351,7 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
 				  unsigned int mode)
 {
 	struct ad4080_state *st = iio_priv(dev);
+	unsigned int ch = chan->channel;
 	int dec_rate;
 	int ret;
 
@@ -355,18 +364,18 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
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
@@ -380,14 +389,14 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
 
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
@@ -399,6 +408,28 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
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
@@ -406,6 +437,19 @@ static const struct iio_info ad4080_iio_info = {
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
@@ -420,17 +464,28 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
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
@@ -438,17 +493,45 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
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
 
-static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
+
+static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
+
+static const struct iio_chan_spec ad4880_channels[] = {
+	AD4880_CHANNEL_DEFINE(20, 32, 0),
+	AD4880_CHANNEL_DEFINE(20, 32, 1),
+};
 
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
@@ -510,25 +593,34 @@ static const struct ad4080_chip_info ad4087_chip_info = {
 	.lvds_cnv_clk_cnt_max = 1,
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
@@ -537,18 +629,18 @@ static int ad4080_setup(struct iio_dev *indio_dev)
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
 
@@ -556,7 +648,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return 0;
 
 	/* Set maximum LVDS Data Transfer Latency */
-	ret = regmap_update_bits(st->regmap,
+	ret = regmap_update_bits(st->regmap[ch],
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
@@ -565,24 +657,38 @@ static int ad4080_setup(struct iio_dev *indio_dev)
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
 
@@ -617,14 +723,28 @@ static int ad4080_probe(struct spi_device *spi)
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
@@ -632,9 +752,10 @@ static int ad4080_probe(struct spi_device *spi)
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
 
@@ -644,15 +765,25 @@ static int ad4080_probe(struct spi_device *spi)
 
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
 
@@ -670,6 +801,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
+	{ "ad4880", (kernel_ulong_t)&ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -681,6 +813,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
+	{ .compatible = "adi,ad4880", &ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

