Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510A94078F6
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020778; cv=none; b=NHZ5aOhblqDelbcz49ED4B6DZ4x5zkZ8H9ftdwm2XxVBvrLIrvPg/6sI21WThluZwzO6L7Ibmir+P+aefZP6xCva38XmM8N1jjM1/9iDanItTI1V/VjYbaG+ymCyCEko5HSZJmrPJZHMGzOAKgLrXMcF3InsZaOigeAAd3tOvr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020778; c=relaxed/simple;
	bh=5XLKjOzOTRwerZYjWQlSm0V6kefuJzxf5B3r7vswQh0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Hyq7u5lckyDkNdk2ZV+Nou/F++9V6vO0GVjjFP92X+zZtLurklpF2XtV4Z+6YCgQgX9Es3Oacibtye1314Zjpg7j8jXsCZ/W5jEftC+mRkD61uQRZ/NuNtfWSJWzGP+c1PjzrHG2EJoRuvWkExnip1cJkNreUBRRER6+1KVT6gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DKH9wMXP; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DKH9wMXP"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49b0dd3c9a0so14541855e9.1
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020770; x=1788625570; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=l08v+DWhMTTHzUO00k+LB67tdNqKonKDnz7vF0UlhQU=;
        b=DKH9wMXPpAsByaapCenOkD2y6tQvWkKohy30a0Ug9AgpLeCq3IMVup4lQBD4fuxVk8
         x4hnHDWHxtYbrMYl2DLkHIaB/zdB1zc+/QN3DBhdh7cKxgH8dFY0obw+zcDhawx+DTi+
         t7dSlGy9hDbFO4OLMsPsZyT/oshOZHjJNjBhz5TTDEbu2qN3NIbYjy1ow7acCE0f5jXN
         IRekO3GjtETXu9DhquWXcnIEVIYTp7WSc2NeWuT4JxgsSqdpUnMm606/TrHUCunM8cRR
         CRBDtim4pedrqHJ4qk2RFYk/An4rWQ/F0qPpImGFF4K6dxe2/GreypfIYOZl7YlEwZ5x
         3tIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020770; x=1788625570;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=l08v+DWhMTTHzUO00k+LB67tdNqKonKDnz7vF0UlhQU=;
        b=WBTqw2plXfS9/S1bzTcUIjoFskM5Xb28g0JgdduQTZErS51Rt6j9v4B6UQzIdQFThN
         QhNnerVr/2HuWVOxPxCF9c/2uf41I4LS1s7WdyRDc81e1OMtElRREEiEpN+e/aHzSNAr
         AAGqm2Ap8cQ8QjiiAhIobvsajZQd+S+hQOllM65ve3Iz33KOiI4qW9+u19VBuqMXke8C
         xcxixjr4AZLcsHbRVXPOnbNdc9Ws4XXk0RHUmYu9FuVuAbOWuGpwoLJnK4JKj18CO7kG
         e9IJh5v/odT5owq4QiAdqunsyY5m/j/8QzFep6nUz1aGJ3dyuO39DdDgN28XKMfcO1HM
         +9SA==
X-Gm-Message-State: AFuF++lzXK3oDYW3axCScYjfczqtQ2f8hQmKk1cJeuiCWyNunbAzGQnS
	QrgJCUASTbrgtp2I77I8TArKDlbABd6T1fXFFvpE4QMu+ETmtVqScqigm+WxZX8B
X-Gm-Gg: AR+sD10nvIX765x+9AJ6reiI4i+HMDRrHAMBD+bQtkqPtrdLNjQfwQefal1jC0BajS4
	p9YpzXC8H2IYlxIPqqD6RuxGishmLZQoCMTFoEUG423XM/0b2cBwQn+p02uKvVYno6lAFrDooph
	PWeQVoTNoiRe0Ts2+oLoOdq1JZnJ8E04CMWBk+FlbkdYyrWVKzGUr1XBYwQqWBE51T5lGS9WfWj
	w6wNIWKTPIjn5wXcHBL6WmT80QJsseeiE46YgtChC7v0KQO1tqm878e2mjT4N3emeaveCtm4hZQ
	SU7oqqYrbL22ImQUdgGh0VpB2sIgRB8vx0o2T11Wbz1eJoDntFnfUrlnWehLItWvPhO9orrpfWk
	2LGDhRLMyQ39QGUHZNDBJl4WpXPJBkOk/9C/7xneGOcvnO/00+kz2hfvFEXuQdokT5ATHRgebdF
	xP9nRQ1Tl7zasvAJexjDHe9akNso3Y5MnHl4NMq3FR+Swi8dxXDd4R3CTS3b8robPuqQlGHCLSb
	Rws46azKe5+yfBP4Ztcq1+D6VgW1sf6kviT9GC0gcPcIO9Sm/PMvPIp3bdx5YTnEj8RVf9PJrA1
	XbxSp9YStixO2xwQxpRG+Qq6nUbJG96UPwMTsOlI/o1tdB0J828X/NTKM1VQdiUwOxo+1T0przM
	DxFzMWx/rrRmD7U3ffzd1EC7ew4m4f3F44IU=
X-Received: by 2002:a05:600c:8b78:b0:49c:d27e:8f7c with SMTP id 5b1f17b1804b1-49cd27e903fmr6656045e9.12.1788020770370;
        Sat, 29 Aug 2026 09:26:10 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:09 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:04 +0200
Subject: [PATCH v2 07/11] iio: temperature: tmp117: make headers conform to
 IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-7-c67739d5dedf@gmail.com>
References: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
In-Reply-To: <20260829-kernel-header-removal-v2-0-c67739d5dedf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Crt Mori <cmo@melexis.com>, 
 Puranjay Mohan <puranjay@kernel.org>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Joshua Crofts <joshua.crofts1@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1060;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=5XLKjOzOTRwerZYjWQlSm0V6kefuJzxf5B3r7vswQh0=;
 b=KhNpn5GKI54v//aKPafQ95S+K8LINVDHiNSdFVhlL3menW+5WXGDeN3y9PDnNgALHMn4eDGQn
 py9KRU/hXYzC7YpK9qVTWyn+Y93VIBo5EXSRBjsiIG8DH0M55jVLQ14
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header and add the missing
<linux/dev_printk.h> header to enforce IWYU.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/dev_printk.h>: for dev_err(), dev_info(), etc.
- <linux/minmax.h>: for min/max limit macros
Removed:
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/tmp117.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/tmp117.c b/drivers/iio/temperature/tmp117.c
index fed8af2d81eb..25bc98e64e48 100644
--- a/drivers/iio/temperature/tmp117.c
+++ b/drivers/iio/temperature/tmp117.c
@@ -12,10 +12,11 @@
 #include <linux/array_size.h>
 #include <linux/bitops.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/i2c.h>
-#include <linux/kernel.h>
 #include <linux/limits.h>
+#include <linux/minmax.h>
 #include <linux/module.h>
 #include <linux/property.h>
 #include <linux/regulator/consumer.h>

-- 
2.55.0

