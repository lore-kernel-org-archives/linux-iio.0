Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DD4F4ADD88
	for <linux-iio@vger.kernel.org>; Wed,  6 May 2026 18:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778091316; cv=none; b=f+lIZIrXgn2EIjH57KebMWWmO0bzXoJzLJeadZz3g2MQSDsQ7nGPdBoaPMCP+Mlf/wLrKIEW42NmiJ/8MsvyHU1YcBqc51XE/3rLMRYc5yg9DuhHS4XrGwB6s6aw2T69Bntx0z276yAuarPLZZ21D70W25J6SioOJ59ttNk6XDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778091316; c=relaxed/simple;
	bh=NmE9lzTNppZPaCPrgCj8EIYP1oawhN473+FfdN8gWhM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QsK92lM8QB9yd/rfB6wmHdYTh1VmcHom6+bFWrijrZhjWPxhxOKf3TWfPfcFABbiTWi7gnVo9auX6mH4gJ4QxAKKgUBEnngZycp7pqJfARBVIcFFc/cAaY3R2kB2umWV7DbCi5Sjq9Yyiq8DO20phbCba4PVDiKvrZ7uIjIbny8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFUG4hQe; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFUG4hQe"
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5a40b2bc96dso7436354e87.3
        for <linux-iio@vger.kernel.org>; Wed, 06 May 2026 11:15:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778091313; x=1778696113; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GAb4j8gyow3tDdprlAQtHYkzLM7iXgoY4Z2IizcjtAs=;
        b=gFUG4hQe8pbQ/HhNXvxjLKZfZ2qWh3mo1P9ihmcC5to57qB20uUge65FTT+YGEzPuX
         qMPYjZDRa/qOSamBKvcVVQmfRQhOK/27/MGvdBeNh+6zgxmeto7AF8BFCjWcPa0Ofwus
         aicpOWGjlSqCS8IZycwNI9RondSj03Ah+EmbE5ccDD0jB7KTNveM+JZkpDQMshE8QJpA
         lhJBQ90aCuGtxE4qgMLvSc/SAnlHCVqcBZ32Z3neUTWBK9anf3vmVizHfT3Ug3WkGfhP
         eZOuxhFqkLnd4bjYKBUF3hYIqyqKr108tfwZXpaErJkCPCC030yCj1JbhlsTQ40vUxF1
         EBGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778091313; x=1778696113;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GAb4j8gyow3tDdprlAQtHYkzLM7iXgoY4Z2IizcjtAs=;
        b=SbEO1syE8a+aPLugi3zV4hLYJZY97JiGMtnPoVqyg21nS2bHUWRueyGp9icYc/jb1/
         9w2ZkGf9iHacGQf+deb7ulkFhb4vlItZv/JU/SD9r+oGMHBjqFeGcrSvdBjiE7pa1MBg
         LSCmWu7mbxU6bLybgJilE4LOUaFd6OjcbYsH4Y/7rlXbqbap9SS+yFutsQ4gjmb0elea
         wkX+30u6VBk9XWuSmN9kMacxgJVCBpnRJlmEU45H5vH7dL9FS/GXF/Ljyx56x2P9oP0/
         lWg2IDvDuRDHKVNQlOMHupuR59hx84mj8uncJh2csYew8Kts0qQEnoNrlFhCaKnE9n/q
         B3GA==
X-Gm-Message-State: AOJu0Yx1cXapOCN9yRUi7/atDEwwkcWBwNzBILBVe5LLnFfGuFdUIBF+
	kj00LR+AOF0DQfMQ6x4YQWORFy6GauA+UKlsAGbKCNaG27+wqB0P4ll/X+vu+cb/
X-Gm-Gg: AeBDievujVDzk0J//2c0ddmYcij7zwbbErRCgnmvxckAj9oapgWEGNvJXsb+wyWgstG
	r+II2Wqhiafc1pmWqdFPDqTZRLRWekUZEG6sTjEV3GrhwHZlYh3CNRPQuLl4xIrAW7h9t0MD3XD
	k6DsoSMSP0+B+E/f8OgkMJ26AWSrXdYBnWEFK1gaB+Lt6Ih3iVORX3dkpmyq6Y0Zll2fSQ2qAL2
	o5ORRXzuYcs5Pj+i2FoIkJaiqAz+gNA4UU/cJ2HPGFsXDDnQtFIIofJx1w9jmcffe0rOXqA5EeX
	jhzJq/3V9jsJjuElobygjbiVvDdweC9jLNyuCoBliSA90Oc8UdlA1f1FYTXQayLJL/bL+pBZpWS
	gUQ+thxoefA6K8SH9QWhBFYpuaBgY3aiWya0c8iY5CBtsxMpSNNlDJp6ZnF+Z+bv7WQnPxLouk4
	V8HuFVz30swNHYOJ//wqQvYdfqpC+vpheoUOCvTXcR55LShOdQyP7kb8Blzr+Xy/24UBaoZdQ7w
	NU=
X-Received: by 2002:a05:6512:3f02:b0:5a4:175d:21a with SMTP id 2adb3069b0e04-5a887ad8ae7mr1604570e87.2.1778091313108;
        Wed, 06 May 2026 11:15:13 -0700 (PDT)
Received: from Shofiq (87-92-218-151.rev.dnainternet.fi. [87.92.218.151])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a85c341848sm5037123e87.65.2026.05.06.11.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 11:15:11 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	mike.looijmans@topic.nl
Subject: [PATCH 0/3] iio: adc: ti-ads1298: Three driver cleanups
Date: Wed,  6 May 2026 21:15:03 +0300
Message-ID: <20260506181508.6813-1-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.54.0.windows.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Three small cleanups to the TI ADS1298 medical ECG ADC driver:

1. Add missing parentheses around macro parameter in ADS1298_REG_CHnSET()
   to follow kernel macro coding style.

2. Fix a comment that incorrectly states 40ms for a 250Hz conversion
   period — the correct value is 4ms.

3. Remove the internal test signal configuration from init. The driver
   was enabling INT_TEST, TEST_AMP, and TEST_FREQ_FAST during device
   initialization, which is inappropriate for a medical ADC in normal
   operation. Only the RESERVED bit (required by the datasheet) is kept.

Md Shofiqul Islam (3):
  iio: adc: ti-ads1298: Add parentheses around macro parameter
  iio: adc: ti-ads1298: Fix incorrect timeout comment
  iio: adc: ti-ads1298: Don't enable internal test signal during init

 drivers/iio/adc/ti-ads1298.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

-- 
2.54.0.windows.1

