Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795742793;
	b=uOU9sS3AWgXUhvVwrds2MuJ26hjz/ZwyZTqVScrp2m0ijGeGI9yjBQT0OQ6mG7i69TSA
	 BdFpIhM0BMIEM6XNiOkl9GP4ty4w7qh5tPjdXwymcjP4mKfuxYRfGZJ+jcEIZWy/wrJOm
	 WpVg9ildhR/aQVBEYDnfbkkAEcRCyCrVg20oWRsSZQqCcw+I/g/KYUwudjxt4h3MPq6sh
	 zqRWKphuYklGGN7FoCrsOd+k+d1RRnsM0QES2Pi7u2827iIZKFi6RLzsa8Z7GEbeHYPCy
	 Mrb21NBNxuZjoJiV2Yx+/0rUvbejSeauoXsWr/N6yZK0yQ7yl0AcM0sEG+UsbJCzbNA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795742793;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=4ZwWBrnn96TFtHdsd5bNIm5u9QIUQi8JSQL+RPU0pxg=;
	b=dXih15AtaIsGU0hNJwHUHS16nzhFghYNAa9kye7fu9lFnX5ar5KRYXUTRPo3MuLJFD3z
	 S8w65PXivUkrpX771SjmbNbJx671A1+tRwQCwVxZWUTT120eRzL0aiWZ2OxeOXYEEUtdx
	 KNPyuIwtM0zFFVHPlbRInExYn68p8xalhNj0Kfgi8opf6QMfLuCg113+gYQV7+9TGClJE
	 tyq7ncpwIWVteVR/o1D1udqaI8VOf7hnLniqZ0IMAjKIDRpwOrRx2iUyNusU6YbCBS+J2
	 e8ZjPyFNct1T56akWTf0WZp1x87KkWwWa3Ah0NS3aNbz+gSZUQ8IDvNEuNfBDq/EUug==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WcPaCema;
	arc=none smtp.remote-ip=209.85.215.182
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B343606A324
	for <linux-iio@vger.kernel.org>; Fri, 27 Nov 2026 01:26:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6B343606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=WcPaCema
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-cdb2e0062bbso2950805a12.1
        for <linux-iio@vger.kernel.org>; Thu, 26 Nov 2026 17:26:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795742793; x=1796347593; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4ZwWBrnn96TFtHdsd5bNIm5u9QIUQi8JSQL+RPU0pxg=;
        b=WcPaCema4u0dus+/y5eGcrErIOJSggLSuvW95VzkqNZDz8EyEfmHxof3ThrhY4OxIA
         pkWwfyT2CUrQ6S2SRfGCaCfe+yln8NAooerJurAwHkVk7cTZA8wkPKfBL7c1zR0A1tZR
         pZBsKoJyg2Kr8iXsQVbT1n8ZnplzBNnNUDavr9PJZ7d5b+DoTY75tF21VHr5poW0w+jT
         vEOOcVg2N6TE2KSNM87NItzwzWM1ohcAHtggS8IscFBhWlZ7z4vmQAEwrppMB1aOz+5x
         AV5ny2DCdBoyxNfGp2R0PeF37irRavhLeu9Khju7slPH7+Iqh//rUnp1UJMoi1tHTnxL
         +2eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795742793; x=1796347593;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=4ZwWBrnn96TFtHdsd5bNIm5u9QIUQi8JSQL+RPU0pxg=;
        b=wGLygVUQykDUoYj4pCI/v1m9PROF/98eGYrDP0ADOdK4yaty+S5ozwHuKpiNg4mrVL
         6nD57pFJyG8zd7O/FrBh4kkMhAJTBAGrTivXcQgEasUIoS1TVqAjQYzd4zy82Aiae9Hj
         pnzq95agcZehkmGo5CeP4sVC5SrnoiZYylezOzBUCvN9KU/vKVGYnGxb3x3B0F2nyxVj
         rgWqhS9ZVWyB3ak48CzhotxJ3E9tnoU2FJfvMdRRufAeHd/xhp6n1tHxcj/w0Gp4Q+4o
         fZxvqUbT5mySrFbu6hv+xTNwoWIqwJPL2BCphRi07zbqQ2Ad5xkaw+Rd0d10vVUznh/g
         VQ9g==
