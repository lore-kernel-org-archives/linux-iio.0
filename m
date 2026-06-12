Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C61D42AA6
	for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 13:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781271101; cv=none; b=j/ggAH/mmfCsHuSnkeAzrXCZLQcJ0NviSFq98s8DR53iG4Q8R0Gwqx4iRH8/vtUGtfSlgDta1qqiZOE/faCp1hp3Wny8g2QoFZsyE4OxauBJslmtYWk+8e6RL3892Zv4n+DmOIrEdS+NbSNUB1fTZ7xQM/SjLMunc1EXH3gYlRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781271101; c=relaxed/simple;
	bh=+SPZA9sfUfuu0eiFNYg8AjwuymPaA/dbLjyU0BPYtyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ealBzMY7F2mNfWkOtn6Y98TyB8Q/+K5tS6QI1Ac6S4fckJpqdENvKWkZ8FizJFsih8Mje+rBY6zCxTMgdlnz8Mz6qFyCYZl0CIFItCQXiJ28uJ/xkpHPfpOqiumGrJb775nU96oh7S0fUhqDKuBkvQWZJ1v4VJEPQgPbQcH3vAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bis-linux.com; spf=pass smtp.mailfrom=bis-linux.com; dkim=pass (2048-bit key) header.d=bis-linux.com header.i=@bis-linux.com header.b=KCOF93Do; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bis-linux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bis-linux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bis-linux.com header.i=@bis-linux.com header.b="KCOF93Do"
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bdb3fd39045so147630366b.3
        for <linux-iio@vger.kernel.org>; Fri, 12 Jun 2026 06:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bis-linux.com; s=g; t=1781271098; x=1781875898; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMxqu4QSPzzn6rVUbJqA6sbZp2S99rvDlMor7IWHDhY=;
        b=KCOF93DoF8aP5/qIbyAGVT3PFS0Zm1W2MaWqZYTNuqYUkLn8KDx17/g3g7TwgKkufy
         F3HnISMOf4kLQIUGcChBFsVB7D1LJstdCXn346ZSvJOaaX6bfjkectJ0rwLHWMTHykCI
         JWX0gdzxGz+n6z4EVihLB8xnusqS/iXn1wO5KqA1jA2T7tYtrO1788+vr4t8QKIjnmIO
         iRa5szqZQcz2KxehGHwf7uJL1CeqYQ3Tle7ixMTjjIiZOfrj5+nJZ46I0O7ez2LygUpW
         IX36qC8b6Q8AzngRDidBEly29tFXhp1uMboP5DNlrML1sU4fSfKCi2kXMYdcuscU8sqo
         Pw9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781271098; x=1781875898;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wMxqu4QSPzzn6rVUbJqA6sbZp2S99rvDlMor7IWHDhY=;
        b=fnWonOmHRgZkDBtujAB6ZeUcKyXOp78hSiqonM341dqv/attQms86QxZ2uZiE3WawY
         i2Pr66c13lBGS/NNaMpJJvhKKKub9Jds07HfIInNjJUH+E2/N3/l6LEVA1rOFv5m45Qp
         r8aLmnkM+YA8FO0lf0wthLgHNeWBOKq3SNb+PV+DD7RbJozLKWZgGyTyybrkQF248Oug
         K+HUcAcAPgecp9Eq44SRrX2WkigQx5a+/Oa0wg4qTuhNARop013ibL7hVSig7ctQqHbA
         2eP+R942wmSafDDAf9nZPMaH2Ctrsqa7FwmhV4ODbyeLJLzrLLVBxEi/nCBmtJN1umwC
         11zA==
X-Gm-Message-State: AOJu0YyrS70JhZ4Tt5+UAxYOjllz3AniKgSNQxApEsQ6TJ13E/RwU4As
	X4YZDwLygbUhX9JgThmJ5eeEpPB8b+UcyWtl2iK4QyD2XqxzX39U3PYJOjl66O3CJJZQMFeLZwu
	XdfI=
