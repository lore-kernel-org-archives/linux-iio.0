Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF6603AC0EF
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385832; cv=none; b=oDkVbc7fZid74NvFvUyCMCk0Bg0j/09282t/ySa3sexwW9lDgvSyAnuSf1ye8r1qV6Gm/SMfxWNzrWFeYP9vLNBJUWQq8TQmvLB+GZOGQJZ5j63p2TOQ/rMKe3HUtiIWzSFmKz3XI6QdmwgYDGrVye0nvqyp44wk3sRZBGSBC4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385832; c=relaxed/simple;
	bh=jW53cz7kjVnoXurd4I3ohM3xctyABDVxUF7y45R7I8I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Pfl0/zpkLycXmgDtKFt+MXLKmrd/6otJLQzF4iqmXZkftGrUfurOqmOHiwO6zkpkNHVTk8EC0HFWhFCzUlHEvLhO9M6vZDqN/Nb7KmGd3KHkWhnhYcHz8Eqv07DjTimWiUKCBSNLhEoKQiUdSCV6t5TGyO673+D3jMCjgnJ+1Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bi+T3pgo; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bi+T3pgo"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-6a386a34603so4270135a12.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385828; x=1787990628; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=w5xGBgSpjI6ilIuBwW9NQ1zMvUmD0ICcrq8TK/D9+gk=;
        b=bi+T3pgoHAJx/gS/Jd3nxUoZ9Cd807NZZ/m0JqUWizLej3B4CURmpD/x2ICl2G8JL3
         p/YbXA+7btTvXTQ/Rn3b4d3OToZblUHCkXJPoNvhgj8rtnL2EMMNe3qgQ5p5wg7U+PC3
         o5Pd1gaBfEpd1kRfhKaG+YcT+wh1HlH/KVybovb3KqdFjpEbiifCMS3hdGZFuycXt8VR
         TY3/RVUIx32rmdWVKjEoS4av8mQHJLyJaf5BJ7XW5Sj4mWkSdIlWKFuMGpxhJAhq/C8V
         4vQewASH3Qfhnor6VSVreP3ezxBHLEhwFC6nsFslJXEmhXzqbrsQdH3rxACKYR8xfAQE
         2BGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385828; x=1787990628;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=w5xGBgSpjI6ilIuBwW9NQ1zMvUmD0ICcrq8TK/D9+gk=;
        b=B0poun1oIGsBidz9rasERSmXXZEDpTmCYYlLseZNpzyD1A2brx05eqrFSAYfWYnZQ9
         9lRaT5VdmIuCrMWALuuNW2dUtoPJRwj45BhjdyVdc6b2E8EL/X56/Z6Ykm3X/9QMO093
         xNSJSdeVQUST3hBnedMhmQNCdHuUqdQ9wbgPdmd9FwR05ZJciP+3G6bWyZddYHagtgSG
         jg9df7G2bP2ExIpFOW28GSegz4FZzPNUCs89X+Mg6vaKOefvfVCXSTJGm1RM2tRf1zkT
         Kb8lpJsILPaiKaqY0jezNXKlM887wf/InaoVMKM/NM/kvcBVbf4Az6No3bRVJElCwG01
         mo/Q==
X-Gm-Message-State: AFuF++lscdf6Mc+ZPsceLBv2vGFO07UZBEQ965rvHC+HJMLAEntFMoOQ
	VIK5a2PpD2eJmb1WNOU6FS9nTtJuNRV3QtOxM8ptqXLHzd7XNGi6WNut
X-Gm-Gg: AR+sD10YHnlnqa8QCu478PfryJ2FbprROa3tnIGIMSuPlOP/8GUntKqau3RpK/CuRay
	HUp8S1TkW/PjeHqI0MWyC8Vp6tukG1vSzaYGbtJUICUpiqFqYOlCjlIlTNzR3kd/4tao8w4eWrR
	tNK3VIHP5pdrh+Pas4rL3Bi5lyZYCVQwlZX3NaND8LSjL7OdhdStShUwbaFG43oWKG/qsySy2Bc
	Jtp00GR3IUltRwwS5gqM2RK5X/iYp6X/LdmE4aixyf5NVcJM2QIzE78DWU3LAhVt4l0/Y2IYDTI
	oWdVC/BTFBMl6bmd0a4MfCLbV0hZGUkgTB64r327EaTGmjid3lmOPKXCUuIQ06uNCGkv1wE3lKl
	rFWzi/IMLhhfODURa1acAumNOfWPJ6YpgeUZtNTzMU9FOSnKZc6IgT4u42gBYw4buV+1lN3s2eP
	5G+xBDB7Q0MyQwTiipcDK66Edu4sHAvlDuw7TWnvDNozAZEoM/nGBGmzrpqb42Nkf1vyKpz8JvB
	OifzlnOT2Flf3+NmJ1PB6RqzWJLTmOu4C5e1vUwU4Tt4YYu1q5nevUy0NI7AGaCA12zS1zNnGCt
	IkqHUDnqWUEGbWIXzKb9RwRg9U3VLGhVw4F4r49NCm/YpVgkuGtbCd6sGZKQHTynRrGbMfA42qw
	jHCEVFResEwFSS2F6XruN3bbd
X-Received: by 2002:a05:6402:52c3:b0:697:8b0c:36e1 with SMTP id 4fb4d7f45d1cf-6a430bf0c5fmr11106100a12.4.1787385827830;
        Sat, 22 Aug 2026 01:03:47 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:47 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:30 +0200
Subject: [PATCH 03/14] iio: temperature: ltc2983: reorder headers
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-3-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1026;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=jW53cz7kjVnoXurd4I3ohM3xctyABDVxUF7y45R7I8I=;
 b=j1TtJmtFv9AW8RE47fdwd3/u4qZurbUE6yAsWrOG/UEz+8Xegz3x6gcD7APvZ2HPw6O1Lzx1H
 dlP/wWOcFOkDwHCEvgoyQV4HNShw4tHzws+YtELrbm1ienm8QRSYnCi
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Separate the IIO specific header and group unaligned.h with the other
generic <linux/*> headers.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/temperature/ltc2983.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index 6efb5252a773..fe9eec3058d4 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -11,7 +11,6 @@
 #include <linux/err.h>
 #include <linux/errno.h>
 #include <linux/kernel.h>
-#include <linux/iio/iio.h>
 #include <linux/interrupt.h>
 #include <linux/list.h>
 #include <linux/module.h>
@@ -19,9 +18,11 @@
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
 #include <linux/spi/spi.h>
+#include <linux/unaligned.h>
 
 #include <asm/byteorder.h>
-#include <linux/unaligned.h>
+
+#include <linux/iio/iio.h>
 
 /* register map */
 #define LTC2983_STATUS_REG			0x0000

-- 
2.55.0

