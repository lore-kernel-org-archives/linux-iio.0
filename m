Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E77367B7B;
	Fri, 28 Aug 2026 15:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787931133; cv=none; b=FqrS7RCQ/xTwuiH22wOWbtFi3YUfF78HEZyBHGDoXaonShE9uuRHQwW/qCDAwpi5Uzh9jInaI37TQtWYFkYhP7NorJl16PpeFju83fz48L5DiqJtqdjqAQlTr36bRAoj1308laPf1185NMIRFq896Yx+iu6fdpVTm6O5NoQF2lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787931133; c=relaxed/simple;
	bh=X1hv+PCpqd//A2k5lOrjjeYljMGeKJeVpAfRmNb21f0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SKLDhSCLSR9Kz/g2DgVF6t2jFNdT6S/Fu1Pwle7ZVQKlX23hWv1UQ0YTyF5UwBfC4crmy0rNcWhNuiM7Q1+rjheSG7+t65usZ+pRvoZt1+9XDR5+sIcF21lgGNor5aTIy1bMZxZLgE6+/jq54yoq1XXvSdBFkoaHACjw+fYZk04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=AVPZ0ZA7; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="AVPZ0ZA7"
Received: from pps.filterd (m0516787.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67SDWNhf2013139;
	Fri, 28 Aug 2026 11:32:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=DKIM; bh=D9vQ2
	V4TfQ3Eqz/lRuMaccfLAZbzWqAduV3RT87Brn0=; b=AVPZ0ZA7+WBUJls/kuryG
	ThLsYDAO06U2ZC2Rp1dch+3kM73+mGrhaMg1yy/3s2QjemVPd7nf0teUh3ZDoTb1
	XFtuebTaNc2ofqgVn3r/S+E5SEOkxJxSVIKJkLdoPvV/RXA5u0wnsuGoTTYALLp7
	w1smfUFWC2OOjAQ42Twra3HgyWtUvwGlXoJUMYeyOLK2irpmu+xZD4eDdv0OvShI
	AGfvjpbk/7bhwoZ77KnaXqhrLXcR6vmDKpQUHwFLH0Wl0aFHOVQIM/PPehhVCDKL
	7dVo3pMEYQakIHYDlangLVl2gk3yrBzedgJSTPHYC3u2/paPfP9dNoJRAnaKHuBR
	g==
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 4ga1m14f20-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 28 Aug 2026 11:32:02 -0400 (EDT)
Received: from ASHBMBX9.ad.analog.com (ASHBMBX9.ad.analog.com [10.64.17.10])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 67SFVxTS013304
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 28 Aug 2026 11:31:59 -0400
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by ASHBMBX9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.37; Fri, 28 Aug
 2026 11:31:59 -0400
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.1748.37 via Frontend
 Transport; Fri, 28 Aug 2026 11:31:59 -0400
Received: from HYB-e1y2fvUQ3cx.ad.analog.com ([10.32.223.174])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 67SFUY3x031424;
	Fri, 28 Aug 2026 11:31:53 -0400
From: Janani Sunil <janani.sunil@analog.com>
Date: Fri, 28 Aug 2026 17:30:41 +0200
Subject: [PATCH v5 18/20] gpio: regmap: Add optional runtime PM support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260828-ad7768-driver-v5-18-e33ca6f841a2@analog.com>
References: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
In-Reply-To: <20260828-ad7768-driver-v5-0-e33ca6f841a2@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787931034; l=6335;
 i=janani.sunil@analog.com; s=20260507; h=from:subject:message-id;
 bh=X1hv+PCpqd//A2k5lOrjjeYljMGeKJeVpAfRmNb21f0=;
 b=t8rrD4WzYq491LKZIZFaPVxNXq7nvzMRPYx5aZ/U0UrbWUyEEjl4h9TgiwoPm9xNqd5DMkNkR
 EEQxNYb4IGMArimVqgIJiVpVp9LpBmsJnyJ2mXQiSOZ1nYcgJ1ao8F3
X-Developer-Key: i=janani.sunil@analog.com; a=ed25519;
 pk=e25MyjRLPY3RWrYm/LrJ+/+t1MZJUbkgIW5CZg+g+hA=
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: Gifzs-XWmK891lwg6AcA5oF6AUE9CDK1
X-Authority-Analysis: v=2.4 cv=NtLhtcdJ c=1 sm=1 tr=0 ts=6a91a9f2 cx=c_pps
 a=3WNzaoukacrqR9RwcOSAdA==:117 a=3WNzaoukacrqR9RwcOSAdA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=0sLvza09kfJOxVLZPwjg:22 a=OmVn7CZJonkx5R5zMQLL:22 a=gAnH3GRIAAAA:8
 a=3fJ8ZLtifNgCll64qzMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Gifzs-XWmK891lwg6AcA5oF6AUE9CDK1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfX0MDhN7Qk3A/r
 lvrFDJeLiQBUhhfMYZjMyE+tEauYLitb29aiowsaESGNheDVCIXBJHXB7W7QYvkH2GNmfYhBo+v
 2nehZTELgq7oj7JYB8v1oUkaDJwLqtzkioHgP6ph5b+Xk05ygb917xDvn275a9E5uI0/8J0IvlE
 AQYXHkGD4yMOng/V+UT9v/3ZmCLM8WezhT2nQlMS9QTEtKKEPDSlLRneqOSK7K3/i+KVwId0Miy
 p7llwsK7zx1jNBpd9HHkdnTwapXWlcK4k8SWVRUiV9QcU4eQ50ZKl/X6bIYO6lw1yQBYytkV0Wg
 P/tC9/coZQpkIGs33hRiRbSzQFSiLIKu9DrXLlBfedqPFsP/RVBmwfxjpGGU9UVtUQ/GSPafySx
 CnNporusssXqie+vS6Kyh3PNKbl/o0ZQuJT8jJcxLsnDAFJhP3tsjjjLD/qyi0tivLn2Nwg9N5L
 nUt9HFKVOXI+Zo+yTXg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI4MDEzNSBTYWx0ZWRfXzkRGMeIA24W7
 9ZUfeWptFZg0hSudV1Gw2eOty2hpO1ZaUeSWipI9GTlOC8jClAplJAu1l8UhaxRvuB+hqGbHRwN
 u/yH65NmxvaAPP8wmDPvA/AJTXvMMY0vCKE8msrIuF6TE2Tu1E6I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-28_04,2026-08-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 adultscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608280135

Some gpio-regmap consumers share their regmap with a parent device that
may be runtime suspended. GPIO register accesses must resume that device
first.

Add an optional pm_dev field and acquire it before register translation
or access. Release it using runtime autosuspend after each operation.
Keep the device active across the complete direction-output sequence and
propagate failure when setting the initial output value.

Signed-off-by: Janani Sunil <janani.sunil@analog.com>
---
 drivers/gpio/gpio-regmap.c  | 67 +++++++++++++++++++++++++++++++++++++++++++--
 include/linux/gpio/regmap.h |  2 ++
 2 files changed, 67 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 0012e03d0d4e..154916050ac5 100644
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
@@ -23,6 +25,7 @@ struct gpio_regmap {
 	struct device *parent;
 	struct regmap *regmap;
 	struct gpio_chip gpio_chip;
+	struct device *pm_dev;
 
 	int reg_stride;
 	int ngpio_per_reg;
@@ -67,6 +70,33 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
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
+#define GPIO_REGMAP_RUNTIME_ACQUIRE(_gpio, _var) \
+	ACQUIRE(gpio_regmap_runtime_try, _var)(_gpio)
+
+#define GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(_var_ptr) \
+	ACQUIRE_ERR(gpio_regmap_runtime, _var_ptr)
+
 static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
@@ -79,6 +109,11 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
+	GPIO_REGMAP_RUNTIME_ACQUIRE(gpio, pm);
+	ret = GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -102,6 +137,11 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg, mask, mask_val;
 	int ret;
 
+	GPIO_REGMAP_RUNTIME_ACQUIRE(gpio, pm);
+	ret = GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -127,6 +167,11 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	unsigned int base, reg, mask;
 	int ret;
 
+	GPIO_REGMAP_RUNTIME_ACQUIRE(gpio, pm);
+	ret = GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	if (val)
 		base = gpio_regmap_addr(gpio->reg_set_base);
 	else
@@ -182,6 +227,11 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
+	GPIO_REGMAP_RUNTIME_ACQUIRE(gpio, pm);
+	ret = GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -236,6 +286,11 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
+	GPIO_REGMAP_RUNTIME_ACQUIRE(gpio, pm);
+	ret = GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
@@ -260,6 +315,11 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
 	int ret;
 
+	GPIO_REGMAP_RUNTIME_ACQUIRE(gpio, pm);
+	ret = GPIO_REGMAP_RUNTIME_ACQUIRE_ERR(&pm);
+	if (ret)
+		return ret;
+
 	/*
 	 * First check if this is gonna work on a fixed direction line,
 	 * if it doesn't (i.e. this is a fixed input line), then do not
@@ -271,7 +331,9 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 			return ret;
 	}
 
-	gpio_regmap_set(chip, offset, value);
+	ret = gpio_regmap_set(chip, offset, value);
+	if (ret)
+		return ret;
 
 	return gpio_regmap_set_direction(chip, offset, true);
 }
@@ -323,6 +385,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_clr_base = config->reg_clr_base;
 	gpio->reg_dir_in_base = config->reg_dir_in_base;
 	gpio->reg_dir_out_base = config->reg_dir_out_base;
+	gpio->pm_dev = config->pm_dev;
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
@@ -330,7 +393,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	chip->base = -1;
 	chip->names = config->names;
 	chip->label = config->label ?: dev_name(config->parent);
-	chip->can_sleep = regmap_might_sleep(config->regmap);
+	chip->can_sleep = config->pm_dev || regmap_might_sleep(config->regmap);
 	chip->init_valid_mask = config->init_valid_mask;
 
 	chip->request = gpiochip_generic_request;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..ba68d8cbd38d 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -18,6 +18,7 @@ struct regmap;
  * @parent:		The parent device
  * @regmap:		The regmap used to access the registers
  *			given, the name of the device is used
+ * @pm_dev:		(Optional) Device to use for runtime power management.
  * @fwnode:		(Optional) The firmware node.
  *			If not given, the fwnode of the parent is used.
  * @label:		(Optional) Descriptive name for GPIO controller.
@@ -81,6 +82,7 @@ struct regmap;
 struct gpio_regmap_config {
 	struct device *parent;
 	struct regmap *regmap;
+	struct device *pm_dev;
 	struct fwnode_handle *fwnode;
 
 	const char *label;

-- 
2.43.0