X-Gm-Gg: Acq92OF+BbjKL+F4DzjlTIEXcbd2oYqP6wK6Y4G20n9E4yFzSdNRSBuFRZymJ1FaGe+
	keKifrJNXLheqnfXLLK743tVum2KawtMOLgDccUtEa14jQXMaTGnVLpGpm1FbSQ0C6hkV2dYtwP
	foSjqFH9t2qg4Pk4BY/aJFcIm5/ZTZhRqklZm6lbKW5nymQHnSPCM7K60IlK0NC35eEnbZOs4zU
	J92qjrgrEv4GanP7aSkkHRTqhsSssjISuRCHpwdJ1fBaNgEMhOibTw8Yo+Zav+9ge0/8Cqz1h3T
	GsfLKbbA8N/57/oFzOq0AvC2oavYZFzrnhMY+v0ZzossDbx7oyE8u9qfjzgzYaVSBX6sXgtJRZe
	pRqyM2ffskFhP5vdiWPb8FlldqkcJvUhQCWhqVYzu3F6eONuC2vKPdNO/IUSGr1sBr/2T4/Q9Zh
	AtrxL1UFpmHNEpstMlO65OvS9K373ak8P163gMDA==
X-Received: by 2002:a17:907:961f:b0:bec:e6ae:2f6a with SMTP id a640c23a62f3a-bfe2a80fc30mr124788166b.36.1781271097740;
        Fri, 12 Jun 2026 06:31:37 -0700 (PDT)
Received: from mbtp.lan (nat.piap.pl. [195.187.100.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb8e1db3esm105645966b.56.2026.06.12.06.31.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:31:37 -0700 (PDT)
From: Marcin Bis <marcin@bis-linux.com>
To: linux-iio@vger.kernel.org
Cc: Marcin Bis <marcin@bis-linux.com>
Subject: [PATCH 2/2] dt-bindings: iio: dac: adi,ad5337: add dt-bindings
Date: Fri, 12 Jun 2026 15:31:22 +0200
Message-ID: <20260612133125.196208-2-marcin@bis-linux.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260612133125.196208-1-marcin@bis-linux.com>
References: <20260612133125.196208-1-marcin@bis-linux.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add dt-bindings for the AD5337 dual 8-bit I2C voltage-output DAC driver.

Signed-off-by: Marcin Bis <marcin@bis-linux.com>
---
 .../bindings/iio/dac/adi,ad5337.yaml          | 48 +++++++++++++++++++
 MAINTAINERS                                   |  1 +
 2 files changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
new file mode 100644
index 000000000000..327a45ccfe4a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dac/adi,ad5337.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5337 I2C DAC
+
+maintainers:
+  - Marcin Bis <marcin@bis-linux.com>
+
+description:
+  Binding for the AD5337 dual 8-bit I2C voltage-output DAC.
+  This part uses the pointer-byte protocol and is not compatible with
+  the AD5337R nanoDAC+ driver (adi,ad5337r).
+
+properties:
+  compatible:
+    const: adi,ad5337
+
+  reg:
+    maxItems: 1
+    description:
+      7-bit I2C address. 0x0c when A0 is low, 0x0d when A0 is high.
+
+  vcc-supply:
+    description: DAC reference voltage supply.
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      dac@0c {
+        compatible = "adi,ad5337";
+        reg = <0x0c>;
+        vcc-supply = <&dac_3v3>;
+      };
+    };
+
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 614589b6efa4..f967c18fe730 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -441,6 +441,7 @@ F:	drivers/regulator/ad5398.c
 AD5337  ANALOG DEVICES INC AD5337 DAC DRIVER
 M:	Marcin Bis <marcin@bis-linux.com>
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/dac/adi,ad5337.yaml
 F:	drivers/iio/dac/ad5337.c
 
 AD5446	ANALOG DEVICES INC AD5446 DAC DRIVER
-- 
2.43.0

