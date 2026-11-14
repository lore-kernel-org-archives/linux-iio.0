Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794645519;
	b=ltwRksGJRYkqihu1ojCjUCX9AGskAsXulyQmZDSAb2QgbU3h0hqI1S3K7hDpVLUtViKY
	 6yYkOQGS+Gl1oeqYTlDFOoggxY3dYr2L+Xe570wp+/kkkIztHIvwz4gcA6gD40FeJibBx
	 EdGGIN4G1cpiB2fhlawZsCHRfzdIXKQrb3f+UzLcszXXBJ/FylvQ48yey80BWNx0dwJwB
	 UVTv4ZObElqoeCvmEbSzOmMzI8NxXDcNxOpRwWTXIytmX1Gs4dacVXJhFCA4sbR6WKTW6
	 SXrMADN2BfBMU8j9OsThSB4H0qZwUKs4xAwjvK3xwzedVH9jRiN0F3Ja2N3Kel8O23g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794645519;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IrLTARzuKGpNCEUALTN/Yh4br8W0rH7Am+lSrApsbX0=;
	b=FvybM0tjG+ONVaLeKHhexkfQ8JHN7PlLmPu4vHZ6dzmOSIVIhhpeQjhoUBnEOC2QTomS
	 yV6W+fojvu1H1fM6zZVLkzgbC6APrTtohCgjRwUGkT6GgLn2L/7P8SuXYOrSD7cU8xn6T
	 LQaM0lD2x1oAKWcXYiZTR8gVFmFZeeR7lXm9MJ0fkb4IoU9fHwvitzTatx+/HLoYAXIx3
	 dBU+LVmA6wuXR4iN75C7E1a2NoIWDJOf5A5j9DI6Kwlmw+30ZV43VHh0qcS+6ulx5S6yD
	 UFC8jX9daJnL2KHBPNXiT2UTmVP4/vlG0mXD6yuvyeB9HZCOavR8SkxlBLva7USNEgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0Mb++yI;
	arc=none smtp.remote-ip=209.85.208.172
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D748A606A89A
	for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 08:38:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D748A606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t0Mb++yI
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-3ada7d53082so27543661fa.0
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 00:38:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794645517; x=1795250317; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IrLTARzuKGpNCEUALTN/Yh4br8W0rH7Am+lSrApsbX0=;
        b=t0Mb++yIbpunMuxHHwKZuirS6kHgEIlj7XoC7EmEihDJtgIj3Cwk0gKAO0305MGXd0
         3x9PYJr/2WJaI9StZ+dQCTjk2p4jiHiIeqgQTk4fJ+hofbbc05trklIFVtT1OxHXg2XI
         0rOiEvHMjiOs39KnOMCkVnXpKveQgC3j3e+eX1JYHZMAyGiJ7NEa4p2Q7ZK2QCH26w7F
         MuGf0LMQ7sun8vH0IRFRrUBUvHvrTNgqKhkWKtd3+t8rn3n6g782HAAhCOUvS6Hjzwyi
         D99bK9fHfdNZ5mSEyRLhMpESKW2A2+gOb1Di6Y1cQMdqIqyJHuQFV+Uqz8IKAjb3BKNQ
         L2+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794645517; x=1795250317;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IrLTARzuKGpNCEUALTN/Yh4br8W0rH7Am+lSrApsbX0=;
        b=b6hkBkiE4l38nQ1eWZUNtoGOHxu0T59dVF+Y0RfoGgTq6/2tk4Ub5sJg+e0JoRWxja
         aeesqW3A3NDiyOKiMT9AzHidpP7ZWrbQVhS3mYWwFim416TJjMvcji1vFCP/Ztx4canO
         kqPp9V80W56sI6hgTevbovh3AqhNxfwnYpE+D7SGj4ESaE9GCGhlyqN5WzzeQ+aSiGhq
         ABwa8EBp2LluRlQayW+FUJ8Wj/wn2Bzb+1mGZqb/7kht+YwfyQXR9FemnDmMUmAI3WZt
         J4YAXgIsj0yy+14QD72TO+Ncn5Tec80cj/FGj+/2440al9lpgPxIwkETubNQYTNhO8JP
         V6ng==
