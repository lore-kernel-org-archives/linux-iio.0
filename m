Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD1F3B6346
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776421012; cv=none; b=rNoCHwNS9QnmvEQDX9ue7xBspRjuW6ak0fAAu5F8sJvp7X9cYudKVy70KEfMuUuwmVUBhRji0W0nPd4meP+O6ROYQNhNRtKf2MR9GlQPGsY8GS9fx2bwc2Y+b9JFQMD+8DH7SXz4gS30PdIMAHhHXinCZMrlvH72I17+dvnIB+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776421012; c=relaxed/simple;
	bh=lJIJxbvQURiXsSatZoyGsKXZNQ0AisVAxB4bL995vZQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CoQbFs2Y7Pfo2PeQFYo6/zsio9VthUoNYbpqS+8tcbrfxusSUzcZpES7KKfKCl/E7V0QKg8+SRJSrQIOc+VsFnO4YdS1ghSuDyn+FtZnTae2+61P9Oh3u8dXRrkdheyUr+ezF8hAwnql/RoVrXGc2sd8MoRPyHQRHjT4wrBOvOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XyG71o/Q; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XyG71o/Q"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b9c6680aaf8so93305966b.3
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 03:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776421009; x=1777025809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8SAmev4VJJf4i5t8EUbInGL1AJKkZdyx8tFeJUEXIQ=;
        b=XyG71o/QdJQ0Nz9zCbl9f5jpsi1RqVTDEFMkoae9ESgEuy5geS4FH+AKpE3AbzV2sF
         I7pkuF9zUCxZZ4/Cg4JbD66A+FBZTVj2LjOrYT40T9ZkzqnejjiIcxtE/F23YTKis/gK
         SMfYaHH9ij9K311ussIuHQvPIPY6cULgBimDsSciAM41RZvCI65Qgy5Bt08N+DyBjyW2
         Og3IJ4bzBYloq585Mok15IeWFf5pazsiSUhfWg40jALoFmSiAGcmApckZRdQ1VDtFHVY
         xjWPiMTM3bYSmitpyJrcvQimgaGQl0R7LdmxyJ7G4SCgCsmo3jl/DwmBw9NyCgzKNZxZ
         EklQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776421009; x=1777025809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L8SAmev4VJJf4i5t8EUbInGL1AJKkZdyx8tFeJUEXIQ=;
        b=A6cGQQd5R/CkyyTiJXDOs/sIunSsQxWU1uYVeP+Bobx2ml8bc1kE7uUCFS3ZBvwSbr
         wUF1hpPEu0vp2vg4Lohnkmi+zCgJc0QuoDjtqSSiuhMyopurjjULsL99sFpzFD/Tww0R
         3QIwRWUmRigb9QD+lotxLY+yWyPIC4pohHAOOy5lIrmhEMnNjnFlBK5To4j4Il/QNatM
         Ql4cofoUw5QtkRf/5wG0HHL/r7L6u37DGkY/Wyt88/Q4XN9HMDPytH0w+CCORvCF/dlP
         L2R5f/NpcmqlFz50b8jXzQ4lhtNuAPWG/viPBNM6/9S0kph5XHedVMQL/FGvjhod6z5L
         QRlQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aUiT6XATB8n29VfJJ/IPRrYLwF+FzIGoVPsJl5A4s7LDX/NPevuPVZMMDEB3BAvdJw5+YiVN6Smc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8KjMZRckndgpBTcP/vpF/0SmnoWravmcyTL4i7nXgxMH9xtYk
	jPLoxzOQfLDxAfdRwhgjAceU6lGUrbO0+iqHFfV3J2ec0esfZW7m2mKi
X-Gm-Gg: AeBDietlk9eqcmxvTIs5DcUehpEAQSOxvNuxpMnmCU5GiiWgFJVu4vAkGg+bNnaSPLg
	fnUUDCRA5VGUMPk9T2amDh+SUl0kZVD3Di8hvtrFlhM5yMQ1SwlGYRXKK5KEhzILdIH7RFbjw9i
	yn4hHpvB72cc82virErNUugx8J/qMWUw3fMpDGLk+eRSub6jk9Llh/WlxQ+Vp/ghsVNnHOxzL0k
	h9ZQv582z2WI4ImrK56eN5IY02o4w7m+joDLJ2QgwcDFoZ/InVjj9KVuLMwJIYc7ZghpQsByTMB
	PJh456QLPvBCF0SskdWGyj0QodQ46dc+cpy9USwW1WrmTv5uRgoXiGtJIsh4yYLgo97oMvoC+2I
	AGxApWaZVznM0dZFZ8BPhO5EGbRlmQkSEIAwqoBLqMMrJrFRWo3zsYDNXu4VJReRq/2Fvq16fwI
	0hmdhcpbQjZt0rZsX87TljY1qnZnovERMWKnBQnh8EhTKQc0Szp5Zn73uD2Qupdl5z+bkxAp/X8
	HAuUdQueyickOQZG+jxBFHUFlCiVfRp2vPkHST+ayuUjSchZZBDjWDvNNiM1OkpvRFWbG54fqP1
	+qNBKVwAWeGAujZVO/kbnkp16qUc7E5gcI87YtnPAw/1Vd/6gRSDG6VrU+p7PXNd1ky5CAt5bqO
	oHbMYzOP/T/E1GM+yT+5vydqdzIxozw+ZiYsRjbYQAArAb8Caarkyu62cVcaQLjob0TG9zr8MqB
	ftzNwei/0=
X-Received: by 2002:a17:906:5190:20b0:b9d:166f:ff82 with SMTP id a640c23a62f3a-ba41916f331mr89383766b.6.1776421008575;
        Fri, 17 Apr 2026 03:16:48 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (125.133.90.34.bc.googleusercontent.com. [34.90.133.125])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455926c61sm38937066b.63.2026.04.17.03.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 03:16:48 -0700 (PDT)
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
Subject: [PATCH v6 1/2] iio: frequency: ad9832: remove kernel.h proxy header
Date: Fri, 17 Apr 2026 10:16:22 +0000
Message-ID: <20260417101623.1281-2-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417101623.1281-1-joshua.crofts1@gmail.com>
References: <20260417101623.1281-1-joshua.crofts1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Remove kernel.h proxy header and add replacement headers (array_size,
dev_printk.h, kstrtox, mod_devicetable, mutex, types, asm/byteorder) to
maintain atomicity. Moved asm/div64.h header below generic <linux/*>
headers. Additionally, add bitops.h for BIT_ULL() macro.

Audited using the include-what-you-use tool.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
---
 drivers/staging/iio/frequency/ad9832.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9832.c b/drivers/staging/iio/frequency/ad9832.c
index b87ea1781b..c0b7852f1c 100644
--- a/drivers/staging/iio/frequency/ad9832.c
+++ b/drivers/staging/iio/frequency/ad9832.c
@@ -5,21 +5,25 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <asm/div64.h>
-
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
-#include <linux/bits.h>
+#include <linux/bitops.h>
 #include <linux/clk.h>
-#include <linux/device.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 
+#include <asm/byteorder.h>
+#include <asm/div64.h>
+
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
 
-- 
2.47.3

