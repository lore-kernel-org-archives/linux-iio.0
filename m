Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.135.77
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793981158;
	b=0TULnJU+QCqUe7H2il1W7D6ocTJDjjWfG6kPbT6i4YY89wFn2axjht0qbDOmasrX4H8h
	 RpFxUjBpAqrW/l+MH7OEuR1+Q5tF6GZ/O2Z2O08gykWbbraAFthEqJ4PCBq90hJg07cBn
	 H+sx32T9eOktFNFskjJEDIJlFTj8upvsn2Rnx89FBI3a599Li+2NQ0pVbdyYPxit6pq8N
	 xxsSr8tHftyvNmpU+43OdtkJzU00Ej92yvbzYiHRYuzB+oEx5I5ET016Uvda1jpbBNX9u
	 TDpYJKdEVC3tp/O3RMaoAStX0c81jeH751OtBL8RDmEQl6Mzzp2F4DmOhy0IoH02Jog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793981158;
	h=DMARC-Filter:Received:DKIM-Signature:DKIM-Signature:Received:
	 Received:Received:Received:Received:Received:From:To:CC:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-ADIRuleOP-NewSCL:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=CdPyxSX2vgtOg7hrcN7yAmZa7qdHwilUVb2ZJdItH8Y=;
	b=qfCZeOpUhXN825eT/TyDEToRGS+hz/X/QV3iRcyFRiBDAfwk4kehqCjoS6VXBzHmFjzL
	 f3o1ZoO2r9WgVMTOIaywWaLyXdFPHUCXCyyw8sSe4yZ2MePW+xSghJvuWbyD9vRpvH7F6
	 V1dylntnDW7ZYnKNi0Pk+umMqZn4B6UAT2DG3NxP7uYNnWZMTjVYs975Mj7oXj7aZNpel
	 /dGUX2+3fv3O51g0xvQpK7V8Wau+R/P/8f3Fn93JatkuIPilq1OVADJP6yAnHsLCXLDsC
	 z37YKd58R/atZU3Bfk5O68FpY7YuIGZfDq5blZCjN+YRMz4FiwNDxxo9AdlB+2nKWeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=analog.com;
	spf=pass smtp.mailfrom=analog.com;
	dkim=pass header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=fq00DSX+;
	dkim=pass header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=rxF6qztb;
	arc=none smtp.remote-ip=148.163.135.77
Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D3606A32F;
	Fri,  6 Nov 2026 16:05:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0C5D3606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=vtelectron.com header.i=@vtelectron.com header.a=rsa-sha256 header.s=DKIM header.b=fq00DSX+;
	dkim=pass (2048-bit key, unprotected) header.d=analog.com header.i=@analog.com header.a=rsa-sha256 header.s=DKIM header.b=rxF6qztb
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A6F4FAX3366340;
	Fri, 6 Nov 2026 11:05:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vtelectron.com;
	 h=cc:content-transfer-encoding:content-type:date:from
	:in-reply-to:message-id:mime-version:references:subject:to; s=
	DKIM; bh=CdPyxSX2vgtOg7hrcN7yAmZa7qdHwilUVb2ZJdItH8Y=; b=fq00DSX
	+181pwaB4w8wqapun2jhDVVMXq81nmvJN4zTrh/7C8eZUJRqko2tfVU0Ls3gHroN
	JEBwX0XuXgpmMZx69zqq2CFqw2NI9jK9av2gc3xOCBSZGtiUv6xBzphyZ9WHqOeQ
	8p7CGIiBM6x2aRn1evOV6GKz2cB8O6L+/XYjbxuITRy35aQjbuR2ONpuHX0ubPYp
	JlWm397R5uBnFkurnZmoJnTy7RB+ttpXrlechmETpnnONNE7T1XJJDnZVunXh4F8
	Sldm95FTJdCUiuu/4ua7t3dCQseOI663rQhwrxYessxons2Mcak4qDmieT7xSbRi
	eiSCbkrbq5xFaKg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CdPyx
	SX2vgtOg7hrcN7yAmZa7qdHwilUVb2ZJdItH8Y=; b=rxF6qztb7QJ3RkPjJOG4h
	PbfyuiWc7CLRZlCBLGz4awFT3K83KCR6+OZFJlNgjTCWfeDT7isWfeFETbkMlKQQ
	khPcTocSZ7hGmigE+TdoOzRMM3m9rsMPnr/aWtjfmqibUP1K1AYsRY2cWkLz6oyk
	7IhrPy2Fg+Svm7TTqmIeI+9Bogbs5g6SVISErgODJEJ1bT2aJIPyQuOgyxhgimWC
	MoG9Gw1zO2Qi2iS2r29MTdAdeUSLWZoTSv8VOmJjV6vUBa27pONb3GLN1OP0oE0P
	BxxloS0IBVTGNJ6a+hxyKy9SM3VpowP0D8GLze4o0EWjwJdXDjD49nyLgSd0Qnn9
	g==
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4hs3qad00n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Nov 2026 11:05:54 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 6A6G5rrE052474
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 6 Nov 2026 11:05:53 -0500
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:53 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 6 Nov 2026 11:05:53 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 6 Nov 2026 11:05:53 -0500
Received: from arch ([10.135.2.92])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 6A6G5TDL016340;
	Fri, 6 Nov 2026 11:05:45 -0500
