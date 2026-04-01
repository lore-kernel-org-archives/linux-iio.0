Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4624301493;
	Wed,  1 Apr 2026 11:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775044747; cv=none; b=uYAiv+9YNowZBMctjyPlJvMwSqATuCjRjqESoA1BIcJ621i/37tycwbpZHrJQhdmlIHRZ1H9hrbXQNFWMEwApqvbfDHeyJ6wWykOsCpVZ80s6xziNTLGQm0QXCf2X51tK6LJO0A3PpaYA4CSHVVojZtQ6VPMX2eyEI0FWksurJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775044747; c=relaxed/simple;
	bh=6YOmkp1WjS/ZM10YN4TiDOETr+UCVze+LQC9/Ji1KEs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ITu1ZjkaPLqqwcut7ORi9Drr25d0/zQLKHE70SJKbFbmLqrShX8tCFGkUr5QbYr58QuDxOkTtcUIcCLuRojKsFhqXiBYa4UsfPUjQw32JOBEIREkpNzjUCdk9X0PD6fWbJFrSgJm3OS7LmTc2+83cO06phuHpiAXx2CmN5/TWi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xz4q3wjb; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xz4q3wjb"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6316m96q048223;
	Wed, 1 Apr 2026 07:58:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=sHoAb
	ozGJsVnzk1MSmvFIZms0iAXn5VCVyLIcSLcHho=; b=xz4q3wjbX69qErnM5qjfk
	qMf/G4BvR9k+CsuWIytltIE2iYrY9ZmIi1gZ6FM/umTYYfbvyD88Pvtowbb/in1j
	uuwHQnx86S74Hf4o4Or3x3yryPK7OZH0ZbpLHsvuwgML4onm5oiDXmRHel8YyAk4
	g1WSgESTEM4zUCaSSGxsqKBZHE04j0+CNNxZ9N/4HqlDqsqmO+0djFUsw8TJpIyP
	hgQ2K2eIpqLqdXoSdp/CE4VM+q7zvWy01eWwNjjatjWU8nJvBfDbLxGPqLxAjIwL
	2Kt+nMND27mqtqm89cju9H+eBL4X6aIiR74fQlLD4f4zR8NdXU5igxXMug8uGiAP
	w==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4d8xdsh5h7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 Apr 2026 07:58:51 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 631BwoE1005294
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 1 Apr 2026 07:58:50 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 07:58:50 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 1 Apr 2026 07:58:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 1 Apr 2026 07:58:50 -0400
Received: from JSANTO12-L01.ad.analog.com ([10.65.60.206])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 631BwaiF011484;
	Wed, 1 Apr 2026 07:58:39 -0400
From: Jonathan Santos <Jonathan.Santos@analog.com>
To: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>
CC: Jonathan Santos <Jonathan.Santos@analog.com>, <lars@metafoo.de>,
        <Michael.Hennerich@analog.com>, <jic23@kernel.org>,
        <dlechner@baylibre.com>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        Andy Shevchenko
	<andriy.shevchenko@intel.com>
Subject: [PATCH v3 4/5] iio: adc: ad4130: introduce chip info for future multidevice support
Date: Wed, 1 Apr 2026 08:58:34 -0300
Message-ID: <24c34bf6bfe61a0cb1dfc1438a87329356dbeaba.1774996100.git.Jonathan.Santos@analog.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1774996100.git.Jonathan.Santos@analog.com>
References: <cover.1774996100.git.Jonathan.Santos@analog.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDAxMDExMCBTYWx0ZWRfX/67mBFFobdti
 du3Lji7uG9eQVMoyoV5Vro1UWSrsUR4jqqbiOtwFxHxyPaJR5aKsINjryQvBILzpD1Dt4/RZsPS
 TzwaM84DfoUhNcqYVBeRnKOONIwVhqIUMoFQD7dtBToG5tDM8RePH4cuzzWbU9nGXgRfVzhAjmx
 PVO4vyHAz88vBBh9/rQM3Ukh2puWyZYobihZV+xrCEeg60L315cfFjN8mguDJUhOsoAEZGInCoM
 6zBIZ8j/sMz7Wm/Wi4prs4BkrXJTqGzqJ33FlC8RtynWEzYaalgJpqnkyct3iLaVhpbvE0YqQ3D
 Go5mc6Lc3YSYUhNXvyXrtMTLghmKE43kHLfoIuQczyjV0iMl+2oLBMOCY+rQq0mVmdS699/op0N
 tT3BGYCG3/aWhmfC6R22S/S26ROgU2NPrgkGm6FCokTepqcsLdFsvxcfBA2YcPf2x3/TGF736Xm
 nNhIymAB9FhApadDHbA==
X-Proofpoint-ORIG-GUID: UYUGKOE-jKLEGWpfSby25qjLgoe9zqZA
X-Authority-Analysis: v=2.4 cv=cqiWUl4i c=1 sm=1 tr=0 ts=69cd087b cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=0sLvza09kfJOxVLZPwjg:22
 a=Z0pTeXoby7EwIRygza74:22 a=QyXUC8HyAAAA:8 a=gAnH3GRIAAAA:8
 a=iK7pNCdl7K3njzu4ZfAA:9
X-Proofpoint-GUID: UYUGKOE-jKLEGWpfSby25qjLgoe9zqZA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-01_03,2026-04-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 priorityscore=1501 phishscore=0
 lowpriorityscore=0 impostorscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2604010110

Introduce a chip_info structure to abstract device-specific parameters
and prepare the driver for supporting multiple AD4130 family variants.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Santos <Jonathan.Santos@analog.com>
---
Changes in v3:
* None.

Changes in v2:
* spi_device_id table moved into a precursor patch.
* OF device id table using the original indentation.
---
 drivers/iio/adc/ad4130.c | 40 ++++++++++++++++++++++++++++++----------
 1 file changed, 30 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/ad4130.c b/drivers/iio/adc/ad4130.c
index d7aaf57ab87a..b064744e8da8 100644
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
-	{ "ad4130" },
+	{ "ad4130", (kernel_ulong_t)&ad4130_8_chip_info },
 	{ }
 };
 MODULE_DEVICE_TABLE(spi, ad4130_id_table);
-- 
2.34.1

