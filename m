Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13BA470E82
	for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 21:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787001093; cv=none; b=fmm0+ejIidKWK19CpYT/kWjtjBZE1L6fuwxeSXClg0vqE8zHQUflecX837rVUB3CHIxzpL1GIotz5RmtpCgWLfSU710q4eNTPZFuqxRcdNBijc8wrDERR+wdw29K+Xu8blUTHeq1CvvXYcJ1EHm/2Sx15xhLZxpGHpk1kFu64Sg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787001093; c=relaxed/simple;
	bh=9gxlDRHqhuwt8FJ/CwukjTyzdPv7n6MCBFsd7dAHKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EIDFyeMf30gXyFvLFSF23dGMd88jEPCXuNIaTGgLM/lDaT0uBgtWv7e/961ynMKvAM8fGIkPfdeCLk4JIk3Rv2yYqg1l91GQNAI8mGLHaUJgF8F7q2gmtqDPx6iHfNlaF7danBPw/NxHGfZujBjZmKhTrcsX1Z29R4vzOLT2+aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M9tCz+L+; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M9tCz+L+"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49800c6a846so46258065e9.3
        for <linux-iio@vger.kernel.org>; Mon, 17 Aug 2026 14:11:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787001090; x=1787605890; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ht5SF4+wx6Jf8JH+OLs35dYBN3IVS35rx1u5RktbmkM=;
        b=M9tCz+L+Hbev3R+xTFWnewrHpNUkeCm5DAeEcIz1WCzOdwFUAjx6XF06Zhps9mOAl8
         gi5P4eEX7/i02a7CFjsn/8Yk5YY9pNgV1hX22Ivt0v3r4zhdAiEVia2HSWdqWHc/K23O
         Ymck1jO0Q2w/efZ9HCAVW6A/2rO28c3y6/QighqnL7HbWuNFEIZoLy2V16N280ADxQHL
         6yAK/8k1Euzrql9p99/xUzjrmwfhHVrIk/Ba5nkgqJF9YDmrW1aVjdt+KbIlLWqUezfp
         EQtNndCeEtHB1R5R8x3Gggvb533crJtmaRzv3zfDguqs18wD8X/NEGKNaaATnMfQPL7c
         t9wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787001090; x=1787605890;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ht5SF4+wx6Jf8JH+OLs35dYBN3IVS35rx1u5RktbmkM=;
        b=k/ua0MgUJmO0jLSpjXDk3kJDG3gu56A0zT+Ps+g9irhQr0ZchsGiWmzqC67tv+2Zzj
         +pNc1j4YiFUx96/LsKas9BxJDeAdgWg7G2ooo5F3v9MsmDSUpUcqcLZn4NUC5wI6wATC
         Oph8JHFT4P4H/mjrcAKyLYfB37e5NG7dBFTX4WBUPuyVnWyfcS2qhc0e/Yn6nJPZwbQG
         4QcfWzdO0kOaeVufrDHjlKZhUuFWOzSr4+bXW91/r3CRS7tiW9ZMWlADTuIVQ1rOw8y9
         7y6TQt1xReGaUVQpoKR/MY5B1i/aLHvNtpnsdzi36Ab1MEDiOTPs/1XPfAnSyXJ9cqzv
         kA0Q==
X-Forwarded-Encrypted: i=1; AHgh+Rod8NopVbYAMKLqwaiR5Ana+SLF8ruyWfHpzGrXMAdvSp0N41g1PStkftuOL6wbakVzdzMunfU0Ur4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwaqZsE5VdOBGg8jzLzKixeCoj+heS6m+au3lIXCKZBX6i/VfCi
	Z2rJojYpEieTwX5QBgYdmpk0XbNbIgeWN83UcfZ+I3v6XPYjBLMlDTgO
X-Gm-Gg: AR+sD10pLD9uJVyTaBKJsnmnhVPR69O1jR762US+zobteSpakXHwSbB8V2vq8zHUPgp
	cG8MA6sjWhh27p/MHFQ4BFnI7Nz7DBb9kIGnIThkZs3zsi6DRQn5FiQmnYWJhF9BIbTvO+wuXbu
	WhHWvJxLJymgfMsqD4PHHtb3s9ajwy+pxBvsPPAAxvTKd16aVjTXwRBurbOiVrPwmc4UXiaDdrz
	uieRZ2FupJx6mVHkXuwC3jzOay31DT9THR7EPxRV/HcWFshSw6OHwCwSR5WjE/P0CFNxoUVh0YD
	Pdi4U/4Unix5zi/YawzYcm70yGF3Z0kTCZu+CXhqqReX5oaNRmSVs5LgtkGNKCVvEHof2Ro+ruO
	m26dN6Wq6yhxpdeXuIO+ct/8PEagiGgRNwnGPsaG1BNWlfe82xW5cqYTZNJrUMgNCqYt5fvmq73
	L1Lw6q47ahTb9fXQFBX8JkoXiPS8ZZutRJzQNNKB0CEQ0bqaITh/QZilTICI6k7OiJg2chulXBx
	A5EGokGPVIz
X-Received: by 2002:a05:600c:3b23:b0:499:8ae1:b900 with SMTP id 5b1f17b1804b1-4998ae1bb69mr347688205e9.12.1787001090092;
        Mon, 17 Aug 2026 14:11:30 -0700 (PDT)
Received: from fedora ([105.74.73.207])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49996176b95sm134587625e9.10.2026.08.17.14.11.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2026 14:11:29 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/6] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Mon, 17 Aug 2026 17:11:10 -0400
Message-ID: <20260817211118.21833-2-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817211118.21833-1-0rayn.dev@gmail.com>
References: <20260817211118.21833-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.

Use standard output-range-microvolt and range-sel-gpios properties to
describe the hardware configuration of the R_SEL pin. Ensure mutual
exclusivity using the not/required logic. Additionally, add missing
vlogic-supply, clr-gpios, ldac-gpios and datasheet links, and provide
a complete usage example.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
index 9c2c038683b4..e0123dceaa33 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
@@ -10,8 +10,10 @@ maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
   - Jonathan Cameron <jic23@kernel.org>
 
-description:
+description: |
   High voltage (up to 60V) DACs with temperature sensor alarm function
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5501.pdf
 
 properties:
   compatible:
@@ -27,6 +29,29 @@ properties:
     maxItems: 1
 
   vcc-supply: true
+  vlogic-supply: true
+
+  output-range-microvolt:
+    description: |
+      Specify the channel output full scale range. The R_SEL pin
+      determines if the range is 0-30V or 0-60V.
+    items:
+      - const: 0
+      - enum: [30000000, 60000000]
+    default: [0, 60000000]
+
+  range-sel-gpios:
+    description:
+      GPIO connected to the R_SEL pin to select the output voltage range.
+    maxItems: 1
+
+  clr-gpios:
+    description: GPIO that controls the /CLR pin (active low).
+    maxItems: 1
+
+  ldac-gpios:
+    description: GPIO that controls the /LDAC pin (active low).
+    maxItems: 1
 
 additionalProperties: false
 
@@ -34,9 +59,17 @@ required:
   - compatible
   - reg
 
+allOf:
+  - not:
+      required:
+        - range-sel-gpios
+        - output-range-microvolt
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,6 +78,10 @@ examples:
             compatible = "adi,ad5504";
             vcc-supply = <&dac_vcc>;
             interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
+
+            output-range-microvolt = <0 60000000>;
+            clr-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.55.0

