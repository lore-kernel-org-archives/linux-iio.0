Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BE44577E24;
	Thu, 10 Sep 2026 17:38:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789061906; cv=none; b=tRoCtTe+ts1Tz/1EoTHMC11w6y0HGrMXWenrNRvnwLaZ4CFfgNEhKxXuyTrbfl66M/V1ddGOR8MBxjmVePq3weNm0yTqizf6rNcKdDTlbMO4S72tL3mc4fdcFsEye1uojq1BLmGm+Dzzh5wFqn3QusgcsPdzNyPqKWFnGB53yXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789061906; c=relaxed/simple;
	bh=WVOEdN4MgnzT99O6n7M//fUnp014UcOJ1KRFTnPWbNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O4Q5V49Nv60nllxBUb3M2fvvjO9ZZ+uIcTOa1V9pfWCy8F51wicJ1umXjxmxugLqCzOtFjH3mlj8EUCSGv1tgnSgDkBW/gpD6S4tlscNkab8TjgfgppQfetQcs5qOVdebT2/oZUxw02C1p7LQlqU9ycHMxamNjXvq4uDTzg+j0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=nOnUA3Hd; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="nOnUA3Hd"
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68AF83Ov3830565;
	Thu, 10 Sep 2026 13:37:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=CDVX/
	iJm5rKIuFkqHWJuT5VeMLQnpDTBaPnX/snVg5Y=; b=nOnUA3HdF0Ai7bpRy8tq5
	fv3jqiOi4ie1xmp1JAFCUspvtlap/D84V96Jqqhfyy8WGJFWKe3FfPZyQE5ToBoV
	odJn/+VR5P0hiIqUoV4gr09ElYR8r+dLYYu2omZWZjBia+JHXg0LMfEKLVwWTR4O
	4p6UJbCelcsgUMl7AnFvf3Uw88apOSNUozIL/Ieef/22yoh0vjdfeiORHfdgm9Bk
	bY7b7yyKu0fIdH3fiFdjFFQ7c/6URSOvT0lINnP2HYntx7soBDm7v+HusquzuTED
	KfvFFSCqj9v3a1FlcXAdOh4jjZQzM+KqeLEP8Dp+7pp2EBKgSqbzWPGW+mKGRotF
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4gkcxad2fu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Sep 2026 13:37:52 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68AHbo9E038865
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 10 Sep 2026 13:37:51 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 10 Sep
 2026 13:37:50 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 10 Sep 2026 13:37:50 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.225.204])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68AHaSSl018832;
	Thu, 10 Sep 2026 13:37:45 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 10 Sep 2026 19:36:33 +0200
Subject: [PATCH v7 15/17] iio: adc: ad7768: Add VCM regulator support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260910-ad7768-driver-v7-15-7f70b07627e1@analog.com>
References: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
In-Reply-To: <20260910-ad7768-driver-v7-0-7f70b07627e1@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789061788; l=6843;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=WVOEdN4MgnzT99O6n7M//fUnp014UcOJ1KRFTnPWbNY=;
 b=m3mmQdXgTsZ8RppAUqXA22f1wSgP+Pi7sDd5P1T2m2/uaY5YxVPZFTLb5AzyphTA/WrB71T8M
 aOjX/Qg1VKyCjRL8nTySuJu0fMe1Jn2h019sdtMpS+mE/JG4Qtbi8SA
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX0ERXRBmx6kQr
 o53zswGBEIdTVCyylBY4bVdAnw780brtW4v7ltujU5wD4KdvYEMMqzcTdFak1Rm/JIaxc8MWjFT
 SJaCi6CqShBbGwEkO2zUgJqskxVqScw5UxXpMvWooEOoIFfqcc7v
X-Authority-Analysis: v=2.4 cv=Ao17T+9P c=1 sm=1 tr=0 ts=6aa2eaf0 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=Z0pTeXoby7EwIRygza74:22 a=gAnH3GRIAAAA:8
 a=-yOam_tWmGQwaYRI1VcA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-GUID: gpBlCU2_yOrcTjveZc9ezhW-ABHjGBct
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDIxNSBTYWx0ZWRfX5cvYezukk6Rh
 kAjFwb74reCoK5zNsZkguscl2kbhmBMsYUK9gc0vXjaomet9m7zQGh8JVWBlmTnt8Uc854u2IX4
 Z9RvD0fByoCwOnXIbafwqZe32nBAgWKiu0q1Okg5wcCZZLHfXkKtSyxjxJ6RyLXlKJqeRinWyW3
 5KBlmd9QvU5iRGF4AYjoteXnGH/gNblPIXM6AtUrNSuiooYuSK3b9w9m8hPE5FsaKHaTHW1yXF3
 lD0Ves/NLNW7SIoKV+JBmJYTSeq+OFgtMJqeKuhdsRORgJ+JW1rQXFrGsFbThwLkVCqQwIvfMj+
 HnWlahCYITICOxR8v9bZ8hi24DMHiDiXqZL+eZ7J5Het+jAXAN/YzKDeuFxdGZcUnBbHYagDVbE
 3y5FLd2ddexFBSLbmPA+bH5odc3hEqVxFTpF9cmnNO1v+ehg6ElH/b9bEDyufZpaDKoZu2QzZ2G
 E3HfhgVVqEDM8Yf6SqA==
X-Proofpoint-ORIG-GUID: gpBlCU2_yOrcTjveZc9ezhW-ABHjGBct
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_05,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 adultscore=0 clxscore=1015 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100215

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
index 941fdac634a6..b854c10467a2 100644
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
@@ -183,11 +188,157 @@ struct ad7768_state {
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
@@ -1541,11 +1692,13 @@ static int ad7768_probe(struct spi_device *spi)
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
@@ -1679,6 +1832,11 @@ static int ad7768_probe(struct spi_device *spi)
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

