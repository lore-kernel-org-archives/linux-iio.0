Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8537F426ED3
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 12:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777380416; cv=none; b=ALeQSfENFpfzKR4DQEXi2Xp6WCP0RzWKGEmVCEVP9izIOaqwuwJmgLWyIlMi2H89uGuv6hRUzQr3+TQe++hQ+1UfAR+qENNgq/P5MB2QrdUgFICR2hx/Ume3n6I2eNHhQfCy/8tdUwWMJxWMah9S9PTh9ihiPPpTQknAdfHDjl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777380416; c=relaxed/simple;
	bh=EyyOQuWL6/GefVd19dOAwzBViaoRhCHSwxojmabHjZY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=izowagm7uIMnpTGlC1MYxW9+GlpXirLirTZCkMXUi+bOU2oUsteeKtAXfnK6bkApIhiLtRxSQMv8vQUMFGdfl6PQyIPgswOa3moXFu0nla7qwGzH2AuWfBiyNY2N1gE1HJ0pO+p1qet4mShM7Cjc9xxDnVHcU48hmyW8iKxIB+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TJWoqtlm; arc=none smtp.client-ip=209.85.210.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TJWoqtlm"
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-7de7dc85b74so1847758a34.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 05:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777380409; x=1777985209; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lDMsfTF1mWpHEAoyQjrrWliccNJ00PHaO0ADCiBzBGY=;
        b=TJWoqtlmyl+HBC+78frwihExPUXMdrqLStbu+XIkyqp1ji15KQ53Wymw6Jh6HsLIoj
         RTBPSrO7xCz3jDkqRSa71zo/BoMWAWdXZvfp2nRyOfLCI4MYxi6u4qj8UHNMGKJ56cPu
         2hpGotKRBFYatdpLJ95bGOCUK55U1U7fYItSiTbZSQlE/oiruETej/hshI4ysHkxQog3
         nZ4WbY2PQwgKbWpgOnMNQUazaWcIOg8q4ngsob4lXY/sTObgfgMnssas0ky2wjQyhd22
         F4NU+sCygWwBrrKFHUYAuuFBcQtQXyZa7H8a+j0RE0leBAW9s1AnWFSjBdIsONgr8ld0
         tUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777380409; x=1777985209;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lDMsfTF1mWpHEAoyQjrrWliccNJ00PHaO0ADCiBzBGY=;
        b=O2WUQBAS2m5spNhxrNLq3Dj+6YvqAgWnt0jt9zNQZHPeJ+MQQxFjYWXB68D/GEn717
         sTZdD2ysBWemCrXk0gGvhQhpFdA+kNk00GuflLGe5Wdx/+RfdWJ849qt99Tx0TU7sdoa
         QNYahMzaSJL2wwzky20VEEcW0SDQMqHK3up5jSnwOB03V2nEHWKmkkCts998uekput4n
         X6uwOVT4lVYIDddyNLfdGJi8Pf+Vl0+ze3cexogOJP7QZD9iiOt3MjaksnolCB4cXuiR
         FS6wHDz+v75UKQ2GCteDDQQphbsPGMivGQghRmG3PWybxDT1EO749jjTiyN3EZ5RKCWe
         KtNg==
X-Forwarded-Encrypted: i=1; AFNElJ/V8fRLqLm8KKxaDiqasnP2mn7xQ9FcD1iDypVrmqYGdw7HzrRfK8WtUo+vQJhBDukR9HsfYxsYh9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+ka9tiQydXkzNnzrJsGHtNfQXcaxzrWoVPenWrcoCTmyfyxQx
	D+sFAEK0eA6sMumhge3Jl27ifGBWMOwg0cvXOERNFPhjXk4QPLxBxo6U
