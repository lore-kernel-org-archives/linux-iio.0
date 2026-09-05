Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AACA3D3D14
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601078; cv=none; b=E/EQCrDDPk/FDUv7sgSM1rgBr0IDm7TH9mOtMQ7AquT7Dp72cRU1zc6JFdKggbGeITPFME0AUpEJo26Hd98+E0co5NNlwwTEwUEoSZL+qu/qCvfR6wjg9qt20RBnbmq6dWs4pZ2esjYspHOBrXmVBI8UF5iNPRN2L5iUgbibsG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601078; c=relaxed/simple;
	bh=mZPq9LcmgwAvNURf/extfUGWqqJSNfRaX6LbCY+2TTM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=c5xTSb0i8Br06jPh9KyJQ9bNUL9U0DhhdHw22s0sVKRkCkF8UoDZXC5BJHZIk4IcQC7MWhOT+HMBLcIoIHSChl+TzjJqsMNjTgZ2xKSRHx0Ga1Dg0GZH8fqLxMlV1fIpBJekKCl9pVS/ccHpthlRtJ98VSD0e/UJzMwBhbFRWYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rNohPktb; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rNohPktb"
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-38dc4553f62so1929473a91.0
        for <linux-iio@vger.kernel.org>; Sat, 05 Sep 2026 02:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601073; x=1789205873; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cdCH0/RB1tBvaj1W6sXWObI//sTHWe8b2CDTC69fJ18=;
        b=rNohPktb0DxxJNtokoj+tdSF8Laf8JvPGaOjvofMq7Oy89G4iudPODk0Wm0k7oXoXn
         bv8gNuZ41rz/COfBA37gKvRaVN2zXoy/qKPJ9G8SrO9OVNM6Y8cPMD3AQqyV8OFMG8oh
         GIr+MR/udKmMwNsp0+Hqgu9NQhg4BjyOlKV/xbakFma/0p/lmr4dkyHCYncm2X8zg7J3
         QES1VHnwaPhTsxVGIyD2nV3pr8gBFX3bsaHeWhKQlVay9JtjvSk7iO7RO0qtGv4AcrzQ
         k4D/SGXKkowa6Ig1lm/MHfrup6DFL4OIoNXKT1a7AkMPfzssTpZhU82KM00f/p9VSyv1
         jqDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601073; x=1789205873;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cdCH0/RB1tBvaj1W6sXWObI//sTHWe8b2CDTC69fJ18=;
        b=Xw1LTNEFnX0GX5xBFRQ2XhWsTKad2OQXDKmz2qFr+krV331N/3kwllVVBrAwTz3O/J
         3QQnJifLUVikZIFqNlwv51b0faysLSrLXHi7DPG3dt/q0Wp3Lo5HZmq9so6gy5C8Us+1
         PK2pOuhODAl0I7glhvpHsh9RostV7tvcx0xv3hlJzfLW5IYFtT3SGpDNd6TtCCkbiJE/
         tgDF0VYasXNog+k+FyPMJfMXumGR+NNMirCKV3wa4IVhsMk4oLMqGUcFLKwblKQWKnRc
         9oOLAc1eYXK2So98HkVM7HLOqY9IPwR1Qj8AqUnucDTqfWvFdH+xZD6OkBtVEF7dNzhU
         vb/g==
X-Forwarded-Encrypted: i=1; AKwUvBxO6iDjUTyKzN5zN0r63yieEt/BuHnlvjHWkcZ4XLNPW4HwBmaxdLmHsSXZoVff/hCA7JOvQc37Z5E=@vger.kernel.org
X-Gm-Message-State: AFuF++mc+FRa0yuIjq+0tgqezH+pEEsSujw5isxkZtg/bVUzZf8u/z8J
	yLoUKUhIluIO+3APtIBsxV2OOTUTVYl8KkDO4niGlmZv3h+v+Qeom1oc
