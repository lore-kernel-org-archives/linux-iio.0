Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4979F42DA35;
	Tue, 21 Jul 2026 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617119; cv=none; b=Yv1iE64S1Zn7pk8lfC+lBrrLM9cf8CIox/CgDgccpkH1TuoX0rr5t92/ZyHNEgQfMCeE1ILZzgKV6BfdZlNFz537Y10b7xv+DC+M8p7PYW9YKxKaS7p9Imk4QuqVPVdOtygpJVJdjK1T0POLuZnDLaQLfayWwuTPyQU/ZDB82R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617119; c=relaxed/simple;
	bh=RvwDCpRXnN9dI+Byg7715D5QgV5d4OjI058sswEXLbA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mB8OgAaVcrHnHhBuSCD21KVhF3WRWh8EMh8jTb6wsm93eE0iRZCsn+pbKYboPjg+GqHDODAKobdcMlnYi+RXMN+4hhXvEvAqosQMykDaU4JQyOszKhR5T9OegEuKicjm9iLni/Y1E0cJ3jjkduMGa/YvmLVCCr99nJ2SoV5JFJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Ve7axBCg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Ve7axBCg"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L6w44s93014041, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784617084; bh=d9U7R70n3ivMA5xWfoEJlAr7TNsouCIjO8amTPMYc80=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Ve7axBCgF4V+pwoLPOAkchqNv9OSuXj8B7m30aaT5hv4vqgoAp5Hl8N9Ih+go5y+V
	 MNbxG4OIGbOItZwDpAXgmsQw2CdOqet4CTR7T5dy/nnut/jjnjQ6rISYMF1tEry0zH
	 PI8FGRGCF0XQuZeKVDwMRA4cOLiPAOEUVM4UbfIinYD1JzbazmybbBWPdz2Mr7zwCm
	 ALL8bm1Jr5IBsQhcBBugv4QFRugOvOgo2LftWRlKM4tQh2a5Kgtrg7uIpaZhlb7H9n
	 61GJc2xTMazJACBn9de50EN0Bp7i9hAAw2buyAIphvFvC8e0OURP4b8Ksa5cv+0Pw+
	 +oBExkm6CMpVA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L6w44s93014041
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 14:58:04 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:03 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 14:58:03 +0800
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
	<james.tai@realtek.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: [PATCH v6 2/8] gpio: regmap: Provide default IRQ resource request and release callbacks
Date: Tue, 21 Jul 2026 14:57:56 +0800
Message-ID: <20260721065802.689530-3-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260721065802.689530-1-eleanor.lin@realtek.com>
References: <20260721065802.689530-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When GPIO regmap based driver supplies its own IRQ domain, it might
still want to keep track of the IRQ requests and releases, in particular
to prevent a GPIO, which is used and locked as IRQ, to be requested
via standard ways. Provide default callbacks for such cases and keep
struct gpio_chip private to GPIO regmap implementation.

Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 drivers/gpio/gpio-regmap.c  | 12 ++++++++++++
 include/linux/gpio/regmap.h |  3 +++
 2 files changed, 15 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 51b4d69b8740..535bd9deaa71 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -276,6 +276,18 @@ static int gpio_regmap_direction_output(struct gpio_chip *chip,
 	return gpio_regmap_set_direction(chip, offset, true);
 }
 
+int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset)
+{
+	return gpiochip_reqres_irq(&gpio->gpio_chip, offset);
+}
+EXPORT_SYMBOL_GPL(gpio_regmap_reqres_irq);
+
+void gpio_regmap_relres_irq(struct gpio_regmap *gpio, unsigned int offset)
+{
+	gpiochip_relres_irq(&gpio->gpio_chip, offset);
+}
+EXPORT_SYMBOL_GPL(gpio_regmap_relres_irq);
+
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
 {
 	return gpio->driver_data;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 06255756710d..e939709fde8d 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -121,4 +121,7 @@ struct gpio_regmap *devm_gpio_regmap_register(struct device *dev,
 					      const struct gpio_regmap_config *config);
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
 
+int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset);
+void gpio_regmap_relres_irq(struct gpio_regmap *gpio, unsigned int offset);
+
 #endif /* _LINUX_GPIO_REGMAP_H */
-- 
2.43.0

