Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4977442B302;
	Tue, 21 Jul 2026 06:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617116; cv=none; b=AfBLCYizePwefT/4MNfPt1vztEwPxNHVRa+GKUXRBIFL/Qgi23T6hxkFx29PkNWRtrp/Mb5bcDV4FXRtWnsLQ9kN9G/nvdkKs5dxYnf2KC2Vk/+5LLAGvbEUgqtiVYsaHTcy7YyNZP8Jb0/Ovev0QvAX2x0mTS3AMBRh6MPbAH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617116; c=relaxed/simple;
	bh=U6I3z8gdwxAvkhCmHnL7Qya4aQZmvqWUn4deA2dua04=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PGhFCWV3kCsSJFdHhGNfxJ5bWwRpcaJK+QupvsSvtJyObAXfS9jKvvYv/3c/AbepqXkoxj5i6KBS+H+phv+kwqwA8sr1OgO1Tzv8hC5l6Yj/g8mug/5Jn13eeoD9+WJOoWXVeeX9fyzRC/XkaKsxDDnrcdMDpOOqcYbSbUXG0ig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LREICTB0; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LREICTB0"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L6w6v453014056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784617086; bh=1FajypsTNcpyVsGIWUH/7huhGoEjymV0DRkxHBIAb4k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=LREICTB0hzjIKYp4LDRKfaYYZoudMmKoIUiZ/ZgIx+DZPgi2UX5ZHXdXAZ/YFiefx
	 okQSmeg3zMUnc/D4+GeK2M6/iIquifbIG+lWHcDhhb5Ei51zPrtKt4ln5JhDPN0UoC
	 rI3t94znhESX6pHbQ6HhCM1UFc56vi+an8wLVN3KAlMMVmrqXpN+MyMxniu9T3dw8I
	 vwTUXpqk8iw177stjjWrBR9i7kgc8geeYLGL2g8T/q6pEwSM3uuDaLaP6HzkR0pjJr
	 VR/UBNsWP0O2nBYC1IFcTEKTMKv8c0xTssa1qPRlGdeImAyR3TgsArF0BHThSdM+UJ
	 NTKLKekp82XDw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L6w6v453014056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 14:58:06 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:07 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:07 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 14:58:07 +0800
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
Subject: [PATCH v6 7/8] gpio: regmap: Add IRQ enable/disable helpers
Date: Tue, 21 Jul 2026 14:58:01 +0800
Message-ID: <20260721065802.689530-8-eleanor.lin@realtek.com>
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

Add gpio_regmap_enable_irq() and gpio_regmap_disable_irq(). Since struct
gpio_regmap is opaque, drivers cannot access the embedded gpio_chip directly.

Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v6:
- A new patch.
---
 drivers/gpio/gpio-regmap.c  | 12 ++++++++++++
 include/linux/gpio/regmap.h |  5 +++++
 2 files changed, 17 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index b856326ff01c..5c6fdff20cf8 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -345,6 +345,18 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
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
index 23460995c1d1..8042e620621d 100644
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
@@ -167,4 +169,7 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
 int gpio_regmap_reqres_irq(struct gpio_regmap *gpio, unsigned int offset);
 void gpio_regmap_relres_irq(struct gpio_regmap *gpio, unsigned int offset);
 
+void gpio_regmap_enable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq);
+void gpio_regmap_disable_irq(struct gpio_regmap *gpio, irq_hw_number_t hwirq);
+
 #endif /* _LINUX_GPIO_REGMAP_H */
-- 
2.43.0

