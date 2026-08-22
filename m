Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42263ACA58
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385830; cv=none; b=EdmMR4IA0qPqGwYZ0WDSfBcznrKvZz6xfJYNM4JQxMkBcLkvp8IHJ+9ERrx8eRkNo+ULsKv3G3OVEapNRq08i58AKYwwY1HUNqOJxCNSvRahGUFT6IOCXNdyzm7FE5CHtK4Cuvb+mXXwwxxOEUTp5HMkgZ8/l/zp7e39a30S4yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385830; c=relaxed/simple;
	bh=8NR/WlE9E0GCwHS3ToDlwOTNuK9Ali2qSyD+jxMyW7A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=WHk3ss73og47wmJo1/EdOccfo+wiVpBpCKZG2E1ANYDlgMukM0EaollExyvUb7S7VvouLn2BfHTW4ksO0NuDQuqUzirqmcGu6VUHSu6gx0ff15c06RkHx23Impo5J7Dg4UAitMT1Kpm5R+z237uhZ92mTWj0S3lAT+CDYghp9r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThS2EHIT; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThS2EHIT"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso3288604a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385827; x=1787990627; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KK+F3fCpYGk5HF9gH1Eee/5AW8UfgQ2wuP9pAS1oP1s=;
        b=ThS2EHITBU5zAFQtIfMnZAVNRbFsnCZlD2RoOPCkLH5M1tPJChhqI2rndJYynOEAt4
         7HZGcXv+yvSvDVB/0GlxcqvfV6hXqpEVQsO1KRVtd2ETYmSNVCVusAKssCbLbx793O5d
         /WexjLJtzQpK9/8O87ZYz2z4xyONZZa37yMo3nK6ZntfG4LiCSH/4/DX4thF8cTXAtP9
         /HS4bPpE2K6ot8OkgttF+YNbCaiYBWZjHkFfA03lpBRk3opjXx4An01s45wucGKuobuC
         3M5ggj0vXgCkRv8LmaxRbCJ7f3tm0Bl7aSWncSAwKwhgHSt9J2eOFV/3sgQufJK7xEHS
         TmDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385827; x=1787990627;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=KK+F3fCpYGk5HF9gH1Eee/5AW8UfgQ2wuP9pAS1oP1s=;
        b=aVLCq8e4/trynwmA1s/vgMLghrippKYQLjjM1BphKUlUnuJlqGJgQrrQFZV6nOK9hG
         Cs6jqdELaySI4RZKYK6gMzGrVzOTBceHYFyGTftqC22958lMhEdgxEwnnaW6a7R6kFz6
         e8fzIWsoFiRqvGZrMOblKhXhBvghHpQuxcYSRr+S9MJ97d9VuHuneFaLiqW/VhVNQ6DU
         z8Va3nLg+0z9VuPC6zRN1jSTG3/FbOF8snw6eqaP7ZTpUkQ2MP5Rur0Lyr/S/gXxbPoi
         TCo7b1+6V34m52z+w6mhzjSiDR6bL9EjyvHe1C7pukoIBPc4oS9FgKern8GfrK64FpEQ
         DGjQ==
X-Gm-Message-State: AFuF++lcjraPAotuaNnCO5FaYp14Um6jH5y/As329g/UKiWheSjYr4/s
	PD53HfFueN6sL6gokeq9h8h0htGnA6LzakTn+MBTaxdYoeHc2dd8PpzR
X-Gm-Gg: AR+sD13cTzmouSa3H51WLc/VYizP/yvNm6AcZeG99AriA5bj4YEWHzNS9NNuZYohpIT
	74mcPfKGQu6HUoKmm0HYsxFo79ag6rtTXnFvxpRx4074HCDJnRjpK9Jl87Lwm6/kc8FVFwVdgWz
	UXEDf4RF3QqUd4koJigWtQMNhRy76J2d6oYj8DZbPHvahHaUDgBU584DhMNwTSZF2sV3u0V5nVx
	h72G4UojiKbqwoCsk1lcTKCBc4gGpr0DicWMlFEZpf8pB7CR0/b0dVLYsG3X+sssxhUB5rxWMhK
	7JY8M75dO0ILIL5FW9I9doYxBw9O/Iq6XndPFYR3hIJZLqJ8JFRGUmO8XPr9NXusTxTwh7cDdKJ
	gmeV1vXAfueCYE4uy+meEG6HAWk/LLFPpv8V7XgL4GUK3VEEXahhy7Fq4WvspP0UCxpbzOBCFE/
	08v7FVZfzm8WnlIW1jrCWkmHGcXuXoX2Lwi2EitMbmw4qr/fzzBgjC46WqUU5Kv1jXuIyD+wtyK
	cuoPMi9WBAMWEGDYyG+K/MwMNtyHGpnKQ8p+/5NXXnxAJZlQiN1N+rDgENCh5/1EZFSQd+RtbXN
	nNmOuYizoyxX/fMxfJtayOle/EvFIt8Jw8DfN/iYoY6FygTye4jCN6fJvGM/lboLrfmD/s87k2P
	vMbPw7Rn2hB8ff9giXPbj+6Rs
X-Received: by 2002:a05:6402:5049:b0:6a3:f63a:4997 with SMTP id 4fb4d7f45d1cf-6a582af9535mr4709500a12.3.1787385826893;
        Sat, 22 Aug 2026 01:03:46 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:46 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:29 +0200
Subject: [PATCH 02/14] iio: temperature: iqs620at-temp: make headers
 conform to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-2-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1223;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=8NR/WlE9E0GCwHS3ToDlwOTNuK9Ali2qSyD+jxMyW7A=;
 b=+er+2idqASc2yuWKUGgYnhinum0nYMWdEJyDNL3nubYndU1DrwtZbIxcTSaZ78/nHFtlhGVgj
 5tRWI+9VUlOCoEZKRZgniVOCGV4UJXKT7bvXH8o6P58Tgi/JIuBOo8K
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <asm/byteorder.h>: for endianness helpers
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/iqs620at-temp.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/iqs620at-temp.c b/drivers/iio/temperature/iqs620at-temp.c
index 24b4d50740f3..3a3b1f256585 100644
--- a/drivers/iio/temperature/iqs620at-temp.c
+++ b/drivers/iio/temperature/iqs620at-temp.c
@@ -5,12 +5,16 @@
  * Copyright (C) 2019 Jeff LaBundy <jeff@labundy.com>
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
 #include <linux/mfd/iqs62x.h>
 #include <linux/module.h>
 #include <linux/platform_device.h>
 #include <linux/regmap.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

