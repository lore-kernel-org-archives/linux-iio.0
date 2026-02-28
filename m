Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA7E3A0EBB;
	Mon,  2 Mar 2026 12:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772454359; cv=none; b=YS6zEsKQYKuiSAT1X0W0HZngzWLhhmv4CuehmYTR1+7w3Yl5MSuGzD9TeHEL00QcDUEFYXUtX2SK+qExG1UHWO1jJGsQmpBXyd0YVwtPV8sg3DU9jwn/Ja4A3ug0zr94Cd1n2WeBWNgjtIQ6E+0WFV2/hg8t44muVuZ6FMRBesg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772454359; c=relaxed/simple;
	bh=PHCfiXdyYCoBqmex8G2ZEZbQ6qAjYZwcT9YiujCPlhk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a/8iCOs1STt7rT1DYK8U2cL9IqBf2hImw9H2goGP7UnVS083oLmObduzmbLIAnTkyIQTUdV0xRebt+BilNQaA1CZ397kp7S0EZBsmoifIHmb8phsw97H0Dg/+t/DjOu3V7l4NR2SynwM4dmtERc8kJqOcfTC2HFv6KxMZGdzdOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=mOanKTZf; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="mOanKTZf"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62286R5T3411691;
	Mon, 2 Mar 2026 07:25:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MvNnw
	iq4clSrEx0QXm9GuJxZtqSCRQCbZm+defZoWkg=; b=mOanKTZf4MwQB5j1PY9VH
	r5tl74ziDdYF29nuWDlvobl9UuOlObdVrUltTOhyWkDXqk/EVsDS9qnwdUNkKItr
	JJeM//Xx+sEulRUbRr/KLmd5Pe3Uwq62M5kA62yckYHx4kMDyNh60N8A3tP4vAsz
	ond3qRrIT+b6QbI/OaJb5ktnGTDHWDTgVk2aEjPtZAs7nT9tJ2S2A3g2Bhi3CDRT
	6VI2+c0PSd0pGTd4FtgX+qXEHeMc4Fcq1pRLE5hRDRKQBe5yQAOsa3FeaX1w78aR
	a67KV36i29gfCiYmiFXq8qy6Tok0Bu5avXapiRnG5ysvsfsBfW43igU36+JDaznW
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cmfjcma8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Mar 2026 07:25:42 -0500 (EST)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 622CPfia002641
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 2 Mar 2026 07:25:41 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:25:41 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 2 Mar 2026 07:25:41 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 2 Mar 2026 07:25:41 -0500
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 622CPTtI010661;
	Mon, 2 Mar 2026 07:25:31 -0500
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <cosmin.tanislav@analog.com>,
        <lars@metafoo.de>, <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
Subject: [PATCH 2/3] iio: adc: ad4130: introduce chip info for future multidevice support
Date: Sat, 28 Feb 2026 09:38:53 -0300
Message-ID: <b95a029f836a1d2d125f5beccf5290cfcf32c725.1772078999.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1772078999.git.Jonathan.Santos@analog.com>
References: <cover.1772078999.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=adpsXBot c=1 sm=1 tr=0 ts=69a581c6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=iK7pNCdl7K3njzu4ZfAA:9
X-Proofpoint-GUID: uRTBUugSssVqWcZugOHXZzmkLkxwJNok
X-Proofpoint-ORIG-GUID: uRTBUugSssVqWcZugOHXZzmkLkxwJNok
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzAyMDEwNCBTYWx0ZWRfX4nfvxuQnnSf0
 vRylcci8m9Ugf0LBf5zx0K85ZJQs0rffPLiZrrjk3GiKz/chJgC3expiHKlSZ3nns4IgJ9B63N2
 aGPDOsqvRq2NUD58rIwXIunjAHBa4fnekHjJ6r50KYnS44LI9UCYZjBmz/bRESS1Sqns7csG9uv
 qvoNKVtfHwfV9c8horimST6510DUgE0aZQ+ghWJeUuDc/R95LLZt/f+fdzqG6GCFIy2FEK2Z5Vq
 ZXl7b4HnArLCMZq9+xuRxGAccE8Rbh6xUK5jcP6fyqDLhLiylSu9knvOULooZTNXAiYnEhvoR9c
 LzKSKAjplwfMHKkYW0yofGP8uC8bSZfCuYmiat6miu6rY5UcYrQwn6Ov5dVSVeI6PYzScU25rlb
 NK1v2F/B7uXfX3AWvI3gOflcHin6ZkHXNwGnAVIstd9u/1SBkQKnIIcnQyVDUa8p/1DnKNOvp6Y
 utLzmX/BNgfCVqZ7syw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-02_03,2026-02-27_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 phishscore=0 clxscore=1015 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603020104

Introduce a chip_info structure to abstract device-specific parameters
and prepare the driver for supporting multiple AD4130 family variants.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
 drivers/iio/adc/ad4130.c | 48 ++++++++++++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 5567ae5dee88..138fc0b99d81 100644
--- a/drivers/iio/adc/ad4130.c
+++ b/drivers/iio/adc/ad4130.c
@@ -224,6 +224,14 @@ enum ad4130_pin_function {
 	AD4130_PIN_FN_VBIAS = BIT(3),
 };
 
