Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E810D4052B1;
	Thu, 13 Aug 2026 23:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786662332; cv=none; b=P8/0nhavGs4wcKWmHOmAyL5KNZxOelhTagohIF+fQ6/J4/g2Px2UMU1R3ZT1wZMq0pvyF0521ryf/wAXAmJCh1JZVWOeKoKW7wghttmgvdU4vekGtKDw+lfpLfFExunuYOLWAa8mITmCnd6tYtkGc4gG7AUCEpQ4VrDaz2vxe7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786662332; c=relaxed/simple;
	bh=e2EX3Qe+h7gXqJVNEBiBF24ePtr3pPxqZo0WguZ3a/s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I8RRHwmu5+4E2BImXhXWEEboGX9eBzD8Iib2Y9+0gwulzp0sfNjSStByv0l8meG+eqWpH93oO+thc4En+qgy2HResoIiE+XQ/DyXBI7UV456JY7cc5TFBjBXwxf2Ky/eFmPZcLMLUxN9icJeWC0PoWU43LVZghYzmzT1OYJwFrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=u8WtbBUp; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="u8WtbBUp"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DLd3B22531250;
	Thu, 13 Aug 2026 19:05:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=9F0Px
	/oJoIosN4Ro8xdWH4fLGjK8lSTM6KS5BlJEbTo=; b=u8WtbBUpEkNnuGPyDx+d7
	WC+BhScSd4jMXhJ4VP+yBxvg5WA/JbbeQYHdX2fik6B8tuifa3mE0l8oXBK7AfH4
	Vt+2Nqy5ABfVVcz7DRXUF27WM3ugWkRuyOuEaA8j6EBE20uaLhBTyPwbivwyR0K+
	gxHUWfgIfM9DzNPz8keh6CTJlzTqggLHjE6YgXrOWbrYlraQ2ezTGUO0M2+M548E
	cYoOXpeijMYY7/V8ZabqgSHW3csqUVF83K+tNlYjzrAMrZJk62fIukOsO0Kfb8nF
	muWplYbs8PsN10DbDv9AE48OvWynUdyaGa2vrt+sj2qghjxL9+z6LHfN7mpxLB8b
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e1nams4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 19:05:27 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DN5QvJ031484
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 19:05:26 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 19:05:25 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 13 Aug 2026 19:05:25 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 19:05:25 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DN5DTq025420;
	Thu, 13 Aug 2026 19:05:16 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v10 1/2] iio: adc: ltc2378: Add support for LTC2338-18
Date: Thu, 13 Aug 2026 20:05:07 -0300
Message-ID: <8b0d2e34163b85634266be3b9dd8f76697c89bd2.1786661484.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1786661484.git.marcelo.schmitt@analog.com>
References: <cover.1786661484.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDE2OSBTYWx0ZWRfXxJ169Akk/RmQ
 ikIRfLQEhnEF6WcG79rgVUoqoayEayjQSIG8oDKIOs2ykcDbqzT2qK883ucmmGygkI/niG3K2go
 JuZBoYnYHAGHHyoBTliwmSpSiilYx1g4e3VKoBan6PdsUPYAmIK2EXpJ1dGcXESxPItUrrRD83Z
 dQcIJcitSPy6PLemjZ4lxBes3QLHs1qGCE+c5wLT0qV5eR5f8QAHVqaS2ErifuVFMy1yukMnUAz
 N3AHAq9QYnCjMo3LlAharp8bVBrK144xp2pgOPRAo9D71unF2AjidX1Ud6qGAFCf2GCzNfHM0OH
 jZy+yMROEvgLR4gqQRoE2auFaERRxKF0MS/ht6Zb7zvXzuPend12Bq35LF+HOvLHzaDBV37hwLp
 cIAwTnhKND9X6+tAb+jAWHbHSrFiO+mWh+aiW7NFg1mEYnklNCPd6uPCDUWKfZ1lRJIkmDor7r5
 WcScZp23D6nJkTh0NWg==
X-Proofpoint-ORIG-GUID: w5bT8M7MkmlJxxIF2MZG82MJ_miZ-tLt
X-Proofpoint-GUID: w5bT8M7MkmlJxxIF2MZG82MJ_miZ-tLt
X-Authority-Analysis: v=2.4 cv=fLoJG5ae c=1 sm=1 tr=0 ts=6a7e4db7 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=4nAW5gtI2-J5lNiwDswA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDE2OSBTYWx0ZWRfXwEU6lu/PsZLH
 mFX0Ponuflb/DkHIpnn7lrnPNfUBVW96/aONRtf1x34bZtoKS0+5uHO1Bu3PCL87kzm6E4VoINg
 nblaPVe8wuSde/x/QWGYJFNOIaSfXKbDv6/rq01neJAs/YEz3oMO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_07,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130169

LTC2338-18 is similar to LTC2378-18, differentiating from the already
supported part mainly on the embedment of an internal voltage reference and
addition of a resistor divider network connected to the input signal path.
Extend the device driver, handling the internal reference and input signal
attenuation, enabling it to also support LTC2338-18.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
Change log v9 -> v10:
- Added {} to make local variable at top of code block scope.
- if-else code neat.

 drivers/iio/adc/ltc2378.c | 44 +++++++++++++++++++++++++++++++++++++--
 1 file changed, 42 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 146eaadbeb6c..74ac6b8cb7c4 100644
