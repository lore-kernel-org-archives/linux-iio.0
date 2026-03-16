Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB762BE053;
	Mon, 16 Mar 2026 11:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773661568; cv=none; b=HchWt4upqCAhqSD9fXu37voUYE13p/1FhUpFtP9t+cKYOW9U8mkFyOX+DXwbW8Vb+7bfTq03a9sHeIl7ZH/A1JSwN/x+VFckMIW/hGObwugvCqh4DQHD4kZEtyxhetZlsGlwv4Esh2LCmWkwp+rgxnU8W6uGlsbFav/1x89QPiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773661568; c=relaxed/simple;
	bh=C0lzfyubQUMxfOhfydOPTpcZUyNanKAXcQ1c94bVV00=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m8MAPnjFwLKTHk8fIrP7jm6VoHVXBu+mDKMD44fhzGslY8pwsQBjT6oitqELXi8I3+o2NMZQglRzaWy0KFHeA7EBBBBhuDLwIZ4FVjaK/sLs57xrcLRRmbZdZLSt/Ohvj/8f4+CbbtTYlDi5KK3DdRY7R6Eo+Ax4gb2gl4vqMNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=q54Xhno0; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="q54Xhno0"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G7tGvt1348410;
	Mon, 16 Mar 2026 07:45:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=PYyFD
	8W3ZpT1S5S6l9V1OFSGFB7/AXuqWwJsCVa+t2M=; b=q54Xhno08Hbqn6NWHpwZF
	c/yYMvWVaW3u0P4JdCuqYXMkmPZrZi0cEiSxUGL0DCsmHVg2eSOLbOwXQCJJAgYx
	pdSwEwkxTHRAFd+LeGhmhaQCA+g2XysQusc4+tXLytjor0LGMdQltTblX/1WBbNq
	B0eG5xcBRIS2l3kaAD928aR/GFNNDR7Hh0GMSpLWkFeTp3NIT+YDjYhh9CtPy+63
	yYdSxIHlS+VKhZXbRdP0n/YzG5KOFFhJrU6dFYUlDplLlGn8JDLi9ZAROGgR7p5D
	OZAsvGAMOO4O1XMSi46rCkfsHcuTXaiAvPvvURMECynNsRd+g605NKKUj6b5LmsZ
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4cx2dgaugp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 07:45:50 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 62GBjnNT002743
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 16 Mar 2026 07:45:49 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Mar 2026 07:45:49 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Mon, 16 Mar 2026 07:45:48 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Mon, 16 Mar 2026 07:45:48 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 62GBjb8B022996;
	Mon, 16 Mar 2026 07:45:40 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <cosmin.tanislav@analog.com>,
        <jic23@kernel.org>, <dlechner@baylibre.com>, <nuno.sa@analog.com>,
        <andy@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>
Subject: [PATCH v2 4/5] iio: adc: ad4130: introduce chip info for future multidevice support
Date: Mon, 16 Mar 2026 08:45:36 -0300
Message-ID: <4ab83983026db04695e0a36a7103efbfb82f7a76.1773311639.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1773311639.git.Jonathan.Santos@analog.com>
References: <cover.1773311639.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: T8vPyAAuZLo2pjbaFQh_5TKXga2cjwYy
X-Proofpoint-ORIG-GUID: T8vPyAAuZLo2pjbaFQh_5TKXga2cjwYy
X-Authority-Analysis: v=2.4 cv=Mb9hep/f c=1 sm=1 tr=0 ts=69b7ed6e cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8 a=iK7pNCdl7K3njzu4ZfAA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA4OCBTYWx0ZWRfX38/1z+Ayaxsu
 ckbBKErZUqHmLlHCsjq3zDC9F82P6ECwNvw/9p0vBDagmkz+9ymzh0002prsAszMMrbWLzaZDaT
 SjQ6/wImb0jJM8zmXgUktjVL9Cai2GDFNNPf2Xm63k0nmGro/Oi0w25JS/8Ou2VGYxp8wQ8x1A1
 90FnhcjYiw5xA2teVHWSrIdBSHibmX2rCd2FBRIH8afMdkqqYPqZ1iSQm0+ukyDteDKm/uajtGW
 hDuJeFb5ziW+YuydQeGH8hq9I4EksDEZMJvuKzln+4E6Qpbyd20wXzj1eDDmDU+uY/SFSFZK8ZO
 weXKS6AnQGgr8jsEYlI7jRk8VrseWI5fRslibU+qO+ZpBYNcUKW2iayT19pWips24uLaLka+n2P
 bET6LHMgifUxcJbiEZCIvKxlvh3PNjlzuQ4P4dG6lcqb6DL9LWbYLSKYaHlQ1N11dKzCbljyIOY
 pKMDBVxiHagqHUP7MPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160088

Introduce a chip_info structure to abstract device-specific parameters
and prepare the driver for supporting multiple AD4130 family variants.

Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v2:
* spi_device_id table moved into a precursor patch.
* OF device id table using the original indentation.
---
 drivers/iio/adc/ad4130.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index 94cb6af0c4c5..b064744e8da8 100644
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
@@ -2104,13 +2123,14 @@ static int ad4130_probe(struct spi_device *spi)
 static const struct of_device_id ad4130_of_match[] = {
 	{
 		.compatible = "adi,ad4130",
+		.data = &ad4130_8_chip_info
 	},
 	{ }
 };
 MODULE_DEVICE_TABLE(of, ad4130_of_match);
 
 static const struct spi_device_id ad4130_id_table[] = {
-	{ "ad4130", 0 },
+	{ "ad4130", (kernel_ulong_t)&ad4130_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4130_id_table);
-- 
2.34.1

