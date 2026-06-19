Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BED363BE644
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884528; cv=none; b=RgHmONO+krY3jS5hs+7U+mBSF9wVEjtQC2qd3zoAmjXgVg3AUaUEZlHNFiCatNjEZBEPpkxsPOUdMbm8RwYCCNhbBtQ9sZHbASHjrqDgcH9a4BlIdZFKFAXUnLM1AQSXrxXSp0uwr7xPTnOS+fGg1A3FJnFrkh4um5f6dqRukHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884528; c=relaxed/simple;
	bh=uiKFLbhx3BgEcgzYMQ3lN+vi0rsygnMaCWVPpm3hXXc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pfN4v6AiUjs8Qu5Y1BSNJWAOMjbjnZ3KgylFW98sK8lWBMJUI+iilpbUMqtpkvAiwWqkpfnCOKQuVIkjyVDTodp/tryJ6eTKHKZSpPfgJ8QN9TTGvzSX0OniImgw0wpNR7sGeJPrp+KJRT2RKXrMJQ1myDuOq7iNmfEtg1Zq3DY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=dT97t1U3; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="dT97t1U3"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490c1915793so18254845e9.2
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884520; x=1782489320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ejerlHqY1v5r+oE4x8ZYp5/kGV0wwByccj/f8eBeG14=;
        b=dT97t1U3HwM331FCJfE8F6Lgd1kvESYPV7lLUdyDOjZIzpiJDyDBYy0UKH+C+AT4rf
         YS3DZw5CnJ20N8vTytdakPRqF19sl2VLqPD/+EBgZtQbweCjRGZp+a+QijI/6I/axwy7
         gRsP95p2F9Fpnp1lltubZAWm55x+AUC7FthwKF5StROuheWfXOcbi5CpoYxR3hG6rA0M
         kvECkKdaJSZXBqj7UESjOpd1DifeclsF+/gN0oywKx6lApe0QOESfC+hGwVLxDCiLEE5
         R1/Y+DwmYQg+7GLdfExTJyXKuPzB9gljCismBTZ92DmjQgvQG37n/EMY8HgVP2GfW7PN
         vK/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884520; x=1782489320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ejerlHqY1v5r+oE4x8ZYp5/kGV0wwByccj/f8eBeG14=;
        b=jhB6x+7CMKLr0iH8ihtXLjmShzvdtdr95myc6/MLbL0EKVBYbA7ouReLW2mYjOabcK
         q7GjJbwOxNFI95+izR+lUDkuq2vVvEkS48oDGQOiTTGVpaIPLZ1tcjdOxSQEqA/9/aIS
         /MEo0x5pR6KuKhmJLJuNYCEJj7UPCIM10djXG9PmequAs2SemhOzn4WLN7M9c4igp8x5
         8+gdi3RVzXIvEGaBREU1RVFXum2bPMN9ZhLqXAaQ4roicKSq6OY/WjFK3YnR++Ohp8mI
         WD+t7dPtk37jL/9dlXxg0Cwrb6efqgAREQ1TFc617EdF9Lur/hTeS0pS+0RlIKSIn9TJ
         qshA==
X-Forwarded-Encrypted: i=1; AFNElJ9tn5N9/RH+lmSDpN10lPGh7eo3LUyUcRUsJyEaalRmyci65OOQFxPGQQ70J/AbCzxXk36D/liuFEY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8CfJ2hlxa/9IpxiWKNPLtcHYXb3eGCAMTfgv1ljwasIR9i1/d
	SuyXdVkHNhHFIkcCxfWDmirfAbqZZZIMlWgjjwixOd/0+7lANIr2BZzQtGjlnNafEv8=