X-Forwarded-Encrypted: i=1; AL+hErEyOhXi3g8La18oOAlWQt7cOVQ1wG+qNwYN8z2y24gpBnieXaGM4fl0b3TQmNjU9BRds8TxMYt+5zY=@vger.kernel.org
X-Gm-Message-State: APuU4Z+202uSZnT68VcNMkd5FMNZlJod9X62PtgLUzlm6NcC43R2+ERZ
	sQfR3MJ+XAqwQFPQU1hUujy+Jt9n2N4R717X0xjVqdZYxRb79TADa6K4
X-Gm-Gg: AZFdTZevk+TH5Bq21oZHhhu13vaIMwdCV43KO55giu3ockIfpuAgLl9urx+AYGMM9RO
	k4E5trlEvstZcts93mcu1d/J8cidf7R1Bj4bjs6c7rG9Qjx7wtar5npBx51QQZEFG1jpd47HYRo
	MpG5bbeGEUFBEWyXbSio4etAyvjJqo4MUhsKfHyty4YHuHHXPaF/z6Vau/ZMq2R4GRV6NhVEWjZ
	i5q/Gdg5t5ckrZ6W2eiQEcVTsnC/jGctlq4wOqxS38b+ITdTC+9mLBS/pz58CKOA9HENEXbwEl/
	ggC+n53z4B2lX2A0RQgU/nCQG8kYn4yUbMgqsyD4ubtcctJoBRA6yRp22YjZiyqt/h80mA87Jao
	tPgpxqTwqEoxiBKT7KXzyvhslZ+SHBG8bRdjoeQue5cbmt0/sDRyF/EojfXmqlDxW4upZ6pYwj1
	crF9JEIBaL0UzjZqlsGQcpxS4I/dRM0lBofbhByxZgNSO+oE0Od2aqKq0Tn8P8AMkRPJI4pmT1k
	VDWet6Q/ORb7nRlbVUVY7mGEhUzTWY0fYlROc2/M6dXQ6QIKBlHzVUirt9wIPEAKIrnO9ryuzqn
	4lPldL6z2g43pG00/U/p1xATavb7LQmpEAELyWdlnrb+sdyOuzAIbvcYZxZN73yV1lP5wW4X9aj
	xmhlwkik7VF/cYMnwqhI2QOouSo3hNUNP26c5bIdb1snVdA==
X-Received: by 2002:a17:90b:2f8f:b0:3b0:ad59:7199 with SMTP id 98e67ed59e1d1-3b41c942629mr20023312a91.32.1795742792547;
        Thu, 26 Nov 2026 17:26:32 -0800 (PST)
Received: from romain-ThinkPad-P14s-Gen-5-AMD.tail433d9c.ts.net ([2001:861:39c2:e340:1432:1241:93b7:7b4b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b41ad0b2c4sm35042866a91.4.2026.11.26.17.26.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2026 17:26:32 -0800 (PST)
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
Subject: [PATCH 1/4] dt-bindings: iio: adc: Add the Miyoo A30 analog stick MCU
Date: Fri, 27 Nov 2026 02:26:09 +0100
Message-ID: <20261127012612.1589039-2-romain.tisserand@gmail.com>
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

The Miyoo A30 handheld (Allwinner A33) reads its analog stick through a
microcontroller that samples the two stick potentiometers and streams
the raw 8-bit readings on a UART. Describe it as a serial device with two
IIO channels, X and Y, for adc-joystick.

Signed-off-by: Romain TISSERAND <romain.tisserand@gmail.com>
---
 .../bindings/iio/adc/miyoo,a30-stick.yaml     | 42 +++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/adc/miyoo,a30-stick.yaml

diff --git a/Documentation/devicetree/bindings/iio/adc/miyoo,a30-stick.yaml b/Documentation/devicetree/bindings/iio/adc/miyoo,a30-stick.yaml
new file mode 100644
index 000000000000..6c0e997d4ff0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/miyoo,a30-stick.yaml
@@ -0,0 +1,42 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/miyoo,a30-stick.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Miyoo A30 analog stick MCU
+
+maintainers:
+  - Romain TISSERAND <romain.tisserand@gmail.com>
+
+description:
+  The Miyoo A30 handheld reads its analog stick through a microcontroller
+  that samples the stick potentiometers and streams the raw readings on a
+  UART at 9600 baud. It provides two channels, X (0) and Y (1).
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    const: miyoo,a30-stick
+
+  "#io-channel-cells":
+    const: 1
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - "#io-channel-cells"
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        adc {
+            compatible = "miyoo,a30-stick";
+            #io-channel-cells = <1>;
+        };
+    };
-- 
2.43.0

