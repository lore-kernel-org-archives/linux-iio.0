Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795471629;
	b=XmXL1DSQNF5RiYcMVxI7L33+oEz4Ta1Cmx0HKYX/sYG4mQPY6PpwVPvT39Fo2xltW47c
	 rbkRGF6CNuLOxHjJtZTltEUB9Gh3i3FTDmf+A2TWyjESM/jh5jJtKsNO3H3TPvACJQIi4
	 AY573B6ZW3FGphGz9Tt2s49Kf4AbeGKdtWROdrtQgm/V1Ca5ziYxDhjnBaKMrDqooo/4y
	 tNZUuB8riRsRKZ5Kyt/FWkQTW4yndA+uDJzGbAEwiuFMRvuqlUYqbjAqDkkvJ8SVARDGc
	 wGNTQT7LDrctk1ITu0dj8nh9zBVmofe2bvPSOrVFNFiLFRj9DZBLMoWkglcoyrBicoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795471629;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding;
	bh=qIMhjFwxcL0DmsspKzOZjTfn8gizO436jmGNqizsDvM=;
	b=hrG0PQ7aP3ys3mzJV/G0rdsb4Znpl+p4RROcmxbwlDSl3QT/arlgtzRLOUV9k3+IHkRV
	 x3iOxLFFi9CbkYX2VHn+xPG4bJ6noLZT0JAk9zS1sSNP8KnIj2bf/PIv03TjdNyw80QKv
	 l7wB+mi0HA+mL1C75WzOrzn+epqz7lsHvh9vHeYhLzBbO7j/ymJ9+l4CfMo89dplLcd8K
	 uixYTRpRVLgLg8/afDhmRbqIi2tL2DpGU0Fjgk2G7NDD8DLqMnqpbrCHx9k9mpQuPfED1
	 1aBRn9k6FXBvdMqBOD/p+HAt613u2EbdP0QcY2otQdekkjeltcYBkNqdbNQonzGKpgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4HKUHhM;
	arc=none smtp.remote-ip=209.85.208.171
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AEFF606A331
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 22:07:08 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AEFF606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=x4HKUHhM
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-3ae417eb235so30958731fa.3
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 14:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795471627; x=1796076427; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qIMhjFwxcL0DmsspKzOZjTfn8gizO436jmGNqizsDvM=;
        b=x4HKUHhMUI2SEPUgN88XOyPhLfyhpeJOY2J0LP2QrhQ9MngCUEd+JeV1bQOm5umVZI
         L1+thJjBwKAQfdnpoKToHkQtZcEf/shNLopEXnFfvJXmC75O5368Ry9ZMi5tkYALfOco
         Ij0e00CYtH+etSyOG0hF00SQ0hNKVg7/W5+nUHV648q59yKQfV26AZNZXPTnE/7+EF3u
         NkI+jBuuqXSqfUWNr2J43uA5xaEDjSP1PbgI9l2db+lDz4mrX6rkw3+tcPsfgUrO+JYL
         02z8NtVi3VS8znx1GaFR6woD+AEHrLrIX2Aa9zvKidgqOFS3mD3xA8C6JB2mkeLIL4ES
         1eWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795471627; x=1796076427;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qIMhjFwxcL0DmsspKzOZjTfn8gizO436jmGNqizsDvM=;
        b=CA0KCZV5/gyMtO011rbQw611sgtmei5rYA1fuQ6z8FOZ1PMOCeUhQ+g5Ie6yOAcJNz
         lDfY5o0HPfXB25KodJWGtZ1pXSCoUUmnIsVu0u1NJibspBp3IeNu1/3mRVWe8LG61oPN
         lAToUVJ5nBrG60lYPRwHx+TZNAnwdcI/8M9Qfrs8iGsh4qUf3EUXpUCi9P1ccFAwi1IS
         W5+IzkJHQ9D+OLML+6umSM1xzD1Noq9t86TdZ0YQSIxpXyS8ntHhoNEk31MvFRIBoZfO
         8USqlXzKAkokBo6lBVgosXS4qmNOXi6NaAXOQ9UNFccocIwoo606CfYQ4WEADi1Wes1z
         7M3Q==
