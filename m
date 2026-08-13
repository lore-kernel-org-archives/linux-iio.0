Received: from mx0b-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E462483BC7;
	Thu, 13 Aug 2026 13:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786629508; cv=none; b=PNXdgPQB2P3FnD5Pk6F9E4gsl+WM8Xt7xucYFrgDyzKOL4kxixQUEjJfd6NS3OPz4q3cPD4ZNxr1svJmSE+TY29LpmlQOi146rkItuca6vgPO8N70GnK72oPWerPjy4bGFo6/pVGmfn/l1Gyx/X2NIgYYViz3KIU3c1cf088axs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786629508; c=relaxed/simple;
	bh=BuxT9qg53qzC6Bm2kjwBO93j/6wjnoLQIvbUESOMCuk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=GQxSxipv+/B5HbjBE/XCpjcdD8Ti37xN0T9FcQfTgrWyvgOsXHSojWQlTHnhi0xp1LwLdwvyBHg0bBl4Vy2oQGCKqRD/zLuMTBaiSW5WJht785FLCfnFKWCxwJxW2yGMB3tXHh+X0pT3TLnqsi61axYnUOCDxqbN42h1aJdjyec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=F/EvL5y5; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="F/EvL5y5"
Received: from pps.filterd (m0375855.ppops.net [127.0.0.1])
	by mx0b-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67DCXRgP1492205;
	Thu, 13 Aug 2026 09:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=HeMrL
	pY9mbTXa0W++ean40OknpJiJccP1J10S41S9pI=; b=F/EvL5y5gJJXYHUBi+hrV
	OV9+srRP34lkyDds7CYfeZPqNP1hszfyHb23yJT5ESy1T5+OaH20wSUmGAR+oaki
	2MnDi8FsCfUeQKoC1/sYNo8yXJes2UAajE2y2e34EuFIt0E/3WyydFG6OYRLxNJU
	RGVYdfJELzkP2AzdV0sLnzwJ8jgqCpn12fDx1S3zm12qfjGNa/8mFl/vhoRVbHQZ
	8LxRzBO6/eOgZq2kdq0aRjKi5knbkWZ2n1Uy/3TIzPDWrfMCV7rDkmDBorfzCIxR
	Zinlqs5TUbaa0l/7ETuTz64iEazzp5yMPcRXTXX/CVkKbHpOFEYy7So8Yttb/OHW
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 4g1e1n8dwc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 09:58:15 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67DDwEL2024672
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 13 Aug 2026 09:58:14 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Thu, 13 Aug
 2026 09:58:14 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 13 Aug 2026 09:58:14 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com (HYB-e1y2fvUQ3cx.ad.analog.com [10.44.3.60])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67DDvOwe006802;
	Thu, 13 Aug 2026 09:58:07 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 13 Aug 2026 15:57:05 +0200
Subject: [PATCH v3 12/14] gpio: regmap: Add optional runtime PM support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260813-ad7768-driver-v3-12-cb554399ad26@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786629444; l=8368;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=BuxT9qg53qzC6Bm2kjwBO93j/6wjnoLQIvbUESOMCuk=;
 b=VOfypmMZviME4WE/ns2ilZBU6CERv1HPdwKvW8FP2/V31hKdORgUlI21J42nvDm7ez8yojIwm
 JbMCUHqSi8WD2tQAWKrSBtwJAHbkpnMYhUcimoWxpOGJ9ETzT6iVqtn
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfX5dxXNbgnt4Xr
 La89m/E23yoRO8i4/bRf6aXGLCQY+Mk0gQtCirJmB/MDjLtlivW+GAfoKoblIuVCrGbdtgPAgl7
 iPbILk2SLoJfwiVog0Jertz7CTDO1uOKI5mFiseBIqPBhf8DjCK/AdDB8v54hHEmBOx8M01crbQ
 a38Zer1T96zhHUtcNLg+v4KXCl40B/RX9CXq1XIxq3abI2aV0WSLejOGfwdx67u5glS8QZ0KHJt
 Z+79VkL0QYKnsnSMtrquAg3zg7AEgVsz/14NMTZQDDg7vs6fVBebImoIlpVqtDAMCEzjxp3nbKJ
 7cEXw7+ZTg8n46o+z/tbsRpVfpokDSToNudMsTxqZCLiT8PKyVpmr6J4Vqwy9VyYVbg9Oi2f36E
 iMm7A8UzSyGUzFgSvWpkOwq2ZhkmnqPTx+cUHA4ZHIG0APbawnVuXg3uoGJx4LYhXXg/QJJPIFX
 G5pGCm4M64HOmg3/EEQ==
X-Proofpoint-ORIG-GUID: EgsbFUSQiCm5IXn5CqxULdKQzVaO4538
X-Proofpoint-GUID: EgsbFUSQiCm5IXn5CqxULdKQzVaO4538
X-Authority-Analysis: v=2.4 cv=fLoJG5ae c=1 sm=1 tr=0 ts=6a7dcd78 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=N--XFCr6TIEc_64PeIT2:22 a=gAnH3GRIAAAA:8
 a=lWN7PXLlU04E1KMc-cYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA5OSBTYWx0ZWRfXy5HUwXddN3MR
 l9cZdODc3Q1+/USE/euDvBnOdkyuNGB6wh0Og3Gv+r2UmCI4KZ9lBMe05Trm6H+SCvup0BDGkBa
 NzuM2ieSnkkIQUQ09osLpQsXsji90yeRwSrKuJGq6PTCm0uO2PX+
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608130099

Some gpio-regmap consumers share their regmap with a parent device that
may be runtime suspended. GPIO register accesses must resume that device
first.

