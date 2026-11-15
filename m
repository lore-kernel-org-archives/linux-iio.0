Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.218.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794733896;
	b=X+/MnSgSx4Gz8D6eukpbxxa9dmRKMebG4/g/xY88H92Dynra9VtXYEhtfaxWLw2iTrxn
	 gRPbnMDk9l4YnSqnZ3N1ZIHIB3RH/Ez7JKYJ9ikkKgCQlQ/T/mjdpHgnAgJMOkKX/jo6P
	 QLWzIK4+3wHZVMMQ4O6U7Spb41t8zj40HnfCi6l1c4yaDkF59svAYAe/WA+NFIUn3Jnwn
	 XdM5lRAFxeFd12p30L/SQSo/yOmWcuAc9ADT3LPa+PCo7AUjm5b/Zi5y8O7CSjrHeL54G
	 1RAIJ6xqZPbQ86hsC43seHKqlLB6E5yRFozAPMsx4V0BVlq3aoR6qV960RApzLED1Sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794733896;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=RY4e8RQI4e8c796FFazTJw15iVbsWFNMY5rFPzIKTlI=;
	b=lT0IUUeEMAzhA8b3NPrky5EfaKTr+0MEr7MLn8PAbMYF3etGiD9yVK4GRzD65pSbAtVM
	 d3z6MmwhQS8Vont9UzrxtFqlKvkY4Aak58jQ65J8HvnNHGKwalMaPx4DtTXhKFbNBs8N2
	 M9xiEK/t7F2gkghOYLekH7LXdCIJ5KRqRBf4b63Fil5yc5rGLixLMGVrNlEP+L7fzzTMF
	 dCrFKrYkbEcH2MR7EzOUd1AuGGr4XNKh+pBCsfsvqw09OszNRBiOX4QBrMTxAEBVk6pXX
	 /CJBhsvReXkBk7j2rpcjAcJNaDMLoxZlxZwZQZOZzZguKqzrZ35tVaqSfmJjhk46hUw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zpeEOxJF;
	arc=none smtp.remote-ip=209.85.218.53
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED954606A883
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 09:11:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED954606A883
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zpeEOxJF
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-c4d581da0aaso308232266b.2
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 01:11:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794733894; x=1795338694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RY4e8RQI4e8c796FFazTJw15iVbsWFNMY5rFPzIKTlI=;
        b=zpeEOxJFB4OlzxXuUvRB2ROyZTScJGpNYisw2Pm31di54GthPgqqLGb9lLSctlhvPn
         RvLh4IRsAyKv9IXTMxCy+rNYTf8jlvqI5o1xhXZOCZ7PLJdPtGaRxSea3gDi/aK6RmS5
         w/66Zuz/EiRerU4+QP0nyZblpt1ciRGAOHHXGaBCjJVIe92oACMD6nPeoDX0YkvhOpi1
         JS6n2elcMbN+mp7mIcq3pR+K+a/D0FEq7dIPsudqzJRMflViZBFDyPWoeslr1RvFG64M
         xRCuGA1aRLTrNI24SXeT67TWN+VecygM+0TpF/3jbZyv8QzLKwiF1ZRyWQ+Sto6HdzHF
         UnXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794733894; x=1795338694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=RY4e8RQI4e8c796FFazTJw15iVbsWFNMY5rFPzIKTlI=;
        b=iO9CzLsIjMXWo3UbB3zhVS+F8nUHjcCCDPeP6aOXVKyaEXZEpJXjOGwqWnQ5kvbMXK
         Y7wSBU6ZJRptSjV2Av4AZUxOZVpYxtubqIFUazM/Of45Rj2KZo1Q/rUMUF9/ZWPchJsv
         490yez/OApohFj4bFTQ8D2JGw2VHs8HQxGY7r7wyPYDJnJT4K90XCnlrf72R65de8fJ3
         FT34uChQgqzjuXhGFvhDAaD3J/fEzXAFmE5Sjk2UAMeXJBGOKAQoAMaNiDYU/dPAyo9d
         MEoeQWx5ASyEdKNAJx1oAoO17W5z2h6iv87A+OZWiR1E4b/jz0Io5eBpihGwkJedwgmw
         PWHA==
