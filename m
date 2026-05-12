Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72D3672AE
	for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778571315; cv=none; b=glaHYgGK/YlbomTD/oEY7wssMAHc1cGdXtIpSqqnLH7GJENDsq7SjNrSpLapn9CfSC35gdSx1Ofkgq4CxNKBWdqGyitMe++XBKkAg+6hEzSZn1Pqg7O9NWCf1OY+lfVcVnysnoNGEP7nHk3rHInM07apwvKeuB8wtZDCjtRfXAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778571315; c=relaxed/simple;
	bh=fbdh9NQNpS4/2osYLzPXwMe0njkZEUnNjRMmIq7Gkgg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=miy5XTDa7LtMXvyPFdUtg4GWv3736Gn6DMRRHTuG6Snrk01kho6LupSrJpuIxFg7MFcpJ6fQhhUJTnQjQIRgt3LWnlKk1tn+DkgXuxS+IAzcwiCJxV3pFdg2hr0WyqapzGv/DoS18QB3Mx4yRXV6aslNmkojKahO8OCJyDgBZyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OMyaYm+r; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OMyaYm+r"
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-6763cc8775cso11102066a12.0
        for <linux-iio@vger.kernel.org>; Tue, 12 May 2026 00:35:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778571309; x=1779176109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GJ29S31AhqL1OZChggRVRngpT2QA4nmXZsLCEt5Ynts=;
        b=OMyaYm+r5XAf3yjPXIIw7KNJF3w8q+UmxB1WMSyIuaZ55FF1C7Pddy0CCZwpFWTvtl
         wkwmdhjdPGQY1JUkX7b3jLDdYSEuP2g7sI2QrZwNVI876P/ljiQjwkoPbciKbw7b4af3
         gM1LuuaLyXwSWuUwvlsMNcbZQEzYt5m5Kjwz7JeKcG7tZQF+W3LgTd2a5vDF1qoxnSxe
         HTwgrDCFMNz5tYQd7l6zAnZu+ntpEdRa8rit6AOkbZ/XGigIseOLP45LJHzW2vuZuKGZ
         c63+byd0rOROCdHdCpoZd5ow0Z5/4QGdGHMt/P4h6zpm/aWlk+qMa5+WwyeFgDgMm97s
         bvpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778571309; x=1779176109;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GJ29S31AhqL1OZChggRVRngpT2QA4nmXZsLCEt5Ynts=;
        b=P6JWp8b0c8tM1obWIbWVdj/YX7FX8a0WnyHrYlrUilO0PZk1/yvbscEtS4LwBxsg+/
         6pizXzzYvrB1KW94pzBEVZzheXMg9NAbszuZJqIap+1sxW0ZJ+kenlBZG1CBoVRNDtEb
         GeBkrlrX0aMqtAT+gSirpZkQR6BmgM9GXahi8mm7hO5k8uX976dikc9R1WyV9Uc4yKj3
         dTCRdGFrGM8gAcM+PEAGBlPveujZUEjdO2xUXwVWxVFkna8Bq9xK/47UyVEQfx2sD9qo
         Mx/ECHsIrVkbqUz93N5qntuKGgaqULnAhQgzgpAQQ7P4ic0WbyBTrg+8nyXloS4WPLIp
         UGcw==
X-Forwarded-Encrypted: i=1; AFNElJ8nw9rixjxnrRgZyY8kxBoPpSrDAkaF49EIzVgTyYvYwvVpjE/f0Bh+X4diP0sjknSVG7z21xcWD8M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxyGwONzzbYvUQoSCATLTArwRfvZUR2l3q/KIVPFd39/TejWPpc
	D6QZM3RYsYBXAZgeAXjNIG7+2Qy0tUSFTEqvkD/ssgHGzEmAcDj/GLN+
X-Gm-Gg: Acq92OHCfgFAbuQ6+X0/ulVmd95Su6QMGpi1zNyL0lzghSGhmEVmi7iw19p8Q9Qv4DL
	WRX3B+AQ02qCeAv6c0aq6mxdDNQUt9BwZf2jcKPdHofrxh8LdchFE8OrtOY3sdrfxXoabVJE6DW
	2uskq5dYwxiU5jsPPMwFQtNkDpDKguOQpTkqP8j+ba42/lEIHxBiiRkoqNPGWkBtJM8RbARtogo
	vlBabSO5MkGWbVVkq5WKuCHw83SSKdcU1QKKWE7pVlkbwnhoFPlrQrRbcyr1iCBYMoHlk0rSzI3
	LOs4HwxZq+bhp7zWko7qmuoLi9ytPDTD/bokvoF6iUx6lHuWEx9KqYhsAxcNh3uyFdwTzDm81SA
	sMeJgoawQMFW8uEqrwvAbXDGQIb2vNpnpz7LigOz8hSddtGN7iOR+71j8NYN2pqFYQiYFRkHHfo
	qkCVtyqFM/ExjYPeI8/RaPSGvOgTabbOAr/NGc6JFaDLCqfVxVrUA5MXLYMC0xBhOZa4gRcfxqA
	AZrejDtEtm9uUi9Lhr+qORQT0TCHCNhSDojCZ8PrX4u2JsrPCJm1u9V6jdhEtyINm5mqxjc0R7D
	hdhUcFz7IZ5eUimpBzOr4/oLpZ5kQr9q5aXqjhKIjFmHOBkEvCb5kHVl8jZ86HR2eYfeqwvFQu2
	JVNHfsQ+PenQOfDFGey6gNgTzefjTye5zxPR2T83LDVAXWmEKkl41lUgHmTY9/CajMS40KwQjud
	XsGty6
