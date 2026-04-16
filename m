Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF4B37BE8F
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 06:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322320; cv=none; b=W5oJfJnWqh5jKT56WtLdZNlh+yuDwvGkmfGJCwKhn0U5fJsLuaouJnRqJov7cDvmaRip5KW+fbnspASxiHXuyo8IGpIT9PSap7LfGyEK5+s9lc91ZFtV4iDkbiNSl1IRGDNXu8dVDqayilVl4oKdb23oTY3Xu8o4Z4GPgqN9Cts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322320; c=relaxed/simple;
	bh=/cnRsqWfWhNWUgWgkxXglzQ1GNerJRk1XXnfGhrxeI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DP6jUjaSe91+7V4GNbg8WmkfB2/Hf3Y4fb74i5xblYuzMKaY71AWJpJ31OJYRDosN60YjST7YV1IoWy7JtjncIFRSeCZxlDDnhJ8zLrdWyM179yR0JsvehM/lohSqWVf0ZatOnkIop2EQFfqi0KgCaK+Z3QS67m1SjQv/2XIs+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iI7WVp0m; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iI7WVp0m"
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-66e8cf72a93so9058328a12.0
        for <linux-iio@vger.kernel.org>; Wed, 15 Apr 2026 23:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322317; x=1776927117; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrcwJVOrLuk/AFe+po/SIs1Q3hHaDdqPoE+YLreuOlw=;
        b=iI7WVp0mS4bucVoNNwIOOTptcHfS9rFSrZo9l0h5hSzYS1Vpr6bH0oK/0VQ2WuiOVy
         BDOuIPS2meOdK6NVtzgnYJrsC1/KzeU/+4SyThFRmSjR0DRnFu1qh2urzwN3vI0c4cFH
         iL4Mf3X2RCbT58CKF/oRj81njw36z4NmldBJxJbbY5noYvfi99KsHCmaVmA8aKqYk3+3
         qZz17rS6wSqFHhOat+sRWXlWe1Wosv+1KlxIjsNBcWY6kbo/8N7w7DfJwq3m2qWIHblz
         ff9n0LbjrqENptkWyY9qyD7DsweZCyLfDRualXbZQUIvdHUYBSA++d8mirpnqyY8dacH
         xBBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322317; x=1776927117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FrcwJVOrLuk/AFe+po/SIs1Q3hHaDdqPoE+YLreuOlw=;
        b=puGdxfph14e96FTbGbYeNFRTfzecSAplaYn92gWAa4LWBcfSzhk031u8EAuYngzamm
         yC3vl06K7oZui4M3SIhygKP/JbuWMEYpCouopV1uA6To9zSTgiajwMH9Bw5z9Wm9idTM
         7jonqJ170HvcNjmRkXE83OWYS5W1g5l1ByPQAlZQNv3cuDOCIggsLZnyB/HWHq3EiOjA
         6u6Ol6op3TkjP87wqIuhcAWIgZZcFIoFdqRRENBUVLfHyAY5rJKYW9N6TBHpGmpGGEzs
         SXTfaYPdTmfzXi2FJ/1kQuyQqwt2fnAp+Rc45FEnjHIsWARS564nGpVXgEOKNg7SSCgp
         VCGw==
X-Forwarded-Encrypted: i=1; AFNElJ/0T0kLJA9gKi8N63e8hVTgD1/rHbZZfPwTioM7FdOiJyU3nZC3BVsE1nirggsaREzIS5MXtbO1AiQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxkrlq3TCQzBiVdU3d0kvvTUfsVzGbOcZKoboFx+su0XInoQaz1
	eLOnoY887B+hXUyDvWGZKQ8U0G5rDZhsNUQJ7Az7sy1fwh7pu9vAaFVU
X-Gm-Gg: AeBDietpvNGiBlPl2jmFHXe27pji2WXhyB20uXxmJTLXXlZsHvBEa7glebv7Mnk+hix
	PrYoDugxRsnHKK9rSYZMwVyHQbLBDMd+fosVzz/avAspe5mUZjiHBymUfb0s1e8+IXuu453ToGz
	zbnw+rPXMstI5nMfBOPmBiT/2ILKSY7mwe6wI6IzDXd4yPI2Fi4UYtddw60OreTJdfYe0i889+W
	Zg5GQNH24mSCTxv3eDJTNJ0UmzD06kXbrhK/r23X0zkaQqVMIDxbzfAq58Wz9Gt6O3JLNj68GXQ
	MMOeZ1R0o14LemTLRjwxCa1jslE3SiywWJznSjlRqMlAvVvs/6ZbY+VfF0T9DMcx45cbV/kIG5b
	D/HSRw54IsQlgamc3WZJzXoIlEscyO45o+2Y2vJXtSOeXBrGAyj/9x+twSgwBEKUw+ZEmhnnW+S
	NpefStF4nTFwuIZCYVMy0slqd82TvVDDMjfvbyWQH+bFxRWbbCPeOdOrsAAMi0gyqdCLGDAPNz5
	Y1kc6frvzfcldrxXuxRmxKwIutzf7DpTrvGxVQsPDviI3NgLTgpuRuIYKkpB7suexHOQ/6l2p8o
	jCta4wLDxqN7iDlWbq9OhEwZ7b3QS9cd6zlvWRR34QUuQ7HbKxfO9mUDceGYeUObi9EJIQRNfa/
	vfyr3LnPtbIIoAay/hWIYyJF8JkEoEktPH3ak27ExN4W9dvH9Z5hJToSMkMBfJB5GDHQvm2nDwk
	tXvk1qq0k=
X-Received: by 2002:a17:906:6a27:b0:b9d:8697:73b8 with SMTP id a640c23a62f3a-b9d86977753mr1271579566b.22.1776322317229;
        Wed, 15 Apr 2026 23:51:57 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (119.230.32.34.bc.googleusercontent.com. [34.32.230.119])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba17341a8e3sm132530066b.6.2026.04.15.23.51.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:51:56 -0700 (PDT)
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
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>
Subject: [PATCH v5 1/2] iio: frequency: ad9832: remove kernel.h proxy header
Date: Thu, 16 Apr 2026 06:51:17 +0000
Message-ID: <20260416065118.1299-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260416065118.1299-1-joshua.crofts1@gmail.com>
References: <20260416065118.1299-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add bitops.h for
better dependency control and code clarity. Also
removed slab.h and moved asm header below generic
<linux/*> headers.

Audited using include-what-you-use.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/staging/iio/frequency/ad9832.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..fbcfdbd398 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -5,21 +5,19 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <asm/div64.h>
-
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
 #include <linux/device.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
 #include <linux/unaligned.h>
 
+#include <asm/div64.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-- 
2.47.3

