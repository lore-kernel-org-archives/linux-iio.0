Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A3231842
	for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 04:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781930416; cv=none; b=Q68lO3Ji6uhk4WpD941INIO2SlIK9xReFC/D54cJew90g8rBYGfQIx5IIQOHJmTmU59/dhQI2p7UbYCJ+yq2Kgr+3dpfpJlmIaTMDH48NB7MTYakDCj3Ll+kGX03whYRAyU2ym7MRmZinpSbGuVwdRy1AlINRHIsnKlP0SaA8L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781930416; c=relaxed/simple;
	bh=s4uGUDCNIZcuL67jmQB+Q6rJHyfc0sUokTYu0rPht9w=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L/349FhAtAhLKvC1kYrCHeofpnXQ6DdEA5AEMvfczgcVoaO0cVco9tdv3+zVtk/mGFsdJAraADqMF3eCUOoOtCjjobheyab/ZBXuPsLad2GOej+O2lv09CXIAImMOaIHMaIMgrJFtz6dKJ3t0UEFTQPn4VyhNVXPPlVfp23agnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mVCe7jNk; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mVCe7jNk"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7e6e21c47e6so1641783a34.1
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 21:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781930414; x=1782535214; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZK6YFlyAvt6yked5wvEFfbmqGCX0V5PCrDLneg6SZt0=;
        b=mVCe7jNkbF0jAtTp+xZdhTKjtZYEHhLTwmeIWXKqu4/otQwfE4ffcRJBnVKEiARhvg
         LpWFdX8Io3HheXEixMEkuJ8CehmZyp8cUPcRhoRDbhXrxE4JCSmVcVMSW3/vs8o3q1mg
         t2W5yTwfqW8meuUpQpVL703NxL3OBuRAJVL4z9BH3AGlmen77R3147jxllfWp+A69Lhn
         teJY1qmEJvrGQlMH24jIYWgKWHfNdhvUP1iySR///dt80mpBhY3bEsVza3PSagWOcU9d
         IYKQKGrqpjTmREvgprH6k2CwtLT4PaOxuMq6Tb7fD81EJw2ANl25xm7y1pjSIl8SpSJ5
         3DEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781930414; x=1782535214;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ZK6YFlyAvt6yked5wvEFfbmqGCX0V5PCrDLneg6SZt0=;
        b=McEyeZDcd+NL7rztc+Bwy0xJtCtB53YuP+Y25Pfgk9m2k/W3yFnECcSXb/qoiHNnEs
         OOeXTwDQ1T1v1P9hyb0ZWjaL3h7WS+uCMIDSOWOK6exLtAu1566O9vdUvu3Fd+2fsmtX
         QdPADeMKHv+g0yA+HVb6oATgeZj5MMWEiWTJOtd/UdE9qhF8ID6XJkyLrOP+3IcGU5Um
         0TFoO1kfH4sA9ZcuCQHZgeoaTdyxxlya3cdJpULGk5v6PQumttoSwePrcn7OsF3RHhIX
         vM74qhZd0rQ8sumFfnAczQVdp+abRXtI6uH7gyfHuo2hsjK3MtPg3uOGK/v2C5BJwoh4
         nVUQ==
X-Forwarded-Encrypted: i=1; AFNElJ+wjTyucszbKr+fzHD/NZC2A2Eu3PhV0JqFs5Spsd8FQiZYfZWtAEjZJy/VFweW49hNKiE5OxqxCzs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyrk2NFfqXa9aizjjNNNmLmr/bTuv9H/a9qrvCkWKx3vZNpilGl
	Y/JN785To3VDb1/OAu9bC9qIAEOVQ86gkIDESUB5TNQt2wI5p1kLTY1GhBBEDPKq
X-Gm-Gg: AfdE7ckAuJvbOaE9LaGrK6IR9kSWBeYDp1K/D06LdCNB7daeCtztsTqcu4O+4icAUN0
	Q55M/wcZlBJSzse4b2BnYOOu34rs7xWbmjhRxava7Gj2QiOJVRBS7QLdkQX5Z4mm8r2JFReKvFn
	cQBR2O2ikANeCRIWAlOEXPDQ885v1IKT3eGa87IBajdkyshZQnm3ySVHc9FPquWEfpFAmfE9pvx
	yLyT4Aq1dLU6eYMDHvckPoY9L9aWiqGbw8feMwf8SSLtQ/1zlqoEAEnghNsa6hVfjf5w6Tj1MaJ
	6sA/sKDXwZpTPvCWAqg3+0I5NjfeBptXFsh+8U5vZ/EwHebOrV+i8GJblghym32KdahBS1H3MQU
	MoEWDogHIkb9uCf9+dpIHHUYU7s4/iHascqy7ZoTnXtbC0BKHFxf/OglNAmkWDMXFV8P5u0w7D3
	NiN93BVSO0Y8NK6ybyPa1YXU2lNGEotSbaH0wu0xsHCkW/OOc=
X-Received: by 2002:a05:6808:c2c3:b0:489:5dc8:1d61 with SMTP id 5614622812f47-4896aa57359mr5850543b6e.13.1781930413798;
        Fri, 19 Jun 2026 21:40:13 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-48aec0ddd7bsm679754b6e.7.2026.06.19.21.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 21:40:13 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [RFC PATCH 1/3] dt-bindings: iio: temperature: Add STS30 devicetree bindings
Date: Fri, 19 Jun 2026 23:40:05 -0500
Message-ID: <20260620044010.1082621-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260620044010.1082621-1-m32285159@gmail.com>
References: <20260620044010.1082621-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the devicetree bindings for the STS30 family of temperature sensors.
The STS30 family of sensors includes the STS30, STS31, and STS35.

All devices in the STS30 family share the same commands, timings, etc.
The only difference between them is their measurement accuracy and
tolerance.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
 .../iio/temperature/sensirion,sts30.yaml      | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml b/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
new file mode 100644
index 000000000000..dc0c6b7832fb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/sensirion,sts30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STS30, STS31, and STS35 temperature iio sensors
+
+maintainers:
+  - Maxwell Doose <m32285159@gmail.com>
+
+description: |
+  Family of digital temperature sensors from Sensirion with I2C interface.
+  All devices are compatible with each other, their only differences are
+  their levels of accuracy.
+
+  Datasheet available at:
+  https://sensirion.com/media/documents/1DA31AFD/65D613A8/Datasheet_STS3x_DIS.pdf
+
+properties:
+  compatible:
+    enum:
+      - sensirion,sts30
+      - sensirion,sts31
+      - sensirion,sts35
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
+        temperature@4a {
+          compatible = "sensirion,sts30";
+          reg = <0x4a>;
+          vdd-supply = <&reg_3v3>;
+        };
+      };
-- 
2.54.0

