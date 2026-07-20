Received: from mail-oa1-f49.google.com (mail-oa1-f49.google.com [209.85.160.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA943BFE5A
	for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 20:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784579168; cv=none; b=aC4cp7fQrUeagTbWv/DJYEOgoNqEvZ9y21IkNHKUj+JWNtQVaPwFeGFaSHuDzBpWYIluAJY4fQUlpVwB4HRyFUT5u9sYwj6djcw4qMxdIRi60FGcwjUQz/7oF6zwQSfz9GJXvK3q5SkSoC16tURnI1O1PJv2Bof12stA1GnE1GU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784579168; c=relaxed/simple;
	bh=0k6bV3LH2ghjcSL5r5b8oHagkbu8nFD06A6dOv4SBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JrJ/8hWcXY8F7jA8GeNmhtUCotOSMU39yURouUF7cevOB6gOOb6w+4i15nKc7LWN+1Na5D3CCR67ux7PRnkGZH/5jQPx/OtSy+Zot1VPgxjISD9OA+CflsQb3ysjFMCwrcAGA4STqlkFnzU1CNA3HLaQDqVlV94M+Fj9+Q4Guqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qrQoxkPJ; arc=none smtp.client-ip=209.85.160.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qrQoxkPJ"
Received: by mail-oa1-f49.google.com with SMTP id 586e51a60fabf-44856d185bcso6473472fac.3
        for <linux-iio@vger.kernel.org>; Mon, 20 Jul 2026 13:26:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784579166; x=1785183966; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=qrQoxkPJTVnGc+yZRU4GN9NCeCY/t3BtTw9edfhKrgWPPg3Kduil/zT7be2MXvwE8o
         IJBZN7hSjzWJiOAIQjxeQPXP4smMBPgauaJBS82Ecjj10XB9EUEbXtXjcgvUe/2of0P4
         4clJiK5Q2QPwXdp9S74yxj7ZP/u0cdlV2G5Ob4Hm0FmkhNrLgq1o/PVr8+hqeI4cb1J5
         0XIp0E46MquLUDFNDJPDGSCNYkcATjAQYXr15KRsoF8NXM5fFRc6l3atq0Jux/JW83Bo
         aX6hg7dbckwREZWuRoz4EEY6GJfM3cgKNAwDKKI8q/UvrflJ20SAfjE5fxq7U0Jw1McO
         IPBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784579166; x=1785183966;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=MJt57ozR62dMtAeICinaOXAPwhfVlSaiajP0V2TuI6f0bJY3GF5IGS/v1u3a8zGAfz
         ky2vTQ2b0bwrdU01UHTZQeZgRX9Q8cUaTNBphk1KsmvNPEKQcuZ2qLHTTge9RMddzM6f
         x7ybANKnRZkmIP3hBPxaFs/7GHHkBGpMdtvJD+0vif+EoUyUlWmvpCOPTvnEv7nNaM41
         v7j+crpHfCN7vNetJWX9oyC57XCNOvR8lW2T1NcthXkE+fUjwjPQ2S3Kb9DSgSQacY9g
         PRF9o4sbThspnV4yMETMT00B2/M6Md9qPYPwUZLOObwefwN85+WLQhwZsm4VttZQc6iQ
         elhg==
X-Gm-Message-State: AOJu0YwBsk7m1jIGfMpHcMqyVMSTSfY6ZxURNxjygTt7MRY3Sgl35mHT
	EaNmL7mgxJCpDRlqGIQ22Myav7p9JEF/+Cs22KfPOYxKrjnBdjFMzStE72QBiA==
X-Gm-Gg: AfdE7cnNC8GJtqDFMr98tGJfRUChoW5JUHy6wJEt5ea3M8pHsuxzmbLwOxD47hWc44j
	vlG6iUVj5x4BWkDlcLy+JOICcooLXDiPAh61MZ+t5JWxKBqNYQtsdQy48gIph9Eg1p5y7AsN4Hq
	Gn/cHkHbXXOeVChfw7prOOVDCWe2RQe75fE9bUQTol6WASsaEseaLFkK3dTvbZm4ZpiQDzdZUnd
	G11E64oD2KAFe1IFEd/WBCSoRJ5dghZbLDzV2NPxPP30CUuczINK9O5AEHLKP6yNUKwcWzh37QR
	R0cWVC8xuAcfMVcx0G2X0KD+pK+4YXrVbGpKPZ6D4AYPl7lF7GEGEk6IhELgqX/6FzpqfSEgT3d
	/DybnpljhGub8iqSYNUacJxWlKDK8XX1iVQoz3SBCWEaom6kOF9zgaXLanKwuiZtysaURC4B1sK
	YXfCrfw2VuwkKGowKvgo1exg==
X-Received: by 2002:a05:6808:16a5:b0:496:dfe1:e8ce with SMTP id 5614622812f47-4a4d031daa1mr7693832b6e.22.1784579165871;
        Mon, 20 Jul 2026 13:26:05 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:9988:5abf:3c51:d168])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4a4d3e5a0cdsm8029550b6e.18.2026.07.20.13.26.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Jul 2026 13:26:04 -0700 (PDT)
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
Subject: [PATCH V18 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Mon, 20 Jul 2026 15:23:34 -0500
Message-ID: <20260720202343.70138-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260720202343.70138-1-macroalpha82@gmail.com>
References: <20260720202343.70138-1-macroalpha82@gmail.com>
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

