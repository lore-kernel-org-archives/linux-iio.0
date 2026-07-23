Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE8361DB8;
	Thu, 23 Jul 2026 03:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778209; cv=none; b=LjUPIDWScVQWdgbh6GOTFicMhW2GaCOQEHXgzdYIn/MvlnM9LyFDIrnMmYPLmTHXEAHR0MjB2Lrgl7McFsBFIrbC+Ifx7wcmEIfiHXtWzWjijARX6AadwUg60GkaZoBA6Iwvj13CjbkdMIOdUxfgwN4soxGEbUzy14+s2xbJav8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778209; c=relaxed/simple;
	bh=Cm/RKXWnBXERGIbPA7j0nr4RNtwsj7QLUihqBUeTCTc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aq/psvP8fxnvLUVNkmhjyE3SB3Izqbzp7+MuzDmqWoL8v0NNikDoB5X4bBIcgDDSvBig0/SDitGYL+lbKGHzckuFaTUgeiea5Ddq68HlRpdTwa4Y94DtwjlncIb3QYO7VNn5l5q4eHEWA8QTCPzotzkfsr2zl6xpNYFUZHRqdBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Kd/oKlx5; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Kd/oKlx5"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3h0L71179581, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784778180; bh=1+K3+yhdGwWiLaUt0U4utFuxXog7YaDwSauZcSSoHWo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Kd/oKlx5DnInV2We7JrAnD4879WOlRu4aWspCGA9fF9nm74Yjtjcw5J18/x4v+HBK
	 ik31KxJvk3adpJrTDk+WaLucLSQnG7NsKvWrA4wmqB6iqdSA/SL41x8hmLgcxjtsxk
	 L8N9isDQTvp6XsUzZ7/aBjN+39C5cdQpiP77AM5kB9elT4CU9vRyLTl2sZKynVT4li
	 687GnacjNYcTddKkJswUZQqNNmIg59zccjnLtFRgAMCCkJaVS76Zfbpsd7UE6RiPPN
	 9sDMz3P564Nehm3i8R3wus+Fu3tZY1o+8hYUj0kU/oLpPmisZgc3tajIKhk0nnUCr5
	 wKDX7w+BGBSjQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3h0L71179581
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:43:00 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:43:01 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:59 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Jul 2026 11:42:59 +0800
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
Subject: [PATCH v7 8/9] gpio: regmap: Add IRQ enable/disable helpers
Date: Thu, 23 Jul 2026 11:42:25 +0800
Message-ID: <20260723034237.2501507-9-eleanor.lin@realtek.com>
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

Add gpio_regmap_enable_irq() and gpio_regmap_disable_irq(). Since struct
gpio_regmap is opaque, drivers cannot access the embedded gpio_chip directly.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v7:
- Add Reviewed-by tags from Michael and Andy.
---
 drivers/gpio/gpio-regmap.c  | 12 ++++++++++++
 include/linux/gpio/regmap.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 98cfdd890069..75b70aa1eb5b 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -357,6 +357,18 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
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
index 4bf4319ec12e..483b5deadda9 100644
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
@@ -172,4 +174,7 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
 int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset);
 void gpio_regmap_relres_irq(struct gpio_regmap *gpio, unsigned int offset);
 
+void gpio_regmap_enable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq);
+void gpio_regmap_disable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq);
+
 #endif /* _LINUX_GPIO_REGMAP_H */
-- 
2.43.0

