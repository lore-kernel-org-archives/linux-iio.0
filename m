Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC0274B55
	for <linux-iio@vger.kernel.org>; Sun,  1 Feb 2026 17:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769965688; cv=none; b=Feapg/hsbqP0sfKlY6tQI2TCHjLMjyI3m60+Yh9R756Pb8z3y1XgFRZbgILyW4dmw+nBvgNEThUVkOwxmHpHLSnAa4nOPS+RlAblejmD6okUNm8vyE2A4AJNulmoLuiH3HmTXo3T6aL5NnRxiVl0bdFKxd5vhsLicfV26GpW1o8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769965688; c=relaxed/simple;
	bh=oZVM0jsRUZFOAD5WZ3E63gXjNmhECNXFhQvLake1fM8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qimfApSAgZET3j2Y+S8gulKkDimTzUIV0dUpi0Y6ty/2ZxDe4eKlFmoCT9j0soRcOs8Qz6tSMnhwTp11JHNyfJcnTYstKTMpgUi3IFmmTzaAZWVWj/lHVku+JO+fs2Wqge1ay0/Oywt01sTLOciIOB9NkMsi8b1tVS+/pJVn970=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W62HedvX; arc=none smtp.client-ip=209.85.221.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W62HedvX"
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-42fb6ce71c7so3053458f8f.1
        for <linux-iio@vger.kernel.org>; Sun, 01 Feb 2026 09:08:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769965685; x=1770570485; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aiP44f+/iNWWPqnIpAiWlM8Sc6MEYUGh+76c97VATbg=;
        b=W62HedvXZHq5oo2iN1BxGFnFHcGm9JNQJVgneXQhHTy6XE/G5HFHXZo4mhi0brhSo9
         N2WS0xx3e8+S3injvEHcDYHMMmZ4hpO7nr3KseH7BTUFgIZ6ON0/YSRzffX+EHDu+39H
         vVNAStUFGPiVRmfNcDFK7sOyYnN9DT/aPPUzNN94YyOpGFQkrSEk6kkPyexqQnmV0zPP
         SV/eMPUHJMvDFomQqkWcwDEE1zIKg+Qm7kmebjLJmq7RAnIWkQ9ilH313pKim6GtVe+x
         tvXcnkW8UxhZdaY3AGdg7UIGkzaVg+GwcmjyT9Poe05XoQITb/6MCQsO5SrI2fZKbt3f
         1+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769965685; x=1770570485;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=aiP44f+/iNWWPqnIpAiWlM8Sc6MEYUGh+76c97VATbg=;
        b=DWbLCZZCEcCOhfH57SNPwRfkgZ93O158o86tHBGSod5iIunKqfrfvJg/vhZ5JyW0vb
         hf7b0c9MXPTcG75MXbcQThXg9XbsdF3+08DwUzHUOYMSPkQ/n9mlmhC2kpfAhOcDSRUJ
         kGqeTS0/dJWjTQNSaDfbALVotVeStymlXkWQnUfJBX3Kr4M7C29vphyFGQHy2J/ikTLD
         nGl3AxHHMs2t6p+hocSNRBYDxkImh3yoSCureaAc5lmxK7UUVOxVqGg5Fqq+9Z+VGqE1
         7wUG/gS8USgQ6TS7WfwSqvvxwWrkPcd07zpWEy5JadvWl4lk/CMRpc6bwzude29mUmGW
         qXQg==
X-Gm-Message-State: AOJu0YzoNNygt6OQh0r8ZqNlCwpfWMf+TZuLkcpmTrtqck92vqP1iQaH
	CZfHQs1IHrSCyA5gTaF/Jt+Q5gRrjPxOQDnIW3zknACClaW/gI5ztD2M
X-Gm-Gg: AZuq6aLhraa60G/MQBscydm7e48y3GSwCArFdoxEPt0gsVlwCxRTZwKlDaV7Dyc/I6U
	9S/tHyb/dp3E3GeStoKWJ+iDyu1DixjxXsFbSvBU9UPkOgBCSKpwG+VMFbjqplCdBT254qa5UIW
	Ng/p6Y/NWJ9yVedKNLxwXZiPjrhnuAxeb3MzeDGP0I5cUSlhCWY/dJTR3/AOKYlcvf3WeTxSR8t
	a7crO/p8lJS9rdcsVPuPprMHCXOcjyUlK3ZsDHtadQTXlIG2uIv6T1f6sz59DTipKGG+WUCxWGP
	F7BdaMIhHQ0m3fesbAv62FmFSwM7f61irSxT/o06CXAUCUPJWH08rPTrI95wCrTdXsEx0Hye8t6
	2UVozpJYZxHvDnnt0rHBFUK23dzVqWuvEU7/noCnMh5w9fdkv3mGscv6kGQKsmvu1xU0A089UNG
	rzMA/aYtY5oFGuYg==
X-Received: by 2002:adf:fa02:0:b0:436:348:9a7f with SMTP id ffacd0b85a97d-43603489b39mr2583532f8f.28.1769965685455;
        Sun, 01 Feb 2026 09:08:05 -0800 (PST)
Received: from [192.168.8.10] ([2a00:f502:260:44d4:a26c:adcb:8da8:2])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-435e10f82aesm40615460f8f.19.2026.02.01.09.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 09:08:05 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Sun, 01 Feb 2026 19:03:48 +0200
Subject: [PATCH 1/2] dt-bindings: Add binding document for cm36686
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260201-cm36686-v1-1-4949a2a9ba63@gmail.com>
References: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
In-Reply-To: <20260201-cm36686-v1-0-4949a2a9ba63@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Document the Capella cm36686 ambient light and proximity sensor devicetree
bindings.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 .../bindings/iio/light/capella,cm36686.yaml        | 74 ++++++++++++++++++++++
 1 file changed, 74 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
new file mode 100644
index 000000000000..5f0a585e3d87
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm36686.yaml
@@ -0,0 +1,74 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/capella,cm36686.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Capella cm36686 I2C Ambient Light and Proximity sensor
+
+maintainers:
+  - Erikas Bitovtas <xerikasxx@gmail.com>
+
+properties:
+  compatible:
+    enum:
+      - capella,cm36686
+      - capella,cm36672p
+
+  reg:
+    maxItems: 1
+    description:
+      I2C slave address of the device. Must be 0x60 for both cm36686
+      and cm36672p sensors.
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply:
+    description:
+      Regulator that provides power to the sensor.
+
+  vddio-supply:
+    description:
+      Regulator used to power IO and I2C bus.
+
+  vled-supply:
+    description:
+      Regulator used to power proximity LED
+
+  proximity-near-level: true
+
+  capella,proximity-led-current:
+    description:
+      Current for proximity IR LED (in uA)
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [50, 75, 100, 120, 140, 160, 180, 200]
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      light-sensor@60 {
+        compatible = "capella,cm36686";
+        reg = <0x60>;
+
+        vdd-supply = <&pm8916_l8>;
+        vddio-supply = <&pm8916_l6>;
+        vled-supply = <&reg_prox_vled>;
+
+        interrupts-extended = <&tlmm 113 IRQ_TYPE_EDGE_FALLING>;
+
+        proximity-near-level = <30>;
+        capella,proximity-led-current = <100>;
+      };
+    };

-- 
2.52.0