X-Forwarded-Encrypted: i=1; AL+hErGre+L8p+cZmo7MtJjXvhPsS9gDPyiA6m/SlEn3cOBjBGpdRx7fjoVlN3omhmXtoaIo80kno9N4gsg=@vger.kernel.org
X-Gm-Message-State: APuU4Z+b57W77YiYEm1UGGr+/gXk/VjTej+WMYaW2kq+mZRirwEuQOFh
	WU3QMY/MEwIJjAfE6nvvLKiYWyIeoBYeTpSpcEPojdj5aV+ooSe3lS7XU2YsEk0U
X-Gm-Gg: AYBFou00NKT65/Iys1nufSAy9h11PH73WkVtxF+3SecvVNOJqBKeYJjdSQiqG4aisuW
	oJnzBpOhVpxBg2P1plS08Z+PtsgGydTYMnMh6C8b6+EfIfd7gUByHkY3mqDEcFAeN+i3JQDO2tD
	WfZ0+sxX/tlDTlmwugrgAwwprFZfycJNAK1HzOYrwWFGXxIvzjHn8JXlbwgjYmZW09GzVpy1PmN
	blOp1dHAQtEhxMaEw4WGXk83NkQRfYK/9eHegpURzHHm2fqWjFrHXrc5KveGVRrLKxidxK/SsoN
	yTQbhOXaUwpwgx8Qiw5KXI7QPRQ7Eg5Nl8rbD5k6oCLRfZtlaurWHXKriRlY7rCb/KX61lVzK6G
	61EGVCuS4Fky06YHFVQWyNlVvJ1IK3M1YiWp4qDGFY0j1wJf06A2vHEjLS3ret6gV7BchxThDIL
	1i0ryJ4cjrARwmXJEGiHhI+YOeQZIQ6zsO6QuxfusA1oyVseBSVzjQ3zmYjtw3hu1aA/vaYh/69
	KpVFfAaqUek3OUScNk4XUQdfZV4ioMB4NwOACSe2xvV6rxapRsSuTAdJUuw02IyfxfYLGheTeSe
	ztOSDSN1tMdzhvBc+poaDIGGj7bE9xDhExoytPzFIvCdHkl0ty8uLJtyE+03Cz4LKJN97pa697B
	zHrdXJU9pvzRSC89AhhvQK9MiqONSLD1zaBbbyA==
X-Received: by 2002:a05:651c:1596:b0:3ae:920:ac4f with SMTP id 38308e7fff4ca-3ae1bfb800fmr22203951fa.8.1794645516894;
        Sat, 14 Nov 2026 00:38:36 -0800 (PST)
Received: from yantra.. (nekmmqusxj170dz200l-1.v6.elisa-laajakaista.fi. [2001:99a:d7d:c300:b551:8edb:536d:8395])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5c1713565a6sm1527803e87.78.2026.11.14.00.38.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 00:38:36 -0800 (PST)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>
Cc: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	Paulius Zaleckas <paulius.zaleckas@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: iio: pressure: infineon,dps310: Add interrupts
Date: Sat, 14 Nov 2026 10:38:27 +0200
Message-ID: <20261114083828.18059-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261114083828.18059-1-zoone.rupert@gmail.com>
References: <20261114083828.18059-1-zoone.rupert@gmail.com>
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

DPS310 signals new results and a full FIFO on its SDO pin. In I2C mode
the same pin sets the address LSB, and interrupt polarity must be the
opposite of how SDO is strapped.

Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
v2: no change

Cc: Paulius Zaleckas <paulius.zaleckas@gmail.com>

 .../bindings/iio/pressure/infineon,dps310.yaml         | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
index 416117dfd927..cded6e0af147 100644
--- a/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
+++ b/Documentation/devicetree/bindings/iio/pressure/infineon,dps310.yaml
@@ -23,6 +23,12 @@ properties:
   reg:
     maxItems: 1
 
+  interrupts:
+    maxItems: 1
+    description:
+      New result or full FIFO, on SDO pin. SDO also selects I2C address, so
+      interrupt is active high at 0x76 (SDO low) and active low at 0x77.
+
   "#io-channel-cells":
     const: 0
 
@@ -42,6 +48,8 @@ additionalProperties: false
 
 examples:
   - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
     i2c {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -49,6 +57,8 @@ examples:
         dps: pressure-sensor@76 {
             compatible = "infineon,dps310";
             reg = <0x76>;
+            interrupt-parent = <&gpio0>;
+            interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
             #io-channel-cells = <0>;
             vdd-supply = <&vref1>;
             vddio-supply = <&vref2>;
-- 
2.43.0

