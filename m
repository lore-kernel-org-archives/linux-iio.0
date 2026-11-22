Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795374521;
	b=wwktkarW385eKod3dOWIOMcHxXhYhLbBFHH2SEPVCK6Vsmzz84SyaKde4P5iQYT+AtlD
	 kA7Zd2DY8r4IN9Fcpg+r0TXAQH0pgRvyazK8dZAJJ6ZcIPNJuzU4n7zN1YsYEoFZLiQTz
	 Si46Hi2b9WVYCxTCv04XFPnHR0/wMW8D1uBgt0xoGAWhhB54zl84688PdkS7+WgaMCX5R
	 hlWK4VOczOF35D4iOomirKH2jNGouvoSSxCCjK1E/ePIs7gLEn0ECUoYfpk0pxQemMKCy
	 37jBculv7ffp/7gWoWb8FeO8EKALZF6CKN8/8Nh2kVnEEnY/NXWNTz8jG7szMz24ibQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795374521;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
	b=np+mIOl5JwpuoE9Z5WeY7Qp1FgZQDpoqsMQZ7OKCBENC9Fw697IGeWb+SpeC5Amg6Z07
	 BPor8LRBl5t/G9RtcmEBy8kyu/Fsdg+RHUk/8rhP5sS27m+GxjCrguM8ZiqGs/yPHnaCp
	 iYpXtxqETXaDXqVrD4XcT5q9d7wzVQpv3rO0QQ7/B3Sz316xO/dFBiuqDGCPXPzcDsCYb
	 yagRDqcy4Rd38CxH4p6P41GNxkgv/Jzz7LN+3KO1vxgkmg9aZbR575QpgD4KBMd1apSlk
	 SFc3Eibwf8RlZSrEDRgpUKYgc0rDXBxf96wj+mfZs2Y2gds0krgm2ARTvCfYaJbPRAg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=teslabs.com;
	spf=fail smtp.mailfrom=teslabs.com;
	dkim=pass header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MY60QOdv;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40584606A33A
	for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 19:08:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 40584606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=teslabs.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=teslabs.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=teslabs-com.20260707.gappssmtp.com header.i=@teslabs-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=MY60QOdv
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4b79502c27aso22652035e9.1
        for <linux-iio@vger.kernel.org>; Sun, 22 Nov 2026 11:08:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=teslabs-com.20260707.gappssmtp.com; s=20260707; t=1795374520; x=1795979320; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=MY60QOdvETfWFmzwHjAuZarP728XBww5sgW3Xpgzkc70uYm1GMEHAQ+OOFQyGz2K4I
         3UC73tciUBKM+zkMIQzkP7p2N5lWE6wMCMvL5KAbRLniLc5l2r+QuKs8OVwjZ0L2MXEz
         5HGucgog25eHDSnCv4SeLN5AgVDWYrJVcq3XHgEI5vx9a+0gJ4lis9sOU18uHwdcB2Ve
         xcuhSVCUFiyOnhouVZEEvcYwxCHzdPPPr65h4w72ShWmB8NJwpWvBv4G/cqikENHyup+
         nSSJUYV2wt4l7+XxQnezrF/ms1W06KZai0bFFGSdID8MbVX6w01z5aJWgstMFNsJulBe
         AuCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795374520; x=1795979320;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tBF+matHGBGE6Nr1Fd/2Ogm4SDKpAbX6dyL5PCX4Igk=;
        b=q/1izOmA3vhzISFMLAMM0JZp2ziIjLDGgzQBXOqRu8hty+UA75dQcNU1pPoH2MANZD
         lomEB3fbzuPAH2HaxsZwi0KvIV9UBniyH/1Dl3drYPcywrb1wtQ7DtecOGNtKsXHJV+X
         je5DI2/PwuNHC0I0kNVEU4ttIpW8cZkD19WpiZ/uZihw2fFCl6O7thwB02Za80pJjtpT
         Vg/dR8iozFJyWXXqFWw9IUthWYlqtUX4cvXJ1bOlm3Ntbmbf2O3F2C2n3pqyJla9MhVo
         BLCCd9vlM0/5oBA6020agnwNiQPNuSxw/MbKDjtoWWJwAWMbEREZDl4sCYViq0VVKAW/
         HJFg==
X-Forwarded-Encrypted: i=1; AL+hErFGx/MyWvzBFKtK2xLkqwz18k1L1wiWUmaa/tGqmtD99Ug3tO9tu6422x6BLt4tpS9w+2ejNRJxhB8=@vger.kernel.org
X-Gm-Message-State: APuU4Z/1rvs94dQn/lg29rsMqc7EHLUl6ljc8Utr1L2MWn8leL5tc3z8
	swb2xaqMkOw4VW6gXG6005P/DK55Y8tNFHQAqaXHmJce5KC63wFIs5hi7inRBd42t30=
X-Gm-Gg: AZFdTZdzkckmnYhHZr1zpgY51jx9PxgFfp3zlNzV9mnwsIg1IW4O0Zv+Mhy5rXZKwq7
	+U4llgUtmEmarEdPCrax+mzKNF15SRVo8gUC7cV31BjWsNMkj+W5whWH6ovkXQjnyw83QncZkvZ
	K7YAMz3HWZpbGfnXXaZuJMhm2H1nzJKOuDK0L2KfmQVxJt8L/7P45KzzB2CzjeogAsGPZyNHodv
	g7SlEftD+QO+JtGkHvIAFcTrDvTxvRyS7GvLRe96OLsGJ+zbBodzYFdp478ln/OLcYZZNbEF1T/
	n29NLRpn7RfBysi3+OeNJi/niccnGQ+4jVyK1lMAKOZJ0WSqVnP5rusFaLfzmw/Toe3iSq5VR7L
	KlFe276hwM0W5rgSgs0flqeRZrkpMdO3TdcAQ+TOeQSonQdfdNWWpOp+dqVGLG4fI9iCUb5lpps
	nJkT0k+hWWHJxnTqMyUjg5StK+vgblTdeuGM+hwQpALtHGginvkGteYvqc4yflLCUBSf027+yop
	B/iSPq8whvvMI7uXwBivySVMN93aEiw5KC14ycBLUXq1FTaTi8uR+QHW9e7J4ns17W3WNtz7HvV
	JEad0OKBlNs390EV4UcD+7eh0/3kuMjtdl22rTtjsW3xyfGJitVcyslWCiDEKvVFPXsMRuJ5j/E
	P6w4aOy4ovCY=
X-Received: by 2002:a05:600c:4515:b0:4bb:6f67:ca0b with SMTP id 5b1f17b1804b1-4bb888267f4mr200592785e9.29.1795374519093;
        Sun, 22 Nov 2026 11:08:39 -0800 (PST)
Received: from localhost.localdomain ([139.47.121.129])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb895f7bc1sm103080395e9.3.2026.11.22.11.08.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 22 Nov 2026 11:08:38 -0800 (PST)
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
Subject: [PATCH v2 1/3] dt-bindings: iio: magnetometer: Add MEMSIC MMC5603 and MMC5633
Date: Sun, 22 Nov 2026 20:08:34 +0100
Message-ID: <20261122190836.66111-2-gerard@teslabs.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20261122190836.66111-1-gerard@teslabs.com>
References: <20261122190836.66111-1-gerard@teslabs.com>
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

