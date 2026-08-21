Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4994C8FEF;
	Fri, 21 Aug 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787321345; cv=none; b=MuPFuwoBQVZ05KMOKL8plQSiT9S/Z2XaYCiZrh4zu2/K8/jBudvmqd/51Ru3iUriAhOSwEQhs50VbMBvnlpRejC28OfNQXIT1KsAIa0fNnRtrDqf0h4V7IpUbOvjqIs5lOnjq5rATSPODx+rK91nwwMI09iUtH8CHpr2Ddb+HfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787321345; c=relaxed/simple;
	bh=qAtdMDKoQuyTDGwsahfpRL/dgFjrGIYhZrr36H8o6lY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=DWZxPjNwVvrMDp4C+a6ul+CNt8yQ6v4glaK3LKkjSlWVdCc6lGnN8mV0UIu31RlSHZfbmBqC9a6/xM0v3r++ZZbRRPzg19OzHFUsvjCsbMn7pTCzXxc0DdjK1GWouhjTE5W16dyLDVeRhAlgLE1Qi9vTDuRYEKNkzdmHnkqMGII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=xEKxJUaq; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="xEKxJUaq"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LCpTMm3387957;
	Fri, 21 Aug 2026 10:08:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=R46s5
	fxfiAUeWw76ISw/2grT3/yXiC0NWLVsFCoQ7TQ=; b=xEKxJUaqWRTJ3ay1mulrJ
	3JmD8NVo6/FzPOhQkz1FWRR+esnHs25AmXT/JJaavF/2Nxb4/vH/YXIdZTZywXll
	Jx0Zw/BGYXR3e/RiLXFitnoC30Md6NCWFHk8scJnyFgGNuzZlU9FXC1Shn9qC2kO
	wV6rGlvUfM8bTw+XkCUOAZ9LAWsQAerWVWRatNj8hO3F4YweEBZ1V66vixa96bpx
	HOV4eTmo3BbCiP5XMm4ixqVmCoiSZIfbX7XxL7Ql/kg5fXRfNqcEIZ2T3mpqpwmp
	e+9Hqc9zn3EsDg+RXmfQ3ojJJvr/aXfitFkmDsWgXFODqwYh4gjEF+K6uf75IUB1
	Q==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4g66m6m0jn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 10:08:54 -0400 (EDT)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67LE8rVD033076
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 21 Aug 2026 10:08:53 -0400
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by ASHBMBX8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 21 Aug
 2026 10:08:53 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 21 Aug 2026 10:08:53 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67LE7Kkv024319;
	Fri, 21 Aug 2026 10:08:42 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 21 Aug 2026 16:07:05 +0200
Subject: [PATCH v4 12/14] gpio: regmap: Add optional runtime PM support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260821-ad7768-driver-v4-12-bb8fbd06d4eb@analog.com>
References: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
In-Reply-To: <20260821-ad7768-driver-v4-0-bb8fbd06d4eb@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787321240; l=6305;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=qAtdMDKoQuyTDGwsahfpRL/dgFjrGIYhZrr36H8o6lY=;
 b=PHxPyBfSZbyXwfiaodJzgSw4+bVxOn//gShAPWNu1tdG0kSqVsDtD3/+FMHahzPj2VPElB0oO
 sLjvpDDwsn9AFHnmpIDFtOc42kQajGUFXvYdsj13nfeeKy0aA7d0+az
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX9+zIqF6yBG6w
 5YMMBjZ5aLYY3OuUDril8UDdzYWOnYTueDXnr+OCbK6Eem2itCPo9k+iFWRbgFGqKssbf06lBG/
 xamK09ulQGK/DeQU3cfDgnelpwXTRIoADzrY5a6cyfxkJ0gAe/Si
X-Proofpoint-ORIG-GUID: CTpP0wPXLqnwS2Rk2PjxM3mkjYiIyBYo
X-Proofpoint-GUID: CTpP0wPXLqnwS2Rk2PjxM3mkjYiIyBYo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDEwOSBTYWx0ZWRfX2AQeqmM+9vqs
 4Id3PlUGacjU0BlewgscSDDU5q8KN9eJ5I72uLEXdyqiv9QQPXTiXvB/PAtI9YrdEpUzsPruT3+
 fjxtpXXvNkKjqdWA89FmSA17vp68xClR6DtwqVr6pcYn9J2eB810HtZ7165pP2+Cg18UB1K+UFr
 WvIXk8yhyh8GNWrdM2fwOAuscCqCxdSPlK1icI3gpKFCj2nCjmN+55TtWotKBjlIphcdw4BzcDp
 jubOb6Zzq5zKnSWgveRDdwkZzXUHwwTjFhZs9o3l9Wp2g61KA1I1vVzUhVngWXHlL6D24c52JmX
 EXfWRUa6JpPudAln3MGGiZ4gCH1xL4YKmfhsl0kFxHSnXGeI1xsAe9qTWad48Sk70vRHAZ6MCEB
 jtw6DEu+Op8EzFgPs+hBi2CafKlVP2Y0fm0gjyjCvT1CBuGnB+wrpXZYKpFJJjHo2ZWBNqgbo5l
 W4aTSpSgC/4uNvaDdZw==
