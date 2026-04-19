Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F262F39C2
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776628788; cv=none; b=E3PWqMOrIzy+WX5fEif2MedT0EGC/rPQSWgEUVYeglCedfn6oTtnyA13vGyKquyQ9QS6b3owGwdhiw67z/+S6CRR5I8n43OjG7KffTNTdXCGb7Jvmw7pBHD2/9/NsGH36mPLiwsFH+ThFa+m0vkY8tFR5SbYD5p1VwC8lZqAE2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776628788; c=relaxed/simple;
	bh=u1DjuLJv3B9UnrkHjQRMvjj8DrFn4X2FMIArEdPEwO4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hcatO+N3Mf90D3FAby8czOMLIwRjVkPrLp2bX4FmxU068vlvVPyf/QsAhEyLtCkXhjXRKbvNead1ccSUErs9YcecahQ3gm4haGImlcBxvf3n8LZzEFiqC93VMONA4bFrE8m7PL8ybsdPJqi4rJvynDNcoFE4Tg1hPWSShrqKf4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dH8XfEmn; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dH8XfEmn"
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7605ec91so2076738f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 12:59:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776628785; x=1777233585; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rl/TuzTHRW8C3bls0W7JrVojdF7Zq05E0Xt/Pt3+S9I=;
        b=dH8XfEmnH75UANRP0pPii6GSv29EyuZP0i2sBIwbvVqEVJQOLDOCeSS6OpFnTVpBql
         Zrf8dT/f//JJoCgiEYtNnu2d5Yi9i3YRwwQQ4guAlACmVAaD6JWDW1G77twPKdI3a/Ed
         zG3JmBUef7Xq045v66BQvhfAMbMxh+anwIA8rPVLI1XyDLrXPoXsSXyK56KqfbpmBmJn
         mSpqz5bUgMjRXVK+co72P32OcsCC2yKKF+COu/Dv/dtfQtsJF+n3veVlsWqGzxl937M3
         8hMp2lu5U7wnGw2cbjcuJmCbC0wMegC8B23Pru6D3gaZxSV0sq37sia9KOAEhlu0SgeK
         F0rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776628785; x=1777233585;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rl/TuzTHRW8C3bls0W7JrVojdF7Zq05E0Xt/Pt3+S9I=;
        b=XaNwgxUADwylAlUGVzF2hLJKuGms3izpOosmE7p1UIiXnR2ZHtj13ALNdRgneKldcF
         tr7+ixf3l8/9KEcQvOOxUND24pIVKWT6CVfPvH2FBHHrjusONVBrYYp1NMrFp5D7Bh5J
         24KoQvoMRJqEuMiEGXHre+q2g5c9gxc8QfrEYOjJ3Y9Q2EZs3Bi2QA3CMNDVyPyYZo+z
         r/VNk+dCP62Da+JLnOAxV8GuUdrU/R97VP2T7WxxCunxFqDKlid9sDPA7p3pSCGhO8JF
         ZgkaI/wykbm4+buEp92aWHGOxYfCjzoJjzMuptuc3XqBASD9a8etKUenmWqaRhwEqMYM
         ZAiA==
X-Gm-Message-State: AOJu0Yyez4f3cylhzPmZ0XMk2+p2erQDvniA/8SeiEynTT1ee1cPwi/d
	y9ae0o+F4GNvB+/gZD1MYBqPAyPlcyhM3qheXr/Bro2JTWLS7l1zpFwwFVfm4ED0eY8=
X-Gm-Gg: AeBDiesHKMIfEIoYNTLGYvf+mZB6icdJFwSW1yCX8klLSBJOmQ6jI/LsbdNaDKk5E0W
	73IUnLD3qC/YeaSTJ0pQSPK5JtsCgGwnlIHOGJwaKy2LR8h64KN5J55/LZashoMbgHHXxhwABl/
	yhWS4mEEFI6FB9oy9ggfuTs6YHI6ya4zF5LSlsnCsKSoZQdIdXSreSMDyUR1MSKbWXTQtE3CEL7
	Y/jXBlSYT0hlbYK/JNDt5ka3ATuWouksDg3r3IjxAiouPrFBAlinPlKYenaoodNkZM0c9owkVFx
	3S9IgV43bHdAkbkpokMaANjSkerN6v0DKnFpfmV/JSEWKOA/1FR5CfHydEK8ccHxqfJml7AQK07
	AWb7b4r6KSoeV55P9ZiQQwfMDw/X5PbIUeBLx+t7le8VahpmxcSHLHyidm1fOq3Ik7NR4deFmxA
	jgLSsb1s9M
