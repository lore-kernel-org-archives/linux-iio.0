Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E0D23ADB99
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385836; cv=none; b=oQ3SmPE5DI+tbs/YrUilRMA+cbhc1GNFru6LGL5VfMGRDWNBF2PYKKnGjtRibU9uVUr8Kk/OQF5rtVem24idalwQlhP/xZNS6Ztxzbc18BuPzutlwA+j1DkOM76aIO7lMAPCOOdymz2s/cLuBghif2X5cAqQmJZnPpWj+Eb6zKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385836; c=relaxed/simple;
	bh=Aup1Yjuhu+cqqByVfSlcvOh4RJC/seOs9ArHyAUDofs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=K8l5MECf6q76+z8CcwNcobQ2W9DN8YfCB0c0hZLfFHcjZ0k1LpG6ppiadm6ttBPaI3/4z/yJZRH3H1dy31UCVc0T4hScMWvSnTixM62nmfx6XVUXl23wL8IWkTlZWnQTtXbBEPz10KP5eKe4e02rUEPLVCi0lmyHxmCy0Hh0IQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzcLFRb0; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzcLFRb0"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6a18e24ad25so2513431a12.1
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385830; x=1787990630; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CMgdbm5JfWfswGpj0HgkJDCnsxJ/CXYgBjNXOsNGrqg=;
        b=DzcLFRb0AIPHOujZvHXvUlfZYyue6WTCigkwdu2IGY0o4yAt6N/1ePTrVxrrb5jSiA
         k64OF2jaW+s4lDaTKl4ao9/2RYFwDCItXF0cmL7oI8KoRf6k/av1M9yaqDbm3/niA6Dq
         6TffahRzZf68bjSg76h9GIqwmiKXt9Ur2Lbo9J3eu3xfzm/h79nxz/HdDp2lxg0CPxtg
         wxqsfNt8zgEOoRLtLlroSKlGhtMCMfoSSX9AbmsoYrnKtbzUImUohi1A/rDmNsVb727v
         fLyw4zIxbFF+zc4tu2Vr+CzQ9MTUBkUS1ITpueYUq5+wJFrcRsF3U/xWKDlEcjgmRWtR
         B2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385830; x=1787990630;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=CMgdbm5JfWfswGpj0HgkJDCnsxJ/CXYgBjNXOsNGrqg=;
        b=IOWhRCWSWFy4Jpj3N7TL9z5f5ANBLdgAH4iTx9ScxED3Fw2h1Jhp/glzyD1csF4/eJ
         P3srFzlcxdsUrcErO7CM0dfgOBJd3Iql5Js6sonc8VpAvYgntXEwep6OO2YxeqlxwWG5
         AOGmUWsN+MqRcdH0vbnMpQdbs8MLses4s/ovj0chbwlSC33rpbI3CaAbDoNCof6doboE
         5ngI4T5QhGqnGmUdGKkC3Erw9jYrx6Gd8TS06XFN/tW1mdg/fLMbg8X9dMBM2IvdIDQm
         3HMg4y8QI5yXGgNPGQmPVJOlTQab5bJHKtII15aOOvG5V9kKAJFHZnjL7eOKH1AhAROu
         6ZYg==
X-Gm-Message-State: AFuF++mY622X7VJ+NVRdm3gOU7AdbRv5QxubK67LILPWHsp4FR0KFzS+
	RBBZQ4XgpTF+nHjQYu1nBstXXpFFO4CgqbkNfF50OFSohYUUj4R+hvuE
X-Gm-Gg: AR+sD13g3gnvOJq72wneMCMyXyvZ3/XPiOHPDtGmQiNmbyKlVKunhXZxa9IRxzdqCKa
	EHm3gX2YVNg6MMUC17MpcTY4rI851Dp0WKUyLdr50g1rwirPL4b2ZV0n9fmUUwLEo12Xp8jgz8D
	Y61c8QdcTweDgGeXF2mjHko4apfKikysWperWmJUpCdw1ed0mBDwRxd43bGCadf+aV15nx0f71c
	fTlLnALI9gT9+Ej5wTaivl78ewHzehCxM63tXO6n/tN/4QliBlyr3hRI1nWUgmwLLEkl/F0+KP+
	gqPYbfR6JZahB2T7P2YgL8EzHpIIBzSNkkde/N+B0QRjOUA+Aw18VgST+MRHFw/1sDQMaM/jFxg
	F9QTRLGy6uOqytz5ci54jD74BgFlyvvCp+0sAnbTDKCNqwvSlEzImGiCMIedBSWdzNqPRqhIh8A
	X0F5QOIO9FBYLBoSqUm0no5bGPh7ukaNT2mKb4ZwTl+hrRJAZbCqjgp9QkOfdKkaLRMdZ3skBwb
	oWxZqIQsT9wRZaESERK/Mc8ZEoBM5TTwNjCzjloCNNmtnPQJUut0PAshNBOmpfmyAh9uoiHFlw9
	hlvN1wdSFrO4UeM8BwMXd5y6BragRiTmPUbw4jTuds1IvAN0QKL+QcJAYn3KrVu66MaOg1NilwX
	6JblWmv2KU68iZbjxKJypV76e
X-Received: by 2002:a05:6402:a0cd:b0:6a1:babc:5b9e with SMTP id 4fb4d7f45d1cf-6a582b0b815mr4145650a12.5.1787385830258;
        Sat, 22 Aug 2026 01:03:50 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:49 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:33 +0200
Subject: [PATCH 06/14] iio: temperature: mlx90632: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-6-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1496;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=Aup1Yjuhu+cqqByVfSlcvOh4RJC/seOs9ArHyAUDofs=;
 b=gKE5hZ7/jKhWqTlG1HYm3svTRf+qUBwmSrnUnVrR/F8vBdZak/AALgkRKiK9ewKy8X3ai7IFt
 JZGgzVDPoPzC7gGGCQ5jsyrN9N9e6mP7Sf3GSqYmUmrK/jIKnR42gND
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing headers to
enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/mlx90632.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/mlx90632.c b/drivers/iio/temperature/mlx90632.c
index 73c935364d33..bca31c4bef00 100644
--- a/drivers/iio/temperature/mlx90632.c
+++ b/drivers/iio/temperature/mlx90632.c
@@ -6,7 +6,10 @@
  *
  * Driver for the Melexis MLX90632 I2C 16-bit IR thermopile sensor
  */
+
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bits.h>
 #include <linux/delay.h>
 #include <linux/device.h>
 #include <linux/err.h>
@@ -14,13 +17,14 @@
 #include <linux/i2c.h>
 #include <linux/iopoll.h>
 #include <linux/jiffies.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
 #include <linux/math64.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/pm_runtime.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

