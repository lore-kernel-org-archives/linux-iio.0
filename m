Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C131C84A0;
	Sun, 26 Jul 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070378; cv=none; b=VHii4bao4XYj/4DAY4aJS0Zr6zFQn9zkakpN4H1Y5518oYm4kqD3C5GTvpAEadspYaPDVt+c/gyo/Y2lBBkypN2KQp728/QHTwXyaNuvrsXGfdnEeOAryVbBDB38WJxM0Da8o4IFl1iAKkaQ8LbduS4QTzeTkgHwM9e3DmzCP9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070378; c=relaxed/simple;
	bh=1v/pedrLaK/2cfPnyaiWM0xgw809x1bLiJD2fMiEuK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tPntGIH4ZKfnc//cZqMJM/YffyQdimUNmxuDLclh2PuD5gNo/eW1pRfR+xW21beyeu/Hk7PnQpuKDTF91fh9icEYQ15/Q/iZzUrgXPpTfqZmipn8HugeyqCxq+F9zj7dGC+vFbqIXWxpwrJNCmyj4EI7dCGKdAZthCFHM7QUljw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZtpF3WEU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZtpF3WEU"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCqAjfD2402731, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070330; bh=RC74IvE+kVsuLivMcMU03RBe1FO5XZXLfYOiBtFc41Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=ZtpF3WEUOXdbYFhVyvDlRtoBOfK0lVqwbV20twgdD8ezdezPxCkRp9c3wVAtfhgOX
	 TQFV4mirdcSC7C320+S2n6QhZM8ibLIaMX/MigXWGpWi3ceJSm4trtjADsAhrEq9AQ
	 mQvF/hdYj0Mu3VM0d9OJhGmw4xVaKa0yqi8VZIh//am5AtlYEhPgAIAD8YDxteG2iZ
	 /bqwDVB3MT+sTY2hsH6deoMQFnkhr9w2+0ED96avfWKOkktbyC8XC8QBzWqBPu+Z/Q
	 zy3ZEt6PsPNCy9368PgRS0sjcAFV+Y7rJDrdKWmWs+rSb+0OCzAiw2RfWIW1nYDk5q
	 wyxHZoC3t79bA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCqAjfD2402731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:10 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Jul 2026 20:52:10 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <andriy.shevchenko@intel.com>, <mwalle@kernel.org>,
	<brgl@kernel.org>, <tychang@realtek.com>, <wbg@kernel.org>,
	<mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
	<o-takashi@sakamocchi.jp>
CC: <u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<eleanor.lin@realtek.com>, <dlechner@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
	<james.tai@realtek.com>, <stanley_chang@realtek.com>
Subject: [PATCH v8 6/9] gpio: regmap: Add value_xlate callback
Date: Sun, 26 Jul 2026 20:51:57 +0800
Message-ID: <20260726125209.140307-7-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726125209.140307-1-eleanor.lin@realtek.com>
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Introduce a new optional 'value_xlate' callback. This routine allows drivers
to translate or modify the register value and mask immediately before a write
operation. It is particularly useful for hardware that requires additional
control bits, such as a write-enable bit, to be appended to the data
dynamically.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v8:
- Add Reviewed-by tags from Michael and Linus.
- Improve kernel-doc comments for 'enum gpio_regmap_operation' and value_xlate.
---
 drivers/gpio/gpio-regmap.c  | 31 ++++++++++++++++++++++++++++++-
 include/linux/gpio/regmap.h | 15 ++++++++++++---
 2 files changed, 42 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index ceab805d053c..cff7db8036f7 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -45,6 +45,12 @@ struct gpio_regmap {
 			      unsigned int base, unsigned int offset,
 			      unsigned int *reg, unsigned int *mask);
 
+	int (*value_xlate)(struct gpio_regmap *gpio,
+			   enum gpio_regmap_operation op,
+			   unsigned int base, unsigned int offset,
+			   unsigned int reg, unsigned int *mask,
+			   unsigned int *val);
+
 	void *driver_data;
 };
 
@@ -114,6 +120,13 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		mask_val = 0;
 
+	if (gpio->value_xlate) {
+		ret = gpio->value_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset,
+					reg, &mask, &mask_val);
+		if (ret)
+			return ret;
+	}
+
 	/* ignore input values which shadow the old output value */
 	if (gpio->reg_dat_base == gpio->reg_set_base)
 		ret = regmap_write_bits(gpio->regmap, reg, mask, mask_val);
@@ -127,7 +140,7 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 				      unsigned int offset, int val)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, reg, mask;
+	unsigned int base, reg, mask, value = 0;
 	int ret;
 
 	if (val)
@@ -139,6 +152,13 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	if (ret)
 		return ret;
 
+	if (gpio->value_xlate) {
+		ret = gpio->value_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset,
+					reg, &mask, &value);
+		if (ret)
+			return ret;
+	}
+
 	return regmap_write(gpio->regmap, reg, mask);
 }
 
@@ -248,6 +268,13 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 	else
 		val = output ? mask : 0;
 
+	if (gpio->value_xlate) {
+		ret = gpio->value_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base, offset,
+					reg, &mask, &val);
+		if (ret)
+			return ret;
+	}
+
 	return regmap_update_bits(gpio->regmap, reg, mask, val);
 }
 
@@ -415,6 +442,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!gpio->reg_mask_xlate)
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
+	gpio->value_xlate = config->value_xlate;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap_output;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 7eebb6381296..77dbb353bc1f 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -14,13 +14,13 @@ struct regmap;
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
 /**
- * enum gpio_regmap_operation - Operation type for reg_mask_xlate callback
+ * enum gpio_regmap_operation - Operation type for gpio_regmap callbacks
  *
  * Traditionally, the operation type was inferred from the base register.
  * However, that approach does not always work — for example, when all control
  * bits of a single GPIO reside in the same register. This enum allows the
- * reg_mask_xlate callback to explicitly distinguish between operation types.
- * The user is free to choose which method to use.
+ * callbacks (reg_mask_xlate and value_xlate) to explicitly distinguish between
+ * operation types. The user is free to choose which method to use.
  *
  * Read operation:
  * @GPIO_REGMAP_GET_OP: Indicates a read operation to get the current GPIO value.
@@ -81,6 +81,11 @@ enum gpio_regmap_operation {
  *			is used.
  * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be used
  *			if not all GPIOs are valid.
+ * @value_xlate:	(Optional) Routine to translate the register value and
+ *			mask before writing. This allows driver-specific logic
+ *			to append additional bits (like write-enable masks)
+ *			dynamically based on the current operation
+ *			(GPIO_REGMAP_SET_OP and GPIO_REGMAP_SET_DIR_OP).
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -138,6 +143,10 @@ struct gpio_regmap_config {
 			       unsigned long *valid_mask,
 			       unsigned int ngpios);
 
+	int (*value_xlate)(struct gpio_regmap *gpio, enum gpio_regmap_operation,
+			   unsigned int base, unsigned int offset, unsigned int reg,
+			   unsigned int *mask, unsigned int *val);
+
 	void *drvdata;
 };
 
-- 
2.43.0