X-Received: by 2002:a05:6000:381:b0:43b:5b25:67f8 with SMTP id ffacd0b85a97d-43fe3dd4ce6mr15568490f8f.20.1776628784337;
        Sun, 19 Apr 2026 12:59:44 -0700 (PDT)
Received: from fedora ([2a02:8071:50c5:5c0::d908])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e46471sm22482179f8f.28.2026.04.19.12.59.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 12:59:43 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: wbg@kernel.org,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	linux-kernel@vger.kernel.org,
	Wadim Mueller <wafgo01@gmail.com>
Subject: [PATCH v2 2/3] counter: add GPIO-based quadrature encoder driver
Date: Sun, 19 Apr 2026 21:59:07 +0200
Message-ID: <20260419195908.12202-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260419195908.12202-1-wafgo01@gmail.com>
References: <20260419195908.12202-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a platform driver that turns ordinary GPIOs into a quadrature
encoder counter device.  The driver requests edge-triggered interrupts
on the A and B (and optional Index) GPIOs and decodes the quadrature
signal in software using a classic state-table approach.

Supported counting modes:
  - Quadrature X1 (count on A rising edge only)
  - Quadrature X2 (count on both A edges)
  - Quadrature X4 (count on every A and B edge)
  - Pulse-direction (A = pulse, B = direction)

An optional index signal resets the count to zero on its rising edge
when enabled through sysfs.  A configurable ceiling clamps the count
to [0, ceiling].

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 drivers/counter/Kconfig                   |  15 +
 drivers/counter/Makefile                  |   1 +
 drivers/counter/gpio-quadrature-encoder.c | 710 ++++++++++++++++++++++
 3 files changed, 726 insertions(+)
 create mode 100644 drivers/counter/gpio-quadrature-encoder.c

diff --git a/drivers/counter/Kconfig b/drivers/counter/Kconfig
index d30d22dfe..72c5c8159 100644
--- a/drivers/counter/Kconfig
+++ b/drivers/counter/Kconfig
@@ -68,6 +68,21 @@ config INTEL_QEP
 	  To compile this driver as a module, choose M here: the module
 	  will be called intel-qep.
 
+config GPIO_QUADRATURE_ENCODER
+	tristate "GPIO-based quadrature encoder counter driver"
+	depends on GPIOLIB
+	help
+	  Select this option to enable the GPIO-based quadrature encoder
+	  counter driver.  It reads A/B quadrature signals and an optional
+	  index pulse via edge-triggered GPIO interrupts, supporting X1, X2,
+	  X4 quadrature decoding and pulse-direction mode.
+
+	  This is useful on SoCs that lack a dedicated hardware quadrature
+	  decoder or where the encoder is wired to generic GPIO pins.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called gpio-quadrature-encoder.
+
 config INTERRUPT_CNT
 	tristate "Interrupt counter driver"
 	depends on GPIOLIB
diff --git a/drivers/counter/Makefile b/drivers/counter/Makefile
index fa3c1d08f..2bef64d10 100644
--- a/drivers/counter/Makefile
+++ b/drivers/counter/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_STM32_TIMER_CNT)	+= stm32-timer-cnt.o
 obj-$(CONFIG_STM32_LPTIMER_CNT)	+= stm32-lptimer-cnt.o
 obj-$(CONFIG_TI_EQEP)		+= ti-eqep.o
 obj-$(CONFIG_FTM_QUADDEC)	+= ftm-quaddec.o
+obj-$(CONFIG_GPIO_QUADRATURE_ENCODER)	+= gpio-quadrature-encoder.o
 obj-$(CONFIG_MICROCHIP_TCB_CAPTURE)	+= microchip-tcb-capture.o
 obj-$(CONFIG_INTEL_QEP)		+= intel-qep.o
 obj-$(CONFIG_TI_ECAP_CAPTURE)	+= ti-ecap-capture.o
