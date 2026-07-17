Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6665381E97
	for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 20:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784319105; cv=none; b=KYv2v9iwXUyCLnl28AABoT8O8HOqHns4YmjRwJ5lCafsC6dO80rEbRHe+iOzleaS6+NBchxcdp/XlKOKO8KsYww3MK+8D0Lr2bZ+UCTCqqaz4CugkYGqux/VLyT55KkWJyFSJHx4Adu9P6mJG9sLJjE7zuqeoqBelXLSVh2VDRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784319105; c=relaxed/simple;
	bh=BCVGMZJMqKv9mEWFv1asCj8XmBIDC6Y8WkqH06d1nCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SFE1vPMk0F2XZOiPRnvk3/sxsQHlAWjpwlkXulQIVf+ic3+i4rpZCu3HZZ1glF6F9SqABm3ynAs1SJE522kpl/GMzGXkAbKtASidrlgfgKnlbEigTnpNjttpridTDSO1zBvj6dt1foivgY2+a3rws81BSLX320itJepS6fFHT1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MuJ3T1B3; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MuJ3T1B3"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-39c7ed5410bso44776331fa.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Jul 2026 13:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784319102; x=1784923902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QE9NqWnp+0llPNlHSCBGG32bbwPzbNgAMLIqj11/XOg=;
        b=MuJ3T1B3HaHfJ45wbixMpH3i+nhcSI7a5ebyshfJEbrbIRU3eDQLmAdDqEWewo1tAE
         dFr9ftLLJ1Dy05kIqICcDILzFcsLTux77bN8IpuS7CWQEbyQVvjxlBGzxeDUpMdYO5QT
         6RQiklm2/8mznmypPP3idA6vXsevZvhFPg68vJGyoidG3ZCbQbbCl7t//NDQY0+b5AbC
         9hlauVzHjyAU6SFGOnCbhB5isilgHrglHxj+HTzlS671r6Fr6ZXPui9nMZsDSrrS3tvF
         BYxRktPGfmUsBvAeCNkj1l26OtUIn6tSaescKvkJnQ6k/OCkscmdBT2yDn7PR0UoiOzP
         drEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784319102; x=1784923902;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=QE9NqWnp+0llPNlHSCBGG32bbwPzbNgAMLIqj11/XOg=;
        b=kGGbMkx24CE7YHgNsixUnBooBp5LuYgiJs9Fr24D2fzpbfLrtmKGNa7XRgniq9SKdQ
         oFoXFBxpnGvO3OPXsukyPjHnvjRJnhuaATa4T8/pitzaLkjKOPc0nLbBhh3oNLs9ML9f
         N5TugILv8P75cM2LGMZf0u+idcch1ek7IH5t2RFURH2caa1pS710zsh27zgF8Hacxb3C
         3DK4D6gBXJLAf1R1skkyacZdgJWGiSK1zB0Hr7004ueo/2Zbzibhva3+Y8WnnrELeZki
         9qT74FWQ/jkDqm1l2guKOoD7IU5WMQw46tGm5dDPmA8vl7tV8+NtoaiiOChP2wHn3cSL
         YLeA==
X-Gm-Message-State: AOJu0YwRnatT4Rc01ywC3M/u5gMLBmz/X99YL+fxZ5QsjhqQDcYYvcwP
	rfsdxecfbTgI6lWrW1DX9KCAyaSg1k4Tx7qJNCrtPcHHFg/2q15y9Q1alLd8Q3gtfA7pfA==
X-Gm-Gg: AfdE7ck+thITkMbSWmoXCbH4YPaIqeeDuJi399IJHMpcw2pe/LdKb43yOe6N3XR3afK
	4JMPSqmqsQaS80zuqv6TWBpkFLrnQcAvYBPYeTJ+zZPM48X5yEigVK+7ZD7O4WIuBDal6cKgqNp
	K8vMtIk6snZWbuj5kwfz4Qg+d2DRqsCzA33wNf+SStYio7yblZcHOcFIfirlGvx6dS6SlTOajU8
	g0/NXq6mB7wIQKeUlxidYuxKoChpNjTxZnnj5R20Y8WPnWxTdnFpzrKzR5tariqy3jTMY+M2FXm
	6AG6764i6hsskvxM1Wwhhx1HJjugr3wQ+n2vZpjcJNNgBWINhAHj2m4iQD1Yt6eGXQ9BRImBjIx
	wpOXdvEIyQmoCOJ4K0JfMC1Rea+7ATi05zBG6yQu8AIVXGNFLZe2q3aJ4UwHDdaPlDwnCIjSe4G
	J7HpWmnL7glu0ud2lEMs7ZsInSf/UrgUc=
