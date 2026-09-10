Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3E5585974;
	Thu, 10 Sep 2026 17:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061901; cv=none; b=D0I7wDrV/Uh9jBj5NFQmNXmEo9VKzp7E+XTUx+TZhDIOg/1OulFu57xNgcLH88d7Bi7K144q24H/D1DTpp4NMXWCdruiU24gt0gqphD/yw8eLfcNp5AZzKBWRv0XElCvRKiLF+QxIuisXROxBKumnsnpHnh7QSS671kPaMDLJIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061901; c=relaxed/simple;
	bh=I1mKaxKEAyp9gq6cUp4BXfT/L8nwybmrRghZ9fu8iAQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=VqhrVF/M0rI0g9W+vAM5oS4aTKlRYjdiFXm+liQTPBtKAkwGWGEs9EJpAKxx53i/gxIB294VfLaRAeJP4gtMYgx1ZpL8vWwPIVUeMaKodiLhO7hKoIEnL4XcPNNStUC7tYXp4siAPWDdXNlRtubxQlcZB0nnucVlDVMVPfc4JQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=WK3HA12C; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="WK3HA12C"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF7OqY343068;
	Thu, 10 Sep 2026 13:37:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=w78ev
	UcMatvI7FlsI1/oc0c33SOPqEEJUfUZJXJOu80=; b=WK3HA12C1j9TOhBXvD2TS
	DRWr97htseMtWFQXeY5ldBkJXNQzhTJfAt3v2qDeaTrCbph3SfyYvwuVxR4LtBtr
	e4Sr82fB2uHUlfZs1XGsVFy4V0B0Zw40xMLFOj4oYSoVByIXAybETuUPTIKi4rhE
	0YiYspma4kJOAJP9Pj44GW9aaVDyGbYmwK4xfNiDB44IE9hsRX4jjKAA7XLwcUFt
	rJFD/VnukUUEF4LRyhy156e3jjkUckgKdvYbfoKCv4cnsIGMziWeduBjcFw5CT6x
	1SU52JlUjWnHziFqqM92+TGbqlxc7xmdpAa5TTXzAi3xcxZ+gqo6t5knMtvKuvYP
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcx9522e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:45 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbitJ038853
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:44 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:44 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 10 Sep 2026 13:37:44 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:44 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSj018832;
	Thu, 10 Sep 2026 13:37:35 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:31 +0200
Subject: [PATCH v7 13/17] iio: adc: ad7768: Add calibration controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-13-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=5912;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=I1mKaxKEAyp9gq6cUp4BXfT/L8nwybmrRghZ9fu8iAQ=;
 b=J3uPWNVUW95gFBtgk8CFHWtC4DGBro1hVHjorc+9lNx1tzGvRz1Fo1e7s9Sqn8JnF5cQ/mLyp
 EVv4lFrlSMEC4NBeV0pkv3WPFTp/bMgLhivAiC5lS4YW4HZdwsSHvDo
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX7P7kidUAmxtX
 cCKKwDOLf02UZPiKdI26Z7+JP7FHTf2fgaHo5J3FCAsZWogJLwOfVRiLfAQXWiQZplr5Cp3dgHB
 A6Ie1UZ+FxlJnyOcVPrO9vNlBFw4MyQuJW7LqCWuGeBGEEQg6UPJ
X-Proofpoint-GUID: MyU3YKvXrKpvBlDHBmZMpoRW3WNmWezC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX6mb0tlzRNHKL
 QaiGXdTtczLuhMTBBRrSR7GHtmnh+VnRX7OAoTQbILWYraQB6gSdXCX5Bj+6UgaLgAt9T25oEHo
 icDFTjSo2KtuOay6Vd5JadwtC5//yj5WOJiwVJ7dwTKiXp8TyJFQ6wfRT3ddkYP0DARIbNxH4Jc
 aWhfQ1OM9M1Iq/3JPMjr8OOK/5/3IBFuqVInZy9sNir6xzjmcFkmLkDVyToa9K/4Gddk4HHXk7z
 /BA5r7W7H6B/aQRzoFtoX7SGwhJHQUf36BrHDZx+EOcSiHztgnqyV6naE9eVN0235Xu+E+UkU5z
 d3sSOg5Q3q0kaCGMBqWBl+P2y7voZOEsOIfIdTmqVhCBaYvh1bOTfRlKG6P2t4u5SaHvUC/K2OH
 khOcDnLv11RcRLqnpTjezpf0B8K092ZSbTs2b29g6465PuVQhJ7R09bJW0JdaybCW/fC4ncCel9
 PR7AGiW0EYcC4MyS79Q==
X-Authority-Analysis: v=2.4 cv=G8CJgNk5 c=1 sm=1 tr=0 ts=6aa2eae9 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=u7vyrQcF4N0oJoUPIfgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: MyU3YKvXrKpvBlDHBmZMpoRW3WNmWezC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 adultscore=0 malwarescore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

Expose the per-channel offset and gain calibration registers through the
IIO calibbias and calibscale attributes.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 119 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 113 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 5d576fffad80..ab82355c839a 100644
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
 
@@ -234,6 +237,18 @@ static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
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
@@ -360,6 +375,67 @@ static const struct regmap_config ad7768_4_regmap_config = {
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
@@ -810,6 +886,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE:
@@ -820,6 +897,19 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
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
@@ -828,24 +918,39 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -1057,6 +1162,8 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
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

