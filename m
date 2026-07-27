Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2497C37DAD7;
	Mon, 27 Jul 2026 21:32:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785187942; cv=none; b=Kyz7k3ZrGjQoBBEI9mEQrxwLiVDXsHxZzBBidw01s3E6bhQY+Qnl47X6QFNGwS3ux9wtrTtliahpCZ/LWckTuUH07SPOD/RZwvVxcar1zCxWr5iP6iY+/mIwxwUu9DNXOlIg7n+TEMRxW/VHAFkDzMlMG4eaX2z2mSmoN5jfnjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785187942; c=relaxed/simple;
	bh=IOOT4jX5S/Otl3E8RCnO0yqcozZHb/2fKsFeAuMNGoc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kper1WbjegQqAPqQBkIfTfE+w75bUySfM+b8pC1cileUJMkZgya12uWMveQ6gXiOpBmFXn12ynME1PaRTu3MCUUEn6bBF79nDESm/C6saLwH/UPtpmR/o3Gwx9q5iKLByWIeE9LoFVZQHLxJflj3L3YmZFelNlxfVDmvIVDcqQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=J3cualYk; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="J3cualYk"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RIHE5i1173193;
	Mon, 27 Jul 2026 17:32:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=T+1Yi
	tY+V3LOzOy/rIU7smJ0CTKC/MJ01Hiqij/5phA=; b=J3cualYkvY9Inlk7GkEJW
	Qoc2nLkW6V+oYfjIYlV3iBTaPWogmlvNy3JYXgJ4snHmujCXU6yFsURaFmKhRafZ
	b0xqI2kw3p8pOD5vX3wWGlfDQ4uMAJhrZ6wWLLvTLOeOscMk7PgqcKXPRVZn1UV6
	6TlwePu1RhW2lNcZNVuZmwk0oaCl3SW7oWgYUrFoUS+Z6x1Y7ZU1dvCEPs4+RCsY
	dBiceY1PTulVdbRuooWtvabeYfquca0rfy1ozXy6SkipPS1bPFK/ykNcm6BIJcaA
	00yLxqKnNVeDmFIUem2cRZIgugNsLoLU9Fqu9mXytdRvneeW9h5q5yMUPikWRn7G
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fnefgf11y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 17:32:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 66RLWEox004067
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 27 Jul 2026 17:32:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Mon, 27 Jul
 2026 17:32:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 27 Jul 2026 17:32:14 -0400
Received: from work.maxim-ic.internal ([10.66.6.190])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 66RLW3AP017481;
	Mon, 27 Jul 2026 17:32:06 -0400
From: Marcelo Schmitt <marcelo.schmitt@analog.com>
To: <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <jic23@kernel.org>, <nuno.sa@analog.com>, <Michael.Hennerich@analog.com>,
        <dlechner@baylibre.com>, <andy@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <julianbraha@gmail.com>,
        <marcelo.schmitt1@gmail.com>
Subject: [PATCH v9 5/6] iio: adc: ltc2378: Add support for LTC2338-18
Date: Mon, 27 Jul 2026 18:31:58 -0300
Message-ID: <39f2ff86cf736ff97286d6451fcc45fdba6732f9.1785186980.git.marcelo.schmitt@analog.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1785186980.git.marcelo.schmitt@analog.com>
References: <cover.1785186980.git.marcelo.schmitt@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: tdFNQTSGv-tnOZWcA4wOytY_b1Ogr8_5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX+fr+gyuPT99H
 1vpppIR4pW9UPQ/x1lH6GzQF264PisP9Yk6h6zd6hzxWUD/N7DwGh05/wN05pUbjmV44NU81jQv
 Uig1UOMHXDjf30/xm6uYKVYj+Ss/ppxJVktBuZrq60LSWEmcZzQL