X-Forwarded-Encrypted: i=1; AL+hErED07O4PJ4BoaTHxi+JgMpeFGfPF7vloCK5guHJe32VHBhldLabOFznoNp3qqDbuBN3B8N8JPGPBMM=@vger.kernel.org
X-Gm-Message-State: APuU4Z/7RiH3Y1sJK39wdOIQtKUmQ40tIpZAxATlXWK9mkccl0u86R4B
	XJW4vlgsc9AXP64Y0h+/7aqMdeOv5CtT6gx+ckNvnJi2z4KQZOJLRB3N
X-Gm-Gg: AYBFou19YZTKvKt1odzZZkB2OH5w/APzcPP5S8UGp7/wkqa+wzwFhTk6V1CgL7xLWkS
	35bzqw3vFmdNuRxDahsaAPeJpYSuE5IjiAdt3lA3leygsv7ZPNztksKbLVuqfg1hNX6QEnTYbi3
	HMpIHUYb16ClYSn6K/HkJ9BPlep2CpR9arvj1Oqm5QbUwcOVB+uyB80mlVR93zuingKhsxWpHdy
	bW63i3ZDaEwVgpAw5Doxg5bgrQ9I458anC1klYbQlZQmZkXn9AE8vqarXI7vbTM44gmmmEx+pmT
	6wpnt1f0U20e52AkqrP7yRF7Tdym8ui3IWbFeKn13yLc2qU98ecXiDEcug2WzoSD6ZVjT8eNenR
	RcoDLHwR/U3za0Mu2oGozMqW2gSKIolvIQcUIXKmLnvw6QaX47cP0LmxdVgRgfbfS32VHAt6Utc
	KKJdWpeF8iR2KL7Zcw9zWaKexivrnPeGG021W0Mx3ess09t8Hgeo3sNaIIyUFQY10A+wOsa8GNn
	e0G8WnswdPLMW8snp84uMa6nUOMvNCHSgi0wd/XHXePhmCI3Gnv+vJox7EfyrwRJUsnBkQp+G89
	kdy6SSRySGYRv5MRuE/cUwctuYh83ViwdO9MOehvErXYrQbpWc7ZfvL02bGmqUcfYKWSJat5GUs
	7AuEsfYzRMrjeMQkf6HN/00iKaC4Wrqw=
X-Received: by 2002:a17:907:3e9e:b0:c41:5e31:5184 with SMTP id a640c23a62f3a-c5096344e23mr565201766b.13.1794733894179;
        Sun, 15 Nov 2026 01:11:34 -0800 (PST)
Received: from xeon ([188.163.112.62])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c5095b3dbaesm289392366b.32.2026.11.15.01.11.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 01:11:33 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	mfd@lists.linux.dev
Subject: [PATCH v2 2/4] mfd: max8907: Add ADC client support
Date: Sun, 15 Nov 2026 11:11:18 +0200
Message-ID: <20261115091120.108684-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115091120.108684-1-clamor95@gmail.com>
References: <20261115091120.108684-1-clamor95@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Maxim MAX8907 has an 8-channel ADC at a fixed location. Add client
support for it along with its regmap and interrupts.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/max8907.c       | 74 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8907.h | 53 ++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index f492ade8e4cf1..2aaea750d1690 100644
--- a/drivers/mfd/max8907.c
+++ b/drivers/mfd/max8907.c
@@ -113,6 +113,48 @@ static const struct regmap_config max8907_regmap_rtc_config = {
 	.cache_type = REGCACHE_MAPLE,
 };
 
