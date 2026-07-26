Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4823BD05;
	Sun, 26 Jul 2026 12:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785070382; cv=none; b=IvgSO1ADxyqnx4VdUUvsQbw9RrXbRolGhZNDPUXl0bTIBVqrGaxUPHDMxuxN+G1+FoH0eDTzQ1EBJUJ3qWKlnXcbHWW9Djmhqk/kJkU5h6IYjtel0gSZR8XqWVEc+u+CieKxkIVe2VeiDpEafFAtd7BRFXmJXC6g+i6x3A8bNqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785070382; c=relaxed/simple;
	bh=RFr+KCFGKCASkOIvQ0VMHpE4RiV9hMSBxOKIs353Am4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=quyFRD5GJEkE/H9DywIZsgZ7kSTkpIZsldQhDMzlrfNkN17u1jTqQ5kONvyA0TO1PKKGx4gFX8K4zIC7sDIHhdxFkVjMDLVNu5Sh4jrion2sZtxaRM5FNu0n0rLjtGQetWuLpbyNCCONoMT/yegTXtH4cw2stGsM8H4gV1atICQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=EccKjJ1D; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="EccKjJ1D"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66QCqAWs92402729, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1785070330; bh=yNsiloUK2UIYeHDapO9B0IpxE70bg5Stj3kJOKxtq4Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	b=EccKjJ1DjJpFtGJ+wwEYpNvtSpBHFGAACNsn2RG8Q8gi5I9OnMUzxD0ieHysJ8WXu
	 Qkkr9XC3RZ1DVIwPp62uMYH5uZQN1i7nTh3KcNBecOrXdw9B17KX3FmgndcsvCGfzo
	 yIRyU+DWmp5IrV0Y2baXqdklkoYT1OiXa54FJKwhNdvuQp0jJWwpOrzZT1tFiOdbuw
	 mDSdXEuL6e7aXd7CUputeh5iBL32c9i09WvGAJdLaQXqubWr6Gq/yymndKpWunfUzW
	 nFiGZyEFj0lQdyBVTKGrHrtojZfZAQGh9V59gjg7GsQSXRrtRvPE+LBnHZxii9X5Th
	 zpHDIPGVonaUw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66QCqAWs92402729
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Sun, 26 Jul 2026 20:52:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Sun, 26 Jul 2026 20:52:11 +0800
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
	<james.tai@realtek.com>, <stanley_chang@realtek.com>, Jonathan Cameron
	<jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH v8 5/9] gpio: regmap: Add gpio_regmap_operation to extend reg_mask_xlate callback
Date: Sun, 26 Jul 2026 20:51:56 +0800
Message-ID: <20260726125209.140307-6-eleanor.lin@realtek.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260726125209.140307-1-eleanor.lin@realtek.com>
References: <20260726125209.140307-1-eleanor.lin@realtek.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit

Extend the reg_mask_xlate callback with an operation type parameter
(enum gpio_regmap_operation) to allow drivers to return different
register/mask combinations depending on the specific GPIO operation.

Consequently, update all existing drivers utilizing the gpio-regmap
framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
to accommodate the new reg_mask_xlate function signature.

Acked-by: William Breathitt Gray <wbg@kernel.org>
Acked-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com> #for-iio
Suggested-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v8:
- Remove GPIO_REGMAP_IN and GPIO_REGMAP_OUT from 'enum gpio_regmap_operation'
and one extra regmap_read in gpio_regmap_get().
- Add Acked-by tags from William Breathitt Gray and Jonathan Cameron.
---
 drivers/gpio/gpio-104-idi-48.c        |  7 +++---
 drivers/gpio/gpio-i8255.c             |  4 ++--
 drivers/gpio/gpio-idio-16.c           |  6 ++---
 drivers/gpio/gpio-max7360.c           |  1 +
 drivers/gpio/gpio-pcie-idio-24.c      |  6 ++---
 drivers/gpio/gpio-regmap.c            | 18 ++++++++-------
 drivers/iio/adc/ad7173.c              |  8 +++----
 drivers/iio/addac/stx104.c            |  6 ++---
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c |  1 +
 drivers/pinctrl/pinctrl-tps6594.c     |  1 +
 include/linux/gpio/regmap.h           | 32 ++++++++++++++++++++++++---
 11 files changed, 61 insertions(+), 29 deletions(-)

diff --git a/drivers/gpio/gpio-104-idi-48.c b/drivers/gpio/gpio-104-idi-48.c
index ba73ee9c0c29..fb017569cfa8 100644
--- a/drivers/gpio/gpio-104-idi-48.c
+++ b/drivers/gpio/gpio-104-idi-48.c
@@ -36,9 +36,10 @@ MODULE_PARM_DESC(irq, "ACCES 104-IDI-48 interrupt line numbers");
 #define IDI48_IRQ_STATUS 0x7
 #define IDI48_IRQ_ENABLE IDI48_IRQ_STATUS
 
