Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794325383;
	b=ygdUhCzZm5TFy42tWKwNOU8etZDRNIfEPAsBuEhZ0BvDeJtZcKq45BOCDdYF5QQzch03
	 DvllVjjxv8f3NZJ3ZmfrO/boBCUXsf7qp39/DSs3XfsbjS+mvuBHLxIYArzRdxgb71MlB
	 VLOpm6s/ablhVI4vSqY02PlFIrwtk16OxRxy0WRPW+3vBY928kbjnUR8DC8UctjyTy3cb
	 wcl3p/tasLFUWQsTSgITWC1owbhVOjbEHvtDNlrj0C/jr7FQS52tYEyyTqc84gWsieGIy
	 LvcbuZBZuCeS48Xyc5edrY2NO4Fc4BiUWpCdJ9jQbtnfAaqNXcsQgfQMljIfO2ytyjA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794325383;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=lXiFw4Dd7FvHs44ojLdvo5R3mFdiF36N0TFZ4+8H/44=;
	b=GB03SXS/IVR/7mjr/Dtoz1eejcpc4oSnpyd6QG/R7cThYBXYb7Mk9ecU7qDj1tz3cONb
	 QhgU4tfJ3Y+xiqdsyUohWps0CstefvbuqccmaJBiB9jnK4k+WqkEIROZE8/hG2z5Kb709
	 dSJ3WuaUyiRQGnZozuv3ujA6dxlBMVRL6b//gVIGRnOqwsyTxWvaf3Uv13w80g3jjBkDF
	 EcnH8EoQwmvixLdvDKfSiEceut39HfyAQ8C8oManZJRUBsPdu36RDpAND6ZnRl5DL3Poy
	 uksHvRh3Ybhd3rrr7ZB2VjdlaZMuIpr4O/i7pncLLgzp65yOkna7yqe7r8Xv2EzXstg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2QuhtcD;
	arc=none smtp.remote-ip=209.85.208.173
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFF5606D768
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 15:43:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0BFF5606D768
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=a2QuhtcD
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-3ae0a5c1715so7279671fa.1
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 07:43:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794325380; x=1794930180; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lXiFw4Dd7FvHs44ojLdvo5R3mFdiF36N0TFZ4+8H/44=;
        b=a2QuhtcD9NiI+APBI/3N5YHnMvnOOrpIrsL6je8N2XoT0m0FKjNMV820GI7bijoRmc
         AQA7HLoxpArYDNh73ojFE6zMnZdFiG3W7BgjhIsm3FRV1xSimg4ApDajKNK62U53VgUd
         B3arRBndGdPE/jS6QrENVrshLO1eXSy9+akDRPeCo0q4tggfj3AqPBOphavascuD6zfP
         sQSJpNLp70cnQuuL+GOVAjM4JOdO+b/KlnZjGLaFhWcQD1FOLku6WBaWhkTZEj+Oftua
         aBnpVtTeSh9eRzP84UBqna8iacPOjOZWArTgHfRf4+AtLTWgklZuZBwLZmhlxONaTbRV
         IYKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794325380; x=1794930180;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=lXiFw4Dd7FvHs44ojLdvo5R3mFdiF36N0TFZ4+8H/44=;
        b=DLa3fYo/TZ9VtoprSLoy4My60050HnHpNhrFvDz0/bq0VF3dYMaDOLPtsFOW1JpK/W
         iZdkfJ3J+epT07XFLYSoggg2CeqOGHclVi+ZXkeed6TFsiwzADIetRm4GHUAZMAUY7GZ
         VDrJ4cv3LIXPMQ+8PSr/ImJcLc9cUKEhJ/EJIocERWo9I4KYn2Fvz7DqpTkM3facoyG9
         zg6NALCDIgrgTXV1/xopE39mv2L/e1wN8uEM/RbSLiWMcRvZoHfcV5EniCNkmJKiQtJ5
         8GNCNOKmxWa089DTo71yHFi4nvzKlUtBC7s0sXSTJfLjWbSZZKJ+B8BQefMgu8e2dmTi
         +0iw==
