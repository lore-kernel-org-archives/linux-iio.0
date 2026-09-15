Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E8643CEDD;
	Tue, 15 Sep 2026 19:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789499673; cv=none; b=GgBu2zgHB6uyTdasF+2LDmu0NWWkG3li93Vo9Dy8IBQ2SAGFgaoRq65QUT4U8TRgK9PHHdnpRUHhlMr1cr8jOlwfNs7NiYJvStnuD0svr4YyvDp2RKSYqsANIdYLXgRrFo987vu11Kqi7+Jz32NDwxfMGurajHZCk3LRYkvMsIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789499673; c=relaxed/simple;
	bh=whMbh0YXILcwhbWMXk4c0ac3emhSdvH2qQqSULMiM4A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DPXl8Iwmsgz3RqsVRHAEx0Es2bBNT/fOZmMEz9QOSbesUuO1ybNP6z35qK2be6FzXLkpvtOBpop88DWZ9FxRzoH5YI0xSRIolKiHaxA+r7nguTKm7NISbNm+Y7vF+iFNKGFtBbt83K+iDSeIANQShw3otk3YnRSuyyVnikRKGFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=CddH9pRf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="CddH9pRf"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68FIsFnb2052578;
	Tue, 15 Sep 2026 15:14:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=25ypb
	y5fJqBoe/2f0hkh6wCaD5OM+HrCgfEhOIO5qJM=; b=CddH9pRf+LfkfHIYNDYZ1
	OYBQHH9mZxpQLZ7FWS59OxCfq8YgJAjc92VOFvlX4bLZprkco7kTfx2bmRaF+u/3
	Rla1kU7xbOCa66MRkOZOCbRNAb/UB2pM0SBh2zClL2uYPVUiQV4Y9f4rXBqs7Zhf
	JH00TxI7isPWS7SOuAvIwlOPT3n/wp5waxA5dId2ZTv8Nvy1PDb1D4YJJO4iqfrU
	ayik4A+M8rfhjY6ZO4H0dVdnTpCc81KsCxVjdN6RXrpW2m0DwiphaAfEVTzf8b2K
	mQdFA86srHJ4tMAFOawYgCZ7+oUaXKQeOosZAc1X0wUj9G2FMRl+uRIruDz8wTRB
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq57ead37-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Sep 2026 15:14:26 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68FJEPEq019265
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 15 Sep 2026 15:14:25 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 15 Sep
 2026 15:14:24 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 15 Sep 2026 15:14:24 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68FJEBn4028151;
	Tue, 15 Sep 2026 15:14:13 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v2 07/15] iio: adc: ad4134: Add support for digital filter type selection
Date: Tue, 15 Sep 2026 16:14:05 -0300
Message-ID: <2d85cd933100b5ef003a8865a95deaf8082744fd.1789494473.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1789494473.git.marcelo.schmitt@analog.com>
References: <cover.1789494473.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: fuoVLXcN1FkAXdT-Zol8QSedioVI1xpN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfX1xQnh+3zHmd7
 ueHWuALM9DCgdjIX9fS/mq7v5dUHSF/11RfGL6yB4qtAD6FgZbtPgsGj5VBgzi07czODhxAWxaX
 EB9H4tcAl5L9OKA8RJp/UMo8vTew1APu5B1uFg7iKefZbujT58Q9yL7C2bdivdmYDGBdmdsMN9p
 qjufbbjcgfMm6Rug3xMxuz2oCaF7+D0z2NUixObCbSkP0moIVUaaKWLQL2zB8N039MHU5c6j4N4
 L8KqYWZAJqiS1Skd0U6wI/Bve+8AjAxqDOGSxpv+fgIeMGNrlwRjchjaX8lxM6dDefrUd2WibNR
 tvrdjM4U6fNOMrFLguYfmwlRLtO2k5W6Q7bAmheHyRK+4teDswSgdukZlh6Ea1sQY2/wItUErH4
 SwqRch4vsms3b8eII0dEPNGT7FIRUO2jNd6nsqd06++QCQMmQdGcCEoPhlTjg9wRiMwOwgWAk/M
 XDMMlDt7hoo+LHak8pw==
