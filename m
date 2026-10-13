Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168B94EC66F
	for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 11:21:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791890511; cv=none; b=WrfoHTOpi/L/TM/4qVIm6aZx5Aesc5RQb4/l1/GIZzodiQjr4yZZahfnYsBJWaUdjTpSWhqUYq7Vfv0dXEIs38Xn5Jb/2XBQbAQ9wEDJ7MO6vJIuXxBy+R1EWpbcK/zLtXXYiHTr6+lXtqqg5OzpKrq03Vn6FHQPAgmfjDopnc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791890511; c=relaxed/simple;
	bh=nEBAEcr1DpggMNA7XbubOTPWUzXKTrOJxdCh4sDtEpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dQEVABUg8JBXz86V5KH++Ef+yxf/korf2yhM3YqTm3V8abqKyXAuaFv+R1UG7eM2YgeExXW97J02/7dBFrct4vrdl+FHc1KmlkaRnidhSnvtVZkdhIZQtu2O7ZD2TEJeFvixybCjxBeiM3ela1dsBcXCUxN3FEcASrsK2zjMrlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a0PTmbVM; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a0PTmbVM"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5bcf21cfbdaso1570739e87.0
        for <linux-iio@vger.kernel.org>; Tue, 13 Oct 2026 04:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791890507; x=1792495307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=m/Zy7Y5eanQKJCoQxPls43jtvnUNLhviTL0wISl0Q1Y=;
        b=a0PTmbVMGoF1ttebwqEUGwsMbUMyHnvOVd37Mk29nq81yyuD5kIs/7Ws4JRW/BUZBS
         i7eHo4eKJLa8vVtaCXxbW00t2VxyZF3ENwAJ2yJpxQae2BT4DWujaznK1aryC8WH1l1U
         IQeGfVaDixBVNSycTw5g+rvbb6fXPUJwNqVaA3A6LkVqp19twMxLhPlrPAa0sK+qW8lk
         o/DbczBRekpaTv5N4IXDfNRZtShs0zcZd5rmfigUVIlATirH+lM1E3W77QbGbOGu+niL
         4Cwea3vF8AzGKKeFijSER7tIYw8m+SPvalevfFkYQVM+QE+aJsIQbjTJxsLCMR2XKc6b
         PeNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791890507; x=1792495307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=m/Zy7Y5eanQKJCoQxPls43jtvnUNLhviTL0wISl0Q1Y=;
        b=SpKC5u64NuWpe+ryxHi+2ndaVKOPYEfEf184ksv8uT3E5ilsHBzoyQ+NYG1f2Ajc1o
         cKrqUy2dDKO/r2ltJcKv9Vaik/MmwQCqcUxS5c2hmWkCnK+MKub5OJcg4WzoS7IBSV9a
         6QVF3f5WU8homwMP01PDWF8XtSdCrq8BogOqHtFE64U2844Coy+++hNWY4VeyvOEnCHF
         yS2c27LngF/jNeyMM7qu/SOg+uQHNfUhOjkjGDRjRrQzTVROZEVuIEjypfQQ8v7WLJjL
         gq6kj5nD4KJJnaoPOcxUpCFFxJN8ZGbF7ZJhO9g3FH81mfslhqyLAIsatd775qM2+Qmq
         44cg==
X-Forwarded-Encrypted: i=1; AKwUvBwrzk6uRcAY+Xc1WMlWtxFlYKrBhlaYkJnc9rZlkkVqxL/63/E3GRlT10d9+5r08XMRYfmWSs6IKbY=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ9gtyKXSrwmPO+70ayeRhaqzfsROod1ZK2eLDWKWk9fxsaFwNJ
	nXUShDGwJ6ACya6yB2GrKmUkBkPnMyykFwpo6TH7rAN7qQ+//LKsaAr+
X-Gm-Gg: AYBFou1P/MzZWzldrhinb+lg/LQIC/yngPjnKGltgvY25tpouakyQIqA0PHh3a3fVuc
	BBPZ1c4rYFFpASGKjUvl8t1qalJ18MyOB3Fg9Wqa8U/oJ8EfBMpe+Spq0GhPvHDJfRLtSsoHrta
	jrox05EoM3ui85jNy3myRMyvncmgwqAPAWniIvKHnmd9PflFnKA0k5ySvLaHjt1Cxm8d6Ip8jJv
	1JrciLwK2GLwOprOl8+/YFoxtfhAXUSXgiN3fXLvCBY8aG43+s3lITfVadxDCVdeqS6jd7OGnMh
	AQOokoIo9ovJJxZk3Jff+KulufvoktKexHfalsQz4jC6rZX/zv0jj2qWVeObyIwxbKHunP/yOvt
	jwAZfG+YQ6qy/Uqg0iOm3DsqW3+115JGUSftBIPtUwHFCVlFeokZYcknUh5OOLRfYs5vwCHTI4u
	KfJrpyfMGc2r7BMntyEWDqI2sqcUtxvvoy3SYqluYiIt1XDDaXaHLpjev17qTlk8gPOzHtxs3UU
	NOH9ovWuUUH7C69+G2UDuHJC7wFXnCA1WTEOC0WYKe06Tvo5FpjTdBqGjnzPuEkG+zfDXqhSG16
	qHlkSU+WKMfU1IwHEGrmVamMhZaa/u+VA0ok8Q==
X-Received: by 2002:a05:6512:692:b0:5b8:f960:1bd8 with SMTP id 2adb3069b0e04-5bcde8d91d8mr3905853e87.61.1791890506767;
        Tue, 13 Oct 2026 04:21:46 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bcf8a3970asm1116148e87.79.2026.10.13.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 04:21:46 -0700 (PDT)
From: Paulius Zaleckas <paulius.zaleckas@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	linux-iio@vger.kernel.org
Cc: Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v2 2/6] dt-bindings: vendor-prefixes: Add ZillTek Technology
Date: Tue, 13 Oct 2026 14:21:20 +0300
Message-ID: <20261013112124.1878296-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
References: <20261013112124.1878296-1-paulius.zaleckas@gmail.com>
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

