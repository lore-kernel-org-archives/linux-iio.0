Received: from mail-vk1-f182.google.com (mail-vk1-f182.google.com [209.85.221.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B5FD3290AA
	for <linux-iio@vger.kernel.org>; Tue,  2 Jun 2026 18:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780424042; cv=none; b=HlCOu0ZJg4r0gUoPzdaxhw/uEiy9NPpXC8Rme+arFbBmNPSExpcdmlNakpnQYWVIlP3mGbN4eFheEldPvvuCfhGN8mxXeNzRqEofGXRMRq9MyJ5AgWyeXnIhjYb2DVlVd0Qh50k6bSEhqtSYN4tW4Xym17evG3fhbXNs8gKO0WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780424042; c=relaxed/simple;
	bh=gT9vtGomwr2YBhqB+I1cUafVp3NVJebbX9LkGkLu4TY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lSCnoCmlPtfVWxjJQQppmSDQDfAH2BNypfVEoLOTl9F3aPBLCM98yS78af6eUAl7TYJBm220vWjr7MKo+aVtRSy0fnaN2e7GLrdHRpZyK4d2b7pvmnUNNcYbdfr17wsQ2kdJiPYMlxd0oIWC/JyVUpYIZ96rFccB1ey3btQy1Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=HAev8hXC; arc=none smtp.client-ip=209.85.221.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="HAev8hXC"
Received: by mail-vk1-f182.google.com with SMTP id 71dfb90a1353d-59cb87795d1so134469e0c.2
        for <linux-iio@vger.kernel.org>; Tue, 02 Jun 2026 11:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1780424038; x=1781028838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=un5+wVFsN+iMeasPatJXlEUYLopu8Se8GcAmqD1RE0k=;
        b=HAev8hXCnm/IMZw9XbYhXn3owurtVlmI7y5Jw+toB+QO5MUpfUsz77exGpcEJCiTME
         RWjOWjM7EGf6NjzxJorDF3e3TzEBo7malDGNoWL0lI4+BKkj3VczYk6QduDQqewfQuC/
         tz+i9pgEYMMr8KzSL17cCRFWi4Afnh21dxGhY1w6BXYPpMNzpq8kBeySUaDxnAymdgz1
         N4lkRa+LBHgGKDfLLAJ4yFClW8KZ9/Qsd7D2MUst/Hp58GT2HRTq71/kQdqNGP08qixt
         aiz9/PIXgy5rpehiriJz0lvCZB/JDSO+Y36Soak182EnfyrPi6Ol/WXlT7mC54VJvk4A
         V5XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780424038; x=1781028838;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=un5+wVFsN+iMeasPatJXlEUYLopu8Se8GcAmqD1RE0k=;
        b=ZFmitXr1wB0W/RWC4S1qZCbd1tbh/FQyCxysDMO7Lvj8JjxkuGPl7bUo30bZxH/ifi
         /v929yh0SurrjADgSUXhypgXG1ayqbmklnAPcMUP6IT6bH4Ybpn//+uO/t2JqZjmno+e
         OJdVHe1MwA04gnFbX+JKoVML6n9b/XyEjHatis4DSq8YnuU4jq+B/kJaFB8qC8EmvZz/
         wj0dISC44oSHjNRR0IegR/nEIVKR1tN8R52bpsL/4w45H0AUeC9FsQgklOAM4LCiaP7J
         QhUwAhBkankzTqJc/ymEdGsGCAWhRg0ZIYh9QOC3oAqTENGogFPdMGlIu+Mka3ID0Rn8
         K64A==
X-Forwarded-Encrypted: i=1; AFNElJ+CYdYMT0yM+CzrR6ARpc1eI8UgVgRGHmCW1Cz77SSqimH23x78amsLkSSBa43dvIWdzYRudkLq25Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYZAkO5iXpXeqIH9BshvyHkwFFqoc7iyerx0pjqYL/V/VU0jzm
	lIgr29rhTmLjGwO4QY2mxbMkEy/6BjMXoF9W3ZJE/p05zBthsslrNRhcqXtymMZmq+Y=
X-Gm-Gg: Acq92OGAGtFyNjXU8JGE5tLSQkb/P+CCjp9TBf9O9I0lQdR/WCrFKvg7M9eDPcy1a2j
	Wd/t5HgK4FN9Hdbh4uowRdzryK7AUwB9H5avNhk+v2HzqR/UQ9wc73piWTw+FRsxZgpInCKHCi3
	Gxzc695EjXslGEghGKY2QpSZ7+qTs4dY7HOTQjz5O6t7M6DWHmLk6cRTpk3jfsFAOGDpzfOnem8
	fAEzQ6wdg2NucAr0ZcH7O4q38tX5r/Fhw7SB6t61IlB4qD0EWEe8m7/DYCPVbXXP/osFu8czMXO
	GjtgtxOMWW9UJi4CKH7HxIAZB/YKFfe9Eg0rpdh6kwHHXrOSQSkHduLN6fH/X+5er6fgfkbVCVF
	wFqjJTjfFWcLRaK4nLU2kWgtFzy6LN6JxnLrnBsoWGRocKjh1smZ1nPirkSbbdFdCtErmjvf8vl
	+/jcAONJU2UrdjoClGahr42Lx5i+tZOMVtrqn1roQ4mk8u1tWzWKVFOKrvpHLLUu4=
X-Received: by 2002:a05:6102:c4a:b0:631:bcfa:39d2 with SMTP id ada2fe7eead31-6ea2c9c5657mr513734137.6.1780424038069;
        Tue, 02 Jun 2026 11:13:58 -0700 (PDT)
Received: from localhost.localdomain ([177.118.156.89])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-963abac87ffsm9305408241.7.2026.06.02.11.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jun 2026 11:13:57 -0700 (PDT)
From: Lucas Rabaquim <lucas.rabaquim@usp.br>
X-Google-Original-From: Lucas Rabaquim
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Lucas Rabaquim <lucas.rabaquim@usp.br>,
	Matheus Silveira <matheus.feitosa@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: tsl2591: remove unneeded tsl2591_compatible_als_persist_cycle()
Date: Tue,  2 Jun 2026 15:11:49 -0300
Message-ID: <20260602181211.48399-1-lucas.rabaquim@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lucas Rabaquim <lucas.rabaquim@usp.br>

The function was only used to verify if als_persist is a
TSL2591_PRST_ALS_INT_CYCLE_* value. However, before its call in
tsl2591_write_event_value(), the line
als_persist = tsl2591_persist_lit_to_cycle(period) is executed,
meaning that by the time tsl2591_compatible_als_persist_cycle()
is reached, als_persist is a TSL2591_PRST_ALS_INT_CYCLE_* value,
making the verification pointless.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Lucas Rabaquim <lucas.rabaquim@usp.br>
Co-developed-by: Matheus Silveira <matheus.feitosa@usp.br>
Signed-off-by: Matheus Silveira <matheus.feitosa@usp.br>
---
 drivers/iio/light/tsl2591.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 3ec823865ce2..39cb68abbbea 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -309,31 +309,6 @@ static int tsl2591_compatible_gain(struct tsl2591_chip *chip, const u8 als_gain)
 	}
 }
 
