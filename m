Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBF427BF93
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 18:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770920426; cv=none; b=B2Tea88IoGETSxbsjkglspHRwdSVQoD0hYeYpR9JzDJ4gwoVQxBxBwNmlh/b+jScWFdD/dyaOAMBpO4W26fYK4yDCIwao9xYIya6buvwpc3lf5C7s9axWOKjsxecx07Mfw79Jkn7O9rxN5NWDRxhbXRoD6h4ZrSYQpSmWJoWhGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770920426; c=relaxed/simple;
	bh=cih/c/q4/7Hg68boWh+HLVoGUUsEO5l70x0eaBfgVYo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tlU+3eR5d2wuKz/JUmpN6gW3XhOXL977kpnw/whC1iHiAt+nUqE4vOSDNgB3S5Agn/eC7+E+98Q73h+7lDXeFfRY0PX1d5U6PIWynPeR37kZXHlBnOcat4c5VrVoi+/tdiEHB9S6BWrWmrBVRdQp3ekFV54UTHMnkrLaQjpw728=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AGxv24LH; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AGxv24LH"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47ee3a63300so1527875e9.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 10:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770920423; x=1771525223; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Bprsrllva8d7VsynFvqVLjqVpekx6Ne+uNmXQ1YCZFo=;
        b=AGxv24LHx2yj5QQEV7TS74Wl5bLLTLONGJhZr4awWP3v5sdhvNkEnCGzkxpTkG0BtN
         Dv3V+XE/MZaVrLsd4i40PnWAtDZsM4UUFFCmIJfAndP1jcW/1fFv4VcgGt/dXH+nUda5
         xqM2eDMDdnUnKiFCglfPbAnCe72KE/Eo7uAM4vMkuZUj/ezuRfl+Oz31QXUhlbmnnXH3
         Ao6hSnwdYRUbKK7pMBzwTrRX9gwNvrNGElzpJEJMv9rHwNr6IOLJZQEWpqlghqca+L5W
         2zmlJfl6jG3b2H5lgUoFP8MExzX3Y/9609RUxtU2b9GU4eW8nL4FMrDv5SAYvrcQ/oPG
         N+5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770920423; x=1771525223;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Bprsrllva8d7VsynFvqVLjqVpekx6Ne+uNmXQ1YCZFo=;
        b=BZzL+Loxg9Jc+hCF7Fhhg5340HIemCWEnf+AbNdlHgUdsX80IIJHxMmfiTA+V2Pdqb
         IWQON6GAuc+3Hk8uVH2RmUhaKbQuxAEUGYI1wqjxJyBi2LC/IoXhALI82/0fSqG3PYF3
         LJm5tKjl8lDCvSUy84r4qdhKnoUUqAtRc858Bv3tJO2QWvNrQKEQ3HvOWdxE2liArbb/
         8RKQYtPY/IJ9jCKQtKPF49QQbCOLtmpR4r49fTXwmhQc+N5vp0OYYgyrsPMH/Fde2Q5T
         tulvnwPfYX6fOer6bblcWshQbB9z8G7SIIgH+fZxHC5BH7WYbtJ4K+NLvQi81yV4Uoo4
         tTVg==
X-Forwarded-Encrypted: i=1; AJvYcCUZ7xIavM58albRgFyToduuwQMAXdzwZoj7dJCSnhWcriAKnSp8atWMJ/8g/Gh5FmAcraWeW8BmJoM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJFIEGAMrUp5wmFGbUMLNH7V0aJj8BECrXseypTo93bPm7UgJx
	VioJl5J2X94fvJ4XEvnS5LEkTMrnpgl8SaCmM/LpoWnDslFDZjUksMp0
X-Gm-Gg: AZuq6aLdHjSxcJN14ej/z7fCpiuHCNPbnQjBZS6pjNHNFZ2QXQL71RPMSHsJskhCZyH
	llraoDtqDkSpTCEArFcSougTGpXOPNzk97oLrOmBlbjPNECVUKtNPvuVjoufHuUl5EwqqZfL1zI
	pOqUpA4OZAgBkSvOFeBfRa5f/KP/30u4XRo/jdgVifW0pLBOKKJz8pJxidkEFlUDsQ/96vh2fLF
	RN25bX1s06Tyf4Z2e2AprAfCXdNhTrnm413kDrjPL8IKh+59NmtACL+D4K8IJ1p6k23t7Hzwchp
	Th+V1qDi6gyNkSPY2zhL5B5uKT3edzlBrXl/o46RuEh+ZhdlWgHT5QINddLuM25em54ZAhNnPrV
	92Fibm4tvliXa5xOgSnBkCzVpaeJbJB31myKB5bEP8RJ84QUkQHLybQou6FKkKY/MnEP7Y6qcTw
	d5LfCr7QA636Z/ddy3u8dvBKfSOHX8q4RUIrTheHR4+IBbJn9uNsHA4ClaAfWQy+si
X-Received: by 2002:a05:600c:6792:b0:477:b642:9dc1 with SMTP id 5b1f17b1804b1-483710368cdmr371995e9.20.1770920422733;
        Thu, 12 Feb 2026 10:20:22 -0800 (PST)
Received: from db07.UM6P.local ([196.200.180.25])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc2b0sm13239933f8f.21.2026.02.12.10.20.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 10:20:22 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mentees@lists.linuxfoundation.org,
	me@brighamcampbell.com,
	skhan@linuxfoundation.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Thu, 12 Feb 2026 19:19:54 +0100
Message-ID: <20260212181955.42724-2-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260212181955.42724-1-0rayn.dev@gmail.com>
References: <20260212181955.42724-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.

Add `adi,output-range-volts` and `adi,output-range-gpios` to describe
this hardware state, using `allOf` to enforce mutual exclusivity.
Also add `vlogic-supply`, `clear-gpios`, and `ldac-gpios` to complete
the hardware description.

Suggested-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 38 +++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
index 9c2c038683b4..3e832e501b0e 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
@@ -27,12 +27,50 @@ properties:
     maxItems: 1
 
   vcc-supply: true
+  vlogic-supply: true
+
+  adi,output-range-volts:
+    description:
+      Hard-wired /R_SEL pin state. 30 V when pin is high and 60 V when
+      pin is low.
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [30, 60]
+    default: 60
+
+  adi,output-range-gpios:
+    description:
+      GPIO connected to the R_SEL pin to select the output voltage range.
+    maxItems: 1
+
+  clear-gpios:
+    description: GPIO that controls the /CLR pin (active low).
+    maxItems: 1
+
+  ldac-gpios:
+    description: GPIO that controls the /LDAC pin (active low).
+    maxItems: 1
 
 additionalProperties: false
 
 required:
   - compatible
   - reg
+  - vcc-supply
+
+allOf:
+  - if:
+      required:
+        - adi,output-range-gpios
+    then:
+      properties:
+        adi,output-range-volts: false
+
+  - if:
+      required:
+        - adi,output-range-volts
+    then:
+      properties:
+        adi,output-range-gpios: false
 
 examples:
   - |
-- 
2.47.3

