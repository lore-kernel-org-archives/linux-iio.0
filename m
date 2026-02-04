Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BC652E92BC
	for <linux-iio@vger.kernel.org>; Wed,  4 Feb 2026 13:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770212214; cv=none; b=ZcRAOpc2x/KYDN7Wa4lxVgDyxh/xISltsxG93uskSVzjR59xgqChcK6UxaXzZarwp/ogMby6JN+zMtc8Ey6lFkjFuRBFTkDZ+Tk5NAobmF9106h7mtN2HWn1wdxxz9rYFs9+NsmPJ8OUWDME2E3ih6Bg7SpmfT1YaAlaPcanDd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770212214; c=relaxed/simple;
	bh=f/iHOSt98VEql9k83HDuNZJgnWlJD811sHLH6piWGKU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dhA+sMRpiq1hyx3ntPV9/+ClGTrKKLFuhgwOYRElj2/Pr5tetF9Th+GGWvX7ogFX+wDxuiz46wMUhrU3L/06ndUk9MNGoTljelzhWzje+4N4wejGZRETLEUQnA3b6Y/MosVk2PePxoJaqAKatfqsFSU2Zwf+qen0DefK8tdimss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cUAk+Yum; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cUAk+Yum"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4806f80cac9so39011095e9.1
        for <linux-iio@vger.kernel.org>; Wed, 04 Feb 2026 05:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770212212; x=1770817012; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HObmXU3uBvxhP6GM9bDdwOd15Fnf+3qnP+5Sq0FpP0k=;
        b=cUAk+YumvPJk6Myzv05e0EXNBF42SuMTH2mI4BDTI+XiKEJ5mN7pcYBRX1E707MtCP
         s0rc/NSMWbpbQ6ZOPVIVrQO6q6x/5Gn015S+R3dh0LBC7D1gcMSfYWk86C6E2/kY/05/
         j2Znrp4GK9GIIyG/UZRGJ5vVwS6vl8b14qCMS5IonF9lCroAm8YnMNVEIhAO18aAl4GX
         1bJdsICoeYWj0zUfov1Rf56/+zeaNEt0+gIzX8OQ6/D3Eg5XaclSXfDq+Dj71yGiAONy
         akX10BLCOKc3eqwu7W8lQ1y5LK70xFxslwYxyWYENzDh3v0PL5YoU+sXdGeRjoL3wJY9
         kz+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770212212; x=1770817012;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HObmXU3uBvxhP6GM9bDdwOd15Fnf+3qnP+5Sq0FpP0k=;
        b=cvbyPcHhgiAMkYqaoHdoZUMy6H8P8INXb3qwTKPHZYHDpQT1xbmWXnfGdRmjqjs+h3
         KAtH4VwTazSarnFKXIlbdFNJgVSEIV7sSK+XnO+rvb17M/mtzaTLWirx5Kdtz9eeP+Dg
         YhudoyuqFSxHCgE9ASEgS70PN3gWitOiN+Yrn4c8BWJY7AM7LD7KJsJbmpsVCoYwM/r8
         +rtvN4O4SBPS3ucXpNu1ZVPBBiVAkXUeDV0mHj724mFtUoLEZkWSSPFgWRaotCdAZCOq
         +hilTaq1JwjUAJsbppCupk4YiUf9aBdXAlEyNsWdqzUnt1tzcRH8ZcqtTtOoLreWQLqo
         ZFMw==
X-Gm-Message-State: AOJu0Yz8M35K2AKvJMLoRGQexn6wPnXm55/SMZogUsDZXRh6THr4Nwsw
	2biBOxEhpLPcD03y5OQpXXqfkU08fJ+beAAG7oNMCZI0FT3FK7wFecQI
X-Gm-Gg: AZuq6aJ/Qf12DCkQUQY1GUnNAsF//Z/X2NiHsQk//e+JLf/FXd5Zkk42yAFCi0eFwVn
	aZ+EaeJ0Qz0YnL/Bb0e/ye/394acv+Q5TzfmH9u3rI4+XG9pPdkdTMYOEPby8NgEgoY5QtuRSau
	+gR4CA1Paz/bEoWgKKff4kXmfJcl+H+MyPJajBjZMSoJn1SzUrnfmDqCrBLvUH8DAHC0nZmMYYW
	GYoUKOUrfNr2MEtGb7lCSnnLRcXPQbNBms0lbtnmKplXB2aqMuCgfN1mMhH/7wytagzgILedqUy
	GhgOC+S3kL9bS83+O7xERXsi201m5kBReDNirKkw11AHUXIWGf4W3bbzvcjWDePT9tBhifkNyFM
	Y6hdT7hACMwCnsvZo9VYaBcg/1rFX/DUQlMJGGo3tC3xr4+392XjPrA+JDjb7pw0+HXy4POvF1h
	47bUjVanDyIC5ZBCg7obRO1SyZlUyWZYKmzcEEDbp/b1t/7sM2d1KLfzZpa84MXlL9SGQ=
X-Received: by 2002:a05:600c:1f16:b0:47e:e71a:e13a with SMTP id 5b1f17b1804b1-4830e987b7fmr40251235e9.32.1770212212107;
        Wed, 04 Feb 2026 05:36:52 -0800 (PST)
Received: from chris-laptop.localdomain ([195.21.90.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483108e3ed5sm35389725e9.5.2026.02.04.05.36.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Feb 2026 05:36:51 -0800 (PST)
From: Chris Spencer <spencercw@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vassilisamir@gmail.com,
	Chris Spencer <spencercw@gmail.com>
Subject: [PATCH v2] iio: chemical: bme680: Fix measurement wait duration calculation
Date: Wed,  4 Feb 2026 13:36:13 +0000
Message-ID: <20260204133636.29361-1-spencercw@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This function refers to the Bosch BME680 API as the source of the
calculation, but one of the constants does not match the Bosch
implementation. This appears to be a simple transposition of two digits,
resulting in a wait time that is too short. This can cause the following
'device measurement cycle incomplete' check to occasionally fail.

Fixes: 4241665e6ea0 ("iio: chemical: bme680: Fix sensor data read operation")
Link: https://github.com/boschsensortec/BME68x_SensorAPI/blob/v4.4.8/bme68x.c#L521
Signed-off-by: Chris Spencer <spencercw@gmail.com>
Acked-by: Vasileios Amoiridis <vassilisamir@gmail.com>
---
v2: add Acked-by: Vasileios
---
 drivers/iio/chemical/bme680_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/chemical/bme680_core.c b/drivers/iio/chemical/bme680_core.c
index 70f81c4a96ba..24e0b59e2fdf 100644
--- a/drivers/iio/chemical/bme680_core.c
+++ b/drivers/iio/chemical/bme680_core.c
@@ -613,7 +613,7 @@ static int bme680_wait_for_eoc(struct bme680_data *data)
 	 * + heater duration
 	 */
 	int wait_eoc_us = ((data->oversampling_temp + data->oversampling_press +
-			   data->oversampling_humid) * 1936) + (477 * 4) +
+			   data->oversampling_humid) * 1963) + (477 * 4) +
 			   (477 * 5) + 1000 + (data->heater_dur * 1000);
 
 	fsleep(wait_eoc_us);
-- 
2.43.0

