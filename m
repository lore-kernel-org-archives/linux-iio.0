Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D2C442A17E;
	Tue, 21 Jul 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617116; cv=none; b=VWIBZZq8UfSEMJBKvPO7c43emUxIiisA8cBiosSKsRqVrsXZN71zY2lh4yXeEvZJZbIoTyAF94Hm45hDFB7HPZgnhyzfepKXJV1LqQPAjIJ+J97OiCNYbKCmu8VYPzBTiDnCJzZPHpaT+VN0aMQ+e3bom+4FzKe7dMUAunfoSvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617116; c=relaxed/simple;
	bh=rA8a6r/yhAKBcah1k3fbfgq08wg/I4nEhbo24pEnEJk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RZhyB5hx2u+KGdi+EdTV7VNVFmGjK+G16Eu3brG4FWLVYs3/5P8AggZ3VyumowTeroM8TsbZyKDQaoWv0CZwwgH+6NIRb99k1G9k9+F4eQEqG7fvC/lO3oRbdA/bmmaetZIYncJOMIJnXBA5Fuuj+LCh9CZe4J6KtaWCpC0vRio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=SNz9i7Ae; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="SNz9i7Ae"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L6w6v253014056, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784617086; bh=tErcWa7vawdhi8WJ5LaFGHq3z1tLEYUJnYrQNLu8spw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=SNz9i7AemElws6opKXAStX+L2qBRH0uw0tTjA9g+gNOhqmnBzVZx0j0TQYuWOkWlx
	 It/CQ420KiwaEybfuCqf98Bre/h7F9z9JB1+0CCTIkwhAbfSVm0AJyWTS+NP1cLpra
	 bmYrZoTZ6UONQyuJf/Naidg1jzvUvMAHq6nV6JhvLgAERbcXasMQZbwT/CPE78fHEu
	 ki6H1fYBB2vpG/RPot2U2WPbwSMdrnY3P9UoVng0c7QTsmxMDdSsS7SDBZRKjB/0y7
	 9qlb52jYBQOEUA94JPEXq/6vGhrmf0z0Ej5G2BNG5xV97FJgP21+VC4h1NIDZFRV9c
	 FlvAUAHHyerAA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L6w6v253014056
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 14:58:06 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:07 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Tue, 21 Jul 2026 14:58:06 +0800
Received: from cn1dhc-k02 (172.21.252.101) by RTKEXHMBS05.realtek.com.tw
 (10.21.1.55) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 21 Jul 2026 14:58:06 +0800
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
	<james.tai@realtek.com>
Subject: [PATCH v6 6/8] gpio: regmap: Add set_config callback
Date: Tue, 21 Jul 2026 14:58:00 +0800
Message-ID: <20260721065802.689530-7-eleanor.lin@realtek.com>
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

Add a new set_config callback to struct gpio_regmap_config to allow drivers
to implement hardware-specific configuration such as debounce settings,
or other platform-specific GPIO properties.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v6:
- None.
---
 drivers/gpio/gpio-regmap.c  | 1 +
 include/linux/gpio/regmap.h | 5 +++++
 2 files changed, 6 insertions(+)

diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index aecc35f610dd..b856326ff01c 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -454,6 +454,7 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
 	gpio->value_xlate = config->value_xlate;
+	chip->set_config = config->set_config;
 
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index 45a30f50043f..23460995c1d1 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -89,6 +89,9 @@ enum gpio_regmap_operation {
  *			mask before writing. This allows driver-specific logic
  *			to append additional bits (like write-enable masks)
  *			dynamically based on the current operation.
+ * @set_config:		(Optional) Callback for setting GPIO configuration such
+ *			as debounce, drive strength, or other hardware specific
+ *			settings.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -150,6 +153,8 @@ struct gpio_regmap_config {
 			   unsigned int base, unsigned int offset, unsigned int reg,
 			   unsigned int *mask, unsigned int *val);
 
+	int (*set_config)(struct gpio_chip *gc, unsigned int offset, unsigned long config);
+
 	void *drvdata;
 };
 
-- 
2.43.0

