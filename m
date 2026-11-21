Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=220.197.31.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795249531;
	b=rGzeV2MfpsKVzNuvdVMuWtLuiMW2XGnPamTE1e81KyJ+ZqVRE/Mjhd2k6I2L7J6nd80u
	 v2DAzvDC/rY+RqVeKEtwuQzg1IAxWEXmZfBYgSNTgkcubrfu8MPY/s8dsl8S/ckmdO051
	 77Fxe8x3bi4U8ldEB1lhlJEzm4fRapjUcidrM9xKGKO2EEOb1++55WFs0sKEIT6sIqM0a
	 TC/7WGXeo82uA5x25hgSxouQ4lTYYWuMg2/omA5gKLGhWgF+e34MOFtDxTipbWx4t+VD2
	 ROlbcPyUABIezYXqR45BqR6jzdHh05OxhxCFt0bw6EIGXeOdxNrJW3wfoYX1J4hd1pw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795249531;
	h=DMARC-Filter:DKIM-Signature:Received:From:To:Cc:Subject:Date:
	 Message-Id:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-CM-TRANSID:X-Coremail-Antispam:X-Originating-IP:X-CM-SenderInfo;
	bh=rr3Unccu+FX2HHtyfCXRHBz0t6xCYR+ulMFhFa9D/ik=;
	b=tZ7/2f5YFSUkeUm+RWDTmg+osy3sLRcWvEjzAIjvZE1kAOM/MlF24U+rHbvVzDm7Ollh
	 6EYXnvTs2bywsUL4ZnWSE3u5AEThS5NigpPVJReFKVLEB8ez/NcOgdJXmkjb1qiAzX2Lh
	 PdzBhGdq68k9CJcc9MUhcWyolOf7gZfGHBy1zHepGHKzOqqGrymma0oa0U+1MVhRy4XJK
	 QYmhgJsUWOGbNoP+26VacSmLbeKLg9bUvwng2xvr31hvzR+jXW4iKAmyZ4qasLW+rZ2Ag
	 C/ZgV7N71L+QyP3opjBUuIq2ikFL3z8PVH8FJE8z/aDNtS0z/NM+z5JSPlFL4sClsPQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=163.com;
	spf=pass smtp.mailfrom=163.com;
	dkim=pass header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iTjJblH3;
	arc=none smtp.remote-ip=220.197.31.5
Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383F606A320
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 08:25:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9383F606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=163.com header.i=@163.com header.a=rsa-sha256 header.s=s110527 header.b=iTjJblH3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version; bh=rr
	3Unccu+FX2HHtyfCXRHBz0t6xCYR+ulMFhFa9D/ik=; b=iTjJblH35x48an8DNT
	oUTTZ8/78y6hhUqcmH1Tx5RwJ2Zw7GlaTeQXl+Nk+9cv6kTz6yvS7t9vMoaooplw
	aoG6VRTfnDNjay/N1KPfeapu1WW/JVwpWQ8MfjkzN5/LZRCIg+Y6PQ9aWieEkaUN
	9GZScADTh/Hc1EjfOYIYKqyUY=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3X8hVVQFrzAG0JA--.43285S2;
	Sat, 21 Nov 2026 16:24:55 +0800 (CST)
From: Wanhui Fu <fuwh1120@163.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	dakr@kernel.org,
	kees+treewide@kernel.org,
	giorgitchankvetadze1997@gmail.com,
	u.kleine-koenig@baylibre.com
Cc: linux-iio@vger.kernel.org,
	Wanhui Fu <fuwh1120@163.com>
Subject: [PATCH] iio: twl6030-gpadc: Add error handling path in twl6030_gpadc_probe()
Date: Sat, 21 Nov 2026 16:24:19 +0800
Message-Id: <20261121082419.376423-1-fuwh1120@163.com>
X-Mailer: git-send-email 2.25.1
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
X-CM-TRANSID:_____wD3X8hVVQFrzAG0JA--.43285S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxJF15ZrWrury8GrW8ZF4UCFg_yoW8CF4kpF
	ZrJF90krWjgw4S9F1xJF1DuFn8Crs7t34Iqay7G34S9ayYyrn5Wr1rtF10qF48GFWrGw43
	J3y3ZFW8CF4xZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07UnYFAUUUUU=
X-CM-SenderInfo: xixzxiqrsqqiywtou0bp/xtbC7heFJWsBVVfUlQAA3w

Add an error handling path to call twl6030_gpadc_disable_irq(),
as twl6030_gpadc_remove() does.

Signed-off-by: Wanhui Fu <fuwh1120@163.com>
---
 drivers/iio/adc/twl6030-gpadc.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/twl6030-gpadc.c b/drivers/iio/adc/twl6030-gpadc.c
index e7fd371b3404..8dae7561320f 100644
--- a/drivers/iio/adc/twl6030-gpadc.c
+++ b/drivers/iio/adc/twl6030-gpadc.c
@@ -931,19 +931,19 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 					TWL6030_REG_TOGGLE1);
 	if (ret < 0) {
 		dev_err(dev, "failed to enable GPADC module\n");
-		return ret;
+		goto err_disable;
 	}
 
 	ret = twl_i2c_write_u8(TWL_MODULE_USB, VBUS_MEAS, USB_VBUS_CTRL_SET);
 	if (ret < 0) {
 		dev_err(dev, "failed to wire up inputs\n");
-		return ret;
+		goto err_disable;
 	}
 
 	ret = twl_i2c_write_u8(TWL_MODULE_USB, ID_MEAS, USB_ID_CTRL_SET);
 	if (ret < 0) {
 		dev_err(dev, "failed to wire up inputs\n");
-		return ret;
+		goto err_disable;
 	}
 
 	ret = twl_i2c_write_u8(TWL6030_MODULE_ID0,
@@ -951,7 +951,7 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 				TWL6030_MISC1);
 	if (ret < 0) {
 		dev_err(dev, "failed to wire up inputs\n");
-		return ret;
+		goto err_disable;
 	}
 
 	indio_dev->name = DRIVER_NAME;
@@ -960,7 +960,17 @@ static int twl6030_gpadc_probe(struct platform_device *pdev)
 	indio_dev->channels = pdata->iio_channels;
 	indio_dev->num_channels = pdata->nchannels;
 
-	return iio_device_register(indio_dev);
+	ret = iio_device_register(indio_dev);
+	if (ret < 0) {
+		dev_err(dev, "failed to register iio device\n");
+		goto err_disable;
+	}
+
+	return 0;
+
+err_disable:
+	twl6030_gpadc_disable_irq(TWL6030_GPADC_RT_SW1_EOC_MASK);
+	return ret;
 }
 
 static void twl6030_gpadc_remove(struct platform_device *pdev)
-- 
2.25.1

