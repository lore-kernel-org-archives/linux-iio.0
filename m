Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA156FC5
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 18:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785178151; cv=none; b=qE41FW0isdGMcqvbj+zVmv7bVsGx9gFu33/m4wxgaspGbHt0KYPWkkF3u2GctIdhzHhUYrCpOg3GX1PhCh1lttstGiPud5HI55Dq5dWlFMBqvh2E5q1QOmP1LPKN1GV8COxlMfmsAVyFCrcas52/AIS0+s+N3bEwKjJySQeVUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785178151; c=relaxed/simple;
	bh=W4IQ6GXohjMhkaqwXnU5ErX6zmIVKPPTUQkUGXqGh60=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pNah31cU5QcDw1VAThAdZpjuUtivk/NSArGfkNk53Wi8/ewz5uTZZ+/RuAhUTHEII19GKaRbrtryPaWma5xW+RBmoTw5/cJow9Iu3ZOvasB644p5J/ljebPklfdvDKcbo2UxEFxKEJKNlMdQOqQQ7S2VmIP3RY4IFtp5gVhdPwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh1u5o3k; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh1u5o3k"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2ceaf8a1265so37075205ad.2
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 11:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785178149; x=1785782949; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uffnzbO7pKc1iMQL3P86uZeFmD14KrCf/TU5kuwyBBw=;
        b=Wh1u5o3kAWpbIPFe+XvcSmEhxscwW0I6bWyNt/u8cSAIjmgIOYlhYX1KL//7iHOEjS
         GYVkLnNcY8t2oMujiAr3Fy70NegOhzZf7d4sauo+ZIKSCWlHq+U4Gdu6Rds/b16tibfU
         1Zxn9H85PazvF08Ro3ofajjy/vMNws40HoXnJyXXN08pqvNAl58gRlgbIwjk6w6/oz2y
         m3VWjfUiAbOBCgLMUva/2l4/t3AIQIm3gFP3kqzwjdxGcJnPLlMqgwwaMglMfEI6NLv8
         zGFa2VgFqDK8y20WBq3j5cuKdguJDkuYfFNEdGgqAPMNvJj2TeQt3u+AK5Kw6tMglW2x
         ICGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785178149; x=1785782949;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uffnzbO7pKc1iMQL3P86uZeFmD14KrCf/TU5kuwyBBw=;
        b=O+CHfcZnynINnoA3/815CeHQi+1GqijKXiSQegNdqZcAI5e6D0Tarin4iE0ZPB4pT9
         S913nthu1T5CfRR7+mHfyGpdKvXlSk8EciMbW1wFFGIsmH8Z+oAtsVgWZ12+9PLmVV0t
         HTybT7mmsi8AH4bdXFwWMi85Y0t87WqpRn5DOWKAHYG8sfo9Xq2bf042sLJ4Dna4LEBx
         8Xr4lD19eR87xugkxSALOLh7G7Py6SsWVhOogFcVkMJE+UXW0B2G6HhQJInsei3XYx6+
         OJDBJC/KbvkUATPGPKF9SPHqwtU3l7gyBzi78F0gjO603uN1U9RPa448RlCdcgwXxsoY
         x0xg==
X-Forwarded-Encrypted: i=1; AHgh+RpW/UQLZXKoOxSvVXh4gHJZnm/IZzfuZ4bOmXxH56eB1JhZGxr7zl9aZdZGvxI0JDqjPZvcOMEJIMs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpUCVA3sWJyD8uC02eshCNCfKZ5FRFQ3jjQfqFjr+GQZbM3Kmi
	UQh/OkSaxvbiFfx8SxScX6RE+Oxr+fZz4hqngptUGjRWFHUyJzdKznhr
X-Gm-Gg: AR+sD12tQWR+qI4ldqLFTQNO03+PPjo3CPbdoYMz8UNYQmkAXYYwOzlaVlzX3uGEAzp
	HACHpy7sv/k8yPpb8PYUOw/Bj43D5NH07dehhCs2iIIbv/aCh4mBSZ3e7FHCszlglnSehGJqlxO
	ux4Zf0x+b+et9oiCL/ECGSoxUIhDsFRf1ANLkqndhvzfYWmAE2047KQEfZPx5TO9q38+CZXa3qJ
	w7wCWOD8P4FXWtLf9i+fUDLbq1vPUmFL3NC4X+oY1fU8hByPEuhYkFS+Z2BbCUQUeZ7ZHi3CO1e
	YPNL2plgy1rzA+FefSnq2qvInW+2KzYMgt6gixBDNYiYkaQoM8W79WmDpdYvXZcEqC4fo8rMWpJ
	MZmy01EAvkg4Hd32VrSe2Ki6hThrm980KmfLnW6R+zYB81MsCAM3M3LO6fRsz6Y/0qlZzCHfB
X-Received: by 2002:a17:902:eccf:b0:2ca:f40a:be76 with SMTP id d9443c01a7336-2d00f3e156fmr4449635ad.36.1785178149304;
        Mon, 27 Jul 2026 11:49:09 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cfde7d7b87sm40186245ad.57.2026.07.27.11.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 11:49:08 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Linus Walleij <linusw@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Magnus Damm <magnus.damm@gmail.com>,
	Marek Vasut <marek.vasut+renesas@mailbox.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 3/9] iio: light: isl29028: remove isl29028_set_pm_runtime_busy() helper
Date: Tue, 28 Jul 2026 03:47:40 +0900
Message-ID: <20260727184755.2055414-4-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727184755.2055414-1-ekffu200098@gmail.com>
References: <20260727184755.2055414-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

isl29028_set_pm_runtime_busy() just calls pm_runtime_resume_and_get()
or pm_runtime_put_autosuspend() depending on its bool argument. Call
them directly and remove the helper.

No functional change.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/isl29028.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index 6d5dd17e7a7d..33deb1726689 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -333,16 +333,6 @@ static int isl29028_ir_get(struct isl29028_chip *chip, int *ir_data)
 	return isl29028_read_als_ir(chip, ir_data);
 }
 
-static int isl29028_set_pm_runtime_busy(struct isl29028_chip *chip, bool on)
-{
-	struct device *dev = regmap_get_device(chip->regmap);
-
-	if (on)
-		return pm_runtime_resume_and_get(dev);
-
-	return pm_runtime_put_autosuspend(dev);
-}
-
 /* Channel IO */
 static int isl29028_write_raw(struct iio_dev *indio_dev,
 			      struct iio_chan_spec const *chan,
@@ -352,7 +342,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -405,7 +395,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, false);
+	ret = pm_runtime_put_autosuspend(dev);
 	if (ret < 0)
 		return ret;
 
@@ -420,7 +410,7 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 	struct device *dev = regmap_get_device(chip->regmap);
 	int ret, pm_ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, true);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0)
 		return ret;
 
@@ -476,10 +466,10 @@ static int isl29028_read_raw(struct iio_dev *indio_dev,
 
 	/**
 	 * Preserve the ret variable if the call to
-	 * isl29028_set_pm_runtime_busy() is successful so the reading
+	 * pm_runtime_put_autosuspend() is successful so the reading
 	 * (if applicable) is returned to user space.
 	 */
-	pm_ret = isl29028_set_pm_runtime_busy(chip, false);
+	pm_ret = pm_runtime_put_autosuspend(dev);
 	if (pm_ret < 0)
 		return pm_ret;
 
-- 
2.43.0

