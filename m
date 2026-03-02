Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6817E30E835
	for <linux-iio@vger.kernel.org>; Mon,  2 Mar 2026 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772429178; cv=none; b=Kwo6/GIvKUkmIqv/Q9UO1JshugNmrDxmgBbY0wyOaZfZEAQpWU3TlHPPJFrzF2REHulKzDG9MClmmgUT/q1T9ikCjJErN/s2DXqdSHWQm08/GZyQtsBe/XxcxxpLtB5wJ6Ge/f5ac1/cFNUeIpEn6Nhm1m86H8PSO5e9jRMz2lc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772429178; c=relaxed/simple;
	bh=BShzcGQ5TSxPcPyjbcHQImaTpsxpGLqHCWEyrwfxpgM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P6jPnQF4ZFP6AxM2xE83DBJrcDoFRx31SU+fNa699CIlnmAcrJ09cflZgMoxTeVMKZ3ftYpkUjZUXUNUjE2RtB2+84pPzm7WPb16DluZD0AHkDwNdjPTUZn7k2Jup7kj2SdjipIx1BL83VK4GMHPODzLfBS+c+DrlqSUHUyBnrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cd7S0uwJ; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cd7S0uwJ"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso18377205ad.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Mar 2026 21:26:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772429177; x=1773033977; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7DjFw8npH/saWUp4S7FK0mRYY41Jcjm78Vwid4RX8Dg=;
        b=Cd7S0uwJ51cPqwfMGuJVVFOZ2VJwljY7WcuO2xhQPmc8cjR7eg4cFtYnoid/EdXCK8
         jpWDdfp2aFvClifu94XBu1j5NPBFKc2VFFEHdjFSxflwAfT8XafXfp6xnI2gxYfw+87g
         VjHmV+f95vEhSIgYvT8AtwlKhjL8L7LzsEyLjPTIh2Xlho1aZjtWdZfdCZ3r2SmjDr0c
         ZgGU3QcZsv3RBk8BTssWIyexVdgdzaytGne5ebiW9ELE1tZiMObZvc9SaD31nvEMd6cP
         NYj5Gn3nHescv9dL02T/D9NdRGRz2xr17eYRsVNRlTYlCOqHRI3QAwUx7srKE6Qz6h5a
         m+MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772429177; x=1773033977;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7DjFw8npH/saWUp4S7FK0mRYY41Jcjm78Vwid4RX8Dg=;
        b=LZ7AvWu59iuPGKh5i9ymrGgKGT+3Jm1aZVmeYGWeM8FVJLrFeCIxQbzi3bRVJnAD9V
         g6bwuLolKg5USJVSThNfWay6LlE3Re1Zkg6R0ZpOc0RQVBH+TZkWUGmqHeC+XY3MzvS8
         AqxPayFE4zKKUcv49qFLVu5ovayScw4YitTtc7Nitlnfm8PJrbHZWV3TendvJ06oRRLC
         y7rhbC4WSRbVoLc/9KnwHRzAxWTVgYy7cIAmWAZSMSpvzIBqwwmZt55UXXEUMSqtgllD
         tkoFFUXfGcmo75uxPJ/GW8dzTUfeX03FjMIlSB4qFgUqCDSptpr0qLD6sOg48LsAicsx
         N9sw==
X-Forwarded-Encrypted: i=1; AJvYcCXxsThMOa5B1jhMSGgysfAc31TSsAMnPSASZyhAF1SZBis0+n6bFW2S5PIwxnZecdU7fKyxEo9Jz+g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhpeVY4HhtKF8zWubEpV6Py9HV483KAvlF3+7/ffjta+cUVjWF
	vqqox2De16HXVaLyGJEMWH6/Zih/qAmiDKFzb88gRRgCOdGG8321RU9t
X-Gm-Gg: ATEYQzzCzwXwA/gj1rU7T+qZPK/FUFz6evgne+qOu6v704KaFktgVJAgFEZmQWgxlPT
	lXSpqJetv34FYcqRbXBnJ1WpzGgZAoj+ReStwuDwdVewUYxZewU2cBERK5ohMo5gEOfuxOowkv1
	0PnLS0C8AsFeavs7TIdHsS2gOz0533gTi/gLlsiTuCeN4Cl5la5WRgrXcSBXvInlJQntVN33UNI
	E5QffMmjARNB0A9CiHs1bSoKPrWc0NbyDttNi0ed7x7HUW9CLkJmqoThu6GvWtECWcUtdmO0IMf
	yFn13Mage7+LT/bgy84Mm/UeFKi3hqeW7ouEbntsp66xYK5wlmQ2zh6QqXXaUlGOyusIbTsE3Oh
	vFN8UwoXOt+mPfw177MsCer/Ozi3U1gzeDve74lao8eyEPEyHnPyxm0t9AX2YXbaGilRpnfuMsu
	HA1+kOn4iA63xhm5h0hDxlXcUh3yBVur42XfXQO8ze3g==
X-Received: by 2002:a17:903:1250:b0:2a7:cb46:706e with SMTP id d9443c01a7336-2ae2e47e0b7mr107067965ad.35.1772429176483;
        Sun, 01 Mar 2026 21:26:16 -0800 (PST)
Received: from debian.ari ([152.58.177.124])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae4f945985sm24692575ad.71.2026.03.01.21.26.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2026 21:26:16 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2] iio: adc: ad799x: convert to fully managed resources
Date: Mon,  2 Mar 2026 10:55:59 +0530
Message-Id: <20260302052559.19494-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Refactor the driver to use device-managed allocations and actions,
allowing for the complete removal of the ad799x_remove() function
and simplifying the error paths in probe().

