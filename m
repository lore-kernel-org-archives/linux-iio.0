Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B172D48381C;
	Thu, 13 Aug 2026 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629497; cv=none; b=iRi0It748aGyCwj153QGPqA48Vmd2i2BJ2+0743st8bZd5HUug+JEgdFmRrRzavjdgGKTBW9jrZj6dr2UwnR2jHiAYAA/aJTr8Nj9wULJhl6k/xx3IyvuXi42zOMBOIQhVsNyboDsN7OgbPRPm96w1jiuEVb5BVp/Rc1DHjKqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629497; c=relaxed/simple;
	bh=UJWSoyXKe14qXIpvAb3M5QVG4cT+Njcg5l1hFRvSyHY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=daUmmH5qaTNXIenSnFM5d6f8RBg7da5DthLN1reNDY5JEcgB3SkbJ6hqbClJXChIYVw7frGfGRZ9Xdw9y6TFEBW3IFy9/9tbF9HEg4tNV2QAlh2w+zdGPJs0OIOz+PehzZt2aG0W6G5YK6Pk7DnjhFqvqawwD73GkbnFQPX9s7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=ymh2Catq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="ymh2Catq"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCa7xl2129063;
	Thu, 13 Aug 2026 09:58:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=vERAW
	jWK/FBbrldkzn0mpkTsowpwRtCAi+3UBq7AKno=; b=ymh2CatqR4F0q5AiuwvRD
	dMZEmxmevMETuw+8ThO6NsRS2Q0rA8arv5kblMGX5g1R2DrkcIlEMcIEVnpjcxbo
	eM812CyIVOIX2FctD9aw9FF8jymnYAlw9AmXWA+ZJ666jl0iXkgWETDipJNpwzI0
	O92kyxHam756BpM8OqkI1lrfUrS9NVFJEvQaEeCTUbQK95f7s7MBTnGxB1LMB4U7
	NMKtbJls5kRIIfBJgtoeaP1RFmfZtSVjVRrnV4+2KQdRs5cBeT034HUqSbYBSWez
	pUjCWYgmGBGyb/tJ4h7DIOD5Dvam4M9hAtqiFNh628pRTEVRUAIZ4Ct0YsEBZc0g
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e2wgccp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDw1d8024645
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:01 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:58:01 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:01 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwZ006802;
	Thu, 13 Aug 2026 09:57:54 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:00 +0200
Subject: [PATCH v3 07/14] iio: adc: ad7768: Add calibration controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-7-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        David
 Lechner <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, Rob
 Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor
 Dooley <conor+dt@kernel.org>,
        Olivier Moysan <olivier.moysan@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Linus Walleij <linusw@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=6085;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=UJWSoyXKe14qXIpvAb3M5QVG4cT+Njcg5l1hFRvSyHY=;
 b=9bkyBcjPZ2yzJ22h1QyxZ1T2T8Qi775ijwyl2B19vahytQIboKiJwph62joJ5SnAgbi3bOQP/
 ul+KVIGZLYMDFxyBbBQgj2NiZvqlosyi4Gp4K+Srrla+82UM9zrPk7N
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXx/Inru+u/Esx
 3zdv6kI6W2MX5FhBBJNJkQUm8MIIh8dmO2rMQ2NG87FUvsUd+E9HG5X7Kn7HsZs95t0aR5Aky95
 RTlh5et2gruN47p/3EG+S5EdDd6cML5pGVGCLq1TxMFdtIJ+ZTPh
X-Proofpoint-GUID: W6y3S3N0m7lIOrhv0MW_X3lyb0Ljd60Z
X-Authority-Analysis: v=2.4 cv=UJzt2ify c=1 sm=1 tr=0 ts=6a7dcd6a cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=XhVhMDlc3cf8FCRBbCAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX9XHj2m3R1lvT
 +kS/w8bd64Nv1qyc3YBIBjlf+k0HXgK/FU+JiWRz1XHQR9G/Cp8F2iFm458WkUQyzgfs7PdUAo8
 1whhAWo7fI+O+r9uuvCO4Hp4c+ZeKqq0Ii9/zmT9iiV3jo99EiIfN8LV1vDIOKo4nSegA5acO1M
 /2ppJ4NgtJJKXYJmEw+awbeer4EG4GVi/xNOs8Vj26H/gFkOzeU9jltIg0+0e99ihCNcStAH59Z
 4ofx1crhZkAGO3Y3GNNJCPBJmiZk3wh/MQaanqGNf+hbCCG4Zw2Q7/xzW4qZhLrlG3u6pZpCx8E
 4ITNSLj13rXMM4JYkWhqhdI1aVNxraF7X5mqx6lRJ6IW6yJx5WgFp6o+I5VIv22kgNTM+MThN6v
 psGHAeU6CdbZXBCeuoDV1fJg1q4Bg9ZZqrJOPOUIFEde1+WhsSBWV3axR4t6uBYgHPPp/NuT69z
 7zJaooHeGOg0YGvxhPQ==
X-Proofpoint-ORIG-GUID: W6y3S3N0m7lIOrhv0MW_X3lyb0Ljd60Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Expose the per-channel offset and gain calibration registers through the
IIO calibbias and calibscale attributes.

Use bulk regmap operations and unaligned big-endian helpers to transfer
the three register bytes.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 119 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 3849f544a1e5..08721079bb37 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/backend.h>
 #include <linux/iio/iio.h>
