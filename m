Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44E53403FA
	for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 20:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780174506; cv=none; b=c9Ap+gbrre3Iri4WrtUWW11+LNvS7oNWf0puLpdhXQ0ryI6it4Ah2Jz4Oql6Lti6TJo7jiTDaOQzITDJMOHx5KeMjoBn8eX0L1uIr1YPbii8AbFfuCOuFzjD6jLEQy5ggUG1jwewOx7PmH++ZYaYHRgjq2ecRntZUrkavOPSnN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780174506; c=relaxed/simple;
	bh=hwGl3EPuphO2HwbxFoFnDldoXbDsAWGoIy1kLT4Cp5g=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=s4cZHxgFTq+362Va9uykTtZUnPOff1nAz3oKSS53lj4KNhuI12bDZvyiZaiVmPhUTi9BdC+5xVPhyZymlCmDZCZY6V4bqxsgC233Mra2q4dII9vD2QHHDXvbDg8xUZWpd1reX7Cq6AkFJHCPlrd7JKfC9T4Fyncv9mH9aapArsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K6MuVJXM; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K6MuVJXM"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-49048e043e5so69427895e9.1
        for <linux-iio@vger.kernel.org>; Sat, 30 May 2026 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780174504; x=1780779304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fP/yeBc6tDGnYnwkYYiLHLYGfPjF9AFGOqGTC6mRuYQ=;
        b=K6MuVJXMtCKJnnL3zr6rtTD7fo0JObyDg1Mq7XSDFppzGCnQ5AYO9cU5YkrVe770MD
         bYgNcty23Y+TMUMEjQFLgndu15pMoh2nL+rmwU4f+t9eWlclbT0r8bTw/KPJkb8r/d6p
         +Ywm7VTN6wfruN74hEd0kYIa3NK61d4G5c1M3CPWLts5f8HbofwpQh/yduNL7zWvI5qH
         E8xw4mlwqEOLGocJyDWp0dek3M5n1KN7zxva86RCLs069IkuS45FCmlCiD76vhd1OGg5
         MPHO3yFSW7yZGxOnPzRshLGLj6nAuNld7jqnnfhGOFjNKjFik0vA4km7+2rCXE5hYiti
         WMEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780174504; x=1780779304;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fP/yeBc6tDGnYnwkYYiLHLYGfPjF9AFGOqGTC6mRuYQ=;
        b=iXiE3N/XAV/U9wk1C1pVkvv2j7UW7y672BKcuEY2V3ZbccvWWUXvwngw0MLmcTNrgH
         QpeGrGve4zynrru+dsIFRkeVDVspomQ8vWPPidpW+IcPqJNaadkhDALXY5eVo4giHofa
         E4tgdYmj89RqZGgVKn0lJcDyhyt0BDgFPGR6TDYGjo3MQ+l9mthUys+TFI1/hDgIc1EF
         fc7s7jmL3RbXLsZN6sFiCcXwTOd8Hc5Tfw1+zomdyzAxAdeA9p/qQ49RNXWfQo5l1NdQ
         W6uDJZcEmSF18nTEXVLobLMeVVea54a4bjJEmN37N4b5Db263g52eedV/sfFkjaz4yJZ
         7Law==
X-Forwarded-Encrypted: i=1; AFNElJ/M1yU9ajbT972ra/k6nnPy1vkKLInMFblHbK2lA/M5dzQL4kcbZJEmKMMhRrPGWAx4VzKX9wFcWzY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYee54aXMmyMWayOoXjAFEXujVQv7p9PzKdkMCujnRp+P492RM
	xluPkT/r+hVhlc3tp4Y1nfMsq8BpNRmUxiBZXkXLxV30vwwfNy2eHYyt
X-Gm-Gg: Acq92OHmJ8w7M03qwoTPsxehxGJfizFt6dXAHCACcHmAFqizsfgxlZtWrIJohw8Gg+s
	VNKzsCmEDcJGJebWmKmMwIimJbbDrQbbMRRmGJGqfdzzAKDBhKpXoLwpX/tQgy05iTAXQOcVa/X
	pKYpE2k2dBS7aMIkT1wk0hZUS+bkwhATKFX9IqWNZCmnQGkc3hS5i2lJVUD5PC1pDDFr/PDvNMx
	OXyPM9B15xabAroNlVNuw+M3styjWTWGicLklI9V1o/+0c6hRe76bqye1/aN74tuzzPvCosHMSl
	JQDRy+bIylC3JbhJ1rKFrolH9ibiR9WmCeqpcU+et91a2q1m0cowEeTlNtU73RMzOxcrbbp10kI
	0PwI/Sf17eFiRed9uSXGqOxM4lLniDcGNtPuC5ujFbN9bvlEv0uw6YbyZwRi8GGLtILItVtkTrg
	BpLKDJf9BwgdCOPEI=
X-Received: by 2002:a05:600c:6287:b0:490:5429:1513 with SMTP id 5b1f17b1804b1-490a2901c14mr93218935e9.6.1780174504103;
        Sat, 30 May 2026 13:55:04 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4909cab0e94sm132288225e9.12.2026.05.30.13.55.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 30 May 2026 13:55:03 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Maxwell Doose <m32285159@gmail.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] dt-bindings: iio: flow: add Sensirion SLF3S liquid flow sensor
Date: Sat, 30 May 2026 22:54:31 +0200
Message-ID: <20260530205435.37326-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260530205435.37326-1-wafgo01@gmail.com>
References: <20260530205435.37326-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the bindings for the Sensirion SLF3S family of digital
liquid-flow sensors on I2C.  The family currently covers the
SLF3S-0600F, SLF3S-1300F and SLF3S-4000B variants.

The driver auto-detects the variant from the product-information
register at probe time; the per-variant compatible strings exist
for documentation and dt_binding_check purposes.

The active calibration medium (water / IPA) is runtime-switchable
via the in_volumeflow_medium sysfs attribute and therefore not a
DT property.

Signed-off-by: Wadim Mueller <wafgo01@gmail.com>
---
 .../bindings/iio/flow/sensirion,slf3s.yaml    | 49 +++++++++++++++++++
 MAINTAINERS                                   |  8 +++
 2 files changed, 57 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
new file mode 100644
index 000000000..dc41120e0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SLF3S liquid flow sensor
+
+maintainers:
+  - Wadim Mueller <wafgo01@gmail.com>
+
+description:
+  Family of digital liquid-flow sensors from Sensirion with I2C
+  interface.  All family members share the same register map; sub-types
+  differ only in the flow scale factor and the calibrated measurement
+  range, both of which are detected at probe time via the
+  product-information register.
+
+properties:
+  compatible:
+    enum:
+      - sensirion,slf3s-0600f
+      - sensirion,slf3s-1300f
+      - sensirion,slf3s-4000b
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
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
+        flow-sensor@8 {
+            compatible = "sensirion,slf3s-0600f";
+            reg = <0x08>;
+            vdd-supply = <&reg_3v3>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 06a8c7457..222a03b6d 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24187,6 +24187,14 @@ S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-iio-chemical-sgp40
 F:	drivers/iio/chemical/sgp40.c
 
+SENSIRION SLF3S LIQUID FLOW SENSOR DRIVER
+M:	Wadim Mueller <wafgo01@gmail.com>
+R:	Maxwell Doose <m32285159@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
+F:	drivers/iio/flow/slf3s.c
+
 SENSIRION SPS30 AIR POLLUTION SENSOR DRIVER
 M:	Tomasz Duszynski <tduszyns@gmail.com>
 S:	Maintained
-- 
2.52.0