X-Authority-Analysis: v=2.4 cv=V9HoQuni c=1 sm=1 tr=0 ts=6aa99912 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=h0nqOfEF1LQ6m6ocHhQA:9
X-Proofpoint-ORIG-GUID: fuoVLXcN1FkAXdT-Zol8QSedioVI1xpN
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDI4MCBTYWx0ZWRfXzyzTtuYQdX/o
 hDDgipzJrVyKOh3s1Am7hGKn3yAwMxAU/DA8pBzLjjbqDz9Pc6SHcd0R6ec5Z8xZa8RuHrG4yw/
 fxPHlOta0HZRFmembxAOIu6S4KAB3iTJANfOUcA/tBJFtp6ptSfp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 impostorscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150280

AD4134 supports four types of programmable digital filters that allow users
to choose between different output data rates and input bandwidths. Enable
basic digital filter configuration by providing a way to select which
filter type is activated for each channel.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v1 -> v2:
- Tidy up code for filter select support. 

 drivers/iio/adc/ad4134.c | 76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index b4db20b80c44..30c7b1d1bc67 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -63,6 +63,9 @@
 #define AD4134_PW_DOWN_CTRL_REG			0x13
 #define AD4134_DEVICE_STATUS_REG		0x15
 #define AD4134_ODR_VAL_INT_LSB_REG		0x16
+#define AD4134_CHAN_DIG_FILTER_SEL_REG		0x1E
+#define AD4134_CHAN_DIG_FILTER_SEL_CH_MASK(ch)	(GENMASK(1, 0) << 2 * (ch))
+
 #define AD4134_CH3_OFFSET_MSB_REG		0x3E
 #define AD4134_AIN_OR_ERROR_REG			0x48
 
@@ -80,12 +83,47 @@
 #define AD4134_SPI_CRC_INIT_VALUE		0xA5
 static unsigned char ad4134_spi_crc_table[CRC8_TABLE_SIZE];
 
+enum ad4134_filter_type {
+	AD4134_WIDEBAND,
+	AD4134_SINC6,
+	AD4134_SINC3,
+	AD4134_SINC3_REJ60,
+};
+
+static const char * const ad4134_filt_names[] = {
+	[AD4134_WIDEBAND] = "wideband",
+	[AD4134_SINC6] = "sinc6",
+	[AD4134_SINC3] = "sinc3",
+	[AD4134_SINC3_REJ60] = "sinc3+rej60",
+};
+
+static int ad4134_get_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan);
+
+static int ad4134_set_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  unsigned int val);
+
+static const struct iio_enum ad4134_filter_type_enum = {
+	.items = ad4134_filt_names,
+	.num_items = ARRAY_SIZE(ad4134_filt_names),
+	.get = ad4134_get_filter_type,
+	.set = ad4134_set_filter_type,
+};
+
+static const struct iio_chan_spec_ext_info ad4134_filter_type_ext_info[] = {
+	IIO_ENUM("filter_type", IIO_SEPARATE, &ad4134_filter_type_enum),
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE, &ad4134_filter_type_enum),
+	{ }
+};
+
 #define AD4134_CHANNEL(_index) {						\
 	.type = IIO_VOLTAGE,							\
 	.indexed = 1,								\
 	.channel = (_index),							\
 	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
 	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
+	.ext_info = ad4134_filter_type_ext_info,				\
 }
 
 static const struct iio_chan_spec ad4134_chan_set[] = {
@@ -115,6 +153,44 @@ struct ad4134_state {
 	u8 tx_buf[AD4134_SPI_MAX_XFER_LEN];
 };
 
+static int ad4134_set_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan,
+				  unsigned int val)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	unsigned int mask, reg_val;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	guard(mutex)(&st->lock);
+
+	mask = AD4134_CHAN_DIG_FILTER_SEL_CH_MASK(chan->channel);
+	reg_val = field_prep(mask, val);
+	return regmap_update_bits(st->regmap, AD4134_CHAN_DIG_FILTER_SEL_REG,
+				  mask, reg_val);
+}
+
+static int ad4134_get_filter_type(struct iio_dev *indio_dev,
+				  struct iio_chan_spec const *chan)
+{
+	struct ad4134_state *st = iio_priv(indio_dev);
+	unsigned int mask, reg_val;
+	int ret;
+
+	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
+	if (IIO_DEV_ACQUIRE_FAILED(claim))
+		return -EBUSY;
+
+	ret = regmap_read(st->regmap, AD4134_CHAN_DIG_FILTER_SEL_REG, &reg_val);
+	if (ret)
+		return ret;
+
+	mask = AD4134_CHAN_DIG_FILTER_SEL_CH_MASK(chan->channel);
+	return field_get(mask, reg_val);
+}
+
 static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
-- 
2.53.0

