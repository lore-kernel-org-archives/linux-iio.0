Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B346C4F4745;
	Wed, 16 Sep 2026 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789557393; cv=none; b=Abl3/1m8G9y207kjle7vHgaE9fY4wTBzsvjodbD6pz8PvD6AnzaLSds4ERb4rN/FT8OKmS3XK+hjvIN25rHGFuqpyf6Gh2jcKQSP3CBtEN78SnKokwoZCSVz/m9QY/Qn6bQOcog9V2dMuujTO6LRywF+ZRvoJUZXYf+ASoadjQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789557393; c=relaxed/simple;
	bh=4jy9/jgKTSS8f09g9nm/mjlYIrxyyPBvegzPMR+9vOs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=XxrVl7WDYjcSdM8EdhqAd0RcN6KThzP4s0OxZkk2wBcpQp/wHA41N67ftAbDIPQBMlxwIs+uJjV8f3MM7qqDV0uaINknQk65B03c0cIwGae4siGSy5HE+ifBxqS1o0SkIYSDDTFO2GcXId73jjdsmtx0X7siCoUhDeykM/lTAS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=TVWu4OIh; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="TVWu4OIh"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68G7A0Sa1548646;
	Wed, 16 Sep 2026 07:15:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=YZiN/
	UhPei+9RB94xr8CYCzeWenkSTCq0j3g+tdrb78=; b=TVWu4OIhacQ03DIDxOHfa
	Z+10JPp5X8i+06drmY6Pd5k8x42Gnf8sG4G+l3O/S4lCpzDNPqz4DruueteGydrQ
	QQU2EcYLNxEUtVBJ2u3JP5yzCdzLpKlAioKmk0q9orcjR3Y4zOLCHAOV9GnlGAgI
	/OmJTL40G9LGJIeqQuoe58yO7AVNIUotQ7wbC/hdjg1rLWg09utgCR4kk0vTZhA3
	SF1iDjSuMR/sS2mmuEuvvPXbm6URTCWY7kjwI883udyNvUBIb3lPs6WKGGEi24RW
	8KXNdQFWFGgYR9z+S5TnOC+wZTmwg5g0bZQ7bXxoIepHy+zgSaud7X57uWZ0YHAF
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4gqj57hxg4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Sep 2026 07:15:35 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 68GBFYvs047166
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 16 Sep 2026 07:15:34 -0400
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:34 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Wed, 16 Sep 2026 07:15:34 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Wed, 16 Sep 2026 07:15:34 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.69])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 68GBENE7004263;
	Wed, 16 Sep 2026 07:15:27 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Wed, 16 Sep 2026 13:14:04 +0200
Subject: [PATCH v8 15/17] iio: adc: ad7768: Add VCM regulator support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260916-ad7768-driver-v8-15-27aa24db5225@analog.com>
References: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
In-Reply-To: <20260916-ad7768-driver-v8-0-27aa24db5225@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789557263; l=6943;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=4jy9/jgKTSS8f09g9nm/mjlYIrxyyPBvegzPMR+9vOs=;
 b=ZTfaAKwue82OQjdYb6JeVoJJOY0nECp0YikUrADs1EVaRXO6HjIZJoMwsiOyMsKl8owzNbdQ9
 mTZqvjwXb2AA/2TYNwaLgbHbL2+jvz3izf9wFLHKpqlimjV7U9Tqozh
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX+q8pG5GU4doj
 10krxVGekoxXOnrnB1bP8RBvfoi+40cfaEpigTCGYzyA1LUxUcVC779kuUZEBX9grFKz0/h906G
 pyWv/hFsbjq5zvF8SPw1BYpfyPtNTt2e56WNdfi1vPuuH7bhSSlT
X-Authority-Analysis: v=2.4 cv=HfuB3SE8 c=1 sm=1 tr=0 ts=6aaa7a57 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=-yOam_tWmGQwaYRI1VcA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-ORIG-GUID: cbD54D-dSPcNR4_E68Zil3Vzkl0v3gZK
X-Proofpoint-GUID: cbD54D-dSPcNR4_E68Zil3Vzkl0v3gZK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE2MDE0OCBTYWx0ZWRfX7a/8/vpi5jjl
 3rl08fTqd4XFk8rIG72KdnsCJZMUgQ2+28EXgs3DBhqASuKLw102w+IqmzCIuSVInYArbECBsNS
 NdzgZKqjWkfB+nXVSz3M/HAg5Fac/MOf9H8kLdclS065L2Y8JDQGktDTtKmZgT6ze+yP9Nq1b9l
 pNDYM0adqjT3WwDvQzsnpDYWnNuWYi6zUVUdAGHhBfvad7L1blp7DGbgGv9rV4w81UXN1U2GLdh
 9ZrBjx5L/jeTFO2jyNqleDpj7ubk7lDzdS+3Kak2WFjbFJq3xEFnncc10X/jjGEw6cyGPATZYMW
 FsA6FQn1zlSm0CFIEN4jBqFGPxLh2xY2dzuoq8LsGHTDC+l8Y6+JLdSEq0HeevwTWSEtbUgMJqr
 oJQWQbZ4DzfERMk+gOUUNLnvP7uQ3L9RoTGmyM7BBSms0OCqCToWj0RdOgZojxhIVm3gAigIzsN
 daEav1vldM2UJ//bzKA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_05,2026-09-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0 phishscore=0
 bulkscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609160148

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
index be2eb21c5b63..33b1b124d4d1 100644
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
@@ -183,12 +188,158 @@ struct ad7768_state {
 	unsigned int power_mode_idx;
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
+	struct regulator_dev *vcm_rdev;
+	unsigned int avdd1_uV;
 	unsigned int vref_uV[2];
 
 	/* Used only in regmap_read() callback, hence guarded by regmap lock. */
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
@@ -1534,11 +1685,13 @@ static int ad7768_probe(struct spi_device *spi)
 		return dev_err_probe(dev, ret, "Failed to enable AVSS supply\n");
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
@@ -1672,6 +1825,11 @@ static int ad7768_probe(struct spi_device *spi)
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