+static bool max8907_adc_is_volatile_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX8907_REG_TSC_STA_INT:
+	case MAX8907_REG_AUX1_MSB ... MAX8907_REG_TDIE_LSB:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max8907_adc_is_precious_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX8907_REG_TSC_STA_INT:
+		return true;
+	default:
+		return false;
+	}
+}
+
+static bool max8907_adc_is_writeable_reg(struct device *dev, unsigned int reg)
+{
+	switch (reg) {
+	case MAX8907_REG_TSC_STA_INT:
+	case MAX8907_REG_AUX1_MSB ... MAX8907_REG_TDIE_LSB:
+		return false;
+	default:
+		return true;
+	}
+}
+
+static const struct regmap_config max8907_regmap_adc_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.volatile_reg = max8907_adc_is_volatile_reg,
+	.precious_reg = max8907_adc_is_precious_reg,
+	.writeable_reg = max8907_adc_is_writeable_reg,
+	.max_register = MAX8907_REG_TDIE_MEASURE,
+	.cache_type = REGCACHE_MAPLE,
+};
+
 static const struct regmap_irq max8907_chg_irqs[] = {
 	{ .reg_offset = 0, .mask = 1 << 0, },
 	{ .reg_offset = 0, .mask = 1 << 1, },
@@ -175,6 +217,20 @@ static const struct regmap_irq_chip max8907_rtc_irq_chip = {
 	.num_irqs = ARRAY_SIZE(max8907_rtc_irqs),
 };
 
+static const struct regmap_irq max8907_adc_irqs[] = {
+	{ .reg_offset = 0, .mask = BIT(0), },
+	{ .reg_offset = 0, .mask = BIT(1), },
+};
+
+static const struct regmap_irq_chip max8907_adc_irq_chip = {
+	.name = "max8907 adc",
+	.status_base = MAX8907_REG_TSC_STA_INT,
+	.mask_base = MAX8907_REG_TSC_INT_MASK,
+	.num_regs = 1,
+	.irqs = max8907_adc_irqs,
+	.num_irqs = ARRAY_SIZE(max8907_adc_irqs),
+};
+
 static int max8907_power_off(struct sys_off_data *data)
 {
 	struct max8907 *max8907 = data->cb_data;
@@ -233,6 +289,18 @@ static int max8907_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(dev, PTR_ERR(max8907->regmap_rtc),
 				     "RTC regmap init failed\n");
 
+	max8907->i2c_adc = devm_i2c_new_dummy_device(dev, i2c->adapter, MAX8907_ADC_I2C_ADDR);
+	if (IS_ERR(max8907->i2c_adc))
+		return PTR_ERR(max8907->i2c_adc);
+
+	i2c_set_clientdata(max8907->i2c_adc, max8907);
+
+	max8907->regmap_adc = devm_regmap_init_i2c(max8907->i2c_adc,
+						   &max8907_regmap_adc_config);
+	if (IS_ERR(max8907->regmap_adc))
+		return dev_err_probe(dev, PTR_ERR(max8907->regmap_adc),
+				     "ADC regmap init failed\n");
+
 	ret = devm_regmap_add_irq_chip(dev, max8907->regmap_gen, max8907->i2c_gen->irq,
 				       IRQF_ONESHOT | IRQF_SHARED, -1, &max8907_chg_irq_chip,
 				       &max8907->irqc_chg);
@@ -251,6 +319,12 @@ static int max8907_i2c_probe(struct i2c_client *i2c)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add rtc irq chip\n");
 
+	ret = devm_regmap_add_irq_chip(dev, max8907->regmap_adc, max8907->i2c_gen->irq,
+				       IRQF_ONESHOT | IRQF_SHARED, -1, &max8907_adc_irq_chip,
+				       &max8907->irqc_adc);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add adc irq chip\n");
+
 	ret = devm_mfd_add_devices(dev, -1, max8907_cells, ARRAY_SIZE(max8907_cells),
 				   NULL, 0, NULL);
 	if (ret)
diff --git a/include/linux/mfd/max8907.h b/include/linux/mfd/max8907.h
index 9865ae52877fd..ac4532d172331 100644
--- a/include/linux/mfd/max8907.h
+++ b/include/linux/mfd/max8907.h
@@ -153,6 +153,51 @@
 #define MAX8907_REG_MPL_CNTL		0x1E
 
 /* ADC and Touch Screen Controller register map */
+#define MAX8907_REG_TSC_STA_INT		0x00
+#define MAX8907_REG_TSC_INT_MASK	0x01
+#define MAX8907_REG_TSC_CNFG1		0x02
+#define MAX8907_REG_TSC_CNFG2		0x03
+#define MAX8907_REG_TSC_CNFG3		0x04
+#define MAX8907_REG_ADC_RES_CNFG1	0x06
+#define MAX8907_REG_ADC_AVG_CNFG1	0x07
+#define MAX8907_REG_ADC_ACQ_CNFG1	0x08
+#define MAX8907_REG_ADC_ACQ_CNFG2	0x09
+#define MAX8907_REG_ADC_SCHED		0x10
+#define MAX8907_REG_X_MSB		0x50
+#define MAX8907_REG_X_LSB		0x51
+#define MAX8907_REG_Y_MSB		0x52
+#define MAX8907_REG_Y_LSB		0x53
+#define MAX8907_REG_Z1_MSB		0x54
+#define MAX8907_REG_Z1_LSB		0x55
+#define MAX8907_REG_Z2_MSB		0x56
+#define MAX8907_REG_Z2_LSB		0x57
+#define MAX8907_REG_AUX1_MSB		0x60
+#define MAX8907_REG_AUX1_LSB		0x61
+#define MAX8907_REG_AUX2_MSB		0x62
+#define MAX8907_REG_AUX2_LSB		0x63
+#define MAX8907_REG_VCHG_MSB		0x64
+#define MAX8907_REG_VCHG_LSB		0x65
+#define MAX8907_REG_VBBATT_MSB		0x66
+#define MAX8907_REG_VBBATT_LSB		0x67
+#define MAX8907_REG_VMBATT_MSB		0x68
+#define MAX8907_REG_VMBATT_LSB		0x69
+#define MAX8907_REG_ISNS_MSB		0x6A
+#define MAX8907_REG_ISNS_LSB		0x6B
+#define MAX8907_REG_THM_MSB		0x6C
+#define MAX8907_REG_THM_LSB		0x6D
+#define MAX8907_REG_TDIE_MSB		0x6E
+#define MAX8907_REG_TDIE_LSB		0x6F
+
+#define MAX8907_REG_AUX1_MEASURE	0xC0
+#define MAX8907_REG_AUX2_MEASURE	0xC8
+#define MAX8907_REG_VCHG_MEASURE	0xD0
+#define MAX8907_REG_VBBATT_MEASURE	0xD8
+#define MAX8907_REG_VMBATT_MEASURE	0xE0
+#define MAX8907_REG_ISNS_MEASURE	0xE8
+#define MAX8907_REG_THM_MEASURE		0xF0
+#define MAX8907_REG_TDIE_MEASURE	0xF8
+
+/* Regulator stride */
 #define MAX8907_CTL			0
 #define MAX8907_SEQCNT			1
 #define MAX8907_VOUT			2
@@ -166,6 +211,8 @@
 #define MAX8907_MASK_OUT5V_EN		0x01
 #define MAX8907_MASK_SOFT_RESET		0x20
 #define MAX8907_MASK_POWER_OFF		0x40
+#define MAX8907_MASK_INT_REF_EN		0x01
+#define MAX8907_MASK_NREF_OK		0x10
 
 /* Regulator IDs */
 #define MAX8907_MBATT	0
@@ -226,6 +273,9 @@ enum {
 
 	MAX8907_IRQ_RTC_ALARM1 = 0,
 	MAX8907_IRQ_RTC_ALARM0,
+
+	MAX8907_IRQ_TSC_STICK = 0,
+	MAX8907_IRQ_TSC_NSTICK,
 };
 
 struct regmap_irq_chips_data;
@@ -235,11 +285,14 @@ struct max8907 {
 	struct mutex			irq_lock;
 	struct i2c_client		*i2c_gen;
 	struct i2c_client		*i2c_rtc;
+	struct i2c_client		*i2c_adc;
 	struct regmap			*regmap_gen;
 	struct regmap			*regmap_rtc;
+	struct regmap			*regmap_adc;
 	struct regmap_irq_chip_data	*irqc_chg;
 	struct regmap_irq_chip_data	*irqc_on_off;
 	struct regmap_irq_chip_data	*irqc_rtc;
+	struct regmap_irq_chip_data	*irqc_adc;
 };
 
 #endif
-- 
2.53.0

