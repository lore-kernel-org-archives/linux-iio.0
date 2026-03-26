Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2FA439B95F
	for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774548365; cv=none; b=acpnQSvyOAiUpmU4izBmfTzmiD2NY6PwwnGMP0wU4GRnH9OMeCgusT20Gn8ZA2Krd/lcdeE/SupQ3kehcDXBDmHQrB6wRIropJammPpx6Eyp+K4D4DfwuM+ue1AKNE/7wgKDklXNrdFjHY3/6wD2vFxGmXBCHxo0ieGrdNn4f5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774548365; c=relaxed/simple;
	bh=/819GhgVQ0f1i/VhmZvxWpH70/XmEbCIvtzBQyZG8Uo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=aMkX3WIWNRH2j+6cuYY+NDoweyDCKKWj1bbaekAexhU1ULnj/Q4eFbXGlKAKFjRV/oiz40F9iMR2sNqZ1E92benneAAkbBIWqPAiUPpybaZOBvzWk2fHFCJAYj9/lBAvrdaHow5G9AxZQxO3qb1IRceZT46IVjeo/ElNVIgg4yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nnQGkdvY; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nnQGkdvY"
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-2aecc6b0861so8086615ad.2
        for <linux-iio@vger.kernel.org>; Thu, 26 Mar 2026 11:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774548358; x=1775153158; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3ATvkbzTX4jbWmEQzoe5/614PGWtMpERJNWTbS3U6No=;
        b=nnQGkdvYcdLKRMLJCES3aAEf1/94ExzPmhCyJV9ze+sjsKonA/NwgXnO6mZSU5oNN7
         mXOgrz7Oe/jKBdUK9LEJmXyeFys8Qar+lKE/BxyAIZOkVLThE/LOMo0Ot1YnLgL0Bfrg
         UF54Cvs/E8eJQSMvuJo8HTIzH17dz1cQvuOsUYoxbSZ5Ga05RUBQ4Ipnn80CfTUMohqx
         Iy8j9NUaDvkp7Yz3ZJjh0fx4RbnMRJADngwB4v/XulP4boq23hqoCQi4ITFu3N9JUOzV
         KdMSFU4oFDiI5uSWfJQMQpEwMPwnyeRDhuOpd5V3n8X7jt2gCYq74QYT4OkWGFJf/Cwv
         M/sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774548358; x=1775153158;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3ATvkbzTX4jbWmEQzoe5/614PGWtMpERJNWTbS3U6No=;
        b=EE/lQYUeM91bK2sjTcQZDwsF3kRGW0MeTR2TTDLiQ2pHjEV6Z2fDq8MzW9eIFPp3IB
         3+INq/7hEBJRBbwIr2zs0gGMnFgxmRG1Rm3WgTWATGSvGP4zZwG5xrKx37K2DTOwcYoq
         5A6lRF+LA4OY0x1Qp0B5SjZX5ZOm5rEZB9IR0ghRCFQ9AMWR4/5zu+8Jt+Q/EqgR+rrS
         EoQrnEkJsOCb9QjvRhol3VHp/Ph7psIFcGMX9dmal0xgjaAaRFMifJPOVHzIBioAsSlB
         z0ca+85isUxXKbzfBBL8MM6gArmQJV36bP9fHDnIFgopOLuVN2nuOz6Pm49D3QW+CvaL
         JxPA==
X-Forwarded-Encrypted: i=1; AJvYcCVhvkEqTFRkhtn3XXTrqaxx1LdL9Zr63TZmBy5Skniv9KsiZ24Siooldtk3NmnTE5OjwEZqhvxglZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywp+CTirUWROJpYQSOqbjIDlo/0PeqQCFtUhFgeJJXKMmL9wk15
	Id5DO5w0Kr345OcHi0xgy80TQRb6atSsZZ4/CF8Q/WGtr8FwV2itSeDu
X-Gm-Gg: ATEYQzzQF2r+A3ijr4YWU8w0FPbfmw50HoueS+cXl+5yBA3b8a++XT5+6t/2MBvO2NI
	7wWkMK+Wa7Tf/IH/X4nCYs6rWQq7No9CoClZ6T69vbrJ+0rOqr648L1JhSb4uz5ppudbZ3MTYcQ
	OI1LXKryccapMNp8RbBoWJYKz3sv6ZdiHSiTtK+Add8ByRGt4M7TWoV0LnGNCYmVqrV2JI+cy7A
	5rJD+zSvyl+oPaaUlknEv4AqTYNezSzLaZjJkUAHXwBkOhVQBGP9ocaLqqCBroFAzUuWinczC6C
	cU2K05OJEL41K/4Vdxmogv8QSpoS0fpKXU6naexhOJAbm6B7BGxrgSd99JBcpw03/hGDS7YXhGU
	TbPzXEycoXI/a4whB24l+zunARp1+Eyx4SBvQZRjzqs5y9ODdlY02kezx1/b7W1Zw5pG6tmleJp
	eGe5Xro20Rrm5xjvlOX+QC5txJNJIT3a39WmDmLJK0OHkXKn8cePRB6ggCDp95l7C/zujURTPqv
	x4=
