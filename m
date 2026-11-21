Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795240525;
	b=euwMAwQFg6mioGDLL2rygmUesorxfQMGwIkLgfIli714tU3pRPvsG8pULqOm4v0o6E+u
	 jPmuT+P5S9pYZ2cQmvRwAq9kK5exBFpz1nWeF8rndRZAJXGTNE1rFzkf7CYsBC3+5co82
	 q6MeTGedg+vAgP8kxZf28ULBWNHKYaVHcjqtLvMFUIeueJ3LKouC/Mr74Zx5bXGbLGbjP
	 Qe/Vjruccvg0Rns0XgJbEfoFW2iwly+MqxpcoLu/uzMwXv9zUBo/Xp6+Y/7aD5usmThK2
	 yW0TREn36SteAx9JaxlqM/bCN40xZ9q+h9E7xgq6IjlYiLXmlRs3XcH2GHsG+wXB1cQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795240525;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=NPYFuPEgu44jhRwl9AuTqHxhKDURTNdBQkYhdhcmNfk=;
	b=MeHsOMn7vybya0BDS41f0y9pEO0NTVTJpJQjQIfFHe9Y428u6gXEISuzTXKiaYcOB5yt
	 1nATSNLEYcR4M+d2EIh8D6n8bXjdvyiHXLmjk6siOKkI10T9tbLlBidGYIgvm9IuBJF3t
	 GZ9vdWp1WBc7WMhgtmbtkoCSe7GSbCYPulesG7J8qIwgIJy4le6MDZyAtEeFfPoi1zsup
	 3vKsiFy98zQaQSjoDPcHKT83q+bdcxbq7Bhb8qKueT4jBNFE1lk9mn+ajjDFD3/8n9UMZ
	 kXfjX7W87iLVf5eOBvsH/vqG0BiXrNLeDr5b0Jvv2ignX2B9aASwBVvwe8OlOv+wMWw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5FMl4lK;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA100606A693
	for <linux-iio@vger.kernel.org>; Sat, 21 Nov 2026 05:55:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA100606A693
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=z5FMl4lK
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3863db981d4so1676917eec.0
        for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 21:55:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795240524; x=1795845324; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NPYFuPEgu44jhRwl9AuTqHxhKDURTNdBQkYhdhcmNfk=;
        b=z5FMl4lKPo5jDTZak4fyIIWTlt6W2K8PrGOgBBb8aEWjMSRIocc4vo6nRWZHfxm4L7
         Vgu2oKjOnuyXSxGT3D5Rz+YHuulKC+fzS6Tno0D4BI1du5okq/NMQMv7fqeaqG2kUteT
         6XgEvlTuzx8ljPCOd/eZQRIIL53MQkpjEKQzlg5UpJwAb+MaG70OgnXP1I/F07zRylL2
         Wxsn93eQrAesTmNKM7DXtUiXhkRq1kO76tskmDfLeFlIdss4d5gQ8QBWuGncc7rWwtQ/
         dzx0IppAUmcaz/pcwFYhxnRaxAgaH94uMrfZfIoN6NP9xAgPipogFd8mLwMpOjQRcFnN
         ODFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795240524; x=1795845324;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NPYFuPEgu44jhRwl9AuTqHxhKDURTNdBQkYhdhcmNfk=;
        b=fffQJeVnEg6G+OhAh0ZFLe6zAYsVKUOXZE05g9uFF+OocMWzZsyzuKUfNESWBmlwWJ
         26HnuCk8D3dK46Z79SPFCpS2QBsr2bNnqosoKoWuMR9SxnsDO36R65h6l3QPwNsUqz4I
         ADTUr47J/VgaVRhjIw7fFPNTkOk1UYJMREwUxV0RVZ2CVZaSni7S5hmMxPPE6BRB3a5r
         /tazq0hAtvCM9tEUJ7HXJXwepCu8Iq7BoFDFbVf43wTTno0FW6SYLTtTuhUitRQagJ/t
         D/swtHip0oXpuqXqu/OyJNqZ7z/70EHq3v/zQAk7vMLiqd6yFp5fsi7Y0jr9TEVfAohK
         xk4Q==
X-Forwarded-Encrypted: i=1; AL+hErFyfSnAVKLu3wbBbUvxnJy0WgwECwNlgizNmUbgqvU6XtwGVX2Lv3b7Z/Ik2p4PXtf+p9W5aBRRR8w=@vger.kernel.org
X-Gm-Message-State: APuU4Z92tz348hsrjuFm0qOsc16YsarHmuKZpYXonPjrmbqT+9Wr5a9U
	NNcOECAYqIHDY6Fu220Bja2hG2yNpOA+pmmk0ln+SoPLsGQj7psfbTET
