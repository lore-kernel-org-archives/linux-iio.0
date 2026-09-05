Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0326F1632E7
	for <linux-iio@vger.kernel.org>; Sat,  5 Sep 2026 09:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788601094; cv=none; b=SJUZsJTDv8X2fDnJH4K5sKHpOoxx56ZsdsBG7g9Ji5nObMwmKuVg7FGBGIcOyJfVnn3ThgCe0BNImzOcj6tRYtsai662SjL1LoSiW0S5vfFQ5b7Yf8O8Vt1gb9mSMFShkpECw08+PQvQ9RQqHx5cpt1DesaQsiDg4GNGOZyGzHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788601094; c=relaxed/simple;
	bh=/SnvANubHgj9t723fD3mWASr15hxcpq0LbaSmB4ROXA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fNuvqSR6DVpMUHktmXEiTV0kWjtdRxqtKPKDb8Ys/Vdc8RJrDv+uG7NQidyj2t2os3xzvgwe9gnXgAjzyM9mZuqQG+fCBDU+48XIfMVGVAPOlDud698e3FZneVOje942xaFaosss4+ABxrO+DFq7zxTNf6sqOXiISc69H7T6hbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFzKWe4v; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFzKWe4v"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d9b60c652aso23449205ad.1
        for <linux-iio@vger.kernel.org>; Sat, 05 Sep 2026 02:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788601089; x=1789205889; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FKhaAa1V6dcazyDIDdMRIu/saWb8D7tpQe+JyGNOhTA=;
        b=qFzKWe4v6mY7w15FxyEseDpJtEZmkYtf7jV7h5U8m2y3uoq+lAEAGIq68NqHIGWoXr
         3HJizsIOmFMWHvA6n2qyPY5rNsEUBIPQ32nOtVCUyDBQj3E6MhenCzQfQgFPRs7pFeFk
         5B05p+ZZ7V0oTumGQn3ZRB5huy5+euDIwP0YQ9+k3XVF2P7I35Ef9OTQq18AA7tQyOaX
         HOZBvuy9J3VNNubAu/FJWKkwBkd1LqvYiXelfyDhbOdwafEBfR5Cgiy2rLOHkQ3V0G+E
         q6A4aJDYYulW3wmKKHFDBR5aGQESEixBI7woiO52XNbfzPo6460I9jmuNCzzzPKAW3Ec
         l5nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788601089; x=1789205889;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=FKhaAa1V6dcazyDIDdMRIu/saWb8D7tpQe+JyGNOhTA=;
        b=D/TJo9rvQCJtBhauDdfowsBRU6vTM7MfK+Z95X/POh2SugjqF+WGRMFtVdM0kUZfMY
         BBB6O8iYaEOsNNnZ1e68FMBcgD8kSBpDsRmGA4Y+gwammMkhnuuFs2UNmElg4LXpgCUk
         ogdssE559kLKuLZ/S/ejLsXZCK6rvAdE5Oq8Ww+DPbEVgaaW41ndHVSGaKM7m5PbHyuO
         kefhyFB91dNIu26WWmf35KZCsscEBZmaGSJwnsUGZ0uCqCIhl6M7RqjyDufuDMdRzoYh
         ZjNvboB8/ARfWx/CusAsaFXb0M2JKxxGjPmW2tMcDOsw8MjfVWUcZic5VGubL/XpFLQ9
         F0Ng==
X-Forwarded-Encrypted: i=1; AKwUvBwb9p8Ueht/5OK1DoiJ2HujRH0x7D/OxgqJ5NBmOsfd8c4u7YVbqr09j9DaKSO1GTp9L7P371tWnb0=@vger.kernel.org
X-Gm-Message-State: AFuF++nLuVGhBmcwvSaeA8xPIeX1G1wdt6Bv4WbnGTv/U1AXjQ2w+U8b
	4Hfp+j0i9IeZz5HBOxOQkCsXreDlvcH//IbR4dQDjaOPrCmcScgbyBhB