X-Forwarded-Encrypted: i=1; AL+hErGHLIUsj7R4NnsHO6QeD1x0dLnoPB5oKKDB0+xlvk/duiMm01+MR/gHKpk28QrKVEotEdD53aYVnJY=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bOsqWVMd44GR4hRDYInfq/F1irvDOWfq3z7e/YJEa34Vw2se/
	zeqlRy6p8J7SzYJbDIa+9qOZhRi0MnkImIDDtCsKx9hn3zEwYfzyts8d
X-Gm-Gg: AYBFou1at79lFnZRbuNoC02TCEHIrNnQgdg2rrXVni0yBiyqLOi8btAFUbbAdfkvSUU
	P1KPWVXlgp3w1a1b7nPSBJJ6wOf/bPpSwjX5ebzDHDgQV7HdAmsUdkkhSdGKP8cy0bU3OfrrsOb
	YxRcTLR7s+RLnm3BfRpXfgdbjm7fpP91XktcO9HyYKUce9m/5sbanioe5kIe76V0vynz+JL+3jX
	lje61yJi1NgHuNrZvj6Z+FlmHOuIZKtREa9m5HRGUafxTcFCslVS1KvO1mjDTlnkrO3bk029kFc
	KBEi12aZ7DX8EsaemNGO2ommVyPduWwqcnMCZUePm3QymhkpZsD3Cy9T2KtZaMqZdRAVNPmGfZV
	VB0ueeloSs1fxwuNWYxexEOZDr9LCE5KV2QhRrLsTghEoMSXrERU71AiBq0YpMH2B3Qgt8ZZTkR
	oj1X3ByEIZ2Lis2TMmKanVBhCwLCnaOlVgxH9X9DtDUJ72cKqp/nEPe1detqRdtlzjCcceTn/tL
	JZWRWgbQ11Ka2MakJ0O1Unis+f9Y7NuHulS7t8FtQFLyBugg+y5sU0QK1IwW7PsnKUn4ne6H0Tl
	hC2ycIOw0Xr/YmselLsZggPXs5rzV1LGrXNUiSdtuUerH/ebwXLvosdUfDZDBpA9Q8W9KTs5xjQ
	6jfcn4dOgTgimJrlF1VNZb7gA+ypA1WsRJMCrJNg=
X-Received: by 2002:a05:651c:1615:b0:3ac:e00f:6bef with SMTP id 38308e7fff4ca-3ae109af6d7mr1681fa.6.1794325380084;
        Tue, 10 Nov 2026 07:43:00 -0800 (PST)
Received: from yantra.. (nekmmqt3kfwnocz4ivv-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:453b:19fe:80e1:2b9b])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae0923d583sm5751481fa.21.2026.11.10.07.42.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 07:42:59 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH 2/2] iio: pressure: dps310: add a data-ready trigger
Date: Tue, 10 Nov 2026 17:42:54 +0200
Message-ID: <20261110154254.39092-3-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261110154254.39092-1-zoone.rupert@gmail.com>
References: <20261110154254.39092-1-zoone.rupert@gmail.com>
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

With an interrupt wired to SDO, the chip can signal each new pressure
result. Expose it as a trigger, so captures follow the measurements and
scans carry the time the result was ready, not when the handler ran.

Polarity follows the interrupt type. Status latches while the interrupt
is disabled, so it is cleared before enabling. The trigger is not the
default, so FIFO mode without a trigger is unchanged.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

 drivers/iio/pressure/dps310.c | 129 ++++++++++++++++++++++++++++++++--
 1 file changed, 125 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 5cee23986f30..76738360e528 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -17,6 +17,8 @@
 #include <linux/cleanup.h>
 #include <linux/devm-helpers.h>
 #include <linux/i2c.h>
