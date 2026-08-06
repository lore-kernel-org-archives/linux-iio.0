Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77BC9480DCB;
	Thu,  6 Aug 2026 15:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786030956; cv=none; b=b3SrA7fMrHRgSdd+UUSz+yU+Ak9OTPFtQKAmvHTlkVJ25p+Zhpfr6GQilBARB38hHxknmZ1kTOcjoiyCufaQaYUrg/yyXgFYUfP1Kk7usV5IidQHviI6DGwUeQ3b0ZJC2hghBoLWQ1o8no1EmPuSsrRfZ729hDOnzIOS1FYXfb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786030956; c=relaxed/simple;
	bh=/J4IRhEi1Bc31VvVWteTE9nhuF4aaDgvc9V2RLSwc80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=rXvSM7hoeBNF+61CaijvvXPGqqqB1L5bn/MFgUilS1Z0XtH8FOKBltrB+TneiJCyaCmI7VckwnihVAhyWHIxJ9wwUCSJFDdWRvIEsSX7tVHQJ0UXPZX+jZ4qiIQP8r3QWY0Q6qeWDAxakCxjEUYKz/7GSpa6+Bz7t6q3XRb9n6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=egs6f8Mc; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="egs6f8Mc"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676Epu6u3854093;
	Thu, 6 Aug 2026 11:42:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=msoAY
	y/zJHdbdQLuhzc7AsOoqBDGP5sUvrwmvPG/DZY=; b=egs6f8McJNtlZ9tfF8BLX
	jymMnaFbPe5faeKeqrKJfoIvTsvE6Dn/BuXIyO6ZtJVmswqeibihLWOr8o7VZISN
	Q0MgF2dpQQtSGv2+Dkjih7gCmyLLjqvScWS3eUIDpdJxvXbhnKoRC6uWTBlzlQQ2
	fMpeK3WbYxdMPHMI7Dtw/OM7IVqzjXDtE1Bt44rRbyGDEFVu5pJJnMhGdPED3DBh
	R+Wlt4CZvPy/o7w1HjAlgYarDntbgI7IdRiPeNotbuMUsJB/RLgvuaClWXRlb++K
	s3+iArQpU5Q/7Javsg834Nf/5N2fjNhsVJZNnLGMoDCbBCVJH2yX0evwm1tffk7h
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4fvrcpsf7c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 11:42:20 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 676FgJ41007050
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 6 Aug 2026 11:42:19 -0400
Received: from ASHBCASHYB5.ad.analog.com (10.64.17.133) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:19 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB5.ad.analog.com (10.64.17.133) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.37; Thu, 6 Aug 2026 11:42:18 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Thu, 6 Aug 2026 11:42:18 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 676Ffcgc008127;
	Thu, 6 Aug 2026 11:42:11 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Thu, 6 Aug 2026 17:41:24 +0200
Subject: [PATCH v2 5/7] gpio: regmap: Add runtime PM and
 read_output_reg_set support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260806-ad7768-driver-v2-5-027ac5e2a641@analog.com>
References: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
In-Reply-To: <20260806-ad7768-driver-v2-0-027ac5e2a641@analog.com>
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
        Michael Walle <mwalle@kernel.org>
CC: <linux@analog.com>, <linux-iio@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <jananisunil.dev@gmail.com>,
        =?utf-8?q?Uwe_Kleine-K=C3=B6nig?=
	<u.kleine-koenig@baylibre.com>,
        Janani Sunil <janani.sunil@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786030898; l=8989;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=/J4IRhEi1Bc31VvVWteTE9nhuF4aaDgvc9V2RLSwc80=;
 b=CpzPjC/nhIdYdmsGrUhbghsCg8PBgykMIJvgB2P3PDJHu+ieI5hWghototroTZA4EOeshvkLh
 uLEuDAFihodBNHEEeyEZ13s8q4duokJmc4NyK8/aP2CBDpjhSY5VU8R
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: zzTwpDpinh5LNQsE1zKm7qFTHfSKVyFI
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX6wuS7tq0EiKs
 fTTdT0HEK2R4RHiPJBd0roTUjx0qGTDDsVOhFOsaFr6zwsT+vmB/jd2ThgVp6Bs8eIb2/sAI5Qb
 +tpqEuYd9E/8rQZnPvhVMe5ye9JyNzcMBn91W2XzWDTE7TZtod4a
