Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B71E393DF3
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 02:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777344224; cv=none; b=g/Q1Hh+jwpCEdMLVAY3ZNj5I/A3Rc/CH8L+d/kH0/X0ZHummF4FVBDiy6WFzNIS3GSWkPcQgnVhMl7lydEN01hMC6PSJHkEBX8SG5su9GyGNp5X1iJb8ZaDPf6colwZoZiHjVCHrFvYqzHw0yaONDVh4Pek4GVBMPllF5MrSpQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777344224; c=relaxed/simple;
	bh=k2e7VzCTUG49XUMvFa0dmZR5x9BYszbrt+Orxcswq2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SbbU1mSVG3GIXVfwXzsbdlWSu+zK73fyzOTbMX3hO3YNlfeLhcKuS00qD3FC3XKDp5pTjxR1qzeO80c/WSwmc+QBJI+Xv0dPyTYwXyI6W3OJmYMWrjJH/uPkaRHTAyxwkF8cMYNfrxi1McgFteKFhaMZPUsN9lLC+b6GeODyUuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DpdANL5d; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DpdANL5d"
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-42321c8b8f5so8675861fac.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Apr 2026 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777344222; x=1777949022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T39vGluBL8JV264VDfxOvwuC8v7UKvv7R3Dcqwtq8fU=;
        b=DpdANL5dcvM9DzUe19EKsMX2cgVBQeZEdgoAvMpg106r7znLg0wFy/rVNMDMdbjchh
         EM9OmozNlzT4bLi59cdqyohtK5uCuZiHrp4eA8BkW6X5tBatxl8a2FWj2znFy2MRd1Pw
         7aF9wmOQ1CRGr0zs+CJs25TVzVEqhgwbHB3Dfwq+D3gD7JjkSFf+tgvFkbD19nnwYbBY
         KvtH4rIpPNazrWf8bHnlmfFKcufN1Km8CSMVM8kZFWPPvwkTEio1nHDz4N2xJqtX5k1c
         9WB3qVt4EcMPfkhytb4yJMGeqPjEbV7Vd8oSF14T0w7S4R3bYHVFH1DAmY6wvAy6mm/9
         /xzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777344222; x=1777949022;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=T39vGluBL8JV264VDfxOvwuC8v7UKvv7R3Dcqwtq8fU=;
        b=nIQmVHi55/yLiLcM3om7Q7pnNgQh7oOka8bzoNz/e/LZlCGHD4zC5sLGnej9wgprJp
         GTef14tMixGepz7lXmmXKX+L4hNUgf8gTf0Vukj/Vn7NqdMfFgEIR8tb6FPpVusgFFBy
         U47l4UairUA03YiXa6mpglyPwHr1UnszJnmjyHfXFAJc1epM3zo/NfYmlCvJt5o1w/tr
         HSO2wCKApCxiXPAW+DOfbLfSuel960JRzq/RYNIJjAV+y6/lKRThHc3eBeQSfCmy9yv2
         IKDUTRInAq3zmzisDQ+CuoUQWmyJ/ZEpNT1e9OyKYjbjmBVQA/foVjSmJLkFigLuDU1g
         jSfA==
X-Forwarded-Encrypted: i=1; AFNElJ+UEBJRnqlNkTCzbeLRDTXh97p+b4Ztht14jAY6/A7GnNXF5Vu/h469azY/TdsKr0J7j7D1BegLnT0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzD6ZWKFbFEGc8YXPv7CsQQV6xkdrbBVlJlzGBbnhlGIxps80VW
	F65vZe0ajCD6cD3+rOZU5VZqnn7FpFF7cY206Na7t3lIA9ipB2BF/SRvyi8VYg==
X-Gm-Gg: AeBDieu9EpAiIKYj24Wgst3xtR+Lix7PEtkslnKraQJ+7tZ4Fjh99x759i5eS0i/k+O
	R3CMx77T7nUD7eXXYCX3kJYr9+roYY/YUwXYOismh5XhR18l7gpVxnmxqU4w2HbhLI/HI2VbObY
	gj8FFvGf0azpo0Kc6ZWa7jkBO488uaWr2oLZcu2nKcaykmJnv0cDkXQqkZW5qMNbxmc7ziXzgTo
	+ohhq7etymmbnU4WlYfPyN+4JNk8WQum+0nyqUIkn8w9X0my0m9EGDnYJFhHj6YOJRIW7XcIWnZ
	qtXffWyjzncbndeSYiU5+1C1a9xsYCFtmsgyF4rHSEnsOAAAnTv0W5dahVCoVs2NgzNfLhr40fu
	Ek8BmwDx9iJSUzbgy66x9IG9c3r6gMNpY7YaQS23NkPFayrzztaGom4QurtaYQ7JyByEXdtBnQO
	P29NV+b+xr8OYIUDb8gzj81qJ5p64HjDusPyZjYl4Sqx/jZE/WCrpkdQ3SRlX1Ww4URkON
X-Received: by 2002:a05:6870:1754:b0:423:1cc1:f878 with SMTP id 586e51a60fabf-433f187b172mr665399fac.29.1777344222230;
        Mon, 27 Apr 2026 19:43:42 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-433efb816e4sm958392fac.1.2026.04.27.19.43.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 19:43:41 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/4] iio: magnetometer: rm3100: Use scoped_guard() in rm3100_read_mag()
Date: Mon, 27 Apr 2026 21:43:36 -0500
Message-ID: <20260428024339.45109-2-m32285159@gmail.com>
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

Replace mutex_lock() and mutex_unlock() calls in rm3100_read_mag() with
the more modern scoped_guard(). This will help modernize the driver and
bring it up-to-date with modern available macros/functions.

While at it, remove the now unnecessary "unlock_return" goto and
directly return in if statements.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/magnetometer/rm3100-core.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 2b2884425746..a2bf6e504a15 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -204,27 +204,23 @@ static int rm3100_read_mag(struct rm3100_data *data, int idx, int *val)
 	u8 buffer[3];
 	int ret;
 
-	mutex_lock(&data->lock);
-	ret = regmap_write(regmap, RM3100_REG_POLL, BIT(4 + idx));
-	if (ret < 0)
-		goto unlock_return;
+	scoped_guard(mutex, &data->lock) {
+		ret = regmap_write(regmap, RM3100_REG_POLL, BIT(4 + idx));
+		if (ret < 0)
+			return ret;
 
-	ret = rm3100_wait_measurement(data);
-	if (ret < 0)
-		goto unlock_return;
+		ret = rm3100_wait_measurement(data);
+		if (ret < 0)
+			return ret;
 
-	ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
-	if (ret < 0)
-		goto unlock_return;
-	mutex_unlock(&data->lock);
+		ret = regmap_bulk_read(regmap, RM3100_REG_MX2 + 3 * idx, buffer, 3);
+		if (ret < 0)
+			return ret;
+	}
 
 	*val = sign_extend32(get_unaligned_be24(&buffer[0]), 23);
 
 	return IIO_VAL_INT;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 #define RM3100_CHANNEL(axis, idx)					\
-- 
2.53.0

