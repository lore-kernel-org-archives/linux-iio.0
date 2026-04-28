Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 597E239FCB9
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344230; cv=none; b=uvwX62hMryuksYprfCZ333pnMM3Y6zs5CtQmrjLBlp1JKJl99tqfO43Om5vFBak1D6V3WhFrRkWn8fvEhyzxLnA4T/R80URm8+Uw3yDdjEiRHgX5+5l5WhTaJknLIhA9zvuttKXYtEz1MHQ5peCo4n5QrbHBc+bxs5o8P1Xgz7w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344230; c=relaxed/simple;
	bh=ogCmYkSPTvppIJTAZFH2UnNd6CEoSm+Sh+akJK6+6uY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cOPWVvSY1+cWq0VrqcMHbz6c8WAU8iHtjhlIhlMy9Sz54FPAxrNvMhDV4zCrKrm7cuKwDpTw6sgLvSLx5BdwnkS1ps/imi94Tcuav+7VA8GppdzHZNTWUgBbUAIo5xKRurIXUWNF8M4SqgMzi5kP4h7f3eE+oF0ghb0Rar/lE5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awzoGW5S; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awzoGW5S"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-4303eb92930so1304959fac.3
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 19:43:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777344226; x=1777949026; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x9It474Q5BR2Rp1VOLDO7IGUOc7gU71s1Xr0iQWEeRI=;
        b=awzoGW5S8VVvo+LbJzSrfOpcV/80H/rGb2B5y9l9nwih/aMrW3rOcwrmWUfqr5jPds
         E0KkUXEfAn7MCUbEpoxZkHoYvkI2/iNbsQUWmYKAE3jLFmufBVe3o9czapi+iVJXuAXX
         fFyRV4GlYGZfjzNCWGCGF4EfCvgsfB9SiTO4sNb6TyyzuE+eY8RCUfJFOhIS7dwwyG9A
         X4sYTrxk+x3I8fy2y6pLJDxB63a2VmVJzARbbHTx3vcG4I9vgFrvZfg+FO38wYI/F7jF
         A5Pr3BJ7dqgtAik5Dj4ViWfjsp9H1pzZt3kq6cdwMroWkVvsEAZEItu/f3T0XUOZO5LK
         oKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344226; x=1777949026;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x9It474Q5BR2Rp1VOLDO7IGUOc7gU71s1Xr0iQWEeRI=;
        b=poKa6k4clVRrFdQI2ZASW9I8rW60FpjjNyZ8ODI5X8EA2/UFiYcO6CAGq472NdOaJ8
         yOMMp+10YTIz2LE6NRGX45atNbHA7HpudQkxl8otDsooBDxBfkrRflTGbwq8Su6zXMI0
         hETLnrIPyT8pTCMg6/dgambr5CaU7Bg9N+ELpxJWqDllMa8FRfewn2szAsAvCfr282kO
         YsMKIlMZSTa/bZwLw/ZRFttSVk+sPch0RLo6o/UstGH+7BaqMntDR4N2h8TCpU5a075a
         shMf8xeFqa5Qoo0s85vakO29PsYlIylGM/tDCSZGdsYkIjftTu+Jv6qA9JoW6UXlKNCB
         5LsA==
X-Forwarded-Encrypted: i=1; AFNElJ+IfRyPLxK35/VM3KAL9A7EWUvGayh2Fcd2Mu9s70zi2MKGr6ChE4e22ijBZzWrd7Gu0SppzNuxU/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YyMTe5hdDI45D19PCX4+zvnxqIuArh3DPwB4YVMYKQZGCCBn/83
	fJhSzCLKsSN3aCTX8nDhmSCxKwYrhip4ppHg7zliEiq8fj7X8e9AMkzz
X-Gm-Gg: AeBDies3CjxL5Qjj+V8Dom2vbX+F31CzkAboWkDYyXn73gXTpYEviJ11JYv0xP6qiek
	WfezpWrMCiGl3qtBw2ntb8fUYPTZXKl/dSuB4H2h8lmsu7LtRWMJuWuGm/FFmKIPeA/xSgf532D
	YL/DugJy5ULTb1wFaI4zCugDDbc++Uwl2Psm9Z/ULRGEmIPx/K89S4C7nijbZwOsY7p315Kfa96
	f9+XG03OtGBT46dRTNVuSAS4yeVNCBGVBVk1FLj/wn/8AOR/u0wDmd/fGVTsXTwqp6QAQTzneVM
	VJjM96rlf6PkSKKUrB54IbVREpRP0LdgPH0BwRQW88MN5K8wFIemZkx1w5drJhhp+Ij0Q4OF+Ta
	MSs49vLqGag/GQO1N9DWfSAeArXa41u6iorPNObxmqKeFgmUlaohXRTiNA+w0tc6kZIcY6NcQP0
	KNFwrh6rSO11+9PbjQ357/ZHG+zpUen2T+kIzTkPOjh1zrKdy2h0TYbEeKl+xiqaOHcwIh
