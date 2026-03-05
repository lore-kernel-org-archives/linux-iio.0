Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F0B3914EB;
	Thu,  5 Mar 2026 11:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772710796; cv=none; b=Kro+FoLwqK9qDfXkjUzT3FvgxbuVw0R/C/Y7uqHVBots3F81WLFJXQ8pBTvBqfkTZhPUxSsQ/uRtSsUH8pF4yfv7vyJ127Bxygfkzcnt1WimfrGSomTWsbEWj6/3c+QGgix3haQ9SwucgOKetuFWPcbyrLAQ0tKrat1sfcelnT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772710796; c=relaxed/simple;
	bh=pzVI+lHqoYAMXrhdyOxmNjqokRlTfefIabXmu/2uzPE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a1aZOG2slvCrCv77x0/UE62nYsmZSItq+ALz5uB756VmEfGF7Hf1sVgEabs9FxItNopNyWdDORBXUzCO2UhkaCBqawaDoJ7jXA4ekID6ZAwLC4aQYk8Q6Iqn9qTCj0suQrL4c4R2564C3qIYBj+JTscpWEPIioTclnXKu11ocCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ywotsZSI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ywotsZSI"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6259TIqG2756858;
	Thu, 5 Mar 2026 06:39:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=cYxeP
	EZY4UkmL5/fv1qhEYouRbTBLH5qcPKX1GKqBWc=; b=ywotsZSI008qdVNRr7AWm
	E8aP2tsfXhA1nNnsbum/qRt3SlaZbot8I8NJsVSpPJffQ+lBrNIbUeuxTUWc3LNT
	PYncRVeY8MCyftZptBbc/UdOlmCvu0iDTwUBvXzqln8O4hLHolQNEkYL5W12cMyH
	oZsErqg+scAQFhI0kTZluZnEu+5ZlJGWvtImlYxLRlJKi54Oht/zWu3YI6WG28Iz
	mZBa8rEiKywt5o0szRbqEtyn6QEJ9ehUCBtUdganMlmjeRl3Ckqj8vRkpO5WSEW5
	wMpP9O4vjzELKpdAX5/K3FmXK29x7vhhWGe85fzsuXG2wWXjn5bPkjZjsBpQq7SY
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4cppt6c2v3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Mar 2026 06:39:36 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 625BdZnT058611
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 5 Mar 2026 06:39:35 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 5 Mar
 2026 06:39:35 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 5 Mar 2026 06:39:35 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 625BcrWI005601;
	Thu, 5 Mar 2026 06:39:30 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan
 Cameron <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Olivier Moysan
	<olivier.moysan@foss.st.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 4/4] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Thu, 5 Mar 2026 13:37:30 +0200
Message-ID: <20260305113756.47243-5-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260305113756.47243-1-antoniu.miclaus@analog.com>
References: <20260305113756.47243-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA1MDA5NSBTYWx0ZWRfX/c1HDOXncM0V
 lksCRSiCJVbG8epK6Pao1EqBAZjGmU9bG7qGpBZuxHXRmmoybWKTmNsTC1bGt2LH96Uj3yh+N6O
 CfZl3iK/3lW48WMki0GQ3exfw0DYId6MRMTnk/j7OG3Pt1Xcnoc7Wt/h4n7zKtTESkLfxlfFn55
 HJg7+DqJLuG5AEIcVmYzsYfkVgjinVTkj3Tgd7b+SO1djlgunSBm3/+rMAmgL8bdTHPbSynCjIc
 Yp3nhg7OuBD3mQmGgnBkrN9Fl1qd8sDctER9qcvd0mvaqao5jnj9P7wD5kcCpwH5XqsoG3yDVGo
 d+GOy68a1D7nKxhnH2hHasrrEyh0bIm/yhqaESzNqqoq4oWRNQQHC0KHp+lWagFC+BMxkEVFO1j
 NYqfbE+q4LWJkBR5Jh6fERzYLg8mfVXvG3e88WI9iYxcx63hRcKKTMl/BsZYzMG7xWW2IqFffty
 U12heyd8sjgF3crQXDw==
X-Proofpoint-GUID: sTJdEg_7TCY1RJPt953bk3m7PbW460ae
X-Authority-Analysis: v=2.4 cv=EKkLElZC c=1 sm=1 tr=0 ts=69a96b78 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=IpJZQVW2AAAA:8
 a=gAnH3GRIAAAA:8 a=TkdxIJFci9F1GQXeX6YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=IawgGOuG5U0WyFbmm1f5:22
X-Proofpoint-ORIG-GUID: sTJdEg_7TCY1RJPt953bk3m7PbW460ae
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-05_04,2026-03-04_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603050095

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
Changes in v5:
  - Declare loop variables in for-loop initializers
  - Drop redundant num_channels > 1 guard around ancillary device
    setup loop

 drivers/iio/adc/ad4080.c | 230 +++++++++++++++++++++++++++++++--------
 1 file changed, 182 insertions(+), 48 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cf3b6ed7940..2d5fdfded466 100644
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
@@ -203,10 +208,11 @@ static int ad4080_reg_access(struct iio_dev *indio_dev, unsigned int reg,
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
 
+	/* Use channel 0 regmap for debugfs access */
 	if (readval)
-		return regmap_read(st->regmap, reg, readval);
+		return regmap_read(st->regmap[0], reg, readval);
 
-	return regmap_write(st->regmap, reg, writeval);
+	return regmap_write(st->regmap[0], reg, writeval);
 }
 
 static int ad4080_get_scale(struct ad4080_state *st, int *val, int *val2)
