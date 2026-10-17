Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6A403839A1;
	Sat, 17 Oct 2026 01:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792202353; cv=none; b=mudjSwKMRub2HN4LjXi8FOfNQ40At6XF2mlVWEPUnsWSMU4LzoIbK0IA//uzEbDCbeVGhRcn6gYQ7AfBnjG2mXZUUK5GEmpXmryU4AIJ/7XuQ3yylRGVDMibV8Y/sAkDyxwspbzfsvfz2RCK/FsDicPozjS6Gw+x96tMcQjkXjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792202353; c=relaxed/simple;
	bh=4XDEfLN6FiAOHRZqXdi8ti4WU8Zt0u3A7J8JXYZZcXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=slsL79LQvl0fot3KIiB/xorCJHvuvD4Cv/S6Nf+IUz8OX+zBgu6niMXycUsBElAd3NXsIj1Mv7cgwqhbW0zKoO6j5IowmtO1CFTXLruc9f3YAQOqAXtg4P1EAMpca5QhGAWP3KX0/KeG99ACc2mhs8SJEKFk0/vhowXwfwH1rWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=JfHW5zOO; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=eE9Yv2Pj; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="JfHW5zOO";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="eE9Yv2Pj"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GNHSaP2680473;
	Fri, 16 Oct 2026 21:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=4vJaw5awVXT57/SfW/oF3AIalY1DwaBd0ecvdOZdZ4g=; b=JfHW5zO
	OTnHtm8qRB/XS4ePGgUe9YVYbbARx28s7XQjlvl0jtR16nP5U/UjDKeXGNwJ8t93
	iy7GRrWP1Qs2K/nZ64dPklAqE/UohTHQUT4HUs5ZOZPFi9fHaTri2MPKkZTmL6V1
	w8PhCRw0hcNCpdxr3KKY7JXRThOwIv8kf39W6cwcJB+xg0lVU7H013lo1Ay6ZgSj
	lZfY5zCKcLUmQaRTMXni7pjgWZ9pfIdHbWSFBC+Q4kWrQaY+6SBCMaRw6QrsWrJI
	iCSbbXaCMaMxHMv33uBN788+d6wpEm97VgSMuLzMcHopKXFEtChtnrpLSS7hLcRI
	YQbgi3Y4vKI5LUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=4vJaw
	5awVXT57/SfW/oF3AIalY1DwaBd0ecvdOZdZ4g=; b=eE9Yv2PjRL36/zSkQZUHs
	J8QEAdlyNgWzqGA0TlSAfuOtvU+PJd21cLH5MaNo7CU7m2/2HsbgVWUJhogwEoiV
	Dp/spiQrXNeg+hHD/7xgBWjUHAsJi76rjr1YObs6iVX60ReB1t0SYWdL/AxOSpfi
	x3oHfcP7EzB5SutR8YrbOHZWnliruXQNtYL2ER7S/XYxhFn9Kl+/1Xg1LaTZLOpU
	EbWcd2XnC9DJ/dd4/8N9YEBskcXE7GnHZgzur1LrhADyK1Doox4BBs8kCnm9tTEu
	Bc0rWuwVEHcHE+hgsyKxn67YVIAn7bHbjymfs3J7Lrk4Gv9pYAsJFnNJAzbbB1NV
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4hbmr4uaew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Oct 2026 21:59:07 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 69H1x2UI061808
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Oct 2026 21:59:02 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 16 Oct
 2026 21:59:02 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 16 Oct 2026 21:59:02 -0400
Received: from work.maxim-ic.internal ([10.66.6.191])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 69H1wmIt004338;
	Fri, 16 Oct 2026 21:58:51 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v5 08/15] iio: adc: ad4134: Add support for digital filter type selection
