Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A20222584
	for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 15:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772293534; cv=none; b=GonfhnTMA2GmRPa6oSUNn8cJf7xpM3XeODveRizeqMcwZzeLnIv3IQhC0l5hSAtWHq749mDIHOHj04kx2S8TtqsS7wMqiW6S9VGMPteT5EDjCJrTFIJJvWbjCq0of494w1GRquNOm+832UiMC17HC/g2BH/P5LsB2hXzaDu9d88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772293534; c=relaxed/simple;
	bh=cQLQApxV+gyvPCk7Kb0ux6zyje+EMsitaz8UQXjtjv0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E9BI4P2CmrGjFlxHnErQeGrMfxJGV82mUgHTw4wz4OgCHwKkWnGvElbhSZkhMZCMrF7qGASxWzk0oBFwvXm2ScfLIgNO0AFSJWQ/Iwg57YD775a6o3GR/6jhCsWnzXu+UV4LeaYIf8S5NVXBP4B6f1jao3uzfd3D3R+uo6tZEUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LN19Nhev; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LN19Nhev"
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-82746ed8cdcso1613841b3a.3
        for <linux-iio@vger.kernel.org>; Sat, 28 Feb 2026 07:45:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772293533; x=1772898333; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8y0A6UC5dgjVa/R/Ri9dwaEzI34u2KnV/kwuSGeb3lg=;
        b=LN19NhevlzJwqZwTkrCuXYXvTewuXUcHiT3dddtEEHwU5cr7oeUXbHJaICpzkmj/hw
         CmEy5LGrPDEJg75LJ/iXlV4PxBvs9DEbXAQHPRW++xyzkILqg81kL5wdozVoefO9WRH+
         VRO9TIzPX/mtSLQgVzsttypIvVsFQayu0DsMnRNHWkHklXtJegyqYYo9C7B+RcFNLwql
         wAT/O1Mnq6lXYvAC3Ln5nsS3hboUQ8L1GDqRwTaArrA3RBtr384ERJw929AKdKEQCAGf
         MOvx77iRjTSZk+4yY8gQ5qfyxlV/hPCoCBzP9+YWIhPaEWiIhC4vWDtpDNXMiNvLVv8D
         7EQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772293533; x=1772898333;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8y0A6UC5dgjVa/R/Ri9dwaEzI34u2KnV/kwuSGeb3lg=;
        b=iMAGwo2bsQ9V2qE/Wyew7eP2shDEKcAMcldbK5LMygI8yr3lQ+VZ2VPna+FHM/caiX
         dlC7OI76oob7bED6InnE/uRH8tHDnGGcaPcPkQ64gljR71xbh+1ToF1NPxBWs9iJIMtg
         cwK+t+9dyN8JUkAtXIh4z9KSANCa6GnYmhYOeIT8nYmQUyXfKcaMjntWfU4nZFzGTNxh
         rmqxK5JpKcVim+WS/VCMeRpv8a8dzstAFim5ohpM00l4qfyBMyyMbO1D6y6S9dzzKZGX
         O3Gs+3V6eNJ2pxZkbaKhS/8/RioJ0Q4O4lUno66Ja6XyNdnP7giKA7fHL/D4BK3f+sHO
         XgIA==
X-Forwarded-Encrypted: i=1; AJvYcCWXKkCB32DmrjChxApf4necFh/2pPSw6/0YE2g1/i39yzZ48aAAeBoBhhBUzzvsEwi7IILclcSlSzM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMIztr4yjmdDV9ebXd2tNuRT+t86x52TrufKNT+aOrwSotiMn7
	lwV5ZlzwNa00iHlGAbgot/RutDecRIVGphxaVltL2He2E8jzqAtm64/o
