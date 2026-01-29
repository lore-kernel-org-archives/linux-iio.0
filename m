Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A66B832B9A0;
	Thu, 29 Jan 2026 15:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700489; cv=none; b=CS5JjOdHneMEePAnglKsiYU0h8l4OrDsjIOFyMVsoDd7waKNppukRmFCNCNeDRSP/txzGcBhXBb5m3kwS4xWjj+w7Vup9dk8sEulE+CBV884E82n8vTCUkI8yPsRaLisk8MRaVEyPgzVLa10rqcrnqkp2RnbK7sQO56qTYMs29I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700489; c=relaxed/simple;
	bh=9Q2PDmAWK7okqFpBBIfoLfRndPHUH97jc50thp73IQk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rwYBCjwQwwzQ9OVvMYB6Jx6CxNH/FMZcZxYBKu9qFqEbiOTxT4MEFoed9CYmf1M8XjydepuWASA8tEtQiCb30GGV5IBqf91jZI1y7AIVsCjgL3HpjtJViEkgCeCPfHf/CVLzvd+M5DqMCDsoUvUa0vFL9V4LEcBHx0Il+1uABsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AVvLIrXI; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AVvLIrXI"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60TBkq7X3783249;
	Thu, 29 Jan 2026 10:27:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=FXpvk
	e7eS0H7l3Ec1M2hpKBnE1wbXj9+7NDJ+EeQsyE=; b=AVvLIrXItfN3ah19qpDWl
	FDOgLUeoyoXBUC0GvBOUvlF7EPBR2NeGFCVX0kuINlg7PCQuaRhJwugyTtz1/I4R
	UqisD2vySUUQOuMdr/xQ0707AerOeRLPAI6FcLYoYqKR88G5+wKnCMkXGMG1baNX
	OE8Wr1dnMS9TqGSeluyOXxKogWLv1hHzNkqBfEmo0ig0/Ug9lXWWjLl5LQobJw0c
	G9XGoxOBApA1+0e/UQUyK6PKs0n8pv/IjrEeU6BoEe4Lfbq20JdXfbMTl4vcvScE
	ibbDq8Hog5vWn9DQB32LfkC5s2sq71+yzVxG47G2nl+6tbQQ983JeyCltaBSQd7l
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4c011bj41k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 29 Jan 2026 10:27:52 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 60TFRpN0042249
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 29 Jan 2026 10:27:51 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 10:27:51 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 29 Jan 2026 10:27:50 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 29 Jan 2026 10:27:50 -0500
Received: from HYB-b1tGeUj4GP1.ad.analog.com (HYB-b1tGeUj4GP1.ad.analog.com [10.48.65.247])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 60TFRX1k002992;
	Thu, 29 Jan 2026 10:27:44 -0500
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
To: Antoniu Miclaus <antoniu.miclaus@analog.com>,
        Lars-Peter Clausen
	<lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        "Jonathan Cameron" <jic23@kernel.org>,
        David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] iio: adc: ad4080: add support for AD4880 dual-channel ADC
Date: Thu, 29 Jan 2026 17:27:30 +0200
Message-ID: <20260129152731.154368-3-antoniu.miclaus@analog.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260129152731.154368-1-antoniu.miclaus@analog.com>
References: <20260129152731.154368-1-antoniu.miclaus@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=PvmergM3 c=1 sm=1 tr=0 ts=697b7c78 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gAnH3GRIAAAA:8
 a=1TNaxu5aMze5YuMPDZ4A:9
X-Proofpoint-GUID: kzRqUpgAqpg7tFj65VXJ_vDA-XYBgSah
X-Proofpoint-ORIG-GUID: kzRqUpgAqpg7tFj65VXJ_vDA-XYBgSah
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI5MDEwNyBTYWx0ZWRfXxOIr1xinhObj
 3zP1p+P+gBUtocwTQUYtgOHtpvASwD1K6lsqLA7Tha48416gOrDPNzh3bnRBW1TWhtirQa3duBf
 mxRfRZng+WLypks1yuSZaAOhVZ8k1lFhUrMn1Rulyvqkb4y9oZvtIzwcbmEV7wF+n2MFDDqAhHJ
 avDI9Ah9NRQmzh/FHiX2uAtScVuwyPMGGafeCAfMWpwpir6v6SmqNT6EdULpPyzOXd5SQI8yX6s
 L4EN5IX0+08wIB01tRrri5KYs9jeznej0gxSHxnQOVT3EJJXYF0/x9DTr3zgIZlBUE0JA+xCDtc
 M3v7y1eG88ksVEK2ois4K6dvVILJsIpEgyih3N/oGk7jTY963RlnLpXLPzWwR1BDjlx4JVORpJF
 gfd2slLK8OB56XKh1/S2FZ2LkuuT1zRtGtOBPvVqiKCsKhGvnCS7xmQP7W456Kjzz8UhbR3V2C+
 fHeSbc/ID+pRbX+oj8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-29_02,2026-01-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2601150000 definitions=main-2601290107