@@ -98,6 +99,7 @@
 #define   MAX_FREQ_PER_MODE			6
 #define   AD7768_MAX_CHANNEL  8
 #define   AD7768_NUM_CHANNEL_MODES		2
+#define   AD7768_CALIB_REG_MSK			GENMASK(23, 0)
 #define   AD7768_REV_ID_VAL			0x06
 #define   AD7768_WIDEBAND_SETTLING_SAMPLES	68
 #define   AD7768_SINC5_SETTLING_SAMPLES		7
@@ -209,6 +211,18 @@ static u8 ad7768_all_channels_mask(const struct ad7768_state *st)
 	return mask;
 }
 
+static unsigned int ad7768_offset_reg(const struct ad7768_state *st,
+				      unsigned int ch)
+{
+	return AD7768_REG_OFFSET(st->chip_info->chan_map[ch]);
+}
+
+static unsigned int ad7768_gain_reg(const struct ad7768_state *st,
+				    unsigned int ch)
+{
+	return AD7768_REG_GAIN(st->chip_info->chan_map[ch]);
+}
+
 static u8 ad7768_precharge_buf1_mask(const struct ad7768_state *st, u16 val)
 {
 	return val & GENMASK(st->chip_info->prebuf_split - 1, 0);
@@ -327,6 +341,48 @@ static const struct regmap_config ad7768_4_regmap_config = {
 	.readable_reg = ad7768_4_readable_reg,
 };
 
+static unsigned int ad7768_get_calib_reg_base(struct ad7768_state *st,
+					      const struct iio_chan_spec *chan,
+					      bool is_gain)
+{
+	if (is_gain)
+		return ad7768_gain_reg(st, chan->address);
+
+	return ad7768_offset_reg(st, chan->address);
+}
+
+static int ad7768_read_calib_value(struct ad7768_state *st,
+				   unsigned int base_reg, unsigned int *val)
+{
+	u8 data[3];
+	int ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_bulk_read(st->regmap, base_reg, data, ARRAY_SIZE(data));
+	if (ret)
+		return ret;
+
+	*val = get_unaligned_be24(data);
+
+	return 0;
+}
+
+static int ad7768_write_calib_value(struct ad7768_state *st,
+				    unsigned int base_reg, unsigned int val)
+{
+	u8 data[3];
+
+	if (val > AD7768_CALIB_REG_MSK)
+		return -EINVAL;
+
+	put_unaligned_be24(val, data);
+
+	guard(mutex)(&st->lock);
+
+	return regmap_bulk_write(st->regmap, base_reg, data, ARRAY_SIZE(data));
+}
+
 static int ad7768_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
 			     unsigned int writeval,
@@ -650,6 +706,8 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int base_reg;
+	unsigned int calib;
 	int ret;
 
 	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
@@ -657,22 +715,44 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	if (info != IIO_CHAN_INFO_SAMP_FREQ)
-		return -EINVAL;
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ: {
+		guard(mutex)(&st->lock);
+		*val = st->ch_freq[chan->channel];
+		return IIO_VAL_INT;
+	}
+	case IIO_CHAN_INFO_CALIBBIAS:
+		base_reg = ad7768_get_calib_reg_base(st, chan, false);
+		ret = ad7768_read_calib_value(st, base_reg, &calib);
+		if (ret)
+			return ret;
 
-	guard(mutex)(&st->lock);
-	*val = st->ch_freq[chan->channel];
+		*val = calib;
+		return IIO_VAL_INT;
+	case IIO_CHAN_INFO_CALIBSCALE:
+		base_reg = ad7768_get_calib_reg_base(st, chan, true);
+		ret = ad7768_read_calib_value(st, base_reg, &calib);
+		if (ret)
+			return ret;
 
-	return IIO_VAL_INT;
+		*val = calib;
+		return IIO_VAL_INT;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ad7768_write_raw_get_fmt(struct iio_dev *indio_dev,
 				    struct iio_chan_spec const *chan, long info)
 {
-	if (info == IIO_CHAN_INFO_SAMP_FREQ)
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE:
 		return IIO_VAL_INT;
-
-	return -EINVAL;
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ad7768_write_raw(struct iio_dev *indio_dev,
@@ -680,6 +760,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int base_reg;
 	int ret;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
@@ -691,10 +772,24 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 	if (ret)
 		return ret;
 
-	if (info == IIO_CHAN_INFO_SAMP_FREQ)
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad7768_set_sampling_freq(indio_dev, val, chan->channel);
+	case IIO_CHAN_INFO_CALIBBIAS:
+		if (val < 0 || val > AD7768_CALIB_REG_MSK)
+			return -EINVAL;
 
-	return -EINVAL;
+		base_reg = ad7768_get_calib_reg_base(st, chan, false);
+		return ad7768_write_calib_value(st, base_reg, val);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		if (val < 0 || val > AD7768_CALIB_REG_MSK)
+			return -EINVAL;
+
+		base_reg = ad7768_get_calib_reg_base(st, chan, true);
+		return ad7768_write_calib_value(st, base_reg, val);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ad7768_read_avail(struct iio_dev *indio_dev,
@@ -983,7 +1078,9 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 		chan[chan_idx] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_SAMP_FREQ),
+			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.indexed = 1,

-- 
2.43.0

