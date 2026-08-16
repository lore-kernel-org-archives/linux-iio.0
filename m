Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6BD339B970
	for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 23:42:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786923764; cv=none; b=TpHa7+uPdBHGdKsRTUOGCigt03NG7+bou4twJW01RvbNukm+wV28KGkaxcV81g+gYQt7bB/z5/QIwqNyQzIghV6g57T99CuG9vBb2hGDzXtiM9tLrN0E/DxXWxVv+/qCWXWMItwiV07qe7hv3tN5TE5HB4u7oCMWQ2V1eI6MW5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786923764; c=relaxed/simple;
	bh=QK9K2KX+Sw8Z+PCUzt+d/R1Ay6ZHrvBZ2m5t9/NT3Hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nrQ90I/qBMbFbL3FCOGVr2ELBLdYEyVq0qY7U/PcanNKfCiNpK1CmP0zFs32f3qEn5+pA/bEo+I9tRfelL/IC6GdcxcAiM603Ype4wDe+bXoSi1Yyo/G1IiwZLWlkLgR/urqz1zTOOSEo0W8dw0swsTvqRvez3/wYzRTKq0k7h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IUzGxm1q; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IUzGxm1q"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4995b0343c1so26715035e9.3
        for <linux-iio@vger.kernel.org>; Sun, 16 Aug 2026 16:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786923761; x=1787528561; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OB7vT6dn6m6phjSQeDb4kS8h3H6TRw2MJFOf2QVEbek=;
        b=IUzGxm1q5EGvx7mU3f44osv1j/JOA+MhXXFVeK40IbWrnzt7Z0aFUqiWmL8p5dqsAM
         pRSwXcMZAE8TT3OhAhtLOmKaOzm/9EUq0RMl84QfkRw/2WyLjeH8BOTQT8a9JopVKu4w
         5rXSrMNUeOCyugEbG8Uz+TkDv23PuGLTt7qf51DEW6PQAUXjxoMcAe1bik5SuqkVxxQm
         MI0Jk4oHzlAdOT0pKTPEXwB2WLYAsCWMMP5MWc7UBCgVGnBTqGDc6wX2T0W8M/qFHltH
         ubo17JyLq9OzgPx3kHLUXMwdhFWLBFSpdRYUEMz3vrP3qKKPDALT/tDUFImtDZBZdpip
         IggA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786923761; x=1787528561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OB7vT6dn6m6phjSQeDb4kS8h3H6TRw2MJFOf2QVEbek=;
        b=ZZSR7193mAof4qvCN2DaRcYM/6Et5fWap672imiXQaWDOCl4PDF56sswW+yFcZjxrb
         E+Aw5Iy1nu8vV4pIK9X+KiY4XIaMSfgjRz8mO7QnDtUFQZghN4lNs2jtZLVI01zLaZv3
         fn3RKXTsBoj4SCTOqN2JtUryoZjMjtHA4tVKeDcJL63xVN+3l3oWLBBFfnp1zYGGJba0
         i6kdxwqJ4XURsuQViObQMRsiK+h4kCeaut4M0hdNYldTchUAitlvOhflSxaxTiDb6dme
         uwtz1sJZuTYN9/nwnNv5s2u+Zwwd0ZmVDZovYZITdC+nZKluSgiEOk9KPmEdew0AMjJU
         INWA==
X-Forwarded-Encrypted: i=1; AHgh+RoVZ5ZB5pTR6MteEDKKVFGHAhU+Xtchror7O23q96Eh0d7UVUIQpi1vcIgULe1Ga0Mpe/QjQ4z3CgI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1leV8iLX7z7sTr1+ltAAFJpbwVm+U5PylnO/Eqg19uk6x9GBY
	V2UHV1lv/ZCJAhXt68SUi+SZB5V5oYwoHPyKDzFpJXff9Q4Th4FwfmGm
X-Gm-Gg: AR+sD12HNE8GMjH6aiYg9dAZ7XsvUGctKFy+ArdI916COWruGFsJlgOLsYZ0H4ohtAU
	rV/0KG0Sn6etxDqb605RomcnnElwK/YKoZzWdwky6qucKWXApq3Wljc5SmxrW3vTasiK2013mSR
	pGWNIpnAIVJ6ldLDqQlK3PgJn0RpwiFGihMtnwM/ZXKvGRdew12Fbq5sTIoxOiNNj/ExnzzjaR8
	EFCGA1k+EACS/Jg6Ilicz9wOnmzJET6K/Uh3JLdm+aoVttXQcP+UoyjOmfe/NHu7Bhw8cw/O8Jz
	2zxW6mmqLQ4g1Khhak49u77NZBtwx/GSN66/Z/9ZqHUphquRmrYbsCseMraF/y5izwlnTjHusvv
	ipg+21Q7Z82V5vE6/aPZ4o46R306Wr8RgoSZnGtUW4FNnmIE5j7TvAzWjLuN2tNVpu9W0kovCbK
	yGb5NvXXA8a6ngr/SP5RxRwvIsie4JSKSQ16rVEjsLyAlGjDXpqgr2n9M0M8U4hyD2DLq9qjZID
	9o3DsQN/qJ8hGGSeWDWqi1xl9zssVy2TNw=
X-Received: by 2002:a05:600c:3e15:b0:498:ee7:e407 with SMTP id 5b1f17b1804b1-49987999622mr333020525e9.17.1786923760824;
        Sun, 16 Aug 2026 16:42:40 -0700 (PDT)
Received: from MacBookPro ([2001:8a0:6c97:6700:ac71:8b16:e755:35c9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499960ff072sm112915555e9.3.2026.08.16.16.42.39
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 16 Aug 2026 16:42:40 -0700 (PDT)
From: Gabriel Rondon <grondon@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Maxwell Doose <m32285159@gmail.com>,
	Yash Suthar <yashsuthar983@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/3] iio: accel: bmc150: sort header inclusions alphabetically
Date: Mon, 17 Aug 2026 00:42:29 +0100
Message-ID: <20260816234231.14168-2-grondon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260816234231.14168-1-grondon@gmail.com>
References: <20260816234231.14168-1-grondon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sort the header inclusions alphabetically. This eases maintenance and
prepares the file for adding a new include in a follow-up patch without
introducing an out-of-order entry. No functional change.

Suggested-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Gabriel Rondon <grondon@gmail.com>
---
 drivers/iio/accel/bmc150-accel-core.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/accel/bmc150-accel-core.c b/drivers/iio/accel/bmc150-accel-core.c
index 10c67f47b5a0..d067da9b5ce4 100644
--- a/drivers/iio/accel/bmc150-accel-core.c
+++ b/drivers/iio/accel/bmc150-accel-core.c
@@ -4,24 +4,24 @@
  * Copyright (c) 2014, Intel Corporation.
  */
 
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/interrupt.h>
-#include <linux/delay.h>
-#include <linux/slab.h>
 #include <linux/acpi.h>
-#include <linux/pm.h>
-#include <linux/pm_runtime.h>
-#include <linux/property.h>
-#include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/iio/buffer.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
+#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
+#include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/pm_runtime.h>
+#include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 
 #include "bmc150-accel.h"
 
-- 
2.50.1 (Apple Git-155)

