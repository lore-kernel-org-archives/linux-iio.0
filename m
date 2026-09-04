Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523404D2EC4;
	Fri,  4 Sep 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788531405; cv=none; b=p5dvNRkZ1DA9QoOEMDNPff5RqPspqA1tMtflUXF+mWAa8ADxva0/uYqSxvtMmyECmmTNd5/RMYJWQcsx44Hu7cqqf/DKxRVvlM1zEP3dLGNAExatlS/MHlkzZIjRrs6vBir1LN0tNgK9EkjZHmb/Ndwlb2f/7ZYNxADKeHA/Ki4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788531405; c=relaxed/simple;
	bh=SttIyvMI7w2tGaXFII+STMY8iJ7bQTKeDJINWqUI+FU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bpNFYRDJjERiimOm2utcTpVgdXgSKj2yajwfb8wgbTY/2cRO+4jNjsQ8nCWPbqzDzs7Zh/1XkjGchzbrxo362MV3Bwt86P12M2yIbNTbavpfM5o82o1B4YoxrSrr0m+0XB00wXElf4QP16rPIuSwzWIHz+F5Un9ZKtZfdD00tEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=krUfkQ6p; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="krUfkQ6p"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 684Dg53p3553411;
	Fri, 4 Sep 2026 10:16:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=MocIZ
	iAaxaluxDCmMIEV0zmhi+Tr376M9cujRrEaxJQ=; b=krUfkQ6pKHtq/zvse0mKm
	SDxQ/T5kPj0GH4iST0qRStOSQifvft7hoSBMopODDPhKOsvEUqG1B8vkliDodc7z
	0wC+o97Bc8hdgRdwy57JM9PIQXguWB0JE3VTbzke05DBdsG03f3CA+s+2QkbNmos
	GKfMaZM+oATBNlZEEoPP6AkmUnqrLaiVDgt4TSvkOHvwWHr8fRNKMAlE8UvpXScA
	cOfmd+9POnynDLPRO65lUJgokemdd3oq/FOnttOg1FJcqZkDINPiOm5eg7+dtXiC
	D9EkY0XLM3fW13NtJpPv7GMEafuApasYxaNWLJAa4/nPHSc/7naQ4xyKXEJlmdaI
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gftu3smqc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 04 Sep 2026 10:16:22 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 684EGLe6036387
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 4 Sep 2026 10:16:21 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX9.ad.analog.com (10.64.17.10) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:20 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Fri, 4 Sep 2026 10:16:20 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 4 Sep 2026 10:16:20 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 684EF2dJ026210;
	Fri, 4 Sep 2026 10:16:12 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 4 Sep 2026 16:15:07 +0200
Subject: [PATCH v6 15/17] iio: adc: ad7768: Add VCM regulator support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260904-ad7768-driver-v6-15-e4378f946bfb@analog.com>
References: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
In-Reply-To: <20260904-ad7768-driver-v6-0-e4378f946bfb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788531302; l=6843;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=SttIyvMI7w2tGaXFII+STMY8iJ7bQTKeDJINWqUI+FU=;
 b=JyD2Ue+JuxHmvBn0mdutbEKR2GTQWqhUJQXvAQB86lWtvR+msghMeByL8KtSEY4Dn7NJ+0NdH
 lFIZfh1qT7HAeWF+loUKVtNez5skE11eaikrlyyOWRbTmUYyYkyehFl
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Authority-Analysis: v=2.4 cv=R6wz39RX c=1 sm=1 tr=0 ts=6a9ad2b6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=-yOam_tWmGQwaYRI1VcA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfX2TRBnDKa2Wwi
 7KRzoqPPH6piTNEPnRxskQ5JXXeqWHTc7kM0k8X5Zv1R0JKN7lPTyALH7w9ylj7Y1AG/HXQaFxo
 ypE3+9r7xQLfPptaUkGmZx3GNg5MzwU/XfyT4cWsn6wnn5F34Wo7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA0MDEzMCBTYWx0ZWRfXy3HlcZtE0Tbc
 zD6UTUW+uOz2zcjBLz8VkGCgH4NwCJ/Zzr889KE7QgQ0mp1GR7bB1XLtX77CyuYKYVCgBsQ0ZfW
 Aka82BTB+d3tiVN+RwEeX58I9SjQu5nBSXiJ9HKPejkIpTZgNeRQgw4IU1nj1zOila8fQp63ccq
 1wkeJbtNuRyhy0H7FLHyj1fuVx4hHlVuaIKtVJNqnnrDkBaNJ6W5HwHAfj2MjJIRdZggUpvGN1U
 BXSXZNdvzfn98gQhsEPdr1y/fKBtqH5MRYY/XtBpl/wHVR95MBXDmtXvA25qzex/a7cZ5XFGWn4
 PIt3552i/2DbZbUn228++Wzhn88WeZld9ij6Ldp2KTKvdwRg2eeGDZGOLoKjNyIjuaWuXZfnEZT
 ZBCJY5P0WmZArscna4FaLcfpyEo34nPZQWDs/8ILCr2WNOSylkNWdZRijgSzrFdsZB2s7jZYSLx
 nnRWLJ3TTvH7u9y8Ghg==
