Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E693D667F
	for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 15:34:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769096081; cv=none; b=fd9spUL5NjZjXgfelVB4JsahTdlMAWhbcBnINNE7OA/qK5iuGmeS64F9R6naVvkvUdTWu7Jzv1E5vAcTc6tjuDk2QQDs/fCLqX6HDpsaEZ8aNs65x4UOm3OG1MtvuiyrV5ARExkA4Wi+qfZcibF2gjjS6NAjiXGzvJxG+O0rCOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769096081; c=relaxed/simple;
	bh=veV4Hvu8V3IhvoHM9jbNfN/ve07wX7fk7Fy2f71wti4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CRvatBWS3RIeG2iCclsEnxUnwE3CZhipMmeL3x9qfOYbBDVvl3rJA7EsjVNd5q1eI7DV7ZG1ZGwZOhis1Iprd+EMHdsOa4oTvlFxBuzt5/71F8hL/JBGModO01NEtWkQonmvAwNdZpGwxTpsMWAalRefQjAJANmizy0aB35SK00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CVJ/cYc1; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CVJ/cYc1"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-432d2670932so1061114f8f.2
        for <linux-iio@vger.kernel.org>; Thu, 22 Jan 2026 07:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769096078; x=1769700878; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mpJOi209vD/uxUS2snh8vwobnTCwWbIDWS3RXKuN2dc=;
        b=CVJ/cYc1VpYQYdRE+VI9lFctPikTef+76DiHlDOKlznK0A2yrI72F4JSsq/4KidaRm
         52RQgv7vZbXXskN4p7tBl9qIkRKZV900wueC8SB3kqR5DO7hqdMAzd3TH7rJrYOOaL68
         qVNL/w12F5GrkLfvPQNVxg7mciqtgckWBslfH/LSYGzOjIc0hEkZz+jUNFDZjGfEpWPw
         xhI4TbZgiNXr9+ugCBiqKKFFyVZ8ZTYGWOgmmA0snj1TC8yFdb92DcwsdaJHn8gnhbee
         c7NSMygOvow1i29An9Ke/Ko32xw9pORf6K/HqALdDhEkjkSiUztpP8/g3mWnkSbNxblb
         uZbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769096078; x=1769700878;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mpJOi209vD/uxUS2snh8vwobnTCwWbIDWS3RXKuN2dc=;
        b=ZqsOKdpoIEEwAjYTSg54kM5Gii1Uk+ueZkiZXyIoTb+XT5UTpxj6dxaGm6n6PzfgK/
         d6LMs77nMV2Q60ak+EJDd/iFHvnZLI+yCwivCY9ULLS3RrXISRJR1TVEQaoBqK45VWd9
         lFH4n6nFql1quKb13lsEeOlZTQugYVwP3nQ5HQLhpeAHOp0AAMRMqJ758g7CwwZpK9gb
         44GxBUtt6x+SU5TP61mHUBXo4gDRW5pTbXDYRuHqq2XjBtfLHemm4361m358s6/09wmn
         RrrClI7H7Eq2EyVA3kYadkDUDis/cqaPeDMyWuLSXezzqH2xVHLnG6WEk0r2q7pfY2Sg
         972Q==
X-Gm-Message-State: AOJu0Yy+WtpIt8n4IRYTbGAuDLDJqEjcBVAiUNADsB4ufi0rFcb7sjO2
	ukZ60pHa805Nrt93UHDUI6/jxPTk8ddiI56GT+YMBIWfO9a5UHVo4WDj
X-Gm-Gg: AZuq6aKeuHlMPGMj2zhbMwYZO+t5BAWc38ZyRiL4Rne8eJO9A2iXXzrZY+6U6C7WwFr
	swhXsbNYSc4vIXOnQOAmKl9x1ZegyvcjrjKnm0fyK8+nOkN/9RmENVnNMuscePQZgYSZeDTTSIT
	z9En9IGv/LREKzZP352TheSLsJO8sINe4juO4jWe4C4GcNA9f5RphnPf4BIUkgyX4fQqiOwjtZX
	wkxytP9ArkOI4eCjEV+aPZk4dIF/jhnaJrZ2nd6Gvls7A1jbP8bFXV4v2SedzODmxtNsiyrPR1e
	P4asBWTubwZyWO+5jBHlE+KezdHE6qUtOgRVohLK0fWqQ0dJcarFWU5P4e5mme6qzrG5SDnAN98
	lWoVibkhNzPXBBHQdf+7rihp8IRHJGJad45uTHG8PdjbAJyy3u89JDhnOK4SAc2lcjQY55wX/cX
	LH
X-Received: by 2002:a05:6000:288e:b0:435:a2b7:2508 with SMTP id ffacd0b85a97d-435a2b728efmr8956264f8f.61.1769096077821;
        Thu, 22 Jan 2026 07:34:37 -0800 (PST)
Received: from xeon ([188.163.112.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4356997e6dasm47355229f8f.32.2026.01.22.07.34.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 07:34:37 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Linus Walleij <linus.walleij@linaro.org>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Svyatoslav Ryhel <clamor95@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1 1/1] drivers: iio: mpu3050: use dev_err_probe for regulator request
Date: Thu, 22 Jan 2026 17:34:25 +0200
Message-ID: <20260122153425.8751-2-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260122153425.8751-1-clamor95@gmail.com>
References: <20260122153425.8751-1-clamor95@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Regulator requesting may result in deferred probing error which will
abort driver probing. To avoid this just use dev_err_probe which handles
deferred probing.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/gyro/mpu3050-core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/gyro/mpu3050-core.c b/drivers/iio/gyro/mpu3050-core.c
index 67ae7d1012bc..ee2fcd20545d 100644
--- a/drivers/iio/gyro/mpu3050-core.c
+++ b/drivers/iio/gyro/mpu3050-core.c
@@ -1162,10 +1162,8 @@ int mpu3050_common_probe(struct device *dev,
 	mpu3050->regs[1].supply = mpu3050_reg_vlogic;
 	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(mpu3050->regs),
 				      mpu3050->regs);
-	if (ret) {
-		dev_err(dev, "Cannot get regulators\n");
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "Cannot get regulators\n");
 
 	ret = mpu3050_power_up(mpu3050);
 	if (ret)
-- 
2.51.0

