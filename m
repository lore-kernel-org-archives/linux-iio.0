Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A1415F1F
	for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 16:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788020784; cv=none; b=Ra6Eoo3gcuIVjiloIZeh0n8yVWx0QeHQaz+AxaBuyGO7tJSoF9YJaMnLNusMRn5P/4ZUw8gFS3F1iDof5k5KUScmaFb0Kh0oMR3SCildrNzoXup6d+wEXn9eL1h54GLXemhL5duz9fspt7cMrlpmwSGMbXLbTAlzbL4e6qNZ698=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788020784; c=relaxed/simple;
	bh=sQVJMp3C2+a4ti+a7qwKMOTUI8kXgqbTgt5wFTn5j2s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ciD3t6BXnpkeTPVC4zbim22iA6e4iPLOl9Imf6jycVXdJE2GoeRU9u6FmIxglB+unIppn2aL5hS9CMj0IzA4MMUCGX0G8s+JFRKswF+fLg6tqA816E2utuupLycF0xPbFZbdSst+kDB1kH136/X5zeCxAnQMxASHK8KYLCjeHJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E45fgCy4; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E45fgCy4"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-49a97714f5dso14827015e9.0
        for <linux-iio@vger.kernel.org>; Sat, 29 Aug 2026 09:26:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788020773; x=1788625573; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=37NQ1+thP2Lwc8BjlF3YW6iY09VuBpxsUD1pSnN03YY=;
        b=E45fgCy4JYJ2S2A13Ute6L/t7dv10Mjz8O2SopdR06602fNo+kJ+7L3Kn8edASIt9H
         1o0urLvSr1aV8r68KeX1rdtXyVkU0mWDmZXUDtUldm030M9fAguxbJeKnkCFaXdHdrCT
         VUTFqyawcFoduB3H6vPnsQkl7FoKRqDe+gRDa3SL5gWKWpQQ9ByY/BRaSuH7IW+5JD2i
         fJgSWYxP66rOuAu1bdZmVUWG24XJRTpT7cthvuZl0Evled7J3oySAXDi5l6R2eaO29fR
         NCkv4FwMT+KPgyGioEuDg64dlU66QKbCAMYIwewNC+aVrUjK4MbxOnAFvQJOJNh1QD1Z
         dSWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788020773; x=1788625573;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=37NQ1+thP2Lwc8BjlF3YW6iY09VuBpxsUD1pSnN03YY=;
        b=iE6MarK81+zU6odcatNT7S/0zI37stld6GUZJ02EXi0Un8Q78xOMrQsufuabLE5EB8
         j2RZ1T3MxRc38PTD/Y9X7zahpFFSJ5Oy0o0gmFs5JHic/hfi+4D6JF57+j1Nhe3Nx+/f
         r6kgQ2EH70QCWCa8re/a/JtfObGiU2F7FXXao908etXn/DOs6StBayOkcocCBMOK0fp6
         mdwGmNd85/9500newIF6P43byXvuNr+iEpimnqu1dJg52yGxxO1pcZ+oiG73+VYEWuID
         Af2nfrVpJkXi2fqETLAJnzJkz1csFaLJ85sM/PvmDAedj2Xs7rtj2YzChriqWy74n/Ym
         M3KA==
X-Gm-Message-State: AFuF++kxusPWYV6xeW8ggYi2fnLENMtrwM9ZHIpA4MUkp/NkzIf6yBgm
	IoQpzyvIgep++bNjxhui22Rf2Lx/ucY8WqHKkT6wEGQ6SboSsZQEOHPC