X-Received: by 2002:a17:903:38cd:b0:2b0:7a50:886f with SMTP id d9443c01a7336-2b0b0b1dc00mr89275245ad.51.1774548357917;
        Thu, 26 Mar 2026 11:05:57 -0700 (PDT)
Received: from debian.ari ([47.30.237.79])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0bc7a17c5sm43823545ad.26.2026.03.26.11.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 11:05:57 -0700 (PDT)
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
Subject: [PATCH v6 4/4] iio: adc: ad799x: use devm_iio_device_register and drop remove()
Date: Thu, 26 Mar 2026 23:35:29 +0530
Message-Id: <20260326180529.19154-5-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260326180529.19154-1-architanant5@gmail.com>
References: <20260326180529.19154-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to use the device-managed versions of
iio_device_register(), iio_triggered_buffer_setup(), and mutex_init().

Use devm_add_action_or_reset() to ensure that the VCC and VREF
regulators are disabled safely and in the correct order during
driver teardown or probe failure.

Because all resources (buffer, regulators, IRQs, IIO device, mutex)
are now fully managed by the devm core, the unwinding order is
guaranteed to be correct (reverse order of allocation). We can now
safely remove all manual error handling goto labels in ad799x_probe()
and delete the ad799x_remove() function entirely.

This eliminates boilerplate code and prevents potential resource leaks.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 66 ++++++++++++++++------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 3cf7850357ab..c12bd7ed4dd7 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -774,6 +774,11 @@ static const struct ad799x_chip_info ad799x_chip_info_tbl[] = {
 	},
 };
 
+static void ad799x_reg_disable(void *reg)
+{
+	regulator_disable(reg);
+}
+
 static int ad799x_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
@@ -808,15 +813,19 @@ static int ad799x_probe(struct i2c_client *client)
 	if (ret)
 		return ret;
 
+	ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->reg);
+	if (ret)
+		return ret;
+
 	/* check if an external reference is supplied */
 	if (chip_info->has_vref) {
 		st->vref = devm_regulator_get_optional(dev, "vref");
 		ret = PTR_ERR_OR_ZERO(st->vref);
-		if (ret) {
-			if (ret != -ENODEV)
-				goto error_disable_reg;
+		if (ret == -ENODEV) {
 			st->vref = NULL;
 			dev_info(dev, "Using VCC reference voltage\n");
+		} else if (ret) {
+			return ret;
 		}
 
 		if (st->vref) {
@@ -824,10 +833,15 @@ static int ad799x_probe(struct i2c_client *client)
 			extra_config |= AD7991_REF_SEL;
 			ret = regulator_enable(st->vref);
 			if (ret)
-				goto error_disable_reg;
+				return ret;
+
+			ret = devm_add_action_or_reset(dev, ad799x_reg_disable, st->vref);
+			if (ret)
+				return ret;
+
 			ret = regulator_get_voltage(st->vref);
 			if (ret < 0)
-				goto error_disable_vref;
+				return ret;
 			st->vref_uV = ret;
 		}
 	}
@@ -835,7 +849,7 @@ static int ad799x_probe(struct i2c_client *client)
 	if (!st->vref) {
 		ret = regulator_get_voltage(st->reg);
 		if (ret < 0)
-			goto error_disable_reg;
+			return ret;
 		st->vref_uV = ret;
 	}
 
@@ -850,12 +864,12 @@ static int ad799x_probe(struct i2c_client *client)
 
 	ret = ad799x_update_config(st, st->chip_config->default_config | extra_config);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(dev, indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
-		goto error_disable_vref;
+		return ret;
 
 	if (client->irq > 0) {
 		ret = devm_request_threaded_irq(dev,
@@ -867,39 +881,14 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			return ret;
 	}
 
-	mutex_init(&st->lock);
-
-	ret = iio_device_register(indio_dev);
+	ret = devm_mutex_init(dev, &st->lock);
 	if (ret)
-		goto error_cleanup_ring;
-
-	return 0;
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
+		return ret;
 
-	iio_triggered_buffer_cleanup(indio_dev);
-	if (st->vref)
-		regulator_disable(st->vref);
-	regulator_disable(st->reg);
+	return devm_iio_device_register(dev, indio_dev);
 }
 
 static int ad799x_suspend(struct device *dev)
@@ -969,7 +958,6 @@ static struct i2c_driver ad799x_driver = {
 		.pm = pm_sleep_ptr(&ad799x_pm_ops),
 	},
 	.probe = ad799x_probe,
-	.remove = ad799x_remove,
 	.id_table = ad799x_id,
 };
 module_i2c_driver(ad799x_driver);
-- 
2.39.5

