Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D0C22D7A9;
	Sun, 26 Jul 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070382; cv=none; b=XHWILFVlCVpD6N/DLooNpQu9uacwSmigHgAVzokPEeiagf0Kj4ZPKeC1TGmUO1aGxnbRSCMI037qteKRpST7r/3DP4dwBMERUCcPXBE9rmH5P3riyzzg6crBVMIE5IdgaUFbGBDnyuYpDpBvNI1F7M13ac2uKw3hF0f/HXRis2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070382; c=relaxed/simple;
	bh=XZuaYOoovsfL5amEOzT38vDiTHJ0q8Z31zzCYRKhJi8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WDWaDrwODRgf8pQfQS7OJgxa9iMPFF7GHX6EYVuozcJFY4PlBS7cGWZkgHJT1YUNjzslJspV4RMjkHvWlFcM3IBwUphHCOEQyBLdaEZhDYDOcY5ReL6MLVAk7A+8HW2JpBjBGqhGkJCXFqqzKxIsmNTs9gMfU/KTPl6u/vRJJ2k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=A0vqyroW; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="A0vqyroW"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCqBxtD2402737, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070331; bh=CLzgZ8gVrtLaA0sFxP9OQ2184DrYNzFQrOiTJhEYTbM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=A0vqyroWevpW1uZTD9Ab83+sQwRJ3/48Ii/SCVIVKXciHUFEir9PhNzNmHPpRuHsm
	 CELRGFgdwP+BISCfD246rWXBB7wgbRPu1qCUwLpTb8CfSSgDhKyV2rY6cA99pk2RVj
	 5uOKwThox/gULJW9lMGLuU+7sIcmzkUlfIPZnHKolVeLhTVt1gyMHEsUBVJVSMvaH4
	 q09m3cWIFiSMm3hhMC4LDa7RYJQ9Jyjq9Ol3VhCeETMaHAUza2oURdY/7fR7E7W6tl
	 xqCVBVIGdFpU9a4uThBr64iXnLbYVJzoCAHWoUgNOqFkl8eLIluJ3pwAcP8/y1QhDp
	 qbb8ihV1NrAHA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCqBxtD2402737
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
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
	<james.tai@realtek.com>, <stanley_chang@realtek.com>, Andy Shevchenko
	<andriy.shevchenko@linux.intel.com>
Subject: [PATCH v8 8/9] gpio: regmap: Add IRQ enable/disable helpers
Date: Sun, 26 Jul 2026 20:51:59 +0800
Message-ID: <20260726125209.140307-9-eleanor.lin@realtek.com>
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

Add gpio_regmap_enable_irq() and gpio_regmap_disable_irq(). Since struct
gpio_regmap is opaque, drivers cannot access the embedded gpio_chip directly.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v8:
- Add Reviewed-by tag from Linus.
---
 drivers/gpio/gpio-regmap.c  | 12 ++++++++++++
 include/linux/gpio/regmap.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 19e33e361cc4..fb21396e1d02 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -346,6 +346,18 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
 
+void gpio_regmap_enable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq)
+{
+	gpiochip_enable_irq(&gpio->gpio_chip, hwirq);
+}
+EXPORT_SYMBOL_GPL(gpio_regmap_enable_irq);
+
+void gpio_regmap_disable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq)
+{
+	gpiochip_disable_irq(&gpio->gpio_chip, hwirq);
+}
+EXPORT_SYMBOL_GPL(gpio_regmap_disable_irq);
+
 /**
  * gpio_regmap_register() - Register a generic regmap GPIO controller
  * @config: configuration for gpio_regmap
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index dd9de9958409..6f52c140e50d 100644
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
@@ -165,4 +167,7 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
 int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset);
 void gpio_regmap_relres_irq(struct gpio_regmap *gpio, unsigned int offset);
 
+void gpio_regmap_enable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq);
+void gpio_regmap_disable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq);
+
 #endif /* _LINUX_GPIO_REGMAP_H */
-- 
2.43.0

