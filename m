Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCACC351C20
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780049419; cv=none; b=k7nDclmV7XV3EexfyqKfa9N4EJ/XEGO2uXTSxYxUyWzBO1p4CuMU59be6fv0tozn7w5cTzAaqFFx0mSdzgmBJjNDuJnUgViwBsTcT3l5nO5fgSubH5GKGfSTIUHvTc9KvcmmBnE2MPVYZxhhO+h24RzNBVMf/0gGbcZQzl4iUFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780049419; c=relaxed/simple;
	bh=8lP2osw1ejXQFe3pBiR0qDG5WlB9iomr56wEmbszI30=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=IefA9z3n3iZWs6h2Jl5LTJRJ8rhN/n91nKse24/HNaIjRrgX3AkeFcGIL0PAtfqOisGxtjp1z/8pQ6xDaK9f2ptPittslyPvbb+XkEdm3W9P4sWWKebHBRouT8hNG6p5d7NYjh9YEBz0yBnSKGCQfAp6nzTzXDhKfoEQsyEok0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jUVZZUj+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jUVZZUj+"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5a8e387baaaso1169620e87.2
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:10:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780049416; x=1780654216; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=waXLFXi4u+JUT04meQL0HqaKFuPIcUDC7QQYoJLhlmU=;
        b=jUVZZUj+i2H/MGX8eBobq+f2GlW/Z5y/0mHfsHhJbdhUiQ0CwlBkgl4S0Nk/tA6Qyk
         Ds641StfzTb/3kaXI/zsMVQsBIvsuYsPj/Ad+Etu2Z7C26hU3P57KNSCBhtgoguYLZmT
         KoxGcuKpT9tP9/hKD0u52Nfel3XfUt6JCd4G+OGFtG2GAZ72VGvNUOEpquzxtwjCYrZz
         UDvcKVVkYWjqIDoLww9OOlQn+0bce4gdC0G1gobhAVyarQyNlsT5NWxWsKMU3FjuUzIp
         6AVtOlvBw6oDJvL+Wcpz2xF0GB8p/QWkxXzK/8oqNTod6KaYua20YzXWpMh7dcZ98mGY
         ZEYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780049416; x=1780654216;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=waXLFXi4u+JUT04meQL0HqaKFuPIcUDC7QQYoJLhlmU=;
        b=NoriH5270vcvQlGYF5nLMDmtkmxXrapuNitFh2eUT/ntanqSxAHxEq6sMfOn4v5sgW
         ZdV80OgE5UKkfvxR+lNReGExn1XJJkXQeU5oJ4dRNwIsCroMEKg52d9/XHbu3KN/v00t
         Q3GBiGmz/RsY6fa/J0vlTb2yTt5iLStLRsCEPM8LPfUUM7x6jdRBl3+gbglVN1cp3nrC
         m1+hJO1/Wn4DFfvNqbo2mU3Tt/5clfwAkcP+WUpcnHiLVo/npQJ2fwEuWEoM6m2Lih41
         u5c0UmvjCPf0wbZoKD9FooxFzVVyqH9KQH79ipdschq+m5u+mQKhVTJIDx/k88Y0ijUp
         +xfg==
X-Forwarded-Encrypted: i=1; AFNElJ8sTSPIAJV+NxU1MIyUSIlf89WaxeaXjyk87o0VqpGfQZjg7L86yiQacAp5NCV6fDR4eOgwshIOfpU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJbmFtgP48RqjI0W+4r28MemLAfJTaiLKmU9lAb7ZALuzoJyFB
	mEFfCEIDVJafpm1+Msjr/5m4F4NmvCgDZ2vYPNKCKDIbwvl2/PygWxTr
X-Gm-Gg: Acq92OEBruTsM9cayBbbPxRCqKZSYuBw8gwrY2f8LGSnay//wK33rrEJw4bxuSWuPsS
	eu2b6GyUu8gApIIt+S1GLdyE7XJ57YsxUNxDNF8gfcwhgol0yRgaYOslLGGPgOQ8lfDvmuUgWPf
	OtXKc1Sng4mBhUpCyxNbbkvOVAzLEOQ6HJcz4A3u1tQXAUMgoEuiaqnB0ztgFqMcVQx/RAy8vZ6
	yRZuYorvwsYYKC5OwZaxa7X9Nc/wHfvLmT3r9lrmtmR/5phUkbYdupHVCfC02mFJLYXJMEtmRBu
	aXivY81/dzfqtk1VsZRXm7yq6GIyjBgm3c8tAHmL0KvGRBwhWevZfL4kMT7o8y79TpFKFJqC/2R
	C+6CwpxwKa89NAVi1MrKZE5RRZtxuvtWMMZ7OmZxzaTsamPl8az104oNzu6rAXEyus3G6QxnzPy
	bpalc39qPhxXvcK7IUQwuGd88g3ZMorMywii0hyQtjLGjUOEI38/RjAl8=
X-Received: by 2002:a05:6512:1051:b0:5a7:46f9:be6b with SMTP id 2adb3069b0e04-5aa5946b7d8mr320093e87.0.1780049415913;
        Fri, 29 May 2026 03:10:15 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b59682asm175334e87.45.2026.05.29.03.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:10:14 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: adc: ti-ads1015: use devm_pm_runtime_enable() to fix probe error path
Date: Fri, 29 May 2026 15:10:11 +0500
Message-Id: <20260529101011.3030-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ads1015_probe() calls pm_runtime_enable() and then iio_device_register().
If iio_device_register() fails the function returns directly, leaving
runtime PM enabled and autosuspend in use. On subsequent probe/rebind
the runtime PM tracking complains about an unbalanced enable.

Switch to devm_pm_runtime_enable() so the enable (and the matching
dont_use_autosuspend) are torn down automatically on probe failure and
on driver unbind. The manual pm_runtime_disable() and
pm_runtime_set_suspended() calls in ads1015_remove() are no longer
needed and are dropped; the devm action runs after .remove() and now
handles the teardown. While here, convert the dev_err() + return to
dev_err_probe() to follow current style.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index c7ffe47449e2..2331e946c519 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -1037,13 +1037,14 @@ static int ads1015_probe(struct i2c_client *client)
 		return ret;
 	pm_runtime_set_autosuspend_delay(&client->dev, ADS1015_SLEEP_DELAY_MS);
 	pm_runtime_use_autosuspend(&client->dev);
-	pm_runtime_enable(&client->dev);
+	ret = devm_pm_runtime_enable(&client->dev);
+	if (ret)
+		return ret;
 
 	ret = iio_device_register(indio_dev);
-	if (ret < 0) {
-		dev_err(&client->dev, "Failed to register IIO device\n");
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(&client->dev, ret,
+				     "Failed to register IIO device\n");
 
 	return 0;
 }
@@ -1056,9 +1057,6 @@ static void ads1015_remove(struct i2c_client *client)
 
 	iio_device_unregister(indio_dev);
 
-	pm_runtime_disable(&client->dev);
-	pm_runtime_set_suspended(&client->dev);
-
 	/* power down single shot mode */
 	ret = ads1015_set_conv_mode(data, ADS1015_SINGLESHOT);
 	if (ret)
-- 
2.43.0

