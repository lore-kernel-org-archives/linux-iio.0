Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880F23B0598
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385846; cv=none; b=q/75C+aZYmzziv7WKZg0G5msY9DNZsoU2kCS6zkTI6K+Oap16L8yW6sMEzbPWb8bhdLbVzs85ksZHDCgkicUlGwWQtxUvmCXO+yO8LorPYrHmQn33r3Z8/8Vv3p58lLinQ+KAdGGoHWHGCFmjx1k3A7fS81DWXq8rNqmhzdosGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385846; c=relaxed/simple;
	bh=7tTh2fPf7iFeO3U8BlBb/3ta4cj+9ajJrFCl40iRRrM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rP2iNAmFr5WaxQPavlY07biI9r2niZJ21pLZ2XpuqlPIYqEGqD0q2FqoibrqFr56LQu6fH2IEhceDUMUDu0F7l2l4UzQqPvJw6YGwAyxtoArTGnn8GLnKe3zBs13alaKI/8JIFnz6Kl8t1ShiMiVQLDsNjuqXi0xYjjVXpIfc+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aDnHjKLY; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aDnHjKLY"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6a38098734bso3273994a12.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385838; x=1787990638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hqSRpmeDyEjld1I49lUFsvTYIFVUbcFLBMBEzk6FHJU=;
        b=aDnHjKLYJyMGBUUvm5TYe3QKi3ZomiQGIzAIrg++ekwkiCtsTMGgEpWLi38dTyY76n
         N4dYt12A6rFvUJpo9trbp9eIuzgqeMmFcla3xk/Wi8grtw53UzPit6fXAHP15d9fSJGC
         O7k3e9Y/4Xgtm7AEYRlbSl+hTxZpRchU6CluKr4xhtkdCdhceA+tQKqj2JqjEf06T/5i
         YWriNWZw5RnL5IZ7vNRX8w6yKyblqoJPxBJParHE1hzoDNNc++wfhaTfnBRwBP9riFRu
         i2aBxvFdI1L0u/L99a5DXNykhQlpp9QfnECA/HnXDQ7UbIIoFj0KI50Ox4nIAabLRaJv
         mZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385838; x=1787990638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hqSRpmeDyEjld1I49lUFsvTYIFVUbcFLBMBEzk6FHJU=;
        b=akJN1xad9E6RvseJ22zGCJxTCYXjkHIlsCf0zeHQonqgOb/ElPdv1rnxVYKvoczZQ3
         qk8rIVesYvaBhbscA9ukKkCLnODrSIqbdkpmyQL5apsc5f+eGMeZu7aKAAI2+5yOQrbU
         mP+4OWd6M7vt+pj0yw+4AcahxbJK0jnMwNlj3zpzA74LEa4OHiPzVSbZVWw7IZW9WPQR
         LQYvbxgIxUAOq5dUEW2/BaZHembuMvy0F38IdxG40ZChBTEQQn0hJB8jn0kZFnwQtNq2
         T8rJnd2OV70OcLyZQAs1ol7tt/wOrp07HwsKQJVYY1ntTR8CDJsIkXg0Oykkpz9Que2p
         6jiA==
X-Gm-Message-State: AFuF++lztSajus4uyC6izYZlFOt+kP57QSWo1kviDUC9/FMXkuKNzd7K
	ZnzgSZuBKpvcV9kehsTYJ1vNxyWBSp7pVUv96gGMJQWot9/qJJ8C2gT7
X-Gm-Gg: AR+sD12mqvi1SWrEVrCQ4qa0M5/0dIXsuHtNzOc6zNp3U24Rei7iNkYRuaCZizxljeD
	wxmPYigv+rO9vKLa9jBgD8y/2rbcuooIngS+8hCiH4izI8RLso0I/4Bkqrkx/7jCvCv7o1KG7hh
	crbUrpyezaOozTdg27HiNqRkosS+o1cDSaOOXbMHf12IvSPGuY6ZYjFz2yKYUcNszb1xHzmNt5c
	wvu2GWZAxXtDXEpyE9pa0okOMNHLjEiGZxpAWBLi/140Xy8/k+F5KIrdkDmMwyeZOQTuWLCofQJ
	w61EI47vE2vZebJnesxPGnZJoboP2+Ep5YtgHmpjavkr7k7D6loHyFJ5QN2Tzf70ZwzL5ayCz+s
	bRQ4+7tbmNUhSmC/NAI26F0Kr4ysW9LbkkaASV9dhixbKpHA8E9rMlz/rO5GPlZSpEDUm/oPV38
	0UUaBvI330RT5aIEJ26FFpK1Iad/2OF/yggn4u3TMsV3NFCoQV5NrlbgsCdJYmyPh0Vz/vy4jQ2
	nJ570ZaTRzLyB5tC6fgf0FvqwTedRwL9yuC4sJZCk5u+8OucxvW+0v08qjJUf28jC9MFXlhAZIN
	Vz/4LLDhMYNRByJoxFkA9HWqmH9rn6VvtcCoyxqohlN+5MzqNGVqGewK4sfJez80V+Zi5LvMUKz
	EPhjqPTQM8hF0b83dLrfbvVJo
X-Received: by 2002:a05:6402:43c5:b0:6a3:8652:a373 with SMTP id 4fb4d7f45d1cf-6a42f184819mr13588325a12.3.1787385837730;
        Sat, 22 Aug 2026 01:03:57 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:57 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:41 +0200
Subject: [PATCH 14/14] iio: temperature: tsys02d: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-14-ee31b124be11@gmail.com>
References: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
In-Reply-To: <20260822-kernel-header-removal-v1-0-ee31b124be11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1477;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=7tTh2fPf7iFeO3U8BlBb/3ta4cj+9ajJrFCl40iRRrM=;
 b=SMv2Ka/BQoFvmpaTBEd9YhfaVeZhEsULXS6EaqVqRNiBgqmjE/Z/6TGzQZW0TfhK/IEmlTxYP
 5JWMTuwLi7TBL6lofkrA5jPEkQge7Ygb4bZSAH0fKlj5igh0VOjHRvO
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header, add missing headers and remove
unused headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
- <linux/i2c.h>: for i2c_client and i2c_device_id
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/device.h>: not directly used in this driver
- <linux/init.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/tsys02d.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 377e27b45fdd..9fa803bec92c 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,11 +10,14 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/stat.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

