Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1BD4183AD
	for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 17:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544491; cv=none; b=nGanbSvTDYKHzy4skQ1AR4d37bt8RIlj0e2u2Ko4rzwPTUeWX8l09DwLa1ZapIZbFI5aq0axDsfvIjZfN7U/L5ENGOjt3HktfnhQvWaiAcPrI1n1Z2PfbqQhyeg1qM3MYt+4I5wyYxFmqVZxezyebCqoSYNC8s1Cs6SVZNIg7pE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544491; c=relaxed/simple;
	bh=44wlK79p2iFBlaDNEJYYoVrsZ4V64y2DhfrkrngDWyE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kbujWFfp410p3mZXTI8WD9CShutm3kqrAH0cJL5/ssFIKV7aMxhjQo8N/GDGXCTaIFYzOjeeY6R0/3jfe/GyvkRkbKQeydvjh6a0gdK5qSN7h4z47gaLBywh6hqbOTFxNNGq7Dg1J2BzMquxNAHSvPSEVt762VpnQtyjI7iOKWA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oq/iAIMq; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oq/iAIMq"
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7e6dcad6018so3130056a34.3
        for <linux-iio@vger.kernel.org>; Mon, 15 Jun 2026 10:28:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781544489; x=1782149289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=oq/iAIMqQZTBJlgNKViBnr8T46zaVepKpiIOpTbXyH+S5pA4mmnJq13vgt4zk8+rU9
         +RkJ5HxGhTBPjVcYSzj1Q03k7mWvket3zUokv4f59ECONFffleVednORbu1teR6PYXe+
         jqZ33h+NR6Bv1n06IIk10/Xmstr0cVxGPhiPcyfs7gVlpWls0gvXEsB8qRKDGnEGIrf8
         bhTNDelHTgxBVXZwyG3gw97LsYsRD1GPCuPWVNuEa+FiWt1xdP7+NCTE86T24Qkqwagn
         Yh4Z5vYtB9hYdFxT6aePvogsE8QdL11FnbH0DagzjgFlizZ/4GWpE6BTlN9Y0UO4et1K
         mWog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781544489; x=1782149289;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KaUmQ9JpbnpkUCaTH5UXy4GKoNzMoHaVL3LWpQbAxts=;
        b=kQhsi3d6+xL45sfqUAxJ/vCHPFpn3hYucL5QEhkl+BSjXdxlmlYrgJdnBVJTh5gBra
         o9LCcAV6zKsCcyya9mqpTfiT3lJZDHnTrnnuQkOCcbOa9euNOFXE8E4RtG99NvFP6is7
         1CDGUaYTvB/hNDnqYR/nW4ttzYxu9c+BSpZo9+yEnSfc0yTZVC+AB84jUUmPh45UrGOC
         LGx3lFU9i7J9H4nl01bD9pkjw82cBbPgB6oeVcDUu3Bw6i8SP5x8RUN0OkUeRb/EOmKR
         /u7HdIcatWKz1XcMAjztO2h55sa8P2UW5JLCzI82G4WYisCp2wCR1dRbhVdBml5sV2zP
         f93g==
X-Gm-Message-State: AOJu0Yy+43Bmu4XZ5CVhJ3u4YWlnBKYcLvOa1fXwBQiGvQ0gUWfb1D+S
	jwVfAcZ4NuL0BirOd5gCnqjSqrvWS+fo7x035jboWSdPnltv8xm8eYDKRwwRnvRQ
X-Gm-Gg: Acq92OGTXr4sp80llQ39XZJ966+wB+ejndcrJ7/7Vux/qnCOJN0Hg4/H1lUM+psRYBr
	XL99AqujmkZmiC1Qs6yKOxu4cAjLFv52+4A0ZeKqgbIk8Gzwj00yClTOwOhDaXOGYTDiEscAnLy
	s3+HPvo99UTCvHdbo8PozQSt2aUIIt/t2qqnopy6igY01SbJUMHIfqzAw47G6XkZXFc7ngQ1d1d
	JA0LzeS2xQJ4raSLE73NXEvvnoT5caO0kHIETdD5giC1exq5plFBTbBgtAR0DJVSKEXeoWTUsfB
	aIAzlgwXxFrW9rFIUfgzVyd/Up43eOoQoQrSs9Ch1zz8f1Zh0qCDm1/eQk/qV+jT0yr1zEewf1O
	DVPEtEvaGrlYgXu4lRoJyEOS1IDwugjZlYUlv/XNeBTbs4kAifI8oGW4BKi0/9NplzCpcsMfgeV
	8fWac+j7nPrtOZ+h7S1jVY5g==
X-Received: by 2002:a05:6830:438c:b0:7e6:ece3:80ed with SMTP id 46e09a7af769-7e78e7f3cedmr8432644a34.21.1781544488940;
        Mon, 15 Jun 2026 10:28:08 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e79f451fe7sm4480033a34.0.2026.06.15.10.28.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 10:28:08 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH V13 1/9] dt-bindings: iio: imu: icm42600: Add mount-matrix to icm42600
Date: Mon, 15 Jun 2026 12:25:44 -0500
Message-ID: <20260615172554.160910-2-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615172554.160910-1-macroalpha82@gmail.com>
References: <20260615172554.160910-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add mount-matrix attribute to schema. This attribute has been supported
since the first revision of this driver, but was not documented.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/imu/invensense,icm42600.yaml        | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 119e28a833fd..9b2af104f186 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -53,6 +53,8 @@ properties:
   drive-open-drain:
     type: boolean
 
+  mount-matrix: true
+
   vdd-supply:
     description: Regulator that provides power to the sensor
 
-- 
2.43.0

