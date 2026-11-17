Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794912259;
	b=08laLv7V7Ta24dNRw21BoHkCu32Olx1oyTbNPFAEeYGDZqZy2Zlpnin7wabre/ImS9ar
	 OodLXyb97scp1/0FYewRXcVcQE9ioDRjd0KdWeUBaO2fKgckJfEWFIzjy2D73mzGEaFJT
	 P2Fyp21xLzwMIinxxmP/UfuOgUuHLOuf4Lusv3xCn+u2t9cmtZ9i+FyO4wT/xj1KLwUR6
	 zP194Q7Jf08rAcbYWzkhdBEXD2EUA2ppxL7RhzlSZZ8QnZMLdEyyPnsBUkjuIEilcFGeW
	 jsiAZzlqdjJzYpI8DT/2JSkNjVlVPRTK+078k8PoHJvff+pq55pXeIoTZtrgy8LIRGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794912259;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=4P0NB3VMBLnpdAs1DFprR1jE/RwnP4MqbaYmn8aT4e4=;
	b=lLp4CK8MbSJqXctRDGEeTiSRtIJ9qxNzx7mL7gtuJOZVm/Jm+8T1U+tyAItZKVb2dRdv
	 kJZGtwWeN+yTiuu0J0uhPzSAHuhVTW6/zDbie1ylmm3hAO/BY+0G07/1GckDpAAKq2OMF
	 nY8RBJtJBTHc5NHXMMGjENE7LTUv4J7yzgaC3z4yUdZC0FzyF9lAqFzqqkiFNI9/WcBc3
	 ugABBzV7ZTsw1qfQ91Zq5+JfemBp8dLaXuUlsazbxJSW59rpDMykx2K+PAeSwDagOsh4j
	 sZDTXbYcGzQF/v7y+kfPWaYAUzfU6VXZmYVTp1kSJKZvWEulqOm26B/Dm9oaqdONrgw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHZMc88f;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6D7A606A329
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 10:44:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A6D7A606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OHZMc88f
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-49a92144733so1820483f8f.0
        for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 02:44:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794912257; x=1795517057; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4P0NB3VMBLnpdAs1DFprR1jE/RwnP4MqbaYmn8aT4e4=;
        b=OHZMc88fL0Y3ZOM7HvBq6PnkbDMfe2WWSDzt9S6xySiq1ZMexL5Cki0nMDoLFTh7+/
         zkaoirwpf1n/fh/f+V8+B/g+QOInR5uI/ueS/emwC5xFWWbO+syNYp9A0CetBSXEdiWy
         qbwuLzPUTNZn9AOD+gUavFgKhlMm5YPJS2Yq7DKsGAuclBE8Y2ydtoZCmPsG+iuLpCUk
         fzs3fe4utARTlNuWFnXLZQ1+G0S4j4y37nsva/FwpRke5mvaD+Vjl4mk5Q5MWG+jQUXU
         rc6HtIN5fASzP2LGxFSdj7s4bir6sRq0E5AK+NulruDhYw77Za9sZ2d982Ibt+vCkdg5
         H/jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794912257; x=1795517057;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4P0NB3VMBLnpdAs1DFprR1jE/RwnP4MqbaYmn8aT4e4=;
        b=1uYZv2jpC0mKTjqpYyasVzRsYzOyAmB5mVyw1A8HmNBI1LOsToL9QB0pLnOrklgJxv
         jCcuqPd3h7GYst+X7YbVJD2roeXYWYVscGXJDIPr0O+0LtlaLyKguaThSrEK02pEGbRl
         whYErN+TfLDl9rTRRWpzITXjlXf3C/ZlNIhiWKx05vt8ryetRuLIW4raj4j6p7qLgmwQ
         NVnh4PlxoZeOJZLELy4kFfSoDRju0rMlm42FhhumYkKt5s6EuzHwBGQsc5qXXihIVpCr
         UecDJ+j/ynQTbM5/r11K69rR1EFhgUQTV3ooEo7pg7FAmWNWYC6MRRMrSxBh+gt51t/Z
         4Eow==
X-Forwarded-Encrypted: i=1; AL+hErHXVM+b/NDnLuuz8nPKgMMfbUluc78/U5zHA0K0EF6zNqDOAhIFieOJeCEkM1A1lTrZN5TDwZjF5rU=@vger.kernel.org
X-Gm-Message-State: APuU4Z+xjl1zKYLKEx+i8HllG/FIaVeaUWpOC532Q1bufuTI5TeZpU82
	RrLoBRm9ki/1hzkby63DI/sK7UbqFEuTQTomHM1aYJN3mH3oUZO1o0uP
