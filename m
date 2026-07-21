Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D19542A144;
	Tue, 21 Jul 2026 06:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784617117; cv=none; b=juJo3geuoSWurxcgiaZ4WLdFqj3obHs1ZpvLgNSbvSDDCWktVCD1XGyzU+dYE91stFKxacb+tlQ3Phz8luNj+joO68y9+QcLg/tRdDW/oVNzG/OiVnst0yXtsIFXU5b+/KdMX9in0/l5gtMdL07tWPmpBE8Phu/LoyBjxuqFC5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784617117; c=relaxed/simple;
	bh=+bhXdOTY4yijgnDNcKKLMglqtOkd6GcBoEfWj5v7u/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBv0F3A2rI6oFRENbpuEOfLb5J7zBsObSZBkXL+AiMkFoALEYKliTmP9cH68VV3zU2uisJ2Dq9YRNUBbI4VvQPo/bt5cGR7wxu+/cjvVvEwx26slcWyg872NlikK1tzNLf/Dk05iyiAQOs5UFpd9P5vCaV4ILfoe4bTWlGBWbvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pN0W1BiO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pN0W1BiO"
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 66L6w6MM13014054, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1784617086; bh=MwD/01m1eJN+aia/KT/cteuyoxG4f47EF4qMlDzjW78=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=pN0W1BiOtnHU4ZscFrQRslNK8Bu37v6eBEXx8g4FH3T+uSXfpBxVaqDiqZMWTlMx/
	 LKg1zOuExCyNwyRZCXgXx9gdQXldJOxx2o0To+UduNx7NQsVPa/oCQq8g/gBBFVusX
	 7+emxj/YXxOhs4z+Mkvr1v/hBhpHscmKRrAeGSsHBNRqdoBLz1ROiolFEGegQ5GzH+
	 hJ50uzS5LrhsrnTCUOaLFoTi78d/AP+kE1I0GXYWGvijlE8IPcU38zEk6Xhx6NmZLg
	 jlDXozvTTvr/BVBaf2nyn6OVI5hoDHJpOYlQGgD4ttNSljmaDXUZtRjWhjRDq7d9ud
	 EtZ4zmNu86zHg==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.29/5.94) with ESMTPS id 66L6w6MM13014054
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Tue, 21 Jul 2026 14:58:06 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
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
Subject: [PATCH v6 5/8] gpio: regmap: Add gpio_regmap_operation and value_xlate support
Date: Tue, 21 Jul 2026 14:57:59 +0800
Message-ID: <20260721065802.689530-6-eleanor.lin@realtek.com>
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

Extend the reg_mask_xlate callback with an operation type parameter
(enum gpio_regmap_operation) to allow drivers to return different
register/mask combinations depending on the specific GPIO operation.

In addition, introduce a new optional 'value_xlate' callback. This routine
allows drivers to translate or modify the register value and mask
immediately before a write operation. It is particularly useful for
hardware that requires additional control bits, such as a write-enable bit,
to be appended to the data dynamically.

Consequently, update all existing drivers utilizing the gpio-regmap
framework (across drivers/gpio, drivers/iio, and drivers/pinctrl)
to accommodate the new reg_mask_xlate function signature.