X-Gm-Gg: AfdE7cmfEae0myppgIOZYPweqEakT+qU9CJqJzo86tcEWYU8QLf+2up2b8ddjQZY7gR
	ZeO1wk4buAgAHeVLekKZsDlnbVjy24B94cvCj5SdQDElQlIlcgT6ojhswsYPeqNswrgjd8fEkd1
	xyvFd2m0wdcKjytyluRTIEGQyrb1iqUj8j7wuZLvlmLQJd+TrqhWR6/DvXZjYhZO937Hv3Fn8cL
	kZKukZ9Z13ixqR6BoN1guXx+N1M5A6f+ckkvGxeKT80dSBQYI+I44hkmW06wKPcJkODoPigbQ37
	YdujJbPnTkAYbTip52A5pFQKs7FAss+Ykl00iddwsHhHMJZVGUy7NPL0YI8oLEJsShWufI9HD8B
	iv0XjaiSV+/JhBwuZ6ga+U1uHVJNVqQ7SZIdb1svyNItYBuUiW52yJKLuvllDM8fkKMIKMZcQIZ
	O3bANl4ScB8G+QJyJYMMx44aIk5fKEvmKHPkdFUY6TqT5ZTpU3VrDo9+xBdZ/BhG4GHW3VpfrB9
	5Y=
X-Received: by 2002:a05:600c:820e:b0:490:d354:d151 with SMTP id 5b1f17b1804b1-49242571659mr50331015e9.18.1781884520006;
        Fri, 19 Jun 2026 08:55:20 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923fd164f5sm78321885e9.11.2026.06.19.08.55.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:19 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 04/13] iio: adc: max1241: Simplify device abstraction
Date: Fri, 19 Jun 2026 17:54:32 +0200
Message-ID:  <3e03bd522955c265e88f61d9b3d3e5f018762ce0.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
References: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1455; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=uiKFLbhx3BgEcgzYMQ3lN+vi0rsygnMaCWVPpm3hXXc=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWY/AgNgTneKHSnQYepsdlhx0VcBiwVbTQQUg oqthRMA/TGJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmPwAKCRCPgPtYfRL+ TqG0B/4pM7Jazp7+1amWfNMdR8y8ZZSNGAmTy01ud2F7Nf8ZPcLyfaQR7dCnxSIOST13tioxlqT x+uCiPXnH4C6aRgCb0//+BNy5ZQ9NoHrYX/9ZxsWBbxwJNcEnDz6zlyR+Y6PUjZ4vrOUPvEyk1b 3fL2JZfrGCYsEb5jF9UQelaPwuWtkJkZzVdWIjLEu+m21kaGa4aUVxCsubdioo95SHqhYrxfbMm xOy7JMUEoomhkkA3O3D/ZNGHS81G/Oeg7CWpl8wP81NPgII05VSyXNsv0R2wnSzeMm4vZWEqJc3 eiABj72UcPeqqVkGtJ803FkE1qkNo8eYzg5cONfaStTZp8t2
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

The driver was introduced in 2020 and since then only supports a single
chip variant and .driver_data was unused from the start.

Drop the assignment for .driver_data and hardcode the device name
instead of doing a lookup in a table with only one entry. While touching
that array, make use of a named initializer.

Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/iio/adc/max1241.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/adc/max1241.c b/drivers/iio/adc/max1241.c
index d62c1a011659..fb7f53316e3d 100644
--- a/drivers/iio/adc/max1241.c
+++ b/drivers/iio/adc/max1241.c
@@ -15,10 +15,6 @@
 #define MAX1241_VAL_MASK GENMASK(11, 0)
 #define MAX1241_SHUTDOWN_DELAY_USEC 4
 
-enum max1241_id {
-	max1241,
-};
-
 struct max1241 {
 	struct spi_device *spi;
 	struct mutex lock;
@@ -166,7 +162,7 @@ static int max1241_probe(struct spi_device *spi)
 	else
 		dev_dbg(dev, "no shutdown pin passed, low-power mode disabled");
 
-	indio_dev->name = spi_get_device_id(spi)->name;
+	indio_dev->name = "max1241";
 	indio_dev->info = &max1241_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->channels = max1241_channels;
@@ -176,7 +172,7 @@ static int max1241_probe(struct spi_device *spi)
 }
 
 static const struct spi_device_id max1241_id[] = {
-	{ "max1241", max1241 },
+	{ .name = "max1241" },
 	{ }
 };
 
-- 
2.47.3

