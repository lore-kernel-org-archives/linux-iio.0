Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A5D4749D2
	for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 22:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785279489; cv=none; b=MRlvKnWkjD807czosvbhLZFNwjtQeGshEcDWSPNBJHGlWgiPr+v0QylFFyvfTb69gEKwX0buNwBm8urP2hMNaaxzxDMUO5WQWArjmqErGiYd8D/lvvcNTXmZROinBzBvH9s9Me/c87u0WaaarGX91m3hnVPeK2v02eH+lgmrgDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785279489; c=relaxed/simple;
	bh=0k6bV3LH2ghjcSL5r5b8oHagkbu8nFD06A6dOv4SBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hADgVbDzqXL31U0dBS66XAttqaXlySXbyQtUHu2mXgc984Hgnpihai7OyahrKj5lNpfoYc0o4ndtPakH18+a3KY59VkKReywxmkMEAYA8FdotpQZDf0n8KNDaPvDsyqgT8FsnIfJUwnl9YnmidpLDcN1bvyKjGsDZ72ATJa2Oqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pfOzCV8W; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pfOzCV8W"
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-44ae14b4fd6so130319fac.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Jul 2026 15:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785279487; x=1785884287; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=pfOzCV8Wd97bC73QBfzFTQjXKTUISK77euZtIyVYlH9zYAVh2CZlTPsSaS1aBlkIs2
         wVOH/Wzp4h6i3QKxzGKOB9+vEvuBGT1pgKEAPTjl3qvdTnuUu7gqtbrLY2cRMpvur60g
         TwNS9iIVly+aufltu4utOferw/Bn8r3W6I8LfqjpTHSFyU4hjE+MUL9DGYkFDhhN+BAM
         h0UgmpFPOZFx7WyTdv5k2GT5BCnyUy2FSw0/nXDJQAhCaBsdPZ9erSIzxzatIGslSPz1
         qubQR5PR8sVQyqGb9b3NxpWDSh8F3jY2yq5CsRAANcrgh6roZL2dvGB2/U+D/jo/3kjf
         0YRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785279487; x=1785884287;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=Nx7fP5QB6s8hS4N7g9n8ymIWxmsLkKwwIUBCXC26TihOsxLSv0Dei1/Og4OKhuEvJw
         k+v7BLQ3sP1o2LiC2JJWxvCoxqyECe4LzX7Ro+xxDGFhdj+vMv8HpcBlMr1fdsO8emu/
         srX488UBAF59Od+Gh2O8LbJqRmCTKhl2S6UYWRBVsIBQo4dV/Oa5m6NoGcyrcXRWZaxN
         zy5UKH/VaX1I0IkabEktVqF7H18oSnlkRN6t92ZURxRYFHMWTKFexnaGPVxZTlzZdcBn
         yikiXfjs8VbFB1T9hKkG4uvgYd9Cv3byvtHgVEmTWFM+KdwnVi66W3GdnL/rTI48qg9L
         cH8A==
X-Gm-Message-State: AOJu0YyQnMgaW+P+wkH2DbdMCPTL9B92yorXr1QpcrnCwYsTEpQBilWH
	xrSVHhCFshsyfEN0xFiN99j0b05T5S7JK9KTC5CtA1yyWvtyPv/neiYzOihu2A==
X-Gm-Gg: AR+sD12ouSNelkqWY0ukW7Mge513jec/8Ou/W8TAQnKrd0hx1H4fzR8r6FhbudUoGPV
	Mrzv1WuJkXIjNEGk9nqO4bFzcsf4QiPg10w7GsY2jJYmkmqSmximzYkVruT83ftDsBQ7pAC9BMc
	jHg1s5FJsMmEiwg0Gj8btJ4fapPzL7uRgvClfVL3o0WVh171AVG8CoQ+3fHdZDDqRUb7WHLRiTG
	/lWLDsunUHvWpy413F+Es2w6C4v/a2RcVxwQs+2PGMTl9I4vezC9eX0EDLq/5P0wP3Dk6QlCrpD
	dLTMikkCZB0XbLBEDlzs4pxLJO8rBon0iqJHU30RCIM6ZxrKk+MChipycNU1LeoX58iy3GhNhka
	V6CDrOJ6/gAiWKc5UzTmqrB/dYun3Eg7PtHVBen5CHz1T/0eVg5tGbFH5x206ZrbnOJ5R3VTgT8
	gBq/P8pez/ZmYYq5tA0xH7QCQ4G6vkKLrBpGUDrFpTNNdB9fV3UYle06G+i7Wz/eI4Bwgpr08r0
	jsIKvMN
X-Received: by 2002:a05:6870:7204:b0:44c:e350:a0b7 with SMTP id 586e51a60fabf-4586cd87f4fmr2888608fac.27.1785279487214;
        Tue, 28 Jul 2026 15:58:07 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9162:e42b:cb94:2d55])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4588646ade0sm990277fac.5.2026.07.28.15.58.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2026 15:58:06 -0700 (PDT)
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
Subject: [PATCH V21 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Tue, 28 Jul 2026 17:55:33 -0500
Message-ID: <20260728225542.174825-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728225542.174825-1-macroalpha82@gmail.com>
References: <20260728225542.174825-1-macroalpha82@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add the ICM42607 and ICM42607P inertial measurement unit.

This device is functionally very similar to the icm42600 series with a
very different register layout. The icm42607 currently does not use an
interrupt because wake on movement and buffers are not supported, and
cannot be implemented on my test device which lacks an interrupt line.

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../bindings/iio/imu/invensense,icm42600.yaml  | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
index 9b2af104f186..81b6e85decd5 100644
--- a/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
+++ b/Documentation/devicetree/bindings/iio/imu/invensense,icm42600.yaml
@@ -30,6 +30,8 @@ properties:
       - invensense,icm42600
       - invensense,icm42602
       - invensense,icm42605
+      - invensense,icm42607
+      - invensense,icm42607p
       - invensense,icm42622
       - invensense,icm42631
       - invensense,icm42686
@@ -67,10 +69,24 @@ properties:
 required:
   - compatible
   - reg
-  - interrupts
 
 allOf:
   - $ref: /schemas/spi/spi-peripheral-props.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - invensense,icm42600
+              - invensense,icm42602
+              - invensense,icm42605
+              - invensense,icm42622
+              - invensense,icm42631
+              - invensense,icm42686
+              - invensense,icm42688
+    then:
+      required:
+        - interrupts
 
 unevaluatedProperties: false
 
-- 
2.43.0

