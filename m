Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AD173FE369
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 13:23:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777468990; cv=none; b=Fyt9OAkzCQWSb7crKMpLtmAbE1mdVSS/26oFv78Q7DSnoDoObIblfADGcsc0aX7VhD35bQwRFeXl21oS50FmJ1kXnONcobR49hq7m24XWX61n88kpNWrJqL+b9R4U7+6Ay6hDylF7del04tgWieGW6vCSX3gjKgDNBqLljgMzZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777468990; c=relaxed/simple;
	bh=XI6T6E8eQ16tquB9SZpNeOdIKNi56M+uqkEzHvHoV1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=glqFZtS9ADOTlaXhS06XZvjjSqwl3JaZEGMW1U/B/rszfriSRTanJNca5trM6tTt7T0+G2LheO7mmZDO/wyiWC/wJK+miBjHBxKGNzXoXJs3PpY7NSFcI/67jgyLJZoq7GfwdyDDdukMBWvcTkHpHljogv3PspM79eF27WlhTpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BVfmOJ9+; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVfmOJ9+"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso4993841b3a.0
        for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777468989; x=1778073789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=60u99mHhTFmXU2vBmbXZTzoik2emfTfjOC7hf/f4LX0=;
        b=BVfmOJ9+YlHkKbVu54sKEb30VDVeFfA5aPiAIhdlajZ4Kn6Ai77RBaYpIHqyOofusP
         6y0FJvlXBqyZK2h0Q6dIG9pBLriHUgEa0/Io8XmF4pPUJlYJYrwxwblyItbEzs6MQ3Tj
         oHHHaRDEUUOihl76sfQJx5V32mAXCChfrBbQd7t41KH5kcijZe8fqg/krAHiMrLxD/p7
         OVw5n5mVtnndQxh7uPXkFO8fNDBfeHxttUD2sCQju7Hr92NEGpFTevo0gcn6l/GyWZ8W
         qQvhbLU/cK5GX5+wDLO+y/sWrK5QGto42oSUTbEs3TDXrr6ot5xLmAMCL/p7mjNEV3yI
         DnOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777468989; x=1778073789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=60u99mHhTFmXU2vBmbXZTzoik2emfTfjOC7hf/f4LX0=;
        b=j44WY7guJ/4t6LnErBjUydjeN71vYnLrzToDZ4A0liAOxhO9r/zGQEoFFGwZwy3Iaa
         l7vNEjUqr3heKrJzm3qFD7d/Dm7W0JG/snoKWZ/3FfD+uW6rilAD0qwAX+QkiCXSGukk
         ugf/uYxfF95EplWrnDSoYbXTcobUN0km3aXhFX4xOUpKuKN327dUJdSbihX2BxYGiNuY
         MWZWBjyTWv3ZhTeXabGxkm4x5WieXfos+0m2MqiFE3POVkDM3XAOe3Rg/YkdutuWVShg
         smwjrgVU6WuerA6JviARteiZKNS8xi67gTJFF8y6n9YfQ29TG25DCMRx3tqK2Yjr/szC
         K/GQ==
X-Forwarded-Encrypted: i=1; AFNElJ/k+tHOUiuB5306gN/K97ualO9FMmr6ee04qHvmj+TnXcWsWbVgUuEhTbz1wtI53EbHSxsfOW63cv4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwV6838OR5N39ZM1fjmJ62SsbpghJyxt4AiPNKtlzCV9EFdAeKj
	NmkOamv9AsKsY/LtYHrYHY8As2Q4OvhcJbFHzPpIW3pKUo9HsD6itE0bYJCGqv1f
X-Gm-Gg: AeBDievo3sA48t02NwHJVxX60n46BKdQQzKGHGxi1ykvvk9vTuOBq54nT8LYayX/HaZ
	m9FjArHbE4Op3ueSvWWJ6rqi6zkAg4W02mBDuFqpbrvuF0pil/03lsz0BC7PJUUfsYX+IH7s/5E
	3OVAqjxUwMYOPJogbIs/+Gv2QASt5Xmp3xhZeIb13NyWTCR/RP1E1++H6Yrm5kygxgjWVytWpZD
	dzA0ALTn6yVIAAhln/wfSTdHjF77f68CkM+J//9uUV+rSylWe2FaT0rgKD85kiUDYf9xSAGygjF
	ptoXSYzHRCh59fVKY1YXKd3XdqmBJn+9ulearbGLlEAcnEuu1qlgg/mPGtFyPCXiSV21mBjx5bi
	EgwSEjAo5q49ghunxbD4TQ5oqcKq46Wv1oPZ6U8vMHOqMTYAUoK2qgmHOt27XPRAzQQKTOZoWz8
	ioT0ArnRi9l1oj5pIwe9iIeYRoeq/v0ci7VluApi/MlWcm6mfEZMd1NmU8fFIFYdpMWm7ChItML
	gX2D3WWV7V+UjY=
X-Received: by 2002:a05:6a00:1911:b0:82a:6b97:34ae with SMTP id d2e1a72fcca58-834ddbefef5mr7957990b3a.32.1777468988794;
        Wed, 29 Apr 2026 06:23:08 -0700 (PDT)
Received: from localhost.localdomain ([2001:448a:2002:4381:3859:fd0d:505e:362c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834ed5cd407sm2091372b3a.13.2026.04.29.06.23.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Apr 2026 06:23:08 -0700 (PDT)
From: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	devicetree@vger.kernel.org
Cc: branstj@gmail.com,
	lars@metafoo.de,
	ojeda@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	igor.korotin.linux@gmail.com,
	linux-kernel@vger.kernel.org,
	Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
Subject: [RFC PATCH v2 3/4] dt-bindings: iio: position: add ams,as5600
Date: Wed, 29 Apr 2026 20:22:29 +0700
Message-ID: <20260429132234.30514-4-muchamadcoirulanwar@gmail.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
References: <20260429132234.30514-1-muchamadcoirulanwar@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
---
 .../bindings/iio/position/ams,as5600.yaml     | 40 +++++++++++++++++++
 1 file changed, 40 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/position/ams,as5600.yaml

diff --git a/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml b/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
new file mode 100644
index 000000000000..d29543d85d1a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/position/ams,as5600.yaml
@@ -0,0 +1,40 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/position/ams,as5600.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ams AS5600 Magnetic Rotary Position Sensor
+
+maintainers:
+  - Muchamad Coirul Anwar <muchamadcoirulanwar@gmail.com>
+
+description: |
+  The ams AS5600 is a 12-bit programmable contactless
+  magnetic rotary position sensor communicating over I2C.
+  The device address is fixed at 0x36.
+
+properties:
+  compatible:
+    const: ams,as5600
+
+  reg:
+    const: 0x36
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
+        position-sensor@36 {
+            compatible = "ams,as5600";
+            reg = <0x36>;
+        };
+    };
-- 
2.50.0