From: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
To: Jonathan Cameron <jic23@kernel.org>
CC: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <ukleinek@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Rob Herring
	<robh@kernel.org>, David Lechner <dlechner@baylibre.com>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
        Andy Shevchenko
	<andy@kernel.org>,
        Michael Hennerich <michael.hennerich@analog.com>,
        "Trevor
 Gamblin" <tgamblin@baylibre.com>,
        Joshua Crofts <crofts@kernel.org>,
        "Sergiu
 Cuciurean" <sergiu.cuciurean@analog.com>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Nicolae-Daniel
 Deaconescu" <Nicolae-daniel.Deaconescu@analog.com>
Subject: [PATCH v3 4/7] iio: adc: ad7625: use standard unit names
Date: Fri, 6 Nov 2026 18:05:16 +0200
Message-ID: <20261106160529.876251-5-Nicolae-daniel.Deaconescu@analog.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
References: <20261106160529.876251-1-Nicolae-daniel.Deaconescu@analog.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfX+2nXN4g0kc1n
 3Ou0G3ZiEoN1vQ/mdWMMbJyLE2RnLXaE/fAwbuZp8/SxCX1tZ4mm6QlwD1aswQXIN/bRN6h+Qvo
 gClhPM0ZApnnCuBa00y+3oktR1sJZEr8gN5VNwHNqZEEj7VyB0XfIgwln7STGQQABVawOuJEiWm
 +q+eSW61g8ZCSZGf6y8cqtBGr0vJV5wxwP6NNzGWS8srJufyzYlwNWkVbt3L/nyC3m15hfYq8sz
 iRWc2IJugJpAcsuIcJ2t+8wSAG3TPf49/FDrxJUt21jDyUHwKdYUDl7+TOroZOcmP04yskxyfEG
 s4QZdcXNDE/BZX02m3YMoSa99UilfWxso2DrJUXfWSUyPt3BYNOSSV8WcAFvtTJg0ttfQS76Tq/
 XSJad9WV7RgEyMcfE90m4Nj0an77LmnQcgM63e2hnsPXxu09wa5KKJTkqU6grqUZrh73ylk3ocz
 S7GpyFGuZ5oqEHFpbKw==
X-Proofpoint-GUID: F0H4tfnqIW-IF9nVnuD8QED8kv5mtNSU
X-Authority-Analysis: v=2.4 cv=NbBzRGD4 c=1 sm=1 tr=0 ts=6aedfae2 cx=c_pps
 a=PpDZqlmH/M8setHirZLBMw==:117 a=PpDZqlmH/M8setHirZLBMw==:17
 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=qmoc8CyE3JTOV2GcCtoA:9
X-Proofpoint-ORIG-GUID: F0H4tfnqIW-IF9nVnuD8QED8kv5mtNSU
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA2MDA2MyBTYWx0ZWRfXz08Qid97NDJr
 p9lWASZ4Zm1rupKdkHVumqf3cLXS9nT5FFwK3WQYry2Qw5CbTlFb9fCw8TJqu+eUx0/kq1qzRx/
 q+yQM4IvVknviFzV9bMFp1AcMFln2yyWmo6NxwMNTxriPPPkhlBp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-06_05,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611060063

Use standard unit spelling and macros in existing code:

- Rename vref_mv to vref_mV and ref_mv to ref_mV, spelling the voltage unit
  as mV.
- Use HZ_PER_MHZ instead of MEGA for frequencies.
- Use MICRO / MILLI instead of 1000 to convert the reference voltage from
  uV to mV.