Suggested-by: Linus Walleij <linusw@kernel.org>
Signed-off-by: Yu-Chun Lin <eleanor.lin@realtek.com>
---
Changes in v6:
- Remove removed the hardcoded write-enable workarounds.
- Retain the necessary prototype updates in every driver using custom
reg_mask_xlate
- Add value_xlate to dynamically adjust the register mask and value right
before the actual register write operation.
---
 drivers/gpio/gpio-104-idi-48.c        |  7 +--
 drivers/gpio/gpio-i8255.c             |  4 +-
 drivers/gpio/gpio-idio-16.c           |  6 +--
 drivers/gpio/gpio-max7360.c           |  1 +
 drivers/gpio/gpio-pcie-idio-24.c      |  6 +--
 drivers/gpio/gpio-regmap.c            | 62 ++++++++++++++++++++++-----
 drivers/iio/adc/ad7173.c              |  8 ++--
 drivers/iio/addac/stx104.c            |  6 +--
 drivers/pinctrl/bcm/pinctrl-bcm63xx.c |  1 +
 drivers/pinctrl/pinctrl-tps6594.c     |  1 +
 include/linux/gpio/regmap.h           | 44 +++++++++++++++++--
 11 files changed, 115 insertions(+), 31 deletions(-)

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
index 658b892b624c..aecc35f610dd 100644
--- a/drivers/gpio/gpio-regmap.c
+++ b/drivers/gpio/gpio-regmap.c
@@ -40,9 +40,16 @@ struct gpio_regmap {
 	struct regmap_irq_chip_data *irq_chip_data;
 #endif
 
-	int (*reg_mask_xlate)(struct gpio_regmap *gpio, unsigned int base,
-			      unsigned int offset, unsigned int *reg,
-			      unsigned int *mask);
+	int (*reg_mask_xlate)(struct gpio_regmap *gpio,
+			      enum gpio_regmap_operation op,
+			      unsigned int base, unsigned int offset,
+			      unsigned int *reg, unsigned int *mask);
+
+	int (*value_xlate)(struct gpio_regmap *gpio,
+			   enum gpio_regmap_operation op,
+			   unsigned int base, unsigned int offset,
+			   unsigned int reg, unsigned int *mask,
+			   unsigned int *val);
 
 	void *driver_data;
 };
@@ -56,6 +63,7 @@ static unsigned int gpio_regmap_addr(unsigned int addr)
 }
 
 static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
+				    enum gpio_regmap_operation op,
 				    unsigned int base, unsigned int offset,
 				    unsigned int *reg, unsigned int *mask)
 {
@@ -71,7 +79,7 @@ static int gpio_regmap_simple_xlate(struct gpio_regmap *gpio,
 static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, val, reg, mask;
+	unsigned int base, val, reg, mask, dir_mask;
 	int ret;
 
 	/* we might not have an output register if we are input only */
@@ -80,7 +88,18 @@ static int gpio_regmap_get(struct gpio_chip *chip, unsigned int offset)
 	else
 		base = gpio_regmap_addr(gpio->reg_set_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_OP, base, offset, &reg, &dir_mask);
+	if (ret)
+		return ret;
+
+	ret = regmap_read(gpio->regmap, reg, &val);
+	if (ret)
+		return ret;
+
+	if (val & dir_mask)
+		ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_OUT, base, offset, &reg, &mask);
+	else
+		ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_IN, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -103,7 +122,7 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	unsigned int reg, mask, mask_val;
 	int ret;
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -112,6 +131,13 @@ static int gpio_regmap_set(struct gpio_chip *chip, unsigned int offset,
 	else
 		mask_val = 0;
 
+	if (gpio->value_xlate) {
+		ret = gpio->value_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset,
+					reg, &mask, &mask_val);
+		if (ret)
+			return ret;
+	}
+
 	/* ignore input values which shadow the old output value */
 	if (gpio->reg_dat_base == gpio->reg_set_base)
 		ret = regmap_write_bits(gpio->regmap, reg, mask, mask_val);
@@ -125,7 +151,7 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 				      unsigned int offset, int val)
 {
 	struct gpio_regmap *gpio = gpiochip_get_data(chip);
-	unsigned int base, reg, mask;
+	unsigned int base, reg, mask, value = 0;
 	int ret;
 
 	if (val)
@@ -133,10 +159,17 @@ static int gpio_regmap_set_with_clear(struct gpio_chip *chip,
 	else
 		base = gpio_regmap_addr(gpio->reg_clr_base);
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
+	if (gpio->value_xlate) {
+		ret = gpio->value_xlate(gpio, GPIO_REGMAP_SET_OP, base, offset,
+					reg, &mask, &value);
+		if (ret)
+			return ret;
+	}
+
 	return regmap_write(gpio->regmap, reg, mask);
 }
 
@@ -183,7 +216,7 @@ static int gpio_regmap_get_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_GET_DIR_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -237,7 +270,7 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 		return -ENOTSUPP;
 	}
 
