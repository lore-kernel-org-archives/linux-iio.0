Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795446463;
	b=ioSZvmBuH4BsfXoAz1jy/oyrccE5HppEFEj4j8g9DrFcVyY37yR1HdAsEZTePX0/3NE5
	 6LD7Rj467XXHCYEckv7tkQ6nVw9auj0SnLKdcMFZmuv3ZDb95nMGDvH0+7LM8N+7gnET4
	 V405EautcrsaX5abPi3o05hTk7zxRRD50cgCx2BVL0WCGDRhrbxITCoBkER3NtK8KPfqm
	 SxNqYKTXXfXGZGvfXwusqwe94ys2s5Sb+afIynBu/i7WxtoJMWydyj6g3DCweRkcVynqh
	 D7gyHkf1EisoeKuId2OlFR68CGbTsHorVL5C1fcFTF+WHN5uwy4e7ZovA+c2CPgRFhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795446463;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=YYIF8RkppipMffW3zldT0xJTZtUWxbFsBpGgswJx78w=;
	b=MgxLa+oToUEf0mDd6S+SNleQSUP5fsR5mv/3jGSDqru0SW6VnjeHVRh62vy1JxBL4vLR
	 grwf5VG9hLrnHJJ00cl71QscFuZz1rHOOSvnS6rzXSosoQyV2IsPnQ9C2+Sii82aMNrVF
	 Nm/ra5W3f+BYA1WYaZez83U7r35FG2sM4CDbUdwVILwcPHotKkKfeXkSBvHkba7EdjWdl
	 mkY6CqYW9U8Btd8N+adMPFIFPBVbCm+HWzA9A+j89jEr2rvhtZx/HdzbQxRsEkx/B9J3+
	 mBfrWOZQpDaPHN8+qE5iriKYXMuFGCa3TcmegjIEvg5+n4+P7Bk5KAWasu+rLyVOLeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TfA421co;
	arc=none smtp.remote-ip=209.85.208.42
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7540606A334
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 15:07:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7540606A334
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TfA421co
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6b86fcbd647so5392711a12.1
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795446461; x=1796051261; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YYIF8RkppipMffW3zldT0xJTZtUWxbFsBpGgswJx78w=;
        b=TfA421comjFBVbbEMmsL749if8t/plGgmb6d1AxvnpKwqaF9MibkRxyxNAT5zg/tks
         c6LQXh7BNTIowGXReJdjFY5Dt7y6bFU/Udj7Ekwn1aEY2rm27N42MzOecrrVIXh/elA8
         MzIcviteHv8a6xn+WyORl5Xc8TRj2+je6BEH/GLltKfG/AX82VtXvlVvtV8JlzghVGGI
         kKj1FfgMCxenXBernHt5dUwc/DdHFhYNZchOYssKRgL6RtNHqK4LS6tKnFnszzhxnYTy
         NPnnBcioA/GxQPoelYLTQ1nncVOwrFje39Uwh9et3GJ69nc0P/ylnnDb5Jr17joZhQ2Q
         izyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795446461; x=1796051261;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YYIF8RkppipMffW3zldT0xJTZtUWxbFsBpGgswJx78w=;
        b=C6KJv+SeD/UOzgqtI9T4W09EiMEGBdDUV3nMfzLHySMnk450BOvNSVS5MfZlZkFXE8
         brOhMefMwj3lCDDpXBPvrPolT4vn2tfOyIqky+bUbTQCfTkoK+64mLSkK2ug5e3pAVGH
         0s7fQ+K8KDNAkr26g9uZGhn/aGpabVhx0cWvEIodSRl3i3mwncGfxFfMMmckhcf0A+zr
         U2RDyisPHgDoC5cXwFg6owVPJuIpwEAfemTyBZRHVX2WAkbiatY6zhtQK43ZLIKc2DTe
         vka0cfR/iJ85uH+qErPErO0C748NL5evldk9RC30DExrtJj27nzRX4SZcrBL5rRiqsWF
         DxJQ==
X-Forwarded-Encrypted: i=1; AL+hErF00VPU5dbQtUqE/ELCSWa8Mmm1Slu3DiuMeXlGylRZO8cLmjCPzv/rU1grxUa2sP/wUase765DQek=@vger.kernel.org
X-Gm-Message-State: APuU4Z9YRpdQoYMlwzoKeMpgD6/hoKNa5h1oHXbiHRohWtw5kuCsTBIB
	uXzmegEXjyiOOnJ0gH1XbbQQXY6W+1/t0XEswbsrSI8/9RZ6Nzn9EE07
X-Gm-Gg: AZFdTZcCA1OPcQPc3rR8Mb+sspbpJ8b+WWBEmwpuGSg/YzIKeaEGdF17hpqEpX9f/6U
	sOTfl69gVJmnX6ka3KDIjSAdfUE7ZfQEFCBeOyR+TZBS2CALbBrZWyH5b7udF7how9FcLvuylDD
	lz9jvYhQOO061S80heTrTAqqF8KOHYaWXCBmWTFgt0QrpGXCHj5cFTg6YFWfxFuCBui/aMbU0Mq
	52C5t4kmC/japu1KMfk1QD+hxemPxuSBgA6e8kT06NctyFn9jDi+4lHiU5HGIvSZJ6BxGQMj232
	f5kerEZHZORvIxV3FWqxc4oOOnotsHS0HRHWqm6XF2Em79HMi4TdDyQkR5QO5ffkfMqgTYlFO2J
	pNUUPO0GztTgES4JbW+rFVd3mSeJHuLwTygVnyRdglLsqe1vLuuvSavE7ZMqOyFwcLVdEu1V1qv
	j0p1oPl0pmT7SLSQB+C6EoIWTxrXvq9JU33ngHSaxxWwhf2VEMCLXNmHQDEs0zbCG5FclSPGnyt
	p1rabAFu9UPC0vvH7cwLIOEtL75PHNmeIEOyj+d6cLJseJljmixN/Zp/g93jXf0IN1KfY4x69tC
	8WPiRKbQQVo4Tj6Q+EZ1+GgARzaxXG375X418YgY/cYP4lQOp/zTDVcvmC1ZzZ6C4MAFAglovUJ
	Tb+HjUOtYxA==
X-Received: by 2002:aa7:d402:0:b0:6a9:8863:ada4 with SMTP id 4fb4d7f45d1cf-6ba1fae103fmr6832292a12.3.1795446460920;
        Mon, 23 Nov 2026 07:07:40 -0800 (PST)
Received: from xeon ([188.163.112.54])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6ba370fc020sm5446279a12.25.2026.11.23.07.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 07:07:39 -0800 (PST)
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
Subject: [PATCH v3 2/4] mfd: max8907: Add ADC client support
Date: Mon, 23 Nov 2026 17:07:23 +0200
Message-ID: <20261123150725.212836-3-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123150725.212836-1-clamor95@gmail.com>
References: <20261123150725.212836-1-clamor95@gmail.com>
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

Reviewed-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/max8907.c       | 74 +++++++++++++++++++++++++++++++++++++
 include/linux/mfd/max8907.h | 53 ++++++++++++++++++++++++++
 2 files changed, 127 insertions(+)

diff --git a/drivers/mfd/max8907.c b/drivers/mfd/max8907.c
index b511c57026188..103294c76b97d 100644
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
@@ -227,6 +283,18 @@ static int max8907_i2c_probe(struct i2c_client *i2c)
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
@@ -245,6 +313,12 @@ static int max8907_i2c_probe(struct i2c_client *i2c)
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