X-Gm-Gg: AR+sD13XgW0E+upzgA5BC0tyxIGM9lxHZ03ZuaHzcwf9rvbjY48AggXbF6RlJOjJL+h
	S2mQLhP5846ghlr2ttLTToIsMcJjAPRJXmXLJGSCkjnk997NdFGOIczZx40Use6YmJQXsWeNG+v
	SWpx+xZ3vtb2t1VhL+Vy70dSe1nUGE5DP1KKRPKSLFJYSRwZ2El+zhBvHlhyb0w12jrYX6EWmvq
	tHy/xOQfIIvTwv1OExnZRLEakhKpEGnJqqVsKBj4Q0V2Z4THYteJTKrPVIjWPAoS6cIrBEstLhv
	4DDgxKMdNfuu1QroLMe/GA0un4t4gh3g8AG1lneexUFw4rXcKKVpoBEDmM0FGOpO0P2mU5BJupU
	eTAAUTo2i2tg1Ya7E1rfQrKlRVD+q1Sjty8EiNnMrsLIgh1QIkjgZ/UVp6/TDc+ugi7Cy2x+7gi
	a2aaEKBz8Ij7/vNpgV9Dgrai7MX683hDorZ7XdieAeehr3XhypMTTY/iQDFxmXnO9qBjOdqpS5j
	2reKTpKGb7WiAT69wBqZksPlg3mEmTWZrSEZ0WhSayZj6q5a1/XEpoK/ks0Oxr+7rG6c595RSk4
	4yS5elbIgwAu46APdseIgzG7WWbzV1R0zDRFqVsj1yNQSSVdLjHk8v8x8ZF/o118iTrTFol3PKP
	+bIlIYcsjxXLLCnuOw5j2bP1wDdxWuelc078=
X-Received: by 2002:a05:600c:8b86:b0:493:f5bf:4dc6 with SMTP id 5b1f17b1804b1-49b91c2777emr259876155e9.7.1788020772776;
        Sat, 29 Aug 2026 09:26:12 -0700 (PDT)
Received: from [192.168.1.187] ([2a02:8308:4092:11f0::f9f])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49b92679be5sm137861705e9.3.2026.08.29.09.26.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Aug 2026 09:26:12 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
Date: Sat, 29 Aug 2026 18:26:08 +0200
Subject: [PATCH v2 11/11] iio: temperature: tsys02d: make headers conform
 to IWYU
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260829-kernel-header-removal-v2-11-c67739d5dedf@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788020764; l=1873;
 i=joshua.crofts1@gmail.com; s=20260530; h=from:subject:message-id;
 bh=sQVJMp3C2+a4ti+a7qwKMOTUI8kXgqbTgt5wFTn5j2s=;
 b=PDDTE3Ssmq27mEZddwEE7tj0c4EuQj5HRH2JegwaoBBBOj3IUVxhfhK4J376cavbir2b459rP
 hz9V/vF1eBPCLtlJC++UIqVKOpVI4fKZ7XJfCnX1BGjsXhhMRHuzLUg
X-Developer-Key: i=joshua.crofts1@gmail.com; a=ed25519;
 pk=RTDOoVwgeL4oFdASj9U+cxJuIjXuXk73zkjnGOJKbEo=

Remove the catch-all kernel.h header, add missing headers and remove
unused headers.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
Header changes explained:
Added:
- <linux/array_size.h>: for ARRAY_SIZE()
- <linux/bits.h>: for GENMASK() and BIT() macros
- <linux/i2c.h>: for i2c_client and i2c_device_id
- <linux/mutex.h>: for struct mutex and mutex_lock/unlock
- <linux/sysfs.h>: for sysfs API
- <linux/types.h>: for fixed-width integer types (u8, u16, etc.)
Removed:
- <linux/init.h>: not directly used in this driver
- <linux/kernel.h>: catch-all header no longer needed
---
 drivers/iio/temperature/ltc2983.c | 1 -
 drivers/iio/temperature/tsys02d.c | 8 ++++++--
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/ltc2983.c b/drivers/iio/temperature/ltc2983.c
index b8deb9aa9d48..6c4de6854683 100644
--- a/drivers/iio/temperature/ltc2983.c
+++ b/drivers/iio/temperature/ltc2983.c
@@ -11,7 +11,6 @@
 #include <linux/bitops.h>
 #include <linux/completion.h>
 #include <linux/container_of.h>
-#include <linux/dev_printk.h>
 #include <linux/device.h>
 #include <linux/err.h>
 #include <linux/interrupt.h>
diff --git a/drivers/iio/temperature/tsys02d.c b/drivers/iio/temperature/tsys02d.c
index 377e27b45fdd..4946d0b14632 100644
--- a/drivers/iio/temperature/tsys02d.c
+++ b/drivers/iio/temperature/tsys02d.c
@@ -10,11 +10,15 @@
  *  http://www.meas-spec.com/downloads/Digital_Sensor_TSYS02D.pdf
  */
 
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/init.h>
-#include <linux/kernel.h>
+#include <linux/i2c.h>
 #include <linux/module.h>
+#include <linux/mutex.h>
 #include <linux/stat.h>
+#include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>

-- 
2.55.0