+#include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
@@ -31,6 +33,7 @@
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+#include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
 
@@ -62,10 +65,13 @@
 #define  DPS310_COEF_RDY	BIT(7)
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
+#define  DPS310_INT_PRS		BIT(4)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
 #define  DPS310_PRS_SHIFT_EN	BIT(2)
 #define  DPS310_FIFO_EN		BIT(1)
 #define  DPS310_SPI_EN		BIT(0)
+#define DPS310_INT_STS		0x0a
+#define  DPS310_INT_STS_PRS	BIT(0)
 #define DPS310_RESET		0x0c
 #define  DPS310_FIFO_FLUSH	BIT(7)
 #define  DPS310_RESET_MAGIC	0x09
@@ -144,6 +150,9 @@ struct dps310_data {
 	bool timeout_recovery_failed;
 	bool fifo_temp_valid;
 
+	struct iio_trigger *trig;
+	s64 irq_timestamp;
+
 	/* Used only while the FIFO is enabled */
 	struct iio_dev *iio;
 	struct delayed_work fifo_work;
@@ -706,6 +715,7 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
 	case DPS310_TMP_B1:
 	case DPS310_TMP_B2:
 	case DPS310_MEAS_CFG:
+	case DPS310_INT_STS:
 	case 0x32:	/* No documentation available on this register */
 		return true;
 	default:
@@ -713,6 +723,12 @@ static bool dps310_is_volatile_reg(struct device *dev, unsigned int reg)
 	}
 }
 
+/* Cleared on read */
+static bool dps310_is_precious_reg(struct device *dev, unsigned int reg)
+{
+	return reg == DPS310_INT_STS;
+}
+
 static int dps310_write_raw(struct iio_dev *iio,
 			    struct iio_chan_spec const *chan, int val,
 			    int val2, long mask)
@@ -1048,7 +1064,7 @@ static int dps310_fifo_set_enable(struct dps310_data *data, bool enable)
 				  enable);
 }
 
-/* No interrupt pin is wired in tree, so drain on a timer */
+/* The FIFO only interrupts when full and then stops, so drain on a timer */
 static unsigned int dps310_fifo_interval(struct dps310_data *data,
 					 int prs_rate, int tmp_rate)
 {
@@ -1375,6 +1391,7 @@ static irqreturn_t dps310_trigger_handler(int irq, void *p)
 		s32 channels[2];
 		aligned_s64 timestamp;
 	} scan = { };
+	s64 timestamp;
 	int rc;
 
 	mutex_lock(&data->lock);
@@ -1383,7 +1400,12 @@ static irqreturn_t dps310_trigger_handler(int irq, void *p)
 	if (rc)
 		goto err;
 
-	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), iio_get_time_ns(iio));
+	if (iio_trigger_using_own(iio))
+		timestamp = data->irq_timestamp;
+	else
+		timestamp = iio_get_time_ns(iio);
+
+	iio_push_to_buffers_with_ts(iio, &scan, sizeof(scan), timestamp);
 
 err:
 	iio_trigger_notify_done(iio->trig);
@@ -1391,6 +1413,97 @@ static irqreturn_t dps310_trigger_handler(int irq, void *p)
 	return IRQ_HANDLED;
 }
 