X-Proofpoint-GUID: t21vGNDRGaeYviZeadM08X-A3MJc6sCy
X-Proofpoint-ORIG-GUID: t21vGNDRGaeYviZeadM08X-A3MJc6sCy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-04_04,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 spamscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609040130

Expose the on-chip common mode voltage output through the regulator
framework. Support the three fixed output levels and the
supply-dependent AVDD1/2 setting.

Keep the ADC runtime active while VCM is enabled and release the runtime
PM reference when the output is disabled.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/Kconfig  |   2 +-
 drivers/iio/adc/ad7768.c | 162 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 161 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
index 5164608fa418..c784bee0fd65 100644
--- a/drivers/iio/adc/Kconfig
+++ b/drivers/iio/adc/Kconfig
@@ -434,7 +434,7 @@ config AD7766
 config AD7768
 	tristate "Analog Devices AD7768/AD7768-4 ADC driver"
 	depends on SPI
-	depends on REGULATOR || COMPILE_TEST
+	select REGULATOR
 	select IIO_BUFFER
 	select IIO_BACKEND
 	select REGMAP
diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index 9c6bebb1857f..4acf89bdad12 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -23,6 +23,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/time.h>
@@ -50,6 +51,10 @@
 #define   AD7768_POWER_MODE_LVDS_ENABLE			BIT(3)
 #define   AD7768_POWER_MODE_MCLK_DIV_MSK		GENMASK(1, 0)
 
+#define AD7768_REG_GENERAL_CONFIG			0x05
+#define   AD7768_GEN_CONFIG_VCM_SEL_MSK			GENMASK(1, 0)
+#define   AD7768_GEN_CONFIG_VCM_PD			BIT(4)
+
 #define AD7768_REG_DATA_CONTROL				0x06
 #define   AD7768_DATA_CONTROL_SPI_RESET_1		0x03
 #define   AD7768_DATA_CONTROL_SPI_RESET_2		0x02
@@ -186,11 +191,157 @@ struct ad7768_state {
 	unsigned int power_mode_idx;
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
+	struct regulator_dev *vcm_rdev;
+	unsigned int avdd1_uV;
 	unsigned int vref_uV[2];
 
 	__be16 d16 __aligned(IIO_DMA_MINALIGN);
 };
 
