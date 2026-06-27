Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3410374192
	for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782566755; cv=none; b=HSMszc+zGtMcAcZRHH1mMsd6dIubjglVrpzrdaXzucmoNg6d/J1UnM95Fb5msFwMfRRig0pPaGnl28Yj+K2supt/3JMaXShRsTOxHhREiIN44JE8+Lg+1FHi/5nvyDGegrsLccxsFAxeXnOtVM4nblgVSMvh+AqT62uZUpLL3rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782566755; c=relaxed/simple;
	bh=Vqr+P0fmW6i8ScqI3uNCd8zQy9Ct+INYWkMYXH0qaPQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sSPtSHkEYRZTEBkEWJHxNs3Q5FZjrjGO4Lo5UERXH7H6U2O4ROlzI0YyejWOG5lFrXVELvXIy7427IfgQG3U+Bee5SxClFFKHKBVJH7ww0a0bgaybI7id7vz46vafmK05myowQ7d6JyWZjRX6IWZZILuqFnzeta/5dyXNQv+Ddk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=uAhOZeoX; arc=none smtp.client-ip=74.125.82.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="uAhOZeoX"
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-30ca1b4b278so2556699eec.0
        for <linux-iio@vger.kernel.org>; Sat, 27 Jun 2026 06:25:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1782566753; x=1783171553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMMcgVUjc6nJMeQ7kMm5VGBnEcDmSIKt9aMAjG7uLLY=;
        b=uAhOZeoX+vkrOzpAvU9fCkb9jmPPpXJW2sNKDZ6uDCy3bA5B/gEl3N9QIfaKK4fi6W
         JTCGa92xwbn7mvTl+66lo00Xeh9g38cMb8eS969IwUUOzG89vtNbZQfcded0dn/Qh89Z
         tDmQAqK7G6k8WDPuJkkINY/5pgv6mXYGSux2gO3KVLH2jluAWzfMLVDkYae7ZhWbK1Xt
         ttjTju/Xd8d3ZK16d70oD9esNlsxxSn6nHk7QnJ51/+XB4/y77DHIuK8L7GRnfyA9qJ6
         FQBNTaLVJpj62GHXhkv1geBHqzpLFYVVu60oZL5W2vC0V55/1vjNLmeMDt2TBYCci0PV
         aJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782566753; x=1783171553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GMMcgVUjc6nJMeQ7kMm5VGBnEcDmSIKt9aMAjG7uLLY=;
        b=Oz7Nf7kb7SEZQf979fibcwiNFe4jjjWxmUriIfjXJQR9DEFs1UH9FMOnltFgs49MZj
         Br2FKN8DsCKrr0AJWOkv/TGV8JjybHkE8NgbV1tOT7dfCBdhmma7uIUJMbeUs6TR6trT
         A2nF7TxJ5vOICwRRqlGIBa6SvAGOK77joOINyuRwdplkwHUzxD2YKM3iTU/bs/odwfa6
         k017YFbCmuZYuXQ5Xv2/FXyKWaTDJ6vX9y/kgXAITCep1UbHX2s4/uzvh/xxkMyPcuPQ
         055zxA/Lcx9ZxJTM0AdsJ44SfHItiwq2MNqArkFf/7p6uB7/1qFCtjyCppoT8+JsePs8
         nj0w==
X-Forwarded-Encrypted: i=1; AHgh+Rqv71vzN8EnmCVN9NOM+/RMbqwT+Oa3WijRleZwH7kAVOUfdOW6ARkIvf6JNb1r9EGHd2bRla175Vg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyOJBZ0CA7GO09hN0bhnwVJ5F3NfHQAltbsSLyYTWic2zuiqoNr
	cF4FSpofoSnzCrc2ES0UJNkjaFtM+VFUcpI4DMbXdXSIbj2Ggy6uXIAb0LqDuicwmAI=
X-Gm-Gg: AfdE7cnc6DxhIzaqj1Uq3y70C+A5lIoqYN+bHjINPk++vaOHZ9x8SNJds2pgcsmroml
	pNgWxocKa3yeB7bNPOARrT4putAIngUrHhv9Y7Xn0mV/LaW5NusCsHCSGhBlY8cjk8FbbRpLkDC
	D5QGukg9sJapLsY2vt1c7dBM2Spcw8D3xTaXXWtyaeDRa0efZZyiayELx8x4+xIy45gIyGSYw0f
	D7dfA47eb2nUmPgPJNsxTCicud72cEXVp89px1A1saTcwg00wLjSCCuJC6rcONPRoWLFFYkawqS
	8ZgX4WIdBxzVCgdEJnAAjHxYHdDBUiqXeigsaqGY6UhvyakPbE7UR6/Q9Xc9V2DhjS7PRizkiy1
	+J5DJEOQ0jVuw4tniUdzOmmaPNg1WpLDXfZukkVwTnOKdmm1yKWlkiOfH+1hPGLLbQOLRR9Uj4o
	dFtogEddZl56Ld3mL8UNsswUHY594=
X-Received: by 2002:a05:693c:2284:b0:30c:ab4d:3832 with SMTP id 5a478bee46e88-30cab4d3c56mr4286069eec.41.1782566753010;
        Sat, 27 Jun 2026 06:25:53 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:ec21:dab8:1927:ea27:9d41])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-30c7c8b1a75sm27747206eec.19.2026.06.27.06.25.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 27 Jun 2026 06:25:52 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org
Cc: andriy.shevchenko@intel.com,
	andy@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v4 2/3] iio: dac: m62332: Clean up header includes
Date: Sat, 27 Jun 2026 10:25:29 -0300
Message-ID: <20260627132530.96680-3-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
References: <20260627132530.96680-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow the IWYU principle: include specific headers for the symbols
used in this file and drop the unused slab.h. Add array_size.h, bits.h,
mutex.h, pm.h and types.h for symbols that were previously pulled in
only indirectly, and add mod_devicetable.h for the device ID table.
This prepares the driver for the guard(mutex) conversion that follows.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 56cd0081afde..ee8fd3a71315 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -8,10 +8,16 @@
  *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
-#include <linux/slab.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/types.h>
 
 #include <linux/iio/driver.h>
 #include <linux/iio/iio.h>
-- 
2.51.0