@@ -227,8 +233,9 @@ static unsigned int ad4080_get_dec_rate(struct iio_dev *dev,
 	struct ad4080_state *st = iio_priv(dev);
 	int ret;
 	unsigned int data;
+	unsigned int ch = chan->channel;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -240,13 +247,14 @@ static int ad4080_set_dec_rate(struct iio_dev *dev,
 			       unsigned int mode)
 {
 	struct ad4080_state *st = iio_priv(dev);
+	unsigned int ch = chan->channel;
 
 	guard(mutex)(&st->lock);
 
 	if ((st->filter_type >= SINC_5 && mode >= 512) || mode < 2)
 		return -EINVAL;
 
-	return regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
+	return regmap_update_bits(st->regmap[ch], AD4080_REG_FILTER_CONFIG,
 				  AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
 				  FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
 					     (ilog2(mode) - 1)));
@@ -304,23 +312,23 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
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
 
@@ -329,9 +337,10 @@ static int ad4080_get_filter_type(struct iio_dev *dev,
 {
 	struct ad4080_state *st = iio_priv(dev);
 	unsigned int data;
+	unsigned int ch = chan->channel;
 	int ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -343,6 +352,7 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
 				  unsigned int mode)
 {
 	struct ad4080_state *st = iio_priv(dev);
+	unsigned int ch = chan->channel;
 	int dec_rate;
 	int ret;
 
@@ -355,11 +365,11 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
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
@@ -399,6 +409,28 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
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
@@ -406,6 +438,19 @@ static const struct iio_info ad4080_iio_info = {
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
@@ -420,17 +465,51 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
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
+	.scan_type = {							\
+		.sign = 's',						\
+		.realbits = (bits),					\
+		.storagebits = (storage),				\
+	},								\
+}
+
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
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = (bits),					\
@@ -438,17 +517,22 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 	},								\
 }
 
-static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
+static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
+static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
 
-static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
+
+static const struct iio_chan_spec ad4880_channels[] = {
+	AD4880_CHANNEL_DEFINE(20, 32, 0),
+	AD4880_CHANNEL_DEFINE(20, 32, 1),
+};
 
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
@@ -510,25 +594,34 @@ static const struct ad4080_chip_info ad4087_chip_info = {
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
@@ -537,18 +630,18 @@ static int ad4080_setup(struct iio_dev *indio_dev)
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
 
@@ -556,7 +649,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return 0;
 
 	/* Set maximum LVDS Data Transfer Latency */
-	ret = regmap_update_bits(st->regmap,
+	ret = regmap_update_bits(st->regmap[ch],
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
@@ -565,24 +658,38 @@ static int ad4080_setup(struct iio_dev *indio_dev)
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
+}
+
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
 }
 
 static int ad4080_properties_parse(struct ad4080_state *st)
 {
-	struct device *dev = regmap_get_device(st->regmap);
+	struct device *dev = regmap_get_device(st->regmap[0]);
 
 	st->lvds_cnv_en = device_property_read_bool(dev, "adi,lvds-cnv-enable");
 
@@ -617,14 +724,30 @@ static int ad4080_probe(struct spi_device *spi)
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
+		st->spi[ch] = devm_spi_new_ancillary_device(spi,
+							    spi_get_chipselect(spi, ch));
+		if (IS_ERR(st->spi[ch]))
+			return dev_err_probe(dev, PTR_ERR(st->spi[ch]),
+					     "failed to register ancillary device\n");
+
+		st->regmap[ch] = devm_regmap_init_spi(st->spi[ch],
+						      &ad4080_regmap_config);
+		if (IS_ERR(st->regmap[ch]))
+			return PTR_ERR(st->regmap[ch]);
+	}
+
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
 		return ret;
@@ -632,7 +755,8 @@ static int ad4080_probe(struct spi_device *spi)
 	indio_dev->name = st->info->name;
 	indio_dev->channels = st->info->channels;
 	indio_dev->num_channels = st->info->num_channels;
-	indio_dev->info = &ad4080_iio_info;
+	indio_dev->info = st->info->num_channels > 1 ?
+			  &ad4880_iio_info : &ad4080_iio_info;
 
 	ret = ad4080_properties_parse(st);
 	if (ret)
@@ -644,15 +768,23 @@ static int ad4080_probe(struct spi_device *spi)
 
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
+	 * devices (e.g., AD4880), all backends share a single IIO buffer
+	 * as data from all ADC channels is interleaved into one stream.
+	 */
+	ret = devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
 	if (ret)
 		return ret;
 
@@ -670,6 +802,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
+	{ "ad4880", (kernel_ulong_t)&ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -681,6 +814,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
+	{ .compatible = "adi,ad4880", &ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

