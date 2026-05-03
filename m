Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72DAD3AD53B
	for <linux-iio@vger.kernel.org>; Sun,  3 May 2026 12:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810228; cv=none; b=dym+RsXOa2n+o4h5uq1yLQUxr4lSLHQk+f/r8pCbZN7rmDAxbHLLcumWasRXm3edwC0E9xGi76Q+/JooYKkzdwzqdlFXx4G8fuo6LEAPQ7VZcbSZL8Dde5unnu+xNYUmJ4tpTBK6sjrFUu68w3dxKVcziCxsf+y90W6sxhKlPdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810228; c=relaxed/simple;
	bh=W7FJ/zbVP+//+ufafVTu0ETiLzypoHQU29K7UG+1ll8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=D4I/AoB/v1AMwKikFN7Qj+Orbg86LAUohFUeNphV1RoAhUGUYMubKRrjq9qqxmxzAaY+nH71/pBGWTnhHjbAbg6nlQBc0HssDpi4xVTzKu9zL+8hErVf84JVxy5jwB3mtZ6RIEBzYJK4/lVFPuB44ie1n/vytMok0mT5jw5ar9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oz/GGA5e; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oz/GGA5e"
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-c8025f1c227so302366a12.2
        for <linux-iio@vger.kernel.org>; Sun, 03 May 2026 05:10:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810227; x=1778415027; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HC3omfUEQuc+0UzHsrBzp98xO7QT7jZEFHNrIReAJzA=;
        b=Oz/GGA5e+hxY0i6vIzpTxiPJahw1J7QKMVcclvydIheAxh5b3obRRc8G97z7ahmSm6
         DkzoblfSBJVykU5/fh4yPmjjqkldaMeqYQnNncHatps/rjDFb13OvHtqMMC1L9mX0MRx
         bMJWzy4fO22qMrl33ZsPB3FqGml+Htjfw80yvICtW4uqFAxUWT3Gh1K96+AwX/Ba8sth
         pN6cSajd04ySwpaWvxMFXY6NGw94AFdWzLu42mVhWhi2H6QEuBlKoIv68B0803UeSReF
         I4glftUUHMWma6xB83obQPMXzjhuRVJUQ1Ent3uMWUJYdrR4TEKLrO5keOYjWqa819fY
         sX4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810227; x=1778415027;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HC3omfUEQuc+0UzHsrBzp98xO7QT7jZEFHNrIReAJzA=;
        b=n+U+YFAYCRssDa+WDLOU2+UdQnZYnzcrKNjoU3/H9rIrQcwFVeoo6f5OVJbeEQ0x88
         Nyuzum9xAmjcKuE83hjaCcjzi1U4Gw+/RomQsC+e8gsxCZRXeijM8/JzjCROeBfoP/3E
         AgLPDcmTQJcQMsgplFmL4lOWxxLBf6M87L9r/gktAT3tPTFosn6S97c9CbxhL4mrUmbl
         AKJSJOMnqMZ5y8F3tUitkhOjjtuT1UR7pA1BtfI/teQbD0p+bnufuKm+nuq/nRzba7E2
         1qvUB1pQr3ckSWHep9QszIajBJgA831RYUkdyl8cRZAbXmORGnXfCODvj+sdR6Xy5Bjm
         0vIg==
X-Forwarded-Encrypted: i=1; AFNElJ8P487G8m9NYndGMF+oEQTlgn3pdIgGk+NbKa4h+5pJsh0aT2L/xrgG+Pv3+yej3D60AqaDhAQVin0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxR/eBvw5aC3qsTFuBymR7b7tRKVny4aIgqwiUcpkfnSqJgsjr
	lQGRtuWM/PDDWSrmXLPg6RmZJE4XrhbL0gVcqvld7P1lfX//NngBow8a
