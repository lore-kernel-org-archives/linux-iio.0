Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742808;
	b=NLc9br3NE+wu+LmQ9yXx55sPCGWnmv61jvZPMzozFQRaeu3nr/Y9XG7GvSPZfZ+SSMcv
	 MBP9LYFm+x5vuhKQm/CjmFU8TW6IL7XsVer2NW2B9Q7w3oJeB2ubRD4b581P6t/RHT3kK
	 CVEo9Q7CuCpxOc+8OYHjSIS5gDQ5SrhdrdYwTa+izXpLZVDhjSWdfDhAou7w7YTVmoJfg
	 v5TFNyoNvjHx/M3XQUB/jfOTJtUnk8/JxCMk0riiUpppO7DF6pgCnv/Z7kDQ2ohR1P3Dj
	 Yj9mKhUlxWdviL5pwpXvHiBSyoMQxYl1GubX9QTvT5J1BHUJJihF2EAj0NkIT2+jjew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742808;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=aG/KagoNLB3jHRjeL3wtY+SAB/EDT6a7qyc/UcmRA5Y=;
	b=CXc03Dr7aYXfk/MKvrJmm12L0hkSoUkZw8qjuMxJ64lJLPCeFJs0WcPVQd/EUoWTz1lX
	 CpyTQWGre5J4IvG+fZ0/0O8E4kwIGBpIa0YF7vyov95+An4mZsuXNsQO/LTqwHxZjkoej
	 NSls8fh5kbeQOfJwCsSByK8w91S5Gnat8DPItgDUVmRxm/+2GETd4LH55AeYZnX37hW/9
	 EcG5Z/iBqNp4RsVpfcsTfMEFkf2VTC5M6w8lR0IXOYieo/njvJkVtkp1IoHtOCn4OxgS8
	 Lv/LmXw44OlTWXWWGhae50e9ZAknU0qRODytOkZ8m0n4h21iSHaX5qjwi56zROWOUdg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktp6R8QK;
	arc=none smtp.remote-ip=209.85.215.170
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3A7606A323
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 01:26:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7B3A7606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ktp6R8QK
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-cddc597d062so4522074a12.3
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 17:26:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742808; x=1796347608; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=aG/KagoNLB3jHRjeL3wtY+SAB/EDT6a7qyc/UcmRA5Y=;
        b=ktp6R8QKl/2709eOOrraqJz+yX/kr1J3oxhpSeFZnRitQEwCaDgbxtWoVDkyRnfzMi
         vPg9X7wUo5x/TPg8Y9c91IMP8bovEEefBMVEXwN2EBXFJPGuCB3xSCZFDWe6+/3Tuls0
         hfkRrWmfmk9f79CVyuLF0fxxmyDSwJ6J0J3NJyNYZ+t3dNuGQVzqYnT4bI7CFd1V1+WU
         5NAlqUsT12cGI4cfxBjLNceBSyMLtekLfkOQujudOJzryoUMSVjpzIuGNcpj/dF1IYEN
         jhhycfIHCYcPoN9v9GyW4OM+9+xg9/cY+tBUjmO1CkaYv8OMl2uXvRcqqvHJ6lDusSXe
         ArfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742808; x=1796347608;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=aG/KagoNLB3jHRjeL3wtY+SAB/EDT6a7qyc/UcmRA5Y=;
        b=os/PmdS25SKbWIev/a3Zyvh3rOQ9WKy4DsT2ovbSpL59UWJr3fxvcY3Zn4gZJqiJAD
         8nab6jui5fbOR1HSrO6tYVgeYWw9z0QK31iOC4vTS1u7NoPFPc8RDx8YCdkv087H/+vY
         cfry5I5cVNkG7+k5WWL2qYJk272GNOMdkctoFFwr2XQxjy0F2XZxdXAsuBk/kOMWV7Qh
         44HdUQGTr5wSqKjgSG3oC+CieBtTATGbL7Rq1KqnXoBOXIqt+k9yyagDTRuPcN86fT1d
         E9qzB+doNxIOkKDt37xosKFA2KwrZ68oaQfsvJyOJ4WyrnxVk1g0vXO03adavOHDONqg
         vAHQ==
