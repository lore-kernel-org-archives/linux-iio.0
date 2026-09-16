Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC714F7984;
	Wed, 16 Sep 2026 11:15:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557375; cv=none; b=vADrukjN9PFae9lpThr69bP2zm6TERwKUeOyKq4eKcvQGlSIj6Sz/3V9wu+S4j9JO7m9PJDyxlrHJipMKspcuEsX2C0XTf+KpBa2Rs+Z2KgZahBHVrbYa5EukDstUCJTALXO2W4Ck3d7lbmbT3Vm/C7ugCu61dDaRF1ri3ifaz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557375; c=relaxed/simple;
	bh=OuLDskNeHHA1YaHizQ72W0f1T9DvdLITtAOQJI83OAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Y4f4+kc42QEZpCKYTnOMn2yqrxK1/hfntf1K6yB43X33NwkSwb3/Lzyk/AfA6kYwJMFVKxnXudquJ8Wu/64BiO2ox1JxHsQas6tlbVdry2FLrJH5p+ohEX+r8qmvsrqksYo1dJ3lDD1CrCq5n6QEi9Q0rCGYbCrcDbFIblvfKTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=yYtZp4o+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="yYtZp4o+"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G79dNs1591639;
	Wed, 16 Sep 2026 07:15:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=lU8dL
	dgplaE9CAxsjSH0y7F8FVgB4zF5BGETXeDU2q0=; b=yYtZp4o+AKtQKUuLf49qQ
	Ch4PAVGbkdXi1OP4Z2zpFE+O+rcBdtHzU9a5vJRACwhVkM1cBp2gXUv983e9R9cc
	EUEI0lRTpg5r/uS1+Y3vXBRY608SmNFTrwY0FSO8Ov6yvDtl5PbUvbzdQfbS7uSc
	cnfy62bs1DNFE5kgKTkL4Mn3wyBP7DZKPick4qiafkLxieyJt60nKDSDJSUKW4ua
	26clGzwBqBm8PtaiZ0LAyzOF4SjcLERnLHMaSpW8GK/2kj11nDZ/rekrxh+Fj5FO
	UV+VarNlUQPUMY0srFhqcePPBcr+n6NP3DxukRIvt3taOghpRZGythnFQsP1k9BK
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gq98c4cp1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:29 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFS8T047136
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:28 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:28 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:28 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:28 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE5004263;
	Wed, 16 Sep 2026 07:15:21 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:14:02 +0200
Subject: [PATCH v8 13/17] iio: adc: ad7768: Add calibration controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-13-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
        Michael Walle <mwalle@kernel.org>,
        Randy Dunlap <rdunlap@infradead.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>,
        Jonathan Cameron <jic23@kernel.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=5933;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=OuLDskNeHHA1YaHizQ72W0f1T9DvdLITtAOQJI83OAY=;
 b=TuG42fkuy88Q3UeW7Whh+RSOizuAgrviuHxDS0qE+ddFEewqCebFXHbkz+S+P1frGLNKQG+zo
 WQR55TDoXCVB8kprdkibc9qnE9ZSO1jTQdVHndEqWptWHWqG2mr+r8e
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX9UP5VtFMXOjI
 eUVu2OlGVaHUy8FcZpScuvjoPdkgaBztTivDBgvxtcoo+J11A3byoF83ZG4sa2HOGkRwXCQx5XZ
 BBCBmsVhv1M0Xg+DpKpjYyuu/kpKmTfpitOj8tNC1osKgz5Bgicg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX4ekx4/68jeuj
 dSH7yCDYf1JYcjAq4v7QCnTfD6IHx1/X2GO8ojtpoLrlckzgO0CToCMMnNw1cwwqt/nk4C737TV
 XqjkdzVQuv+FYbSkQsPyVCJ5YDncjSZcauf/xqSLEQWqPUzOLnHo2w3LbachKievYQ3iVDCZ7+s
 qQSnicny52W+tOaWzRJHNr1Dnf5g7vxIUiF/YZoZcZ7aWWOyC8ThTx4RI4eBQ+DnKinIvwsUEGn
 1RYALHgRfWPMBuUCvB6ElmIZLoBwfwJbr3aL2tUDgZMZzUQqn0ab+wbwaDXGlpnjXEg30siXQiO
 uOWqSBW/muQib58t20SOrmyzlwYWfMD+fdTOsmow1itWDQbh75iOSs/90PkJSNFIgfI5dkQZLDb
 1vHociFBpANhcrR9lkXk71xQS1mphIu3NI+x6+um5jQsxzO4NLYln+uc7TB/h5/l1pAv0Ci/mHd
 h/231fv5b5bzpRt8eeg==