+struct ad4130_chip_info {
+	const char *name;
+	unsigned int max_analog_pins;
+	const struct iio_info *info;
+	const unsigned int *reg_size;
+	const unsigned int reg_size_length;
+};
+
 /*
  * If you make adaptations in this struct, you most likely also have to adapt
  * ad4130_setup_info_eq(), too.
@@ -268,6 +276,7 @@ struct ad4130_state {
 	struct regmap			*regmap;
 	struct spi_device		*spi;
 	struct clk			*mclk;
+	const struct ad4130_chip_info	*chip_info;
 	struct regulator_bulk_data	regulators[4];
 	u32				irq_trigger;
 	u32				inv_irq_trigger;
@@ -394,10 +403,10 @@ static const char * const ad4130_filter_types_str[] = {
 static int ad4130_get_reg_size(struct ad4130_state *st, unsigned int reg,
 			       unsigned int *size)
 {
-	if (reg >= ARRAY_SIZE(ad4130_reg_size))
+	if (reg >= st->chip_info->reg_size_length)
 		return -EINVAL;
 
-	*size = ad4130_reg_size[reg];
+	*size = st->chip_info->reg_size[reg];
 
 	return 0;
 }
@@ -1291,6 +1300,14 @@ static const struct iio_info ad4130_info = {
 	.debugfs_reg_access = ad4130_reg_access,
 };
 
+static const struct ad4130_chip_info ad4130_8_chip_info = {
+	.name = "ad4130-8",
+	.max_analog_pins = 16,
+	.info = &ad4130_info,
+	.reg_size = ad4130_reg_size,
+	.reg_size_length = ARRAY_SIZE(ad4130_reg_size),
+};
+
 static int ad4130_buffer_postenable(struct iio_dev *indio_dev)
 {
 	struct ad4130_state *st = iio_priv(indio_dev);
@@ -1504,7 +1521,7 @@ static int ad4130_validate_diff_channel(struct ad4130_state *st, u32 pin)
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid differential channel %u\n", pin);
 
-	if (pin >= AD4130_MAX_ANALOG_PINS)
+	if (pin >= st->chip_info->max_analog_pins)
 		return 0;
 
 	if (st->pins_fn[pin] == AD4130_PIN_FN_SPECIAL)
@@ -1536,7 +1553,7 @@ static int ad4130_validate_excitation_pin(struct ad4130_state *st, u32 pin)
 {
 	struct device *dev = &st->spi->dev;
 
-	if (pin >= AD4130_MAX_ANALOG_PINS)
+	if (pin >= st->chip_info->max_analog_pins)
 		return dev_err_probe(dev, -EINVAL,
 				     "Invalid excitation pin %u\n", pin);
 
@@ -1554,7 +1571,7 @@ static int ad4130_validate_vbias_pin(struct ad4130_state *st, u32 pin)
 {
 	struct device *dev = &st->spi->dev;
 
-	if (pin >= AD4130_MAX_ANALOG_PINS)
+	if (pin >= st->chip_info->max_analog_pins)
 		return dev_err_probe(dev, -EINVAL, "Invalid vbias pin %u\n",
 				     pin);
 
@@ -1730,7 +1747,7 @@ static int ad4310_parse_fw(struct iio_dev *indio_dev)
 
 	ret = device_property_count_u32(dev, "adi,vbias-pins");
 	if (ret > 0) {
-		if (ret > AD4130_MAX_ANALOG_PINS)
+		if (ret > st->chip_info->max_analog_pins)
 			return dev_err_probe(dev, -EINVAL,
 					     "Too many vbias pins %u\n", ret);
 
@@ -1994,6 +2011,8 @@ static int ad4130_probe(struct spi_device *spi)
 
 	st = iio_priv(indio_dev);
 
+	st->chip_info = device_get_match_data(dev);
+
 	memset(st->reset_buf, 0xff, sizeof(st->reset_buf));
 	init_completion(&st->completion);
 	mutex_init(&st->lock);
@@ -2011,9 +2030,9 @@ static int ad4130_probe(struct spi_device *spi)
 	spi_message_init_with_transfers(&st->fifo_msg, st->fifo_xfer,
 					ARRAY_SIZE(st->fifo_xfer));
 
-	indio_dev->name = AD4130_NAME;
+	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-	indio_dev->info = &ad4130_info;
+	indio_dev->info = st->chip_info->info;
 
 	st->regmap = devm_regmap_init(dev, NULL, st, &ad4130_regmap_config);
 	if (IS_ERR(st->regmap))
@@ -2056,7 +2075,7 @@ static int ad4130_probe(struct spi_device *spi)
 	ad4130_fill_scale_tbls(st);
 
 	st->gc.owner = THIS_MODULE;
-	st->gc.label = AD4130_NAME;
+	st->gc.label = st->chip_info->name;
 	st->gc.base = -1;
 	st->gc.ngpio = AD4130_MAX_GPIOS;
 	st->gc.parent = dev;
@@ -2102,19 +2121,24 @@ static int ad4130_probe(struct spi_device *spi)
 }
 
 static const struct of_device_id ad4130_of_match[] = {
-	{
-		.compatible = "adi,ad4130",
-	},
+	{ .compatible = "adi,ad4130", .data = &ad4130_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4130_of_match);
 
+static const struct spi_device_id ad4130_id_table[] = {
+	{ "ad4130", (kernel_ulong_t)&ad4130_8_chip_info },
+	{ }
+};
+MODULE_DEVICE_TABLE(spi, ad4130_id_table);
+
 static struct spi_driver ad4130_driver = {
 	.driver = {
 		.name = AD4130_NAME,
 		.of_match_table = ad4130_of_match,
 	},
 	.probe = ad4130_probe,
+	.id_table = ad4130_id_table,
 };
 module_spi_driver(ad4130_driver);
 
-- 
2.34.1

