Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795513598;
	b=l6QzK2J46opFJ33uDFxoRlP+lFIep22D3TcpP87slJnsHIFvKuPuYZ54aW+P1zWJGdju
	 aZpCI8BJUajrbP1pBCi91qTwv04lIRm70CFd7od/7GysFfkRhnInaotaap599ENvy41fU
	 sddR9g9VbQ8w9WlEfVnu0kZZihhguoGhPNdgtwQQY0w6YboH8get83HF74K7/6TojoJUK
	 zItT0tYN6WnKyvOMe+fXwMzzxgBXt9TFR1h42eQBPS8mr22OX8nod5Xwr1b/IwwTnZN8S
	 H1ro3hk4ouXnMnAag3NjeRaBrHoiC6Pa0/e1/DZue/KPE8nBuC6B1vg0afsHYeXa6QA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795513598;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
	b=Q8v8o5BVEm9/QKpXy3C/pVnUmZrb6Ms+DF47R8HbVHJNxNltplnbsWeay9wCTBodbifX
	 lxy0BkVpp8XywwDKbvNaTw3vaNIZIt+ucNsrik+comld5Orq3y+tKxhUEC+sQy5CscTKx
	 ZhYFvRbL8OXYMlt9Hieynk6gR0Ziz3lZUY4LjPLPVxll5z4xp8e+5gr77Xf35+h7jzRXg
	 wrGZiARVrVABOV6sbaB0CJqvfc6CvaA+MCvQBpXZi+yOyEp7jKI9tf2Iz+HdIUgfWLyU2
	 0DBHSphkg9w7DkoMv5YnUpEao+8Rl1fgCr5//lzXwqDGJi6e83a3KVPjM/qfhMhw7hA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2DuapRP;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9298F606CC07
	for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 09:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9298F606CC07
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=F2DuapRP
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb6ba3b244so43317355e9.3
        for <linux-iio@vger.kernel.org>; Tue, 24 Nov 2026 01:46:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795513595; x=1796118395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=F2DuapRPmyZprQaMWa13/95lcAo7egtMQxaK0A97dc36K/UbriXjpI4WRcY04/rH+h
         oQhbZmVPs2FSjZbGBvJ9uh0X7+yZ/+97EcWMSiN6KppPDEcBiONtkTrCS8POowkV7Cg2
         CfosKbONOI5Fk0Eo+pRsFWSgNZqA6ugDOfOmrOBUWKpOCLBWaC6ZQH67Lcejb4XbsSid
         MdQ3Ks/BDgtJHKmUIKfl595k9N7kw+dmBigAhMPu4YI/A6a3JMTFvcsoRbGf1S0CaHgu
         J4a/1uVx5Ru36M5vSSfHS5r2nZgqLkbUDvmPu3P9Cyfr9d4s/LhIyLyE68iUsS5wvQjD
         uMVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795513595; x=1796118395;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=BrvsToAsJCB04ZsLO8Cj8y+IALfupdM7O+5E2afeM6Th1G3laJ7niHLDRcor8wVeby
         YhcvskE8TV0+fSgh6RhKE8OAN/4vNvdH6cy4nMr4aOb9Xua14iyaC/4QMX+nluywNIFQ
         kdOfFxY6vMgYjcOTo9x5u2Py0HOrxJQBZRWeAs+fZbLRbK+WGNNLIynzDo46W/N9jjbB
         nNmyl6LDOOsKHRevvukrvd5L9uV2yPZh7xgF6QSZlujzyEKbbDE/47mO5f4niPzln654
         zriGhwCH1l0c+BWRA+x3n0cwGElkC8b+9PFYKTrf14+63uBEvOBL24tWd4HXQGOvqOfB
         1cmQ==
X-Forwarded-Encrypted: i=1; AL+hErGNViGiPDr3fBNXJORQF3z6Ygej1zhCcY+q95XmNxjmAsklmh3X2e+14JfMRWTLEex6J5yOFw2iiGY=@vger.kernel.org
X-Gm-Message-State: APuU4Z9NoAIs7qLDvNzbp7wvVYfTxLvVSUaUoBMcQep8Pu9mdsBmAHX0
	U35nRjZnk5hGZp+57JRyUna1lxNYsvlFbErxgo2uIZttlNl76WhSDMsfAY+zWZWPeHs=
