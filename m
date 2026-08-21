Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FD934C6EFF;
	Fri, 21 Aug 2026 14:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321314; cv=none; b=ghLmlWyIc6uY/5oa+wwJntdewo7gzP3JmHrxlHPJNi9rFrhpb3n9/MCzpjM0O3KSA/vrX/hkkUxYhhqAl0dTdx92eFGOuPmABVYiC6TphkAbkrSg70FNJ2PT0u6F14IG/N3VMGEhgy61HSJQWkVZpxDSwCzrLCfwADG4ApOgH30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321314; c=relaxed/simple;
	bh=sJaBzRymvE52VIqthqRK7e91z/tu/Vm0dy5m6HwqVOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=eApaqF/3JCFnObWNGF/gO7rNFSpTjRXmRFw8qmKSqUwKblsmI8LnmqjaBaXzl891DtUcOG7FXx5ZEN+st9OUvAhFGNIW/W2VVDvY1KKePTBGduAntlzrJ5N7b3G+70q4Y37vfFv0vCZJvlCmPWOkhLDZsuZ0iQyLQndyoNdkITs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=z/z7a1rY; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="z/z7a1rY"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpcLu3388116;
	Fri, 21 Aug 2026 10:08:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=o84ae
	LP8Ti4e004fMuS5tSXCV08GQ06uX1A5bVW/iAk=; b=z/z7a1rYQ8dSOdvWAxbae
	RciBJ+8FXcXoWSeTeBhQic8Xa+pmkTxK+jPF+WKq7sAmXpV+ihWeVh9PbPsN/9to
	cg0OUyFRl4J9fN8Zf/Vlp5mCZUt4k+0PDMAQgCl2pcJk4XsUK1yUiwkOoy4yjGvs
	FODfuzXuFvS1Z+mowJtXEwHVVxa5PYxEq/YsFbyPH0cZMr38YNi7omg7lbGEbnnD
	OBw4pfb76DTa2QSjXMGgCjOJXA7LFhWXzL1tEWU64yTL+C/ZHG538XC5pRL+nKyT
	oodPuHPOoAVqg+srx41hT6WdRtwCLddjGmtylC3Q+VydWf30QFU+unvCatseVYTb
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g66m6m0gm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:23 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE8M1F033005
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:22 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:21 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 21 Aug 2026 10:08:21 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:21 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkq024319;
	Fri, 21 Aug 2026 10:08:12 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:07:00 +0200
Subject: [PATCH v4 07/14] iio: adc: ad7768: Add calibration controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-7-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
        Michael Hennerich
	<Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        "David
 Lechner" <dlechner@baylibre.com>,
        Andy Shevchenko <andy@kernel.org>, "Rob
 Herring" <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=5966;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=sJaBzRymvE52VIqthqRK7e91z/tu/Vm0dy5m6HwqVOg=;
 b=uP220UAQE8HJYv1kf5GraNvNbzxgzJ+G5BJU2urXWRt9MjXCtcgMnKPxwohNgRXm7P2r8Z7dJ
 8tb+LfxslbDBwVUCwU0u4fKj3+yFsqlnJ8pwo6KZ2mnGeXgNLAA1Ro/
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX6DVHj6iC0G0j
 SH90ANiD2WPXUjmLQTu3ai8tpbM+npWJfTZ7QWBgjIFF1ugJDcHbO5wsAO5JkxnPzq/02NygakX
 5p+LCoue/AWPekeB1QFuG0BdSQusTaKzOp5WYZdEHYItlbsJBknb
X-Proofpoint-ORIG-GUID: RXcABJ2oOyMEvONhKqZ7fyv2x5KE2-Mv
X-Proofpoint-GUID: RXcABJ2oOyMEvONhKqZ7fyv2x5KE2-Mv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfXzi+hn2eORPyI
 rZUrORnCnLHfJ9FDnkqmOwbRIpuJIAjnnq1oZu0jX3i031ZC1epTp/SvVued4/1KsvWZIE6xkU2
 qhZKrRe6+Pe8Ilvnx522Ky9VWUm9Pt0cTImUzlPLtxQHWyQ8GkavPceyctd2wCthoCbuFGhXWn7
 Dxp+CKYM4mzGHmJW1HhUAR4nNnjpIGPptShJjsvhvq0ILHtZj1e8HZ7JTBe1kUsOJXVFMFQ5n6J
 buMDRYLvmBKufUieoAOwsvfoR/Bxa0do1QQJODNWbPnX/XjUyBTlEZJH1keOmBvDV4edk6A4c1B
 CCLwOK36BKyl9/0EHHmGAi80RcdVGVqUAejgClFRx+25ehBJC4fqdci7Fdy9GxGRJhr69V5tTzM
 6OTPPXqzMAYT58o8BF+pEKBTqXL3sy+SwnOsFBcRpQoUxz/4MrjRwjhdYC0cKZrVJiwou7xBVaW
 5GZbvjcNWI2CxyHaSjQ==
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a885bd7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=2R_6Ol2CWV77H6UbNhkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Expose the per-channel offset and gain calibration registers through the
IIO calibbias and calibscale attributes.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 119 ++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 08d8e97d58fc..289f3fa3142e 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -25,6 +25,7 @@
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/units.h>
 
 #include <linux/iio/backend.h>
@@ -116,6 +117,7 @@
 #define MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL			8
 #define AD7768_NUM_CHANNEL_MODES		2
+#define AD7768_CALIB_REG_MSK			GENMASK(23, 0)
 #define AD7768_WIDEBAND_SETTLING_SAMPLES	68
 #define AD7768_SINC5_SETTLING_SAMPLES		7
 
@@ -236,6 +238,18 @@ static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
 	return GENMASK(st->chip_info->num_channels - 1, 0);
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
@@ -355,6 +369,48 @@ static const struct regmap_config ad7768_4_regmap_config = {
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
@@ -701,6 +757,8 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int base_reg;
+	unsigned int calib;
 	int ret;
 
 	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
@@ -708,22 +766,44 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -731,6 +811,7 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
 			    int val, int val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int base_reg;
 	int ret;
 
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
@@ -742,10 +823,24 @@ static int ad7768_write_raw(struct iio_dev *indio_dev,
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
@@ -1036,7 +1131,9 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
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