-static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
-				 unsigned int offset, unsigned int *reg,
-				 unsigned int *mask)
+static int idi_48_reg_mask_xlate(struct gpio_regmap *gpio,
+				 enum gpio_regmap_operation op,
+				 unsigned int base, unsigned int offset,
+				 unsigned int *reg, unsigned int *mask)
 {
 	const unsigned int line = offset % 8;
 	const unsigned int stride = offset / 8;
diff --git a/drivers/gpio/gpio-i8255.c b/drivers/gpio/gpio-i8255.c
index 953018bfa2b1..541a348447cd 100644
--- a/drivers/gpio/gpio-i8255.c
+++ b/drivers/gpio/gpio-i8255.c
@@ -67,8 +67,8 @@ static int i8255_ppi_init(struct regmap *const map, const unsigned int base)
 	return regmap_write(map, base + I8255_PORTC, 0x00);
 }
 
-static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
-				unsigned int offset, unsigned int *reg,
+static int i8255_reg_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_operation op,
+				unsigned int base, unsigned int offset, unsigned int *reg,
 				unsigned int *mask)
 {
 	const unsigned int ppi = offset / I8255_NGPIO;
diff --git a/drivers/gpio/gpio-idio-16.c b/drivers/gpio/gpio-idio-16.c
index 4fbae6f6a497..9ac967c6b430 100644
--- a/drivers/gpio/gpio-idio-16.c
+++ b/drivers/gpio/gpio-idio-16.c
@@ -66,9 +66,9 @@ static int idio_16_handle_mask_sync(const int index, const unsigned int mask_buf
 	return 0;
 }
 
-static int idio_16_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
-				  const unsigned int offset, unsigned int *const reg,
-				  unsigned int *const mask)
+static int idio_16_reg_mask_xlate(struct gpio_regmap *const gpio, enum gpio_regmap_operation op,
+				  const unsigned int base, const unsigned int offset,
+				  unsigned int *const reg, unsigned int *const mask)
 {
 	unsigned int stride;
 
diff --git a/drivers/gpio/gpio-max7360.c b/drivers/gpio/gpio-max7360.c
index 07eda49f375b..6755d58c4534 100644
--- a/drivers/gpio/gpio-max7360.c
+++ b/drivers/gpio/gpio-max7360.c
@@ -93,6 +93,7 @@ static int max7360_set_gpos_count(struct device *dev, struct regmap *regmap)
 }
 
 static int max7360_gpio_reg_mask_xlate(struct gpio_regmap *gpio,
+				       enum gpio_regmap_operation op,
 				       unsigned int base, unsigned int offset,
 				       unsigned int *reg, unsigned int *mask)
 {
diff --git a/drivers/gpio/gpio-pcie-idio-24.c b/drivers/gpio/gpio-pcie-idio-24.c
index 80c0ba0afa67..b99f4863443d 100644
--- a/drivers/gpio/gpio-pcie-idio-24.c
+++ b/drivers/gpio/gpio-pcie-idio-24.c
@@ -225,9 +225,9 @@ static int idio_24_set_type_config(unsigned int **const buf, const unsigned int
 	return ret;
 }
 
-static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
-				  const unsigned int offset, unsigned int *const reg,
-				  unsigned int *const mask)
+static int idio_24_reg_mask_xlate(struct gpio_regmap *const gpio, enum gpio_regmap_operation op,
+				  const unsigned int base, const unsigned int offset,
+				  unsigned int *const reg, unsigned int *const mask)
 {
 	const unsigned int out_stride = offset / IDIO_24_NGPIO_PER_REG;
 	const unsigned int in_stride = (offset - 24) / IDIO_24_NGPIO_PER_REG;
diff --git a/drivers/gpio/gpio-regmap.c b/drivers/gpio/gpio-regmap.c
index 658b892b624c..ceab805d053c 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -40,9 +40,10 @@ struct gpio_regmap {
 	struct regmap_irq_chip_data *irq_chip_data;
 #endif
 
-	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
-			      unsigned int offset, unsigned int *reg,
-			      unsigned int *mask);
+	int (*reg_mask_xlate)(struct gpio_regmap *gpio,
+			      enum gpio_regmap_operation op,
+			      unsigned int base, unsigned int offset,
+			      unsigned int *reg, unsigned int *mask);
 
 	void *driver_data;
 };
@@ -56,6 +57,7 @@ static unsigned int gpio_regmap_addr(unsigned int addr)
 }
 
 static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
