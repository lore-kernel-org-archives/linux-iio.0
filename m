Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A421738D6A4
	for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 17:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782236771; cv=none; b=HEZgypeSvek5VrjjMrDAcq7tFRSVzHfghNxA7Z1pQlHHJpkL+SxhL8StWjo+0kO+55uO8AKht8cQOm/2cVxkWkomnEywwcjD2k6soU8ooU/57BEBRSgX1taucFO7+bhcV9XWAgOh0YKY/tF3YzLv/Iz0kVHYpc0WOyMsLre3jeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782236771; c=relaxed/simple;
	bh=bDrgqU2B+UkBBmPBzeWE0+W7wImAlYaHQusokmx8XJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f3cLFkUikoTPnGx4zK++pZna62v3m0iILJzYJFsqUAol2naPISJHTClcsoKt1e1PofDFpJNoTwjbCsQBrEueY41A681sNMJxJUA/Fqk90ofFs3cR1yydnMvx0kNdedgzCIZdx76veh4YfK1p/4rd4mBRxEa+5WpH+XD4+kQYHTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rszAvOdl; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rszAvOdl"
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5ad53c8d4dfso136119e87.1
        for <linux-iio@vger.kernel.org>; Tue, 23 Jun 2026 10:46:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782236767; x=1782841567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pD39JBAAp2uVwZ98fWzVa8hs4x0Q++h2beL6bLFgwHE=;
        b=rszAvOdl0gTA286+WIjRKfAS/m0LBNpE0IMWOMqF9qEPKR9/OY7wl9w5G7zFDdprYt
         7KC3Cu6zP0d2Ei1jK3QWlkuygD0BHT8kuXa1UH5awB5V3hFkPhmOtyc4d6RZqEQC9YDG
         GPuYmV+tI+5nlZlm8/GXGmeqJ2eS0/GZHk95HFurQTkZTd9/m46XYF0nq96AEhq0wxcK
         bCyHLLAxn28pOXhMXoKvBqlzQKRAXqvNRbAmGUfxKMdO1f1wEdurLyVG9yWAx6sLCiPh
         f2BNCHPA9i8q1lyOWSXg4Ra3nteo+ag1AoKQyVr+8GioMrWOb9pLUAYgFjOHjhLBQ8f9
         9Vsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782236767; x=1782841567;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pD39JBAAp2uVwZ98fWzVa8hs4x0Q++h2beL6bLFgwHE=;
        b=gGHAoAuCYWTU70RenQzO5boeSXVJTF8eMuNvYxsv42y0EGqr7viq450RzE0sciF/B0
         HYoQeUiJel/t/+lTc47+snUkl058eewNCLYtgbrVQtDmEx+GsK1gwIm2ShTmjmJXmHz/
         qA4hl3Y6890+L09GRrVeV2D8eE2zUphkPMJ7JJMiYgaV8BFSlIqHmeO7ishFojZYJ+uc
         fA/S59QpuKYphVLhoZudX2g2PsiDkpeyRrZb7JwKXlPQiQg46Yqe5noy5cSTY9tTSc6f
         v0Uu7vXlMjhkOJgtWJLLIoE+0CKH/HQ0XGKCVZ7x0rRi8RsldqUlRqbHI7pBQulGnHfb
         1zMg==
X-Gm-Message-State: AOJu0YzeXhtU9bNQ3K7P4SdD4CNbuzEHjXSqtMFZgYAyMb+pO41HmSpW
	W4QxUFv4X4AWwfVdio1jLrJi02ll4IM92KhNFl8/sGdMKKBB3ZAciIp++ZIdWImHM6bWmw==
