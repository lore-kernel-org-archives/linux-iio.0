Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4751DE4F1;
	Sun, 26 Jul 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070380; cv=none; b=E1GFfJyh6qo9zf2yUvSqm9bqXromasDVXHCULI6tZDr9uZtEGQEt4dvq4UYYCgr5QVZgFMBZMvccxKx/D5K2671rj47eqRLNDpeuUSw3WApmIljiKzH6afL4eJIDOtkLr+cCdu+O3GnGrv3W20SKIsb3C7/9rctxKtN/oEtF5EA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070380; c=relaxed/simple;
	bh=GY/eNfUDo3Quy5pu+dozGO6ub8c+0hvjHcTzpAI2wFs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYpr2UqifMPgr02ALkugv07kMGNlRcdubETbmnBjNOX7aQVh6LELwZz6maXVEXm2X8azCd2B/FRuNzwty6zv7HBsXytkMM3ZE6wQ+h9JCqfoA4owVydSM6YEKuOiBP6c81y8u+0mB0ICtXEHrIqxTvPhFaesAa7bsoTnKXJspI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=aCKLDuDy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="aCKLDuDy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCq97J12402723, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070330; bh=J5wP9nwD+0ToRbnDRbAySbp6/7xEAP36d/MBYJFLFk8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=aCKLDuDyF3ZkxMHemoMrOrAxxtbNjtCTiXx4UcnqxpDKF4pS9LcDyAtizJWtN8Erc
	 qRJPIMKoZbnvUJdsaLfTdKaM/aXDbr0hN++/06mJ5GKhnceqYJJOx1YMN4Bl8MTi/Y
	 mJcBHEY0yYxV0GTEskBD182pYs9G/ONWA0IJ+XOXybo3YWa7OjBj0JVAFcrp5BJtmj
	 RGqTEkRL+ALfmEEqDfxqsq1e7HRCfzbvIaM5ynzqgLh42kqZ6IADfftnVcIz1e14PA
	 cSuU7UsAQOam/TDva4LIyrxjisfFESc7wKBoixqiGN3WY3zE5qF8t2P0ln54wfldvS
	 /Ne3mlU/Svc7w==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCq97J12402723
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:10 +0800
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
	<james.tai@realtek.com>, <stanley_chang@realtek.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: [PATCH v8 3/9] gpio: regmap: Apply default resource callbacks for regmap IRQ chip
Date: Sun, 26 Jul 2026 20:51:54 +0800
Message-ID: <20260726125209.140307-4-eleanor.lin@realtek.com>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When GPIO regmap creates an IRQ chip on behalf of the user, it also
takes an ownership of the respective callbacks and driver data.
With that being done, apply default resource callbacks that keep
tracking the IRQ requests and releases.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Mathieu Dubois-Briand <mathieu.dubois-briand@bootlin.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v8:
- Add Reviewed-by tags from Mathieu and Linus.
---
 drivers/gpio/gpio-max7360.c |  7 ++++---
 drivers/gpio/gpio-regmap.c  | 14 ++++++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)

diff --git a/drivers/gpio/gpio-max7360.c b/drivers/gpio/gpio-max7360.c
index d12cf1dc8d57..07eda49f375b 100644
--- a/drivers/gpio/gpio-max7360.c
+++ b/drivers/gpio/gpio-max7360.c
@@ -127,7 +127,7 @@ static int max7360_handle_mask_sync(const int index,
 				    const unsigned int mask_buf,
 				    void *const irq_drv_data)
 {
-	struct regmap *regmap = irq_drv_data;
+	struct regmap *regmap = gpio_regmap_get_drvdata(irq_drv_data);
 	int ret;
 
 	for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
@@ -170,7 +170,6 @@ static int max7360_gpio_probe(struct platform_device *pdev)
 
 			/* Create custom IRQ configuration. */
 			irq_chip = devm_kzalloc(dev, sizeof(*irq_chip), GFP_KERNEL);
-			gpio_config.regmap_irq_chip = irq_chip;
 			if (!irq_chip)
 				return -ENOMEM;
 
@@ -181,7 +180,9 @@ static int max7360_gpio_probe(struct platform_device *pdev)
 			irq_chip->num_irqs = MAX7360_MAX_GPIO;
 			irq_chip->irqs = max7360_regmap_irqs;
 			irq_chip->handle_mask_sync = max7360_handle_mask_sync;
-			irq_chip->irq_drv_data = regmap;
+
+			gpio_config.regmap_irq_chip = irq_chip;
+			gpio_config.drvdata = regmap;
 
 			for (unsigned int i = 0; i < MAX7360_MAX_GPIO; i++) {
 				ret = regmap_write_bits(regmap, MAX7360_REG_PWMCFG(i),
diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 535bd9deaa71..658b892b624c 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/bits.h>
+#include <linux/compiler_attributes.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/io.h>
@@ -288,6 +289,16 @@ void gpio_regmap_relres_irq(struct gpio_regmap *gpio, unsigned int offset)
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_relres_irq);
 
+static int __maybe_unused gpio_regmap_irq_reqres(void *irq_drv_data, irq_hw_number_t hwirq)
+{
+	return gpio_regmap_reqres_irq(irq_drv_data, hwirq);
+}
+
+static void __maybe_unused gpio_regmap_irq_relres(void *irq_drv_data, irq_hw_number_t hwirq)
+{
+	gpio_regmap_relres_irq(irq_drv_data, hwirq);
+}
+
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
 {
 	return gpio->driver_data;
@@ -409,6 +420,9 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 #ifdef CONFIG_REGMAP_IRQ
 	if (config->regmap_irq_chip) {
 		gpio->regmap_irq_line = config->regmap_irq_line;
+		config->regmap_irq_chip->irq_reqres = gpio_regmap_irq_reqres;
+		config->regmap_irq_chip->irq_relres = gpio_regmap_irq_relres;
+		config->regmap_irq_chip->irq_drv_data = gpio;
 		ret = regmap_add_irq_chip_fwnode(dev_fwnode(config->parent), config->regmap,
 						 config->regmap_irq_line, config->regmap_irq_flags,
 						 0, config->regmap_irq_chip, &gpio->irq_chip_data);
-- 
2.43.0

