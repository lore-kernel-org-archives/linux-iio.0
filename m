Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE00639BFE1
	for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 21:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210825; cv=none; b=hz/xpx9AsT+HRg63p3EWq0sFiqBDVbKsGzxPPc2PuU5+9zW2Q9+7Meq9UBgVSjaxhwn0SPL6DucIPZluPsbXRhuDNtSC9zu4JlAwJB3PrSbYY0q47m0cm9s81xJ/nif7oa3HfTwRbnW9VlQMjiTGQ0pXiSedTHLm19rzjS77tHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210825; c=relaxed/simple;
	bh=Up7WixMq2UKiZiOquhHtQgYufcWnlB1kNVQP+l4LXLY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K4cry4zBGTWaVFVpnvbdQr0+xsaCOMggzZ8Ny0E70bMBKHcPUYsc0jJmjXEMMayTtkB/5UZOo8frGTPZm4V19VbHJ9ZpQ8h57DZu4LnUoHpn0BdubEO9g231x1C8esgA6oFsh8ZSS+DwJEo6EkJRCV5OYhCJy6l3s8FTwcTFU14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V8NuwLnc; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V8NuwLnc"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b8ce9b733so27618535e9.1
        for <linux-iio@vger.kernel.org>; Mon, 31 Aug 2026 14:13:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788210822; x=1788815622; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+OwGak7jvH9Pv/n5J8RbgPDuhJli2QWAzQdMtVUnCkY=;
        b=V8NuwLnc0ivf8qV5GC/KQ7pUKsjkISvfZaFF/UPEw8a4DnTmbNb4KRkfDeycaKpYCT
         iKV0upYSal4N65YZPbgb9Dq9rPwJ8tgHxW/Bz56qKVaz2Wr+ei4p7sFyUbyuXt9ZXlXe
         5XstJfIc1Zy96f7TxwGpnnNmvPSCDBTQG7nUVF7VytZTpvxxthR6A1Loxcww2kZ2I7uw
         k+LRsU0znKgPJrFGu3oS7AtNwv15Tw6LhcikhHkavRC5G5av8t70Z90BGFx4FiQTA/oZ
         mcfUNOn4/N8qC8yd+G2WqvP4mNFOUUhsxl9n6Jz8plnq1lj407jpZpWWrAI5SiPoL7m/
         icEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788210822; x=1788815622;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+OwGak7jvH9Pv/n5J8RbgPDuhJli2QWAzQdMtVUnCkY=;
        b=OgGBlDd7+bbQQw7aTQCv9tDAM1ZhrXVuB798vZxFvILempQZVvwMAT5uOecu5mhFv5
         1JDI+2uAMgGNSshEUN2IcHLBKUTeb+np7Xcsr7kBmkU6R6SnllPZi2cigHIlVlavd2Qf
         Ztd7xopV8HpT7tOO9oCvW/wyp0GV+8tGGmfTKLnMb8zuL1c8U/1goTPp1o7rbClk4diY
         L+4KdYViv57wuqAcxr1AuVrhAWjMxNgxodThuybtBl/bOPjjdK9IV44gyjYfHOoB1KCO
         HYlAaZOS7rfet5MJE6H3k1mvzXbyzatf5bkKjcghwWx1BPYYbygGbTwxKc/oR1m5jVny
         48kg==
X-Gm-Message-State: AFuF++kP7817RNKHmnL76Vs14Samydc6GhwmWeS0VoAgQE1xUl/s3pqr
	9DvBYjSv6106aH59ZZvS8e1xuJZtcMBGvtqrkRc4rJfTOoas2Lx8DHCm
X-Gm-Gg: AR+sD138/Wn5P0oYqmobYe7zdBeeIJJoo8QCCo7/WqiYru3DgbgQ78hSBQ1Imj1cqDj
	Gr8IXfcWtVEEU3FgsGG4IXCUJjJkCymADS7ucIjAIC8fy9N//cq7xm9zLDxy4gl2r734YaR0Vg1
	zL4jor5TquTlEco8Im7LihDEBF90l8NN6YYpmpDL7hcKXNebDzlsb5XN20UHZI84epocHZGiS9N
	weQBFKYDt2s0YVbEkOfiEsuTo0FgllOuSXkwtIidoauJbx5VPZmt+SVyLijns0b5OZtujaNzItc
	89tcmrddMiytqN2wJxQItDXkD3DmgvxZ+quXJrp/d98UPNOOlS8NWj0mpNwfxWgDR8s2hNvyXHG
	5O7WHAfrw8YZXI26T8G71evqJb5dN44Mvnc4e3PgBPbnKH9plXdAUHdUiiQH/CUqbTUdrEmBJZZ
	+psMLduq6e9ZSRkMqFYKUJ/26v7SPnPFpNrM71mZndckW8l54HkGRDcb5CTuaCzrrQoqoJviW4e
	whmPuO3vBpkYv1xA8ytlbSOqct1Zo7KLEwOSATbbI94p1UTI86bnN4yM/fIOI18/AqTsJ3BAv9i
	y7zitBJ1BHqtrOQ9YlMNiXJwceYDx7ImsW/hQYgfaiCaW4N3h0kE74NS/siebKljDxW1AisSEHz
	Xm5tKAnOboPJ22qn24cvE6N+O
X-Received: by 2002:a05:600c:3e1a:b0:49c:cee2:a508 with SMTP id 5b1f17b1804b1-49ccee2a541mr310505105e9.16.1788210822065;
        Mon, 31 Aug 2026 14:13:42 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cdce1754csm17695925e9.10.2026.08.31.14.13.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Aug 2026 14:13:41 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Mon, 31 Aug 2026 23:13:33 +0200
Subject: [PATCH v2 03/11] iio: temperature: ltc2983: make headers conform
 to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260831-kernel-header-removal-v2-3-b92b580ef5eb@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788210818; l=2053;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Up7WixMq2UKiZiOquhHtQgYufcWnlB1kNVQP+l4LXLY=;
 b=3mzQA/q+KB6k7DDU+xBz9iO5c/lHkYHNLJ7udoTjsYFY0GoyixbGt/x8GiIZAogwSV9SWFZjb
 AbU5ZWdKCAuAe2GXGsVANynSyrmifx5wlaVqkJFZdzavL9hLz0k6hRS
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU (some standard headers are already include subheaders,
i.e. errno.h is included by err.h).

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bitops.h>: for bitwise operations
- <linux/container_of.h>: for container_of macro
- <linux/delay.h>: for usleep_range()
- <linux/gpio/consumer.h>: for GPIO functions
- <linux/math64.h>: for div64 functions
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/pm_runtime.h>: for DEFINE_SIMPLE_DEV_PM_OPS
- <linux/slab.h>: for memory allocation
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/errno.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/ltc2983.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index fe9eec3058d4..6655453c9abf 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -5,19 +5,29 @@
  *
  * Copyright 2019 Analog Devices Inc.
  */
+
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
 #include <linux/completion.h>
+#include <linux/container_of.h>
+#include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
+#include <linux/gpio/consumer.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
+#include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/slab.h>
 #include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
 #include <asm/byteorder.h>

-- 
2.55.0