X-Gm-Gg: AfdE7cmFS2dqGAN7BZstn1fvxxjyJ6BF3XQCavnyXImqT8qwMKR9Ll05X/vrYWHZRKq
	/SJf9gPeMk3yKHWWgETkbtBsDpBpS3iH5cVA5YwpGyBrIcRphFeYz8ZtP0aTX3LNQJa+KEvfWkn
	dY+YXjabMzfPX00EEaL9pa1zCm+CAT+4ohd7jUJDIJGJuXSQnaFzkll1zX6reZGNumYszhBvSjb
	DDrpsoMeU8wn1TtH7AbsgSnH35zxejY5N1fUO6751ESX9Mr7J4+I2upl5sPlHU1r7rx1KXIDuNH
	eu0ZHBmhCxt4DOStCRRgZrcxQoK1CwgcFhCcU7ZcdOW9RzRR8t8NPwQZ3a34xGAp+d/QJ7oRlRf
	UlNV6XLwmiCH6BdjMiJrGdx1XEO45exJ7FDWqilNDORFiJOhgzy71QdC+AQi/tYQh4QKPpaIErf
	DG9fFULx9SZ5MnF8tUZIATGlQNnlOALZ8UDvXyffNd3Ilfwg==
X-Received: by 2002:a05:6512:1156:b0:5aa:71e1:edab with SMTP id 2adb3069b0e04-5ad696c015amr1362920e87.23.1782236766715;
        Tue, 23 Jun 2026 10:46:06 -0700 (PDT)
Received: from Shofiq.home (87-92-251-137.rev.dnainternet.fi. [87.92.251.137])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3999afc7005sm27198651fa.13.2026.06.23.10.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jun 2026 10:46:05 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	lars@metafoo.de,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Md Shofiqul Islam <shofiqtest@gmail.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: health: add maxim,max86150
Date: Tue, 23 Jun 2026 20:45:58 +0300
Message-ID: <20260623174600.17100-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260623174600.17100-1-shofiqtest@gmail.com>
References: <20260623155556.13701-1-shofiqtest@gmail.com>
 <20260623174600.17100-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add YAML binding schema for the Maxim MAX86150 combined ECG and PPG
biosensor.  The device exposes two PPG optical channels (Red and IR LED)
for heart rate and SpO2 measurement, and one ECG biopotential channel, all
accessible over I2C at up to 400 kHz.

An optional active-low interrupt line connects to the 32-entry hardware
FIFO almost-full output.  Two optional regulator supplies (vdd for the
digital core and leds for the LED anodes) cover boards that require
explicit power sequencing.

Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/health/maxim,max86150.yaml   | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
new file mode 100644
index 000000000000..1bf10fd1a3d2
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/maxim,max86150.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/maxim,max86150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX86150 ECG and PPG Biosensor
+
+maintainers:
+  - Md Shofiqul Islam <shofiqtest@gmail.com>
+
+description: |
+  The MAX86150 is an integrated biosensor SoC that combines:
+    - Two PPG (photoplethysmography) channels: Red LED and IR LED,
+      for heart rate and blood-oxygen saturation (SpO2) measurement.
+    - One ECG (electrocardiogram) channel for biopotential recording.
+
+  The device communicates over I2C at up to 400 kHz and raises an
+  active-low interrupt when the 32-entry hardware FIFO reaches its
+  configurable almost-full threshold.
+
+  Datasheet:
+    https://www.analog.com/media/en/technical-documentation/data-sheets/MAX86150.pdf
+
+properties:
+  compatible:
+    const: maxim,max86150
+
+  reg:
+    maxItems: 1
+    description: I2C device address, always 0x5E.
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Active-low interrupt line.  Asserted when the FIFO almost-full
+      threshold is reached or when a new PPG sample is ready.
+
+  vdd-supply:
+    description: Digital core supply, 1.71 V to 1.89 V.
+
+  leds-supply:
+    description: LED anode supply, 3.0 V to 5.5 V.
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        biosensor@5e {
+            compatible = "maxim,max86150";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_EDGE_FALLING>;
+            vdd-supply = <&vdd_1v8>;
+            leds-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.51.1

