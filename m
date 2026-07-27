Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44F8F3C6A38
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 19:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785180084; cv=none; b=FCyG+2cJh+UrpUoGQDv+OcQF4ZYb6iQCibLAbrDh5Xnkyf18MvXSkKOC19PWpkKi04R3aeO9NSmyd+mtdX19DT0O+DZA+6+eEL+RiSgkhItpZolOwaoWvdQUvhZEJH/WpUwkK8SaONIyzzDVNTa1mL6UpArFaClrSXMqK/Ah0bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785180084; c=relaxed/simple;
	bh=KqU7hUX6EEnvGvvXp6tf05FdZonTZfQ28JEGxpEGpyc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=iilIDOF8BqL5eBw7xx8N/wPJLJV87PuYulLmZAOKEpb/CjMd84jXiezxl+cnCU5mFuyf4eO+ofz7TVMHHZT4WMRGSFkmmwZ4oSCMtYDMhX3ulKs1BQlUyxmRUCPkukK7O5mzarLVb18MWPwGK66SpM6hIHi2m2+A6y3+4eYiBmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p/AHpsDn; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p/AHpsDn"
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-caf707e3a70so156100a12.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 12:21:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785180082; x=1785784882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nAYjNEgUAHuckjfKebSgoAzLO2c7KwVpNw4ZzJakepY=;
        b=p/AHpsDnpepkpzCkzN0NJ+xHmzppThZBUH/IpOUG6s67L8SmZOmi2Tz8DhAO7zEsPt
         Wlh9JcOE8z/KY1TceaFZeJxIu9JiBuUzJ/jCYkRSpCvqDk45AbDbnGhsGUIaf6pwCWG0
         /RLqi7np9U6MK8WGz+mrhDiAjYGDjAnic7IDwEoKDrwrkNGgeN3Z7EsKDAikWkElu9pB
         ko3jlfB9n0/9hrABi29j7FgPP6z/xUiCXaZkOoaDNN5igyy0g1uarSgmo4eAeuN3MqBF
         mzDK84phsi4pZ0vXQNk2TYAqHmWGe0HGwJCbKdp71O3akAP2QvbrnWSLGTx9Z37DaSFt
         2eag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785180082; x=1785784882;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nAYjNEgUAHuckjfKebSgoAzLO2c7KwVpNw4ZzJakepY=;
        b=RE5254ENwiIenAnb5NMEJOqc2nYLL3XAEwkWPPlzLjQYVSRnmQJ6pToM4YP0HIgxxV
         sp0uRObjEOIGj3CxYusD1LKFstRKPYrVse/VNNKcgGOc18gddlJexDs9+6QPn+7AZDwY
         70pS0RfNNAZT0qyOh0L4IDtFxglUDS56vym59HkMzFc2+pHcGm13K4kwKCQwvNIvtZJe
         4DbWZqa3QkXcmJu3p7eBmoI3u8+EKYkdi9N1k/b64RdldGD4b/BJdxugr5DUNssuAXpu
         KDSArvqPaMQLMgFpmXkIyTyFgsCtek/gmPnN8ERqLMoKwfR2XP04S4cUXUa38QHo6RV4
         wieA==
X-Forwarded-Encrypted: i=1; AHgh+RoqxCiTfpHD2cAEArKkfvgG2ooQ4lkMK++FdMcfn+N09qlAnAqgaue/hw0+980Pm26fKOeQstcjv0k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4lCj6qcpBPfCym0vxOy2j1QpKzQTweUg2xm2ofUpx+0RuNfLn
	mtu5mkHDkasoUdt4BatKnoilEltf0tZhOu4bG55vuyuHUNjng16edXqJor1hKqRlYV463A==
X-Gm-Gg: AR+sD11Ox0RHL0v2fAxiSbUYaiOsEJx11vPdrMIGrqwPPsj90AlB3wzjr09phD6d1da
	3GDs0CmWElfygSnfGL5Y1urGDv3lTsXLa2n1CW+rzHpf4QYDrsiqn4oxgoJOJcd1EjLzi6ZVNNn
	6/71gUv/F3GXbBeuEn5tMImb/90uzCIbXokrVO7hlDEX8mtkWYEM09g4rj89JBbxHHfFLMOqs0q
	BDnVtenU84WDfgk+FS0T05mXYZxpo+qdpvv0e7f2je6B7EB0aseoj9OFHpJoE/LwbMgETXv2to3
	AimTaPV2riRXEP6I0yOBPVFeMZVwkugUgKo5P634GOoOfg2Tuv0NMw/zwPaJ8jchOpKAz8CDWz+
	LFc/0ToKMB4sJsdNMBdOyZoGvfFGAPQuJYPfAWICqOKWN61LWUBg2xY8TJ6074WBQW5Ka0QHi16
	rofrFSPoP0NqjMUsiKYUnNr1ZDWREipYkXNM15o3VRbqxeb3benkY9
X-Received: by 2002:a05:6a20:9f09:b0:3bf:990d:3fc7 with SMTP id adf61e73a8af0-3c7858ef368mr41891637.20.1785180082471;
        Mon, 27 Jul 2026 12:21:22 -0700 (PDT)
Received: from debian.ari ([152.58.178.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-314bc549b11sm37595470eec.18.2026.07.27.12.21.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 12:21:22 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v2 1/6] iio: adc: ti-ads1015: use DEFINE_RUNTIME_DEV_PM_OPS()
Date: Tue, 28 Jul 2026 00:50:57 +0530
Message-Id: <20260727192102.37968-2-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260727192102.37968-1-architanant5@gmail.com>
References: <20260727192102.37968-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the deprecated SET_RUNTIME_PM_OPS() with the modern
DEFINE_RUNTIME_DEV_PM_OPS() macro. This allows for the removal of the
macro automatically handles dropping unused functions when PM is
disabled.

Update the driver struct to use pm_ptr() to avoid unused variable
warnings.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 8a272af69f7d..9cd620b71429 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1066,7 +1066,6 @@ static void ads1015_remove(struct i2c_client *client)
 			 ERR_PTR(ret));
 }
 
-#ifdef CONFIG_PM
 static int ads1015_runtime_suspend(struct device *dev)
 {
 	struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
@@ -1087,12 +1086,11 @@ static int ads1015_runtime_resume(struct device *dev)
 
 	return ret;
 }
-#endif
 
-static const struct dev_pm_ops ads1015_pm_ops = {
-	SET_RUNTIME_PM_OPS(ads1015_runtime_suspend,
-			   ads1015_runtime_resume, NULL)
-};
+static DEFINE_RUNTIME_DEV_PM_OPS(ads1015_pm_ops,
+				 ads1015_runtime_suspend,
+				 ads1015_runtime_resume,
+				 NULL);
 
 static const struct ads1015_chip_data ads1015_data = {
 	.channels	= ads1015_channels,
@@ -1147,7 +1145,7 @@ static struct i2c_driver ads1015_driver = {
 	.driver = {
 		.name = ADS1015_DRV_NAME,
 		.of_match_table = ads1015_of_match,
-		.pm = &ads1015_pm_ops,
+		.pm = pm_ptr(&ads1015_pm_ops),
 	},
 	.probe		= ads1015_probe,
 	.remove		= ads1015_remove,
-- 
2.39.5

