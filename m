Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795417308;
	b=g8nHP/Kks3ZWO/0NhaTuI7flggcWCmqB5NWIh3vB5MpcjQEZc1LhcYgjNahiyD7yjLt4
	 4dH9GIuX7Xxijp7X8yxjegS1A6LI8fukvwtNi+v0sccSj2fJpGnmFJbuNcqVnnFE4aNij
	 Rs3IFpXHUTISPhTh4kAXjq4apVeGcTaKiAoM2M3tQS/BNGwpYzHndV233VXhgxMC6+QvS
	 b2JonPLLt3Y46VzX1t397b3Snh2Q1seLRc8Qj8P1b7ZFLb4Yv+0NvSstHR+O7KI29vQz+
	 DiRrgc1FAoiDQeLgwp61zq4MvhMrnM9WVl4OzC1aNsYDGB5i2y8sjvPf81rIqh3ffcw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795417308;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ZJl9XladIemhT3/Fp4VwYIfIL4e685MSOlrpJso3I1I=;
	b=grVXzuHIOXPurcENbwbVTKc7PCKtSNkOicOlZsP9qPpmY6wS4zVkiVla5loJjQkq+Gd/
	 WaDiiaoPB4aNk1SQaGa6vruVkraP5/+oZnmGZWEoRvEiyi3umPmpfpywkhJmCEmI81YBs
	 vbuob5/RU0ZciNM97omCND7Npt/DrQrwe1O46rQwi3lBMtiSPMRZz7XgLvmX4FoqqV1Cx
	 +wHH4bf7+OA+i7xxmxTAjrH1+/5iI3gG+jVN4nNsbaFuERYdQ36p8wgdntn6CdOwy/vTA
	 Gs2geqqqcINNH25b7T8imM9QegjXC93Rl9GG8JZU5PUIe6k2iDrtGqNotZhl0Jyd49Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouB+gQpV;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6CB606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 07:01:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1E6CB606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ouB+gQpV
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-4ac08f4a0b2so2043156f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 23:01:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795417306; x=1796022106; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZJl9XladIemhT3/Fp4VwYIfIL4e685MSOlrpJso3I1I=;
        b=ouB+gQpVROS0MzdgORguWFaW4TYdFb70pGv3/cn0v/BXsqO19AWeIx7xbD7t4IhDuC
         3GoefAH1+N96Si5uoupxq2aMZawdh2o+TLwKzupudFEHrpvwuEX8X5PtnjSfwuiQNKux
         98ywtBJX22FnYqWFtfkH/m6+rIDxoWidLCMlenQdL2Ek43Y3zCZ91llTzi/yF+k9wVBu
         4A1dp9bePbmF209Tr7hLeJUGA9FSY+I6Vbe16vsHEaoc/7cSTZNgCF7koz9hyLLrwoxx
         1cc6BtyLIsHaZsaljGHXC8z0z5w7Meg7W3FyM+mk0/Wjky+BTQTRPhu/R3g/kiW7mJkp
         +fiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795417306; x=1796022106;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ZJl9XladIemhT3/Fp4VwYIfIL4e685MSOlrpJso3I1I=;
        b=YXWTtPzhxCXl7xFP1w6Tavttg+qRfvvlcQai5ZuiyYnxYXHJnjVP5JweQP+NLEcxCJ
         iLd5TjLWwX9kVG9PAGeIdc5ct5gJftgI01AQVJW+HbJD13vrwjm+V/BxWRscASugO4wT
         uISsOtJLdcqUgUpfdon9zvYnYgQuz0h/bBcynJIKbCIsPm9fumXj16pZBJEieLfYV52g
         S3QdKUQ1TJOjvdmhviFop42i78hmVdKm+14xSelIxf2Y0ViUSPrz0BtUeIDDIOcLNUMO
         2gg/+N694H/I+7fwAyWj+pYPxI6qbRrgEMyxMHk4ULLyLlaF5YDuMqqiiFwd8lpnCTd8
         VpFg==
