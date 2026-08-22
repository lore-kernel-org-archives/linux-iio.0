Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5196B3AEB5D
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385844; cv=none; b=mBE9Ps5iq1uEyi18c81LcJNdz3qdLB+9b87NsksTrMEt2v/vGVr2QbRvnpBvVMIQ+M9BJFVb9AU9E3YyrP8dLzOYj2n+Etl/+k+C68NAaSorqJH98U0OUetmiweVVEuPOvsxbUQWjOu5+kMbWurnAUaRK8FPQUxj31uEDm8vNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385844; c=relaxed/simple;
	bh=S0psc0GokPMG3r5dgQR0E3KceBkww71p70Ddzytet2M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=W5Ux8A8dTwbYfo2OunXfZo5lYVD7KVlwgt+24TZ1utc8Y/dw9dSjWEQI6xNwuvYJ0MicnQl8IW2CCxwpjzs1Dl/IgtB139TKh/kgx1GuHF721U842GKHZk+q5Fdjp5x+zQqSj6CeHGINjrhUkYYSosrWuVwF7dVqd78UUqNwork=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p0fxtbLY; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p0fxtbLY"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-6a0a4a28cbdso3288711a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385833; x=1787990633; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZLzJmQwMgWXL3sbjVA8gM6zLJbXj/mUC/hE8T4vkRg=;
        b=p0fxtbLYIyW3KZRPFhTNBR3u4tkdgEWahVFXfwOJTRGqdsojsfYpEPhssLeh2PvLd3
         7uawAgNpwTope2dvxEvjiyIIiL4qVfrOeHzB8is7dWj4gcg0aroGrbf7RdRvvc36yWFx
         n+RZ9SKkFPGSjh9tp/Mgc113HfU568+MYTV77EfAR4TWjbY83hD0tNPjBuwbL7iOcfqz
         P55DZARafiAb6+8NcghZMwBPIkkllisLqLDvX/DqvtfSCsiROdxKxnZuTh0OI4sBT0bV
         hnystdt0+egQHXs9YbVZdL/HOVUpLBa6oxiOYLv/EN6as4yBU1O17uYptXJSJAYGHfzj
         KFKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385833; x=1787990633;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BZLzJmQwMgWXL3sbjVA8gM6zLJbXj/mUC/hE8T4vkRg=;
        b=jZfSL24TDQNAx79E28wLVMWLDsFWd/Ifk7uxJT2+LgugqNRt247ZtBPbkGMO/r/EdB
         hfA9P9MM3uI3a0+PiStTCfWemG2jo+L+eDuUFFFRBGPaerx3d9qxtLmwl7aTfOobs6vM
         L//oUGedniN8WCDiuKsJ2pxnUiVC2L3Buc+Vq3Dgf2B4/zWZwOfw7XFDL01W8G9M+kiL
         mWQyk+o2LSD1jCNDlqp3LK3b3+thk/zIIq68GOjHe6PBJiQdClWn/Qcds3hWdTZQY65l
         uWKR/wM/vXZWckVVZ3vqFqGrFroVPfyrVenUgVyEFmx325yVe9bake0CjNSK8NArtG8I
         0Olg==
X-Gm-Message-State: AFuF++n98vIp3guMpwwbgKe/B2kLVnP4XeKZxEk14p1CHoKvf5RUsIms
	2z7206RnBe8XQt1i8MNrpS/JHIjMy6XLNmpRvqBL6J7ElIHCmO9kPoEb
X-Gm-Gg: AR+sD11Y9fFWn+dr/SiWRUuuUJfRpMLG9kODrxU59ZW2vvMxkeKoK3eyfYUj262QKna
	uC+0ydxbvuASUAVznsGPJYAnm6+tEgX9jq/QwIZDHcBN6KLRPlWhiNxQnmBpManUIyG7OUE/ymU
	rTJtE0Deos/EBNIQee8+MjiF+EBBs+BllEQizUvYlVWKTgBfLlHucA/ABzOrBB/O8fbE6g1xFA2
	uSqEpZlNxC+YuRkyLBRVgUu/uh25Y+9kcfRVHI+NPqk9OjM7eKwAg0LZxDxQsE1VVQB/ejzKhZi
	7WfHM7cL/N2q1WSViaLFBLCtQyjJhiFVNWad6xrqhkAHvBtpGRkrj+btBkRkJkUau+yBzGzWLIJ
	mWPxfZ4LZFLE6ssfkOwXPMftQpVNPln+uFKMtAt9jPPbDfuCHNQ867wMt29/ZWlrYUspcvty59C
	Lrh96fDNunMh/Z+uLQvp+N07v2okV2kAU4hY5h+B0lhAWtauyQly+Oa+wASQSpAv8J69UIib1gA
	6UAZ4W/d4iBVx3l68nr/9UsNvjUrh3PLveukwMs3lwJfpM86V/JfwQpdAiRxWnxLTEPxdPYYXNS
	z0PZuEvo48JA6mFhFoXrUtWFt9jr+aV1AtdyPbfRzsffJC9ocLxwZ02ESCE+CKl8L93rDV0xJ2t
	KHRuPuBj7AuG7B7L+dGdWb4Rqkg==
X-Received: by 2002:a05:6402:e10:b0:6a1:7ccd:5203 with SMTP id 4fb4d7f45d1cf-6a582af8d2amr5066152a12.2.1787385832608;
        Sat, 22 Aug 2026 01:03:52 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:52 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:36 +0200
Subject: [PATCH 09/14] iio: temperature: tmp117: sort headers
 alphabetically
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-9-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=928;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=S0psc0GokPMG3r5dgQR0E3KceBkww71p70Ddzytet2M=;
 b=vBrmoQkC4JjDS3WznjtTOCMA1soFG8DMMzwj/IHcSF3zsiypTplB6lM7lVgFyFpt5okC0m2N8
 5ygOh0HGrqsCVq0YlGlc5Tt2Fhemn/LckWaOp4ngmFHjNuQfekmlesz
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Sort the headers alphabetically to improve readability.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/tmp117.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index 74cb8d62bef3..fed8af2d81eb 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -10,16 +10,16 @@
  */
 
 #include <linux/array_size.h>
+#include <linux/bitops.h>
 #include <linux/delay.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/module.h>
-#include <linux/bitops.h>
-#include <linux/types.h>
 #include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 

-- 
2.55.0