+				    enum gpio_regmap_operation __maybe_unused op,
 				    unsigned int base, unsigned int offset,
 				    unsigned int *reg, unsigned int *mask)
 {
@@ -80,7 +82,7 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -103,7 +105,7 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg, mask, mask_val;
 	int ret;
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -133,7 +135,7 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	else
 		base = gpio_regmap_addr(gpio->reg_clr_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -183,7 +185,7 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_DIR_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -237,7 +239,7 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
diff --git a/drivers/iio/adc/ad7173.c b/drivers/iio/adc/ad7173.c
index 9ee65d63c525..f78e758706ed 100644
--- a/drivers/iio/adc/ad7173.c
+++ b/drivers/iio/adc/ad7173.c
@@ -560,8 +560,8 @@ static int ad4111_openwire_event(struct iio_dev *indio_dev,
 	return ret;
 }
 
-static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
-			     unsigned int offset, unsigned int *reg,
+static int ad7173_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_operation op,
+			     unsigned int base, unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
 {
 	*mask = AD7173_GPO_DATA(offset);
@@ -569,8 +569,8 @@ static int ad7173_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
 	return 0;
 }
 
-static int ad4111_mask_xlate(struct gpio_regmap *gpio, unsigned int base,
-			     unsigned int offset, unsigned int *reg,
+static int ad4111_mask_xlate(struct gpio_regmap *gpio, enum gpio_regmap_operation op,
+			     unsigned int base, unsigned int offset, unsigned int *reg,
 			     unsigned int *mask)
 {
 	*mask = AD4111_GPO01_DATA(offset);
diff --git a/drivers/iio/addac/stx104.c b/drivers/iio/addac/stx104.c
index 7bdf2cb94176..6207eb2fac74 100644
--- a/drivers/iio/addac/stx104.c
+++ b/drivers/iio/addac/stx104.c
@@ -349,9 +349,9 @@ static const struct iio_chan_spec stx104_channels_diff[] = {
 	STX104_IN_CHAN(6, 1), STX104_IN_CHAN(7, 1)
 };
 
-static int stx104_reg_mask_xlate(struct gpio_regmap *const gpio, const unsigned int base,
-				 unsigned int offset, unsigned int *const reg,
-				 unsigned int *const mask)
+static int stx104_reg_mask_xlate(struct gpio_regmap *const gpio, enum gpio_regmap_operation op,
+				 const unsigned int base, unsigned int offset,
+				 unsigned int *const reg, unsigned int *const mask)
 {
 	/* Output lines are located at same register bit offsets as input lines */
 	if (offset >= 4)
diff --git a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
index a4aa4146b530..b41a3d16aabe 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm63xx.c
@@ -19,6 +19,7 @@
 #define BCM63XX_DATA_REG	0x0c
 
 static int bcm63xx_reg_mask_xlate(struct gpio_regmap *gpio,
+				  enum gpio_regmap_operation op,
 				  unsigned int base, unsigned int offset,
 				  unsigned int *reg, unsigned int *mask)
 {
diff --git a/drivers/pinctrl/pinctrl-tps6594.c b/drivers/pinctrl/pinctrl-tps6594.c
index 456a3cfc8de9..937fc9cb54b7 100644
--- a/drivers/pinctrl/pinctrl-tps6594.c
+++ b/drivers/pinctrl/pinctrl-tps6594.c
@@ -346,6 +346,7 @@ static struct tps6594_pinctrl tps6594_template_pinctrl = {
 };
 
 static int tps6594_gpio_regmap_xlate(struct gpio_regmap *gpio,
+				     enum gpio_regmap_operation op,
 				     unsigned int base, unsigned int offset,
 				     unsigned int *reg, unsigned int *mask)
 {
diff --git a/include/linux/gpio/regmap.h b/include/linux/gpio/regmap.h
index eb3931fbbad0..7eebb6381296 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -13,6 +13,32 @@ struct regmap;
 #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
+/**
+ * enum gpio_regmap_operation - Operation type for reg_mask_xlate callback
+ *
+ * Traditionally, the operation type was inferred from the base register.
+ * However, that approach does not always work — for example, when all control
+ * bits of a single GPIO reside in the same register. This enum allows the
+ * reg_mask_xlate callback to explicitly distinguish between operation types.
+ * The user is free to choose which method to use.
+ *
+ * Read operation:
+ * @GPIO_REGMAP_GET_OP: Indicates a read operation to get the current GPIO value.
+ *
+ * Write operation:
+ * @GPIO_REGMAP_SET_OP: Indicates a write operation to set the GPIO output value.
+ *
+ * Direction operations:
+ * @GPIO_REGMAP_GET_DIR_OP: Indicates a read operation to get the GPIO direction.
+ * @GPIO_REGMAP_SET_DIR_OP: Indicates a write operation to set the GPIO direction.
+ */
+enum gpio_regmap_operation {
+	GPIO_REGMAP_GET_OP,
+	GPIO_REGMAP_SET_OP,
+	GPIO_REGMAP_GET_DIR_OP,
+	GPIO_REGMAP_SET_DIR_OP,
+};
+
 /**
  * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
  * @parent:		The parent device
@@ -104,9 +130,9 @@ struct gpio_regmap_config {
 	unsigned long regmap_irq_flags;
 #endif
 
-	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
-			      unsigned int offset, unsigned int *reg,
-			      unsigned int *mask);
+	int (*reg_mask_xlate)(struct gpio_regmap *gpio, enum gpio_regmap_operation,
+			      unsigned int base, unsigned int offset,
+			      unsigned int *reg, unsigned int *mask);
 
 	int (*init_valid_mask)(struct gpio_chip *gc,
 			       unsigned long *valid_mask,
-- 
2.43.0