X-Received: by 2002:a05:6870:14d0:b0:41c:a61:b612 with SMTP id 586e51a60fabf-433f385a6cbmr553741fac.1.1777344226281;
        Mon, 27 Apr 2026 19:43:46 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efb816e4sm958392fac.1.2026.04.27.19.43.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:43:45 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] iio: magnetometer: rm3100: Use scoped_guard in rm3100_trigger_handler()
Date: Mon, 27 Apr 2026 21:43:39 -0500
Message-ID: <20260428024339.45109-5-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428024339.45109-1-m32285159@gmail.com>
References: <20260428024339.45109-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in
rm3100_trigger_handler() with the more modern scoped_guard(). This will
help modernize the driver and bring it up-to-date with modern available
macros/functions.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 72 ++++++++++++--------------
 1 file changed, 33 insertions(+), 39 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index a2c3448e296c..f55796e3ebef 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -457,48 +457,42 @@ static irqreturn_t rm3100_trigger_handler(int irq, void *p)
 	struct regmap *regmap = data->regmap;
 	int ret, i, bit;
 
-	mutex_lock(&data->lock);
-	switch (scan_mask) {
-	case BIT(0) | BIT(1) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
-		if (ret < 0)
-			goto done;
-		/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
-		for (i = 2; i > 0; i--)
-			memmove(data->buffer + i * 4, data->buffer + i * 3, 3);
-		break;
-	case BIT(0) | BIT(1):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
-		mutex_unlock(&data->lock);
-		if (ret < 0)
-			goto done;
-		memmove(data->buffer + 4, data->buffer + 3, 3);
-		break;
-	case BIT(1) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
-		mutex_unlock(&data->lock);
-		if (ret < 0)
-			goto done;
-		memmove(data->buffer + 4, data->buffer + 3, 3);
-		break;
-	case BIT(0) | BIT(2):
-		ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
-		mutex_unlock(&data->lock);
-		if (ret < 0)
-			goto done;
-		memmove(data->buffer + 4, data->buffer + 6, 3);
-		break;
-	default:
-		for_each_set_bit(bit, &scan_mask, mask_len) {
-			ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
-					       data->buffer, 3);
-			if (ret < 0) {
-				mutex_unlock(&data->lock);
+	scoped_guard(mutex, &data->lock) {
+		switch (scan_mask) {
+		case BIT(0) | BIT(1) | BIT(2):
+			ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
+			if (ret < 0)
+				goto done;
+			/* Convert XXXYYYZZZxxx to XXXxYYYxZZZx. x for paddings. */
+			for (i = 2; i > 0; i--)
+				memmove(data->buffer + i * 4, data->buffer + i * 3, 3);
+			break;
+		case BIT(0) | BIT(1):
+			ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 6);
+			if (ret < 0)
+				goto done;
+			memmove(data->buffer + 4, data->buffer + 3, 3);
+			break;
+		case BIT(1) | BIT(2):
+			ret = regmap_bulk_read(regmap, RM3100_REG_MY2, data->buffer, 6);
+			if (ret < 0)
 				goto done;
+			memmove(data->buffer + 4, data->buffer + 3, 3);
+			break;
+		case BIT(0) | BIT(2):
+			ret = regmap_bulk_read(regmap, RM3100_REG_MX2, data->buffer, 9);
+			if (ret < 0)
+				goto done;
+			memmove(data->buffer + 4, data->buffer + 6, 3);
+			break;
+		default:
+			for_each_set_bit(bit, &scan_mask, mask_len) {
+				ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * bit,
+						       data->buffer, 3);
+				if (ret < 0)
+					goto done;
 			}
 		}
-		mutex_unlock(&data->lock);
 	}
 	/*
 	 * Always using the same buffer so that we wouldn't need to set the
-- 
2.53.0

