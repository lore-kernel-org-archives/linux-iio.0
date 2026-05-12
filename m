Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30CCA274B43;
	Tue, 12 May 2026 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556881; cv=none; b=EQ22gPWcxVp4rkd6NGjpD6K20FxBGEunLNmOq5bvREJ21XnqwSaD+EsjZPPGAkSE2QcIkKsFOY/vi0dkPAMxKvON/rTMKXpfE9PNtBgndpa84tdhmFoezhZg9c8vji+2Qf0hYNOh7kvgrdVGKEdQ1GOIVuA1p0I3IQzfMRq5eNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556881; c=relaxed/simple;
	bh=tSv8hEY8sk+mSdC1mMMC8Q63kBRtY+0Goshq44RXMbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lhINX1QPsBQvUXqrqTTvcJVR0XZclJPxVyXG7RLM+rPjqMpxJzMP5ICmA9GsBO6Isq95NyuDLoVLBJTeZ95Ion/NfzgEZKYwtfvLe/z9QHYXzlPFZsBBC5F4nT5DJD3SwGPF4OrNhbWlvUoBFHafb7gJRScDi+A8QkF/7b80ijY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YCKBm32C; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YCKBm32C"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C3XIeR43571932, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778556798; bh=UJl/6Y6d4E6puh3y3cEykQ83pumRgeb1nEF73Wn9I74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=YCKBm32CPGop+DynySQ5CrtQTVwrpjxzjpPWAZ/hkBe1/hVH6Sh9pZh8cMwPkrsJN
	 u/STXO9gnMlc0Yb1pnN3qOvsebF6+9yJdLSxDt3033ULLKhXId20NdZG1A08Pc5zYf
	 lrchTqSasIbl5wmx/4sVGwJJy51tWFelV05ZVueRPMHM+k3JJXq9alU4RAin2m8O0G
	 4kBd7QqfNZDwUV25d0uvm+YnvNkQcFARS6uXhmtd6d9eyD37Ur5KhvBfKymbzOyhE6
	 EbcFn5gUa0alCbmrAJkADc8IDYAx7+yQFUqSZbMAkV7VZUyzP18+kd7Wp2/l8QPjko
	 wIe/n/1NtRNmg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C3XIeR43571932
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 11:33:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 11:33:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 11:33:18 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 12 May 2026 11:33:18 +0800
From: Yu-Chun Lin <eleanor.lin@realtek.com>
To: <linusw@kernel.org>, <brgl@kernel.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>, <afaerber@suse.com>,
        <wbg@kernel.org>, <mathieu.dubois-briand@bootlin.com>,
        <mwalle@kernel.org>, <lars@metafoo.de>, <Michael.Hennerich@analog.com>,
        <jic23@kernel.org>, <nuno.sa@analog.com>, <andy@kernel.org>,
        <dlechner@baylibre.com>, <tychang@realtek.com>
CC: <linux-gpio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-realtek-soc@lists.infradead.org>, <linux-iio@vger.kernel.org>,
        <cy.huang@realtek.com>, <stanley_chang@realtek.com>,
        <eleanor.lin@realtek.com>, <james.tai@realtek.com>
Subject: [PATCH v3 2/7] gpio: regmap: add gpio_regmap_get_gpiochip() accessor
Date: Tue, 12 May 2026 11:33:12 +0800
Message-ID: <20260512033317.1602537-3-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260512033317.1602537-1-eleanor.lin@realtek.com>
References: <20260512033317.1602537-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Expose an accessor function to retrieve the gpio_chip pointer from
a gpio_regmap instance.

This is needed by drivers that use gpio_regmap but also manage their
own irq_chip, where gpiochip_enable_irq()/gpiochip_disable_irq() must
be called with the gpio_chip pointer.

Add gpio_regmap_get_gpiochip() to allow drivers with complex custom IRQ
implementations.

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 drivers/gpio/gpio-regmap.c  | 6 ++++++
 include/linux/gpio/regmap.h | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 9ae4a41a2427..deb9eebb58de 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -230,6 +230,12 @@ void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio)
 }
 EXPORT_SYMBOL_GPL(gpio_regmap_get_drvdata);
 
+struct gpio_chip *gpio_regmap_get_gpiochip(struct gpio_regmap *gpio)
+{
+	return &gpio->gpio_chip;
+}
+EXPORT_SYMBOL_GPL(gpio_regmap_get_gpiochip);
+
 /**
  * gpio_regmap_register() - Register a generic regmap GPIO controller
  * @config: configuration for gpio_regmap
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 12d154732ca9..e4a95f805a81 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -113,5 +113,6 @@ void gpio_regmap_unregister(struct gpio_regmap *gpio);
 struct gpio_regmap *devm_gpio_regmap_register(struct device *dev,
 					      const struct gpio_regmap_config *config);
 void *gpio_regmap_get_drvdata(struct gpio_regmap *gpio);
+struct gpio_chip *gpio_regmap_get_gpiochip(struct gpio_regmap *gpio);
 
 #endif /* _LINUX_GPIO_REGMAP_H */
-- 
2.34.1

