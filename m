Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F33B44AA59E;
	Fri,  4 Sep 2026 14:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531398; cv=none; b=SecNynpsTs5uHJCmJdZTZJss4Jt+uuQDxxGIdY+vcSAXLoTyyLdQXyWA1+csYys67qzK5uKHhM5XavvUM2ve8fNmN+zolGK7DFHWDEvclm2mTPQte4AjDlV+HJMac/BIq+qXZXiJ2OID8+Jvk1/96I5B1mn+gZuueYLbEGTkxFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531398; c=relaxed/simple;
	bh=+bkRCAOuQDP8epPKOploODHvIjeX3T2j4xF8qImqJ1U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WN7EsUsCiQLVaTsw4SLTs74r4/hkur75nrXC2u6couRySFNdOhyouCZgGzmPoqr4V+9fU3cHffND6oqExF8zJJlrklmg17VWlhwjnC5dLDfYT76WzgEDFoQRw2u1qyMCFQGgRTgctyvfwvCrkgHBTRI3JbsIYmWdkqNGaV5z9KY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=KJkoo79h; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="KJkoo79h"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684DfdSJ3552678;
	Fri, 4 Sep 2026 10:16:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=XbnfY
	tRTrcWhuyIelNIllAosrm6xnxnGXwUgzoDGPnc=; b=KJkoo79h8QrfMgyycXisP
	avnn8Lc59agc1yn60DOD6NJna4l2aLD2b7SmiAq6tiSPH3C07Yqu1B9KCV/r9LuL
	CxvpUfWlDVbdoNzV1FrX9vwJ8wAWwDlR4qKx2ynQmS1Gb9EN9IAjV+P/kNwT3j1I
	LlGQpF1n2r+6jyWtKOTW7xBdtWHN1e9MpMKA7DV+UjJaKIret0sXvwdtkvubBHQG
	+EDzPnIe9m7Jnn4NjSCNWDbTYIC1TfmE6/0oBMJf8mLTTFZbF663fWji0MLiW3JQ
	PvSfFmW+qY/YMYE0FUBmeUhmyUFfZ/vnelDrfCuo6EngInq2LafWD4gAROkqQc4K
	A==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gftu3smpt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:14 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EGDKN036371
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:13 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 4 Sep
 2026 10:16:12 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:12 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dH026210;
	Fri, 4 Sep 2026 10:16:05 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:05 +0200
Subject: [PATCH v6 13/17] iio: adc: ad7768: Add calibration controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-13-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=5753;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=+bkRCAOuQDP8epPKOploODHvIjeX3T2j4xF8qImqJ1U=;
 b=P8hI2ijfkmbL5HxWND+NhoreycaYqunF2lRX0l9JmqVJC2JQghgupFSVuQg6a7qH1/phynvAx
 dDe1WNF6uXwDPARSkrpBqVULrQpoC0xMqIPudEoxRarUPTanWhEFhkq
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R6wz39RX c=1 sm=1 tr=0 ts=6a9ad2ae cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=-8FhGxT0-ylaBreVXV0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfXy5SE8zXuRFK2
 81UN/9K0ad66rLQVKRBjVyQ/JBvKHMdzq0W3i2X19U6CgVWIpeIyweuzD9ql1Con6DkFoS/ej0x
 9MnNOyNcQzx/4tQMQ1c14/RU3gtXaUgblCM3ueBf0XTKTp+iDra5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX/xjl4HNDLbLR
 cU2cxPoK9tFAxph5NClEYombVCxsLZymoHSOqCCktMAnaMkTYDSb4BuUbYxmbfZGngqLCsEXT1l
 VLymoN4auj/QsFmcY+1hjXX7+R4eW6xTMM4YVBxjOa8OllnFX7GJG9VI0BA0p+//Im/Vbcgsgsy
 lpaBrONLphnCPLwF6OaMY9DTryEQ4jeE4/iLJGCtK1g4pFiQeY8JwhWa14W2seMOWTDeM5jeVot
 ZzsWzGx4dBeeUeRdzliurwhDRnkc5cFwthJ2+vYYxzDUosycPmgflhEY63zBtflmp+bvmdhcREd
 zY9+QqvD2UBX5qswUChVf2w5qzEoqupeuOsD9+PZJhgwL4TICGrqHTE5HNfBQ93/rcjyrRUA6Q8
 FSQdFyt8Pec1bkyNsHDyls3jbgH37nrDEv7zdDVPTTu08aVoHM6pqb6u5MaJH5yK8v5H/JfjB0p
 YJWtc99fEVrpxM05a7w==
X-Proofpoint-GUID: SdNwhzgBSV_KK-Lb14RpjTWvlvfeHjoa
X-Proofpoint-ORIG-GUID: SdNwhzgBSV_KK-Lb14RpjTWvlvfeHjoa
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Expose the per-channel offset and gain calibration registers through the
IIO calibbias and calibscale attributes.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 116 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 111 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index f2c762688fb3..802666f7abd4 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -27,6 +27,7 @@
 #include <linux/spi/spi.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/units.h>
 
 #include <linux/iio/backend.h>
@@ -107,6 +108,7 @@
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
+#define AD7768_CALIB_REG_MSK				GENMASK(23, 0)
 #define AD7768_WIDEBAND_SETTLING_SAMPLES		68
 #define AD7768_SINC5_SETTLING_SAMPLES			7
 
@@ -232,6 +234,18 @@ static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
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
@@ -359,6 +373,59 @@ static const struct regmap_config ad7768_4_regmap_config = {
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
+				   unsigned int base_reg, unsigned int *val)
+{
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
+	*val = get_unaligned_be24(data);
+
+	return 0;
+}
+
+static int ad7768_write_calib_value(struct ad7768_state *st,
+				    unsigned int base_reg, unsigned int val)
+{
+	u8 data[3];
+	int ret;
+
+	if (val > AD7768_CALIB_REG_MSK)
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
@@ -798,6 +865,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -808,6 +876,21 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	}
+
+	case IIO_CHAN_INFO_CALIBBIAS:
+	case IIO_CHAN_INFO_CALIBSCALE: {
+		bool is_gain = info == IIO_CHAN_INFO_CALIBSCALE;
+		unsigned int base_reg;
+		unsigned int calib;
+
+		base_reg = ad7768_get_calib_reg_base(st, chan, is_gain);
+		ret = ad7768_read_calib_value(st, base_reg, &calib);
+		if (ret)
+			return ret;
+
+		*val = calib;
+		return IIO_VAL_INT;
+	}
 	default:
 		return -EINVAL;
 	}
@@ -816,24 +899,45 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -1045,6 +1149,8 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 		chan[chan_idx] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
 			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+					      BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