Add an optional pm_dev field and acquire it before register translation
or access. Release it using runtime autosuspend after each operation.
Keep the device active across the complete direction-output sequence and
propagate failure when setting the initial output value.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/gpio/gpio-regmap.c  | 102 ++++++++++++++++++++++++++++++++++++--------
 include/linux/gpio/regmap.h |   2 +
 2 files changed, 87 insertions(+), 17 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index a5188f8569e3..4d5d92c15679 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -10,6 +10,7 @@
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -31,6 +32,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	struct device *pm_dev;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
@@ -67,6 +69,22 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
 	return 0;
 }
 
+static int gpio_regmap_runtime_get(struct gpio_regmap *gpio)
+{
+	if (!gpio->pm_dev)
+		return 0;
+
+	return pm_runtime_resume_and_get(gpio->pm_dev);
+}
+
+static void gpio_regmap_runtime_put(struct gpio_regmap *gpio)
+{
+	if (!gpio->pm_dev)
+		return;
+
+	pm_runtime_put_autosuspend(gpio->pm_dev);
+}
+
 static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
@@ -79,20 +97,28 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm_put;
+
 	/* ensure we don't spoil any register cache with pin input values */
 	if (gpio->reg_dat_base == gpio->reg_set_base) {
 		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
 		if (ret)
-			return ret;
+			goto out_pm_put;
 
-		return !!(val & mask);
+		ret = !!(val & mask);
+	} else {
+		ret = regmap_test_bits(gpio->regmap, reg, mask);
 	}
 
-	return regmap_test_bits(gpio->regmap, reg, mask);
+out_pm_put:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
@@ -103,10 +129,14 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg, mask, mask_val;
 	int ret;
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm_put;
+
 	if (val)
 		mask_val = mask;
 	else
@@ -118,6 +148,8 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		ret = regmap_update_bits(gpio->regmap, reg, mask, mask_val);
 
+out_pm_put:
+	gpio_regmap_runtime_put(gpio);
 	return ret;
 }
 
@@ -128,6 +160,10 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	unsigned int base, reg, mask;
 	int ret;
 
+	ret = gpio_regmap_runtime_get(gpio);
+	if (ret)
+		return ret;
+
 	if (val)
 		base = gpio_regmap_addr(gpio->reg_set_base);
 	else
@@ -135,9 +171,13 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
-		return ret;
+		goto out_pm_put;
 
-	return regmap_write(gpio->regmap, reg, mask);
+	ret = regmap_write(gpio->regmap, reg, mask);
+
+out_pm_put:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static bool gpio_regmap_fixed_direction(struct gpio_regmap *gpio,
@@ -183,18 +223,26 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm_put;
+
 	ret = regmap_test_bits(gpio->regmap, reg, mask);
 	if (ret < 0)
-		return ret;
+		goto out_pm_put;
 
 	if (ret ^ invert)
-		return GPIO_LINE_DIRECTION_OUT;
+		ret = GPIO_LINE_DIRECTION_OUT;
 	else
-		return GPIO_LINE_DIRECTION_IN;
+		ret = GPIO_LINE_DIRECTION_IN;
+
+out_pm_put:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static int gpio_regmap_try_direction_fixed(struct gpio_regmap *gpio,
@@ -237,16 +285,24 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm_put;
+
 	if (invert)
 		val = output ? 0 : mask;
 	else
 		val = output ? mask : 0;
 
-	return regmap_update_bits(gpio->regmap, reg, mask, val);
+	ret = regmap_update_bits(gpio->regmap, reg, mask, val);
+
+out_pm_put:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static int gpio_regmap_direction_input(struct gpio_chip *chip,
@@ -261,6 +317,10 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	int ret;
 
+	ret = gpio_regmap_runtime_get(gpio);
+	if (ret)
+		return ret;
+
 	/*
 	 * First check if this is gonna work on a fixed direction line,
 	 * if it doesn't (i.e. this is a fixed input line), then do not
@@ -269,12 +329,18 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	if (gpio_regmap_fixed_direction(gpio, offset)) {
 		ret = gpio_regmap_try_direction_fixed(gpio, offset, true);
 		if (ret)
-			return ret;
+			goto out_pm_put;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	ret = gpio_regmap_set(chip, offset, value);
+	if (ret)
+		goto out_pm_put;
 
-	return gpio_regmap_set_direction(chip, offset, true);
+	ret = gpio_regmap_set_direction(chip, offset, true);
+
+out_pm_put:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -324,6 +390,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_clr_base = config->reg_clr_base;
 	gpio->reg_dir_in_base = config->reg_dir_in_base;
 	gpio->reg_dir_out_base = config->reg_dir_out_base;
+	gpio->pm_dev = config->pm_dev;
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
@@ -331,7 +398,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->base = -1;
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
-	chip->can_sleep = regmap_might_sleep(config->regmap);
+	chip->can_sleep = config->pm_dev ||
+			  regmap_might_sleep(config->regmap);
 	chip->init_valid_mask = config->init_valid_mask;
 
 	chip->request = gpiochip_generic_request;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..aae32a569914 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -29,6 +29,7 @@ struct regmap;
  * @reg_clr_base:	(Optional) clear register base address
  * @reg_dir_in_base:	(Optional) in setting register base address
  * @reg_dir_out_base:	(Optional) out setting register base address
+ * @pm_dev:		(Optional) Device to use for runtime power management.
  * @reg_stride:		(Optional) May be set if the registers (of the
  *			same type, dat, set, etc) are not consecutive.
  * @ngpio_per_reg:	(Optional) Number of GPIOs per register
@@ -92,6 +93,7 @@ struct gpio_regmap_config {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	struct device *pm_dev;
 	int reg_stride;
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;

-- 
2.43.0

