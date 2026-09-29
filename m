Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37CCC4E56CA;
	Tue, 29 Sep 2026 22:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790721852; cv=none; b=JEaL6OxTSl8mWky5BU7ExTKA3tUnjdIV45PrHmzgIuSkNTm8nEnEYO29TkqpB9C7/dLnvnsGmOvErdyeFHIK9wWxQtGJBnZg8dDfpHH2zyEzXFndei4QuBMQGU4KjYc/avA7hxBEZn6hij1qIsxGCrtdR4aSaSU2aqF2YGcvrBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790721852; c=relaxed/simple;
	bh=xj11t1/TNY1j0p4ukIAofepAEy6isKX93m4wuf3DRsI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p5VW/iQNO7qy98UyNJovwv7gZJpDEbpzDzE13Um/RWkuPHWNuxPF8/azGCLAoQp/Z6GFDk9g5lyrueDaLCi1z0UaP0Tzo1DW1vSTMSwyrt7fktV5YcMDGW5lvEaHkdTFpPtdVDxPRJR750Drkr1sYP5i4GI46pS8CC3ADd3M5XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TE7jYzT6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TE7jYzT6"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68TM4Kt73743932;
	Tue, 29 Sep 2026 18:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=V0e5V
	qBjKt/EwAgpOK9it4VvvgaWPawX/40lRoodgDw=; b=TE7jYzT6f6jFssZ04tx9P
	RKvJUcSKUN6h70d2WSt9utMnARlHOWqGM4VY7MRsDNd/XA8vh9PR/kMjF3rRPBiz
	wasAMCmCYa1yuMwSxuzE7tEPt4T/T2Li6Ivkd5gmPjRJiHedVvYujd4LPhyWWpYG
	J7w5vHPQWu7v7IiuIgJ4dGLrJ7h9VbdRTt71ovFd6hshkvInKQ2y5C3bO2msdjsA
	YSVVHVPlmSZIRaQa1BMA6QEFvuDhXOSyfxyQxCuL8MG9m0WcYsQlVyomUCqaeZ97
	Bk6/2fUPZbljhSQmPLuwRTfP8/G+4lXV2xduh/zUTfRC6F5CTwgUOzSJsTG7mcAg
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h0jhs949r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 29 Sep 2026 18:44:06 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 68TMi5Yo041492
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 29 Sep 2026 18:44:05 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:44:05 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Tue, 29 Sep 2026 18:44:04 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 29 Sep 2026 18:44:04 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68TMhprZ008197;
	Tue, 29 Sep 2026 18:43:53 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v3 06/13] iio: adc: ad4134: Add support for digital filter type selection
Date: Tue, 29 Sep 2026 19:43:45 -0300
Message-ID: <2b32e8e59c2c9cf88b349b27b1f1a77783517a82.1790719424.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1790719424.git.marcelo.schmitt@analog.com>
References: <cover.1790719424.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=ZbeIpcVA c=1 sm=1 tr=0 ts=6abc3f36 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8 a=h0nqOfEF1LQ6m6ocHhQA:9
X-Proofpoint-GUID: VvsDLEeGOCLXhTSemQ6BRIh2PbMtRMEM
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX6CRRwfZbgJfw
 9zf1gMwBi87DiCQti6TE7qEEf5c7UWLFTn7rJ0iPVw+rR5V0Rd+YCpFqIasiqw7GCYiqolNFVqt
 vyZyPm5Y9irTA+c18hesNVsRGeucSmwPgGpwmBkdTXMyi6jU78KH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA5MCBTYWx0ZWRfX6PFgCSesIKW7
 2Z4gyN7olzTFaUy7ldKcGLlKK1DRS30vn3nlxhjgxtMJtssmA4kMIRUxf8PajRzP33Lh8CP9p2C
 jEXbWOZBY5H1b1cSOn/EmaLM1FDoXXjQcKIEom6WELtc08zVgR+skb+9EGXd2t16H+1KZy9Bh6n
 P/K7nztvJhLHJd415/27Z7nAOA9sJvsDM3gcLKKjJsSwHedxoPrOH8w3LMZc4jjt2hlPXxoATJ2
 J5duF+4APFEXHchT/NxDLTUHF8H9c3D20pkI+sBfX0LKphddhYzi42lsQp5zLJDSQ3lUcl43ftF
 uP6sRUiYtytw8c0T/qEkMd+C2x46lOcMW7aQF4TRQ6gHbeB2yb4nggX6XAjvLwVhAJwMiEiHJMP
 lJloNZWHd+GZRNTgEdy14JOcHx4EFmwq0gs5ZzhmULIR/bWBD1nBE2SG0Uvx+u+IQFaHoBrsFXt
 cq3Ogtka/nKO2R/2doQ==
X-Proofpoint-ORIG-GUID: VvsDLEeGOCLXhTSemQ6BRIh2PbMtRMEM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290090

AD4134 supports four types of programmable digital filters that allow users
to choose between different output data rates and input bandwidths. Enable
basic digital filter configuration by providing a way to select which
filter type is activated for each channel.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v3.

 drivers/iio/adc/ad4134.c | 76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index ce077aef2d2a..14996a0d1fe8 100644
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
+	guard(mutex)(&st->sync_lock);
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