X-Gm-Gg: AYBFou1k0TR1cRShZwPLw+h5d84JZovvR7a1KLpbMIzWX18Q1oCUl+lY+Tex3mJbIzE
	lA5yneKxBU581+1fw9MI0rg7f+mSi8Llm5dhB6R1CO8nE0NgTeapKnPn8VRgSlFFl4g+JQMhbPo
	KIP8M3NbMJy6GiYFPFj8p8P/5h9V9ojqAkYCThVEAaB93a5K03vZz6+fiZFlH9UcuRwfw3IZfi/
	nP4LwhkDvBb77tXm4asY5Gm1Jgej6GzB5jZcppkWqgXrMEa1iWFpT7Pr8WRdtC+kWYFYkz4+o8F
	rXuc7zlEGap0X3qAwnuLd1JMkgTq4wbL6f1T9nw4Y2TbgezJ4HfiKPDL9URk2KxWs51soICXPU5
	Z3XdwXrU0ys7Qhym2A9xAqsoA2XUIXb8s5McHrkU6LeIW3UKKxJjsk7RcIjy/e/GfvuxhqOuoli
	JqbfelHYjdgEk3HIzkqeBsYlaaTSJOKbAvsZUCb43zR1BWpo5XZ7Ji0aC7qQ==
X-Received: by 2002:a17:90b:3b8c:b0:398:9bd4:d13 with SMTP id 98e67ed59e1d1-39b26242a75mr15470856a91.18.1788601072809;
        Sat, 05 Sep 2026 02:37:52 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5b5:60e7:9f67:1689])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm15763353a91.15.2026.09.05.02.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:37:52 -0700 (PDT)
From: mdshahid03@gmail.com
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Ray Jui <rjui@broadcom.com>,
	Scott Branden <sbranden@broadcom.com>,
	bcm-kernel-feedback-list@broadcom.com,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohammad Shahid <mdshahid03@gmail.com>
Subject: [PATCH v3 4/6] iio: adc: bcm_iproc_adc: use devm-managed ADC cleanup
Date: Sat,  5 Sep 2026 15:06:29 +0530
Message-ID: <20260905093631.48667-5-mdshahid03@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260905093631.48667-1-mdshahid03@gmail.com>
References: <20260905093631.48667-1-mdshahid03@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mohammad Shahid <mdshahid03@gmail.com>

Use devm_add_action_or_reset() to disable the ADC automatically when
the device is detached or probe fails.

This removes the manual ADC cleanup from the remove and error paths
and ties the ADC cleanup to the device lifetime.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index 3bbf814d4c8f..24fb41751e93 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -450,6 +450,13 @@ static void iproc_adc_disable(struct iio_dev *indio_dev)
 	}
 }
 
+static void iproc_adc_disable_action(void *data)
+{
+	struct iio_dev *indio_dev = data;
+
+	iproc_adc_disable(indio_dev);
+}
+
 static int iproc_adc_read_raw(struct iio_dev *indio_dev,
 			  struct iio_chan_spec const *chan,
 			  int *val,
@@ -551,7 +558,11 @@ static int iproc_adc_probe(struct platform_device *pdev)
 
 	ret = iproc_adc_enable(indio_dev);
 	if (ret)
-		goto err_adc_enable;
+		return ret;
+
+	ret = devm_add_action_or_reset(dev, iproc_adc_disable_action, indio_dev);
+	if (ret)
+		return ret;
 
 	indio_dev->name = "iproc-static-adc";
 	indio_dev->info = &iproc_adc_iio_info;
@@ -560,17 +571,11 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
 
 	ret = iio_device_register(indio_dev);
-	if (ret) {
-		dev_err(&pdev->dev, "iio_device_register failed:err %d\n", ret);
-		goto err_clk;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "iio_device_register failed\n");
 
 	return 0;
 
-err_clk:
-	iproc_adc_disable(indio_dev);
-err_adc_enable:
-	return ret;
 }
 
 static void iproc_adc_remove(struct platform_device *pdev)
@@ -578,7 +583,6 @@ static void iproc_adc_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 
 	iio_device_unregister(indio_dev);
-	iproc_adc_disable(indio_dev);
 }
 
 static const struct of_device_id iproc_adc_of_match[] = {
-- 
2.43.0