X-Gm-Gg: AeBDieuQ2Rqoi1t+i/uPVY4c0PHAzJGw15qXHn/qARglfwTNQgfBtiO1qBqLCTlWDw/
	jMIGyags8m5xrtubKPuW+hKmkNgfD2sjOWOsWxidL9zTtuic23EnWF30zrbZ5swzM7sxSW1y1ZT
	KTeMzPdsiUtU3V6tcP8k2eEOfzdQOo6mAyjMijHYP8wBZOunaxHIwGN/cZJakN2ehmiYEkI9X8B
	mvjMDLYeg12rsJuTktT4GCbzf+fiRzAbwfLa/wNgLF+5UB6Q2ehilhk0Ef1zZuzN5qqOzjgVUEp
	B9GJsfOvHUGkzQfPyMrcymHhkBSKcvfnl1QnhysUVnDezK15DOsNtU+vi702rjVTpomHOfTYeKE
	Iw/gQ8GBNcU8OYgSA6NAQO5IO+Qz9ZEs4SPXp/oA7FoPHiHscyoZxLLPwg2xqzlgJs9babbSMq0
	fSe5GK5XHBBbijyBIklSrF1VtqbBhE6VOAdHzIuu4ZwmIRP4TRnZ7KaEqnKRjfAp9Toqft
X-Received: by 2002:a05:6830:6d05:b0:7dd:e032:3cdd with SMTP id 46e09a7af769-7de9a0b6146mr1653737a34.18.1777380409478;
        Tue, 28 Apr 2026 05:46:49 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7de986a5601sm1683041a34.19.2026.04.28.05.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 05:46:49 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: songqiang1304521@gmail.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iio: magnetometer: rm3100: Use guard(mutex)() in rm3100_set_samp_freq()
Date: Tue, 28 Apr 2026 07:46:43 -0500
Message-ID: <20260428124644.49707-4-m32285159@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260428124644.49707-1-m32285159@gmail.com>
References: <20260428124644.49707-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace mutex_lock() and mutex_unlock() calls in rm3100_set_samp_freq
with the more modern guard(mutex)(). This will help modernize the
driver and bring it up-to-date with modern available macros/functions.

While at it, remove unlock_return goto and use direct returns instead.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
v2:
 - Added blank line below guard(mutex)() per Andy.

 drivers/iio/magnetometer/rm3100-core.c | 26 ++++++++++----------------
 1 file changed, 10 insertions(+), 16 deletions(-)

diff --git a/drivers/iio/magnetometer/rm3100-core.c b/drivers/iio/magnetometer/rm3100-core.c
index 9f25efb2d02d..eb59ea8d5bf5 100644
--- a/drivers/iio/magnetometer/rm3100-core.c
+++ b/drivers/iio/magnetometer/rm3100-core.c
@@ -335,56 +335,50 @@ static int rm3100_set_samp_freq(struct iio_dev *indio_dev, int val, int val2)
 	int ret;
 	int i;
 
-	mutex_lock(&data->lock);
+	guard(mutex)(&data->lock);
+
 	/* All cycle count registers use the same value. */
 	ret = regmap_read(regmap, RM3100_REG_CC_X, &cycle_count);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	for (i = 0; i < RM3100_SAMP_NUM; i++) {
 		if (val == rm3100_samp_rates[i][0] &&
 		    val2 == rm3100_samp_rates[i][1])
 			break;
 	}
-	if (i == RM3100_SAMP_NUM) {
-		ret = -EINVAL;
-		goto unlock_return;
-	}
+	if (i == RM3100_SAMP_NUM)
+		return -EINVAL;
 
 	ret = regmap_write(regmap, RM3100_REG_TMRC, i + RM3100_TMRC_OFFSET);
 	if (ret < 0)
-		goto unlock_return;
+		return ret;
 
 	/* Checking if cycle count registers need changing. */
 	if (val == 600 && cycle_count == 200) {
 		ret = rm3100_set_cycle_count(data, 100);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	} else if (val != 600 && cycle_count == 100) {
 		ret = rm3100_set_cycle_count(data, 200);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
 
 	if (iio_buffer_enabled(indio_dev)) {
 		/* Writing TMRC registers requires CMM reset. */
 		ret = regmap_write(regmap, RM3100_REG_CMM, 0);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 		ret = regmap_write(data->regmap, RM3100_REG_CMM,
 			(*indio_dev->active_scan_mask & 0x7) <<
 			RM3100_CMM_AXIS_SHIFT | RM3100_CMM_START);
 		if (ret < 0)
-			goto unlock_return;
+			return ret;
 	}
-	mutex_unlock(&data->lock);
 
 	data->conversion_time = rm3100_samp_rates[i][2] * 2;
 	return 0;
-
-unlock_return:
-	mutex_unlock(&data->lock);
-	return ret;
 }
 
 static int rm3100_read_raw(struct iio_dev *indio_dev,
-- 
2.53.0