X-Gm-Gg: AeBDieswvOlonpSi29mNjEkKshfT1WW28oGzz+a6/TMSr3lIFzRbszbap9XL/dU5LF/
	/86hALwEqIkeLZP6YrUd1AN/hRm5kpesLw6fsspjXkB/QgPHY56rjoZtRu6XZ3gu++cwbIm+x2x
	o4WYUpfoT20O/rxTWUVhMua1x4nzR/qZP5ZNO1dYy8GkTKiBC3k9g/Vx+zBmsmd7kgHcZa4site
	8rLVk31cntfsiLs18Ehxz5YKb+3NiHk1EI3QhxVof3irDi4YV/Jimkp8+lR2Fuoz9d1hGCixC0g
	Qkl9YkP/txGuDjTvLJcgIjOh3hXup//jK5ZIjKFmkcSuSAkrCmflcDzfBhxh1ta4xeG4FPiqc57
	GCLFjAgcwurSuttgAVfzWpTVLgxQhgkawrVM4OLNKQnF9PUORXtQC/0W5HfJ/YiVcFQyLf5qBFe
	5xNJckgMOWihTqdJG+W3fza26vxcQulUxjQFiVS279/KnN0rCvTvXS9AY6LEQVVvMfu5rwwTODG
	Wk3YQTSzZIw59qx89j8zoCkR+zvWcTGBgVkjMGzTpHYNWSowNBwxCKX0qwhfJQFOiMo+Cg=
X-Received: by 2002:a05:6a20:9147:b0:366:19e9:f43 with SMTP id adf61e73a8af0-3a7f1a7f72fmr5900257637.6.1777810226751;
        Sun, 03 May 2026 05:10:26 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.www.tendawifi.com ([14.139.108.62])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8357c4f4530sm1474364b3a.9.2026.05.03.05.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:25 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: Andreas Klinger <ak@it-klinger.de>,
	Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 04/11] dt-bindings: iio: adc: hx711: add HX710B support
Date: Sun,  3 May 2026 17:39:33 +0530
Message-ID: <20260503120949.80292-5-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260503120949.80292-1-piyushpatle228@gmail.com>
References: <20260503120949.80292-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the avia,hx710b compatible and document the HX710B-specific
DVDD and VREF supplies.

Add constraints that forbid HX711-only properties on HX710B nodes and
require vref-supply for HX710B, then add a separate HX710B example.

Keep the existing HX711-only binding extensions in earlier patches so
this change is limited to the new variant.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
 .../bindings/iio/adc/avia-hx711.yaml          | 42 ++++++++++++++++++-
 1 file changed, 41 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index 9134bbe41379..b2b5c7bdf05e 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/avia-hx711.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: AVIA HX711 ADC chip for weight cells
+title: AVIA HX711 and HX710B ADCs
 
 maintainers:
   - Andreas Klinger <ak@it-klinger.de>
@@ -14,9 +14,14 @@ description: |
   differential input channels. Channel A supports gain 64 and 128;
   channel B supports gain 32.
 
+  The HX710B is a 24-bit ADC with fixed gain of 128. One input measures
+  the differential voltage between the two input pins; a second measures
+  the DVDD-AVDD supply voltage difference for battery level detection.
+
 properties:
   compatible:
     enum:
+      - avia,hx710b
       - avia,hx711
 
   sck-gpios:
@@ -44,6 +49,17 @@ properties:
       RATE pin state is determined by the board wiring.
     maxItems: 1
 
+  dvdd-supply:
+    description:
+      Digital supply voltage (DVDD). For the HX710B, DVDD must be
+      greater than or equal to AVDD. When DVDD is a battery rail and
+      AVDD is a regulated supply, one channel monitors the DVDD-AVDD
+      difference for battery level detection.
+
+  vref-supply:
+    description:
+      Reference voltage input (VREF).
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -53,6 +69,21 @@ properties:
     maximum: 2500000
     default: 400000
 
+allOf:
+  - if:
+      properties:
+        compatible:
+          const: avia,hx710b
+    then:
+      properties:
+        vsup-supply: false
+        rate-gpios: false
+      required:
+        - vref-supply
+    else:
+      properties:
+        vref-supply: false
+
 required:
   - compatible
   - sck-gpios
@@ -72,3 +103,12 @@ examples:
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    weight {
+        compatible = "avia,hx710b";
+        sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
+        dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        avdd-supply = <&avdd>;
+        vref-supply = <&vref>;
+    };
-- 
2.43.0