X-Gm-Gg: AZFdTZdOOoe2HM4uooH72ldXzC54V7xxAwhi1pU9xNlH62XYxoWlBV3n7oClSbkPomb
	7oLspS1tDGR+FXZ2AdyeFM5fYPc6p1hcGRPKLEpfAGaG5Rc3KEuzQCYILJg+woni9DVjdEdeFXX
	m60WicJqrTgfA6qbMwF5qmKmzKPsc6mdqmAC7LwevWMPz9py0ab4PMceHi6KtizFNbqU5l022zC
	uiSIOY+/UcDcAN2ha5H+40H5wpFMkzKUyi7bBl+oSXLgx9VF/0gj45Rz+kfb5ZpuIqc8cobRvaU
	dQfR0C5VHFh0PjRZRVmDwlaA2PAl+2y/l0fy1FtorqGCjNM9Cm88i8tm95sB8HZnPc0NRDVCN8r
	KgQ3EWgg0UfzrEUG/Qym6esYP49wWBZrLqJWdH86H/iU3mgfPFkyRoY3Ja7NdPpptFTo+KN4wIQ
	YcN0Df162A5h64nTTVHc7kXqA6fegN66tSJCp0CPFJi/E8G5ZQAxwRP4uO67f5Cz1nsTi9i15FK
	sCx3F7R5FVegkMVDz4eB1HQlIsUfeiMD4/b5yVomD2C/9EKZCkBoa6Gx969Y56tnkAQHiCIOJMD
	kDCupastg/wViRBcomcXNwMD8dSy6k8=
X-Received: by 2002:a05:7301:6408:b0:383:1bfc:f1c0 with SMTP id 5a478bee46e88-38570f27a56mr5280716eec.32.1795240523983;
        Fri, 20 Nov 2026 21:55:23 -0800 (PST)
Received: from [127.0.1.1] ([2405:201:201e:8863:a72d:7d80:d674:e22b])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385677c0c1dsm14423662eec.21.2026.11.20.21.55.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2026 21:55:23 -0800 (PST)
From: Viral Patel <viral8854@gmail.com>
Date: Sat, 21 Nov 2026 11:25:10 +0530
Subject: [PATCH v2 1/2] dt-bindings: iio: magnetometer:
 infineon,tlv493d-a1b6: add TLE493D-W2B6
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
Message-Id: <20261121-tle493d-v2-1-92d7e57cec89@gmail.com>
References: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
In-Reply-To: <20261121-tle493d-v2-0-92d7e57cec89@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dixit Parmar <dixitparmar19@gmail.com>
Cc: Victor Chernyakin <chernyakin.victor.j@outlook.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Viral Patel <viral8854@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795240513; l=2626;
 i=viral8854@gmail.com; s=20261014; h=from:subject:message-id;
 bh=Pve1oOphWw1Q9mky6K/7lRz/7nV3rjbiYSeFFIY8C8Y=;
 b=J8EEItayLygRxFy9STgBbIyjsITUuMWIJso9ogNh4CKPbukNCbAccJU8+yftE3Vsfi+Y6hc4o
 hSYCLL1HvMxDTho2NS1PE4hwBu4nq4kctiybNI5ekR9sPV9xvVxzBk0
X-Developer-Key: i=viral8854@gmail.com; a=ed25519;
 pk=UC+UDB53t70pTK4wncXf3tfh0hsYMCqpxYnTaKX3MYA=

Add the Infineon TLE493D-W2B6, a 3D Hall effect magnetic sensor with
12-bit resolution per axis and an integrated temperature sensor,
accessed over I2C. It is a second-generation sibling of the
TLV493D-A1B6 with a different register interface, so it gets its own
compatible, but it has the same supply range and the same /INT output
sharing the SCL pin, so it fits the existing binding.

The A0 to A3 variants of the part only differ in their default I2C
address, so a single compatible covers all of them.

Signed-off-by: Viral Patel <viral8854@gmail.com>
---
 .../bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml   | 14 ++++++++++++--
 MAINTAINERS                                                |  6 ++++++
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
index dd23a9370a71..3f0058cbf538 100644
--- a/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
+++ b/Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
@@ -4,17 +4,27 @@
 $id: http://devicetree.org/schemas/iio/magnetometer/infineon,tlv493d-a1b6.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Infineon Technologies TLV493D Low-Power 3D Magnetic Sensor
+title: Infineon Technologies TLV493D and TLE493D 3D Magnetic Sensors
 
 maintainers:
   - Dixit Parmar <dixitparmar19@gmail.com>
+  - Viral Patel <viral8854@gmail.com>
+
+description: |
+  3D Hall effect magnetic sensors with an I2C interface. The /INT output
+  shares a pin with SCL.
+
+  The A0 to A3 variants of the TLE493D-W2B6 only differ in their default
+  I2C address (0x35, 0x22, 0x78 and 0x44).
 
 properties:
   $nodename:
     pattern: '^magnetometer@[0-9a-f]+$'
 
   compatible:
-    const: infineon,tlv493d-a1b6
+    enum:
+      - infineon,tle493d-w2b6
+      - infineon,tlv493d-a1b6
 
   reg:
     maxItems: 1
diff --git a/MAINTAINERS b/MAINTAINERS
index 02015eaec312..c3004f683e78 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -13117,6 +13117,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/sound/infineon,peb2466.yaml
 F:	sound/soc/codecs/peb2466.c
 
+INFINEON TLE493D-W2B6 DRIVER
+M:	Viral Patel <viral8854@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/magnetometer/infineon,tlv493d-a1b6.yaml
+
 INFINEON TLV493D Driver
 M:	Dixit Parmar <dixitparmar19@gmail.com>
 L:	linux-iio@vger.kernel.org

-- 
2.43.0

