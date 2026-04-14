Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DA43B961A
	for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 09:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776157996; cv=none; b=o5cPjVAP9R8DoPqkYVHw+gAe9Le8650kVyQy7qosR4z8q6NSYthHEkdbuJRFZGybX5onh4vdI71tkM7m4xaNUS/fABVOKN8IKiC91CNcgBs4UhxYfhdn7wESZ1shEJjzji+9dtnIapz6E5cPoZo/01rj4djnD8zKphfpovHMuLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776157996; c=relaxed/simple;
	bh=RzEL6YecJLWxbFnpd/tO+rbow5SRmVdpl86aYOarnDU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aEPYn8AlKW1wrHrN4TB0wjSHLqWd6B9672G1Ls0k/Oi3aMC/VSe7XczPeFuqXhcP6fZHTo4a0d101Rwdoeiv9CpKy41i4ECHOi51jfjiHTQ2IsvKcYR07sFO3jwDDBIyr9ABemjbopohBicBeUy5QLUV2Dq6QJQLTYLuejFmTcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+TrUDM7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+TrUDM7"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b9c04152730so805863266b.0
        for <linux-iio@vger.kernel.org>; Tue, 14 Apr 2026 02:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776157994; x=1776762794; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W/UqgvYl0+LgOmppPltA1iiWZIT64IsidcStLZbzccQ=;
        b=P+TrUDM7Sinnj5Z1fP2/GT94S1PFlng0Vb2rDnxzi5UAAca7j4aJLvc8qp6VaZ0o1E
         ZIRPzvY0h3voLv7Hl2YmNN/OcCSBzyfIQijiinWDVaPBdb8G7v6ah3yMLjBz7IovP77y
         VTGIjnZ0MLj4tYS1aLbt0tMUYjtUR66P1A9kri7zUqYKO4watjiZocH7kOq3M+dqfE9u
         n3NQmG2hPguQvf0NPosHt1EhQas1ALeCexLActdVdsA3cOt1Bay47bb1Y1uG+Nvkjg2K
         Zs2UhSGE4t6buQJI0utp+Rve68FWBeyetKwLFv9sELy850YhuUkcgV5Rx3FjJf2hHUla
         iooA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776157994; x=1776762794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=W/UqgvYl0+LgOmppPltA1iiWZIT64IsidcStLZbzccQ=;
        b=n7KcviynUs0GbSik0sWqXIUeCvYbQcmyUTcByhVi9iXXSuU0WFllsY4z/ZyopNN8KG
         4ipLouuqlmPWu9I478nYWvVGNql8wGqhcTk2JHUUJq8JFtE5mPKQ3AhOGenUtLGGFXFK
         2v5Q+RxCGZ6AQ3msTtSsmzDVt1ytCPcWjlM5vU4GBGSl6xgbHIUHOoe4VFYZW15W+3Bn
         R1aoHvMk1IZy9AHhLNXrjaXi7X+D0cjXR0pt8R9NmqgcuWmD1e5Mg7HEt5M/Iy+lpl/2
         fTpOvkyG0vvtKiTGsGBW5OvXobOIHvgTJ4VGGN5nFBRmd7XuoM0t2xr+fB+tKFStaug3
         7f5w==
X-Forwarded-Encrypted: i=1; AFNElJ99fDcXfuJU94NlC+Icn4GNlNztaj3zYNVkdjDZM9UbS2CcNzrQPRWe9TzQwyBXU/jlscnCQa2IJeI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1HfjRcvo01hLLUIbvlEAVxiwsMSpccV7MEyoMKtFmeH4ZpOeU
	r1/j+u1iWY0J4xxXs2gzMTW+G3ifE0RYxEDkZ3HYn+K5Md/LvA51WnQl
X-Gm-Gg: AeBDievnQAtnNSjamt7xA79muydJ3a+ieGa9qO9LTNfizZR/HEps2k0fARlWTXTVeRa
	K8tlWlCi+lrqVyUF8e2mhY8/4MhYnqQLMD1fgAXkqtBwa1rt66P9SFyVa61vCxB6ry9Qln6pzr4
	/EzlGC6OhR85BMVl4OvApiWcB8yAVhPGMjMKhyMsK0z00jujS2SzMhx8WbDy1bmz0PAbLVQgzDk
	vbo90BQfxeVnCyUek3UnmcasFNXoSaZFo6QeMwalrEihkUNQI8xb5AQPiu7u0VSkncwKzM5DLQQ
	MNmeGcr3lPzMGiBzhPDP1/KpPpVK/cVph7GWHUwY5tEGAU8WSM05k9nss9HJaQvY5BlEjW31Uat
	1DwQKug1KKOSkfnVdLEpqzVlKKwr9DTMtDxnc1Xxfmb16p6N9NhEpR1YuWGmALzFX78zOQ83F7+
	1VNsIdo/S6n+J3hzKbXoRPAqIrUKl/lZR3O2nsQA22raffc6FnHUdVHeGbEZhavJ8uZ7Hnj1a2k
	7oklqJDNaCfhmeAPgvxpz2BJo3lNv5NzK/viZsL7mq1l4kbAE4doOfnO6dO/GbIk2yx1ghNR5jU
	mbLjQBrGNG9KpefD9sXqTP3rFZW3h/ESYbnKdrLRT+3CGdo+M8uATNrxUoLCpXXY32IpT5EYGbn
	pgRUiwQosYCXJXUv+Kitvyg/Mxvuqu1IiiHwB2DYPs0TJBNMNpQL+TT5ZGh4mqtVer9K+GCIkbm
	Wt7fx09FQ=
X-Received: by 2002:a17:907:94d3:b0:b9d:6483:6711 with SMTP id a640c23a62f3a-b9d7281491cmr945606466b.46.1776157993612;
        Tue, 14 Apr 2026 02:13:13 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-b.c.od237066db22328bb-tp.internal (63.152.141.34.bc.googleusercontent.com. [34.141.152.63])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9d6e7c8a44sm384466866b.52.2026.04.14.02.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 02:13:13 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	gregkh@linuxfoundation.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH 1/3] iio: frequency: ad9834: clean up includes
Date: Tue, 14 Apr 2026 09:12:48 +0000
Message-ID: <20260414091250.1295-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260414091250.1295-1-joshua.crofts1@gmail.com>
References: <20260414091250.1295-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Clean up includes by removing proxy kernel.h header,
add bitops.h header and order includes for better
readability.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e0..eed4e08920 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -5,19 +5,19 @@
  * Copyright 2010-2011 Analog Devices Inc.
  */
 
+#include <asm/div64.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
 #include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
 #include <linux/err.h>
+#include <linux/interrupt.h>
+#include <linux/list.h>
 #include <linux/module.h>
-#include <asm/div64.h>
+#include <linux/regulator/consumer.h>
+#include <linux/slab.h>
+#include <linux/spi/spi.h>
+#include <linux/sysfs.h>
+#include <linux/workqueue.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
-- 
2.47.3

