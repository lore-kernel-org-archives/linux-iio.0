Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1738843D4EE
	for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779900238; cv=none; b=CQvrTdUzabT6E0qDkC9V8mjzoKhQhR7WTd6fFMAhQplXxV0CsHiftxBHyTlSMlk4d1vqT2HRjnNEcT9R5bvgRCfM5evSp3lfXIjIQ3oBEPoF6C4W3F3IAUuEcaxln0vkKzVgqlI34/Zpuf9FlMtq9V26rUCIEtCmQk2sOJqHBgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779900238; c=relaxed/simple;
	bh=Df1zfxUcoJgzKYA94f1omrtd1ycQtNPRDMqqjwj7kq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KY7+apvgConVbr1KIWWpWMoiNTsOE8Gb6bQUne3FxfEM9kMh/vMoVgZa54v6bfkRmFpEv9h278bUypnDSuPCihvvJ4+GPQS73FiCUoPkLYB1FTJ66xo6ziXXY9l/c+QdVs0XvUjvSbSQ6+slwv7wwxVb4oQuGmb7AgY234pqVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLCDvO+g; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLCDvO+g"
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4891e86fabeso25025075e9.1
        for <linux-iio@vger.kernel.org>; Wed, 27 May 2026 09:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779900235; x=1780505035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FuiZVwgHyVLOrtY6z/z/MEbgqoHcYU8YHGNAKnxMJFM=;
        b=ZLCDvO+g51UFUTMOFbVJATutVlR40eHuyzEc+cgZzBR4by0AtMCyZj3ak8uFj4YQyp
         717SqMxVxQhudkP8ygYlR+QTrX2W/ETgMv3lh0n+inCRlbpt1c5wJCsKsnLX9+mPhNnP
         DHGNXdKREpRaz1qD7WzjDUr9wEvIxsGgIaCvxhDHKgElFzfkikv8PdUwh7y6hajGMFRU
         HTPkINFpQeUJYzYzj+3nsHsd/q8trEQgQodSVNBVfE5CujDQ9h7oeyi/SGMRwncapCQB
         6/dyVe98Suitke8CqTUdV0bjWks0rDaFycbQ23yyKT0u8NSn3TB0XK4tL4KS82GuLQAT
         Be4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779900235; x=1780505035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FuiZVwgHyVLOrtY6z/z/MEbgqoHcYU8YHGNAKnxMJFM=;
        b=dXa9jhzKELXgzAPS3uJK7oaR6UY9LHAp+8hO506Sy7Bw4CQfJRyN9d3Lyc20OYKpia
         LBDXi/Em4VROLMgNCeSE8Xefm+99wHx1Z1KrplAGU0fY0NvSrbnuBFfv0i23nIJmMWTi
         HL1eFH6H81wkIz2AR5LfhuZYGRo70IfTqVXnvRrxfXevMXY3sMen4iuZ2N9gxOvrV6I8
         9PXyPQkIzit0pUApirjiiLLPb9opaTPd40ongQQ4cRq09Kc9Gg9uqhBGa2K4ZMl25euW
         VvoJKzYjp5cJyX73kD2lryeD88EFe/4mE+U1vr1YEcWsv5CILqd4OekGyFSdqBpZPrDv
         Iybg==
X-Gm-Message-State: AOJu0YxTspCZPB+2+En5PndMtPAnYuwEhcBdETu5TDRxUTU7v85hIFPB
	6n/QugVN+Py0ICDISTn6pfqc0NWZ6lCh4Q0rWhTUThufKCat1oXvHOJv2KuvSH+5
X-Gm-Gg: Acq92OGS4o/5rPvF+drwtzWfQZ8ohqNbW6voW7+DWS8esLjgA9npDIYyACbSFsLDC1I
	j9HZT0Rj8Z5XyGz+rcrgxFSMU8SukrycsOCZAltes6zWFZ7qhluULXb6iU9JT0Qve9zikJkfxMQ
	u8Hcz3Vg2sK2QHR3qnvolr9RLAadedD07X9Q7VeRnU46Kj/S2G1QnbIoGdEUwqlYAYpzKr/B09H
	+DDVHkNZQy5BGBK10+eMkAXjLLupVY5FTMaBHLEl17+gcHUAKD5JgHi9SSgG2bdStmbUDrIKIp4
	+Otn4nPIfkt4KKbD+y/cR5y5b48cRvBHhKgYnRkVnXglENN5tws/qpIdeD1WzdlsQ9166WP/UGG
	wK/+Cp3wZMufnet+Q1z694k4+Uz98DhuZrso8cK8Ms0b6wko1fwpqomNyJKCaWsXKIANOXbMkyy
	z0nNQuPMN+oCVa+zucvMPx2yxGoLTJz8RfbgrmGNgPWUv6uYrZRiKIHQwY+8cRVbb76qY=
X-Received: by 2002:a05:600c:4511:b0:490:6869:46c3 with SMTP id 5b1f17b1804b1-490686947bemr207588605e9.30.1779900235360;
        Wed, 27 May 2026 09:43:55 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:f829:aa3:9ba8:c8c3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490454c5eb0sm436435435e9.2.2026.05.27.09.43.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2026 09:43:55 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 2/4] add ti,ads1110.yaml
Date: Wed, 27 May 2026 18:43:10 +0200
Message-ID: <20260527164312.355729-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
References: <20260527164312.355729-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
---
 .../bindings/iio/adc/ti,ads1110.yaml          | 52 +++++++++++++++++++
 1 file changed, 52 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml
new file mode 100644
index 000000000000..7dfe07acd3b5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1110.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/ti,ads1110.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: TI ADS1110 single channel I2C analog to digital converter
+
+maintainers:
+  - Jakub Szczudlo <jakubszczudlo40@gmail.com>
+
+description: |
+  The ADS1110 is a precision, low-power, 16-bit analog to digital converter (ADC).
+  It integrates a programmable gain amplifier (PGA), internal voltage reference,
+  oscillator and high-accuracy temperature sensor.
+
+  Datasheet: https://www.ti.com/lit/gpn/ads1110
+
+properties:
+  compatible:
+    const: ti,ads1110
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 0
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
+
+        adc@49 {
+            compatible = "ti,ads1110";
+            reg = <0x48>;
+            vdd-supply = <&vdd_3v3_reg>;
+            ti,gain = <1>;
+            ti,data-rate = <30>;
+        };
+    };
+...
-- 
2.47.3