X-Proofpoint-GUID: PR3Hp9d3QC2lvhDbNQcHg7IwJyJbXsz2
X-Proofpoint-ORIG-GUID: PR3Hp9d3QC2lvhDbNQcHg7IwJyJbXsz2
X-Authority-Analysis: v=2.4 cv=KKvPn1Fo c=1 sm=1 tr=0 ts=6aaa7a52 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=Ur4aSapJj9IWGj-igp0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 impostorscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

Expose the per-channel offset and gain calibration registers through the
IIO calibbias and calibscale attributes.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index bd0f5cdac187..e9462278a812 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -27,6 +27,7 @@
 #include <linux/spi/spi.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/units.h>
 
 #include <linux/iio/backend.h>
@@ -103,6 +104,8 @@
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
+#define AD7768_CALIB_SIGN_BIT				23
+#define AD7768_CALIB_REG_MSK				GENMASK(AD7768_CALIB_SIGN_BIT, 0)
 #define AD7768_WIDEBAND_SETTLING_SAMPLES		68
 #define AD7768_SINC5_SETTLING_SAMPLES			7
 
@@ -246,6 +249,18 @@ static void ad7768_keep_xtal_channel_active(const struct ad7768_state *st,
 		__clear_bit(st->chip_info->num_channels / 2, standby_mask);
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
@@ -376,6 +391,67 @@ static const struct regmap_config ad7768_4_regmap_config = {
 	.readable_reg = ad7768_4_readable_reg,
 };
 
+static unsigned int ad7768_get_calib_reg_base(struct ad7768_state *st,
+					      const struct iio_chan_spec *chan,
+					      bool is_gain)
+{
+	if (is_gain)
+		return ad7768_gain_reg(st, chan->channel);
+
+	return ad7768_offset_reg(st, chan->channel);
+}
+
+static int ad7768_read_calib_value(struct ad7768_state *st,
+				   unsigned int base_reg, bool is_signed,
+				   int *val)
+{
+	unsigned int regval;
+	u8 data[3];
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	ret = regmap_bulk_read(st->regmap, base_reg, data, sizeof(data));
+	if (ret)
+		return ret;
+
+	regval = get_unaligned_be24(data);
+	*val = is_signed ? sign_extend32(regval, AD7768_CALIB_SIGN_BIT) : regval;
+
+	return 0;
+}
+
+static int ad7768_write_calib_value(struct ad7768_state *st,
+				    unsigned int base_reg, bool is_signed,
+				    int val)
+{
+	u8 data[3];
+	int ret;
+
+	if (is_signed &&
+	    val != sign_extend32(val, AD7768_CALIB_SIGN_BIT))
+		return -EINVAL;
+
+	if (!is_signed && (val < 0 || val > AD7768_CALIB_REG_MSK))
+		return -EINVAL;
+
+	put_unaligned_be24(val, data);
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&st->lock);
+
+	return regmap_bulk_write(st->regmap, base_reg, data, sizeof(data));
+}
+
 static int ad7768_reg_access(struct iio_dev *indio_dev,
 			     unsigned int reg,
 			     unsigned int writeval,
@@ -818,6 +894,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -828,6 +905,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	}
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE: {
+		bool is_gain = info == IIO_CHAN_INFO_CALIBSCALE;
+		unsigned int base_reg;
+
+		base_reg = ad7768_get_calib_reg_base(st, chan, is_gain);
+		ret = ad7768_read_calib_value(st, base_reg, !is_gain, val);
+		if (ret)
+			return ret;
+
+		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -836,24 +926,39 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
 			    struct iio_chan_spec const *chan,
 			    int val, int val2, long info)
 {
+	struct ad7768_state *st = iio_priv(indio_dev);
+	unsigned int base_reg;
+
 	IIO_DEV_ACQUIRE_DIRECT_MODE(indio_dev, claim);
 	if (IIO_DEV_ACQUIRE_FAILED(claim))
 		return -EBUSY;
 
-	if (info == IIO_CHAN_INFO_SAMP_FREQ)
+	switch (info) {
+	case IIO_CHAN_INFO_SAMP_FREQ:
 		return ad7768_set_sampling_freq(indio_dev, val, chan->channel);
-
-	return -EINVAL;
+	case IIO_CHAN_INFO_CALIBBIAS:
+		base_reg = ad7768_get_calib_reg_base(st, chan, false);
+		return ad7768_write_calib_value(st, base_reg, true, val);
+	case IIO_CHAN_INFO_CALIBSCALE:
+		base_reg = ad7768_get_calib_reg_base(st, chan, true);
+		return ad7768_write_calib_value(st, base_reg, false, val);
+	default:
+		return -EINVAL;
+	}
 }
 
 static int ad7768_read_avail(struct iio_dev *indio_dev,
@@ -1055,6 +1160,8 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 		chan[chan_idx++] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+					      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