X-Proofpoint-ORIG-GUID: zzTwpDpinh5LNQsE1zKm7qFTHfSKVyFI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEyMSBTYWx0ZWRfX1P9ZZhPrWXS3
 EfEl9sRhKSRP8oyKI0Vj8kjQ4m87YQGkU8HQG+hns7dA+GbY4ZH0bMz68hW0L6Pz3pNKDWvcnVo
 HioBYE0Cq4/w9DeIgyaLmgtiUMJSUaTrzmsUTN2yG0ZkCQaFJQ5SBPvjPVSmI9Xc8FQA0J1i5qV
 3qplp9KaYoPU69MWbGY0yHmRA1J4qLv2xMTYiIwelfnxhw+PFXEFH+DizeWCT/ZDTAVj+Rirbd3
 Vg2rwq7Pj1t6YdCmW7ECezrKHEX27h+8uDVSQ8vHizBi73ijJEkgC0KOReqwJuXHieM/QSfqBU6
 PYV3lxlKWeSVhn9tt9C6E5Tf8xYrpyCwRArdYGf9qR4c8mUllDa3nShdpBZ45vtAWGltK6dQ5uq
 S2K1OhjaOujaMfbx0Qp576P8y/NERcBa1pw3JeSoBe2qMU74wm2vnm/tUBxv8qaW3JGw7gug2oD
 AjOauuCl2ILjhX2ZWeA==
X-Authority-Analysis: v=2.4 cv=IPwyzAvG c=1 sm=1 tr=0 ts=6a74ab5c cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=WNRwWYYUYu9DqMPRriAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_01,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060121

The new pm_dev field in gpio_regmap_config allows a driver to supply a
device for runtime PM. All operations call pm_runtime_resume_and_get()
before accessing the regmap and pm_runtime_put_autosuspend() on return.

The new read_output_reg_set flag when set, gpio_regmap_get() checks the
pin direction first and reads from reg_set_base instead of reg_dat_base
for output pins. Requires both reg_dat_base and reg_set_base to be
configured.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/gpio/gpio-regmap.c  | 113 +++++++++++++++++++++++++++++++++++++-------
 include/linux/gpio/regmap.h |   8 ++++
 2 files changed, 105 insertions(+), 16 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..b94d3c51013a 100644
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
@@ -31,6 +32,8 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	struct device *pm_dev;
+	bool read_output_reg_set;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
@@ -67,6 +70,23 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
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
+	if (gpio->pm_dev)
+		pm_runtime_put_autosuspend(gpio->pm_dev);
+}
+
+static int gpio_regmap_get_direction(struct gpio_chip *chip,
+				     unsigned int offset);
+
 static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
@@ -79,19 +99,34 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (gpio->read_output_reg_set) {
+		ret = gpio_regmap_get_direction(chip, offset);
+		if (ret < 0)
+			return ret;
+
+		if (ret == GPIO_LINE_DIRECTION_OUT)
+			base = gpio_regmap_addr(gpio->reg_set_base);
+	}
+
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm;
+
 	/* ensure we don't spoil any register cache with pin input values */
 	if (gpio->reg_dat_base == gpio->reg_set_base)
 		ret = regmap_read_bypassed(gpio->regmap, reg, &val);
 	else
 		ret = regmap_read(gpio->regmap, reg, &val);
-	if (ret)
-		return ret;
+	if (!ret)
+		ret = !!(val & mask);
 
-	return !!(val & mask);
+out_pm:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
@@ -102,10 +137,14 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg, mask, mask_val;
 	int ret;
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm;
+
 	if (val)
 		mask_val = mask;
 	else
@@ -117,6 +156,8 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		ret = regmap_update_bits(gpio->regmap, reg, mask, mask_val);
 
+out_pm:
+	gpio_regmap_runtime_put(gpio);
 	return ret;
 }
 
@@ -127,6 +168,10 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	unsigned int base, reg, mask;
 	int ret;
 
+	ret = gpio_regmap_runtime_get(gpio);
+	if (ret)
+		return ret;
+
 	if (val)
 		base = gpio_regmap_addr(gpio->reg_set_base);
 	else
