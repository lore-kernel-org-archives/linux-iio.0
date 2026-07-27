Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C9430319
	for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 16:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785171050; cv=none; b=retVRRaIClyKl4Hk3JamN7L/2bwgJgqN0R5F4vP7kSy8BbKeGOvm51RHWtNOkxDx4uoYAw4jwXAgCOAmpGz63JXta5jrW0qnqFNQSy2AOJETJv+mYzbnHq4Pl8FARjy18ommZ6DZ0TBPpnvHYq2b30dDzFVpjolDZj2zhXcsi74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785171050; c=relaxed/simple;
	bh=0k6bV3LH2ghjcSL5r5b8oHagkbu8nFD06A6dOv4SBPY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X71UxOobB5nKpd8yz/EmcaCkUXH0QwcJ55jQU10ZfceHpwBbMrUmbpgZlEGtFUuKl6ddZsyosZj4zqQTIIeDfvehxrxm7T/ugDvFqVEVDQ73DbQzIOS5hTmYUDaaVuGlSjxPA8LoAdPsjxFUsqprukNOdC4dzi19YiiagLENktI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1vhJhjB; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1vhJhjB"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6b5737bb2so3097019a34.1
        for <linux-iio@vger.kernel.org>; Mon, 27 Jul 2026 09:50:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785171044; x=1785775844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=E1vhJhjBZHwkumULjQaDnhA5etSTPQJjGEbSH5H98GET3IMbY6w1GCNAnTVGOkr3y5
         65wVpw//PLxFddWs2i9WqXa/+yFvhe2AxfaqPqYuRPYUpCv60AWtx42ZF7Y8wiY6DFMu
         nW58egRJFlvV42KVUZ7cfNhmzsVcXcpdRKvi6BStMs4CA7ovhshgc1OW4oFR5infDIrC
         IG3kQ9u1Bv9B6NaP1wBUacJINK9MsBH3l/TYMAsZuYUyY1WhPUDu+g4jz0V06TnLmQV4
         6ZfNnEvJiXzgyGiw20SjTSkxsMo17j7zzLD5jZ9hR4OHUhdBzN5HKoJCFr8FYUcchXyu
         oiUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785171044; x=1785775844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=GK+FG51ApM0c5ceijH9gfcRis3iTLtG8+LrJylpTuMY=;
        b=VnKq+IRdFlT1VqgsX1bkpjv318FTq1CwgfIORRVM0piC5Qapi5bClJSE33DroRsOp4
         3eBxglnl5Vkx4ayG/FmOjBFAwhlXPG4Viqw0VPuIN1SUSXKteDeHbYhUFI2a1NuQwrUM
         FKEXmauac7tH625SoYwEl1w+KXVwToLCNXc57LWK57QTdHPTRq48Z2FTgOkSliUTVLR4
         wuyUONqqbVp/1cICY2TqIoZJnlQlf2f+DxbE/WSqzvbvuztvU7uEj9AcFfFoIjEjVceY
         kGAuFgUFlu0vd7QvtnUEoY36rlm8yT87SKDXHqiMao+TY5G/TYDQXky/tp4uUOhK3zkV
         19lQ==
X-Gm-Message-State: AOJu0Yzfh/fIDc+p0glhU/aP932AmJH/XzWWXi9HTCsD86njzUo0N3Ms
	e7wrRDGoaCZJrhAV2PVdkE8XS5Mn2ZDER2bGbfCCoEBJm5+clJ99Y1TXsC/83Q==
X-Gm-Gg: AR+sD10l6Uf6RKd+JxYXFKuaPk1aIYZxeLoUbFGdZ3ZM883uYyxvr4T0M2FFpawjwon
	41V/m2LaUUYKRZkaUJP8yP4wUFjaV1H3kiva7loAh1oou+6+5yRuVkLedoB8DNbh6M2i6wCOBzG
	VUnaGCFpyScLo+wxV8G+v1QqY5/81vGLlSnAutc448F7vzPxYlkt7rDYYAtjHr1DR64EGGQnA0Q
	3N82rZiJbUbWA40IPsKK/7NI7/AB6oFSgmcKzakTxzV9FLlovlTdH6hCzGDG3SF/nE6Qk7v7zJX
	aMzDDqKT8KTJrMA8Jx3yAqBMFOHGfnz/WyxnpQ/e6WtHfZX3NRHnwVJt55zn0Ksi0/T+D6ztXqx
	Aytbe+s1FqTgXQgdtaR8mHjhrUKhLzx+pYJSiCOEtpY9pV95dnlYvPOOcyn+JwukGzOTGJQe0Gy
	/eSFMbcUwyuQirJCkvZFZG
X-Received: by 2002:a05:6808:144a:b0:4a3:58a6:8a2f with SMTP id 5614622812f47-4ad5606006dmr28744b6e.33.1785171044009;
        Mon, 27 Jul 2026 09:50:44 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:30e7:7cd7:b59:5863])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4ab0c7a1912sm11395050b6e.2.2026.07.27.09.50.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2026 09:50:43 -0700 (PDT)
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
Subject: [PATCH V20 2/9] dt-bindings: iio: imu: icm42600: Add icm42607
Date: Mon, 27 Jul 2026 11:48:06 -0500
Message-ID: <20260727164815.65190-3-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260727164815.65190-1-macroalpha82@gmail.com>
References: <20260727164815.65190-1-macroalpha82@gmail.com>
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