X-Gm-Gg: AZFdTZePnA0GMuZ/jT8wg6Y6qE2qEyaUMXs+SeaerF1iaLsXaCt/TliHRO4eeKXVZUy
	vhfuPxdUb6E8cuqpeQEzPjCfDuCMDa2sficoBkXmVbf2NYw/eMKgNh3kH4LyI21rZR4BzClcAFV
	Oj5qPbyGeLLsliUT5/zEL3vbU1DdTW4VLEm6PecVoBBfzLmsQLUjyVaFEQBPkc37p2bS+HMyqe5
	0GFLeTLO1LmyqZojbtv/DxGLJusZAygW989flZrLFaPfXchbAnFkamWmtkLbCvVpMPLeCn12IYw
	8JpSnAbVJx9WxYuTWF655RLUZ/O+6zrrDljA2H9TY0KOGBBLIvl46A/LNzEoGJVD9JAQf5WFEsg
	CkuyuHJ49MJDirNVfJZ8j5JwjT3SQZR+XLY9CKXr/3ystPzk4WkvdLkStloIX+9+awzTEUNNBuT
	rwDWDWfEeqVSVO/pRIS/NpK9LtfN7yxig6zhSC/K7FrOuMDhAV5zPhewM/M2pKmakAIqekMnOL8
	OaMs48Fc36ErY5qLre4kvFYy7Mj0Pk1ukjVwbAJLbZSAph7cdOCMbY9jTi3Weu97geIdpXW9eqR
	u2HDZlt1NhI=
X-Received: by 2002:a05:6000:310a:b0:48d:ef7a:e59f with SMTP id ffacd0b85a97d-49c712ac8d6mr29895302f8f.17.1794912256903;
        Tue, 17 Nov 2026 02:44:16 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4a2e6c765dfsm6167711f8f.33.2026.11.17.02.44.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 02:44:16 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
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
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: proximity: add Imagis ISG5320A
Date: Tue, 17 Nov 2026 13:44:13 +0300
Message-ID: <20261117104414.1182364-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116074013.355363-1-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a binding for the Imagis ISG5320A capacitive SAR/grip proximity
sensor (I2C), as fitted on the Samsung Galaxy XCover5.

v1 -> v2 (addressing Sashiko AI's review of v1,
https://sashiko.dev/#/patchset/20261116074013.355363-1-tadilhusrev@gmail.com?part=1):
- Document int-gpios: the driver optionally reads it during the reset
  sequence; it was undocumented in v1.
- Reword the description to the chip's own characteristics instead of
  how the Linux IIO channel is exposed.
- Simplify vdd-supply to "vdd-supply: true" (left optional: the
  XCover5's own grip sensor has no vdd-supply node at all, an
  always-on LDO not modeled in DT, which the driver's
  devm_regulator_get_enable_optional() already tolerates).
- Rename the example node to "proximity@28", drop the unused gpio.h
  include, and add the blank line dt-check-style wants before the
  child node.

The binding was drafted during XCover5 mainline bring-up with the help
of an AI coding assistant (Claude Code, Anthropic) and reviewed and
validated (dt_binding_check, yamllint) by me.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 .../iio/proximity/imagis,isg5320a.yaml        | 62 +++++++++++++++++++
 1 file changed, 62 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml b/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
new file mode 100644
index 000000000..ccb84b29f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
@@ -0,0 +1,62 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/imagis,isg5320a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis ISG5320A SAR proximity (grip) sensor
+
+maintainers:
+  - Adil Hüsrev Tepe <tadilhusrev@gmail.com>
+
+description:
+  Imagis ISG5320A capacitive SAR/grip proximity sensor, connected over I2C.
+  As fitted on the Samsung Galaxy XCover5.
+
+properties:
+  compatible:
+    const: imagis,isg5320a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: active-low data-ready / proximity interrupt
+
+  int-gpios:
+    maxItems: 1
+    description:
+      GPIO connected to the same INT line as the "interrupts" property. When
+      present it is polled during the reset sequence to observe the INT level,
+      as the vendor driver does; otherwise the reset falls back to fixed delays.
+
+  vdd-supply: true
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
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
+        proximity@28 {
+            compatible = "imagis,isg5320a";
+            reg = <0x28>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&grip_vdd>;
+            wakeup-source;
+        };
+    };
+...
-- 
2.53.0