Key changes:
- Replace the dynamic rx_buf allocation with a fixed-size, DMA-safe
  buffer using IIO_DECLARE_DMA_BUFFER_WITH_TS() in the state struct.
  This avoids memory leaks during scan mode updates and removes the
  need for manual kfree().
- Cache the VCC and VREF voltages in the state structure during probe()
  to avoid querying the regulator API during fast-path read_raw() calls.
- Use devm_add_action_or_reset() to register regulator_disable()
  callbacks for both VCC and VREF regulators.
- Convert iio_triggered_buffer_setup() and iio_device_register() to
  their devm_ variants, ensuring safe, reverse-order unwinding.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
Changes in v2:
- Refactored entire resource management to eliminate remove() function
  based on feedback from David Lechner and Jonathan Cameron.
- Cached voltages to prevent mixing manual regulator disables with
  devm-managed device unregistration.

 drivers/iio/adc/ad799x.c | 83 +++++++++++++++++++---------------------
 1 file changed, 40 insertions(+), 43 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..4a3db6f0a8d8 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -39,6 +39,7 @@
 #include <linux/iio/triggered_buffer.h>
 
 #define AD799X_CHANNEL_SHIFT			4
+#define AD799X_MAX_CHANNELS			8
 
 /*
  * AD7991, AD7995 and AD7999 defines
@@ -133,8 +134,12 @@ struct ad799x_state {
 	unsigned int			id;
 	u16				config;
 
-	u8				*rx_buf;
 	unsigned int			transfer_size;
+
+	int				vcc_uv;
+	int				vref_uv;
+
+	IIO_DECLARE_DMA_BUFFER_WITH_TS(__be16, rx_buf, AD799X_MAX_CHANNELS);
 };
 
 static int ad799x_write_config(struct ad799x_state *st, u16 val)
@@ -217,11 +222,11 @@ static irqreturn_t ad799x_trigger_handler(int irq, void *p)
 	}
 
 	b_sent = i2c_smbus_read_i2c_block_data(st->client,
-			cmd, st->transfer_size, st->rx_buf);
+			cmd, st->transfer_size, (u8 *)st->rx_buf);
 	if (b_sent < 0)
 		goto out;
 
-	iio_push_to_buffers_with_timestamp(indio_dev, st->rx_buf,
+	iio_push_to_buffers_with_timestamp(indio_dev, &st->rx_buf,
 			iio_get_time_ns(indio_dev));
 out:
 	iio_trigger_notify_done(indio_dev->trig);
@@ -234,11 +239,6 @@ static int ad799x_update_scan_mode(struct iio_dev *indio_dev,
 {
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	kfree(st->rx_buf);
-	st->rx_buf = kmalloc(indio_dev->scan_bytes, GFP_KERNEL);
-	if (!st->rx_buf)
-		return -ENOMEM;
-
 	st->transfer_size = bitmap_weight(scan_mask,
 					  iio_get_masklength(indio_dev)) * 2;
 
@@ -307,9 +307,9 @@ static int ad799x_read_raw(struct iio_dev *indio_dev,
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
 		if (st->vref)
-			ret = regulator_get_voltage(st->vref);
+			ret = st->vref_uv;
 		else
-			ret = regulator_get_voltage(st->reg);
+			ret = st->vcc_uv;
 
 		if (ret < 0)
 			return ret;
@@ -781,6 +781,13 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 };
 
+static void ad799x_reg_disable(void *data)
+{
+	struct regulator *reg = data;
+
+	regulator_disable(reg);
+}
+
 static int ad799x_probe(struct i2c_client *client)
 {
 	const struct i2c_device_id *id = i2c_client_get_device_id(client);
@@ -813,6 +820,14 @@ static int ad799x_probe(struct i2c_client *client)
 	ret = regulator_enable(st->reg);
 	if (ret)
 		return ret;
+	ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
+	ret = regulator_get_voltage(st->reg);
+	if (ret < 0)
+		return ret;
+	st->vcc_uv = ret;
 
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
@@ -820,7 +835,7 @@ static int ad799x_probe(struct i2c_client *client)
 		ret = PTR_ERR_OR_ZERO(st->vref);
 		if (ret) {
 			if (ret != -ENODEV)
-				goto error_disable_reg;
+				return ret;
 			st->vref = NULL;
 			dev_info(&client->dev, "Using VCC reference voltage\n");
 		}
@@ -830,7 +845,14 @@ static int ad799x_probe(struct i2c_client *client)
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
-				goto error_disable_reg;
+				return ret;
+			ret = devm_add_action_or_reset(&client->dev, ad799x_reg_disable, st->vref);
+			if (ret)
+				return ret;
+			ret = regulator_get_voltage(st->vref);
+			if (ret < 0)
+				return ret;
+			st->vref_uv = ret;
 		}
 	}
 
@@ -845,12 +867,12 @@ static int ad799x_probe(struct i2c_client *client)
 
 	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(&client->dev,
@@ -862,40 +884,16 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			return ret;
 	}
 
 	mutex_init(&st->lock);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
-		goto error_cleanup_ring;
+		return ret;
 
 	return 0;
-
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
-error_disable_vref:
-	if (st->vref)
-		regulator_disable(st->vref);
-error_disable_reg:
-	regulator_disable(st->reg);
-
-	return ret;
-}
-
-static void ad799x_remove(struct i2c_client *client)
-{
-	struct iio_dev *indio_dev = i2c_get_clientdata(client);
-	struct ad799x_state *st = iio_priv(indio_dev);
-
-	iio_device_unregister(indio_dev);
-
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
-	kfree(st->rx_buf);
 }
 
 static int ad799x_suspend(struct device *dev)
@@ -965,7 +963,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