@@ -134,9 +179,13 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
-		return ret;
+		goto out_pm;
+
+	ret = regmap_write(gpio->regmap, reg, mask);
 
-	return regmap_write(gpio->regmap, reg, mask);
+out_pm:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static bool gpio_regmap_fixed_direction(struct gpio_regmap *gpio,
@@ -182,18 +231,26 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm;
+
 	ret = regmap_read(gpio->regmap, reg, &val);
 	if (ret)
-		return ret;
+		goto out_pm;
 
 	if (!!(val & mask) ^ invert)
-		return GPIO_LINE_DIRECTION_OUT;
+		ret = GPIO_LINE_DIRECTION_OUT;
 	else
-		return GPIO_LINE_DIRECTION_IN;
+		ret = GPIO_LINE_DIRECTION_IN;
+
+out_pm:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static int gpio_regmap_try_direction_fixed(struct gpio_regmap *gpio,
@@ -236,16 +293,24 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio_regmap_runtime_get(gpio);
 	if (ret)
 		return ret;
 
+	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	if (ret)
+		goto out_pm;
+
 	if (invert)
 		val = output ? 0 : mask;
 	else
 		val = output ? mask : 0;
 
-	return regmap_update_bits(gpio->regmap, reg, mask, val);
+	ret = regmap_update_bits(gpio->regmap, reg, mask, val);
+
+out_pm:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 static int gpio_regmap_direction_input(struct gpio_chip *chip,
@@ -260,6 +325,10 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	int ret;
 
+	ret = gpio_regmap_runtime_get(gpio);
+	if (ret)
+		return ret;
+
 	/*
 	 * First check if this is gonna work on a fixed direction line,
 	 * if it doesn't (i.e. this is a fixed input line), then do not
@@ -268,12 +337,18 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	if (gpio_regmap_fixed_direction(gpio, offset)) {
 		ret = gpio_regmap_try_direction_fixed(gpio, offset, true);
 		if (ret)
-			return ret;
+			goto out_pm;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	ret = gpio_regmap_set(chip, offset, value);
+	if (ret)
+		goto out_pm;
+
+	ret = gpio_regmap_set_direction(chip, offset, true);
 
-	return gpio_regmap_set_direction(chip, offset, true);
+out_pm:
+	gpio_regmap_runtime_put(gpio);
+	return ret;
 }
 
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
@@ -307,6 +382,10 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	    (!config->reg_dat_base || !config->reg_set_base))
 		return ERR_PTR(-EINVAL);
 
+	if (config->read_output_reg_set &&
+	    (!config->reg_dat_base || !config->reg_set_base))
+		return ERR_PTR(-EINVAL);
+
 	/* we don't support having both registers simultaneously for now */
 	if (config->reg_dir_out_base && config->reg_dir_in_base)
 		return ERR_PTR(-EINVAL);
@@ -323,6 +402,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_clr_base = config->reg_clr_base;
 	gpio->reg_dir_in_base = config->reg_dir_in_base;
 	gpio->reg_dir_out_base = config->reg_dir_out_base;
+	gpio->pm_dev = config->pm_dev;
+	gpio->read_output_reg_set = config->read_output_reg_set;
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..5b353ae5b167 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -3,6 +3,8 @@
 #ifndef _LINUX_GPIO_REGMAP_H
 #define _LINUX_GPIO_REGMAP_H
 
+#include <linux/types.h>
+
 struct device;
 struct fwnode_handle;
 struct gpio_regmap;
@@ -29,6 +31,10 @@ struct regmap;
  * @reg_clr_base:	(Optional) clear register base address
  * @reg_dir_in_base:	(Optional) in setting register base address
  * @reg_dir_out_base:	(Optional) out setting register base address
+ * @pm_dev:		(Optional) Device to use for runtime power management.
+ * @read_output_reg_set:
+ *			(Optional) Read output values from @reg_set_base
+ *			instead of @reg_dat_base.
  * @reg_stride:		(Optional) May be set if the registers (of the
  *			same type, dat, set, etc) are not consecutive.
  * @ngpio_per_reg:	(Optional) Number of GPIOs per register
@@ -92,6 +98,8 @@ struct gpio_regmap_config {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	struct device *pm_dev;
+	bool read_output_reg_set;
 	int reg_stride;
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;

-- 
2.43.0

