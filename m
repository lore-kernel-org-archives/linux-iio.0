Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E40E8498E01
	for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 08:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792398990; cv=none; b=slCOkbxZ1qFkJ0qX56+A5MxpA28wnpJHTHbb989v+4xupHKfRGuO/wQPUc2rO6NKVzYI5Qc/nu8GcvbV6tmXrM6NMXZ0UdGmA651dn2oxfssXovFAl/FmFVrOaTwrZseV6C0gnIlYukICAZFzoxo1r3Gav6FEMHQtK3dAldEbxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792398990; c=relaxed/simple;
	bh=WNP9t6TIXZ0Xl+cKQ0K8b690KUl1scppTVbII9h9hh0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kHDNRBzBtjJrkYr0n0mOUcYu1vXbrUI8deKlTJeFcYEE5y2dOnkdApllIfjsa65AkbpHzBDYakXzkEi/2wsot6fmbPWUYlR23Lf89EElzrgVDJsfne17oxCgc2ZP2ic85gFO+FHIvEKU/Np20yi8ILVisl8B72EkuUDm2eFWDdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VD5S1t1A; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VD5S1t1A"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-c418e215671so215165866b.0
        for <linux-iio@vger.kernel.org>; Mon, 19 Oct 2026 01:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792398987; x=1793003787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=eZCkslrjV5YGHVR25wzRLTh0GGDFeMzjCzaLuY5/q3E=;
        b=VD5S1t1A+M4ysbBYWBNahSQ0jaxLgmfHy6uYYITP51oOxcuzMNJ7W2qakpzzcyZgkX
         atDOKWMVlcatHAPpl2VDMxqNm+cMsQSm7IuujPD0HqDAxcisaTXYs5ruTS6Lj/buSXfa
         zPj4cXcja9FZr/NRRMr8ufAdHRhKBIiWbKkZ12SHtntkk9ZLVg3mM1AsFhC8FeD/rec5
         szjtVwpNJnU3WS9benbANAd2Mj2dl2XV3OOeDaSmmwywyH2wdnfLnzxcAHoM3wwg6HIh
         vHW62bANfFLeYrLBGRWt6XueLdCwFkmG/xroIAPhXxZaY4Iv1kjVjuA1MD5S4cMxL+36
         vbVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792398987; x=1793003787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=eZCkslrjV5YGHVR25wzRLTh0GGDFeMzjCzaLuY5/q3E=;
        b=Mb+RJB5cMgVF8A9l52y8fxdoeFOU9EUpT0C2CBQRN85gZ85rVLbnoAE6GrlxSEzTE8
         K2n+nulg+7FssG3C9vIn7T6mZkYGELDzzYqnpyzKIHK6cYWKzuCTOHYQDjh4qb4xmA5d
         BYzElc8tkz3IZDnRsv6hloFJnI5IIfa1wgGPoiyujiOznbRgUmXU5p3dUayXdt4HEcCS
         Fx/hE0SZ9oVvRDA5o+LY6I5b08FSWNPO+WgDJ8XnJFw6G3mqh3q8nhGmm2kWCNv/VmiU
         a+CBNKJdkqt456Yh6UNimYDwcuZ1Luw7VM7L8DgI75LJ0y3MSZv9T9S8ATVsCC5QLSWd
         R/xw==
X-Forwarded-Encrypted: i=1; AKwUvBz+V6EbXL9qD2zD8XUcr5uYvNXltL94u9BTrsQFDibeRKiath4eo02h5hZvbuvoaPo75P+UkN6C06g=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4ZYSN0u4pd0CfDYV550jI4XAXLxuejuc/fyogMZn0A/bgrJ3f
	WdA1Uc14W3xLc+kSlnSAFXu0xdezuXK9W2kDT8Jy1Dr5covpMvrTGPrF
X-Gm-Gg: AYBFou0wLKwu2wEJgoWqYzsK5eZe3ejVeFjuc9q3m/75eFhH4WVr40CnXXze/HVXHQw
	+hDMp8iu/blT8zxxTUOkM1BWLd1YK8c7d9CDwcdqQwScKsBspHogQt8kkeWcRY0DDw4fJSiwzrG
	S9fkVIlNPGtmUL7UUW8LQjpYQqb1XdUPnERVx8JRwv2/HuAixmmxBvVpNEwRS8rih0vtsvDhi5l
	KAirUIEYwW6ulQoBcCE+ZZzdUmWb+yKl0xaIsnZnrhqaSjcJ2yYi+3YOSAuzjtEQtxKPAeOyfgj
	aPsZ2wUiTZPMK88uIbJ+VMGzSrjvUOnSl7P30LxoFxl4k4UFqYtcq7o/XFC0nFOL7XnMMVajp8c
	f51EcwmeIzATpKhO5dHhtEj8YDcrdD+317y6T242TDiRKoYiOLjLqBt7Mn3JUBf4PzgCPHeC3fc
	SIfQYBP5LWHDGYBN9SwN0Im/sWDj1AYyAGMl1PiBnJMOU5AMV0yxECVneE74qHGDb+oAtG5E72a
	Oxse/SI1jTNh4+bchGWNxZ3cen8vLftzc2Ws3T7EBYedMgFI5bCR9pRTa92/VANig8HpxbGrrFA
	LkYnyFg/MMW6hxQg5G4Y41iSFs0=
X-Received: by 2002:a17:906:c142:b0:c25:91bc:ff55 with SMTP id a640c23a62f3a-c419e639cefmr500101366b.23.1792398986916;
        Mon, 19 Oct 2026 01:36:26 -0700 (PDT)
Received: from M-K2012N0113010.localdomain ([88.119.128.229])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4090dcf98fsm323106966b.13.2026.10.19.01.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 01:36:26 -0700 (PDT)
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
Subject: [PATCH v5 2/5] dt-bindings: iio: pressure: infineon,dps310: Add Zilltek ZTS8032
Date: Mon, 19 Oct 2026 11:36:17 +0300
Message-ID: <20261019083620.1285782-3-paulius.zaleckas@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
References: <20261019083620.1285782-1-paulius.zaleckas@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Zilltek ZTS8032 is register compatible with the DPS310, but has two
more pressure calibration coefficients and takes its temperature from a
different sensor by default, so it cannot use the DPS310 compatible as a
fallback.

Assisted-by: LLM
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Paulius Zaleckas <paulius.zaleckas@gmail.com>
---
 .../devicetree/bindings/iio/pressure/infineon,dps310.yaml     | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
index 1912a1b0b4ba..416117dfd927 100644
--- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -11,12 +11,14 @@ maintainers:
 
 description:
   The DPS310 is a barometric pressure and temperature sensor with an I2C
-  interface.
+  interface. The Zilltek ZTS8032 is register compatible with it, but has
+  additional calibration coefficients.
 
 properties:
   compatible:
     enum:
       - infineon,dps310
+      - zilltek,zts8032
 
   reg:
     maxItems: 1
-- 
2.55.0