X-Authority-Analysis: v=2.4 cv=baVbluPB c=1 sm=1 tr=0 ts=6a885bf6 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=3fJ8ZLtifNgCll64qzMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 impostorscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608210109

Some gpio-regmap consumers share their regmap with a parent device that
may be runtime suspended. GPIO register accesses must resume that device
first.

Add an optional pm_dev field and acquire it before register translation
or access. Release it using runtime autosuspend after each operation.
Keep the device active across the complete direction-output sequence and
propagate failure when setting the initial output value.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/gpio/gpio-regmap.c  | 62 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/gpio/regmap.h |  2 ++
 2 files changed, 62 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 0012e03d0d4e..3e7030e47483 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -6,10 +6,12 @@
  */
 
 #include <linux/bits.h>
+#include <linux/cleanup.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/types.h>
@@ -31,6 +33,7 @@ struct gpio_regmap {
 	unsigned int reg_clr_base;
 	unsigned int reg_dir_in_base;
 	unsigned int reg_dir_out_base;
+	struct device *pm_dev;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 
@@ -67,6 +70,27 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
 	return 0;
 }
 
+static int gpio_regmap_runtime_get(struct gpio_regmap *gpio)
+{
+	if (!gpio->pm_dev)
+		return 0;
+
+	return pm_runtime_get_active(gpio->pm_dev, RPM_TRANSPARENT);
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
+DEFINE_GUARD(gpio_regmap_runtime, struct gpio_regmap *,
+	     gpio_regmap_runtime_get(_T), gpio_regmap_runtime_put(_T))
+DEFINE_GUARD_COND(gpio_regmap_runtime, _try,
+		  gpio_regmap_runtime_get(_T), _RET == 0)
+
 static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
@@ -79,6 +103,11 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
+	ACQUIRE(gpio_regmap_runtime_try, pm)(gpio);
+	ret = ACQUIRE_ERR(gpio_regmap_runtime_try, &pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -102,6 +131,11 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg, mask, mask_val;
 	int ret;
 
+	ACQUIRE(gpio_regmap_runtime_try, pm)(gpio);
+	ret = ACQUIRE_ERR(gpio_regmap_runtime_try, &pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -127,6 +161,11 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	unsigned int base, reg, mask;
 	int ret;
 
+	ACQUIRE(gpio_regmap_runtime_try, pm)(gpio);
+	ret = ACQUIRE_ERR(gpio_regmap_runtime_try, &pm);
+	if (ret)
+		return ret;
+
 	if (val)
 		base = gpio_regmap_addr(gpio->reg_set_base);
 	else
@@ -182,6 +221,11 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
+	ACQUIRE(gpio_regmap_runtime_try, pm)(gpio);
+	ret = ACQUIRE_ERR(gpio_regmap_runtime_try, &pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -236,6 +280,11 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
+	ACQUIRE(gpio_regmap_runtime_try, pm)(gpio);
+	ret = ACQUIRE_ERR(gpio_regmap_runtime_try, &pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -260,6 +309,11 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	int ret;
 
+	ACQUIRE(gpio_regmap_runtime_try, pm)(gpio);
+	ret = ACQUIRE_ERR(gpio_regmap_runtime_try, &pm);
+	if (ret)
+		return ret;
+
 	/*
 	 * First check if this is gonna work on a fixed direction line,
 	 * if it doesn't (i.e. this is a fixed input line), then do not
@@ -271,7 +325,9 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 			return ret;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	ret = gpio_regmap_set(chip, offset, value);
+	if (ret)
+		return ret;
 
 	return gpio_regmap_set_direction(chip, offset, true);
 }
@@ -323,6 +379,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_clr_base = config->reg_clr_base;
 	gpio->reg_dir_in_base = config->reg_dir_in_base;
 	gpio->reg_dir_out_base = config->reg_dir_out_base;
+	gpio->pm_dev = config->pm_dev;
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
@@ -330,7 +387,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->base = -1;
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
-	chip->can_sleep = regmap_might_sleep(config->regmap);
+	chip->can_sleep = config->pm_dev ||
+			  regmap_might_sleep(config->regmap);
 	chip->init_valid_mask = config->init_valid_mask;
 
 	chip->request = gpiochip_generic_request;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..eceb31b89f50 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -34,6 +34,7 @@ struct regmap;
  * @ngpio_per_reg:	(Optional) Number of GPIOs per register
  * @irq_domain:		(Optional) IRQ domain if the controller is
  *			interrupt-capable
+ * @pm_dev:		(Optional) Device to use for runtime power management.
  * @reg_mask_xlate:     (Optional) Translates base address and GPIO
  *			offset to a register/bitmask pair. If not
  *			given the default gpio_regmap_simple_xlate()
@@ -95,6 +96,7 @@ struct gpio_regmap_config {
 	int reg_stride;
 	int ngpio_per_reg;
 	struct irq_domain *irq_domain;
+	struct device *pm_dev;
 	unsigned long *fixed_direction_mask;
 	unsigned long *fixed_direction_output;
 

-- 
2.43.0

