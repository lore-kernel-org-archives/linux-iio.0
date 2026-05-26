Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A3D3C09E9
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 18:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779821848; cv=none; b=IWk4cY6B7yeHy8xUL0AM38vfUyOsen5l8nmFOUybScAShnQnS5uMGQIJntAFVULLuDigBwpE/5L+7XqaICDqiXdZn6zvEtTRm6IY5Au+IbaKU8h7bToC5t4JGxxILK3sPSNXwIcorogk07O4gxg654S956JZKImcgsob5jstm5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779821848; c=relaxed/simple;
	bh=ux//nAzmjjvkMBWaUPyDWOB5C5X7QaoPrezl9UkoOms=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lbv+JwIEgPFysizlc2RBPJBIpbk7KPErxCTaLf+f+SwJ5rdtY62au9poz0et9nkrixvChlB/AEcpHU/JnhoVffTnlhnds061MfPIxbG5PezhmYtU+kc6hd3gFoVA1XFONzX41xNQ9wt5nbdjiDAKXBtu5GQ5TQjADk2h4OvqQWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oO8z9sHZ; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oO8z9sHZ"
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-8b9f2295a9dso119238796d6.3
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 11:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779821845; x=1780426645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GqXp3HkuQTjYBFNS7F4CYQRHQWjXObowIhfHC42UNQY=;
        b=oO8z9sHZ5Gy46Bs0k2Q+StlBxDqVvu+90PWvsl9IO1LhgUdqbUc7U2PWo6c6FZXPq0
         nRsHvwZaqTf03g/wypQKhcNbtyExEFXJRpixAgcuNU9nSd0Yc5tUsPx5NSNqdZrcStl1
         Q7OCckQkOjyfjRco0bMoVf3GXP9jVjVgVv+S3im53yQ+PFf+2a/cgxcuf88zpNlHSSea
         0LDVlYFkCwbF3TGa0tWhV7bdeWd5OolxgL/9L8ivypgAHliW3FGXvcJ8CWxlnBn2P/cE
         nWbPIfgt22aUJvN2M8yA9nS02cVJ6I+34itOA3eYkhRxTFG8Bhi7VkKMyLJD1vc4iDMF
         PvvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779821845; x=1780426645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GqXp3HkuQTjYBFNS7F4CYQRHQWjXObowIhfHC42UNQY=;
        b=R6uCTzonIGDuC0AhkLxZL+rKvMmSo+fJcmj+X5EXV5AlPGb2VGgy2ejfI+66soGXVf
         bD1/RrtfHJ+s+nandOifiRztdfLOpz5NhH/8eSJXM2oIX+2OcoCvGuryNZAKjUpUiPsr
         S7zO/7a1VJA3Oe/LtGoAgJqoPsplS3E8THF2+Ia15flCa9CG5Vub7Rzd1kJ5wJ8Uhe2D
         A29GjcVxNBWb24r4EpR8qdz1IaL7RNLCcfk1CLieAQqm+Zx1v4vd18jXiNcNFPcWHaxh
         HVGOt0Fwr+nTn0o/i+Fu8Oy2CGBhq2ZM48d2Rna8I11TaJR2PaaY/Io0B6vhGEVsYw5p
         cMdw==
X-Gm-Message-State: AOJu0YyIz7ncdbiNf0STp+QLOq77FxTnTCOd/v9jpOBoxBMnU1OwA7Or
	w3YFb2+y6FOerx+Y2ahB97s22wG6NPLknTrRhivgXKijOs5kswTrGKbjar/PFc/4iXs=
X-Gm-Gg: Acq92OGkEibUk1Qsvq9rK+OeeOqsvlFvI8qPz8zJSrwJCRuPkMHHaHQOaWRqOL9aXCQ
	B5n81OjpgPdv34ccjkROk7oe3Hn3wvQTlFK6cFkyibO7mJl2m5Hn6nJEHeJLuRjJzwwCjab0nCP
	7Om6pv6fr5GoIe18pqRSKroYslwsaIDjvIpmGzf23F3NIfs3vyagGaj0Sg96MOHONYXePAtGzwt
	qp6GfBuVw2p0FG2A8HnV13DfMqQlXOfXfd7D4t8bUfY+BlBAQu3vvJGiQVSAbOhq6y6Ew89rWef
	Iz7kslk/LpUTQKRjyGCue34FTVHeI7Aj+yxP0w2jFgkbHUc7BC8LvNetBz9WE9hZg2IcX3ZGMyv
	TbRq57NDwpYeVLBoAa6Ldlx34QLfFSSra4xO1/Iah7WKZAVuukKRO9RHJob/QBakEW+JSyQTRnU
	KUkmHvAfNlLaVjgSy71kLE3A==
X-Received: by 2002:a05:6214:500e:b0:8ac:b471:efbb with SMTP id 6a1803df08f44-8cc7b59a5e2mr325817966d6.24.1779821845180;
        Tue, 26 May 2026 11:57:25 -0700 (PDT)
Received: from louisarchdesktop ([2601:184:417f:5ad5:c570:9008:5a2b:8db7])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc80dcf797sm150619496d6.4.2026.05.26.11.57.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 11:57:24 -0700 (PDT)
From: Louis Adamian <adamianlouis@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	Louis Adamian <adamianlouis@gmail.com>
Subject: [RFC PATCH 1/2] dt-bindings: iio: pressure: Add binding for MS5637
Date: Tue, 26 May 2026 14:40:30 -0400
Message-ID: <20260526185612.35048-3-adamianlouis@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260526185612.35048-2-adamianlouis@gmail.com>
References: <20260526185612.35048-2-adamianlouis@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Create meas,ms5637 devicetree documentation file and move existing
devices from trivial-devices.yaml

Signed-off-by: Louis Adamian <adamianlouis@gmail.com>
---
 .../bindings/iio/pressure/meas,ms5637.yaml    | 52 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  | 10 ----
 2 files changed, 52 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml

diff --git a/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
new file mode 100644
index 000000000000..703e34989cb5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/pressure/meas,ms5637.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/pressure/meas,ms5637.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Measurement Specialties ms5637 and similar pressure sensors
+
+maintainers:
+  - Louis Adamian <adamianlouis@gmail.com>
+
+description:
+  Measurement Specialties ms5637 pressure and temperature sensors with
+  I2C interface.
+
+properties:
+  compatible:
+    enum:
+      - meas,ms5637
+      - meas,ms5637-30ba
+      - meas,ms5803
+      - meas,ms5803-01ba
+      - meas,ms5803-02ba
+      - meas,ms5803-05ba
+      - meas,ms5803-14ba
+      - meas,ms5803-30ba
+      - meas,ms5805
+      - meas,ms5837
+      - meas,ms5837-30ba
+      - meas,ms8607-temppressure
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        pressure@76 {
+            compatible = "meas,ms5803-14ba";
+            reg = <0x76>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index 23fd4513933a..a1516ab50a40 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -232,18 +232,8 @@ properties:
           - meas,htu21
             # Measurement Specialities I2C temperature and humidity sensor
           - meas,htu31
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5637
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5803
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5805
-            # Measurement Specialities I2C pressure and temperature sensor
-          - meas,ms5837
             # Measurement Specialities temp and humidity part of ms8607 device
           - meas,ms8607-humidity
-            # Measurement Specialities temp and pressure part of ms8607 device
-          - meas,ms8607-temppressure
             # Measurement Specialties temperature sensor
           - meas,tsys01
             # MEMSIC magnetometer
-- 
2.54.0