X-Proofpoint-ORIG-GUID: tdFNQTSGv-tnOZWcA4wOytY_b1Ogr8_5
X-Authority-Analysis: v=2.4 cv=Q8fiJY2a c=1 sm=1 tr=0 ts=6a67ce5f cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8 a=4nAW5gtI2-J5lNiwDswA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE5MyBTYWx0ZWRfX9D+WDY4Oo9pP
 exOU584F526xo4HTgor5JnsoSGLNh7St9Q2pfayB+1U6S6OOLGkuy7RfNi5lLcVcU1+vsSJfh2e
 LAbSJoIE2Y1tmAqcUFy5k10tqHV/AhCsF0KXbKVb4AE6TlGGPsAJRuEDAFPbl6GLLXQh/U0pDKG
 TsYHmNwF59aKeGvsD2fXhAB2Op2+FAwJjFWrtBTQ5053PBBJFyN57PH6F0ZD9iN8nEtE+zufhnt
 sNX6Npq+xFgsEI+TX6VSV1MnI1GKKFYRdA98Wjg6hjsj1QQrEss7ocn6WlvdiGni+Uz9+BSqXtW
 jf8HTVgwVlJCXwLAuolf9KwKEOLuKTn1HI5WL65iBREhLFH5CN3uJp20WZR0W5jZP5NF6hnR/QJ
 1gXR+4/aRWiMBIGpn96kVQAMiMam4IajOtGgVeeBPkilLp55Dx4zFj2C/nWWYyff/LYspOhlZib
 j1CEr0nZkVsBsMDir7g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_05,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 adultscore=0 spamscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 phishscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270193

LTC2338-18 is similar to LTC2378-18, differentiating from the already
supported part mainly on the embedment of an internal voltage reference and
addition of a resistor divider network connected to the input signal path.
Extend the device driver, handling the internal reference and input signal
attenuation, enabling it to also support LTC2338-18.

Signed-off-by: Marcelo Schmitt <marcelo.schmitt@analog.com>
---
New patch mainly extracted from the base driver patch with the addition of input
attenuation handling for LTC2338-18.

 drivers/iio/adc/ltc2378.c | 44 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ltc2378.c b/drivers/iio/adc/ltc2378.c
index 146eaadbeb6c..689fa5419faf 100644
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
@@ -383,7 +395,10 @@ static int ltc2378_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	}
 	case IIO_CHAN_INFO_SCALE:
+		struct u32_fract fract = st->info->internal_div;
 		*val = st->ref_uV / MILLI;
+		if (fract.numerator && fract.denominator)
+			*val = mult_frac(*val, fract.numerator, fract.denominator);
 		/*
 		 * For all LTC2378-like devices, the amount of bits that express
 		 * voltage magnitude depend on the polarity / output code format:
@@ -641,6 +656,28 @@ static const struct spi_offload_config ltc2378_offload_config = {
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
+	if (ret == -ENODEV) { /* refin is optional */
+		st->ref_uV = st->info->internal_ref_uV * 2;
+		return 0;
+	}
+
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to read refin regulator\n");
+
+	st->ref_uV = ret * 2;
+
+	return 0;
+}
+
 static int ltc2378_ref_setup(struct device *dev, struct ltc2378_state *st)
 {
 	int ret;
@@ -676,7 +713,10 @@ static int ltc2378_probe(struct spi_device *spi)
 	if (!st->info)
 		return -EINVAL;
 
-	ret = ltc2378_ref_setup(dev, st);
+	if (st->info->internal_ref_uV)
+		ret = ltc2378_refin_setup(dev, st);
+	else
+		ret = ltc2378_ref_setup(dev, st);
 	if (ret)
 		return ret;
 
@@ -750,6 +790,7 @@ static int ltc2378_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ltc2378_of_match[] = {
+	{ .compatible = "adi,ltc2338-18", .data = &ltc2338_18_chip_info },
 	{ .compatible = "adi,ltc2364-16", .data = &ltc2364_16_chip_info },
 	{ .compatible = "adi,ltc2364-18", .data = &ltc2364_18_chip_info },
 	{ .compatible = "adi,ltc2367-16", .data = &ltc2367_16_chip_info },
@@ -774,6 +815,7 @@ static const struct of_device_id ltc2378_of_match[] = {
 MODULE_DEVICE_TABLE(of, ltc2378_of_match);
 
 static const struct spi_device_id ltc2378_spi_id[] = {
+	{ .name = "ltc2338-18", .driver_data = (kernel_ulong_t)&ltc2338_18_chip_info },
 	{ .name = "ltc2364-16", .driver_data = (kernel_ulong_t)&ltc2364_16_chip_info },
 	{ .name = "ltc2364-18", .driver_data = (kernel_ulong_t)&ltc2364_18_chip_info },
 	{ .name = "ltc2367-16", .driver_data = (kernel_ulong_t)&ltc2367_16_chip_info },
-- 
2.53.0