No behaviour change.

Signed-off-by: Nicolae-Daniel Deaconescu <Nicolae-daniel.Deaconescu@analog.com>
---
 drivers/iio/adc/ad7625.c | 46 ++++++++++++++++++++--------------------
 1 file changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/iio/adc/ad7625.c b/drivers/iio/adc/ad7625.c
index ade2f2368bd8..e699a7023b02 100644
--- a/drivers/iio/adc/ad7625.c
+++ b/drivers/iio/adc/ad7625.c
@@ -24,7 +24,7 @@
 #include <linux/units.h>
 
 #define AD7625_INTERNAL_REF_MV 4096
-#define AD7960_MAX_NBW_FREQ (2 * MEGA)
+#define AD7960_MAX_NBW_FREQ (2 * HZ_PER_MHZ)
 
 struct ad7625_timing_spec {
 	/* Max conversion high time (t_{CNVH}). */
@@ -76,7 +76,7 @@ struct ad7625_state {
 	 */
 	struct pwm_waveform clk_gate_wf;
 	struct pwm_waveform cnv_wf;
-	unsigned int vref_mv;
+	unsigned int vref_mV;
 	u32 sampling_freq_hz;
 	/*
 	 * Optional GPIOs for controlling device state. EN0 and EN1
@@ -126,7 +126,7 @@ static const struct ad7625_timing_spec ad7960_timing_spec = {
 
 static const struct ad7625_chip_info ad7625_chip_info = {
 	.name = "ad7625",
-	.max_sample_freq_hz = 6 * MEGA,
+	.max_sample_freq_hz = 6 * HZ_PER_MHZ,
 	.timing_spec = &ad7625_timing_spec,
 	.chan_spec = AD7625_CHAN_SPEC(16),
 	.has_power_down_state = false,
@@ -136,7 +136,7 @@ static const struct ad7625_chip_info ad7625_chip_info = {
 
 static const struct ad7625_chip_info ad7626_chip_info = {
 	.name = "ad7626",
-	.max_sample_freq_hz = 10 * MEGA,
+	.max_sample_freq_hz = 10 * HZ_PER_MHZ,
 	.timing_spec = &ad7626_timing_spec,
 	.chan_spec = AD7625_CHAN_SPEC(16),
 	.has_power_down_state = true,
@@ -146,7 +146,7 @@ static const struct ad7625_chip_info ad7626_chip_info = {
 
 static const struct ad7625_chip_info ad7960_chip_info = {
 	.name = "ad7960",
-	.max_sample_freq_hz = 5 * MEGA,
+	.max_sample_freq_hz = 5 * HZ_PER_MHZ,
 	.timing_spec = &ad7960_timing_spec,
 	.chan_spec = AD7625_CHAN_SPEC(18),
 	.has_power_down_state = true,
@@ -156,7 +156,7 @@ static const struct ad7625_chip_info ad7960_chip_info = {
 
 static const struct ad7625_chip_info ad7961_chip_info = {
 	.name = "ad7961",
-	.max_sample_freq_hz = 5 * MEGA,
+	.max_sample_freq_hz = 5 * HZ_PER_MHZ,
 	.timing_spec = &ad7960_timing_spec,
 	.chan_spec = AD7625_CHAN_SPEC(16),
 	.has_power_down_state = true,
@@ -239,7 +239,7 @@ static int ad7625_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_SCALE:
-		*val = st->vref_mv;
+		*val = st->vref_mV;
 		*val2 = chan->scan_type.realbits - 1;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
@@ -346,12 +346,12 @@ static int ad7625_parse_mode(struct device *dev, struct ad7625_state *st,
 
 /* Set EN1 and EN0 based on reference voltage source */
 static void ad7625_set_en_gpios_for_vref(struct ad7625_state *st,
-					 bool have_refin, int ref_mv)
+					 bool have_refin, int ref_mV)
 {
-	if (have_refin || ref_mv == 5000) {
+	if (have_refin || ref_mV == 5000) {
 		gpiod_set_value_cansleep(st->en_gpios[1], 0);
 		gpiod_set_value_cansleep(st->en_gpios[0], 1);
-	} else if (ref_mv == 4096) {
+	} else if (ref_mV == 4096) {
 		gpiod_set_value_cansleep(st->en_gpios[1], 1);
 		gpiod_set_value_cansleep(st->en_gpios[0], 0);
 	} else {
@@ -365,7 +365,7 @@ static void ad7625_set_en_gpios_for_vref(struct ad7625_state *st,
 }
 
 static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
-			   bool have_refin, int ref_mv)
+			   bool have_refin, int ref_mV)
 {
 	switch (mode) {
 	case AD7960_MODE_POWER_DOWN:
@@ -392,7 +392,7 @@ static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
 			return -EINVAL;
 
 		gpiod_set_value_cansleep(st->en_gpios[2], 1);
-		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mV);
 
 		return 0;
 
@@ -401,7 +401,7 @@ static int ad7960_set_mode(struct ad7625_state *st, enum ad7960_mode mode,
 			return -EINVAL;
 
 		gpiod_set_value_cansleep(st->en_gpios[2], 0);
-		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mv);
+		ad7625_set_en_gpios_for_vref(st, have_refin, ref_mV);
 
 		return 0;
 
@@ -517,7 +517,7 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 				       struct ad7625_state *st)
 {
 	static const char * const regulator_names[] = { "vio", "vdd2", "vdd1" };
-	int ret, ref_mv;
+	int ret, ref_mV;
 
 	ret = devm_regulator_bulk_get_enable(dev, ARRAY_SIZE(regulator_names),
 					     regulator_names);
@@ -528,7 +528,7 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 	if (ret < 0 && ret != -ENODEV)
 		return dev_err_probe(dev, ret, "failed to get REF voltage\n");
 
-	ref_mv = ret == -ENODEV ? 0 : ret / 1000;
+	ref_mV = ret == -ENODEV ? 0 : ret / (MICRO / MILLI);
 
 	ret = devm_regulator_get_enable_optional(dev, "refin");
 	if (ret < 0 && ret != -ENODEV)
@@ -540,23 +540,23 @@ static int devm_ad7625_regulator_setup(struct device *dev,
 		return dev_err_probe(dev, -EINVAL,
 				     "REFIN provided in unsupported mode\n");
 
-	if (!st->info->has_internal_vref && !st->have_refin && !ref_mv)
+	if (!st->info->has_internal_vref && !st->have_refin && !ref_mV)
 		return dev_err_probe(dev, -EINVAL,
 				     "Need either REFIN or REF\n");
 
-	if (st->have_refin && ref_mv)
+	if (st->have_refin && ref_mV)
 		return dev_err_probe(dev, -EINVAL,
 				     "cannot have both REFIN and REF supplies\n");
 
-	if (ref_mv == 4096 && !st->can_ref_4v096)
+	if (ref_mV == 4096 && !st->can_ref_4v096)
 		return dev_err_probe(dev, -EINVAL,
 				     "REF is 4.096V in unsupported mode\n");
 
-	if (ref_mv == 5000 && !st->can_ref_5v)
+	if (ref_mV == 5000 && !st->can_ref_5v)
 		return dev_err_probe(dev, -EINVAL,
 				     "REF is 5V in unsupported mode\n");
 
-	st->vref_mv = ref_mv ?: AD7625_INTERNAL_REF_MV;
+	st->vref_mV = ref_mV ?: AD7625_INTERNAL_REF_MV;
 
 	return 0;
 }
@@ -597,7 +597,7 @@ static int ad7625_probe(struct platform_device *pdev)
 
 	/* Set the device mode based on detected EN configuration. */
 	if (!st->info->has_bandwidth_control) {
-		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mv);
+		ad7625_set_en_gpios_for_vref(st, st->have_refin, st->vref_mV);
 	} else {
 		/*
 		 * If neither sampling mode is available, then report an error,
@@ -605,10 +605,10 @@ static int ad7625_probe(struct platform_device *pdev)
 		 */
 		if (st->can_wide_bandwidth) {
 			ret = ad7960_set_mode(st, AD7960_MODE_WIDE_BANDWIDTH,
-					      st->have_refin, st->vref_mv);
+					      st->have_refin, st->vref_mV);
 		} else if (st->can_narrow_bandwidth) {
 			ret = ad7960_set_mode(st, AD7960_MODE_NARROW_BANDWIDTH,
-					      st->have_refin, st->vref_mv);
+					      st->have_refin, st->vref_mV);
 		} else {
 			return dev_err_probe(dev, -EINVAL,
 				"couldn't set device to wide or narrow bandwidth modes\n");
-- 
2.56.0

