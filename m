Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793180647;
	b=Pw12fwFEPul3MIyoNE3P7PLWmXp7oLsbORGzuZBG7csVSk0sY8yLdLN0ED8ET5RYw5Eb
	 IjFQdzxkch3w6lamaR/Ayjh0+jmpVT3QzNWnGaBGtC6yGcDeqX77O4iRvgjdcaIAvXP9B
	 284HRhV2hmGGVlnEMWJoXu7HFr+1bSSFSTAsNb2LyaN0M2IrBXzdqJOYB2G9GjhBaIIeT
	 Cs8GVjFupIQqDRjUSLifipXo1XhdLEjbr0H6kOGaEYPxMeYkbviRhJIb5JcmMegBqbzag
	 bc6B0Tny3UvvEIv8Y36zKTYfi8rLnf1751Bjc0Bn5l011hDmHN6ASjLsRDC6lfjFzLQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793180647;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=BZ1KJWzBPUbk3tJbiYcox2qZA+SWKs+VXWNl/tiELj0=;
	b=W467glcPPPC+7C98EzsEpIr5vpHS0/9SrXIOIKD3/1vKFQT2msbZw47+CZRRFAHCUCKV
	 +WeGb1P4EBiYmdYxVnHaOALHMX5DS79tQEYYas+oTG0lsW7B4pAjgGN93VDhgi+Cl1Epv
	 ag1Rp+UGlxQuVTqKpzwcLybO5/MN/+whPliSxQBAB1XxNuePQfS5FUZpQNnXzkZIJJry/
	 YLaoKww8zBlx3KnbZ/YW3vXRwZI9KhjlonSJvlcpLtl8V3iekJLdabzfpRN/S8xnSdVX3
	 KvQntH3ICYc48FmZuKPsnERJNTeLKGiD79gMa5KVwKPw1ZYlwxw+0Q3VOKy/A6eATSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spPX3Bi7;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F484606A31C
	for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 09:44:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1F484606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=spPX3Bi7
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a3517554f7so6407085e9.2
        for <linux-iio@vger.kernel.org>; Wed, 28 Oct 2026 02:44:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793180645; x=1793785445; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BZ1KJWzBPUbk3tJbiYcox2qZA+SWKs+VXWNl/tiELj0=;
        b=spPX3Bi7M/os/ds1fp8JLng6eheaRNH8fXJpLWEfAjhGc1oif1TENPL4+UvlTFVlzL
         PlAr6mtQqNQC5/zhH1SHA9BsGy8lGc0hZRXLhe4JJZ1qdjIBIgM2mbd9IWDm7Nknr1DS
         lSTKWGNsc8Y9+FVgIgO8d9qDIz3HI3hv679pDNkw5FOW4rPlNG6VCU0862qiUSpi43NK
         Txbj8jmXnx9v9WPf/6hLVck/52lTEJN6IC/sGrkmBzz6mIznwi+6S8uHHPL3CECBKU7c
         /eeEOnCExBCFKNLSdNDCY+J4pUdgJ3y7HbpwhfKa++sZ7cTV2CCfwbzqjd5bhnimZTux
         75mQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793180645; x=1793785445;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BZ1KJWzBPUbk3tJbiYcox2qZA+SWKs+VXWNl/tiELj0=;
        b=lh3rr062Dh+O77rr/nVVn4iXAzrfecpwAWjrFxyzkkBiXD9fmvaBa+1TdKH9wtsvQk
         h1oZcJC+nlRxLt6omSqlaKlzRF0i5iTpfKp2Z0dx0zi4sCk81kncE/1t6axpRikzT+Uu
         uzSsT2PAoUbeM8wRsYlt5B3wBUrYG90awCW9eNbdpGwvew7HhDA8b8CqAHYTYiCGWp6R
         2+iU+UVkm7mWZd4U9kW2JuTtD5RRy2EYXMbMCfQzCPYHI7WCjlTzyKXnOs13Vp9r/nyw
         3+KyR15zHwci7QY6gp/0dpmdgwY2WkYRtuBSjbx2GfEI7W4Exs7ZTY3kOjjR+8Mrbzq6
         3mQA==