X-Gm-Gg: ATEYQzzMPTt/Ca9DFGAbzrERn9vy9gjWtgOG2AD8GSpK3FydGPjEmA6TzIGaF18uUj6
	c54X/wPlrc4hRuesMHVSY+aBefkd6gGlOeoNHMwLVMta3M7J7LUXrjsDDpjMf/duwFdaWIFrHxn
	j9dL9F7Lf8rvHy8boaeWICcogtmo0Bj/nq7wc7/uq6V88xAXfHHDB4UOvGkMK9bLIY527aTC9ui
	6slK2XnFZYDHLlF60dOC6o0MbmVT13PV50rv8QyT31L8BVoTtYRZ5S17q4JIoIP2783xTd98JS2
	2PB2+vYIQ6FbQcUpHjqg7Up0HhfPZVYs/0z+aS99fJa+zwh6a/McR5tvIl8g+Q4bXNLiYiKuRSm
	C/GQpZbC4GN025Q0iOCyYw0OnL9TMXXNwdnwscGiBsEvPDQPd3X4WWKDjoCtEyrddvN+Vvm+nYv
	ZIJzz8ur3jpl+7uuD6cdtdAjSuE2Q8i4V9xrTwZmEFww==
X-Received: by 2002:a05:6a21:610e:b0:394:6109:a548 with SMTP id adf61e73a8af0-395c3a1cd63mr6137821637.3.1772293532669;
        Sat, 28 Feb 2026 07:45:32 -0800 (PST)
Received: from debian.ari ([152.58.180.148])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c70fa82dd09sm7807299a12.28.2026.02.28.07.45.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 Feb 2026 07:45:32 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de,
	Michael.Hennerich@analog.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH] iio: adc: ad799x: use devm_iio_device_register and devm buffer setup
Date: Sat, 28 Feb 2026 21:15:15 +0530
Message-Id: <20260228154515.16639-1-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the driver to use the device-managed versions of
iio_device_register() and iio_triggered_buffer_setup().

This simplifies the error handling in ad799x_probe() by removing the
'error_cleanup_ring' goto label. It also removes the need to manually
call iio_device_unregister() and iio_triggered_buffer_cleanup() in
ad799x_remove().

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ad799x.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ad799x.c b/drivers/iio/adc/ad799x.c
index 108bb22162ef..42712372acdb 100644
--- a/drivers/iio/adc/ad799x.c
+++ b/drivers/iio/adc/ad799x.c
@@ -847,7 +847,7 @@ static int ad799x_probe(struct i2c_client *client)
 	if (ret)
 		goto error_disable_vref;
 
-	ret = iio_triggered_buffer_setup(indio_dev, NULL,
+	ret = devm_iio_triggered_buffer_setup(&client->dev, indio_dev, NULL,
 		&ad799x_trigger_handler, NULL);
 	if (ret)
 		goto error_disable_vref;
@@ -862,19 +862,17 @@ static int ad799x_probe(struct i2c_client *client)
 						client->name,
 						indio_dev);
 		if (ret)
-			goto error_cleanup_ring;
+			goto error_disable_vref;
 	}
 
 	mutex_init(&st->lock);
 
-	ret = iio_device_register(indio_dev);
+	ret = devm_iio_device_register(&client->dev, indio_dev);
 	if (ret)
-		goto error_cleanup_ring;
+		goto error_disable_vref;
 
 	return 0;
 
-error_cleanup_ring:
-	iio_triggered_buffer_cleanup(indio_dev);
 error_disable_vref:
 	if (st->vref)
 		regulator_disable(st->vref);
@@ -889,9 +887,6 @@ static void ad799x_remove(struct i2c_client *client)
 	struct iio_dev *indio_dev = i2c_get_clientdata(client);
 	struct ad799x_state *st = iio_priv(indio_dev);
 
-	iio_device_unregister(indio_dev);
-
-	iio_triggered_buffer_cleanup(indio_dev);
 	if (st->vref)
 		regulator_disable(st->vref);
 	regulator_disable(st->reg);
-- 
2.39.5