X-Received: by 2002:a17:907:d388:b0:bd2:be3:572a with SMTP id a640c23a62f3a-bd23ae13deemr174038466b.6.1778571308354;
        Tue, 12 May 2026 00:35:08 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.oa7bb030819b2a894-tp.internal (28.170.91.34.bc.googleusercontent.com. [34.91.170.28])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bcbb2b1c3adsm538796266b.35.2026.05.12.00.35.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:35:07 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] iio: mapping file for include-what-you-use tool
Date: Tue, 12 May 2026 07:35:05 +0000
Message-ID: <20260512073505.1310-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As promised, I'm sending my IWYU mapping file, based on Jonathan's
version with a few additional tweaks by me.

Other than adding support for more assembly file business, I've also
experimented with individual symbol definition (see BIT() and GENMASK()
in the following file) - this is to prevent issues such as the tool
wanting you to include <linux/bits.h> when you already have
<linux/bitops.h> in the source file (I agree, doing this symbol by
symbol is tedious, but BIT() and GENMASK() are symbols that especially
do this, and they're included in most, if not all drivers).

Feel free to improve this file and pass it on. I wouldn't really fully
rely on IWYU as even with the mapping file the results can be weird,
but it definitely serves as a good starting point when doing driver
cleanup.

I'm making this patch an RFC - this is not intended for merging.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 tools/iio/iio.imp | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)
 create mode 100644 tools/iio/iio.imp

diff --git a/tools/iio/iio.imp b/tools/iio/iio.imp
new file mode 100644
index 000000000000..c8e9c509bb93
--- /dev/null
+++ b/tools/iio/iio.imp
@@ -0,0 +1,46 @@
+[
+    { "include": ["\"linux/bitops.h\"", "private", "<linux/bitops.h>", "public"] },
+    { "include": ["\"linux/bits.h\"", "private", "<linux/bits.h>", "public"] },
+    { "include": ["\"linux/byteorder/generic.h\"", "private", "<asm/byteorder.h>", "public"] },
+    { "include": ["\"linux/device.h\"", "private", "<linux/device.h>", "public"] },
+    { "include": ["\"linux/ktime.h\"", "private", "<linux/ktime.h>", "public"] },
+    { "include": ["\"linux/limits.h\"", "private", "<linux/limits.h>", "public"] },
+    { "include": ["\"linux/mod_devicetable.h\"", "private", "<linux/mod_devicetable.h>", "public"] },
+    { "include": ["\"linux/mutex_types.h\"", "private", "<linux/mutex.h>", "public"] },
+    { "include": ["\"linux/pm.h\"", "private", "<linux/pm.h>", "public"] },
+    { "include": ["\"linux/sched.h\"", "private", "<linux/sched.h>", "public"] },
+    { "include": ["\"linux/sizes.h\"", "private", "<linux/sizes.h>", "public"] },
+    { "include": ["\"linux/slab.h\"", "private", "<linux/slab.h>", "public"] },
+    { "include": ["\"linux/spi/spi.h\"", "private", "<linux/spi/spi.h>", "public"] },
+    { "include": ["\"linux/spinlock_types.h\"", "private", "<linux/spinlock.h>", "public"] },
+    { "include": ["\"linux/spinlock.h\"", "private", "<linux/spinlock.h>", "public"] },
+    { "include": ["\"linux/stat.h\"", "private", "<linux/stat.h>", "public"] },
+    { "include": ["\"linux/stdarg.h\"", "private", "<linux/stdarg.h>", "public"] },
+    { "include": ["\"linux/stddef.h\"", "private", "<linux/stddef.h>", "public"] },
+    { "include": ["\"linux/string.h\"", "private", "<linux/string.h>", "public"] },
+    { "include": ["\"linux/stringify.h\"", "private", "<linux/stringify.h>", "public"] },
+    { "include": ["\"linux/sysfs.h\"", "private", "<linux/sysfs.h>", "public"] },
+    { "include": ["\"linux/time.h\"", "private", "<linux/time.h>", "public"] },
+    { "include": ["\"linux/timer.h\"", "private", "<linux/timer.h>", "public"] },
+    { "include": ["\"linux/types.h\"", "private", "<linux/types.h>", "public"] },
+    { "include": ["\"linux/uuid.h\"", "private", "<linux/uuid.h>", "public"] },
+    { "include": ["\"linux/wait.h\"", "private", "<linux/wait.h>", "public"] },
+    { "include": ["\"linux/workqueue.h\"", "private", "<linux/workqueue.h>", "public"] },
+
+    { "include": ["\"vdso/bits.h\"", "private", "<linux/bits.h>", "public"] },
+    { "include": ["\"vdso/ktime.h\"", "private", "<linux/ktime.h>", "public"] },
+    { "include": ["\"vdso/limits.h\"", "private", "<linux/limits.h>", "public"] },
+    { "include": ["\"vdso/time64.h\"", "private", "<linux/time64.h>", "public"] },
+    
+    { "include": ["\"asm-generic/div64.h\"", "private", "<linux/math64.h>", "public"] },
+    { "include": ["\"asm-generic/errno.h\"", "private", "<linux/errno.h>", "public"] },
+    { "include": ["\"asm-generic/errno-base.h\"", "private", "<linux/errno.h>", "public"] },
+    { "include": ["\"asm-generic/int-ll64.h\"", "private", "<linux/types.h>", "public"] },
+
+    { "include": ["\"linux/iio/types.h\"", "private", "<linux/iio/iio.h>", "public"] },
+
+    { "symbol": ["BIT", "private", "<linux/bits.h>", "public"] },
+    { "symbol": ["BIT", "private", "<linux/bitops.h>", "public"] },
+    { "symbol": ["GENMASK", "private", "<linux/bits.h>", "public"] },
+    { "symbol": ["GENMASK", "private", "<linux/bitops.h>", "public"] }
+]
-- 
2.47.3

