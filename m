Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BD264A4401;
	Tue,  6 Oct 2026 18:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791310688; cv=none; b=riuVnqRAQQXz+DKDQ+w6Rdzst5xXoU7GTXnAH9vekrhI+dKu0kXoxpZDN3RAR10IKEmDNDMDreXWbuiYnp3bKGnoYd3qVzbtTNvxuar+opjaN93cNVP7xl05EtzDb7CV2BLBT7HxQnn3xmVaPw8pFi8MGrWs5hYcsozPMuNXJ+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791310688; c=relaxed/simple;
	bh=8nih06MOqhQ5Od+8Nt/xfOA0KDfJodkDRO20HvKdptA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SbyqBpa0lI8lojftHkz8cfZI6vW/ABPwYutDV/gEu/J76co4qwMZsuA8BV+3TxKBh4GJFntaj8osmNHmR8UGGtUrNa0zJs4knoMDErjFXikSBg/sWiAzvV2aB3zGSIRfvYXzyMJOeEl1gii8U7e0FzQZ/ERRjenqNl+ukO31hmA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b=mu0xfmiE; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=wxk1BVR9; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vtelectron.com header.i=@vtelectron.com header.b="mu0xfmiE";
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="wxk1BVR9"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 696HhkPg2853358;
	Tue, 6 Oct 2026 14:17:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=UbHlJYpdfPVjl93y1nc5cTf8zf+bIOBblG+5Cz9WvhE=; b=mu0xfmi
	EgJe4ow7Ia+RiSHQ5ltpCMNqKnw8QmmcvoFGlFTCOCbZeBFQguU2MAe/Eb4mQ4fo
	+fYsd+F7n6k6GRhCXxVWF9Nyxh0WsxToKjZwsQFNG+A10UoyB41o/6q6biWY+2gS
	cVjdFaqcHSIs66PErRfYS7YjPAUvaAyaxiGqcoPS4VHwuuwPTBFDBFC1lWtuBmLu
	Sd1CzB69ePJexCj1u97yTdUa3oq2RifVJ4uVqjqYsb0XS3e6AjxqhjKNHg5stA+B
	yTvT/RkzjxOdqZYXE0Y6F2gFeF+ezvzP5ufMUTnkoH8LcvlJW/8fHSiwZUfVEMhV
	PYAhhXm2I+msRDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=UbHlJ
	YpdfPVjl93y1nc5cTf8zf+bIOBblG+5Cz9WvhE=; b=wxk1BVR95Go0F8Xe2D+/h
	nZPAtuCxK6s3V68/CPEpId0B0qXrK7cza6J52rCGnUfKfP/3laXkQ38noJb/vtEB
	U/rCArWPU7qdbauyZOlQwHVtavN6Z3ilLpAjmdYPv4bRbJtMWVWfMSOsEWn1c3Pj
	IsMQLa3zzAXAzh7UftIW/FWXGfyGaS8lXjD9lKZoMijqJeQeDOEFiDp+uDeGf9rG
	4bBd9kVGpPnCD/BsXziUhslEgqkCkrmhBQQtm/ey8kY0ys2BA1rkin88fpQs+pn+
	22tZ6IWaQz/nfRW2a13qZ/LmdgAoMv7C4p72sjnaxZKhWJvY3J1EtGAH0/zKVGS1
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4h4j2exu0j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 06 Oct 2026 14:17:57 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 696IHu1Q010024
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 6 Oct 2026 14:17:56 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Tue, 6 Oct
 2026 14:17:56 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Tue, 6 Oct 2026 14:17:56 -0400
Received: from work.maxim-ic.internal ([10.66.6.193])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 696IHg9v001009;
	Tue, 6 Oct 2026 14:17:45 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v4 06/13] iio: adc: ad4134: Add support for digital filter type selection
Date: Tue, 6 Oct 2026 15:17:37 -0300
Message-ID: <34420a81caefbbcc589da506097571bb516e3eaf.1791309733.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1791309733.git.marcelo.schmitt@analog.com>
References: <cover.1791309733.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-ORIG-GUID: zqnMi7snW9W7Mfsh44Hq6gu3uCBa6Fyr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX4ZPlW/TMew+z
 PSzT7L3T9tyjHIudzIjOhIWzgEHbCT6D8xBm1PGH3+yQ+rIzSYptSmDKWtmNoW2F91SEEzgNpWm
 QL0MU3mDxyI1NkebNP+yf201jOLcpm9XYib8of0r2FXXMsj8Lb21huVyjB1BeF+d309vy3xBDoP
 93CkJVaVajDNJzOallT1dCtaiE7t9EsjjDScR8zfLArXtoqXyojpRpf2R1ba/vQ7rLva58fVVFb
 +H/ZPA4B64YpN06tOsa+P9MxLO1TLlLNncBSskiGAQD2hEoX7R0l1lcChGdUKLEUl3NMe6ejhpJ
 FWWiAkcsSr1TfH2be8tFmdd+8EIhan7aeBMgAqdh4BAEFo0qrva6umpjrCzYCEuRpplrRSSjglK
 VEZ+vrlF9dQYbESbRaN9qXraWO4uT7xTQgN6MF1RkWdC7OOi2vrUmvLeU7p0+WjJrZE7AOWimJJ
 FA8Aric9nb5pHra8lhw==
X-Authority-Analysis: v=2.4 cv=JvtkP84C c=1 sm=1 tr=0 ts=6ac53b55 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=h0nqOfEF1LQ6m6ocHhQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA2MDA3MiBTYWx0ZWRfX82lScQPogOpA
 CRXVdOuGeAGXG8+heFTn1q/Dne9CkJw34i7BRMW8HMbkGggG6e6QkmoigL7qIdk9BFUKV53zFti
 9TCz1vi3Ip5gF2m1tl2g1ID1C8Y6G8E1hrzXIASzay8ljAeLfZ7h
X-Proofpoint-GUID: zqnMi7snW9W7Mfsh44Hq6gu3uCBa6Fyr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-06_05,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610060072

AD4134 supports four types of programmable digital filters that allow users
to choose between different output data rates and input bandwidths. Enable
basic digital filter configuration by providing a way to select which
filter type is activated for each channel.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
No changes in v4.

 drivers/iio/adc/ad4134.c | 76 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 85fa16321d74..3048e61a3cb1 100644
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