X-Received: by 2002:ac2:484a:0:b0:5b0:1380:ca35 with SMTP id 2adb3069b0e04-5b28f9ac996mr678330e87.41.1784319101662;
        Fri, 17 Jul 2026 13:11:41 -0700 (PDT)
Received: from Shofiq.home (87-92-108-63.bb.dnainternet.fi. [87.92.108.63])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b291da7bafsm571257e87.33.2026.07.17.13.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 13:11:40 -0700 (PDT)
From: Md Shofiqul Islam <shofiqtest@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Md Shofiqul Islam <shofiqtest@gmail.com>,
	jic23@kernel.org,
	devicetree@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andriy.shevchenko@intel.com,
	u.kleine-koenig@baylibre.com,
	joshua.crofts1@gmail.com,
	nuno.sa@analog.com,
	Michael.Hennerich@analog.com,
	dlechner@baylibre.com,
	linux@analog.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH v10 1/2] dt-bindings: iio: health: add adi,max86150
Date: Fri, 17 Jul 2026 23:11:36 +0300
Message-ID: <20260717201138.1078019-2-shofiqtest@gmail.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20260717201138.1078019-1-shofiqtest@gmail.com>
References: <20260717201138.1078019-1-shofiqtest@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the Device Tree binding schema for the Analog Devices MAX86150
integrated biosensor, which combines two photoplethysmography (PPG)
channels (Red LED and IR LED) and one electrocardiogram (ECG) channel
in a single I2C device. Samples are buffered in a 32-entry hardware
FIFO with a configurable almost-full interrupt.

The device requires four independent supply rails per the datasheet
power tree: digital core (vdd), analog core (avdd), ECG reference
(vref), and LED anode (leds).

Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Md Shofiqul Islam <shofiqtest@gmail.com>
---
 .../bindings/iio/health/adi,max86150.yaml     | 78 +++++++++++++++++++
 MAINTAINERS                                   |  6 ++
 2 files changed, 84 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/health/adi,max86150.yaml

diff --git a/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
new file mode 100644
index 0000000000000..da2ff9b0ada2b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
@@ -0,0 +1,78 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/health/adi,max86150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices MAX86150 ECG and PPG Biosensor
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
+    const: adi,max86150
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: |
+      Active-low interrupt line.  Asserted when the FIFO almost-full
+      threshold is reached or when a new PPG sample is ready.
+
+  vdd-supply:
+    description: Digital core power supply (1.8 V).
+
+  avdd-supply:
+    description: Analog core power supply (1.8 V).
+
+  vref-supply:
+    description: ECG reference voltage supply.
+
+  leds-supply:
+    description: LED anode supply, typically 3.3 V.
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - avdd-supply
+  - vref-supply
+  - leds-supply
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
+        heart-rate@5e {
+            compatible = "adi,max86150";
+            reg = <0x5e>;
+            interrupt-parent = <&gpio1>;
+            interrupts = <5 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&vdd_1v8>;
+            avdd-supply = <&vdd_1v8>;
+            vref-supply = <&vdd_1v8>;
+            leds-supply = <&vdd_3v3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 3115538ce8291..189385966de82 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15705,6 +15705,12 @@ S:	Orphan
 F:	Documentation/hwmon/max6650.rst
 F:	drivers/hwmon/max6650.c
 
+MAX86150 ECG AND PPG BIOSENSOR DRIVER
+M:	Md Shofiqul Islam <shofiqtest@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/health/adi,max86150.yaml
+
 MAX9286 QUAD GMSL DESERIALIZER DRIVER
 M:	Jacopo Mondi <jacopo+renesas@jmondi.org>
 M:	Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
-- 
2.51.1

