Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4121C2324;
	Sun, 26 Jul 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070381; cv=none; b=mqQW3aD6421JsglGce91/ukH7er8XiTIowEdQJ4sw71SF8FcKYVsOVAte+k5s3RfDX7cwHs42IvfwwPs4QFqHlxdsEaEk3SdjX5zhrTqSyPJh0/CjtJb2bjTWAE4NpEAwjzIFd6Bpw2HqSQFgWAhP+K1zRLdy1Wj1VaNgIDdZqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070381; c=relaxed/simple;
	bh=q0CYVSYVs2MZNSW5Z4xJzmzOtZlTNN49S/YjqCmvNaQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=N19iWCfTxTyQ1tUJpmVr0DYaXdgG/dWRL+fd2R6ECM35MUSkM5lt2LhRzbIk05lgnoIrMKQqqshsDz0wHu2kpqA4QiUv7kPgg3haVa5Pv11XQihZ1WRMiQV4dbl8gb7+/qG7uh6X8WGF2Qmd4Xi/umyR8HjhrKR7I/vMCkGV+Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=d5vNW4tf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="d5vNW4tf"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCq9xY52402721, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070329; bh=hpGqSOIqZmwQLXES8xSuRWt7GrwdMroB+aXgg1BmMFI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=d5vNW4tf/eIaJ7eNF7LhE/bmFsRaBX+3jOLKST2OZOApvSrP3ZdAGNYutNzS+ksJq
	 25AAxzL9+cN25Kp47Zv2lCwEFW11WUZCKAmWLVJYoBCFz8PZoOCnN0Geb+h2BhCJyE
	 GwPulGIgE/Cj80f6EEkVL9W4P1+qzInTHRWnQfixtJwBABaKu9R2ERDXBaYwmTcFuQ
	 y66E9YyZN+mIhNtr/9n+4r+Nx6rrN64rqKoyRErzo6gd6jB7JaQjrCsf+dX7PORyNu
	 CXIwCKvn2vGEJ8/o0f5+NsT/hEwM0ecwkxvBq9NIEwMqzhYvZlZIsGcki4Gy7bo8xO
	 l2vYTX3BOPTNA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCq9xY52402721
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:09 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:10 +0800
Received: from RTKEXHMBS03.realtek.com.tw (10.21.1.53) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:09 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS03.realtek.com.tw
 (10.21.1.53) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sun, 26 Jul 2026 20:52:09 +0800
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
Subject: [PATCH v8 2/9] gpio: regmap: Provide default IRQ resource request and release callbacks
Date: Sun, 26 Jul 2026 20:51:53 +0800
Message-ID: <20260726125209.140307-3-eleanor.lin@realtek.com>
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

When GPIO regmap based driver supplies its own IRQ domain, it might
still want to keep track of the IRQ requests and releases, in particular
to prevent a GPIO, which is used and locked as IRQ, to be requested
via standard ways. Provide default callbacks for such cases and keep
struct gpio_chip private to GPIO regmap implementation.

Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v8:
- Add Reviewed-by tag from Linus.
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

