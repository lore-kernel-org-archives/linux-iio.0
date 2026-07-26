Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C7D1D432D;
	Sun, 26 Jul 2026 12:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070378; cv=none; b=EDLGwJG4ol/O54vKOoSDIjAnE7HaXB3nx0MTjznBkFHhShKKltMRM2eRLEP1KvnWnuqyDD4f9TW/WN7IzCzaRDVv66kYwWMn+ls5b77GoMebJp5yrhmDeJPGoNK637ON9akALOO4ngtRuMdOHFf+A/bjugBwTNW41WnT39quitI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070378; c=relaxed/simple;
	bh=OWcmyoGqocFCpC2D8zd96uNdqooxzF119BFHm7mBs2Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BpAr1F78uIFUkC9pl2Jh+/JQiBUV5A2JDmoRzb1B6Q4Eqc46tH2luoiSajiUZXXaoNqCfZi5L6Wm3P2hthiSHhoyD3NBHtaMZLlhXQNcXsMTCEAOyo0wrwuZMbZUgMpMVzlrLcNelnHwF54Ic2z5kpKr3D36w8TbfNqKaLe32JU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=i5TBMkXP; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="i5TBMkXP"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCqAPz92402733, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070331; bh=2wBKzpUIcxPGBn69FmoQsTNplv+kb/xZ96H/rlz56d4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=i5TBMkXPxLd7ZFKz6rN9IC2/wbjJWlgcgD9EWdf26hJrVElqxyMbp13e8uSXq6HRw
	 YxBQexQRyynNteQvAHIWD6PsdVx64q1BDIcEvJT/sTBI/J6F4wb4D/SBeCsC+Bn2Wa
	 8pcIPXZUpGAK+X/Vi/z83tdwKncMfXZumu5F21s9iqV039b9EVnK6UJnIJiNYYcQaz
	 d5VlKZyz2B1KV3vPxPh2FnBePQ3jhBUis6XZn9TdQRXuEhlmUrTaZ+ixbFYAMwtexm
	 agVpQhwLriIDVVoFCnaz6CpSfuDmBiNBugMGL7Bjm5QZrx1vKorE3IH8Jv5xHP4KWm
	 rAwsfE+rI6VEQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCqAPz92402733
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:11 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:11 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Jul 2026 20:52:11 +0800
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
Subject: [PATCH v8 7/9] gpio: regmap: Add set_config callback
Date: Sun, 26 Jul 2026 20:51:58 +0800
Message-ID: <20260726125209.140307-8-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726125209.140307-1-eleanor.lin@realtek.com>
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
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

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v8:
- Move the assignment of gpio->set_config into the if (config->set_config)
block.
- Add Reviewed-by tags from Michael and Linus.
---
 drivers/gpio/gpio-regmap.c  | 17 +++++++++++++++++
 include/linux/gpio/regmap.h |  6 ++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index cff7db8036f7..19e33e361cc4 100644
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
 
@@ -306,6 +309,15 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
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
@@ -444,6 +456,11 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 
 	gpio->value_xlate = config->value_xlate;
 
+	if (config->set_config) {
+		gpio->set_config = config->set_config;
+		chip->set_config = gpio_regmap_set_config;
+	}
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap_output;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 77dbb353bc1f..dd9de9958409 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -86,6 +86,9 @@ enum gpio_regmap_operation {
  *			to append additional bits (like write-enable masks)
  *			dynamically based on the current operation
  *			(GPIO_REGMAP_SET_OP and GPIO_REGMAP_SET_DIR_OP).
+ * @set_config:		(Optional) Callback for setting GPIO configuration such
+ *			as debounce, drive strength, or other hardware specific
+ *			settings.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -147,6 +150,9 @@ struct gpio_regmap_config {
 			   unsigned int base, unsigned int offset, unsigned int reg,
 			   unsigned int *mask, unsigned int *val);
 
+	int (*set_config)(struct gpio_regmap *gpio, struct gpio_chip *chip,
+			  unsigned int offset, unsigned long config);
+
 	void *drvdata;
 };
 
-- 
2.43.0