+static irqreturn_t dps310_irq_handler(int irq, void *private)
+{
+	struct dps310_data *data = private;
+
+	data->irq_timestamp = iio_get_time_ns(data->iio);
+
+	return IRQ_WAKE_THREAD;
+}
+
+static irqreturn_t dps310_irq_thread(int irq, void *private)
+{
+	struct dps310_data *data = private;
+	unsigned int status;
+
+	if (regmap_read(data->regmap, DPS310_INT_STS, &status))
+		return IRQ_NONE;
+
+	if (!(status & DPS310_INT_STS_PRS))
+		return IRQ_NONE;
+
+	iio_trigger_poll_nested(data->trig);
+
+	return IRQ_HANDLED;
+}
+
+static int dps310_trigger_set_state(struct iio_trigger *trig, bool state)
+{
+	struct dps310_data *data = iio_trigger_get_drvdata(trig);
+	unsigned int status;
+	int rc;
+
+	guard(mutex)(&data->lock);
+
+	/* Status latched while disabled would fire a stale interrupt */
+	if (state) {
+		rc = regmap_read(data->regmap, DPS310_INT_STS, &status);
+		if (rc)
+			return rc;
+	}
+
+	return regmap_assign_bits(data->regmap, DPS310_CFG_REG, DPS310_INT_PRS,
+				  state);
+}
+
+static const struct iio_trigger_ops dps310_trigger_ops = {
+	.set_trigger_state = dps310_trigger_set_state,
+};
+
+static int dps310_trigger_probe(struct dps310_data *data)
+{
+	struct device *dev = &data->client->dev;
+	struct iio_dev *iio = data->iio;
+	int irq = data->client->irq;
+	bool active_high;
+	int rc;
+
+	switch (irq_get_trigger_type(irq)) {
+	case IRQ_TYPE_LEVEL_HIGH:
+	case IRQ_TYPE_EDGE_RISING:
+		active_high = true;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+	case IRQ_TYPE_EDGE_FALLING:
+		active_high = false;
+		break;
+	default:
+		return dev_err_probe(dev, -EINVAL, "Unsupported interrupt type\n");
+	}
+
+	rc = regmap_assign_bits(data->regmap, DPS310_CFG_REG, DPS310_INT_HL,
+				active_high);
+	if (rc)
+		return rc;
+
+	data->trig = devm_iio_trigger_alloc(dev, "%s-dev%d", iio->name,
+					    iio_device_id(iio));
+	if (!data->trig)
+		return -ENOMEM;
+
+	data->trig->ops = &dps310_trigger_ops;
+	iio_trigger_set_drvdata(data->trig, data);
+
+	rc = devm_request_threaded_irq(dev, irq, dps310_irq_handler,
+				       dps310_irq_thread, IRQF_ONESHOT,
+				       iio->name, data);
+	if (rc)
+		return rc;
+
+	return devm_iio_trigger_register(dev, data->trig);
+}
+
 static void dps310_standby(void *action_data)
 {
 	struct dps310_data *data = action_data;
@@ -1404,6 +1517,7 @@ static const struct regmap_config dps310_regmap_config = {
 	.val_bits = 8,
 	.writeable_reg = dps310_is_writeable_reg,
 	.volatile_reg = dps310_is_volatile_reg,
+	.precious_reg = dps310_is_precious_reg,
 	.cache_type = REGCACHE_RBTREE,
 	.max_register = 0x62, /* No documentation available on this register */
 };
@@ -1470,8 +1584,9 @@ static int dps310_probe(struct i2c_client *client)
 	/*
 	 * The device measures continuously in background mode, so a triggered
 	 * capture is just a read of the latest results. The setup ops run the
-	 * FIFO drain when no trigger is attached. The trigger is not aligned
-	 * with the measurements, so the timestamp is taken in the handler.
+	 * FIFO drain when no trigger is attached. Only the data-ready trigger
+	 * is aligned with the measurements, so for others the timestamp is
+	 * taken in the handler.
 	 */
 	rc = devm_iio_triggered_buffer_setup(dev, iio, NULL,
 					     dps310_trigger_handler,
@@ -1484,6 +1599,12 @@ static int dps310_probe(struct i2c_client *client)
 	if (rc)
 		return rc;
 
+	if (client->irq > 0) {
+		rc = dps310_trigger_probe(data);
+		if (rc)
+			return rc;
+	}
+
 	rc = devm_iio_device_register(dev, iio);
 	if (rc)
 		return rc;
-- 
2.43.0

