Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C9E36F439
	for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 07:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262161; cv=none; b=DK2CGahKrdjU9nnqyrtozmFChfCvkPhFT6IqI1qF9AyHHvFpWJW6Iqlb6N4WXEc/TerzFUfththnizkDX8jnn5FnhTmoYGMNir8EA5x3XvxkNTuQO6IB1X7ywVLmCFM2z8jU2DZEKbjXvbgiZuUoCgKX7rrf3Vr/5UnozjpYGD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262161; c=relaxed/simple;
	bh=E3m8x+5Py+DrS1yhwjO4bfslD31NqZ/mOBktiWRfdYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mB/I+1AKHEE9AlURnsvyjis8ZErVVRUo7Bv/NB79Ow/rbV9gz+7e8+xnX8kmdryD1y2kYO5lta3JGRWAS8nMIDA0sLOOOoXtP2HdYISMAjl1HCqMB4gpbv+qCBg9UPHez+iFaQJbwxv1Cn7vIzcN1kmP6j5JujqyFAegMAGAFCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zwp8o4ir; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zwp8o4ir"
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-36974217d4eso2689142a91.2
        for <linux-iio@vger.kernel.org>; Wed, 20 May 2026 00:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779262160; x=1779866960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AK8uyh5+5gdeHTCxNeKbZQznp1Z1On5Jje2vJ7+Ah9w=;
        b=Zwp8o4ir+C7flTamJlshf6rLgfr4jJrGTNQgXvItc/O1eOMAIhrrEUc6MJHLjxLa6M
         6AoTM0rYX36gkaLtBjaS31vJybtKyxug+7ZnWEb5ioywQM/SzX3Jk6fmhC/VchsYEqhy
         9QOo8nPDT3anAaCeZERTTkwTrJQ6L3PlRDUfx4QEnUONVgRp9Ykt9ZZa34FSsjcWnv8k
         t3Tv+zlUBLBWy6W0vYFhHmNYg6LLaxyEZG4KoAGjDvmGzE1t4p904OoG+qjgLCg1cBW8
         ktDfynW5tSwlcX6nbFXLDq+mmqESwl8z7FaR0wy45r0jjlqkQcrkZicKrRKzsd2najst
         XHzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779262160; x=1779866960;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AK8uyh5+5gdeHTCxNeKbZQznp1Z1On5Jje2vJ7+Ah9w=;
        b=RllcQ7h2EqrgxD+8Y+vMxbXmMrvaYqhzNeBj5MCP8irrtqvl+LItaDIJD0026HK6DP
         L4U3fKkXsqSLC7fpvRKgbYboY5y7YX39hERUvhJuSnbPY6Vwfhex90ELNVumAyL8FFKn
         1YTO8TpuNXVcUgfzzMsEy12kDa0bSLdltdjn4kWVl5uKRZ+XElwPJot2BMjiOxkaEXKA
         V7Za8vjnFi0doB7RUVjHghBxDpZOOYm+/lt+0JAjlJcO4+peRd9dPbzX7yPqxNtWJ20O
         UTf9f8h2KDopdIYmskB6+E1jEZZ8nLLeqjG4TcuMp53Ea6tmNlJMRGenHWEoRMFNvltY
         0Q7g==
X-Forwarded-Encrypted: i=1; AFNElJ92If6NY6mRqnHDW0jSVBCMVi57UzQbdijcCH0rmLdU2ypnGqPeDi67BdjHUFtewOYdrnCsgoPtbic=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh5qSAElBSDCRKzMLaeiwv/QM8/oBtHF2fPiFp66PXTb1UTUly
	U2sMSbeKIWPHTGA21+H5os9qGMyA+OKVk+2qjntqTf9D7KspLiZbpnoA
X-Gm-Gg: Acq92OH5Iz+0LC0s4djaDRUf5pZMXWc9TnozDluD92yGBIx+//b1S4FSzHLEZg2vBW0
	kVYChq9mBW7qmtGbZARmikQ9ks1Pbmxs2GzfsfxRf2qi+XrM2PzBr1fPSLKTL1VcWkoUgzN1hhn
	MnoPmOGsDLPht+ApDaKuar73lD+xn119vgwzPCcK27vKqqWKTb1FIHC2/8+wte9iVotqzucEVWg
	KcsVftwolVQdmJibjBCmCN9AbbOCQZQMntyAgbNI65df7fbOXPI5F0DRA8LQk4Vqrgb2fbfOWMW
	QbA4hhFVfUNSuYXPZCSblYW1/YSWQ0cYiTemk7u/aTSQRMLFzTZB8TdI/1rrZaLbiVLxBVgmQvB
	MxppsPe9+tdCAqdkCwbTAHsMz0D2RSyqGjcPx8CvsNBevWUvgI9J6TKqwhNJaAqLWUvjmfNw0Vk
	Sa7XBtJCXUy5uSjRpVjsLyM1goSpjZm3IKQWtiV0fug9EkoJSJd84DQLr6emRuDmucCIY2aaAcI
	XqZLRfUESXCiLFh5e51+7e0uqGwC5hK/86GPE6QGKZsZ+9P
X-Received: by 2002:a17:902:ce85:b0:2bd:ef15:9fce with SMTP id d9443c01a7336-2bdef15a1e4mr111156975ad.20.1779262159642;
        Wed, 20 May 2026 00:29:19 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([112.172.255.242])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05f27csm206258595ad.25.2026.05.20.00.29.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 00:29:19 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC 3/3] MAINTAINERS: add Open Sensor Fusion IIO driver entry
Date: Wed, 20 May 2026 16:28:43 +0900
Message-ID: <20260520072843.3593-4-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520072843.3593-1-kimjinseob88@gmail.com>
References: <20260520072843.3593-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a maintainer entry for the Open Sensor Fusion IIO driver and binding.

The driver path reflects the current RFC layout. It may need to be adjusted
after review if the driver moves under a different IIO directory.

Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index c2c6d7927..001ba4ea6 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20011,6 +20011,13 @@ F:	Documentation/devicetree/
 F:	arch/*/boot/dts/
 F:	include/dt-bindings/
 
+OPEN SENSOR FUSION IIO DRIVER
+M:	Jinseob Kim <kimjinseob88@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/imu/opensensorfusion,osf-uart.yaml
+F:	drivers/iio/opensensorfusion/
+
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
-- 
2.43.0

