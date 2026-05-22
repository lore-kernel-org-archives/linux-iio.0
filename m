Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0247839DBF1
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 12:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779453266; cv=none; b=hU/AvVZrwZS8A2fF3KL9NsIlb2PLbH4/nY6bTvTKMIZOYuNw8E1i9GnzSdUMgSI0XGjwgyvjKIMsYyW1PPz8yuQdlFD2DKtVvcCg60ENeErp46OxgyfJ3W4wYHBUWFMBcLCE4hniI/kjFt6Et28zMh7OY8QiQzr9JnctKARHtPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779453266; c=relaxed/simple;
	bh=i+te5LxeNXfjJjKfGqFDIuk1wWeRe58/ljtNFiAjvXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JZ93/SBFZg6qNVbqQmvZHNwGlG/NPV8KMKhrXe/5oNxcvqvvLhBtZuDM+vSTs57eDalqUDRje0ZgmBnguOcEFEUExZtuQ4DzzW/88OQQBdX2t9OMFYdmS5PsNg+GOo/pVAUbPs/J5O2eCdi5SBc6R1G9z3mfriQrOpudmpAhZq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tuj2fWvC; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tuj2fWvC"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-48e8132c6d0so46799115e9.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 05:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779453263; x=1780058063; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tlnYnPb7deSBfYn8dj/YiBzt8a6SjFibSLJrCP9deBQ=;
        b=Tuj2fWvCrblpDw6DzOn+JrtpsGHojLlJEgJ+9bdAJi/U0MW7d7+xQCgtS6jS9m4Iz5
         9H5s9Zw+lk7VB68yICT9dMoiCjhPtf7EtDM4kJhFi7mzCYlTQ/Hc/LEhMFwswQEKnyGT
         51OEGQcYMWhDrpcVLxPkhYo5pEedJWnscNESbcQlncoDrzGcaWhIpbL1I8m/Xxf7uABI
         BIDDaCvEBO6IcROMWSrOGQdsYMUy3iKxfipA2q7eS9wla8zHERhfSyl5CidSq73c6QwJ
         pApmSRXUwUliGCSkUFO6y4C2YloJl260lVVjLLrVov3C+uBb4vVqqdxCOL4QFt/eBu4H
         XbwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779453263; x=1780058063;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tlnYnPb7deSBfYn8dj/YiBzt8a6SjFibSLJrCP9deBQ=;
        b=Si8szGltqV633SmfvLfm42v/CMkRHSfaNngul0iDWj58tw4F5HAS5da7pWzTN8U8W/
         WRI0iHdFlTwGtr4ClQvXS6Mmbf58Ind6ybamktwSjkECQgbNhzJFIpjUyu3OLcVc2g5q
         0v6tIj5d/rJve6JP9cbCfujHjB769JU2CilnCiTzkvoeQiG8bAaBBwgSgt0f0vNLI7jc
         1iQRblcVTpvDPeh6N8hl3BIJV7d8R2KkskK2JZqq5XvOuvmi7vVwHlw7wL4JH/sFZ5Bp
         uZAN6HTQOpRVqLVbJTvlImt3cXQs7LtrsnAwZV2GJR2zVhh7qrqzRFTsgDK6yw9CLTpK
         f6gw==
X-Forwarded-Encrypted: i=1; AFNElJ8k20YzFr2Yibbq37fxhUexNyXanrHIqFu/Pdl7YAKfVlq2W0ZwWX4e72FsFu8oEcEDqAXeSuL3kSg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwBZKpolnjoBVyQaFyTfzbjV/saxkEYWMrlocwOGutuAi+O2o5z
	uylMHvcWdW9Bq7eahY3kVqIZv+me0XmxGwQBrPcrFnTh9ksDN7EmWc2X
X-Gm-Gg: Acq92OGtKjbS8JvcwvhQ/S426JNuZlxuULsirHa9FoGxZNe68lm9TEVrr5Kix5Z6dg0
	zSLlXcWwWGHw5EVZS8x2xm5ybTpL3pti5NRZptYFPQFN0YGSYCuIWR5a8rL+CkvZCcMABeDSwKH
	XokHCwvLrJ8Xh9SWq6tNbwxdAVQtb78AtqVtbx419roPcd8zkfADqARF8Bz/kqagb1wf8Qnn4VM
	DH9b06T9pB9sZVlpcsdF6vGkTJUkjyTivhX/P+1AVbnZc+PVRF/JaXRJcaUq6jXk9ADFgiYPm6i
	J7FqOaOwHvxEHKGoRe0U9aW+9Pf0BfYxEtnMUfu/vLLHg+uEURTpBi+ou910H6nM5a43jQJsJmF
	642M17nSIS8vgHCczdwzQvB+B3PFywBU1e+a4FgHVlTO0Zow2/YmE7LUs/cl2y5ihpr2cp/75Xy
	AACfaQ8mGEgM3GUpmCTtmQABX6dothtrhM/D1VJVFCflboXA/dZnK4KZ5a49n1Vf0=
X-Received: by 2002:a05:600c:4fd0:b0:48e:82b4:b54 with SMTP id 5b1f17b1804b1-490426d1ebbmr44443135e9.23.1779453263098;
        Fri, 22 May 2026 05:34:23 -0700 (PDT)
Received: from aldo-conte-t14.tailf68ad9.ts.net ([217.61.173.50])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49042af0ac1sm14760175e9.31.2026.05.22.05.34.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 05:34:22 -0700 (PDT)
From: Aldo Conte <aldocontelk@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	shuah@kernel.org,
	joshua.crofts1@gmail.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 2/8] iio: tcs3472: sort headers alphabetically
Date: Fri, 22 May 2026 14:34:13 +0200
Message-ID: <20260522123420.45495-3-aldocontelk@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260522123420.45495-1-aldocontelk@gmail.com>
References: <20260522123420.45495-1-aldocontelk@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the #include directives in alphabetical order in preparation for
adding new headers in upcoming patches.

No functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: Aldo Conte <aldocontelk@gmail.com>
---
v3:
- No changes.

 drivers/iio/light/tcs3472.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/tcs3472.c b/drivers/iio/light/tcs3472.c
index 849ca7885d71..1803bb882804 100644
--- a/drivers/iio/light/tcs3472.c
+++ b/drivers/iio/light/tcs3472.c
@@ -13,16 +13,16 @@
  * TODO: wait time
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
 #include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
 #include <linux/pm.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
 #include <linux/iio/trigger_consumer.h>
-#include <linux/iio/buffer.h>
 #include <linux/iio/triggered_buffer.h>
 
 #define TCS3472_DRV_NAME "tcs3472"
-- 
2.54.0