X-Gm-Gg: AZFdTZfa6h382BHuSO6bZB+6SueHjPEPhVsHHzfy3N27kfneKicIsc2KEMNHcF/6EdA
	2Qr/Am1UA42GFqmdAaFtGoF1LLfJQUrVkmA93tbrZn2HQ532OAUle83S98OyMgfDX8k2MTpAT+/
	5Wiarhmh/Z6Djqp2+GQF/nm/F7spW+uwQsCbgYD6pc4ndbT0sY+trgvHNSxpL67SV8W4Xvvc4Hq
	fk1v4gNB7YFkN3YnOXYXV1LC0g65swKagBEV1aiE2gCYbRZS5fHqhgUFKer7830JU6OBW+ax4QF
	quKjM4PEHIe0/R3R7aJhjJSMTWgjKztPlNN0ElkU002Sxz3UcK2rdOGJ3xcyy5fYOus87+Yd/T7
	5TvRWhScc/O3lNzreGFXIIePvFuQjVNHrFOtGemgPKqPGsX08RwJrCwp15lzxYY6ifpOFb7zj/5
	AluQUQ7DEAay6qGGbMTre8VUVP8QWmv0jKiOoTNRfqhGz3jWNvc2O7M5gUnD89kFDQM6+x02wz6
	HhWYD1jAO/n2MpASz3NtqOosOTZlnvrHjg8uH4SbnPlpKCCxYw6Ef83q96WtHEzJn2qqvGoSMJ2
	H8HBBisKt4oIga2rybz8Sk5U93Ptj+DnrxYLshDdEIO1Kb6BHBLRiD/46iICAzL6K4//lmxcPlh
	qhNpW9Ua9Qon7hhrxc95WAOJBwNONqER+
X-Received: by 2002:a05:600c:a0d:b0:4a1:825a:56fd with SMTP id 5b1f17b1804b1-4bb88826c1fmr277657935e9.32.1795513595111;
        Tue, 24 Nov 2026 01:46:35 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb884c3063sm431782555e9.15.2026.11.24.01.46.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 24 Nov 2026 01:46:34 -0800 (PST)
From: Gerard Marull-Paretas <gerard@teslabs.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Frank Li <Frank.li@nxp.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/4] dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
Date: Tue, 24 Nov 2026 10:46:29 +0100
Message-ID: <20261124094632.8879-2-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261124094632.8879-1-gerard@teslabs.com>
References: <20261124094632.8879-1-gerard@teslabs.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The MMC5603NJ and MMC5633NJL are listed in trivial-devices.yaml, which
allows no properties besides the register address and interrupts.
Boards need to describe how the sensor is oriented, and the supply it
runs from, which is often switched on wearables.

Give them a binding of their own, covering both the I2C and I3C
connections of the MMC5633NJL.

Signed-off-by: Gerard Marull-Paretas <gerard@teslabs.com>
---
 .../iio/magnetometer/memsic,mmc5633.yaml      | 61 +++++++++++++++++++
 .../devicetree/bindings/trivial-devices.yaml  |  4 --
 2 files changed, 61 insertions(+), 4 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml
new file mode 100644
index 000000000000..423b8ecbb9e5
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/memsic,mmc5633.yaml
@@ -0,0 +1,61 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/memsic,mmc5633.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MEMSIC MMC5603 and MMC5633 3-axis magnetic sensors
+
+maintainers:
+  - Gerard Marull-Paretas <gerard@teslabs.com>
+
+description:
+  The MMC5603NJ is connected over I2C, the MMC5633NJL over I2C or I3C.
+
+properties:
+  compatible:
+    enum:
+      - memsic,mmc5603
+      - memsic,mmc5633
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  mount-matrix:
+    description: An optional 3x3 mounting rotation matrix.
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
+        magnetometer@30 {
+            compatible = "memsic,mmc5603";
+            reg = <0x30>;
+            vdd-supply = <&vdd_1v8>;
+            mount-matrix = "-1", "0", "0",
+                           "0", "1", "0",
+                           "0", "0", "-1";
+        };
+    };
+
+  - |
+    i3c {
+        #address-cells = <3>;
+        #size-cells = <0>;
+
+        magnetometer@30,4a20000f000 {
+            compatible = "memsic,mmc5633";
+            reg = <0x30 0x4a2 0xf000>;
+            vdd-supply = <&vdd_1v8>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/trivial-devices.yaml b/Documentation/devicetree/bindings/trivial-devices.yaml
index a8b2b9deade4..523c205c0880 100644
--- a/Documentation/devicetree/bindings/trivial-devices.yaml
+++ b/Documentation/devicetree/bindings/trivial-devices.yaml
@@ -261,10 +261,6 @@ properties:
           - meas,tsys01
             # MEMSIC magnetometer
           - memsic,mmc35240
-            # MEMSIC 3-axis magnetometer
-          - memsic,mmc5603
-            # MEMSIC 3-axis magnetometer (Support I3C HDR)
-          - memsic,mmc5633
             # MEMSIC 3-axis accelerometer
           - memsic,mxc4005
             # MEMSIC 2-axis 8-bit digital accelerometer
-- 
2.45.2

