Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 496CD4C8C68
	for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 15:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792164945; cv=none; b=c1q9P5HMP/L+qtCGWchPpevolzedrw2yY5M3uVC1lwTV5gGAxmNU5NhxL7ZntjjR2clU6omUTJ8gKj3bBQHPTfY+7I69zDW2PpQo3PYOgPMZQs2aCgvVtLx4kQvpln6aStGIwjg24zovV+dY/UVRZaqUCf/N/6KpPIiaVLsBBw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792164945; c=relaxed/simple;
	bh=HQ4Pj7Q7nmHe8ZG4IoM50c88eztmRXYD88gxFA5urxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E5rxK0hN/sJHApV5vrhIbzk+/NdJnitNHmcWsIuSx/CyNbxCGNq5kZtSRYrebNZGtSybCWpVRFb7mk86+UsZ8f1h4BNo0jvTprqbMXKg3sLWolmuaBK4aX/qRGd5dbbkzQcysIpg73ncI9q4bhxS9u+2Cg3d2M/BH1FMaYpQDhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVvCp/uG; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVvCp/uG"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-6b1afcd2d23so7754075a12.1
        for <linux-iio@vger.kernel.org>; Fri, 16 Oct 2026 08:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792164939; x=1792769739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Qm8eZB2avE8gS3tjlwo2WEfgb/ASMpWMg+gWErFlwrQ=;
        b=BVvCp/uGDLpCIPjXDK/SNNTbaC8c/u5Jc0h3WKFnUD1F09KFmZLq2gcNAwJeQs5ceZ
         4dKPbtXzvqIrlCTYi4y5Ek3PwpQ529VRw1+ZGPrulWBe6M6+LVCc5WVFSvxoyh1FsXqb
         QBkPQH/G/3x/zSkrVqeFym/5TuJvo8NbO7XN141IKlPK//1P3ZgRjaZwB18Gg9Yif5nm
         nnycOHbPz4Nhx82FID9OJ6rWVzy1gGdieOjmg9IWgTbIqSP/7neFGgu9cy2JBP5rSbMC
         iJ393EtPpDCk6Kfcq2RfiVk0TJjamSszdFIwhRTI4cPaTQQZjG+qLHSFGhq4ddPOIC9n
         6pPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792164939; x=1792769739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Qm8eZB2avE8gS3tjlwo2WEfgb/ASMpWMg+gWErFlwrQ=;
        b=K3h3CY8Y2X+ZR4ZGHS5Coc5FQNRkcyn5KtvQrV3N2qCx69Uip7U768O7YBn5NlFGjt
         RqTl6YY+AThJQA4xOkdjttr2J2fGHgU5bxpFS90+YD488XF6iYJ6BHQR5Ruw2FcF9YDb
         uyTsYTONbEtpTDAtTA/IQgA1P6+r3AaeY3/3y9L6qWHW1DZ6C6903jvwqqSVsv5IsoXl
         58cjpCE/rqDOqc+o4NUoLVD8oUM2HhZ2o21PJH7ZV/nea/UDVN/VS8+cT5jK5C7TJFgy
         WIzEpwvYcH0ErYxW4nOdDhbcpNsbPzf4Yt/cv7pN4/4Gy5p6caj2X1wbx0jSNBdhbyMN
         E0JQ==
X-Forwarded-Encrypted: i=1; AKwUvBzWonWePPh9WU4K43ArfWCSR96JSLdJAijxwsa1O0V+89Ga5IUb5hfxcONtxnQMxZMhx1kwuyddaSk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsGmR0j8nyPSOy0u4ZXSqPbt8qGIXcOZfEFeKGmfdxYzq4lPjv
	o2oM/jBk5mX3+RawYwu7v5AQBGxYKzMrQcOMO5Q7fV1VkAqg8oYynAiQtdf8ozU/
X-Gm-Gg: AYBFou3foJ6f62kPY9gt510nrhVxJDsoGKQE9l/fEgGtpo6p7hv4TzYWLx1MOLcFA+t
	J28wuMPLQh652Go9D8fNcM6nxvLZbdW4u8ZTxSGHyPbDeA74HPwVfv5tZ6TToIgVk5rK925eoep
	ImkwXW2LtdR2Zfhm29pPMiUiROrOeqPBCDrTl9wKvuYLnmjzP5Ou8CMLXKfw3wJ8jOkdsD3AScV
	jGwZfoFePTTxmv9tJhzmcPWNsYmj1uDRUIJGeWIJ1X8Et8xtqMBC09V67BnLh3+Phh/wELJ+NKE
	hWBI8rxoW7RUxsYOSRYajB+PCU0RII4zF0SNNbkpZkSDciD+YvMszneJQkNopM9AgSMJJHfyneL
	xj4CMbKf8pTpHCruT+pG95WsRZet08Kj1p9I6Dots94MLBFjxcfrSJ+vj93xSxNLDWQyNpwtMQP
	NBjpX0tqdfF+ssSChTWY5H+QCvCNm3q9sze63UbcZZKp3DmtdRDqrxvZsI26Zk9b1WZfwLfXe9+
	YnNt6cz7o97Bi9XrZhUpA6wygn0v9neUrVacya32Onp+4tnLvbUrP19lRJhdukdbNUOBmaR9vTP
	DsB4HzF2f+KlSZfq9KdGt7u8b1M=
X-Received: by 2002:a05:6402:2b92:b0:6b1:ef16:1850 with SMTP id 4fb4d7f45d1cf-6b1ef161c44mr9864244a12.43.1792164939192;
        Fri, 16 Oct 2026 08:35:39 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6b38a1b113dsm999067a12.10.2026.10.16.08.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2026 08:35:38 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/5] dt-bindings: vendor-prefixes: Add ZillTek Technology
Date: Fri, 16 Oct 2026 18:35:29 +0300
Message-ID: <20261016153533.3701000-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
References: <20261016153533.3701000-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ZillTek Technology Corp. (Hsinchu, Taiwan) makes MEMS microphones and
barometric pressure sensors such as the ZTS8032.

Link: https://www.zilltek.com/
Assisted-by: LLM
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..255dc56edc36 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1977,6 +1977,8 @@ patternProperties:
     description: Shenzhen Zidoo Technology Co., Ltd.
   "^zii,.*":
     description: Zodiac Inflight Innovations
+  "^zilltek,.*":
+    description: ZillTek Technology Corp.
   "^zinitix,.*":
     description: Zinitix Co., Ltd
   "^zkmagic,.*":
-- 
2.55.0

