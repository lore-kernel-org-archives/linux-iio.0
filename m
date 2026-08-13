Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD528481AB0;
	Thu, 13 Aug 2026 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629501; cv=none; b=JgxEcZN6Y8vkkvC0obnt6GtyRyyrTkIGBQTl/VrdcczqlTAuRkDalsHMARMWdmh8zRYCJMa0KSw7OTKYAZrEjs3em+/8jukoE2pzpaFZ3sDzJkv1wpOL1F0fygfEFAhPbH+E2XiiBfNy5jQLMbALKwoMJweRWNMTxf7v9unrTog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629501; c=relaxed/simple;
	bh=VLK6BSdElRIJyRqz8EE1UHbbon9eqmgepSi5c3GZU+c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rh2cSh/XOSKlxphgzax+AFiE297Zgllqhglz9AM9eXO/wMjc4hbXmUYW9fmm0V8FnJ9dInIGhYrOlf9+l+2l+DGZeSdthOM1FPCAAivCs6pwKmVl9ikJEE4+W9y1mJKXOwTt3eu1Stjqm5SIhakMN9LNZ2ZYGyTXYKIVoHP0Qb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=kdnqSes+; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="kdnqSes+"
Received: from pps.filterd (m0167088.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCL8iJ2350818;
	Thu, 13 Aug 2026 09:58:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=U1npV
	qNDBpW4WUXfgmfmjrbD8Kydy5EGCIG2ZWZIFJk=; b=kdnqSes+wHaIiRQBSqBN9
	gL250NdXI3E5DR9k37APuvgVSbv98OvN327idWmDzyVdpsUKgUL7g1yqfrhxJcEo
	b+edKySGEaQzQPbb9Vq3UXnzhYmr9oEFK+RQuySPckf19eszT1XO1KcXPZ0kO168
	WPTiTU34DgQwZAIkuFzngD1KzseOPl6mf6y+mSG+ty1vFWKkZQkspSgmIh+H3MCT
	zIVo/7EKWC8VhKWbu9jAU9FLWPHqiZ1zHyPwTHD7+H/ULSMUyd9TZa29dINSiV0+
	bTePWYjzdGdY6NbLfwM501apa8MhEtb4tMdSao+4jqJkVkaEzR9Gdm0sBMf/bLVR
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g19w9hwct-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:08 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDw71q024660
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:07 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:58:07 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:07 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwb006802;
	Thu, 13 Aug 2026 09:57:59 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:02 +0200
Subject: [PATCH v3 09/14] iio: adc: ad7768: Add VCM regulator support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-9-cb554399ad26@analog.com>
References: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
In-Reply-To: <20260813-ad7768-driver-v3-0-cb554399ad26@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=6327;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=VLK6BSdElRIJyRqz8EE1UHbbon9eqmgepSi5c3GZU+c=;
 b=PDnlQaeN+yrJYU+YdN74QhfBVwAsaD1LbWBWc3zUkJTcWMzPOPwbo7GaP6cTjAeTVqgu/WmJn
 dkeFnYS4cBwCqv0KI28fAyZeAGkgtJdmRKBdSlYm+/mxoiPQV3fHbVm
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXxPN4PWPzBPpd
 H8945wl9+2zFP8d6AuPvWfNRFIWR9Ahs9q9MinBRLtw0j0D4DufZwu0GUaFcavuyA0Uy9DZlSkZ
 FHCFG1tUNqIBy9ZqKYapqOs5gjwMCuJzDYUcXkynW/eCKKiOzqeBUYXPqa1AbavH/4XY9U8p/Fq
 GfWrDyM0aZRsA2FmkBK6SHh2BKMjZH2LrewCtV3XKKDpjgh2IyU/ADqQEfB+3Eo0Hj2Ag/26eUC
 FlV+xKWxepBFSf9/X6grIZ1BSiJSG2u8hO6ogLBip/UTnqVYNPkcG1XUGzCl95CG3aghaOB/c9G
 0N4LZ8SLnkY/J7UTAcC6TIasnU6br38wstZA1Q/VDYEHnMkR837g2cO7GES/CjCc3DIlVWzrG4Y
 6iLE1V+LOvaCF834hRSHEvcE+R9Hliw8uic27Nyu6GF8bxxqz48jVZICXg+A51SrboRxbGIT80h
 6KltM3yR1IkC+Ekb3dQ==
X-Proofpoint-GUID: dqTQAvw0e9JdX5RIKaKPsbPPVP4tR-ik
X-Proofpoint-ORIG-GUID: dqTQAvw0e9JdX5RIKaKPsbPPVP4tR-ik
X-Authority-Analysis: v=2.4 cv=f/R4wuyM c=1 sm=1 tr=0 ts=6a7dcd70 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=uXIjobp8t2wMuQ0fPvqm:22 a=gAnH3GRIAAAA:8
 a=-yOam_tWmGQwaYRI1VcA:9 a=QEXdDO2ut3YA:10 a=br55WurUj89AL1qEz8Q6:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX4lbudSvZ9jaK
 Hjt56CeYrixBo6xUoV92IjquphkZn9clNGwyD6C6DJK5X4ljuSRLG9uY5Qg5x48cmZ7qX9yBfrr
 85DV5lalRUKYDfBWCQWP83lgc86h8/c+EcROvXK7fvGMx+b4Yc6w
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0
 phishscore=0 suspectscore=0 clxscore=1015 impostorscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Expose the on-chip common mode voltage output through the regulator
framework. Support the three fixed output levels and the
supply-dependent AVDD1/2 setting.

Keep the ADC runtime active while VCM is enabled and release the runtime
PM reference when the output is disabled.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/iio/adc/ad7768.c | 157 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 155 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ad7768.c b/drivers/iio/adc/ad7768.c
index d332695cc75d..d7151b1fa863 100644
--- a/drivers/iio/adc/ad7768.c
+++ b/drivers/iio/adc/ad7768.c
@@ -22,6 +22,7 @@
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/regulator/driver.h>
 #include <linux/reset.h>
 #include <linux/spi/spi.h>
 #include <linux/time64.h>
@@ -89,6 +90,8 @@
 #define   AD7768_INTERFACE_CFG_CRC_SELECT	FIELD_PREP(GENMASK(3, 2), 0x01)
 
 /* AD7768_REG_GENERAL_CONFIG */
+#define   AD7768_GEN_CONFIG_VCM_SEL_MSK		GENMASK(1, 0)
+#define   AD7768_GEN_CONFIG_VCM_PD		BIT(4)
 /* AD7768_REG_PRECHARGE_BUF1 and 2*/
 #define   AD7768_PREBUF_POS_EN(ch)	BIT((ch) * 2)
 #define   AD7768_PREBUF_NEG_EN(ch)	BIT(((ch) * 2) + 1)
@@ -167,10 +170,154 @@ struct ad7768_state {
 	u64 ch_convdelay_ps[AD7768_MAX_CHANNEL];
 	enum ad7768_filter_type ch_filter[AD7768_MAX_CHANNEL];
 	struct iio_backend *back;
+	struct regulator_dev *vcm_rdev;
+	unsigned int avdd1_uV;
 
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
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
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
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
+	ret = PM_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
+	return regmap_update_bits(st->regmap, AD7768_REG_GENERAL_CONFIG,
+				  AD7768_GEN_CONFIG_VCM_SEL_MSK, selector);
+}
+
+static int ad7768_vcm_get_voltage_sel(struct regulator_dev *rdev)
+{
+	struct ad7768_state *st = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	PM_RUNTIME_ACQUIRE_IF_ENABLED_AUTOSUSPEND(regmap_get_device(st->regmap), pm);
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
+	.of_match = of_match_ptr("vcm-output"),
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
 static const int ad7768_dec_rate[MAX_FREQ_PER_MODE] = {
 	32, 64, 128, 256, 512, 1024,
 };
@@ -1354,10 +1501,12 @@ static int ad7768_probe(struct spi_device *spi)
 
 	st->chip_info = spi_get_device_match_data(spi);
 
-	ret = devm_regulator_get_enable(dev, "avdd1");
-	if (ret)
+	ret = devm_regulator_get_enable_read_voltage(dev, "avdd1");
+	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to enable AVDD1 supply\n");
 
+	st->avdd1_uV = ret;
+
 	ret = devm_regulator_bulk_get_enable(dev,
 					     ARRAY_SIZE(ad7768_supply_names),
 					     ad7768_supply_names);
@@ -1430,6 +1579,10 @@ static int ad7768_probe(struct spi_device *spi)
 	if (ret)
 		return ret;
 
+	ret = ad7768_register_vcm_regulator(dev, st);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to register VCM regulator\n");
+
 	indio_dev->setup_ops = &ad7768_buffer_ops;
 
 	ret = devm_iio_device_register(dev, indio_dev);

-- 
2.43.0