X-Forwarded-Encrypted: i=1; AKwUvBxCc2wX6lamVxAIvXp8BGQ0d0SDFS0huegNZkjCG2RT+UkOFkqMNXZVTb3LgqfgSy2P20P8Q6pjaiE=@vger.kernel.org
X-Gm-Message-State: AFq9FYLts9pIKje9hq9CcNT3fzZdX/fBI3QGx8f9Vp6LgMobrcq9sx5y
	6luqhoAx45AECe9f8p/Optp6lmhPgboqoj/Fg6ANbLI2WE+7D+h5cS7t
X-Gm-Gg: AYBFou3XXs7ff5XPosKI1OFCf3gofhhYMfDKnGGs2rXkJ33xmcs4EbXVkzJlxTrEgCK
	t4UrxXqVUPKxCEyAJ+UnUzklFNdJLVzkQL15qh3hmb6wq1ao6HxvOe6MmgZiqRCh+f8+ow+zxlR
	sQ/ujoVZfV6HoHc3yaHyPQ2ksC5v6NdOdebVvoRkMdaxPm/IlbKtGslY2xM5lWCtk3MWQyprrQ+
	vn1TjwtHHvahsRfg5jurhjmDja68Gg6wgcuZzMUeYz3tmq1dMQCQK1QtXovPMYfhylW1xBz6yeI
	3hG4ZIpFw90KdcEDCCuPpdxl28173msEuFh+KQDnjR09XgCKs+IsLSqj6WfYYv6nvQdCbfBQZDf
	wuCz8UG9cNT/torhQvi+UbeQdvl9mKpK3g+bruNH6L1AapIoSYO6pMx1SfdzEaMhKVPEKcYjukZ
	NnoYizWteB+mHbV3P6ML4T8eS4kN7vEU+9u89cVjhZMeaPTh7U5HXZFRz1ZJ4NJ4+RKr21ih/JX
	tSk7yHs+m8vU3vEIUmxvx9bszJYqpRWLTzvkbLe8wBQM4x8eMq6vNBGJZQe8oRc04SWET7E6pUD
	1PNOJfskk+OU1W8lSorTFbzzRsqlOYe0wiN4aqVLEjzQZ1DyenmyuwYgPoL4
X-Received: by 2002:a05:600c:37c3:b0:4a2:1867:10e8 with SMTP id 5b1f17b1804b1-4a96701830cmr35730755e9.25.1793180645227;
        Wed, 28 Oct 2026 02:44:05 -0700 (PDT)
Received: from fedora ([154.183.179.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a97bf5d6besm31962265e9.4.2026.10.28.02.44.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 02:44:04 -0700 (PDT)
From: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Nuno Sa <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-staging@lists.linux.dev,
	linux@analog.com,
	linux-kernel@vger.kernel.org,
	Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
Subject: [PATCH] staging: iio: addac: adt7316: clean up and sort headers
Date: Wed, 28 Oct 2026 12:43:07 +0300
Message-ID: <20261028094308.27811-1-abdelnasserhussein11@gmail.com>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove unused header files and
add linux/pm.h and linux/string.h and
sort the remaining include directives alphabetically.

Signed-off-by: Abdelnasser Hussein <abdelnasserhussein11@gmail.com>
---
 drivers/staging/iio/addac/adt7316.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/staging/iio/addac/adt7316.c b/drivers/staging/iio/addac/adt7316.c
index 20f6052cc7fb..e30d978fea56 100644
--- a/drivers/staging/iio/addac/adt7316.c
+++ b/drivers/staging/iio/addac/adt7316.c
@@ -5,22 +5,20 @@
  * Copyright 2010 Analog Devices Inc.
  */
 
-#include <linux/interrupt.h>
+#include <linux/device.h>
 #include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
 #include <linux/irq.h>
-#include <linux/workqueue.h>
-#include <linux/device.h>
 #include <linux/kernel.h>
-#include <linux/slab.h>
-#include <linux/sysfs.h>
-#include <linux/list.h>
-#include <linux/i2c.h>
-#include <linux/rtc.h>
 #include <linux/module.h>
+#include <linux/pm.h>
+#include <linux/string.h>
+#include <linux/sysfs.h>
 
-#include <linux/iio/iio.h>
 #include <linux/iio/events.h>
+#include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
+
 #include "adt7316.h"
 
 /*
-- 
2.56.0


