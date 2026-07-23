Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B83A3546C0;
	Thu, 23 Jul 2026 03:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778202; cv=none; b=byk5WVvj8WsQA/qr5kVNJXFjsLcPPBsJDeCqYGurtI+cNoP/CMNVBmBK66VugBnZbp0o/y4AQFDNMKRHLaGiHZSb4JH3ULYLGwPdyjh71p53/Z8JVqTFw+BpsohobJIpXZD5MkBxtolE/WeA56DXepc4iZUx45Eck8xdabM9sBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778202; c=relaxed/simple;
	bh=tfL44FI3uxStwiuVBSv7nfPKODjjXXRvWgd50ghsYP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uCyo0wDAwhfIUrLtnIa0TN798voLvGAWx03Jk0bJf1n+wqQPbNMo3fEvzgSFopR/5hXERvABrDeDcAAHARhhehYenuUWfe4TtH1j0/aj4f8P3gt2t1gy05629k7vD375ALnFTP4D5awd8iz3qddRD1D0tKIBjJGaL/ng7xCJtQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=reQ37FOE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="reQ37FOE"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3gwVU3179527, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784778178; bh=mIpaTj+W0WSXdR2s6Ydth9yG4/Te14E0JihGrEBRZvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=reQ37FOE6mwL7G8Duhqyc/seRFvjWgE8F/N9m45/z4YNHP11j4H/LKiJZuzj3iViJ
	 3QgHmCIDTVv1BVxiwwtNt9Uhn6bz3UYi2uRalZn7e24+tSYUokH7Z/4WwZE2XscZ7z
	 H03RcgPyrOtuoUpyhGSgYuXNa+QrePm4wSAtqOC3ZLI2yVTtzVFFVZm61i9ZVSyxen
	 uF6mUw4tKRUnMeDkfX6uqaeAgw/l9n5BkCnH9umS5pbm861LX9MMO5k6h4OUFSiRh9
	 t1gKimawI326OFupxFO9Bs+WnTvPF7U0ab6Zz1T0g6xGtDSbLN+uv7GO/MUVUvIIEB
	 igdMx7ddary2Q==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3gwVU3179527
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:42:58 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:59 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
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
Subject: [PATCH v7 7/9] gpio: regmap: Add set_config callback
Date: Thu, 23 Jul 2026 11:42:24 +0800
Message-ID: <20260723034237.2501507-8-eleanor.lin@realtek.com>
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

Add a new set_config callback to allow drivers to implement
hardware-specific configuration such as debounce settings, or other
platform-specific GPIO properties.

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v7:
- Drop the reviewed by tag from Andy due to the signature changes.
- Add 'struct gpio_regmap' as the first parameter to the set_config callback.
- Add wrapper to bridge gpio_chip to gpio_regmap.
---
 drivers/gpio/gpio-regmap.c  | 16 ++++++++++++++++
 include/linux/gpio/regmap.h |  6 ++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 8f58b272b870..98cfdd890069 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -51,6 +51,9 @@ struct gpio_regmap {
 			   unsigned int reg, unsigned int *mask,
 			   unsigned int *val);
 
+	int (*set_config)(struct gpio_regmap *gpio, struct gpio_chip *chip,
+			  unsigned int offset, unsigned long config);
+
 	void *driver_data;
 };
 
@@ -317,6 +320,15 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	return gpio_regmap_set_direction(chip, offset, true);
 }
 
+static int gpio_regmap_set_config(struct gpio_chip *chip,
+				  unsigned int offset,
+				  unsigned long cfg)
+{
+	struct gpio_regmap *gpio = gpiochip_get_data(chip);
+
+	return gpio->set_config(gpio, chip, offset, cfg);
+}
+
 int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset)
 {
 	return gpiochip_reqres_irq(&gpio->gpio_chip, offset);
@@ -386,6 +398,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	gpio->reg_clr_base = config->reg_clr_base;
 	gpio->reg_dir_in_base = config->reg_dir_in_base;
 	gpio->reg_dir_out_base = config->reg_dir_out_base;
+	gpio->set_config = config->set_config;
 
 	chip = &gpio->gpio_chip;
 	chip->parent = config->parent;
@@ -455,6 +468,9 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 	gpio->value_xlate = config->value_xlate;
 
+	if (config->set_config)
+		chip->set_config = gpio_regmap_set_config;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap_output;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index b77d6371cd9c..4bf4319ec12e 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -93,6 +93,9 @@ enum gpio_regmap_operation {
  *			mask before writing. This allows driver-specific logic
  *			to append additional bits (like write-enable masks)
  *			dynamically based on the current operation.
+ * @set_config:		(Optional) Callback for setting GPIO configuration such
+ *			as debounce, drive strength, or other hardware specific
+ *			settings.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -154,6 +157,9 @@ struct gpio_regmap_config {
 			   unsigned int base, unsigned int offset, unsigned int reg,
 			   unsigned int *mask, unsigned int *val);
 
+	int (*set_config)(struct gpio_regmap *gpio, struct gpio_chip *chip,
+			  unsigned int offset, unsigned long config);
+
 	void *drvdata;
 };
 
-- 
2.43.0

