Received: from mail-ua1-f53.google.com (mail-ua1-f53.google.com [209.85.222.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E47388E43
	for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 20:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787173089; cv=none; b=rlr7YMkPbMPT5mHRccps8bQzLj1hCPCwzti3g2upvsj2+PbXvbi1vAnKUuA/sCABfhmblDAHZlENPIOztjfDTrsTxksy6RrqGJ8oEH+WqdT2G2nAv6XKL5M038C7F4mYfOAlRAfzc467DB3DzUb0vGK9HI1CxIIfujjqClEboNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787173089; c=relaxed/simple;
	bh=VWRz7lckxRcd4cXpSu6pW5+eqN+XGzez1DeahohpRfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GBomhXXuZR/YulCwj1M6XBstZzIl4z4zTbb/rvSyilzJNc4MjdgmN+Ji32r8rwxpGFhvxZ12TBjF+LFWNtdnqC9IkirdrdngnskE0PHPiFg5oOa9+UkBcOvxb8YtYCXVOSaBAwe+LxSi7KeKHILQ9p2dGMhqWiqorfFMvrtafxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nmDnk2Et; arc=none smtp.client-ip=209.85.222.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nmDnk2Et"
Received: by mail-ua1-f53.google.com with SMTP id a1e0cc1a2514c-966e7380109so1148131241.3
        for <linux-iio@vger.kernel.org>; Wed, 19 Aug 2026 13:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787173087; x=1787777887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YEb/XcRzZMGFqqe/Z3DOazNhxu8ChafO/d8R+t1b82A=;
        b=nmDnk2EtRy9lekyxf8fqdCOCz4sVW0Hr+OxX9WzzH3jmAoYaMUYGDnyIqii92xcxcT
         bU0fNTo3z7yWFCH56fXcwSPLXty1Vg6okiWtAiNZbpAQf2Gtcxu7WdI1A0JdrAJZK4GM
         vHczd7OTCQdVzadYHF/A2ym00Q8owsxzH4XUxTyA2jSCg3HDvRdf5PSBNrxMnLcXgGa7
         TwD+sYaB9rFEwZ0Z0Qivpbp1em6v5cwL0VKGxVD+5nnOa3MsWZeD1HQWOZEpRqtr0+0F
         VQyeik5XDGshGCA57luGMqG4+lag6hKFqPZaCl1GxwnqX2yUHw6qwVG4q7RiNNltBYEU
         fKYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787173087; x=1787777887;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=YEb/XcRzZMGFqqe/Z3DOazNhxu8ChafO/d8R+t1b82A=;
        b=GhcEmQc0FbXCTsALIUXfAJ1afLb4PH+frNuK3YT9QhmMRfSympfl3T7WtXimqdqqlZ
         ud4FMAoee+XlDo4W35YpGlXF1wF9D3JPmacTlHJ+5tSzIgXfM+qAEyQ2e3ou5dM23QJO
         v9t6XGwis/yRoSm0ptVhoeD4OSRtqvbhkY9XZ4c3yZcJMJR3MvZa9rsQJcBx82xuQiYm
         Xye/ffGk9yPcrf1++WcV6YGNcpkbOURi2ecc6xwaq2WaoGUIcZrNlLGJPAMCQ71/7afU
         IsxCwu8bQQ9LwXIILLzQ/4qbqdSISCCDpr3oPTjxjzgVUAjnQhJc3w57wknPzcFtqtKm
         rc5Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr3X+QV2wKzt5GJN0ONR20xKXfPOjfQJ5HSmn8g4qmM9NwJl0xfAhvo4DtZ0bNsgoTv7J4CwA4J0a4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxdybKYghVKKMnPRtH9kbslx0SQ4VEK49jL1rnHwzLfFpPOpjEv
	bEB9MLyScOzxxD6wtKvKak9tFVsTfCpcBGBElKvb8ydxs9KxwuSE1BxI
X-Gm-Gg: AR+sD12P2+idpSIrsJEWJCA08JtgCOuf/lI83KHksu2Td1TbhP8BVUrG8CCFxkmYBaX
	4EFYCFlkKZKwoZwSFczG1IDm5mqXWZgJ0Ng3wJqjnMg8NTAMMPBzUVWBDGG8aCOTGkxNiwaHIti
	yEb8AzgAX3XCgoxVdkKG5B/s4sAR7LMrI+lm6XH4DNHF4JgTONdRWfnyuZH/tcLNqDKPaz0bkwq
	+Qc/2eYEkl/RbMZZji18aOq6Li8Da01I4qGK5KZa+fkXqkCDzEtDcLsKNDxrZi/NIYE6xQcCTJH
	knO33NT4k3J8zbbCIrRnm0MXrlw8avLZB42DeYrgo1GkQuWqbC2+fI8utEUvgL8dBQM8n+wnUKP
	WcWwRpqPosjv7j431p2P+VE6Z5SwumjyLqFXEqlXNtxlAdhsYjjXTt1QXZIXBqMEr4VVbOFiL23
	k3s2jmoEZbg1roS8jEhwJvqbuuJ/avaWV9Q2Z+I5ffjUceKJwpe7fOqPEBaL+og2G8YefRG1TMr
	Hc7sjdIymSqvZlRcRRzWk5+1Y4VT1B7JAVahH790mQ=
X-Received: by 2002:a05:6102:a52:b0:778:f972:32eb with SMTP id ada2fe7eead31-778f9723986mr859098137.12.1787173087170;
        Wed, 19 Aug 2026 13:58:07 -0700 (PDT)
Received: from localhost.localdomain ([2804:14d:4c64:82a2:3443:53b2:2e07:b3bf])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-777ddc844besm3616259137.11.2026.08.19.13.58.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Aug 2026 13:58:06 -0700 (PDT)
From: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matt@ranostay.sg
Cc: ~lkcamp/patches@lists.sr.ht,
	linux-kernel-mentees@lists.linux.dev,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 1/2] dt-bindings: iio: proximity: move LIDAR-Lite v2 out of trivial-devices
Date: Wed, 19 Aug 2026 17:55:17 -0300
Message-ID: <20260819205751.166030-2-rodrigo.gobbi.7@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
References: <20260819205751.166030-1-rodrigo.gobbi.7@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The PulsedLight LIDAR-Lite v2 is currently described as a trivial device,
but it is not one: besides the I2C interface it exposes a power-enable
pin and a mode-control pin.

The mode-control pin can trigger acquisitions and report the measured
distance through a PWM signal, entirely bypassing I2C. That usage is
bidirectional and non-cyclic, so it doesn't map onto any existing
binding for describing pin behaviour, and is intentionally left
undocumented here. The same pin can, however, also be used as a plain
status output while I2C remains the active interface, which is
described through the new interrupts property.

Move the device to a dedicated binding file and document the
power-enable, power-supply and interrupt properties that
trivial-devices.yaml has no way to express.

Signed-off-by: Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Acked-by: Matt Ranostay <matt@ranostay.sg>
---
 .../proximity/pulsedlight,lidar-lite-v2.yaml  | 65 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  2 -
 2 files changed, 65 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
new file mode 100644
index 000000000000..491960bb3a0e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/pulsedlight,lidar-lite-v2.yaml
@@ -0,0 +1,65 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/pulsedlight,lidar-lite-v2.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Pulsedlight LIDAR-Lite v2 range-finding sensor
+
+maintainers:
+  - Matt Ranostay <matt@ranostay.sg>
+  - Rodrigo Gobbi <rodrigo.gobbi.7@gmail.com>
+
+description: |
+  This binding covers the I2C interface of the Pulsedlight LIDAR-Lite v2
+  laser rangefinder.
+
+  Besides I2C, the mode control pin can also trigger acquisitions and
+  report the measured distance through a PWM signal, without using I2C
+  at all. That usage is bidirectional and non-cyclic, and is not
+  described by this binding. The same pin can also be used, while I2C
+  remains the active interface, as a plain status output signalling
+  when an acquisition has completed.
+
+  Datasheet:
+    https://github.com/PulsedLight3D/LIDAR-Lite-Documentation/blob/master/Docs/LIDAR-Lite-v2-Docs.pdf
+
+properties:
+  compatible:
+    const: pulsedlight,lidar-lite-v2
+
+  reg:
+    maxItems: 1
+
+  powerdown-gpios:
+    description: GPIO that can be driven low to shut off power to the device.
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    description:
+      Mode control pin used as a status output, driven while the device is
+      busy performing an acquisition. Can be used to signal completion
+      instead of polling over I2C.
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        lidar@62 {
+            compatible = "pulsedlight,lidar-lite-v2";
+            reg = <0x62>;
+            vdd-supply = <&vdd_5v0>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 2de8eb09cb7d..6a7ee45842e3 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -400,8 +400,6 @@ properties:
           - onnn,adt7462
             # 48-Lane, 12-Port PCI Express Gen 2 (5.0 GT/s) Switch
           - plx,pex8648
-            # Pulsedlight LIDAR range-finding sensor
-          - pulsedlight,lidar-lite-v2
             # Renesas HS3001 Temperature and Relative Humidity Sensors
           - renesas,hs3001
             # Renesas ISL29501 time-of-flight sensor
-- 
2.48.1

