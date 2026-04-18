Received: from mail-dy1-f170.google.com (mail-dy1-f170.google.com [74.125.82.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A858199385
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 13:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776517430; cv=none; b=BQK6YYSLJzPfKahX8iFulFjDvo1AJIi1JWBJtDndHRN2I2+oJGB3v5eMqjunQwhIryZxbp7gUkXPxZaxZKjpir/VIitvD+Qycz/JQdq+SVzzCCNGHSYjUKSjDd7rGcU8DKW/WWEa8U1L12RoQf4/hVJjt/up8z9MazkRj7Wz7hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776517430; c=relaxed/simple;
	bh=5VN7x+7rU3klmqQL4YPw6T4jxB9U29SvzKM/gvk1/XQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uY4dk7WJ0Xu/wvfxW/cmSdAVoMv7dBZb9ISB4RGEDL7rRUlz7cRqcMjP5cpTQy3R3lFX8+olou1Y6vi3QLxXBWIaD/QM31BPfGuE3s89Njo/6q7x4wxrxWYGRxWBiy4ywnKVayzZGNGkFqrpfaQ8jTRtRkoilveXlH81Hr24t8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=krAwOVHK; arc=none smtp.client-ip=74.125.82.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="krAwOVHK"
Received: by mail-dy1-f170.google.com with SMTP id 5a478bee46e88-2dec803f9f0so1273485eec.0
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 06:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776517428; x=1777122228; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x0laeZHWS/nmQTEjXMeiDXpowDhi+KN8Lau4qyXAlaA=;
        b=krAwOVHKeCx0pWoPu11IrKL0jJghU160XiM+5kaUaESdSNEQSMzIur7eVhHHh1RPdf
         kJ12AnKeJttWQxBOproQ8s2QNragLCd+rUzsSL35dZ58yBS/g1btdlGir0IfQ/jBGMFv
         WwWCUpkmxvr4nqDDar0OM5JyV213RjpGJ1km+/si+/ptcybDJlHzpWuWPvJojhGeOOGk
         Z4Soek2VriE5OMHxIYIBpMf7duDTIQW1344gorKhMP8ura536ImC1fJzLtJc36kfUSFg
         4AxOkNGYVXv2qxxt8zb/z6TvBzCzW6QpXzo4mC2DgpDcLVRqJBO5uRLifW2dWr7NB4dI
         TWUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776517428; x=1777122228;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=x0laeZHWS/nmQTEjXMeiDXpowDhi+KN8Lau4qyXAlaA=;
        b=RqC871nrPQI66cKlXgpSgPcQ5T1pVbY0AQSfERrtd/WfjRq7Cory30Fr1+TXFaQ2r1
         PwrjtoTaLDz+7iijck2Dphl8/db059KvqaTV40E/kTIvoVc/KOsYQio9oQmWYSRv38Ii
         9aKU8skoRNQWh0O8HNWVaeU7+yWY9a03Et4MGQKW49s5mQf3FFWU6j/5hzDT5qyDYEaV
         F2fp28MWauBCA0w+OGLmuqaKXqTLk3OiPEbPmqzfFC70C92G6DomxJ+BHFWGFX59JE35
         rJZXF6JuoDrSoCT95CH/jNG4JrdXrrtMGppy3TvrKDP1eTU5YLV9TzV+VQmhiXvXRsg7
         brpA==
X-Gm-Message-State: AOJu0YzK9cAU8luZy4T3y4+nHqkcauXp37qBlm8oEky7FdkZwck25thc
	WdtBCqYpIJkJwzjsLHpdqhNp4ZJL01/LDL4HNcQLt3UZEfG9HuUCE1UDKhweYz4sifw=
X-Gm-Gg: AeBDietXdg3jWnDNKd6DREHK5Q1dRCocMASMkCnUEb7qqgyKuEw6cWP1JqBqh0/ZDoJ
	XBevyeQ3VKIMdVnjAg2VXKHeM5lVOlCsCQRSE/wDtNiQNNJ+ZY6G5epfz82EQVUrpFxyibyGEWw
	1isQInTuzq14vSIANQWjzq2NiqYYfkftxuje7S/47fjJNG+wjCx7sqYJwP8HJselGKgchYs+lT/
	ujuuyn3hEtaW/oi2q2sEDvJTC+S/MfiZoHiIc7zz/SHabweY0CVt6WEnHWn8FlsgUQLR69zYVQT
	mjAyomvPWYMK70SICuUQ4EJxS0AADcnhJTd0iZQWjsaCgvCj4iHkTR5Shuy/EictiBAxfIyNQiQ
	9FiVWY7ifKpJd5/XlIcwHAKmpzPcAuKWaj3H0QWwnEDNwyz4HDnaktzt4xVRj9O9UmAeSQp7yKy
	z2mexK16bxrmsgXOebIgZ0NkSCqYwXeqeTIyUfGMiqbpH447Va
X-Received: by 2002:a05:7300:dc92:b0:2c6:7896:e2b2 with SMTP id 5a478bee46e88-2e42dc07c36mr2333751eec.13.1776517428029;
        Sat, 18 Apr 2026 06:03:48 -0700 (PDT)
Received: from localhost ([2804:1b3:aa80:d8ed:6b55:82c7:991c:cbac])
        by smtp.gmail.com with UTF8SMTPSA id 5a478bee46e88-2e53d2cff04sm6213197eec.23.2026.04.18.06.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 06:03:47 -0700 (PDT)
From: Erick Henrique <erick.henrique.rodrigues@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	andriy.shevchenko@intel.com
Cc: linux-iio@vger.kernel.org,
	Erick Henrique <erick.henrique.rodrigues@usp.br>
Subject: [PATCH v3 1/2] iio: dac: m62332: Clean up header includes
Date: Sat, 18 Apr 2026 10:03:21 -0300
Message-ID: <20260418130322.106769-2-erick.henrique.rodrigues@usp.br>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
References: <20260414233912.662606-1-erick.henrique.rodrigues@usp.br>
 <20260418130322.106769-1-erick.henrique.rodrigues@usp.br>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Follow IWYU principle: explicitly include headers for symbols used
in this file, remove unused slab.h, and sort alphabetically.

This prepares the driver for adding new functionality that requires
additional headers.

Signed-off-by: Erick Henrique <erick.henrique.rodrigues@usp.br>
---
 drivers/iio/dac/m62332.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/m62332.c b/drivers/iio/dac/m62332.c
index 3497513854d7..4b139904e818 100644
--- a/drivers/iio/dac/m62332.c
+++ b/drivers/iio/dac/m62332.c
@@ -8,13 +8,18 @@
  *  Copyright (C) 2010, 2011 Roland Stigge <stigge@antcom.de>
  */
 
-#include <linux/module.h>
-#include <linux/slab.h>
-#include <linux/i2c.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
+#include <linux/device.h>
 #include <linux/err.h>
+#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm.h>
+#include <linux/types.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/driver.h>
+#include <linux/iio/iio.h>
 
 #include <linux/regulator/consumer.h>
 
-- 
2.51.0

