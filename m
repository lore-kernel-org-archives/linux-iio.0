Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A208530EF9A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 14:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778336562; cv=none; b=aEUcuNvVfUStzlb9qie26dzgNl5BqoO4W9hHiD8kfSjpAyOlxWN8EuQhPwWtwUT53ClRGLoZwStO6kI5pLkYKRrf2Vb+Wy3eN5DNE4LEGaqPI669eyWY8LUMDjIaAT2gJqkJb9el7mOdtUoofurm1y53CA+lOgtjA2OS/H35kBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778336562; c=relaxed/simple;
	bh=JA4MiRw1MJjH7bNhnR6shbkdzsy4pqluHZpVAh1DmGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iJRjPvMbLlOG/2LU7VHWUx9Rs5bahVmBl1TgBwJY0OpJtuD7nTzAnLMSSUi8zf0+e6ci4PLSmhZWS7LoIk1zElFYG437snXY8BnDjzV96CjFCszmrNKpnNGil7F/Uv2q2XlhH4bENu3/XTjSd4RXtCAfZa6H4Ho5e0m5mrD/Spk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Fs2zXbnr; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Fs2zXbnr"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-488a88aeec9so32939125e9.2
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 07:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778336559; x=1778941359; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CPxOp9tFICZjOEYxN5qhdPtWLZ//6o03lBo1ImPhBvM=;
        b=Fs2zXbnrXEupnp3kNKMMac5wcRK9kpaPy2PtRKyUANqwxGSV0xpbamWXR8EHIyxBQJ
         jdUhbzccODLp44ygjv79flBbB6H54rWGskR9F86j1mFFuFT+V6gP6c8Kq3sCzbsFeZuR
         lrTeglJA779NLo6KvqU0L+k8v7r09VbQkRCqs/8DHAnpTOzY1IXKRBhUAYKpYpfYy9Qr
         i+azntup870D3OBQ/jmwg7btXQZm0RnIE25Hp2ygSvd64eVIXVF+MnMuh3egT24hIiWe
         x8k5R6puf/YBQ5y+wgx+Qk8IfTQwgnRCq05BOFS6MGV5vWxpRqG58uAIAJ4tz9hhXAdl
         I53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778336559; x=1778941359;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CPxOp9tFICZjOEYxN5qhdPtWLZ//6o03lBo1ImPhBvM=;
        b=JDXkWF1aF4/Y+q+4hMgGDwfR7oJ0k65UXaydkNx+akyK7/SEA4xbz2UXE3pDPEnKzZ
         Zre32U5xAdV4GLRpNwSduT7XXgqGzJXGS0L0pRia6vUwUtl8iMpdz5jwYL4PHNWZakrd
         8Fk+V6rNPyYopy17FNE26fChCe8o/jJ7XGxRVyvvNQ82P02hKB7zOckgjwGir6h5a01h
         6vswmBR4mj0uc+HU+/xh3r85g9pbZH0sI3EbZpVFwo/xIRSSs2UFaYp+rPZcbXzF+T0X
         qIlc5XlAkjPAzFwwVK3kz4Db62y1/piCHaFOz8dHtpNeBRpJUEJOCrCvGDMFRkDr8agk
         pmIA==
X-Forwarded-Encrypted: i=1; AFNElJ9opKuRjh0JCHpXklbnWwy41h63zlbgxx3HyihY9U+h+6aOznQsHMbit6QPyTV7hfKsJIEdQoBGZDA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSONkb9eFlHcUIKU+b4N38ZICrVk7pJSkBEM/9zzNYcipZ9Be3
	QQE9nETv3hT4ZA68EeZaqGQPiSbbFxHAzAvm61t1L4tKIUduk1zxF02s
X-Gm-Gg: Acq92OFzTvP34XEN30aaz6CvY6SvbCQMsOj2P74oMns4pAEUJvpW+z298Ke2Cr7X3pv
	CPjsWCf/+wn153iaSTjbszzNYxMckgcpJiGmtp1/QkB5nEXPmOf3qXvEZqiqTVlKfALxbdXl+Wr
	1s/uvbA0KRK7xntV6OXz6YnSckAJX6b+4V6jwGtmBKrCYf2w4gCyatzxIPd0jUPW3MArWK4afXX
	8QeU5IWbQIys/SKxAOX/WKM+Arlojxz7TLhhg1I+pp74E8ASMdJ1HalOUMi9XkpPLYuew9thlzV
	5uyerNNEtTu1YCyWntDCYxaR9aZbDHYV9Jl/Rf8NFQV5lPceoz5fhzDb+i+iaJrVHXDKSinNbgj
	8XNcL0siXbSUPMZIYLHuu8+YrVjABqNzWsGVNeRoPT/iS+Q9CtrYtpKRtiPMOmSaHL/8AlhRbrv
	TRnhcUzTu3yW6l8C2XlvSvKXQij8ZRjsihYTJevPwo9++xyWrhqsCGhFM0BOelW8V+DcsW
X-Received: by 2002:a05:600c:3586:b0:487:21c7:2885 with SMTP id 5b1f17b1804b1-48e706acf6fmr45737035e9.5.1778336559002;
        Sat, 09 May 2026 07:22:39 -0700 (PDT)
Received: from DB-07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45492271510sm15127763f8f.37.2026.05.09.07.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 07:22:38 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v3 3/5] iio: dac: ad5504: Align headers with IWYU principle
Date: Sat,  9 May 2026 15:20:41 +0100
Message-ID: <20260509142047.30302-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260509142047.30302-1-0rayn.dev@gmail.com>
References: <20260509142047.30302-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the header inclusions to follow the IWYU principle and ensure
they are sorted alphabetically:

- Remove <linux/fs.h>, <linux/slab.h>, and <linux/kernel.h> as they
  are unused. The driver relies on devm_ managed allocations, so slab
  is not required.
- Replace <linux/bitops.h> with <linux/bits.h> as only the BIT() and
  GENMASK() macros are used.
- Add <linux/mod_devicetable.h> for struct spi_device_id.
- Add <linux/errno.h> and <linux/types.h> for error codes and data types.
- Add <asm/byteorder.h> for cpu_to_be16().
- Add <linux/array_size.h> for ARRAY_SIZE().
- Add <linux/kstrtox.h> for string to integer conversions.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/dac/ad5504.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/dac/ad5504.c b/drivers/iio/dac/ad5504.c
index 03ce37e2c616..57e6eeed26ef 100644
--- a/drivers/iio/dac/ad5504.c
+++ b/drivers/iio/dac/ad5504.c
@@ -5,16 +5,19 @@
  * Copyright 2011 Analog Devices Inc.
  */
 
-#include <linux/bitops.h>
+#include <asm/byteorder.h>
+#include <linux/array_size.h>
+#include <linux/bits.h>
 #include <linux/device.h>
-#include <linux/fs.h>
+#include <linux/errno.h>
 #include <linux/interrupt.h>
-#include <linux/kernel.h>
+#include <linux/kstrtox.h>
+#include <linux/mod_devicetable.h>
 #include <linux/module.h>
 #include <linux/regulator/consumer.h>
-#include <linux/slab.h>
 #include <linux/spi/spi.h>
 #include <linux/sysfs.h>
+#include <linux/types.h>
 
 #include <linux/iio/dac/ad5504.h>
 #include <linux/iio/events.h>
-- 
2.47.3

