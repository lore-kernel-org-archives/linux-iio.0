Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794870012;
	b=ioP0rMcbDtxPy3gopHVsdN1LEDhsZAmvbb6WsMC7REseRpja986wJbgrbcH/8Xfu/Nrx
	 30YcVH+JaUw1AHVzrnnCln4KfanjNvkAQ10XWjCoiLLYz2rh8NhwckoJsh9JXlJEAjOtG
	 6wAe/jGh00ylWdSoS3qO7aFfa8ComD22yY1JIzthfyFwujHqt10KJ/lWN9I+pRNMR7hEb
	 yEjNvcb9PYfQGFAowDXwCE8SUABKbklJBU6EcrfbWrh8aCpLxxIwAhOH0fUGoeZ5EzFy1
	 Vund15YGRznfMMv3swHMWo8d8vdMz0m/aFKbQCx81vVrO3HWgsYipjkicT9w59ctHgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794870012;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=PH0YrpSlGVv9qt33Z4Z9rb018oWWfWEr7PktdA631oM=;
	b=WmTW7P3jAQtIvFOzMxNRvlv4hEZE37THVcCmv3jAOSsZc8rIRYRAOMXbR0n1hn9FTNNo
	 qjVGXR7tU/B4wpCB6yhShHYrrYUpMKjiKvW1KAos+FXGmgrVN2rgR+6ujc13oaPPOSEmv
	 bz6eO3NougR9lrWPgEA6DasEVW93dhq2EnhgsNQF3Bpv0SWoP9dsFlXeckPUrR0t0kjv/
	 EEQopu6SZ78Lf4VIZJ/VXAXeud6Ft+UMOgx1CGLFKr4W0ZAWZBT6u73/PSUpXklcWhQh6
	 OTHI+qwD0C9iu5TPx0VUl55WNPCX5lR4np07/GqrnTj2qYEOVG1uOi97KQLRLdtLeHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.182
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42FC2606A8B0
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 23:00:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 42FC2606A8B0
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-8b4d5e645d1so12668677b3.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 15:00:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794870011; x=1795474811;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PH0YrpSlGVv9qt33Z4Z9rb018oWWfWEr7PktdA631oM=;
        b=1rKcyCu2M97pC241GlsSH/Ti9paQ9vLPpPutNE8ypD0529jmLJGXizd1JvCjNCaogs
         s4r+t7SvLjlD1J8SDSiCcZqk1tqNy1ULl17NmkTT9rZb6AXtOK761uexf9WfwZbhreKT
         4Byn11DtSW0jAnsgU0+N/abSd/vt6S6IHS2XhCiNKtRHZsJ9iHGm0mF+TTBAskh/wq74
         K4t0aTiknMFEzooKXX0zaIv01RSqdOuKYvMSUq3Pg0ALIYdnyQu233ofInddCFIQzK3s
         L6s6BpO8CzclskFztDyNPhZYxhnrTStUYU0Ngi6ziR0+U94oIlHIXuQFDo2Wi7QY7uXN
         eqng==
X-Gm-Message-State: APuU4Z/qBQJjVJN2G/lWMWr57J8QoMv22zpzBNO9tLnsX4TeLI+hHU2p
	qHF8blwi+xRJyhTt+yLC5kSjnC/D0uz1+MASdBdjufOKaZJweQ8RB5Kp
X-Gm-Gg: AZFdTZdcZoaEZZPowV4qp0mxZPdmS+zX4SUctKzxnWhct17UVcL7e450Jdzaow8fn8k
	BrFx2PFWYVXG3sfBBZv3LBFL6RrC0A1/AhSAs2h7I4+o97sNVxH5KnLe7URug3OE+rfQVr77Zvj
	M7BAyDwq+WhtBW29Ii3B7h7AqN4dxndrzTW6XGyuQXauJL5Q/fIrBCf/Hn73eSx/cR7IYfbk03P
	9LTQmV1RmXV1kfJYEc59o1Z5pAWu3L9FC1Q1jwKMkd4AwVfYSevWXMrztbPNEmfoSYWSzAwRcBZ
	+bprv732RD6ljyFuY9ixv5RmUU/muSLXZvDlZ2NUm9VSIHP2yXK00+tny+5+OH6bv126tWoCnK8
	zXwOpxF+wps/zizDED7MptC7bUEj6CL3JG7qsenJJo2hsd3ox1PR5gbyatLAzgRwb63MkTR4nlz
	NjAVHMk9cwOL1STkdqE85oMW2pwXtEngxsG/ZbdS7jkZaPnwjk9XCbAKSRFJpQLFZdEo6Z8Y3n+
	2QQ3auWema3ReNAdI0imoCmRE6ZMVkjZ0YzlgmiKWjE+4ULHsYoRG0u7bf3FAhD+v6qY8I6T3qF
	w/PxH18YVjbETnMydIgK5HEd7dtWvHQM9WSr/OmNz+b8nvbxUYZDt4moqSNxA/XiN3W/WAeT2Tr
	jtUzBz9mPFafUlJLAHkC1DrSVArgnKSrGihHlG1vdonb3JxOd/YrWSA==
X-Received: by 2002:a05:690c:7003:b0:8b4:e2be:7a67 with SMTP id 00721157ae682-8b4e2be8127mr15335447b3.34.1794870011265;
        Mon, 16 Nov 2026 15:00:11 -0800 (PST)
Received: from 1.0.0.127.in-addr.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b4ebc50e40sm10721347b3.17.2026.11.16.15.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 15:00:11 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Mon, 16 Nov 2026 17:59:52 -0500
Subject: [PATCH 3/5] dt-bindings: iio: potentiometer: Add Analog Devices
 AD5246
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261116-iio-ad5246-v1-3-ef6b7c06d4b0@telaak.dev>
References: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
In-Reply-To: <20261116-iio-ad5246-v1-0-ef6b7c06d4b0@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0

The AD5246 is a 128-position digital rheostat on I2C, in 5, 10, 50 and
100 kOhm versions. The compatible names the resistance in kOhm, as for
the AD5272. It uses the same protocol as the MCP4017/18/19, and the
mcp4018 driver supports it, so list the binding with that driver in
MAINTAINERS.

It gets its own binding rather than a trivial-devices entry so that it
can describe its supply and be an IIO channel provider
(#io-channel-cells) for a consumer such as dpot-dac. There is no
fallback to the MCP4017 compatibles: its resistance step is 1/128 of
the end-to-end value, not 1/127.

Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 .../bindings/iio/potentiometer/adi,ad5246.yaml     | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.yaml
new file mode 100644
index 000000000000..a6642746f002
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5246.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5246 digital rheostat
+
+maintainers:
+  - Joseph Telaak <joseph@telaak.dev>
+
+description: |
+  128-position digital rheostat with an I2C interface. The compatible
+  names the end-to-end resistance in kOhm.
+
+  Datasheet: https://www.analog.com/en/products/ad5246.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5246-005
+      - adi,ad5246-010
+      - adi,ad5246-050
+      - adi,ad5246-100
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
+        potentiometer@2e {
+            compatible = "adi,ad5246-010";
+            reg = <0x2e>;
+            vdd-supply = <&reg_3v3>;
+            #io-channel-cells = <0>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 9cb91ee8a56d..81069fdbd778 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16680,6 +16680,7 @@ MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246.yaml
 F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 

-- 
Git-155)