X-Forwarded-Encrypted: i=1; AL+hErG+qwngveh1A4DJYR/JeDIRCHKj8PtR7zEXW7EpRKXOU69CA6qY9HWXiLNLLwZ8/8CA+WPXIqyTCHA=@vger.kernel.org
X-Gm-Message-State: APuU4Z86YPLj+ccGJaFTRuhYEpx6jWvt0M5qDICewQ0Mc+fkS87zywNa
	rQ9077KGda2e9qrwVTZgHCASObagTB3u8h48lECnalLraxNliyzdMuHi
X-Gm-Gg: AZFdTZeaB/u/K9gLqujqXGyD2CVjpUgi1/JKw/DSFtqRGWsnii2WCmEUi3c4PPLGDkG
	FxmXrEmW3B8LDT/5Sra2h5B/NGNcvzNQuCPqGGFOfsOfvTMhBMPKWaFG5v4GnMEPq7sP4OxDpts
	sVAcQwNnF1WTzYlvVusTGV9HwCwVw/NR1sFfye3p+jr2VD4t5qTgMQ/uF1pkgSzRYz/4MF9nCsN
	mbNyYBqDBhingj3ZYdqOJLsX2M8wU/iRRLh0q12CINlOndcjonbuDqdk7MlZY8mMMGdkCkSCjPm
	vuJUuiAa69N2Q1dr6OqJgylNuNKJ3wWKaIsL+IFj+XqLWFuM/gpZ2+5qh3tBbwq09l1HiM7ji8D
	4sKiDyKCv2dF/qwXeePM91+MRXA8AGA/cN6BX+Mx9sZwpilAZLgC9ETO0dfLmmjryElqliChW0e
	CIxZ2nFETrMoGNIbNtJKx8gq0iQJK46uzYZgT+wU/gsCewr9FDpP6FxxE4nzpx1239ivYByfawx
	9EubGxvnM1z1JDPPX+vfR1+hnRlyMnuIGL5HAvo2DUCTbHHtKm3sXnX6JlYqCl5Oft3bGC8Pq8j
	7ak03MbHKbtGkXkNW9SxME3FNcVVb4+QJCaZD2B3mcNFN+4sLBCqIrLCBgD8jyR/UOgBtkryoD7
	LD8Xytarc5aGvR2WbAiUjF/WPPCaJV8b/287uW0fvrJgdzw==
X-Received: by 2002:a17:90b:1e4f:b0:3b5:35eb:5ea7 with SMTP id 98e67ed59e1d1-3b535eb6056mr549399a91.33.1795742807761;
        Thu, 26 Nov 2026 17:26:47 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm35042866a91.4.2026.11.26.17.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:26:47 -0800 (PST)
From: Romain TISSERAND <romain.tisserand@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH 3/4] dt-bindings: iio: adc: Add the PocketGo S30 analog stick MCU
Date: Fri, 27 Nov 2026 02:26:11 +0100
Message-ID: <20261127012612.1589039-4-romain.tisserand@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261127012612.1589039-1-romain.tisserand@gmail.com>
References: <20261127012612.1589039-1-romain.tisserand@gmail.com>
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

The PocketGo S30 handheld (Allwinner A33) reads its analog stick through
a microcontroller on I2C that samples the two stick potentiometers and
returns the raw 8-bit readings. Describe it as an I2C device with two
IIO channels, for adc-joystick.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../iio/adc/miyoo,pocketgo-s30-stick.yaml     | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/miyoo,pocketgo-s30-stick.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/miyoo,pocketgo-s30-stick.yaml b/Documentation/devicetree/bindings/iio/adc/miyoo,pocketgo-s30-stick.yaml
new file mode 100644
index 000000000000..103a11c96fbb
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/miyoo,pocketgo-s30-stick.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/miyoo,pocketgo-s30-stick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PocketGo S30 analog stick MCU
+
+maintainers:
+  - Romain TISSERAND <romain.tisserand@gmail.com>
+
+description:
+  The PocketGo S30 handheld reads its analog stick through a microcontroller
+  on I2C that samples the stick potentiometers and returns the raw readings.
+  It provides two channels, one per potentiometer. As the stick is mounted,
+  channel 0 follows the vertical axis and channel 1 the horizontal one.
+
+properties:
+  compatible:
+    const: miyoo,pocketgo-s30-stick
+
+  reg:
+    maxItems: 1
+
+  "#io-channel-cells":
+    const: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - "#io-channel-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        adc@60 {
+            compatible = "miyoo,pocketgo-s30-stick";
+            reg = <0x60>;
+            #io-channel-cells = <1>;
+        };
+    };
-- 
2.43.0