X-Gm-Message-State: APuU4Z8tg7IrepWVXsNXRx3GNfmpV+cbPy9XuH5IXi5qJ8EdV4gU48Np
	9dWDi5KLXmOQarCoXEl6WIpQ0BT5w6Qw4Xs/5SU/3KGCv4vYGgOE45MTl07ilA==
X-Gm-Gg: AZFdTZcib2382OcMrs4WuwjiYGJofSQTRjXzegv4nkPN08v96R+FKTLcdsH+BB6a2eU
	xgIca0wrqnrOuMx2GVl4jk7ZhM7o3L0O12x+OnzHxnUosrisVhlMx+BLEaDtqEeafnzNi/c7ecr
	ovDEKC4wo8oy+UkFNuJv1DT+73p5Nzki0+4HtO+xUa23PabVFMZ+cPxk5irW7vDnwzDv8c3BVmk
	qsiQxw4tQHyR/KSVQaIpIO+CXCWBPqdA6lqsqPY9I3jTWv9PUqgRHhmXYv42JnOI+ScewHSyhb9
	nNmyGLTyBzbxUrCMvdUUXSrtMOnC5/SnRN+Lk8Vi99yimYPGmHwAG3aVj08M4p3mzSvGBrpjupq
	uudG1veSx/heXCzn1PiTh62jYbrncJQpiu0HadYmZsnAC+zbh82QPJJnETdv6YpU5CwjdKkcTXs
	PoU/cvbgypAo/1iwpC7NHwuWCa1gUR1FfLpt4MaiOKYyF6g/rlWrOlGX2ZTBuH5JcCAdHW4IDh2
	7kyQjLXMXRzpDagRSQcMxs6Q77N7QPZgFISQ9K3gAiCE3b8EQO7v33beK+Pst5uxzwe364ZHvZq
	y7XP2Mnr20k+dMX9I3iop7y7TC6RsPdQ6o7gIH30RyyFhr/bcVw/dfshbkgdst6DevbqFUS//o8
	wXko7G9yjNruFiN0n1ZRfSPo2JIv1yS0NwmII4Q==
X-Received: by 2002:a2e:a98d:0:b0:3ae:7eee:15d2 with SMTP id 38308e7fff4ca-3ae7fa63ad1mr37899791fa.18.1795471626898;
        Mon, 23 Nov 2026 14:07:06 -0800 (PST)
Received: from yantra.. (nekmmqsyyquzw1lm5eb-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:3cd2:d52a:a1ef:5dd3])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ae805215ccsm34272021fa.21.2026.11.23.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 14:07:05 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH 7/7] iio: pressure: dps310: include what the driver uses
Date: Tue, 24 Nov 2026 00:06:49 +0200
Message-ID: <20261123220649.36887-8-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261123220649.36887-1-zoone.rupert@gmail.com>
References: <20261123220649.36887-1-zoone.rupert@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Include the headers for what the driver uses directly and drop
linux/iio/sysfs.h, which it does not use.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 7581ea4c99ba..fd17fa38e9fc 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -18,28 +18,40 @@
  *   c0 * 0.5 + c1 * T_raw / kT °C
  */
 
+#include <linux/array_size.h>
 #include <linux/bitfield.h>
+#include <linux/bitops.h>
+#include <linux/bits.h>
 #include <linux/cleanup.h>
+#include <linux/container_of.h>
 #include <linux/delay.h>
+#include <linux/dev_printk.h>
+#include <linux/device/devres.h>
 #include <linux/devm-helpers.h>
+#include <linux/err.h>
+#include <linux/errno.h>
 #include <linux/i2c.h>
 #include <linux/interrupt.h>
 #include <linux/irq.h>
+#include <linux/jiffies.h>
 #include <linux/limits.h>
+#include <linux/log2.h>
 #include <linux/math64.h>
+#include <linux/minmax.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
 #include <linux/overflow.h>
 #include <linux/regmap.h>
 #include <linux/slab.h>
 #include <linux/time.h>
+#include <linux/types.h>
 #include <linux/unaligned.h>
 #include <linux/units.h>
 #include <linux/workqueue.h>
 
 #include <linux/iio/buffer.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/sysfs.h>
 #include <linux/iio/trigger.h>
 #include <linux/iio/trigger_consumer.h>
 #include <linux/iio/triggered_buffer.h>
-- 
2.43.0