-	ret = gpio->reg_mask_xlate(gpio, base, offset, &reg, &mask);
+	ret = gpio->reg_mask_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base, offset, &reg, &mask);
 	if (ret)
 		return ret;
 
@@ -246,6 +279,13 @@ static int gpio_regmap_set_direction(struct gpio_chip *chip,
 	else
 		val = output ? mask : 0;
 
+	if (gpio->value_xlate) {
+		ret = gpio->value_xlate(gpio, GPIO_REGMAP_SET_DIR_OP, base, offset,
+					reg, &mask, &val);
+		if (ret)
+			return ret;
+	}
+
 	return regmap_update_bits(gpio->regmap, reg, mask, val);
 }
 
@@ -413,6 +453,8 @@ struct gpio_regmap *gpio_regmap_register(const struct gpio_regmap_config *config
 	if (!gpio->reg_mask_xlate)
 		gpio->reg_mask_xlate = gpio_regmap_simple_xlate;
 
+	gpio->value_xlate = config->value_xlate;
+
 	ret = gpiochip_add_data(chip, gpio);
 	if (ret < 0)
 		goto err_free_bitmap_output;
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
index a3ba8242c353..45a30f50043f 100644
--- a/include/linux/gpio/regmap.h
+++ b/include/linux/gpio/regmap.h
@@ -13,6 +13,36 @@ struct regmap;
 #define GPIO_REGMAP_ADDR_ZERO ((unsigned int)(-1))
 #define GPIO_REGMAP_ADDR(addr) ((addr) ? : GPIO_REGMAP_ADDR_ZERO)
 
+/**
+ * enum gpio_regmap_operation - Operation type for reg_mask_xlate callback
+ *
+ * This enum is used to distinguish between different types of GPIO operations
+ * so that the reg_mask_xlate callback can return the appropriate mask for each
+ * operation type.
+ *
+ * Value operations:
+ * @GPIO_REGMAP_GET_OP: Mask for reading direction to detect if GPIO is input or output.
+ *                      Used in gpio_regmap_get() to determine the GPIO direction.
+ * @GPIO_REGMAP_IN: Mask for reading input value. Used when GPIO is configured as input.
+ * @GPIO_REGMAP_OUT: Mask for reading output value. Used when GPIO is configured as output.
+ *
+ * Output operations:
+ * @GPIO_REGMAP_SET_OP: Mask for setting GPIO output value.
+ *
+ * Direction operations:
+ * @GPIO_REGMAP_GET_DIR_OP: Mask for reading GPIO direction (input/output).
+ * @GPIO_REGMAP_SET_DIR_OP: Mask for setting GPIO direction (input/output).
+ *
+ */
+enum gpio_regmap_operation {
+	GPIO_REGMAP_GET_OP,
+	GPIO_REGMAP_SET_OP,
+	GPIO_REGMAP_GET_DIR_OP,
+	GPIO_REGMAP_SET_DIR_OP,
+	GPIO_REGMAP_IN,
+	GPIO_REGMAP_OUT,
+};
+
 /**
  * struct gpio_regmap_config - Description of a generic regmap gpio_chip.
  * @parent:		The parent device
@@ -55,6 +85,10 @@ struct regmap;
  *			is used.
  * @init_valid_mask:	(Optional) Routine to initialize @valid_mask, to be used
  *			if not all GPIOs are valid.
+ * @value_xlate:	(Optional) Routine to translate the register value and
+ *			mask before writing. This allows driver-specific logic
+ *			to append additional bits (like write-enable masks)
+ *			dynamically based on the current operation.
  * @drvdata:		(Optional) Pointer to driver specific data which is
  *			not used by gpio-remap but is provided "as is" to the
  *			driver callback(s).
@@ -104,14 +138,18 @@ struct gpio_regmap_config {
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
 			       unsigned int ngpios);
 
+	int (*value_xlate)(struct gpio_regmap *gpio, enum gpio_regmap_operation,
+			   unsigned int base, unsigned int offset, unsigned int reg,
+			   unsigned int *mask, unsigned int *val);
+
 	void *drvdata;
 };
 
-- 
2.43.0

