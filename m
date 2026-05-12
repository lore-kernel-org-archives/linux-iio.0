Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9995271471;
	Tue, 12 May 2026 03:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778556881; cv=none; b=EK4tJunFAvHre4XJkwl143s/SxuGZ3OBEkUG0ZzfPxg3J5EYHeWtNTqYCHMGXZS/vP89m3FGiI1hdVWVcUOJO016LC7uYyBwPU6iisCdO0wjP7bgmdyRFVRG9mCyOMSaQit7ffdu9cxf2swfv7t7vgdv/Mg79ksxFbUmX0zy16A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778556881; c=relaxed/simple;
	bh=SdsnUhudj41/ML8sMgBpdIzE44zCA5T2abko+StvirQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mgkAuDD8t9ld8oqhUS7yaMQ3o9wLHHPIQERIihN+Xrgjo6MdUcWLPOfqQVTttrdSNqcDpprX36VPdbYQD+kKwtMu7lSmqkSsfAQGnwsFlUThcTsn/BTGT9YGl/H11rD4cW8uvkWGVg5w1PL2nDeDjd5NHtCLB+02aWjamekCL9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Dm5NRpYy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Dm5NRpYy"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64C3XJJb83571936, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1778556799; bh=oZBr9pwH4UXc5QEjRFphG+sAgmDAvI5SstkFwh3TAWA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Dm5NRpYyetZZsz5cBE+5AZv1AnkBs4Lqme8c9gx3Bd8UKMBVA1NCbdg5AkE0g5QUo
	 1RRchNc7CLTuD5PehZmeChRJRrS21rRV7AyGtnKVtcxq/mcOL1SyWuQfOsFFqrLLBc
	 NtACys14NHVhXiR0CqFveOmS4zr4ot9gbXmfz8be8Hn8Bxi9ixJMQtrLcbrQmgtJ6G
	 GTejugRSl2QhhtkDKWuAtJ2GlDKnWymgJGdKumqfIdr9MD3MRoEOWiY9Dn4JOLUdG4
	 NE4AFR09MPZZdPLMnUU1bCi7MlbzJW2IjNkczKY0vv6Cb8v3KhjRLTdWA3QtEuEAeW
	 JsJtxt0gpe/+g==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64C3XJJb83571936
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 12 May 2026 11:33:19 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 11:33:19 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 12 May 2026 11:33:19 +0800
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
Subject: [PATCH v3 4/7] gpio: regmap: Add set_config callback
Date: Tue, 12 May 2026 11:33:14 +0800
Message-ID: <20260512033317.1602537-5-eleanor.lin@realtek.com>
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

Add a new set_config callback to struct gpio_regmap_config to allow drivers
to implement hardware-specific configuration such as debounce settings,
or other platform-specific GPIO properties.

Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
 drivers/gpio/gpio-regmap.c  | 2 ++
 include/linux/gpio/regmap.h | 7 +++++++
 2 files changed, 9 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index c76eef20e412..490a35fe8768 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -371,6 +371,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!gpio->reg_mask_xlate)
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
+	chip->set_config = config->set_config;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap;
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 519fc81add8a..0660fd9be928 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -89,6 +89,9 @@ enum gpio_regmap_operation {
  *			domain will be set accordingly.
  * @regmap_irq_line:	(Optional) The IRQ the device uses to signal interrupts.
  * @regmap_irq_flags:	(Optional) The IRQF_ flags to use for the interrupt.
+ * @set_config:		(Optional) Callback for setting GPIO configuration such
+ *			as debounce, drive strength, or other hardware specific
+ *			settings.
  *
  * The ->reg_mask_xlate translates a given base address and GPIO offset to
  * register and mask pair. The base address is one of the given register
@@ -142,6 +145,10 @@ struct gpio_regmap_config {
 			       unsigned long *valid_mask,
 			       unsigned int ngpios);
 
+	int (*set_config)(struct gpio_chip *gc,
+			  unsigned int offset,
+			  unsigned long config);
+
 	void *drvdata;
 };
 
-- 
2.34.1