-static int tsl2591_compatible_als_persist_cycle(struct tsl2591_chip *chip,
-						const u32 als_persist)
-{
-	switch (als_persist) {
-	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
-	case TSL2591_PRST_ALS_INT_CYCLE_2:
-	case TSL2591_PRST_ALS_INT_CYCLE_3:
-	case TSL2591_PRST_ALS_INT_CYCLE_5:
-	case TSL2591_PRST_ALS_INT_CYCLE_10:
-	case TSL2591_PRST_ALS_INT_CYCLE_15:
-	case TSL2591_PRST_ALS_INT_CYCLE_20:
-	case TSL2591_PRST_ALS_INT_CYCLE_25:
-	case TSL2591_PRST_ALS_INT_CYCLE_30:
-	case TSL2591_PRST_ALS_INT_CYCLE_35:
-	case TSL2591_PRST_ALS_INT_CYCLE_40:
-	case TSL2591_PRST_ALS_INT_CYCLE_45:
-	case TSL2591_PRST_ALS_INT_CYCLE_50:
-	case TSL2591_PRST_ALS_INT_CYCLE_55:
-	case TSL2591_PRST_ALS_INT_CYCLE_60:
-		return 0;
-	default:
-		return -EINVAL;
-	}
-}
-
 static int tsl2591_check_als_valid(struct i2c_client *client)
 {
 	int ret;
@@ -915,10 +890,6 @@ static int tsl2591_write_event_value(struct iio_dev *indio_dev,
 			goto err_unlock;
 		}
 
-		ret = tsl2591_compatible_als_persist_cycle(chip, als_persist);
-		if (ret < 0)
-			goto err_unlock;
-
 		ret = tsl2591_set_als_persist_cycle(chip, als_persist);
 		if (ret < 0)
 			goto err_unlock;
-- 
2.47.3

