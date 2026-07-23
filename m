Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24DEA34DB41;
	Thu, 23 Jul 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778201; cv=none; b=PncDlCxigq4v9dapTU7D0Z5nrKHt1VbMV1+3tqyH/sblx3vzOZr+zjCT0uPzwd/Nzq7ug2lHMq66zZSNauU1ATpeVvQO2gjxkNbpWuBEDMj7tBCOpdBoIkpkOyUjTOxGPVrRaYsIPJ2XEyqZ4m7ilFwSiF2gzYFYxIykzXPILlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778201; c=relaxed/simple;
	bh=7kqs3DMf/R6InNgEjhgwWNhfAWfAjGCag8CXa1NrSNg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V5xOP0mmFCpW/RpuQN7jEpXZ6ATf3R9PiHbKMJ8seWU9W+ku1IuddqtJd7bZQWI+HLc6lN6pL+1ac3P8xZhc7nvHZxDrRjKLR/f08CEn6SVxf5AjMGA0bi+L41EqAlmHfSmb+e7d2H5mRo7Fv8Z3afokC9BGCjI1kqKqDQhgjnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Szt98KMB; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Szt98KMB"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3gw0K3179525, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784778178; bh=DLw0m+6lyX9ieILDuLH9M9GJ5YumVTZVgjbviF3a/d4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Szt98KMBygl0pyY1c1cUROu3wopdDgVC9rYLeKjhWDjw1Y07mD/xnhkOB631xgv0D
	 ZUuIER1o28X+/ljlqVNV/SiMn1LRief24JjtGs2tSD4L9sYdPbGwCbB1eoOqXkMmPz
	 ViNDL1MgHMZ7NWLLQSqwTqxxNOlNjcIMranZ1AL/UDa/lLkn8JDZ7cXoOy6U7wKjt8
	 Pe5m4Jjoe+acWm+XJl6/cpnoxMbynzGuf9Tem7Nsr3osKo+stQsZjrymUyiTTMLjgX
	 Oj3s/bkD36P64RreNKATugG8AAcVkKEneyIpDDwj3sZ9q3YLFIpmoEwkAteRfKrJ0m
	 Fp2ockELqTcKQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3gw0K3179525
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:42:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:58 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Jul 2026 11:42:58 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <andriy.shevchenko@intel.com>, <mwalle@kernel.org>,
	<brgl@kernel.org>, <tychang@realtek.com>, <wbg@kernel.org>,
	<mathieu.dubois-briand@bootlin.com>, <nuno.sa@analog.com>,
	<Michael.Hennerich@analog.com>, <jic23@kernel.org>, <andy@kernel.org>,
	<u.kleine-koenig@baylibre.com>, <dakr@kernel.org>, <bhelgaas@google.com>,
	<o-takashi@sakamocchi.jp>
CC: <eleanor.lin@realtek.com>, <dlechner@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
	<linux@analog.com>, <linux-iio@vger.kernel.org>, <cy.huang@realtek.com>,
	<james.tai@realtek.com>
Subject: [PATCH v7 6/9] gpio: regmap: Add value_xlate callback
Date: Thu, 23 Jul 2026 11:42:23 +0800
Message-ID: <20260723034237.2501507-7-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260723034237.2501507-1-eleanor.lin@realtek.com>
References: <20260723034237.2501507-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Introduce a new optional 'value_xlate' callback. This routine allows drivers
to translate or modify the register value and mask immediately before a write
operation. It is particularly useful for hardware that requires additional
control bits, such as a write-enable bit, to be appended to the data
dynamically.

Suggested-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v7:
- New patch
---
 drivers/gpio/gpio-regmap.c  | 31 ++++++++++++++++++++++++++++++-
 include/linux/gpio/regmap.h |  8 ++++++++
 2 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 1cc9c03ade99..8f58b272b870 100644
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
 
@@ -125,6 +131,13 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
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
@@ -138,7 +151,7 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 				      unsigned int offset, int val)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, reg, mask;
+	unsigned int base, reg, mask, value = 0;
 	int ret;
 
 	if (val)
@@ -150,6 +163,13 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
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
 
@@ -259,6 +279,13 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
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
 
@@ -426,6 +453,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!gpio->reg_mask_xlate)
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
+	gpio->value_xlate = config->value_xlate;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap_output;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index ececc287d519..b77d6371cd9c 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -89,6 +89,10 @@ enum gpio_regmap_operation {
  *			is used.
  * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be used
  *			if not all GPIOs are valid.
+ * @value_xlate:	(Optional) Routine to translate the register value and
+ *			mask before writing. This allows driver-specific logic
+ *			to append additional bits (like write-enable masks)
+ *			dynamically based on the current operation.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -146,6 +150,10 @@ struct gpio_regmap_config {
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

