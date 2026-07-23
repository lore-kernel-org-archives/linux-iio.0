Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7DC144C50A
	for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 18:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832413; cv=none; b=S5c3pSe2vCn2smJ70xLqoGglOxT7k6Q8TojjTMOCUb1McBkX9BcHyyeEXEmVUhzAm5Pdkzuj7tQQZytiF8ap091JiUFIdIwdqejX/UAEJrOyLHK6IduIT+4UhEKUedU5BhsHeZKJ3d0ulEcylTFtGFWe57Sz+APWlZOYqKrMN/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832413; c=relaxed/simple;
	bh=koLwl54hduwliaDn6Li/AbrO7iJtrRjAGHnmTifrPGc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uVMCo4WPLc1kXZeZcxfOrgm2blPMKBJOReirUXF+qP1UDmKMMxIbq24fYlRnOME3ARXGJMwkPVHnBR7ohlOnzhQXXY1FQaX6dmjlea5g5Wei/4rOjFODDFp0NnGMBdGGtUiBcw8an+KvYbvvIr+Tb0wuEfKUObM6JTtlGps7QsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TxpoLRqT; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TxpoLRqT"
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-38e07ebd263so690121a91.1
        for <linux-iio@vger.kernel.org>; Thu, 23 Jul 2026 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784832400; x=1785437200; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ECPS5j1qCPcwB0YlL4FTJ27ue7WhDH56E/Wn/MeLYUc=;
        b=TxpoLRqTRQvl5KhCiowrngOKWXJfZ8rgv8ETnvXluAX8cUE0oIJ9Mn8LPX2O1mUKzR
         vyjyPS9TLBgDo+Do45clztxYhuKe4YIZ7gj9cdI82jXSc3/sYOLyscfe9z+XyVJdYDtv
         8txziwMlbm1shHg37eGw3uk21JrO+8w5bdDyy/7A3p5SR2PzIkQaleFVIcP/pdzrIpP7
         Sle9SLoXxu1rnq7Wf5zEO/+P5de5/kg/nhNDfeUEY7FCqTTQDC7N9KAyCMXRwVeUvm8y
         QJ1KZS6ujBFgF/wTWUWKEAdO9djPTuetHtQH00FR0qc14css9jrqjIBxF4mcYwu6WWsr
         BRNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784832400; x=1785437200;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ECPS5j1qCPcwB0YlL4FTJ27ue7WhDH56E/Wn/MeLYUc=;
        b=NYfNtmxdr/aS2bihjPjRvt7sgEDITzinbVSIY3S/gNUk7rNaY1riWOS8H8e7M8TpHh
         EV3s8kiYZXKnS+ktZcAn/05gFRLJ2j5sa5sn8AS7URXiOC/ZxwIQhRxsubT5qkFlsT/B
         mQnXEYNFtDjUE/BhxuOBoQq8xqVmDbK7+1G2ZUXu1Fu/3Us0qNzLXyQe3WB7ilcrllwi
         UsctJHUUUdJhqrDP6ZJw3a0zLAz6e5ubVBw/UCflYbplQh7s2bTJB6oDVMLMM1a9j5Qd
         8tPZm21Jtu+w/GiSoB1yN92B/wbxpxAJdBlTAgVwhPraq/I+HHJR3OAWB8OYFd77TPLr
         /0JA==
X-Forwarded-Encrypted: i=1; AHgh+Roya+h2vsXWvwbEX76XwVym8onNF4kweiKc6Sj3n1XUONUG+8LyPtWaeoIHz3fMO9PDBpK5CsRZ6a0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwHzqN/AW/10W9H+8whJowhCOmt+XSudPokm2NQWuRmXGSOkLPf
	7N+FqmDdMTvVu5YOIUpRS/sPHoOyA9XvPh8sw+K7t36C3MA6glOAWjZW
X-Gm-Gg: AR+sD128AEoqtaC0xIOyORnDoBvrkk6IBau/cgdWB2ETp8xOMqPOWokORUjl0DZ0LIS
	PBCUbsgGia+qP5Y+jKR3RSeQQy8/F8vEOSrx52kZBmPHR/bl3AWnaXZH9l8yMYDNAyia4MzJgXj
	p3pWyFR3Xcdgg9TZCDjLKDtnqfQCRprvrwoEftUWAgl/Bq2YcVTkZt68xk5BCOlotpwinfcaBPW
	as2ZHrCrGRWsryDMF2z1IpX2SjzJe7ooJ4kPEio/zXRURkb3L78bA6RnvgnM7mHUYPvwxJiAmXG
	HxbpNDlayX0a7rrA28YaP0wB9O8IvGqXWnvBIRfysxanV1kOvkr8LnPJh6RHRGNhXbc/EPo/KsP
	ua/0HJb4iwi+L54pyumRwIzg+jJp5Y6e7jr6UtNHFHGoMUwI0waKOSFlNjoe9B0P88uf9frtO