X-Forwarded-Encrypted: i=1; AL+hErHlQe63giBPPXN2ZhNB4nS2BvrE7f8hDh/25TmDds/E0m+72nDfq3SucpaMuGD4rVCeXtPZ8vjQdW0=@vger.kernel.org
X-Gm-Message-State: APuU4Z/caffWPqQN9OG1GT1dQiCowqTs07BRoZc4P8hi5gqrjO3389/h
	wP2OrGNlfbWacWu0miAuiYkcgvuXUshkqsaVj7XXIH7/zNUC8ZYwRtDK
X-Gm-Gg: AZFdTZeKSGLAej5min3W74S7jaLfL0BWaoFLtTu4C9kHlxZ9CA+v6kUeh4+hboAU+4O
	sYY2z9uNG/72lMno4ma5iGT6Wjnmk6zUu/kBiPytfo3wWjR++ChmOVypoO+b/j/tc1AuEhxW9sK
	FVyFCCX2+r6HBitIcUJH+gYUYds021nLLzJDudLUJRnbA19nI8SuBGet+SbNlfj/M1z2gZ6J9su
	rns2pP7r5N1/CBDcL2h/v+ekd58Laokut5AtVezrX5tk+INW6WIoalGBLsQd7ojQF9FiwLSloDd
	cUpT1Y1q1KDflvUV20s2iTna0z7ectXaHqM4uqo5wlOkyXlg24djtH55+2O4fWft5jCFU0qwaOh
	NXwhUlwsNCRHB8HdF9/hOhrHhGjJ/VFRydr8iZRtNdqYuvoFG8IOfolasepo9QXoSC25mEZzCx2
	jPgxXDCGl1N6ES1qNucgDB2P2LEnHOj3+u9+3EU3uSORxh7QIKYix2gTfFL1wCSKJQDxiPX9Tld
	nRShiiPwdVlQYc7dE/ySN0A+oqct6VWvaOUhQ+ilIOoSNlVqQQ4h6boQVy6yYTmRs51M6J7uH+m
	zArsAyHTXhdjuFs7YuP2OvBnC3O974WOo1Q2
X-Received: by 2002:a5d:64c5:0:b0:48f:db47:6ebf with SMTP id ffacd0b85a97d-4abb2ecf85amr19716411f8f.38.1795417306314;
        Sun, 22 Nov 2026 23:01:46 -0800 (PST)
Received: from fedora ([154.182.66.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm20779007f8f.3.2026.11.22.23.01.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Nov 2026 23:01:45 -0800 (PST)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	nicolas.ferre@microchip.com,
	alexandre.belloni@bootlin.com,
	claudiu.beznea@tuxon.dev,
	giorgitchankvetadze1997@gmail.com,
	amin.gattout@gmail.com,
	antoniu.miclaus@analog.com,
	gregkh@linuxfoundation.org,
	mripard@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH v5 3/8] iio: adc: at91_adc: switch to device_get_match_data()
Date: Mon, 23 Nov 2026 09:00:56 +0200
Message-ID: <20261123070101.53868-4-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
References: <20261123070101.53868-1-abdelnasserhussein11@gmail.com>
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

Use the firmware-agnostic device_get_match_data() instead of the
OF-specific of_device_get_match_data() to retrieve the device
capabilities.

Check the returned pointer so that probing a device without matching
capabilities fails cleanly instead of dereferencing NULL later on.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/iio/adc/at91_adc.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/at91_adc.c b/drivers/iio/adc/at91_adc.c
index 76000486b17a..2a378540837d 100644
--- a/drivers/iio/adc/at91_adc.c
+++ b/drivers/iio/adc/at91_adc.c
@@ -18,6 +18,7 @@
 #include <linux/module.h>
 #include <linux/of.h>
 #include <linux/platform_device.h>
+#include <linux/property.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
 #include <linux/wait.h>
@@ -1002,7 +1003,9 @@ static int at91_adc_probe(struct platform_device *pdev)
 
 	st = iio_priv(idev);
 
-	st->caps = of_device_get_match_data(&pdev->dev);
+	st->caps = device_get_match_data(&pdev->dev);
+	if (!st->caps)
+		return -ENODEV;
 
 	st->use_external = of_property_read_bool(node, "atmel,adc-use-external-triggers");
 
-- 
2.56.0