X-Gm-Gg: AYBFou12Z/u+bWOuXDffTMrZ8mKnws6ijF0+8+SIPx9tGDXq0Jx5k/5dET5hioazO1S
	wCTC8tQg9an7O4xRmcaYllQ8kAu22zmKOtqTUtZ8cEm6roEWr7QCu/JEu/WQRjUcEoZy8UhpyOL
	Sb/qAAoTu2OCS09ERGjdIOHijVJ5W2tdb8C76XVFGSB/8LBpimqTNXffpAx/It3ffWiB3JQ0K7B
	SLBpCfUN0by8EdL1Dig70ZEbrElLgDRdCNa36PP4g6YJQDxxIxmNAknQ9ZJ1VM8S6tdFMCKOvdn
	Gq1LosbAfw6ePAEh1+t9VwYgX8qIG4YotG11JKN/ThkHbdqm2yvBO8a+97SUBnDuR0vzP7yFz/o
	q81ccxVk4jbKz7yVk5vX7WLnN8m3HDAHln9eGdRvPA/rMkKJKYjc4a2eIVmxW9nlrhNitDuIMRm
	Cfxhouz4MIa2StNLgAWDK4Ldj5ORPFXjj+wypzknKOML7VaD/Rwb3FnRIq7g==
X-Received: by 2002:a17:90b:3d89:b0:398:9be8:ea69 with SMTP id 98e67ed59e1d1-39b262167e7mr19037767a91.22.1788601089070;
        Sat, 05 Sep 2026 02:38:09 -0700 (PDT)
Received: from ubuntu.. ([2405:201:8026:213e:5b5:60e7:9f67:1689])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b08d086adsm15763353a91.15.2026.09.05.02.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 02:38:08 -0700 (PDT)
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
Subject: [PATCH v3 6/6] iio: adc: bcm_iproc_adc: use devm_iio_device_register()
Date: Sat,  5 Sep 2026 15:06:31 +0530
Message-ID: <20260905093631.48667-7-mdshahid03@gmail.com>
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

Use devm_iio_device_register() to automatically unregister the IIO
device when the device is detached.

This removes the manual iio_device_unregister() call and makes the
iproc_adc_remove() callback unnecessary.

Signed-off-by: Mohammad Shahid <mdshahid03@gmail.com>
---
 drivers/iio/adc/bcm_iproc_adc.c | 15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/iio/adc/bcm_iproc_adc.c b/drivers/iio/adc/bcm_iproc_adc.c
index f4676607682b..6eae7596ac8d 100644
--- a/drivers/iio/adc/bcm_iproc_adc.c
+++ b/drivers/iio/adc/bcm_iproc_adc.c
@@ -524,7 +524,6 @@ static int iproc_adc_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	adc_priv = iio_priv(indio_dev);
-	platform_set_drvdata(pdev, indio_dev);
 
 	ret = devm_mutex_init(dev, &adc_priv->mutex);
 	if (ret)
@@ -572,19 +571,8 @@ static int iproc_adc_probe(struct platform_device *pdev)
 	indio_dev->channels = iproc_adc_iio_channels;
 	indio_dev->num_channels = ARRAY_SIZE(iproc_adc_iio_channels);
 
-	ret = iio_device_register(indio_dev);
-	if (ret)
-		return dev_err_probe(dev, ret, "iio_device_register failed\n");
-
-	return 0;
-
-}
-
-static void iproc_adc_remove(struct platform_device *pdev)
-{
-	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
+	return devm_iio_device_register(dev, indio_dev);
 
-	iio_device_unregister(indio_dev);
 }
 
 static const struct of_device_id iproc_adc_of_match[] = {
@@ -595,7 +583,6 @@ MODULE_DEVICE_TABLE(of, iproc_adc_of_match);
 
 static struct platform_driver iproc_adc_driver = {
 	.probe = iproc_adc_probe,
-	.remove = iproc_adc_remove,
 	.driver = {
 		.name = "iproc-static-adc",
 		.of_match_table = iproc_adc_of_match,
-- 
2.43.0