+static const unsigned int ad7768_vcm_voltage_table[] = {
+	0, 1650000, 2500000, 2140000,
+};
+
+static int ad7768_vcm_list_voltage(struct regulator_dev *rdev,
+				   unsigned int selector)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+
+	if (selector >= ARRAY_SIZE(ad7768_vcm_voltage_table))
+		return -EINVAL;
+
+	if (!selector)
+		return DIV_ROUND_CLOSEST(st->avdd1_uV, 2);
+
+	return ad7768_vcm_voltage_table[selector];
+}
+
+static int ad7768_vcm_enable(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = pm_runtime_resume_and_get(regmap_get_device(st->regmap));
+	if (ret < 0)
+		return ret;
+
+	ret = regmap_clear_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+				AD7768_GEN_CONFIG_VCM_PD);
+	if (ret)
+		pm_runtime_put_autosuspend(regmap_get_device(st->regmap));
+
+	return ret;
+}
+
+static int ad7768_vcm_disable(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+			      AD7768_GEN_CONFIG_VCM_PD);
+	if (ret)
+		return ret;
+
+	pm_runtime_put_autosuspend(regmap_get_device(st->regmap));
+
+	return 0;
+}
+
+static int ad7768_vcm_is_enabled(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = regmap_test_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+			       AD7768_GEN_CONFIG_VCM_PD);
+	if (ret < 0)
+		return ret;
+
+	return !ret;
+}
+
+static int ad7768_vcm_set_voltage_sel(struct regulator_dev *rdev,
+				      unsigned int selector)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+				  AD7768_GEN_CONFIG_VCM_SEL_MSK,
+				  FIELD_PREP(AD7768_GEN_CONFIG_VCM_SEL_MSK,
+					     selector));
+}
+
+static int ad7768_vcm_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(st->regmap, AD7768_REG_GENERAL_CONFIG, &val);
+	if (ret)
+		return ret;
+
+	return FIELD_GET(AD7768_GEN_CONFIG_VCM_SEL_MSK, val);
+}
+
+static const struct regulator_ops ad7768_vcm_ops = {
+	.enable = ad7768_vcm_enable,
+	.disable = ad7768_vcm_disable,
+	.is_enabled = ad7768_vcm_is_enabled,
+	.list_voltage = ad7768_vcm_list_voltage,
+	.set_voltage_sel = ad7768_vcm_set_voltage_sel,
+	.get_voltage_sel = ad7768_vcm_get_voltage_sel,
+};
+
+static const struct regulator_desc ad7768_vcm_desc = {
+	.name = "vcm",
+	.of_match = "vcm-output",
+	.regulators_node = "regulators",
+	.n_voltages = ARRAY_SIZE(ad7768_vcm_voltage_table),
+	.ops = &ad7768_vcm_ops,
+	.type = REGULATOR_VOLTAGE,
+	.owner = THIS_MODULE,
+};
+
+static int ad7768_register_vcm_regulator(struct device *dev,
+					 struct ad7768_state *st)
+{
+	struct regulator_config config = {
+		.dev = dev,
+		.driver_data = st,
+	};
+	int ret;
+
+	/*
+	 * Start with VCM disabled so each enabled state is paired with the
+	 * runtime PM reference acquired by ad7768_vcm_enable().
+	 */
+	ret = regmap_set_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+			      AD7768_GEN_CONFIG_VCM_PD);
+	if (ret)
+		return ret;
+
+	st->vcm_rdev = devm_regulator_register(dev, &ad7768_vcm_desc, &config);
+	return PTR_ERR_OR_ZERO(st->vcm_rdev);
+}
+
 static const unsigned int ad7768_dec_rate[AD7768_MAX_FREQ_PER_MODE] = {
 	32, 64, 128, 256, 512, 1024,
 };
@@ -1502,11 +1653,13 @@ static int ad7768_probe(struct spi_device *spi)
 				     "Failed to enable AVSS supply\n");
 	}
 
-	ret = devm_regulator_get_enable(dev, "avdd1");
-	if (ret)
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd1");
+	if (ret < 0)
 		return dev_err_probe(dev, ret,
 				     "Failed to enable AVDD1 supply\n");
 
+	st->avdd1_uV = ret;
+
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(ad7768_supply_names),
 					     ad7768_supply_names);
@@ -1636,6 +1789,11 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ad7768_register_vcm_regulator(dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register VCM regulator\n");
+
 	return devm_iio_device_register(dev, indio_dev);
 }
 

-- 
2.43.0

