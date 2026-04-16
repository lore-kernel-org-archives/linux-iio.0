Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1E939B95E
	for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 09:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331990; cv=none; b=sPaZVdyAepTorG9kSeQlZTPPTw0f0mI+2lzNWEcBmbjUYM1Nn6QKQcc+ZKiggqfZq18M30WHKtGlufWZvEIQm/6Ho904eTNHIHJhXEOjpXVB5TGksSm+AFoe5IpQJyHU/aGK2SCuC9ibeuWbWSjzZIWsL7aeAMx2hTBL8Hy4uic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331990; c=relaxed/simple;
	bh=lJrC90Eolo02AQW1DBzzCXYNK9+dbxqvWdp0pp+6pkA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kkTl943POpiIQhqCW57XiiKcvbw2lJOjnG2a0WiqlLEKDTbMi1NspTVEfuio6/PSaD2vV0UbtBfu7aWEiAQqo2yCbFMdy04sXYV5aRfW3sFamy2GJBZUTKhPGTIyO4gHKIrirQGjbU39prF/UUvv2OzBz7MLgR4nqH9BAz50+6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pp9ioniF; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pp9ioniF"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6725295a113so2677031a12.3
        for <linux-iio@vger.kernel.org>; Thu, 16 Apr 2026 02:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331985; x=1776936785; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/WLv29opBLaLg3QT02xeIvS4ydIjoZK67hcbphIn7M=;
        b=Pp9ioniFSEJ/Nre3lN5mDeenZK8XwNakrMNZbKV46mDVyRCHeQ6l4T+oBJDWLLTluO
         6MW+enVrqSec5JU6Ag/6z8UskiiuAT/Guf/uoxXXRPPRCx/3N632BRhe46Pk5khxqbq6
         UKtXPBYkOTCkf4i4t5xl3dZcJpcZgkzXaS4XVZt9l7pJXSI3kT4AMG9KTZdHw78X+sKk
         9XlPreRGvQoI06Tcrh6qDFlmAbC8Bf2hq4+edTDoGuenHXoPamu5QKFSS2EChfNmihd7
         Nybcudf+mwJJcwMLZ0xaOXWiq/iCKFS2ySrAPCOTyEnUniiKvGsa3sJuSE7hH3B9Q8wW
         Qq7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331985; x=1776936785;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D/WLv29opBLaLg3QT02xeIvS4ydIjoZK67hcbphIn7M=;
        b=ZFK33vEt+uLoyS6euEoDc2k9zAxuqipMbfyNfuwcJUnNaM8cGSLh6LAPIVpX6qiMrx
         WJM7bl4znvNffa+TpEu5wdQt6qatfZP//U7XRS2xna1UzxAk6+FjfUJAXhpMSV8rdrh0
         PtA58MhuyEXq+xzH+GqtTMzvJmhub2R1TfDOLEfrmHUf5zOJeihN+4Jj4G0n0guhNjDJ
         4Mkozi0Gv8pKOLqvzeaAks5dGdgYxim1CpSR0XmIN2tzjlkpbwL1GN3BCVO8R5ANndoK
         OHgYhEYT608DymiG26MTKJPDUghEiiDEXK9v7WIdhNoAlzOr1E0TyvlG4JXrHGxUVIRO
         ZmpQ==
X-Forwarded-Encrypted: i=1; AFNElJ8SDBb1UWe+yqkKoVrjVMwwAmety20kgBvxd0EZAqR4UxoE5jZEITmP+/hg+ttLpDtISQSYlLbau08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHCa5dCdH1UoBGAmDWHasMOx/+n3OkdU5+sZ0jgbg4Cp7OYyrh
	YE2tfwgdyMWG5zh6cbTxlEXCprsR1bjHUn0005jQfZk8WSvQj/0p+fs2
X-Gm-Gg: AeBDievDr994QujToQ7IpO1LLewaCtd1UKK0DonpScJ8PKO/0Ft5H5vJv/R4cofrWUY
	MM/FvRmsl1Uc7M/4KhYgvZcol2w1vSR8wdE/e0lUzs0ff6tlVXtRs0uOzi1yZ3pIiK2H57wm6W/
	PTB25fi9oOyc5eZHlJq0Bl0Ef9KNNIaHLIcCnIRfo0YfA3HhYMDoWrQS82fY2YNWkkq+Bcitk5o
	kUOk7BzDHSPAwp/RiPOV20HxLJby5TEXGGYC7tt+K0g6XImJSBxYyDQgsfmA1KFEpdxRLnLOyOK
	70BK5VQ6fwyxcXsJx3vIiGbQaPUyobb2kjRWJTD5pMmJaHgng4ToUHlGlD6cTIZmVE1stDg6L49
	Ex9jV725xitwNk0tB9qZJOlTFCKBaPApgM4jLPtnqMVQ3onWoUsUuIjs9UsdFwZ/L9xSw1+hFw7
	uJ4BRgTT65qAVx6ofwDzTunWfDC2kjRziNh8vKY0G0Bu0PhFfmcQZul6SASZQ3NZFg8o/W7b0dr
	twR+96+qrC2bAIwFGkz48TGtlcumaf87RrNMtnuopWo43zMcyZkHLiJkbhAorw7pmFmaHa0DIfd
	qjSbQu7ul5laZypJlpIODzmXjSO2p9gRO5Ic15y4eFISKB6MGRcFB5nPaQXbi9s6LLXq8aKxZ98
	/lTtnE/A6rff66vdGneJ/yJCmjwDN+zq+QunPwqqgKt0yihOgdbh6i9WU5Q+a8u8f6yvnPITc+A
	tKgLJXtYVRIQ==
X-Received: by 2002:a17:907:c28:b0:ba2:5226:95f8 with SMTP id a640c23a62f3a-ba2522697b1mr191285566b.23.1776331984454;
        Thu, 16 Apr 2026 02:33:04 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (103.146.204.35.bc.googleusercontent.com. [35.204.146.103])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba1773c352asm146591466b.32.2026.04.16.02.33.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Apr 2026 02:33:04 -0700 (PDT)
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
Subject: [PATCH v3] iio: frequency: ad9834: clean up includes
Date: Thu, 16 Apr 2026 09:32:40 +0000
Message-ID: <20260416093240.1294-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Cleanup include headers by removing proxy kernel.h header and
unnecessary list.h, interrupt.h, workqueue.h and slab.h headers. Added
additional headers that were previously included from kernel.h.

Verified using the include-what-you-use tool.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/staging/iio/frequency/ad9834.c | 21 ++++++++++++---------
 1 file changed, 12 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/frequency/ad9834.c b/drivers/staging/iio/frequency/ad9834.c
index d339d5e8e0..9b65fbe1c7 100644
--- a/drivers/staging/iio/frequency/ad9834.c
+++ b/drivers/staging/iio/frequency/ad9834.c
@@ -5,18 +5,21 @@
  * Copyright 2010-2011 Analog Devices Inc.
  */
 
+#include <linux/bits.h>
 #include <linux/clk.h>
-#include <linux/interrupt.h>
-#include <linux/workqueue.h>
-#include <linux/device.h>
-#include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/spi/spi.h>
-#include <linux/regulator/consumer.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/regulator/consumer.h>
+#include <linux/spi/spi.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
+
+#include <asm/byteorder.h>
 #include <asm/div64.h>
 
 #include <linux/iio/iio.h>
-- 
2.47.3

