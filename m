Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48B2B4BD79F
	for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 10:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792061394; cv=none; b=J83Bjq6H/V+uWRwJFmChL/YC1940eHSAqCg64IhhEs32xkqMS8t8UUMBND3yIUjqZ2nUszUnu/9LcF+F3/uhlwaFe6WI1xfw0qgh46R9LElCJfqoW9H4UUvIejGaCQ2FlCWyise2JDO3zxFPLjgkArC83gMi+idmTyU+Nge3xtg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792061394; c=relaxed/simple;
	bh=nEBAEcr1DpggMNA7XbubOTPWUzXKTrOJxdCh4sDtEpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LSEnNpZjUXzTHEMHang4lQhDRhP9CUuT/2w2ZbuY9lLijZTQFWx+TTO+W0lWUuZNtjta/EPwGbqQNnLQToXe0aFEh6HJfz/qf0GMiv89LAm9Or/d0fM/99LnbB3u7xD24tcI8azmgkrBJMCb+j3+HZFuR8wtEsUajamI/JT2Kfg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uf8ATGlq; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uf8ATGlq"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c350db5a761so688052566b.1
        for <linux-iio@vger.kernel.org>; Thu, 15 Oct 2026 03:49:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792061391; x=1792666191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/Zy7Y5eanQKJCoQxPls43jtvnUNLhviTL0wISl0Q1Y=;
        b=Uf8ATGlqD2E7E71plUlHZjRo7gPgEIFE2QDGWsQgVD4gp1E299msUBLJoEVMtZOjr6
         xFkeO93OjRoW8f/uYQGq094vD0uiYQoLxtqp3qHSIng69LRTpt+Zwc8hqRbuH64xJuVk
         WS0fTkVSkIssVOmNfempPGqJ3Z71xRtoQytZvdqOvt5GZ9P57fR61aYE8Pk7Rn394Cdj
         aG+7OyrKhLzrP1X+g5dOaBvjVOGod5GKTj+QsUCVbHp99fnEWFQ3i7TLcteorsz6SYOC
         UoRfjzrfExiQt61k1xQGlPILzas7C3WTaAALRLPfSRAcNsnhleXmP0WQTD5wdM9e1iRt
         MklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792061391; x=1792666191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/Zy7Y5eanQKJCoQxPls43jtvnUNLhviTL0wISl0Q1Y=;
        b=M5fHVi8SWLFSScSg1uxPbtOxf3DMb6SINNBpnKCInjGlJWm2s/hsORJa+9aPz0UcBR
         NS6ZYumVZiQX1dcNTVUs8mOlp5nZpmHaXeUrdp24/5DnCIuBKlMfqN+UBsCGnJeqgaWm
         muyHsEbyjzs+CJuLXH75HLW/Sa19z7OnEf0xsYOvcbaSa3ht0CHBhrkNHk7nY8g0+2mx
         V0J/dQz2VTOiMDPY+acJshGow2HcB5o8rkw9dLleaUP5V6I6Qg1k7EjSaYosk1deM2FS
         pOkT9vaIHH96wym2bmYjHmKvp2+1DgSBrS74xSNgWDCOBGEos16L3t6BsvP0lP7dwE9c
         CoBQ==
X-Forwarded-Encrypted: i=1; AKwUvBzSeUW6nvQ0DxXqTcwKpe5Bor6r/qPC/POhL1zO+A7CMm/XqEaqqi+p9anD+keoHoABpWyMcPiYMg8=@vger.kernel.org
X-Gm-Message-State: AFq9FYKYn2p/ViLIyOMmA3yyy9sGNCBsFOyiqytlvkNrS+T0BmvYtjcN
	HceqahpNXUTtGZ0KfemiXJQl0BAvIU203PaT6rt6BLZ67a12zQNiSaN8
X-Gm-Gg: AYBFou1Q7ZkmPrzUdALQv3h3hbTjVUjI7BhWuj/2BNx+ZoLoqPuoKBJQ6JUB9t1i4zM
	vq0/aNJ3TeOGFqG8tPWjcW1/qorHWUSknvIM7HFJiErmVtW5fNK2lpKC2/8hGJfr+oQmeoEEOdM
	VpdWeEGPo7rJKYZEaEFcZKMY+NGt7coNF5XYJHFJOEofyAht+uPG16ULtkObkScxZuW1LcBjiFN
	SiOR/l+LMLOXi0KV9PWbfpZjXT6i+rY5/BCYqkOqs/lhS62A+0Tykz29kSWMimWZBCi4wxtBONl
	Vhkb5BrPvUc4rWvSPqn0ls7pq2WnppKe//6pzD+Db4c4S01lg50YReAUYGmS3/7osEaCZZDu9U7
	tOel4ZU8N3sfBi70CUvyNBe4CpWyWJBRnXS62fRXX4tANOrpFeY1ZRch2EBTg/GAAZ7TIiTufrV
	d/RKqXglzlFwXCKgTd1pkiHGCxmzlNWITjuqEGjm/UleHuH0BxD3vMXUupftn8zdz1k8RSdOLc6
	5eixTiTYdZhCqgx829fIiFLbLd6XgHZko64NTcRIDloogMuxZZGhanbOAMwv7PmEdXH3KFd8pP9
	NdbI641WQd4UWYloqSnr4dmGjCk=
X-Received: by 2002:a17:907:9801:b0:c2d:be57:f73a with SMTP id a640c23a62f3a-c31a9fcedffmr1919031566b.13.1792061391328;
        Thu, 15 Oct 2026 03:49:51 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed9b3af45sm107890066b.33.2026.10.15.03.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Oct 2026 03:49:50 -0700 (PDT)
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
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v3 1/5] dt-bindings: vendor-prefixes: Add ZillTek Technology
Date: Thu, 15 Oct 2026 13:49:41 +0300
Message-ID: <20261015104945.2687162-2-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
References: <20261015104945.2687162-1-paulius.zaleckas@gmail.com>
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

