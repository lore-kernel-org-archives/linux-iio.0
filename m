Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB1724AC151;
	Wed,  2 Sep 2026 17:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788369829; cv=none; b=ZWLf+CyyqxJqAvLenpVIHFLq4pypZ3KxD5wuLtbktvwGWmHWoQ+JciRaKrsE/Vk++IPKZw7H74zc2bR0hNMOQdCToDiNGHcf6++bfSKaOyYcTvGbYqp3HkPC94fHLWaTLblWFZR8vL/nwTxxOf3gZSH7as6jhmxx1DRe3JnCLAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788369829; c=relaxed/simple;
	bh=hrQfHrO2atZtkbii0dAwYxzYV3a8hbu6lKcM9TS7vgc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WgOqLBxoq6q7PGSHTnzTVXZtJVPxqebLPKtEAwFHOVxu4vygNOchKmsVEB9CkQVFd9Gj8JNTlgJo5ST1ABg1fRAv5dtFRmsc7v07P/s3jh8FR+UWiQTgxlaW6KaNFEFDMzf+SnJRVgK48ePDTtgoVSl4oKp/8n4Pkw8AU1u2z3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ZpBTPpZ3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ZpBTPpZ3"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 682HDOfA2569950;
	Wed, 2 Sep 2026 13:23:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=O+vjs
	O1HjIxMN3C6gqr8QQ/O9JEQp/8yZ0NYvam4XN4=; b=ZpBTPpZ3yDGJ8VitlDFGU
	ZdzuccbE8Dd1d2ORYzSemWdBqHKvU+T9FqOKYnrWemNxXqDzq8G+euvXCTzx7CI8
	rbU2pl0iu/74lrm7aX13V2XpefkDEPQ21UEcTVxuYOeYrG7rJzCU1Lnw/5+9SP27
	aEm0XC5E8MBNuB7eoQ6flbl7uSXmfxG+rZVeiX0cKCG6cZEUBBzTqPbh/kK5+U8Y
	mhipC3Gh9zDzARO5zrIGQRlm/dFAZBT5IK6MQ5WwCH8Z61yPZH5MDM8uzk6qlwjp
	9jbzOms/T5yRqetoyVTnSxhhNoqUhv1VGbdhkAWVDUbdCL28Fq6VgPxSkfspgkF/
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4ge3v1n7x9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 02 Sep 2026 13:23:42 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 682HNfeI041321
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 2 Sep 2026 13:23:41 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Wed, 2 Sep
 2026 13:23:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 2 Sep 2026 13:23:41 -0400
Received: from work.maxim-ic.internal ([10.66.6.192])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 682HNRWi004234;
	Wed, 2 Sep 2026 13:23:30 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux@analog.com>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <dlechner@baylibre.com>,
        <andy@kernel.org>, <Michael.Hennerich@analog.com>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <corbet@lwn.net>,
        <skhan@linuxfoundation.org>, <marcelo.schmitt1@gmail.com>
Subject: [PATCH v1 06/13] iio: adc: ad4134: Add support for digital filter type selection
Date: Wed, 2 Sep 2026 14:23:22 -0300
Message-ID: <058e82fb421c6794cc3002bde25d9e3485f74be2.1788368334.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1788368334.git.marcelo.schmitt@analog.com>
References: <cover.1788368334.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=bql8wkai c=1 sm=1 tr=0 ts=6a985b9e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=h0nqOfEF1LQ6m6ocHhQA:9
X-Proofpoint-GUID: FZnoXfBk89TF8hI7A5wyeAdL4HIwWYqO
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX5Tq7/2Ddbcq4
 x7VIF43Lsn0cq7JyU6GVLmRcrhpo2M0x3iWLf7cQkPJEPTsIIdLPcYMvfw+AUWaWTExXecSnYEW
 +HeCkQ5VAOA+xyorcmeIEK1mTEILSjL/E9xG77A5kKuY83gLRUCO
X-Proofpoint-ORIG-GUID: FZnoXfBk89TF8hI7A5wyeAdL4HIwWYqO
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1MyBTYWx0ZWRfX9xw8a0jnK0oY
 vytkRp2JuXAErVTrjO7s0uliC0crrStWSNqy+L+u9efYC2uzXB8EH8+z4LEO7vCAbl/LumToBZc
 Sec5SRm9QbbiqnKL7kB2JtsOh+GBi8R+0V1zxw13vXKieG8XYkGRmdpCRRB7ekpE6/DOrps87kG
 UQHtP/dWvJDljOOv9t8Vb1OJcn6pgtLvOjYkAdt5xKtDqAekiLRmYc2P/A2UlhO7/YFu25Z3UKY
 Z0n/1uAE0i+FVXqx9dXPxsnyLINXpTk493+uNfbDYlbqLCiT2dJIMAv/FXNhNH8STR61dDDwK4o
 WIoM+RUjtpB3FeErODPw0JwV+90HSQl/Eb9Ze4vYGW2kYrSuM9LnYF9yNNME1p+DIwQxFAesUTk
 VmhQUbqwLENh5iCoRTnjsQbQygEbrqO4csk5WWVeI3unKKGOlewpMKBppPFSyTYgXLWdkIyl4+9
 M/k7MjuEJuqDLlhtp8Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 adultscore=0 malwarescore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020153

AD4134 supports four types of programmable digital filters that allow users
to choose between different output data rates and input bandwidths. Enable
basic digital filter configuration by providing a way to select which
filter type is activated for each channel.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
 drivers/iio/adc/ad4134.c | 80 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 80 insertions(+)

diff --git a/drivers/iio/adc/ad4134.c b/drivers/iio/adc/ad4134.c
index 7da6734d4609..a1474316e330 100644
--- a/drivers/iio/adc/ad4134.c
+++ b/drivers/iio/adc/ad4134.c
@@ -64,6 +64,9 @@
 #define AD4134_PW_DOWN_CTRL_REG			0x13
 #define AD4134_DEVICE_STATUS_REG		0x15
 #define AD4134_ODR_VAL_INT_LSB_REG		0x16
+#define AD4134_CHAN_DIG_FILTER_SEL_REG		0x1E
+#define AD4134_CHAN_DIG_FILTER_SEL_CH_MASK(ch)	(GENMASK(1, 0) << 2 * (ch))
+
 #define AD4134_CH3_OFFSET_MSB_REG		0x3E
 #define AD4134_AIN_OR_ERROR_REG			0x48
 
@@ -81,12 +84,48 @@
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
+	IIO_ENUM_AVAILABLE("filter_type", IIO_SEPARATE,
+			   &ad4134_filter_type_enum),
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
@@ -116,6 +155,47 @@ struct ad4134_state {
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
+	enum ad4134_filter_type f_type;
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
+	f_type = field_get(mask, reg_val);
+
+	return f_type;
+}
+
 static const struct regmap_range ad4134_regmap_rd_range[] = {
 	regmap_reg_range(AD4134_IFACE_CONFIG_A_REG, AD4134_SILICON_REV_REG),
 	regmap_reg_range(AD4134_SCRATCH_PAD_REG, AD4134_PW_DOWN_CTRL_REG),
-- 
2.53.0