Add support for the AD4880, a dual-channel 20-bit 40MSPS SAR ADC with
integrated fully differential amplifiers (FDA).

The AD4880 has two independent ADC channels, each with its own SPI
configuration interface. The driver uses spi_new_ancillary_device() to
create an additional SPI device for the second channel, allowing both
channels to share the same SPI bus with different chip selects.

Key changes:
- Add AD4880 chip info with 2 channels
- Extend state structure to support arrays of regmaps and backends
- Refactor setup into per-channel function
- Add adi,aux-spi-cs property for secondary channel chip select
- Add channel index parameter to channel macro for scan_index support
- Make all IIO attributes per-channel (filter_type, oversampling_ratio,
  sampling_frequency) for independent channel configuration

Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
---
 drivers/iio/adc/ad4080.c | 236 ++++++++++++++++++++++++++++-----------
 1 file changed, 172 insertions(+), 64 deletions(-)

diff --git a/drivers/iio/adc/ad4080.c b/drivers/iio/adc/ad4080.c
index 7cf3b6ed7940..e588ff23a7a5 100644
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
 
-	if ((st->filter_type >= SINC_5 && mode >= 512) || mode < 2)
+	if ((st->filter_type[ch] >= SINC_5 && mode >= 512) || mode < 2)
 		return -EINVAL;
 