diff --git a/drivers/counter/gpio-quadrature-encoder.c b/drivers/counter/gpio-quadrature-encoder.c
new file mode 100644
index 000000000..0822f0a8a
--- /dev/null
+++ b/drivers/counter/gpio-quadrature-encoder.c
@@ -0,0 +1,710 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * GPIO-based Quadrature Encoder Counter Driver
+ *
+ * Reads quadrature encoder signals (A, B, and optional Index) via GPIOs.
+ * Supports X1, X2, X4 quadrature decoding and pulse-direction mode.
+ *
+ * Copyright (C) 2026 CMBlu Energy AG
+ * Author: Wadim Mueller <wafgo01@gmail.com>
+ */
+
+#include <linux/counter.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/spinlock.h>
+#include <linux/types.h>
+
+enum gpio_qenc_function {
+	GPIO_QENC_FUNC_QUAD_X1 = 0,
+	GPIO_QENC_FUNC_QUAD_X2,
+	GPIO_QENC_FUNC_QUAD_X4,
+	GPIO_QENC_FUNC_PULSE_DIR,
+};
+
+enum gpio_qenc_signal_id {
+	GPIO_QENC_SIGNAL_A = 0,
+	GPIO_QENC_SIGNAL_B,
+	GPIO_QENC_SIGNAL_INDEX,
+};
+
+struct gpio_qenc_priv {
+	struct gpio_desc *gpio_a;
+	struct gpio_desc *gpio_b;
+	struct gpio_desc *gpio_index;
+
+	int irq_a;
+	int irq_b;
+	int irq_index;
+
+	spinlock_t lock;
+
+	s64 count;
+	u64 ceiling;
+	bool enabled;
+	enum counter_count_direction direction;
+	enum gpio_qenc_function function;
+
+	int prev_a;
+	int prev_b;
+
+	bool index_enabled;
+
+	struct counter_signal signals[3];
+	struct counter_synapse synapses[3];
+	struct counter_count cnts;
+};
+
+/*
+ * Quadrature state table for X4 decoding.
+ * Rows = previous state (A<<1 | B), Columns = new state (A<<1 | B).
+ * Values: 0 = no change, +1 = forward, -1 = backward, 2 = error (skip).
+ */
+static const int quad_table[4][4] = {
+	/*          00  01  10  11  <- new */
+	/* 00 */ {  0, -1,  1,  2 },
+	/* 01 */ {  1,  0,  2, -1 },
+	/* 10 */ { -1,  2,  0,  1 },
+	/* 11 */ {  2,  1, -1,  0 },
+};
+
+static void gpio_qenc_update_count(struct gpio_qenc_priv *priv, int delta)
+{
+	s64 new_count;
+
+	if (!delta)
+		return;
+
+	new_count = priv->count + delta;
+
+	if (priv->ceiling) {
+		if (new_count < 0)
+			new_count = 0;
+		else if (new_count > (s64)priv->ceiling)
+			new_count = priv->ceiling;
+	}
+
+	priv->count = new_count;
+	priv->direction = (delta > 0) ? COUNTER_COUNT_DIRECTION_FORWARD
+				      : COUNTER_COUNT_DIRECTION_BACKWARD;
+}
+
+static irqreturn_t gpio_qenc_a_isr(int irq, void *dev_id)
+{
+	struct counter_device *counter = dev_id;
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+	int a, b, prev_state, new_state, delta;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	if (!priv->enabled)
+		goto out;
+
+	a = gpiod_get_value(priv->gpio_a);
+	b = gpiod_get_value(priv->gpio_b);
+
+	prev_state = (priv->prev_a << 1) | priv->prev_b;
+	new_state = (a << 1) | b;
+
+	switch (priv->function) {
+	case GPIO_QENC_FUNC_QUAD_X4:
+		delta = quad_table[prev_state][new_state];
+		if (delta == 2)
+			delta = 0;
+		gpio_qenc_update_count(priv, delta);
+		break;
+
+	case GPIO_QENC_FUNC_QUAD_X2:
+		delta = quad_table[prev_state][new_state];
+		if (delta == 2)
+			delta = 0;
+		gpio_qenc_update_count(priv, delta);
+		break;
+
+	case GPIO_QENC_FUNC_QUAD_X1:
+		if (!priv->prev_a && a) {
+			delta = b ? -1 : 1;
+			gpio_qenc_update_count(priv, delta);
+		}
+		break;
+
+	case GPIO_QENC_FUNC_PULSE_DIR:
+		if (!priv->prev_a && a) {
+			delta = b ? -1 : 1;
+			gpio_qenc_update_count(priv, delta);
+		}
+		break;
+	}
+
+	priv->prev_a = a;
+	priv->prev_b = b;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	counter_push_event(counter, COUNTER_EVENT_CHANGE_OF_STATE, 0);
+
+	return IRQ_HANDLED;
+
+out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t gpio_qenc_b_isr(int irq, void *dev_id)
+{
+	struct counter_device *counter = dev_id;
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+	int a, b, prev_state, new_state, delta;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	if (!priv->enabled)
+		goto out;
+
+	a = gpiod_get_value(priv->gpio_a);
+	b = gpiod_get_value(priv->gpio_b);
+
+	prev_state = (priv->prev_a << 1) | priv->prev_b;
+	new_state = (a << 1) | b;
+
+	switch (priv->function) {
+	case GPIO_QENC_FUNC_QUAD_X4:
+		delta = quad_table[prev_state][new_state];
+		if (delta == 2)
+			delta = 0;
+		gpio_qenc_update_count(priv, delta);
+		break;
+
+	case GPIO_QENC_FUNC_QUAD_X2:
+		/* X2: only A-channel edges update count */
+		break;
+
+	case GPIO_QENC_FUNC_QUAD_X1:
+	case GPIO_QENC_FUNC_PULSE_DIR:
+		break;
+	}
+
+	priv->prev_a = a;
+	priv->prev_b = b;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return IRQ_HANDLED;
+
+out:
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t gpio_qenc_index_isr(int irq, void *dev_id)
+{
+	struct counter_device *counter = dev_id;
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	if (priv->enabled && priv->index_enabled)
+		priv->count = 0;
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	counter_push_event(counter, COUNTER_EVENT_INDEX, 0);
+
+	return IRQ_HANDLED;
+}
+
+static int gpio_qenc_count_read(struct counter_device *counter,
+				struct counter_count *count, u64 *val)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*val = (u64)priv->count;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int gpio_qenc_count_write(struct counter_device *counter,
+				 struct counter_count *count, const u64 val)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	if (priv->ceiling && val > priv->ceiling) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return -EINVAL;
+	}
+
+	priv->count = (s64)val;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static const enum counter_function gpio_qenc_functions[] = {
+	COUNTER_FUNCTION_QUADRATURE_X1_A,
+	COUNTER_FUNCTION_QUADRATURE_X2_A,
+	COUNTER_FUNCTION_QUADRATURE_X4,
+	COUNTER_FUNCTION_PULSE_DIRECTION,
+};
+
+static int gpio_qenc_function_read(struct counter_device *counter,
+				   struct counter_count *count,
+				   enum counter_function *function)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (priv->function) {
+	case GPIO_QENC_FUNC_QUAD_X1:
+		*function = COUNTER_FUNCTION_QUADRATURE_X1_A;
+		break;
+	case GPIO_QENC_FUNC_QUAD_X2:
+		*function = COUNTER_FUNCTION_QUADRATURE_X2_A;
+		break;
+	case GPIO_QENC_FUNC_QUAD_X4:
+		*function = COUNTER_FUNCTION_QUADRATURE_X4;
+		break;
+	case GPIO_QENC_FUNC_PULSE_DIR:
+		*function = COUNTER_FUNCTION_PULSE_DIRECTION;
+		break;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return 0;
+}
+
+static int gpio_qenc_function_write(struct counter_device *counter,
+				    struct counter_count *count,
+				    enum counter_function function)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	switch (function) {
+	case COUNTER_FUNCTION_QUADRATURE_X1_A:
+		priv->function = GPIO_QENC_FUNC_QUAD_X1;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X2_A:
+		priv->function = GPIO_QENC_FUNC_QUAD_X2;
+		break;
+	case COUNTER_FUNCTION_QUADRATURE_X4:
+		priv->function = GPIO_QENC_FUNC_QUAD_X4;
+		break;
+	case COUNTER_FUNCTION_PULSE_DIRECTION:
+		priv->function = GPIO_QENC_FUNC_PULSE_DIR;
+		break;
+	default:
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return -EINVAL;
+	}
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+	return 0;
+}
+
+static const enum counter_synapse_action gpio_qenc_synapse_actions[] = {
+	COUNTER_SYNAPSE_ACTION_BOTH_EDGES,
+	COUNTER_SYNAPSE_ACTION_RISING_EDGE,
+	COUNTER_SYNAPSE_ACTION_NONE,
+};
+
+static int gpio_qenc_action_read(struct counter_device *counter,
+				 struct counter_count *count,
+				 struct counter_synapse *synapse,
+				 enum counter_synapse_action *action)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	enum gpio_qenc_signal_id signal_id = synapse->signal->id;
+
+	switch (priv->function) {
+	case GPIO_QENC_FUNC_QUAD_X4:
+		if (signal_id == GPIO_QENC_SIGNAL_A ||
+		    signal_id == GPIO_QENC_SIGNAL_B)
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		return 0;
+
+	case GPIO_QENC_FUNC_QUAD_X2:
+		if (signal_id == GPIO_QENC_SIGNAL_A)
+			*action = COUNTER_SYNAPSE_ACTION_BOTH_EDGES;
+		else if (signal_id == GPIO_QENC_SIGNAL_B)
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		return 0;
+
+	case GPIO_QENC_FUNC_QUAD_X1:
+		if (signal_id == GPIO_QENC_SIGNAL_A)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		else if (signal_id == GPIO_QENC_SIGNAL_B)
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		return 0;
+
+	case GPIO_QENC_FUNC_PULSE_DIR:
+		if (signal_id == GPIO_QENC_SIGNAL_A)
+			*action = COUNTER_SYNAPSE_ACTION_RISING_EDGE;
+		else
+			*action = COUNTER_SYNAPSE_ACTION_NONE;
+		return 0;
+	}
+
+	return -EINVAL;
+}
+
+static int gpio_qenc_signal_read(struct counter_device *counter,
+				 struct counter_signal *signal,
+				 enum counter_signal_level *level)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	struct gpio_desc *gpio;
+	int ret;
+
+	switch (signal->id) {
+	case GPIO_QENC_SIGNAL_A:
+		gpio = priv->gpio_a;
+		break;
+	case GPIO_QENC_SIGNAL_B:
+		gpio = priv->gpio_b;
+		break;
+	case GPIO_QENC_SIGNAL_INDEX:
+		gpio = priv->gpio_index;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (!gpio)
+		return -EINVAL;
+
+	ret = gpiod_get_value(gpio);
+	if (ret < 0)
+		return ret;
+
+	*level = ret ? COUNTER_SIGNAL_LEVEL_HIGH : COUNTER_SIGNAL_LEVEL_LOW;
+	return 0;
+}
+
+static int gpio_qenc_events_configure(struct counter_device *counter)
+{
+	return 0;
+}
+
+static int gpio_qenc_watch_validate(struct counter_device *counter,
+				    const struct counter_watch *watch)
+{
+	if (watch->channel != 0)
+		return -EINVAL;
+
+	switch (watch->event) {
+	case COUNTER_EVENT_CHANGE_OF_STATE:
+	case COUNTER_EVENT_INDEX:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+}
+
+static const struct counter_ops gpio_qenc_ops = {
+	.count_read	= gpio_qenc_count_read,
+	.count_write	= gpio_qenc_count_write,
+	.function_read	= gpio_qenc_function_read,
+	.function_write	= gpio_qenc_function_write,
+	.action_read	= gpio_qenc_action_read,
+	.signal_read	= gpio_qenc_signal_read,
+	.events_configure = gpio_qenc_events_configure,
+	.watch_validate	= gpio_qenc_watch_validate,
+};
+
+static int gpio_qenc_ceiling_read(struct counter_device *counter,
+				  struct counter_count *count, u64 *val)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*val = priv->ceiling;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int gpio_qenc_ceiling_write(struct counter_device *counter,
+				   struct counter_count *count, const u64 val)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->ceiling = val;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int gpio_qenc_enable_read(struct counter_device *counter,
+				 struct counter_count *count, u8 *enable)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+
+	*enable = priv->enabled;
+	return 0;
+}
+
+static int gpio_qenc_enable_write(struct counter_device *counter,
+				  struct counter_count *count, u8 enable)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	if (priv->enabled == !!enable) {
+		spin_unlock_irqrestore(&priv->lock, flags);
+		return 0;
+	}
+
+	if (enable) {
+		priv->enabled = true;
+		spin_unlock_irqrestore(&priv->lock, flags);
+		enable_irq(priv->irq_a);
+		enable_irq(priv->irq_b);
+		if (priv->irq_index)
+			enable_irq(priv->irq_index);
+	} else {
+		priv->enabled = false;
+		spin_unlock_irqrestore(&priv->lock, flags);
+		disable_irq(priv->irq_a);
+		disable_irq(priv->irq_b);
+		if (priv->irq_index)
+			disable_irq(priv->irq_index);
+	}
+
+	return 0;
+}
+
+static int gpio_qenc_direction_read(struct counter_device *counter,
+				    struct counter_count *count, u32 *direction)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	*direction = priv->direction;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static int gpio_qenc_index_enable_read(struct counter_device *counter,
+				       struct counter_count *count, u8 *val)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+
+	*val = priv->index_enabled;
+	return 0;
+}
+
+static int gpio_qenc_index_enable_write(struct counter_device *counter,
+					struct counter_count *count, u8 val)
+{
+	struct gpio_qenc_priv *priv = counter_priv(counter);
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+	priv->index_enabled = !!val;
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static struct counter_comp gpio_qenc_count_ext[] = {
+	COUNTER_COMP_CEILING(gpio_qenc_ceiling_read, gpio_qenc_ceiling_write),
+	COUNTER_COMP_ENABLE(gpio_qenc_enable_read, gpio_qenc_enable_write),
+	COUNTER_COMP_DIRECTION(gpio_qenc_direction_read),
+	COUNTER_COMP_COUNT_BOOL("index_enabled",
+				gpio_qenc_index_enable_read,
+				gpio_qenc_index_enable_write),
+};
+
+static int gpio_qenc_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct counter_device *counter;
+	struct gpio_qenc_priv *priv;
+	bool has_index;
+	int num_signals;
+	int num_synapses;
+	int ret;
+
+	counter = devm_counter_alloc(dev, sizeof(*priv));
+	if (!counter)
+		return -ENOMEM;
+
+	priv = counter_priv(counter);
+	spin_lock_init(&priv->lock);
+
+	priv->gpio_a = devm_gpiod_get(dev, "encoder-a", GPIOD_IN);
+	if (IS_ERR(priv->gpio_a))
+		return dev_err_probe(dev, PTR_ERR(priv->gpio_a),
+				     "failed to get encoder-a GPIO\n");
+
+	priv->gpio_b = devm_gpiod_get(dev, "encoder-b", GPIOD_IN);
+	if (IS_ERR(priv->gpio_b))
+		return dev_err_probe(dev, PTR_ERR(priv->gpio_b),
+				     "failed to get encoder-b GPIO\n");
+
+	priv->gpio_index = devm_gpiod_get_optional(dev, "encoder-index",
+						    GPIOD_IN);
+	if (IS_ERR(priv->gpio_index))
+		return dev_err_probe(dev, PTR_ERR(priv->gpio_index),
+				     "failed to get encoder-index GPIO\n");
+
+	has_index = !!priv->gpio_index;
+
+	priv->irq_a = gpiod_to_irq(priv->gpio_a);
+	if (priv->irq_a < 0)
+		return dev_err_probe(dev, priv->irq_a,
+				     "failed to get IRQ for encoder-a\n");
+
+	priv->irq_b = gpiod_to_irq(priv->gpio_b);
+	if (priv->irq_b < 0)
+		return dev_err_probe(dev, priv->irq_b,
+				     "failed to get IRQ for encoder-b\n");
+
+	if (has_index) {
+		priv->irq_index = gpiod_to_irq(priv->gpio_index);
+		if (priv->irq_index < 0)
+			return dev_err_probe(dev, priv->irq_index,
+					     "failed to get IRQ for encoder-index\n");
+	}
+
+	priv->prev_a = gpiod_get_value(priv->gpio_a);
+	priv->prev_b = gpiod_get_value(priv->gpio_b);
+
+	priv->function = GPIO_QENC_FUNC_QUAD_X4;
+	priv->direction = COUNTER_COUNT_DIRECTION_FORWARD;
+
+	num_signals = has_index ? 3 : 2;
+
+	priv->signals[GPIO_QENC_SIGNAL_A].id = GPIO_QENC_SIGNAL_A;
+	priv->signals[GPIO_QENC_SIGNAL_A].name = "Signal A";
+
+	priv->signals[GPIO_QENC_SIGNAL_B].id = GPIO_QENC_SIGNAL_B;
+	priv->signals[GPIO_QENC_SIGNAL_B].name = "Signal B";
+
+	if (has_index) {
+		priv->signals[GPIO_QENC_SIGNAL_INDEX].id =
+			GPIO_QENC_SIGNAL_INDEX;
+		priv->signals[GPIO_QENC_SIGNAL_INDEX].name = "Index";
+	}
+
+	num_synapses = num_signals;
+
+	priv->synapses[0].actions_list = gpio_qenc_synapse_actions;
+	priv->synapses[0].num_actions = ARRAY_SIZE(gpio_qenc_synapse_actions);
+	priv->synapses[0].signal = &priv->signals[GPIO_QENC_SIGNAL_A];
+
+	priv->synapses[1].actions_list = gpio_qenc_synapse_actions;
+	priv->synapses[1].num_actions = ARRAY_SIZE(gpio_qenc_synapse_actions);
+	priv->synapses[1].signal = &priv->signals[GPIO_QENC_SIGNAL_B];
+
+	if (has_index) {
+		priv->synapses[2].actions_list = gpio_qenc_synapse_actions;
+		priv->synapses[2].num_actions =
+			ARRAY_SIZE(gpio_qenc_synapse_actions);
+		priv->synapses[2].signal =
+			&priv->signals[GPIO_QENC_SIGNAL_INDEX];
+	}
+
+	priv->cnts.id = 0;
+	priv->cnts.name = "Position";
+	priv->cnts.functions_list = gpio_qenc_functions;
+	priv->cnts.num_functions = ARRAY_SIZE(gpio_qenc_functions);
+	priv->cnts.synapses = priv->synapses;
+	priv->cnts.num_synapses = num_synapses;
+	priv->cnts.ext = gpio_qenc_count_ext;
+	priv->cnts.num_ext = ARRAY_SIZE(gpio_qenc_count_ext);
+
+	counter->name = dev_name(dev);
+	counter->parent = dev;
+	counter->ops = &gpio_qenc_ops;
+	counter->signals = priv->signals;
+	counter->num_signals = num_signals;
+	counter->counts = &priv->cnts;
+	counter->num_counts = 1;
+
+	irq_set_status_flags(priv->irq_a, IRQ_NOAUTOEN);
+	ret = devm_request_irq(dev, priv->irq_a, gpio_qenc_a_isr,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       "gpio-qenc-a", counter);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to request IRQ for encoder-a\n");
+
+	irq_set_status_flags(priv->irq_b, IRQ_NOAUTOEN);
+	ret = devm_request_irq(dev, priv->irq_b, gpio_qenc_b_isr,
+			       IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING,
+			       "gpio-qenc-b", counter);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "failed to request IRQ for encoder-b\n");
+
+	if (has_index) {
+		irq_set_status_flags(priv->irq_index, IRQ_NOAUTOEN);
+		ret = devm_request_irq(dev, priv->irq_index,
+				       gpio_qenc_index_isr,
+				       IRQF_TRIGGER_RISING,
+				       "gpio-qenc-index", counter);
+		if (ret)
+			return dev_err_probe(dev, ret,
+					     "failed to request IRQ for encoder-index\n");
+	}
+
+	ret = devm_counter_add(dev, counter);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "failed to add counter\n");
+
+	dev_info(dev, "GPIO quadrature encoder registered (signals: A, B%s)\n",
+		 has_index ? ", Index" : "");
+
+	return 0;
+}
+
+static const struct of_device_id gpio_qenc_of_match[] = {
+	{ .compatible = "gpio-quadrature-encoder" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, gpio_qenc_of_match);
+
+static struct platform_driver gpio_qenc_driver = {
+	.probe = gpio_qenc_probe,
+	.driver = {
+		.name = "gpio-quadrature-encoder",
+		.of_match_table = gpio_qenc_of_match,
+	},
+};
+module_platform_driver(gpio_qenc_driver);
+
+MODULE_ALIAS("platform:gpio-quadrature-encoder");
+MODULE_AUTHOR("Wadim Mueller <wafgo01@gmail.com>");
+MODULE_DESCRIPTION("GPIO-based quadrature encoder counter driver");
+MODULE_LICENSE("GPL");
+MODULE_IMPORT_NS("COUNTER");
-- 
2.52.0