Date: Fri, 16 Oct 2026 22:58:42 -0300
Message-ID: <a547bfc6d0b41413818f7048d4a685fbb43b6537.1792200021.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1792200021.git.marcelo.schmitt@analog.com>
References: <cover.1792200021.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX9oYg4fdnANr6
 jwVnDf3AcvEBbIWPEBHRHUb7niMXUHJmQCrsNcx72Fwr0Ycyk9Jza1b3vgbFzk9jazoOXlgwHYX
 b7Pr0nqXf1lyxLWqueRjUY1HcfzJKOOrPYxFZKkfI7kbaoXR7JWcoh4XBHUeGW8cHshLBhI10fu
 JWQ58rvcqRLFhumpEwGIWdAxkNeJ1zR7LkRLT0z4zev/BwHf484nRpkH97MCeMd/DxkG81q7b7+
 so6x3TrP5+iOFWj2dOTd+D2EY2KxFJ+U8NZu2INSri/f0DywAEitg4zIbZ1a87tdwCPkxNd8kg6
 4LtZsd0WdtWm7Xs+VNRRPTxuPq2Pk8DNf1l4nlavUrkdLLwdmjVv2UQgtAOF4Txu/ltUs3dpQYP
 n1CAXW0KavQHi7GNrnE+Y2ErkGF7EQZn4xlFNROIxbaIeSPuLomQ3I1Y7fTtrjLEJf6XAYtFieI
 5XY0oYTSSTv4AsWUYTQ==
X-Authority-Analysis: v=2.4 cv=TqtzFzXh c=1 sm=1 tr=0 ts=6ad2d66b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8 a=-aTzIQr-9UvPopa1cmsA:9
X-Proofpoint-ORIG-GUID: 4GAVI820zoUCUIdPNuigfQyhAwvMy3pC
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE3MDAwNyBTYWx0ZWRfX483u/nDV8XQl
 CuaYbCmncjHo2t6mLXXiJvVHs4IDxkHBGQ+cqi2q+2kg2SjaYcaajDme843a9oXDpkj6c8NArLY
 671T/jev8u8gkTF9ujz1ZCAnGL1sXXt6fRnM5w+QksB3v7XXPLCm
X-Proofpoint-GUID: 4GAVI820zoUCUIdPNuigfQyhAwvMy3pC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_04,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 adultscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610170007

AD4134 supports four types of programmable digital filters that allow users
to choose between different output data rates and input bandwidths. Enable
basic digital filter configuration by providing a way to select which
filter type is activated for each channel.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v4 -> v5
- Re-arranged code so early function prototype declaration is no longer needed.

 drivers/iio/adc/ad4134.c | 93 ++++++++++++++++++++++++++++++++++------
 1 file changed, 81 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 91a7c2107770..b245001d4551 100644
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
 
@@ -80,19 +83,18 @@
 #define AD4134_SPI_CRC_INIT_VALUE		0xA5
 static unsigned char ad4134_spi_crc_table[CRC8_TABLE_SIZE];
 
-#define AD4134_CHANNEL(_index) {						\
-	.type = IIO_VOLTAGE,							\
-	.indexed = 1,								\
-	.channel = (_index),							\
-	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
-	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
-}
+enum ad4134_filter_type {
+	AD4134_WIDEBAND,
+	AD4134_SINC6,
+	AD4134_SINC3,
+	AD4134_SINC3_REJ60,
+};
 
-static const struct iio_chan_spec ad4134_chan_set[] = {
-	AD4134_CHANNEL(0),
-	AD4134_CHANNEL(1),
-	AD4134_CHANNEL(2),
-	AD4134_CHANNEL(3),
+static const char * const ad4134_filt_names[] = {
+	[AD4134_WIDEBAND] = "wideband",
+	[AD4134_SINC6] = "sinc6",
+	[AD4134_SINC3] = "sinc3",
+	[AD4134_SINC3_REJ60] = "sinc3+rej60",
 };
 
 struct ad4134_state {
@@ -115,6 +117,73 @@ struct ad4134_state {
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
+#define AD4134_CHANNEL(_index) {						\
+	.type = IIO_VOLTAGE,							\
+	.indexed = 1,								\
+	.channel = (_index),							\
+	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),				\
+	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),			\
+	.ext_info = ad4134_filter_type_ext_info,				\
+}
+
+static const struct iio_chan_spec ad4134_chan_set[] = {
+	AD4134_CHANNEL(0),
+	AD4134_CHANNEL(1),
+	AD4134_CHANNEL(2),
+	AD4134_CHANNEL(3),
+};
+
 static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
-- 
2.53.0

