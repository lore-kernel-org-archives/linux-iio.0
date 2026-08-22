Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 829E53AFD19
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787385842; cv=none; b=AlEsQeD/0MgYvxT4x1Tl13ZuU9X0trKFJXW7pmmbuZrxWoWqlorYSFJDDjvMGDpqMSlQVRVK8L1DFWbALcKxJa6bMHJRR4BjF4aTfTQAuqyPhy4JNbc8sLxq8tGydzLHkpKqjg2BCb8rOiVJKVyGY0G+NtfNM0+Cmgu7LBoJero=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787385842; c=relaxed/simple;
	bh=2Jh4vxjGpcUNYNKIK+hDfhJUAC3KtmBpGHc7CGutMmo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pP0VmbHkIKEUTHef9OtA7Zs5zHWoN8A/p7JEjF+fwd6NiczOAtfGeJ/Gi+1iLGwxf/8YJ5OljQCUoRXtcCaNiw5b4Oi48mV4X6+UUnnU/aewP2PDS4f5oxfgQ0k7PFdNGDjId3jTLhm/zbuo8fiH5t3L/C+5xqxmbpmiT0a2BJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJk6lcom; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJk6lcom"
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-6a173ad7cf4so3491780a12.3
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:03:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787385835; x=1787990635; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ZBgca2fvkXuwjiaJHbEr/LM98HvRD39VyZK6yg9cbHw=;
        b=nJk6lcom2FO/MJYlhmPjbWVgu7Gy/SdDwY/31ZzrB27x2dGg3idpmxDwV4L1Hhzf5M
         hX5LQEwQzb7CDf4UbT7jIlW9PZuzDQJN6tyLZbfrmisQ6kTYN0/Wu2ADOyc4YhjLSjpS
         358FsYFYjJU+ipFI7YwB5a1KV4alxt9rBtNEulF3TgXoA9ZU1I2eiQt/sW0WliDaNXHx
         N6rzt6BsaqzEZjG8+j+89+290d+0KwHkPR7cXdmeDlOSB7dgOSzkrGHx68AvCHHODuKO
         Touu7c2qvitlWhoMHYvovrLWJ2udF7otv6CC36fWOc3K3ch8ZwwTKxswMpg8fiQWqrrI
         U/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787385835; x=1787990635;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZBgca2fvkXuwjiaJHbEr/LM98HvRD39VyZK6yg9cbHw=;
        b=BJVt71ggZkDAF2f0vMkuUBWjRqwk7T+Nxax4WwliRPNpsT6uC380+7cC9ZJMnNO7+w
         KStuZDR3xAVs30H1tpeyKhQIQrpDdZfVhiJvMhQMbWI9gr91sSFlNhGdIPNwDbwU5JtR
         ji5tsbcVpKWlSRF6NF2//hM8AElAxdTahJR92TvN5x24XsUjdLCdDO3KU2lWg3tKh3fn
         lhgMH92/HGp7LBNuD81jFZtveVIfmx+MLHIoRNhgScgAMtMhM/en9FakQG8aKF2LfejJ
         VeXr/kzvTUJslMUccC5RmM7wXx8U8LdIHDnSY3UB+LCXXVg9BIj0mElKey5QDhHi9878
         QDFg==
X-Gm-Message-State: AFuF++nyWf0I8kU5hhv8vgRx4rlZ36DcZZBXewKFEBPZdoZUSbvfHYHf
	0h5RSLlqF8zab8sTOahrP4czL3V40txBq1BgWYVO1XD/dU++BMwtv+rQ
X-Gm-Gg: AR+sD110HOIy4lDCU2HqNoN+61DgRKX/K0lJOzzL6HhOWygzpoAETvIFXmV3STiCMvw
	bwJraYwMTOHh89K9O9jKHFMP6rcTRj5+8vPtWMuMTzchzJeMEjoTVUs9DetW337+dZ8bbARrEAH
	03dhfvFYaHX9HkGFjN1aDH8aKX+Z6PGuwX3queYM6S514GCtXGH70KWhof6z0bvZr2jVQvqDqVz
	knw9qbJ7l9wyV36RhiZ33Vb8+tZf9J6B6RaoRZiGk7Zad3O2EUV7r0CArK2HZp4WS29iLTHo2jB
	PrhNZtCTBP7sK4eNjP4kmB+smIntbilVMDOwWSz/aIiHIqhF3qA0Tyx/XD5o4PmITy4vMNkOOeK
	NWFVgk7/aTtF73XZtd7t2herNUYahkOOsRVTsR/+xvBiZuDpL8BRTGH4e5KPD8qGyP7u6HNq7+x
	Zlt34+gINPOJk+SV1QgdUEkIjFcB+fG1ijUWzCJZF0VI1O6iqk1di3aOueSjDw7keRPinfKGpS4
	J+MAXD+Ub3ba2cWz2Ia/MlFWZGmPl1b0yNMUHDWqHhihIJ8wskOOrL4pN2hz1s99+LHP4pQrtEV
	6j1ipXkhXAC31VhTrimH3aKkNg42gFf8W0X3npkJjmV7i9w0C5EKCX8vAdgh0fU/Htamil9dWFg
	H19IY4y3YB1mUhBNyuK9xAJ0q
X-Received: by 2002:a05:6402:1ecb:b0:6a3:f74d:6a47 with SMTP id 4fb4d7f45d1cf-6a582987b8emr4504442a12.0.1787385834842;
        Sat, 22 Aug 2026 01:03:54 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a3feeca188sm11114235a12.6.2026.08.22.01.03.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:03:54 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 22 Aug 2026 10:02:39 +0200
Subject: [PATCH 12/14] iio: temperature: tsys01: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260822-kernel-header-removal-v1-12-ee31b124be11@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787385823; l=1467;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=2Jh4vxjGpcUNYNKIK+hDfhJUAC3KtmBpGHc7CGutMmo=;
 b=5BpTYKxXB7oAx9fUtBQm+O01KiTYq6cH1pzVAiraWvIJMAVI9dVkHRjTCNJDNQrOU5p9mDqqR
 REd17tTtTEnAEbOT8p5sYnFtpA2sTYEK4+NUaitl9eAxWaFntwtALP1
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header, add missing headers and remove
unused headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
- <linux/i2c.h>: for i2c_client and i2c_device_id
- <linux/math64.h>: for div64 functions
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/device.h>: not directly used in this driver
- <linux/init.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
- <linux/stat.h>: not directly used in this driver
---
 drivers/iio/temperature/tsys01.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/temperature/tsys01.c b/drivers/iio/temperature/tsys01.c
index 14de67ee8be7..4b8c2a3287fc 100644
--- a/drivers/iio/temperature/tsys01.c
+++ b/drivers/iio/temperature/tsys01.c
@@ -8,12 +8,13 @@
  *  http://www.meas-spec.com/downloads/TSYS01_Digital_Temperature_Sensor.pdf
  */
 
-#include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/array_size.h>
+#include <linux/dev_printk.h>
+#include <linux/i2c.h>
+#include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
-#include <linux/stat.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