--- a/drivers/iio/adc/ltc2378.c
+++ b/drivers/iio/adc/ltc2378.c
@@ -107,6 +107,8 @@
 
 struct ltc2378_chip_info {
 	const char *name;
+	unsigned int internal_ref_uV;
+	struct u32_fract internal_div;
 	struct iio_chan_spec chan[2]; /* 1 physical chan + 1 timestamp chan */
 	struct iio_chan_spec offload_chan;
 	unsigned int max_sample_rate_Hz;
@@ -145,6 +147,16 @@ struct ltc2378_state {
 	} scan __aligned(IIO_DMA_MINALIGN);
 };
 
+static const struct ltc2378_chip_info ltc2338_18_chip_info = {
+	.name = "ltc2338-18",
+	.internal_ref_uV = 2048000,
+	.internal_div = { .numerator = 5, .denominator = 2 },
+	.chan = { LTC2378_DIFF_CHANNEL(18), IIO_CHAN_SOFT_TIMESTAMP(1) },
+	.offload_chan = LTC2378_OFFLOAD_DIFF_CHANNEL(18),
+	.max_sample_rate_Hz = 1 * HZ_PER_MHZ,
+	.tconv_ns = 527,
+};
+
 static const struct ltc2378_chip_info ltc2364_16_chip_info = {
 	.name = "ltc2364-16",
 	.chan = { LTC2378_PSEUDO_DIFF_CHANNEL(16), IIO_CHAN_SOFT_TIMESTAMP(1) },
@@ -382,8 +394,11 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 
 		return IIO_VAL_INT;
 	}
-	case IIO_CHAN_INFO_SCALE:
+	case IIO_CHAN_INFO_SCALE: {
+		struct u32_fract fract = st->info->internal_div;
 		*val = st->ref_uV / MILLI;
+		if (fract.numerator && fract.denominator)
+			*val = mult_frac(*val, fract.numerator, fract.denominator);
 		/*
 		 * For all LTC2378-like devices, the amount of bits that express
 		 * voltage magnitude depend on the polarity / output code format:
@@ -396,6 +411,7 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 			*val2 = chan->scan_type.realbits;
 
 		return IIO_VAL_FRACTIONAL_LOG2;
+	}
 	case IIO_CHAN_INFO_SAMP_FREQ:
 		*val = st->cnv_Hz;
 		return IIO_VAL_INT;
@@ -641,6 +657,25 @@ static const struct spi_offload_config ltc2378_offload_config = {
 			    SPI_OFFLOAD_CAP_RX_STREAM_DMA,
 };
 
+static int ltc2378_refin_setup(struct device *dev, struct ltc2378_state *st)
+{
+	int ret;
+
+	/*
+	 * The internal reference buffer amplifies both the internal reference
+	 * and REFIN by a factor of 2.
+	 */
+	ret = devm_regulator_get_enable_read_voltage(dev, "refin");
+	if (ret == -ENODEV) /* refin is optional */
+		st->ref_uV = st->info->internal_ref_uV * 2;
+	else if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
+	else
+		st->ref_uV = ret * 2;
+
+	return 0;
+}
+
 static int ltc2378_ref_setup(struct device *dev, struct ltc2378_state *st)
 {
 	int ret;
@@ -676,7 +711,10 @@ static int ltc2378_probe(struct spi_device *spi)
 	if (!st->info)
 		return -EINVAL;
 
-	ret = ltc2378_ref_setup(dev, st);
+	if (st->info->internal_ref_uV)
+		ret = ltc2378_refin_setup(dev, st);
+	else
+		ret = ltc2378_ref_setup(dev, st);
 	if (ret)
 		return ret;
 
@@ -750,6 +788,7 @@ static int ltc2378_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ltc2378_of_match[] = {
+	{ .compatible = "adi,ltc2338-18", .data = &ltc2338_18_chip_info },
 	{ .compatible = "adi,ltc2364-16", .data = &ltc2364_16_chip_info },
 	{ .compatible = "adi,ltc2364-18", .data = &ltc2364_18_chip_info },
 	{ .compatible = "adi,ltc2367-16", .data = &ltc2367_16_chip_info },
@@ -774,6 +813,7 @@ static const struct of_device_id ltc2378_of_match[] = {
 MODULE_DEVICE_TABLE(of, ltc2378_of_match);
 
 static const struct spi_device_id ltc2378_spi_id[] = {
+	{ .name = "ltc2338-18", .driver_data = (kernel_ulong_t)&ltc2338_18_chip_info },
 	{ .name = "ltc2364-16", .driver_data = (kernel_ulong_t)&ltc2364_16_chip_info },
 	{ .name = "ltc2364-18", .driver_data = (kernel_ulong_t)&ltc2364_18_chip_info },
 	{ .name = "ltc2367-16", .driver_data = (kernel_ulong_t)&ltc2367_16_chip_info },
-- 
2.53.0

