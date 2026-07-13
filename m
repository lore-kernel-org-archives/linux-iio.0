Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BBC8271A9A
	for <linux-iio@vger.kernel.org>; Mon, 13 Jul 2026 03:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783915069; cv=none; b=kbWoeFRsd3AghCVabMHqSw9gb1O5865Yl821XPnLLfltFG4FCIr7KZAjdzZH3TOHfuNc9+AAzhY1LJ1vtTNQP+gItwnLfG49/RDCauGRu9I2P5NC+iJfixX9oqR+dMa+/gNmG27JbwVaPeSzCbFltPAld9+H2leDStZEgYFJzvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783915069; c=relaxed/simple;
	bh=WcD/SwZ51u5D7/QlDApFgv7wv7BrDF1ptkN3NyTZTK4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wu3bRFmRGpwceR78FGBuPt+LpWcpmG9HbnH9DQCAsBd7SIfJENG6EyT1eE+Dhks4kWUGZOLqoX9hYpYqc8EzWh7d2A+FbjBvJgmwkJr3w48W2quh4aao4j6u4c6WlybLuX//R6fwPhlgD2f68gF7We8IC3aZPWGoZnhJH8Rb1Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z98qlz8U; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z98qlz8U"
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-c998fd549a8so1688757a12.2
        for <linux-iio@vger.kernel.org>; Sun, 12 Jul 2026 20:57:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783915068; x=1784519868; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxIbOIh/93KyJON4/kBivEyvzBtFQfz4AT0SG4ihafY=;
        b=Z98qlz8UmWwZApTJ2fQ8I/YU03u/g+VOfY09HQbOluyyQI1fDcNDxj8Z+9P6qscZrq
         oWSFKJluYqHyWRnPohxdFOsl2BuQzPa+T5tuOWHhCYFlM4BLxxWXJf1cdSs2elDfmQAR
         40yjfE75x+67m3YDMZMnbIEd1W9fV4+5cuNrBH7FaWD1nSTdqeLodPNBoxYmZeKu27Jo
         i0keOAcgICFjtTnQ7XthTWsB4D9skb3QjWDLVLod2IQZrmvBFuTUXoEyAcypKkX1A3a4
         0yGjtt5P24skCycCTBKoPtcxPzU3I4LT3P0Ubkj2KHXS6h52rH6T9/HwUiY/FU3J7ym6
         FOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783915068; x=1784519868;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxIbOIh/93KyJON4/kBivEyvzBtFQfz4AT0SG4ihafY=;
        b=ZSTQb56Hpe/EI7MhvrqgBMiOtU/YVE9lkCckl/JvsOvZJ+gOR/RP0YFz1BPTmQXOPC
         +IYjZwFR5k+Y/3VVX+co9hxrAQ2KfLDR9pwmnHAl3gmAJbsERw82h3/BvSDzXWDyDMY0
         yxAsrKiSqxQZXop9KAzvgaqqfN5HlLcOK/6OGj1Oz6PV5rMWzL1am2a1RVTxYVHntJEg
         4GKG1jx8fc73soMr8iOxJwlLv7AMNTT00DWrfd9t25MZr2SrUsV0Dr+fh+hW7pSpwZse
         6xGtNFgFEq9LIpUYMrRnZJPiS70x8Pas7+rOMWUGRw8NYzLFnBIrJ6qKZ/ty2ZqCJEU+
         NvWA==
X-Forwarded-Encrypted: i=1; AHgh+Ros+UDcYLHjpC/xbZJu562a3cGykxeM/B849FmbW4KflbDmFJR/AaE1oh8H4M2eP8aPK267P80/Axc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0/M4OGtzUwgbfdyo0vJcijGsNobkMrnbuADkqZPBde3Ah0o2g
	nHN1YrrSE24MJ4jIuJpKtCOea9lMgIhRE7swZszGLhKiP8bkZchfNqQ=
X-Gm-Gg: AfdE7ckt6avAJc/c8xqXUhIUMghKR5pHRmU6m/bMWh9S1EbdkCyMD3wu//FBTc/FOYa
	lkpVe+XGWF226Z7lvXdmcovTYaqaBp0UiuKCCcwpalavtKZLYbkaNmvizdDhTl3tpY6AJbnkF5u
	XPv3YYupgkI+CkWuy+8FDEgNuwslR9hk5TqEkGWDQoka4qREdMIVkdBc5MZ7QbEmbwi0avcrL7U
	DraZ5GgFTPmPqz8Fw5IDwjdhksDsOLmI6U+Kmc7ODZ4OvQWRWpuMaFmwVj41yaFASWRl70b14WG
	AFGLk+C6SJqLmBgXVAB96S8Bgb39Xk25tJPbd220JXzU5vyQxpozm0n+O0cuGsXouwxjlgiPlPv
	nzYWnY9P36OdecCTPJvjtG/7mPlXuheUopDzHi34xORfpn0Y6CbJfFquMRP82akP4pX8JgBkWX7
	N2y6ewd7iQEHgii3T6TvN9xal7un/z/HQDq7gEaBY/5pMpVlDJxkLi
X-Received: by 2002:a05:6a21:6817:b0:3bf:ab02:439e with SMTP id adf61e73a8af0-3c11028952amr8112912637.27.1783915067796;
        Sun, 12 Jul 2026 20:57:47 -0700 (PDT)
Received: from localhost.localdomain ([101.0.63.154])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-311747f5975sm60862704eec.4.2026.07.12.20.57.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Jul 2026 20:57:47 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [PATCH v2 1/4] iio: light: opt4001: Fix reversed GENMASK() arguments in fault count mask
Date: Mon, 13 Jul 2026 09:27:33 +0530
Message-Id: <20260713035736.11346-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260713035736.11346-1-nikhilgtr@gmail.com>
References: <20260713035736.11346-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

GENMASK(h, l) requires h >= l, but OPT4001_CTRL_FAULT_COUNT is defined
as GENMASK(0, 1). The define is currently unused so there is no
functional impact, but fix it before anyone builds on it, and add the
_MASK suffix for consistency with the neighbouring definitions.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 drivers/iio/light/opt4001.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index ba4eb82d9bc2..0a2d2273355f 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -39,7 +39,7 @@
 #define OPT4001_CTRL_OPER_MODE_MASK      GENMASK(5, 4)
 #define OPT4001_CTRL_LATCH_MASK          GENMASK(3, 3)
 #define OPT4001_CTRL_INT_POL_MASK        GENMASK(2, 2)
-#define OPT4001_CTRL_FAULT_COUNT         GENMASK(0, 1)
+#define OPT4001_CTRL_FAULT_COUNT_MASK	  GENMASK(1, 0)
 
 /* OPT4001 constants */
 #define OPT4001_DEVICE_ID_VAL            0x121
-- 
2.39.5

