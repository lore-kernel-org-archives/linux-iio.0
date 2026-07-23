Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0377E35C1B2;
	Thu, 23 Jul 2026 03:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784778195; cv=none; b=m1eNuW78VLHz9m6jwNv29eQs+s9GJNkWTUbX+V/FcJLyHggMOCZImpCBDFVN0RxDTaZnjIiKJD6a5Ggut+ixl9MYi63dFzRBtVms54iVjeFrAoQdo6JEHKJnth24ChVPeM4Jf09XULBaTFpfHX9j4ZWVWadUojjYEhKNGOIUCNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784778195; c=relaxed/simple;
	bh=0Kf5mrxQNbj2Bt9nK9Srdu/hwTFLWaCBYKuE64lp1wU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CLex6J5YG0kmiLuQUzHPdlM+37+zk4gqSSXIYOjUqF5gBrLNbVoY1ISFPo5WJ7O6ieUMljemFTCKfWOuFTk9KbuTaakkIXR8QjLpbsp1Jn+COmAG5FXtheT1e6iXUc9FV3scuS1J1CNCXaJubN0cFlIpE2EYPR9VP3o+Z2x3RoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=JQbF9DSb; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="JQbF9DSb"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66N3giWI3179480, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784778164; bh=cZZ0lVXCD6wCWSv3NiWQbdaogTfhZ6MlrmbPdXV72LU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=JQbF9DSbuQGKfbeDqgiYVwqTHk2NqXnK6zbQezwgTFZjYFLMcIkKFwBY9hvUWIV1x
	 6he1YUp+vw1ap3IfLxGneK4p0IAS1Rm9pTkNq0SNAuxhYoxZmdvf4pf+srWYcaDkVx
	 NrQWVyJm/JT2X45BlAkov4RrvOypGbZc2F4H1e/B3Eyje1mPYlwlPFdfmDasPwIl9Y
	 ecgza0e7dH9H7P87EVhIeV9D86XUo0/9O7HKAntffV3pd/mwEGhvqZz32obF9Xbln4
	 rN5gNeLYLX5FhMZSTfX+N1p1jO7qzOdj4VEcfx851Q634ypWjHzq6nRscRwbG8Bf3b
	 Y3DgaDDQ+5aYw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66N3giWI3179480
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 23 Jul 2026 11:42:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 23 Jul 2026 11:42:38 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS06.realtek.com.tw
 (10.21.1.56) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 23 Jul 2026 11:42:38 +0800
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
Subject: [PATCH v7 2/9] gpio: regmap: Provide default IRQ resource request and release callbacks
Date: Thu, 23 Jul 2026 11:42:19 +0800
Message-ID: <20260723034237.2501507-3-eleanor.lin@realtek.com>
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

From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

When GPIO regmap based driver supplies its own IRQ domain, it might
still want to keep track of the IRQ requests and releases, in particular
to prevent a GPIO, which is used and locked as IRQ, to be requested
via standard ways. Provide default callbacks for such cases and keep
struct gpio_chip private to GPIO regmap implementation.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v7:
- Add Reviewed-by tag from Michael.
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

