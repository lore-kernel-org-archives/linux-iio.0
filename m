Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FB6501F30
	for <linux-iio@vger.kernel.org>; Mon,  7 Sep 2026 15:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788794593; cv=none; b=XcgTUXV16YfPOnEqgR0vcq1jS1qiVNmOLI3GlqJ+TL0t3avO2rQ3KT4wbafg4EKi4Mkahw6iyTtfOVe9vxaKqnfUKWXTVmhM+eIer5aEWR9yoAMRBfZmHnBnFOhgW080UpFLWdnP0lAFwkAaVXgzh5x5V+THOV+j1u0J98+ZHIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788794593; c=relaxed/simple;
	bh=rRqt2DkRwkgR8tWQwQ/ymaqvmLFKJ2cuYcMhprDy/xg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RDFUP66nCi+AehrXxysUdPTNFgcz8YweAfhIb/Mr54Em3uCEre/kbWBSvGeeG2bEyBof9ocMGjZ5nzlFjpKBOejtdgKhbFrM7vdf5B2HnEJDjnDTkXLK7JhzsiqJz78/ERn25XzJIEyGTIxQDyel1jPG76tl0esgR5kIG0hQGjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6QjMjbR; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6QjMjbR"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-49b392ccaacso55571725e9.2
        for <linux-iio@vger.kernel.org>; Mon, 07 Sep 2026 08:23:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788794590; x=1789399390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LGXRLOWBLjDeRkzuVxlsTvsrgZVPRLz7bQm8bEcHaDA=;
        b=D6QjMjbRdcBVAavHOtnn8BrmBzuj7cJXHuTatURtV7qyXHGgecRMEUELQnaJR5SE+3
         ckmQUo+otiY6YfzQjb56m/tc3Ysi6WFVII8eedNuibGMrf+0If+AwJPhoOKaJjCG0vMF
         mRDFkQ2llRF7e2JJ/r53ZqpmnW/ABsU8TFhPYgu/8kGt/yj0vCIT69mPDrYgAPIN3d3l
         UL0CgmTgZSxQzpnJwYldm+dxa/rptcncuqPn8zkUa5QxbSBLTeZLACugsndGwehUgIuc
         olwzvnwJfpJ18Q34Grf42Q/bOvLttQwKeLfvRZI3te8L3Q/ugpgDHyQErE58bAmPlrMH
         D8Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788794590; x=1789399390;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LGXRLOWBLjDeRkzuVxlsTvsrgZVPRLz7bQm8bEcHaDA=;
        b=jNnV0msYDclkb481aOImiphxdKhS81a+bQ3yRkkei4n9G5f/TGe+hfsEAq1Zhrx/M6
         H0kjTQYDDbGo0xM5Ekg02MdQrYrkA5KiNSQWiEyBtYP77ly1D3atWCFHXw4XxPr0z6GT
         ZODkzB1pFH/lgkNoGjJgMEA2jyC6R1QyEsV3B0a9ZOEU3BeLUWdx8u7CLVsV5wlp/u3p
         Z41gT449evW3siRHC5AZHw0KwOGHOjUq9iHJLO9KER+6ygAwJO1A23lXD3F5buPwH0cX
         yzzCe9u9PqHoLs2OFOHwF4vPZ0Y1T1rRT6+8vJHwR+wYGgylIEH98GDTGKMHby1xdE6t
         rytA==
X-Forwarded-Encrypted: i=1; AKwUvBxPukoTE9VH6uwonifOOAKhMCJw7LoyzbfYB5knde8LdrA2x7W+P3MKnMTFgnSqrfVhYTNEkSisJ5A=@vger.kernel.org
X-Gm-Message-State: AFuF++l1sNj3kIk0VqjnddJfPQDkKlTgH6cJJ1LoJKH+Th65tghBl/ch
	VI28p3yBEHex+JGA3krp9E7L3H9TmzOJcUTF2a4uokeU14ojuWTxiiFf
X-Gm-Gg: AYBFou1s8OhBHixiMdOHrB9ODvxzkajORuxiX37KQ2a41H1ueIY7S1UOg60gazz4mxJ
	AMkzDTqT4USGgMPTpPqWLXMB1Z+fw3V60tEj3AqK6jc447RyRk/DCrsafofAWYfX8Md14EuK3hL
	fJGxG3Y21V7IgavY2y/rrxIdckLQl2wRcvzo4GEjvJnTpeZdqd8HrHtT1vqiTr6r14fwyxAh38Q
	tc3w61LaOyigLWUHaOEqYCOsfUCPP1c6lov5MB3RoQ26AAv8AxZQ585fzcO00MUSvFXAinw3wUT
	jlVN1EdHiqzweN4cUo0cf7okqdEhJ+yDbewwyk/QkxXIsiIDoABqUYIS2qt6YLL6O89A+MzOJeb
	IRx28gdpeR8SX9ZNu57VlZN3olRd3pX54KlBeFyIwZUOLRwpwrbEkAqbuXTwIPGDVaCP3hWoFtM
	AESEldDsYqJBioZU8bAqCGxkQXu9lOqUaYdnrvDeIUvFtLWKzlDqzAZ24Ih3aoBlmU+DLaf69MZ
	Av9ghO2U68f8V57mO9tQ+WgYlHckQv7RtLFMxHV4w==
X-Received: by 2002:a05:600c:4e89:b0:49c:fa21:1c81 with SMTP id 5b1f17b1804b1-49cfa211d6bmr203694125e9.22.1788794589574;
        Mon, 07 Sep 2026 08:23:09 -0700 (PDT)
Received: from flaviu-Aspire-E5-572G.. ([93.122.248.115])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5f912esm413785375e9.4.2026.09.07.08.23.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Sep 2026 08:23:08 -0700 (PDT)
From: Flaviu Nistor <flaviu.nistor@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Nuno Sa <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Daniel Baluta <daniel.baluta@nxp.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: Flaviu Nistor <flaviu.nistor@gmail.com>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-iio@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: iio: adc: ti,ads1015: Add label property
Date: Mon,  7 Sep 2026 18:23:03 +0300
Message-ID: <20260907152304.4992-1-flaviu.nistor@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for an optional label property per channel similar to other adc
chips. This allows assigning distinct names for each channel which can
match the schematic signal name.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Flaviu Nistor <flaviu.nistor@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
index 718f633c6e04..777a75c21d7f 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1015.yaml
@@ -66,6 +66,11 @@ patternProperties:
           - minimum: 0
             maximum: 7
 
+      label:
+        $ref: /schemas/types.yaml#/definitions/string
+        description:
+          A descriptive name for this channel, like "vcc_ram" or "CH3".
+
       ti,gain:
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
@@ -125,6 +130,7 @@ examples:
                 reg = <4>;
                 ti,gain = <3>;
                 ti,datarate = <5>;
+                label = "CH3";
             };
         };
     };
-- 
2.34.1