X-Received: by 2002:a17:90b:5588:b0:38e:6a44:671b with SMTP id 98e67ed59e1d1-38ec6281ddemr4252308a91.0.1784832399932;
        Thu, 23 Jul 2026 11:46:39 -0700 (PDT)
Received: from ubuntu.. ([110.9.142.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38f03af8a45sm308155a91.10.2026.07.23.11.46.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 11:46:39 -0700 (PDT)
From: Sang-Heon Jeon <ekffu200098@gmail.com>
To: Julia.Lawall@inria.fr,
	Jonathan Cameron <jic23@kernel.org>,
	Linus Walleij <linusw@kernel.org>
Cc: cocci@inria.fr,
	Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 15/36] iio: remove conditional return with no effect
Date: Fri, 24 Jul 2026 03:45:17 +0900
Message-ID: <20260723184538.3888637-16-ekffu200098@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260723184538.3888637-1-ekffu200098@gmail.com>
References: <20260723184538.3888637-1-ekffu200098@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Both branches of the check return the same value, so the check has
no effect. Remove it and return the value directly.

This is the result of running the Coccinelle script from
scripts/coccinelle/misc/cond_return_no_effect.cocci.

Signed-off-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 drivers/iio/light/isl29028.c      |  6 +-----
 drivers/iio/light/tsl2583.c       | 14 +++-----------
 drivers/iio/magnetometer/ak8974.c |  6 +-----
 3 files changed, 5 insertions(+), 21 deletions(-)

diff --git a/drivers/iio/light/isl29028.c b/drivers/iio/light/isl29028.c
index b88e7c4eae3e..ea38d797082b 100644
--- a/drivers/iio/light/isl29028.c
+++ b/drivers/iio/light/isl29028.c
@@ -405,11 +405,7 @@ static int isl29028_write_raw(struct iio_dev *indio_dev,
 	if (ret < 0)
 		return ret;
 
-	ret = isl29028_set_pm_runtime_busy(chip, false);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return isl29028_set_pm_runtime_busy(chip, false);
 }
 
 static int isl29028_read_raw(struct iio_dev *indio_dev,
diff --git a/drivers/iio/light/tsl2583.c b/drivers/iio/light/tsl2583.c
index a0dd122af2cf..a38a0130d854 100644
--- a/drivers/iio/light/tsl2583.c
+++ b/drivers/iio/light/tsl2583.c
@@ -456,12 +456,8 @@ static int tsl2583_chip_init_and_power_on(struct iio_dev *indio_dev)
 
 	usleep_range(3000, 3500);
 
-	ret = tsl2583_set_power_state(chip, TSL2583_CNTL_PWR_ON |
-					    TSL2583_CNTL_ADC_ENBL);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return tsl2583_set_power_state(chip,
+				       TSL2583_CNTL_PWR_ON | TSL2583_CNTL_ADC_ENBL);
 }
 
 /* Sysfs Interface Functions */
@@ -790,11 +786,7 @@ static int tsl2583_write_raw(struct iio_dev *indio_dev,
 		return ret;
 	}
 
-	ret = tsl2583_set_pm_runtime_busy(chip, false);
-	if (ret < 0)
-		return ret;
-
-	return ret;
+	return tsl2583_set_pm_runtime_busy(chip, false);
 }
 
 static const struct iio_info tsl2583_info = {
diff --git a/drivers/iio/magnetometer/ak8974.c b/drivers/iio/magnetometer/ak8974.c
index c7fdb7c2f543..c988d0e40cea 100644
--- a/drivers/iio/magnetometer/ak8974.c
+++ b/drivers/iio/magnetometer/ak8974.c
@@ -379,11 +379,7 @@ static int ak8974_getresult(struct ak8974 *ak8974, __le16 *result)
 		return -ERANGE;
 	}
 
-	ret = regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
-	if (ret)
-		return ret;
-
-	return ret;
+	return regmap_bulk_read(ak8974->map, AK8974_DATA_X, result, 6);
 }
 
 static irqreturn_t ak8974_drdy_irq(int irq, void *d)
-- 
2.43.0

