Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A92B3AEF27
	for <linux-iio@vger.kernel.org>; Wed,  1 Apr 2026 08:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775032113; cv=none; b=DMxNRAGDUJyAqWZoXliTXuNTZ40GcGuTk5/qzP0+WfS+FvKsjQx5rjHT+fj0qJWaGU9DIHuRSO5zymPaChvAjo7bR7J7OT4EkkMX1v1/Cusuz9m/8M2+JyCyAUwWcw1pclR5E0U41zP7Rf+5OvnECC2sjV7UHgqKxsW/UpmURUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775032113; c=relaxed/simple;
	bh=ounbH33bOU1BQC7yuGmEugk0/JkQPO45LQQsDJ7rJrQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+xKbLZ/qL0RDocG0OR9GxqS3piJSC7+U6LgC4AokCAWTqmnNbvxgZw/Kn6kf7cN+Cfqmz/K2Xwh0+b9Vqh3CFmDunACMD5sm4sm5/6w/yNo2G9mMa2VaP34EPMn6zfoUhIWjn3p9MQvzwGYeZFnjbW/flx3uW1oN8dUWNCfHIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NR04UgLc; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NR04UgLc"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so508300a91.0
        for <linux-iio@vger.kernel.org>; Wed, 01 Apr 2026 01:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775032111; x=1775636911; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=28vGjQJuP/IrXjf94A1F7k0ukYbn2CRuElEMS9vJWh8=;
        b=NR04UgLcKou6rbLK71NfLxmjJG4zcgFVSPy0hDsF9HK+q962rGdkgon1ENq0tN1pV6
         eE5e+Ataui+2HeD4uR5mLULftTmUp+JVlg2idlb4Y/p+OeqUHZUyNlfVs1RNsjKWLygS
         MSymckRXoG8gNLE5O1tAJDWJNmjlOGHy++LCMwpCrDr1BURrv/AI37Ib2wGQKebov3Mh
         aw7zqyb37hCYvRkdoRJNbujvYG372PZtvU0+r/02LxpikdbRV5yeAHYJrLT5V9NeXNox
         yDq3aPc67S7F3XejTkWVk1C0qTLdJQSfZBSVBaMxnsXyz93NTLfkN4z99HsqBmkzzNgz
         lgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775032111; x=1775636911;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=28vGjQJuP/IrXjf94A1F7k0ukYbn2CRuElEMS9vJWh8=;
        b=Y8kJy2l7m9BMw8i5JW/VF0XgwME0VQyuBdnxaOiFdl4zG5CUnKF+SBaEBNqkHDClHA
         j6oavVDcKfA2QT/RdQTUlgTqyqPLgMHABgJVrwXtQAXDqj5bVthpIjRYxDT0e6HBzjA7
         IvZAH9ZL+1YdwBrYiJSBOhjHosUfSVzQaZU/v5+QqP+JIyZU/HLTWv2wvCYs9HZ9LXvy
         Fo2F9vmGK2OAcf+VSUWXYKM16ZCjSFjT2OMq9L7veyK8TwXnzFY3XGHSivGaU3gI6Wwu
         JqQ2iw1hqGc681OiujXENYJc8IQksHdVhKTOTCsaZQrcmspXHJB/q3n+eUS8P7ntWHEq
         oWYw==
X-Forwarded-Encrypted: i=1; AJvYcCXxtvYfRKCN602QXtSQwvVE74FU79otvQfKl4aC5oKWWh1zBAWN6knQTryyL2Wk2QQkSkxpUZ+3AAM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzdS8bqHAfZqxcf/H2gdeqeqVMuHsAuj3ALpgCdwJgg5wNe0+xg
	kmwwanHqA+/lpqvNbgfBtdQB0gRrLhlD2XFupba0jee7MWZ+3BNyuR+g
X-Gm-Gg: ATEYQzzlwycq0nHj/1KbZdUaWdxhsUsYwUTj/d5VjbCsmpX+XF0b9Ts/nOkQKhkv2U8
	CwWm3EnhDFmiZypQtC5OZ9PcQmeA3x7IrPP4H6UFYEDfIr96WTKP/JtU5ypO07k1uNWIqVV0dEx
	7hThjh8jHDLMu7UufIKSh7FHbooGLQNEgyYySSvOcVxFlx2MhAnCQTep4gK/C7c+6kMmIg8XKPK
	cfMghiFil05hXZEIDUhkKAmURgxDiGcVJpFXYg0k/gNqS2gw+9JTOfNDruujNoNLeIG6Cu4tNpP
	YFSaOA72RL2IihWYqEV9/HHgn0qp5p2KorPfDYShtV+7Kw6xZmWPkUMVT4O7zuwuAbcSETNm1Zr
	9Cg/RecbFILjzS4ogVdVlMyWo5W2AEpf8FGaJHYbMk67AC1uHznE/sxEqKy+XZINwS9ibXwQKSP
	XxEVmGrzjVNKbTLKGpbTJ2VejQwdE=
X-Received: by 2002:a17:90b:37cc:b0:35b:cc8b:1124 with SMTP id 98e67ed59e1d1-35db8e5570fmr6270562a91.5.1775032111314;
        Wed, 01 Apr 2026 01:28:31 -0700 (PDT)
Received: from new-nest ([94.19.228.143])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe5e519dsm4118561a91.2.2026.04.01.01.28.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 01:28:30 -0700 (PDT)
From: Andrey Skvortsov <andrej.skvortzov@gmail.com>
To: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jonathan Marek <jonathan@marek.ca>,
	Brian Masney <masneyb@onstation.org>,
	Rob Herring <robh@kernel.org>
Cc: Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2 1/3] iio: imu: inv_mpu6050: use devres-enabled version of pm_runtime_enable
Date: Wed,  1 Apr 2026 11:27:35 +0300
Message-ID: <20260401082737.781018-2-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
References: <20260401082737.781018-1-andrej.skvortzov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

That allows remove driver-specific action, that does the same as
default action.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---
 drivers/iio/imu/inv_mpu6050/inv_mpu_core.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
index 5796896d54cd8..84eb0ee770086 100644
--- a/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
+++ b/drivers/iio/imu/inv_mpu6050/inv_mpu_core.c
@@ -1872,12 +1872,7 @@ static void inv_mpu_core_disable_regulator_action(void *_data)
 	inv_mpu_core_disable_regulator_vddio(st);
 }
 
-static void inv_mpu_pm_disable(void *data)
-{
-	struct device *dev = data;
 
-	pm_runtime_disable(dev);
-}
 
 int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 		int (*inv_mpu_bus_setup)(struct iio_dev *), int chip_type)
@@ -2019,13 +2014,12 @@ int inv_mpu_core_probe(struct regmap *regmap, int irq, const char *name,
 	if (result)
 		goto error_power_off;
 	pm_runtime_get_noresume(dev);
-	pm_runtime_enable(dev);
+	result = devm_pm_runtime_enable(dev);
+	if (result)
+		return result;
 	pm_runtime_set_autosuspend_delay(dev, INV_MPU6050_SUSPEND_DELAY_MS);
 	pm_runtime_use_autosuspend(dev);
 	pm_runtime_put(dev);
-	result = devm_add_action_or_reset(dev, inv_mpu_pm_disable, dev);
-	if (result)
-		return result;
 
 	switch (chip_type) {
 	case INV_MPU6000:
-- 
2.51.0

