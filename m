Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F113415F3A
	for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787851324; cv=none; b=h/yeaWUySCQkxN/NRAFUDSftRHQzumeZHCnpBk6AAVY/kaZDaAbQ4sPozywtJciUQ+CUvz08jI75u+6hAbntwFvXF9+M7sBSJgLjkfbwjCCtmcTglI9fmxDwmBlwdLCzPu1ksfHzoIC64szZQlRoYUjzvlMselRDlRSJHbRkEF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787851324; c=relaxed/simple;
	bh=SQjMM6e5l1eXQ326406VN4Ppfu0Q1sDCfdFbTQj8lmk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Ztd7r2OAS8UUYLPdjTfIUhDaQuaJogdDql5H9EzKkWAL9uCILhRQiJznNOpk21L4BT5R7FYqCzMyZQdbIcuTp+5CvYherLplDWYQvHUFN1creE6rwDkO3WQYBLC7EvH4IGJqjIUeE+d4zhrBS4vI2eWS3fPyRcWYqPUw+estY38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ahecb6Lj; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ahecb6Lj"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-38759bcd877so310204a91.2
        for <linux-iio@vger.kernel.org>; Thu, 27 Aug 2026 10:22:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787851323; x=1788456123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=zSPvpz+bFRPPrDJKLP2l884CdP+OIZCEuQCCyJqs4wI=;
        b=ahecb6Lj8hn7UHxE4gAGhXJf4rfsX/io5wMhKVgL6cRjm3Do3dzKWiOFmBDxSl56+f
         OqyWjJHSardnItpUllhAU0+LDOlmbJjIBPyx1QsKKCk+LCfSo95nimLYePBRX2Zbltqa
         fxoPjwOQ6zkTDwwee8HV9ogC6Q9OcO5pTZrba56M+Hq3DNaCPX6fvxTiJY7APDB0Fz5g
         pHQwN6ArnLWZxG1wFiinBBsRubsuDTH9i/B1cwhoqDwUHk8+kJbFN+jWIpgUtES1+JrJ
         giWSRmrxG9wxWkHNp3BemQwLIqyD6dCzOHe9YgPlpEwiJ7YcKoO8x+Jl7AhXycsMeBRm
         xVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787851323; x=1788456123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=zSPvpz+bFRPPrDJKLP2l884CdP+OIZCEuQCCyJqs4wI=;
        b=B6ZQj3fBEyHme/iViHijMSI69eF4XVkKOAk99AzrJVgRynlXPpLLzKuo0r2LXM8jwT
         Ot0OeTalBYMkthZibtJP1XOvoPgQxgfRqByeZZvT3PJLwT8D7Ng513tjTkVb+QqMO9PP
         A9VihMUiCve8v7xhgzszohx7hukkWAO8chWE6QVJWl+m5NDWgeVN0t73O8jeWertInsy
         phS00QCP83933dk3UDgbJ84yReqY/LiikY1ouIxgckf/CejAWBTxpjHsGmQONXnolJrU
         cfRTOXJHlKn7J4SmbIp0u1RAnq8lxhYgbO7Hfvdbk+INEdQ5YpR877LpD6coJrRaYNI5
         nIdg==
X-Forwarded-Encrypted: i=1; AHgh+RoNorx7z9j44EVacNGDMNSVc8iXiquGQ7IuYmcLk1NbG0vcZUZZo3R9nujl60T92Wag6SGQHuJl7Ig=@vger.kernel.org
X-Gm-Message-State: AFuF++lWAYgr0wc3xn6kIC/Bnfi6qyruIm3TwJRsEXVqy+UKEqZeL+9T
	8V9QwqtI0NEmt2xEHDMoG3vJyHuyPaiTpd5iKrK155KmuXxe6BJMHeV2
X-Gm-Gg: AR+sD12iFDbJwk80o7352M4Jau4Y7B7eSGysp/W74q4qVXrSuD5pG6F+3VaTDw5urG6
	nppWyJMmRDHLd2ITXaAt7turFo4sY28S4SRH2xBDBFrSpSxIbK3ogoro/bLI8KSNoccVvJGrpdY
	DUhF7W27+kNL/V9Dy06imec2++F4EbsT6RCIA8jm0G2z/ziJInIq5+GG01LyrlmCs8UfgUBe7yW
	aDI6Y4Fj9Vu/Ue8+4PT908nz5fBtoitmplKgUuxvcxUVKoQiMKpeXkrPoXc+Zk716VqTHdugQ6i
	UbbyhxeMPILNzZfvWsZ6shQU8+asDg86cIo+2G2Lv7PIh8+p1c2mtb9q3yxJ/18xJu0euu3vHRV
	VhCuFZhgsxchw1YJalFFF3Wy+FIKKOA/VNrgMSWoBQVmUJJMS60qPPsBFY5i0zB8Lho4wal8pBV
	10fePeoqqOiXiS7dVdess3ZHCPCIbAXkZLr9Xg0Xnrcv7os5YlXT+eoA2ehNsHDmK7663EpaNXm
	RFx8RI71fsrwOUErv0jGw85ynUdfPptW43W
X-Received: by 2002:a17:90b:384e:b0:38c:a59b:5189 with SMTP id 98e67ed59e1d1-396d104d0bfmr1151199a91.15.1787851322882;
        Thu, 27 Aug 2026 10:22:02 -0700 (PDT)
Received: from debian.ari ([47.30.51.191])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141a8eedd13sm17797165c88.1.2026.08.27.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 10:22:02 -0700 (PDT)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v4 6/8] iio: adc: ti-ads1015: Convert to managed resources
Date: Thu, 27 Aug 2026 22:50:58 +0530
Message-Id: <20260827172100.39176-7-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260827172100.39176-1-architanant5@gmail.com>
References: <20260827172100.39176-1-architanant5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use managed resource helpers for the mutex and runtime PM setup.

Replace mutex_init() with devm_mutex_init() and replace the separate
pm_runtime_set_active() and devm_pm_runtime_enable() calls with
devm_pm_runtime_set_active_enabled().

This simplifies resource management and ensures resources are
automatically cleaned up on probe failure and device removal.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index ba4a01850531..a6dd85debc0e 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -959,7 +959,9 @@ static int ads1015_probe(struct i2c_client *client)
 	data = iio_priv(indio_dev);
 	i2c_set_clientdata(client, indio_dev);
 
-	mutex_init(&data->lock);
+	ret = devm_mutex_init(dev, &data->lock);
+	if (ret)
+		return ret;
 
 	indio_dev->name = ADS1015_DRV_NAME;
 	indio_dev->modes = INDIO_DIRECT_MODE;
@@ -1044,12 +1046,9 @@ static int ads1015_probe(struct i2c_client *client)
 
 	data->conv_invalid = true;
 
-	ret = pm_runtime_set_active(dev);
-	if (ret)
-		return ret;
 	pm_runtime_set_autosuspend_delay(dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
-	ret = devm_pm_runtime_enable(dev);
+	ret = devm_pm_runtime_set_active_enabled(dev);
 	if (ret)
 		return ret;
 
-- 
2.39.5

