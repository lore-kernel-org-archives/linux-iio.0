Received: from mail-lf2-f13.google.com (mail-lf2-f13.google.com [74.125.229.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E68F493D4D
	for <linux-iio@vger.kernel.org>; Sat,  3 Oct 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.229.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791057025; cv=none; b=LHC5UGza5v06fv9udyNAJyFd66D+R3ZpZU/qG8jXGGJVEWLcj6/cQMbw6yb49MQaiKsX2RRjV7GtrvLhHAXeWLMcZPYyxz3zksaODPrT3gZ01icgnnXrf2q7eMKC+nDyFiPnXSa3atpC6IQj92MGVFmJ/83IrR7hVCcRcytVxK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791057025; c=relaxed/simple;
	bh=/4d9OigCORtvJ5aTr4LsAeb4hgeXIO/CJ8vO4HGEp18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RcArm1010uhLi+CPKGhL0a4hSdRPU3jHITA+OUUr//uxNLW5mh4Rm8ouFO20wTvyGCwpZz28bKF2o6BrKUaBBdFKt4D8ekp+p5AT5eR0k9NLcQUrMc25i8NM6Qm6UxXWVR+ed8Xjb++x1H9Q0GIBjFXANOpJ9mr1p7lZDoCoOfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T417T2tr; arc=none smtp.client-ip=74.125.229.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T417T2tr"
Received: by mail-lf2-f13.google.com with SMTP id 2adb3069b0e04-5ba418c79ccso299059e87.1
        for <linux-iio@vger.kernel.org>; Sat, 03 Oct 2026 12:50:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791057021; x=1791661821; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GJ/7i28s7Zko07cbEXOC8Ix74/xugwD/hhTUjA8RBs8=;
        b=T417T2trfy7rme67KASrYuQ1mgpSAEC6Wb7iEwkRpdJN7QI0bDnwvKxmSpBz8MqdKC
         sG1pbn/+JrIf+Cmv0jPoIOzwaCbRfK1ljhvBx3GUHlrix+96lul6U1WAX7OtJuSshfDV
         bBiWxaZ9sTxWGZz/vF3wRAdNVKbkV6AVxsadhaX89ilSPSr6JchlgZbNYCXBW/1/Pha0
         Oj5DMnLsArDAiM+2D35GCkyiFOOfR2w63kSbiR+wPUS11cderm52GZM50iuTjW2+WABd
         JdRauqxBEt+fH0XfCnIiO9n0PWOoJ20iPNfWbDOUgJU4OJI4C8xU4YSo1EzPn3wu4OyO
         gckA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791057021; x=1791661821;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GJ/7i28s7Zko07cbEXOC8Ix74/xugwD/hhTUjA8RBs8=;
        b=diYiuZAZvaFUFAdPl6wlYU3YU2jI9AhljEJzkpBe9zgsEzRIclfTluX1RllBW9/Ch/
         jqZK+2SqwrB4tRqz9BIQ2Caa+jooe+dQNnhP/gz8D/KLYfLxE7wHEC8TabGDixowtPTp
         Td8MvXXxKsdKKRSy4UWepp5UJkoZzfLiEcIsA5jCXzeLbl9FgVzyUCAgJ/IJmUkQqCNr
         1mUQHwGhXkmEvNzMvxCD+JArARPPZEAtWiWDuGv7jZp2hQMH63TDTOamPWd09/wDtx1D
         OZYrukoGgnAHhi3kqzdENlb4S9f8murWE8CqIey1yI6Lq+U5DVCWoRElnGkn9hZrVfJ0
         0fwg==
X-Gm-Message-State: AFq9FYLCOzDmUJ/MB+phPVyt6VQ82xUlfeST3P0PK8OZpke4w3fWe6Bu
	DH3xEmBizotMDioXBPczkIKP2kDGlnGr0OGJyvU5A0tuQ3AzkWvJkyRh
X-Gm-Gg: AYBFou3EtNmAIioPABWK/M2t9jbkTH6XYxcvMVAHluxzOcQAW0TYjUiW1tzg383pYBk
	l6QAFfBP6xT0Sbhr3ItrmCrbNUcd7aCwfiqhQFdp/yNubmW6XG+fkeETD9HtuITLwN4xxGUwyak
	K6XOIj75YyDe4/ITk/Swr4YI5/XImXjPgNVQMSaYZPejKvZ22nQdUh4YxkMJfFrmDTwCvWGLD4Y
	aCpv/nAB4S6srsLIekdYz+q4naaTMzDciH5iFL+ssJ8tAFwnHuZRREgg9tQHxGp88bq/N9SmiAW
	v4vmR392u1T7ba2OGy5XP8B0dnJhfv2m/ZJgoMu0BL90/xwEkwyka8CwG+iQTQUcWQsbBisHkLj
	AR2P0f8dKgJ6d6ufJe0vYVnFiR0RVYxp8cMZlJuSdki1gUnsWOzVqrkqeb4mlPvyNYMY/P/1yTz
	Oqf95pxs3ll/MH0ws0daGhJbnGHEZ4a2ZibVUnamiAzXOPsht1qVLtSQIA1UuWNIA2fMG1oR2Ez
	6pgDheD/3hyFKTnsE0Ze9vjbVylwEO80WQUNm0sy8EOMM5skuax2OkoiMIJeBkg972O0A==
X-Received: by 2002:ac2:4839:0:b0:5ba:3d7f:6ef9 with SMTP id 2adb3069b0e04-5bb9bc468damr1943914e87.48.1791057020991;
        Sat, 03 Oct 2026 12:50:20 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bb7c7abdbfsm1762608e87.65.2026.10.03.12.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 12:50:19 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v12 1/5] iio: pressure: dps310: use devm_mutex_init()
Date: Sat,  3 Oct 2026 22:50:07 +0300
Message-ID: <20261003195012.92948-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003195012.92948-1-zoone.rupert@gmail.com>
References: <20261003195012.92948-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Destroy the mutex on unbind so CONFIG_DEBUG_MUTEXES can check it.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Assisted-by: LLM
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 85df58ac1809..5c8af216ece4 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regmap.h>
 #include <linux/unaligned.h>
 
@@ -996,7 +997,10 @@ static int dps310_probe(struct i2c_client *client)
 
 	data = iio_priv(iio);
 	data->client = client;
-	mutex_init(&data->lock);
+
+	rc = devm_mutex_init(dev, &data->lock);
+	if (rc)
+		return rc;
 
 	iio->name = DPS310_DEV_NAME;
 	iio->channels = dps310_channels;
-- 
2.43.0

