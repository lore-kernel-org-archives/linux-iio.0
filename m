Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB111A5BAE
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 12:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781268415; cv=none; b=nXOd0pl73a36ajDecQyHFcHr3fnzdip6S3y50LDPf55iC4pNdVkKppbWOpKFIQ9Daa0u3uLaWQYCb2pwQQIwqgcsZInwlvef4uAMrNf76XEMfVjqGMt0TQqrweYUKjp8GVjGn1dhw2itFIq2ZL4Tq15QIkKr1iTAQU+yIGQKW+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781268415; c=relaxed/simple;
	bh=OeCMVr5zr4slBpySTy0rNlGp/yvw6DNLdo99ezjEHFA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ibliaCC/3Z5wmoM6PjI4HU0gvHMJVPpJutNa5cURxBtN+iwqlkosFCRojMwbSc7SQXBZMWGxn8ztnD+3VqTIUAl7mrqvk8gm2VCv5ENxhqwyo6HWV+zHPT+F81iwGbmCPa+QA7IJlAdv/Fr9F5UxB///rj1fwc5QwK8IBYLD50U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=sirat.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2c0b944f6edso9555115ad.2
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 05:46:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781268414; x=1781873214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/1ga3PlRn9GakSbw7BgrbomeeCmUv0p2MhtufpPdTfQ=;
        b=BkXw+GjMjbFMe0TQUCho+68EBdXslcN808AHnTLkU5FYlG0W6sAVv7pg0vbdUb/0z8
         9oH89CDWsrjg9iD8oxjALOU8TmcykPexbIPXy2AhMzI/Zlf7RqQuTudIoDD+ANTrsGIT
         VXn7C8W6TfP+lA6TeK/c2bZfOE1qOdCimZWxY21PaHU2F5/Vg/hA9B7/uiSg8U0TIW0O
         JV4o3wiWyHMN1vufE/r4OJysCKPYJm1JA2Xj7gcfATGoYit35PkIQr2GBRfqeFsLCD9I
         GfSEsmAy+H4vZm0Mz8LLyrni+fALcNZoNXnnHtePHDLfybOQ3ApI0IUfuxuH1VDEt7LT
         k5KA==
X-Forwarded-Encrypted: i=1; AFNElJ9AOrUbXJPpEtn0JOcK0r7eWbs4ClvM0d0aL8vU0ldHn2Kvv482MzBcqX9KN/mpJMLfuGIw8ageL7c=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFHiN7dmvlSM7BWyJKR0zsnAWZISfDQe5ertrgIwfd+RkpwsT9
	HIH0s8cHXbjH8Ss5jmvj5X7lTUNj3e2tgw6+b9TJ2Fc8PGjL3XMsNU1c
X-Gm-Gg: Acq92OHsmCoW7ex7u0313ekv9HgWgY2F4cRz/PfS8BMMExsBe+T//5aZFe4s1cJ8Dnb
	yWoPDTHdbcks2YKgfxtA/PgP8PthjRSfifL7fGl4eKIV2fWwHabKrWDcFd9cwzL2G1nZDgVHyTY
	9eGvar4TOsVNzjHnZQK98V6LyOj+f1gCQ738e3OV3xyPyJZRVgIapOKUkZHP2BczzzhGrtqH2Lq
	tDrSwK3f2WyTQsya8xXFFs2Lc/3/FBrfXfB54hGegBioOVgMBBvPV0YiAfq313faD/tFD7RChEl
	oguay1ahMapsAqYdKLp+ubuhgvFg7CmanDcSHvm42sdw57IeimPvI2RUAaKhaZA58OS/pnpAkcb
	dn2sGMa0JCGMES9RpCXHE52jvCe8Rl6gAIVVB8gCxLvigDwjOoFPXAlu8IIKeJWbICv/IRse0sb
	hD8VAHaU1rGY2BucbcVosn0Oy+fvcPW3dez4IMc/je8mOXvZCO5CFNLIDlDave9ncXUrCcP1V+x
	FNsf76CgeHgKcjD6jBvCRojfPL5xDcRIxwC6BHySHyLizI3Z/eXMugRKWq9H+dC5+iY1BGmTy6h
	WevGaw==
X-Received: by 2002:a17:902:d2d0:b0:2be:39bd:8dd8 with SMTP id d9443c01a7336-2c412550f4fmr35794475ad.33.1781268413483;
        Fri, 12 Jun 2026 05:46:53 -0700 (PDT)
Received: from fedora ([42.0.4.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c42fbb5411sm21115625ad.32.2026.06.12.05.46.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 05:46:53 -0700 (PDT)
From: Siratul Islam <email@sirat.me>
To: jic23@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Siratul Islam <email@sirat.me>
Subject: [PATCH 2/3] dt-bindings: iio: magnetometer: add QST QMC5883L Sensor
Date: Fri, 12 Jun 2026 18:45:26 +0600
Message-ID: <20260612124557.13750-3-email@sirat.me>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260612124557.13750-1-email@sirat.me>
References: <20260612124557.13750-1-email@sirat.me>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding for the QST QMC5883L 3-Axis Magnetic Sensor
connected via i2c.
Interrupt not implemented in driver but kept in the binding for future
addition.
Used enum so that more driver could use this binding

Signed-off-by: Siratul Islam <email@sirat.me>
---
 .../iio/magnetometer/qstcorp,qmc5883l.yaml    | 48 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 54 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
new file mode 100644
index 000000000000..238cc7e22b89
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/qstcorp,qmc5883l.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: QST QMC5883L 3-Axis Magnetic Sensor
+
+maintainers:
+  - Siratul Islam <email@sirat.me>
+
+properties:
+  compatible:
+    enum:
+      - qstcorp,qmc5883l
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vddio-supply: true
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+  - vddio-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@d {
+            compatible = "qstcorp,qmc5883l";
+            reg = <0x0d>;
+            vdd-supply = <&vdd_3v3_reg>;
+            vddio-supply = <&vdd_3v3_reg>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index e035a3be797c..310074b34072 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21787,6 +21787,12 @@ F:	Documentation/networking/device_drivers/ethernet/freescale/dpaa2/overview.rst
 F:	drivers/bus/fsl-mc/
 F:	include/uapi/linux/fsl_mc.h
 
+QST QMC5883L 3-Axis Magnetic Sensor
+M:	Siratul Islam <email@sirat.me>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/qstcorp,qmc5883l.yaml
+
 QT1010 MEDIA DRIVER
 L:	linux-media@vger.kernel.org
 S:	Orphan
-- 
2.54.0

