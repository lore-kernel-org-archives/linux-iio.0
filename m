Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D87DE3A5E98
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210832; cv=none; b=ND/Bv6KmovJoQFphzr4r9G7B5OSoZzHXq+9gqr8U5zRxxJ+rw1gv2AjUo9aHqMeg4QwY4ebtx0k4goquJo4osgimUtK7vAVPa7Up6EtH4j7Y2O38J3AmX9ZmHedfLrbY80aALH30ta+PdarXlvmIf24yvgSZ8Z0WDl5PFjegCyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210832; c=relaxed/simple;
	bh=5XLKjOzOTRwerZYjWQlSm0V6kefuJzxf5B3r7vswQh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cM8CJsmugku4K833hNPFM0puKoUe3eivKcF2UkrHE08szEd5dGQwM5TGDi/3VCRcGC6YKQqXMfEEfRVvgkFPc4dqpOBNDNzZ0XvQrO8bs3+GIUa5TeWKXs7foKc/OB3MOwpUwdRK7ykWt8Of1PBQ5+KdyUpJgPQ2S8Gw+rxu2dI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7Hcywt8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7Hcywt8"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0eab380eso3702925e9.0
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210829; x=1788815629; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l08v+DWhMTTHzUO00k+LB67tdNqKonKDnz7vF0UlhQU=;
        b=B7Hcywt8xoHVksyPKHAo0XMxL/hmvs/sweidDBMA3A1/x8JQY5LtSCf9ElRTBy0Vyy
         ML33WBaiD0amh5BBAWrMo9Xo1eBhvUWBD7Ka9LBUDIk4HejYkboF+5cZjFj7YeO4AWck
         0881gMKGUOX0B2NtEltXBy7/dCHgzf3jD2/ebJ7sTy9UzkxTQDa1pP3W9uh1805ZNh8c
         uX7YoL/C1rciho2B05B1jR5e9hkP1JmGWQAyvInAOuZAZxF5EdGnbLhFLtiCswBHeXdP
         bLYGjKjAYt01ct8QRHvnhjPv0OdvWJkQlPIW1DYxxkXE4l0oFeSKedMSXwpUj8/qiWfC
         L47g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210829; x=1788815629;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l08v+DWhMTTHzUO00k+LB67tdNqKonKDnz7vF0UlhQU=;
        b=gvPnZv6PuKZ2JMznLY5kJ8tTNvArtv8oYoBct8b1NZT7o/SO4J9AsreEk+ii1Fqmxa
         WNhQlALUw56YLgUMYn2fMcz3RvY0JIbwajYcdcIDHpavznWlbPYC11ePBu9J1fdP/esa
         vutrNmYbFwyCCEKfEiTQVHqZ/W6Z9Q9+1N9Akhj0rqYlUqowt37s6eKcwNfHWExO/flZ
         FFtrSeG9KMfxIITcwsI/Nyp8/vuMOYjBizsWos6OhJ5wsVJzemUp5XxbyKKXAnOzkUeu
         5FuvUKxN+7L+Uo4MfnFgN0ehLIhLqIgwyE3X7ZZrAKiMb9FFI8Kwgt4BlBsGJvvYeOUS
         vOpw==
X-Gm-Message-State: AFuF++k5E1Smyz6jIhGHpRTuF+n0l1qLAq68el1cA4HFvuGKwZceCV38
	UvuO9ml48YZtYGPEG0PXHxrWYDgjDfZFHAhV76hmK2cXMhuCHFC7pgz1
X-Gm-Gg: AR+sD13EaUfPdS/qaNN1MSroh6wX6i7GkCq28vP+OA8B7a07TIZXpU8XT7XY8BNwRZg
	sd+rogfdhYiOEJJ8C+/yqqJgpjQntuNw3Ur1YitTFOOIL6Nq+OhUwONxRCQfGk2UM1ZPfkHULiW
	sIqhrB6pOdkV4BxuC9C5bjEmDwquDN+Sx7X/EqDMHKcmmojkk6WmV3OnTn1NUFIKX1dD1yNps3C
	/WPR7QW3iEF505icjcHA+mO4IGZBcgNlArwKJnR756iU9LT2TzYqKvphc4wF4Y0gOdlRpESN6TK
	g8Svtrugij2WR56MA9hGCSLE6LKmiMV92e7K/CK0n290EkCqXw/P5fK+JZbXWu/g9Y1y+5o+rVM
	HGzAoH355lyWfS86nCzpFLKl5eCv3m1TWfaD1bFfH2sOt/gUg0WOgmq7ipPU0qdB/U+Z6t6EDnL
	/NQwjhrcAYrZF/CLK1KkXcpcvkLtTckPDQHsBnR7vghs/F/4TmD9exnZjUCqD8lyib2Xn3Jzaen
	/c/7zAyWzK8zK8nRTsrZYeP41oKeZC4EeUnyPbm+VCHG70zlrlQESN0TlBQa+19ywuanDHJ1I95
	ceBCt+x+62+cKE2BIYCjqf/Q77ZHzjQd0dwFIE5DzJVvow6YkX5WkwCRUSr5LS+TwoXz+5YmwjS
	fYoqnVyF3R7uvlSAUvVqEuDRTt1Smlk6vrDA=
X-Received: by 2002:a05:600c:3556:b0:495:5d6d:9cc1 with SMTP id 5b1f17b1804b1-49cdd3be8a4mr13416825e9.0.1788210828882;
        Mon, 31 Aug 2026 14:13:48 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:48 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:37 +0200
Subject: [PATCH v2 07/11] iio: temperature: tmp117: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-7-b92b580ef5eb@gmail.com>
References: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
In-Reply-To: <20260831-kernel-header-removal-v2-0-b92b580ef5eb@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210819; l=1060;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=5XLKjOzOTRwerZYjWQlSm0V6kefuJzxf5B3r7vswQh0=;
 b=nIPIsBHN3LFcK6bhKd4eld/6bSVD1bfvwP5GN0lIuTQFyPwJUSgUPByKvyuo9mryDqqwM5+nW
 IycpG0CwQcMDdw0oeiwHsYiqbuPueT1Uw3l5fu23EuovZytTBivs67R
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing
<linux/dev_printk.h> header to enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
- <linux/minmax.h>: for min/max limit macros
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/tmp117.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index fed8af2d81eb..25bc98e64e48 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -12,10 +12,11 @@
 #include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>

-- 
2.55.0

