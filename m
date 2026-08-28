Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FFF737C0F8;
	Fri, 28 Aug 2026 15:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931114; cv=none; b=U4cmJlsoFOrl8AzyM6lYsckfCzsVJa7MwI/pnKmnkvbdM1HznPS7Hm9W35lqvccUYHdJSSUlQO6mb1bULAOqiiJyGb8TSXz/+EW+pR1//FYrXCfe/RJ4el80MgliVaScqBCf235Tj9xOfOsTEZDlVFsyK83Xtage6iOeYTtsWs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931114; c=relaxed/simple;
	bh=PDpKIKpuoOju1+G0iJfiC7tTRiu7g4kVKJ4YoKykPVg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=q1lmdxuU5an119wlIHr+0m74cp3hhFTg1g6dj051UpzBlvvAVBXpWZfQuu5wBBA8Ev/JXXhqMmzcq+vm+X78BRWf0Rg8cLGnuxmsYmxx4+tyYiyrftS0lJaKN4yM22rRiwk/0TVAUewgidZ3JMhtQnu1OHrqyoM8QJaPd9Vobg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=rlWJ5yH6; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="rlWJ5yH6"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDVgLF1142281;
	Fri, 28 Aug 2026 11:31:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=iptxx
	fiof5wXV5iy//guzEve4pAycP/02/v7MLb5uYY=; b=rlWJ5yH65n8TXezAq1c5J
	c0lkJtsGesFMH3iXLx6x6WwHDGxhsk0GRCSMZSPxrzVYefyxkKY+NDew/RhmvwYB
	2mRH9eKL6Rk/m2grmJ2hCQYlzFdLLIYV++xCK/GGXOIYn8eSP4zEfkRTsen3kKkB
	UYnxrRIqFmhg56ouBt5zXUno4sMkacR2MQhb89nscD4vN9oGGRPAO7dJhMf4pqLf
	lwH6Lt9jQk+JK7tRDltKFqmhnO93rrYHBpBia9ID9nQ1eSk8h06aAHwYG9sAArdW
	usjHffofZwi4WnLnw6v1DYDs6HroTVVWo3qjw939YnvSwMjSQTJs2TioNtBs1Q3P
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gaj3cqj8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:31:43 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVgZo013190
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:42 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:42 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 28 Aug 2026 11:31:41 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:41 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3s031424;
	Fri, 28 Aug 2026 11:31:33 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:36 +0200
Subject: [PATCH v5 13/20] iio: adc: ad7768: Add calibration controls
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-13-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=5812;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=PDpKIKpuoOju1+G0iJfiC7tTRiu7g4kVKJ4YoKykPVg=;
 b=OJj1uJ4jyjQrUCvCZJT6aHnxjxZhI2MdjhsszllXvblHJvrdwhvXAveVwmA6j7Sn+1KLDZL1K
 tzudeosSg+MDf+OKXGHHNB4RlHFdgVJeGGAjKyM5aG7wgMr/pGUR2d5
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: iTHRNtDoHHs1MtUEI4DSVKfe17M-1uN2
X-Authority-Analysis: v=2.4 cv=erHvCIpX c=1 sm=1 tr=0 ts=6a91a9df cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=J7MwhgzI37q70DLThgYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iTHRNtDoHHs1MtUEI4DSVKfe17M-1uN2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX5l4Y2qloEUkY
 1aNRuEt8VrQEdhVnBb2vzvTQ0SowLUvBmzqt+8Phg6qAGZh7m3PCAQKnAyZHCqR/UkUkp14cgQC
 Li31T3S0HuNFRXGpzRszl/aPTSzjd6afkVG9jDangzW926NR2f1ptdVZjGBRRfvBmlYDUAuFcne
 PaegLBdzUVv2N7IguaPBvcEKvCHBNrQyhyRFh739rgY3/0XwSdLKTg5RGW320EDkkWlHofEMfsH
 TdYEOPwGfyhr/qRnYCyaOW5CAix1JQdx8n5KO6MM7BggBdZjZZDtXLUgVB6nPiZDy0h8nvalcxz
 sjAhKXJPCQStbdSKOEgprZjOKlVcZoko910TXHHkpK3t2LYUMrwOZppFElt9LJdIc8Wp+JvtKwA
 r5HKvjSrk+EE4u52OY8JexTXp37z9N/9I5NzVVOP1cXFsCO4HrBwfXtABtYuSxvLFbvPlX0vpxL
 0IJKU2tFZqMpSfCSaXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX/JPsszHGAJUj
 BrYPyJj2IGU6s2vHIJUc5X4Uug5r1pqfoQUwDgvlpjnArOyDykK3u2i6If6DqGzDh4zzpM8Z0F+
 4S72dWZ8CRT0eKZyFgtEx6xkxg9VV7RcVTtx++fPcVXqNffaaXB5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 bulkscore=0 spamscore=0
 suspectscore=0 malwarescore=0 adultscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Expose the per-channel offset and gain calibration registers through the
IIO calibbias and calibscale attributes.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 118 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 112 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 84b96b1fab09..f2f318ebf964 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -27,6 +27,7 @@
 #include <linux/spi/spi.h>
 #include <linux/time.h>
 #include <linux/types.h>
+#include <linux/unaligned.h>
 #include <linux/units.h>
 
 #include <linux/iio/backend.h>
@@ -112,6 +113,7 @@
 #define AD7768_MAX_FREQ_PER_MODE			6
 #define AD7768_MAX_CHANNEL				8
 #define AD7768_NUM_CHANNEL_MODES			2
+#define AD7768_CALIB_REG_MSK				GENMASK(23, 0)
 #define AD7768_WIDEBAND_SETTLING_SAMPLES		68
 #define AD7768_SINC5_SETTLING_SAMPLES			7
 
@@ -237,6 +239,18 @@ static u8 ad7768_all_standby_mask(const struct ad7768_state *st)
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
@@ -354,6 +368,59 @@ static const struct regmap_config ad7768_4_regmap_config = {
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
@@ -780,6 +847,7 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 			   int *val, int *val2, long info)
 {
 	struct ad7768_state *st = iio_priv(indio_dev);
+	int ret;
 
 	switch (info) {
 	case IIO_CHAN_INFO_SCALE: {
@@ -797,6 +865,21 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
 
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
@@ -805,24 +888,45 @@ static int ad7768_read_raw(struct iio_dev *indio_dev,
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
@@ -1035,7 +1139,9 @@ static int ad7768_parse_config(struct iio_dev *indio_dev,
 
 		chan[chan_idx] = (struct iio_chan_spec) {
 			.type = IIO_VOLTAGE,
-			.info_mask_separate = BIT(IIO_CHAN_INFO_SCALE) |
+			.info_mask_separate = BIT(IIO_CHAN_INFO_CALIBBIAS) |
+					      BIT(IIO_CHAN_INFO_CALIBSCALE) |
+					      BIT(IIO_CHAN_INFO_SCALE) |
 					      BIT(IIO_CHAN_INFO_SAMP_FREQ),
 			.info_mask_separate_available =
 				BIT(IIO_CHAN_INFO_SAMP_FREQ),

-- 
2.43.0