-	return regmap_update_bits(st->regmap, AD4080_REG_FILTER_CONFIG,
+	return regmap_update_bits(st->regmap[ch], AD4080_REG_FILTER_CONFIG,
 				  AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
 				  FIELD_PREP(AD4080_FILTER_CONFIG_SINC_DEC_RATE_MSK,
 					     (ilog2(mode) - 1)));
@@ -257,6 +265,7 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long m)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
+	unsigned int ch = chan->channel;
 	int dec_rate;
 
 	switch (m) {
@@ -266,15 +275,15 @@ static int ad4080_read_raw(struct iio_dev *indio_dev,
 		dec_rate = ad4080_get_dec_rate(indio_dev, chan);
 		if (dec_rate < 0)
 			return dec_rate;
-		if (st->filter_type == SINC_5_COMP)
+		if (st->filter_type[ch] == SINC_5_COMP)
 			dec_rate *= 2;
-		if (st->filter_type)
+		if (st->filter_type[ch])
 			*val = DIV_ROUND_CLOSEST(st->clk_rate, dec_rate);
 		else
 			*val = st->clk_rate;
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE) {
+		if (st->filter_type[ch] == FILTER_NONE) {
 			*val = 1;
 		} else {
 			*val = ad4080_get_dec_rate(indio_dev, chan);
@@ -292,10 +301,11 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long mask)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
+	unsigned int ch = chan->channel;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		if (st->filter_type == FILTER_NONE && val > 1)
+		if (st->filter_type[ch] == FILTER_NONE && val > 1)
 			return -EINVAL;
 
 		return ad4080_set_dec_rate(indio_dev, chan, val);
@@ -304,23 +314,23 @@ static int ad4080_write_raw(struct iio_dev *indio_dev,
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
 
@@ -329,9 +339,10 @@ static int ad4080_get_filter_type(struct iio_dev *dev,
 {
 	struct ad4080_state *st = iio_priv(dev);
 	unsigned int data;
+	unsigned int ch = chan->channel;
 	int ret;
 
-	ret = regmap_read(st->regmap, AD4080_REG_FILTER_CONFIG, &data);
+	ret = regmap_read(st->regmap[ch], AD4080_REG_FILTER_CONFIG, &data);
 	if (ret)
 		return ret;
 
@@ -343,6 +354,7 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
 				  unsigned int mode)
 {
 	struct ad4080_state *st = iio_priv(dev);
+	unsigned int ch = chan->channel;
 	int dec_rate;
 	int ret;
 
@@ -355,18 +367,18 @@ static int ad4080_set_filter_type(struct iio_dev *dev,
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
@@ -377,17 +389,18 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
 			     long mask)
 {
 	struct ad4080_state *st = iio_priv(indio_dev);
+	unsigned int ch = chan->channel;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-		switch (st->filter_type) {
+		switch (st->filter_type[ch]) {
 		case FILTER_NONE:
 			*vals = ad4080_dec_rate_none;
 			*length = ARRAY_SIZE(ad4080_dec_rate_none);
 			break;
 		default:
 			*vals = ad4080_dec_rate_avail;
-			*length = st->filter_type >= SINC_5 ?
+			*length = st->filter_type[ch] >= SINC_5 ?
 				  (ARRAY_SIZE(ad4080_dec_rate_avail) - 2) :
 				  ARRAY_SIZE(ad4080_dec_rate_avail);
 			break;
@@ -399,11 +412,35 @@ static int ad4080_read_avail(struct iio_dev *indio_dev,
 	}
 }
 
+static int ad4080_update_scan_mode(struct iio_dev *indio_dev,
+				   const unsigned long *scan_mask)
+{
+	struct ad4080_state *st = iio_priv(indio_dev);
+	unsigned int ch;
+	int ret;
+
+	for (ch = 0; ch < st->info->num_channels; ch++) {
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
 	.write_raw = ad4080_write_raw,
 	.read_avail = ad4080_read_avail,
+	.update_scan_mode = ad4080_update_scan_mode,
 };
 
 static const struct iio_enum ad4080_filter_type_enum = {
@@ -414,23 +451,23 @@ static const struct iio_enum ad4080_filter_type_enum = {
 };
 
 static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
-	IIO_ENUM("filter_type", IIO_SHARED_BY_ALL, &ad4080_filter_type_enum),
-	IIO_ENUM_AVAILABLE("filter_type", IIO_SHARED_BY_ALL,
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4080_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
 			   &ad4080_filter_type_enum),
 	{ }
 };
 
-#define AD4080_CHANNEL_DEFINE(bits, storage) {				\
+#define AD4080_CHANNEL_DEFINE(bits, storage, idx) {			\
 	.type = IIO_VOLTAGE,						\
 	.indexed = 1,							\
-	.channel = 0,							\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE),			\
-	.info_mask_shared_by_all = BIT(IIO_CHAN_INFO_SAMP_FREQ) |	\
+	.channel = (idx),						\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |		\
+			BIT(IIO_CHAN_INFO_SAMP_FREQ) |			\
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
-	.info_mask_shared_by_all_available =				\
+	.info_mask_separate_available =					\
 			BIT(IIO_CHAN_INFO_OVERSAMPLING_RATIO),		\
 	.ext_info = ad4080_ext_info,					\
-	.scan_index = 0,						\
+	.scan_index = (idx),						\
 	.scan_type = {							\
 		.sign = 's',						\
 		.realbits = (bits),					\
@@ -438,17 +475,22 @@ static struct iio_chan_spec_ext_info ad4080_ext_info[] = {
 	},								\
 }
 
-static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32);
+static const struct iio_chan_spec ad4080_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
+
+static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32, 0);
 
-static const struct iio_chan_spec ad4081_channel = AD4080_CHANNEL_DEFINE(20, 32);
+static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4083_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16, 0);
 
-static const struct iio_chan_spec ad4084_channel = AD4080_CHANNEL_DEFINE(16, 16);
+static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
 
-static const struct iio_chan_spec ad4086_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16, 0);
 
-static const struct iio_chan_spec ad4087_channel = AD4080_CHANNEL_DEFINE(14, 16);
+static const struct iio_chan_spec ad4880_channels[] = {
+	AD4080_CHANNEL_DEFINE(20, 32, 0),
+	AD4080_CHANNEL_DEFINE(20, 32, 1),
+};
 
 static const struct ad4080_chip_info ad4080_chip_info = {
 	.name = "ad4080",
@@ -510,25 +552,34 @@ static const struct ad4080_chip_info ad4087_chip_info = {
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
@@ -537,18 +588,18 @@ static int ad4080_setup(struct iio_dev *indio_dev)
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
 
@@ -556,7 +607,7 @@ static int ad4080_setup(struct iio_dev *indio_dev)
 		return 0;
 
 	/* Set maximum LVDS Data Transfer Latency */
-	ret = regmap_update_bits(st->regmap,
+	ret = regmap_update_bits(st->regmap[ch],
 				 AD4080_REG_ADC_DATA_INTF_CONFIG_B,
 				 AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
 				 FIELD_PREP(AD4080_ADC_DATA_INTF_CONFIG_B_LVDS_CNV_CLK_CNT_MSK,
@@ -565,24 +616,39 @@ static int ad4080_setup(struct iio_dev *indio_dev)
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
+	unsigned int ch;
+	int ret;
+
+	for (ch = 0; ch < st->info->num_channels; ch++) {
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
 
@@ -596,12 +662,19 @@ static int ad4080_properties_parse(struct ad4080_state *st)
 	return 0;
 }
 
+static void ad4080_unregister_ancillary(void *data)
+{
+	spi_unregister_device(data);
+}
+
 static int ad4080_probe(struct spi_device *spi)
 {
+	static const char * const backend_names[] = { "0", "1" };
 	struct iio_dev *indio_dev;
 	struct device *dev = &spi->dev;
 	struct ad4080_state *st;
 	struct clk *clk;
+	unsigned int ch;
 	int ret;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*st));
@@ -610,6 +683,10 @@ static int ad4080_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	st->info = spi_get_device_match_data(spi);
+	if (!st->info)
+		return -ENODEV;
+
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(ad4080_power_supplies),
 					     ad4080_power_supplies);
@@ -617,13 +694,35 @@ static int ad4080_probe(struct spi_device *spi)
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
 
-	st->info = spi_get_device_match_data(spi);
-	if (!st->info)
-		return -ENODEV;
+	/* Setup ancillary SPI device for additional channel (AD4880) */
+	if (st->info->num_channels > 1) {
+		u32 aux_cs;
+
+		ret = device_property_read_u32(dev, "adi,aux-spi-cs", &aux_cs);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "missing adi,aux-spi-cs for multi-channel device\n");
+
+		st->spi[1] = spi_new_ancillary_device(spi, aux_cs);
+		if (IS_ERR(st->spi[1]))
+			return PTR_ERR(st->spi[1]);
+
+		ret = devm_add_action_or_reset(dev, ad4080_unregister_ancillary,
+					       st->spi[1]);
+		if (ret)
+			return ret;
+
+		st->regmap[1] = devm_regmap_init_spi(st->spi[1],
+						     &ad4080_regmap_config);
+		if (IS_ERR(st->regmap[1]))
+			return PTR_ERR(st->regmap[1]);
+	}
 
 	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
@@ -644,15 +743,22 @@ static int ad4080_probe(struct spi_device *spi)
 
 	st->clk_rate = clk_get_rate(clk);
 
-	st->back = devm_iio_backend_get(dev, NULL);
-	if (IS_ERR(st->back))
-		return PTR_ERR(st->back);
+	/* Get backends for all channels */
+	for (ch = 0; ch < st->info->num_channels; ch++) {
+		if (st->info->num_channels > 1)
+			st->back[ch] = devm_iio_backend_get(dev, backend_names[ch]);
+		else
+			st->back[ch] = devm_iio_backend_get(dev, NULL);
 
-	ret = devm_iio_backend_request_buffer(dev, st->back, indio_dev);
-	if (ret)
-		return ret;
+		if (IS_ERR(st->back[ch]))
+			return PTR_ERR(st->back[ch]);
+
+		ret = devm_iio_backend_enable(dev, st->back[ch]);
+		if (ret)
+			return ret;
+	}
 
-	ret = devm_iio_backend_enable(dev, st->back);
+	ret = devm_iio_backend_request_buffer(dev, st->back[0], indio_dev);
 	if (ret)
 		return ret;
 
@@ -670,6 +776,7 @@ static const struct spi_device_id ad4080_id[] = {
 	{ "ad4084", (kernel_ulong_t)&ad4084_chip_info },
 	{ "ad4086", (kernel_ulong_t)&ad4086_chip_info },
 	{ "ad4087", (kernel_ulong_t)&ad4087_chip_info },
+	{ "ad4880", (kernel_ulong_t)&ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4080_id);
@@ -681,6 +788,7 @@ static const struct of_device_id ad4080_of_match[] = {
 	{ .compatible = "adi,ad4084", &ad4084_chip_info },
 	{ .compatible = "adi,ad4086", &ad4086_chip_info },
 	{ .compatible = "adi,ad4087", &ad4087_chip_info },
+	{ .compatible = "adi,ad4880", &ad4880_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4080_of_match);
-- 
2.43.0

