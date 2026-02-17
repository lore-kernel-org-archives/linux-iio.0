Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422DC253B73
	for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 14:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771338779; cv=none; b=BLbjpUqbeIUrfo9sQWcI4HnNoLqjLK0RHAnf61xZWJm0L+floMqaRPIFOudVw9DX33ar1Ztk5vt2VqP9sPouMltucgS+xj9On61Lpfj+NfEKHLyuQThK0ZR84nsVdVqbBDlIzeXMTRijVCbvBRSg1zJ7VlxWbcvoIn1mc8f3FVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771338779; c=relaxed/simple;
	bh=QX1rnL1NhzIAPacP1l8WQMYaLPvdGGo3fvLF2MnKpZg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNPSDgckAKCJjbE5On9gV0LtuE0cibWSHMaU8hwzxifOmvl2uoUMTZhodyKqxDXBvS8GZSLurfBG049N9WNhkN/Nu3xp/3feNYVevhoBfkxUjPLbludy5kwdJ5wegAWsAgI5Ab95F8x6My11x8jZJR45mph+KihqmaaU3O8Ht/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cqdGU3vk; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cqdGU3vk"
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2b82c605dbdso8893516eec.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Feb 2026 06:32:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771338777; x=1771943577; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yph9I1IzJZAzz0+SJ54sjwvwc7Z0UJr4mZE/WHjMwZw=;
        b=cqdGU3vkmQDaatwxHW4s0h4v9EJ15fTbzoclj5RWKCnuNwBY607sDAfAU6b0DDXGuo
         YUVW7uafaN75yLO3kGcayQr6EImyqc0Nl1+Obxu/ki6ECLuGTB3n4u8fz8NbSSJeEbOK
         ff5yrs+6zP5DaQs8liEkqtuI24ej/e/9QdcyjpIYKkvLV/Vzsxcw7dy06KQqGEQsOiFT
         W/MKQw5ZtP1aMFGlL+4DzwHuXjnyrfPAFnMn+/3fKjIh5bpCF4VdbHL5d25IL9kPNJps
         90XvabCNVjbRPCPRt65dOWiQx2+TzjndIVx597LZxrDgd8DjY2302Q2f9DKGvPNiDH3w
         XmKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771338777; x=1771943577;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=yph9I1IzJZAzz0+SJ54sjwvwc7Z0UJr4mZE/WHjMwZw=;
        b=oEGGN2nujj9mxvAr4n/1itsaV2E+JhMXLp0N0I4twMWlvXvU5Ao8luLJ1WrdohiZ0t
         QkGXWJmAIVas67kLCureAnhSkQgoVQDN78+/KkxPtPEeJDHR+X1S9m/T0vhftbNzaFCs
         DEd0kYAyGn50OV5ZX54xhVXnJX/n4aMIBVXsunJKNT4d2JYewA8BwNY86HGRw8flX+W7
         q7MUfNtWFjNPpOj6e/EwotcQvhOh64o6HhQkT6uNVqeQpUxlNaJB9pJ4mhI7kBAu5gua
         K+df9VGen4xLa5gnQFbjqgJ2fBU1veEwYATW+MC1r+h8kWjXbv5q5Qbka7zsDvp6QYCc
         aIFA==
X-Gm-Message-State: AOJu0Yy42CLh+BgZDTBfL2OXLexFsMLGQK8efdFHgDjVpOknwTrhvrBV
	7DPaXbLCakZPPHTcTx1RzxacUwAiWeTuhojqGLPk5jLUr/YmI2c2GMeF
X-Gm-Gg: AZuq6aJnvR0tZDLEcXF4qzrm4fgo3/dD5e25FnChuOhiji5Ncy8SJtGCd/4l+MPc9LY
	SDz81UZ0UVsOYEak7L3Yn1A8d+YLMaJI4RRCzMq5drBE6rxNhzdcyHnjneKLLi5hb5yE2WvyE09
	Rk12Y/MVivODwWfS5tX1oMQTBaUTw2/6oAH6U+/OQ619xLVzsFDLjhlfV+szdmfdqogyrU8M5pM
	VRWr8NNgG+1KCGYOAqvmHsIF6p1WJQjXIyVfJtWan1ddND1zipyQqO52TBJ05IarzKVT0wbPQHK
	Yt4girZ2tvq7gy4QvasSVZkhwQjAQLW+QAW+TKdxUO3Vr35Uc38piEjJ5U7sX5pAw1AdtWQkMvW
	4qKEblfUa+o9Y0+rlAgZDB5aV1C8VK7tWDYK1Vy3j6JkfE3vyooGuTYU/Pt+xu6/Ul+2Z/SKUPg
	Q74/rHuXuZHikdNUdJABeone8axaHwLA==
X-Received: by 2002:a05:693c:2c8e:b0:2ba:85ee:4628 with SMTP id 5a478bee46e88-2babc4bda52mr7270999eec.39.1771338777302;
        Tue, 17 Feb 2026 06:32:57 -0800 (PST)
Received: from osabio.. ([2804:14d:80a0:804a:d4a3:32a3:b3e9:7fde])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb582bebsm13656469eec.15.2026.02.17.06.32.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 06:32:57 -0800 (PST)
From: Gabriel Almeida <gabrielsousa230@gmail.com>
To: jic23@kernel.org
Cc: linux-iio@vger.kernel.org,
	gabrielsousa230@gmail.com
Subject: [PATCH v3 1/2] iio: light: zopt2201: Reorder header includes
Date: Tue, 17 Feb 2026 11:31:56 -0300
Message-ID: <20260217143157.132799-2-gabrielsousa230@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260217143157.132799-1-gabrielsousa230@gmail.com>
References: <20260217143157.132799-1-gabrielsousa230@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder the header includes to follow the usual kernel ordering
conventions and improve readability.

Signed-off-by: Gabriel Almeida <gabrielsousa230@gmail.com>
---
 drivers/iio/light/zopt2201.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/light/zopt2201.c b/drivers/iio/light/zopt2201.c
index 1dba1b949cc3..3192aa72a0fb 100644
--- a/drivers/iio/light/zopt2201.c
+++ b/drivers/iio/light/zopt2201.c
@@ -10,15 +10,14 @@
  * TODO: interrupt support, ALS/UVB raw mode
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/mutex.h>
-#include <linux/err.h>
+#include <linux/cleanup.h>
 #include <linux/delay.h>
-
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-
+#include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/unaligned.h>
 
 #define ZOPT2201_DRV_NAME "zopt2201"
-- 
2.43.0

