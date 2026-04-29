Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F7362DC791
	for <linux-iio@vger.kernel.org>; Wed, 29 Apr 2026 05:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777441567; cv=none; b=uN+FIBtF3xwFGmnxzHzLzf8KvLQqIqy5Ov9asxFe4Bh8U442OMu8N9dlo+knCjiX8tgF9VKISHFKPKpYgEt7ey0rj9SzpYSFYqcq4p9Nvkk9L8U5GjtC7lTOMW0HG62KWissSaGrtqdSv+jM9U5osar7AwbAqU/rzhs6HWcx6go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777441567; c=relaxed/simple;
	bh=LVx7QBmq5oHLQS8ou5iLZO5dvWTi5L4BQ0pp1NtWuNg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dychPgL85Owqfi2b/Qt9ZYNF0LRc0V9AMIbnGWr4ew74WbYZo/X1c5cTl5qTkpjkzV+9phdA/HE6JVWtawrpyCPlMwm2pZGe3XFgSVJj4ARFMquzJVMFnUbbiS/laVEkFXH1jgYjjcw8drDyTckXOeas0e4v8kgonLYv0yWxjck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G2pyWpqA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G2pyWpqA"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2b0afa0210bso56091265ad.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 22:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777441565; x=1778046365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cMy0u/g2cL7yrYXQqhYNhi1XV/1EanELOFp/N7XhvWc=;
        b=G2pyWpqAZc/6hclJWHE2ZCbfLpBAqe0Z1p0fZC7AG/LqZXenPC0s4Dih8+QC11/JuT
         AI4WNTDVFD/DwaljK4qZbVTT3RK3p0Wgfr2YIDCVachmMJ3nFBPOELnGHEAOloGBDBIK
         osgBQR3Fqf65WYHJ1+p+TVFcLeVNoxBc9LzbgzEv2mzJ7qMywIIz+hX/BcCuJwPoW0wy
         M5PWIaLqRUOZiKvBkyuV//YTW6L54xp4MDKlh9BcUb3Ti7LPJGLGTM62KSl9BEtDIVId
         I5Rs28XRJt2Tap704CdwKQzPqJrBYW34wKtQ159WjMZxVgLLEk0Ir9jfiSeFntAP6Xbv
         cOKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777441565; x=1778046365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cMy0u/g2cL7yrYXQqhYNhi1XV/1EanELOFp/N7XhvWc=;
        b=c3ixPz3oUOrzCwH/ZeROX7a7xIjTD26eFBJiwRr+j8XmJgtDX544QGejn7uYvxPFGq
         bt5f65dD+RFxhteIC7AIP+kdUjq/o5SiJnRQilQ3osZaEKz1szrcUW9tAOC2vN7HE/3M
         rdmw4rrUKdeQEXCYw3izTELKPQ1OdJJJ38m1BEAxRc+6CRcYbN2xjhBYjt9VcwhLVD/S
         Ae2n+ky8JaSY8ChcAgpyYxIa3aSzHzq5UcyrJJfRh54W2zxWiAm9UOdVl3CEN6ThnYCW
         KBr+mgAtl4ZmFJWrFIgADBVk0DXIujgrd73gtL5FFXRDhgPJ8MD6U+wUrUOOPTmEUyeA
         411w==
X-Forwarded-Encrypted: i=1; AFNElJ+pPIEIfF4V3msIeXHrZGfhVkjf3cvtD/Lc/2z3CYIrALfExOThoqAMhzgswNxwJJmu+6iIwfvxaM0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyn+UBsoOccPfxhQmsPQjzDYIUnemGtyjCChd3gErq/S8qd5NR8
	IfZsPYXTsDdtae5pen7FODXrn+wx0oclrnh/QRmYpmnMytxdSrvTYXoK
X-Gm-Gg: AeBDieuG3MNAXUZK5XVOqufcmEnhzlfJqHU2iFb5T+znP4B0jgNPkyxryRe52RN/F7z
	0Y0YbQKkxH+vakG1XC6nT2DSfCCku4wLe/cAGipfoScaYnS5B2f6ERuZORYhX4XhT5Jt4XUegJe
	0M+aJcuJjZCc+vRxU7okWsetHkx3hR/dT21bRIt3oBzcf2KibFqXRjP0V/sLNgTP/Mp4NWDBG6y
	eotI+Aam+CAY43ecvXuKWl1f8fSCs9VJ4rX+P0ssMFcoBFxC1nSej+D3rlgLRqB9F82Ytkf0y7w
	JyPXNpIZqYuDAFRS6qNWvLF7l/eIbk3ilTBty7SslYCUG7QZi1RgR3EIrix3tHM5r8UId/Ppgj9
	k64+RxNvrpDG05oKTioD1bKFzLmjSunEnFRvLvUL0AZEXBDdlXH5nbtqlaXEhiuQAHzJyIXcEEJ
	/40lK+ltsa2yRMgZ7NbSmWsK3BM/BA7Si5X5Xqxz266g5q4DIrIEHNTE1nXk7ZVjb78yELXcNXk
	ogra64JdWEL6dKnXN2AiWSakQflW+mk9sWY8mm08m5GU/FSqA==
X-Received: by 2002:a17:903:984:b0:2b2:ec31:25b0 with SMTP id d9443c01a7336-2b98741da0dmr22832185ad.29.1777441565346;
        Tue, 28 Apr 2026 22:46:05 -0700 (PDT)
Received: from lord-daniel-VivoBook-ASUSLaptop-K3502ZA-S3502ZA.. ([2405:201:31:d01f:5fb:20b2:c2f6:85bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b98879656dsm9346365ad.25.2026.04.28.22.46.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 22:46:04 -0700 (PDT)
From: Piyush Patle <piyushpatle228@gmail.com>
To: ak@it-klinger.de,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 03/11] dt-bindings: iio: adc: hx711: add RATE GPIO property
Date: Wed, 29 Apr 2026 11:15:36 +0530
Message-ID: <20260429054544.123862-4-piyushpatle228@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260429054544.123862-1-piyushpatle228@gmail.com>
References: <20260429054544.123862-1-piyushpatle228@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Document the optional RATE pin GPIO used to select the HX711 output
data rate.

Update the example to show the property in use.

No functional change for existing users.

Signed-off-by: Piyush Patle <piyushpatle228@gmail.com>
---
Changes in v5:
- New patch split out of the old combined binding update during review.
- Document the existing HX711-only RATE GPIO separately and move the
  example update here.
Changes in v4:
- This property and example update were part of the old combined
  binding patch.
Changes in v2:
- Add the optional RATE GPIO property for the HX711 RATE pin.
---
Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
index a8eaa1f18de5..9134bbe41379 100644
--- a/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/avia-hx711.yaml
@@ -37,6 +37,13 @@ properties:
     description:
       Supply voltage for the on-chip regulator (VSUP).
 
+  rate-gpios:
+    description:
+      GPIO connected to the RATE pin. When driven low the output data
+      rate is 10 SPS; when driven high it is 80 SPS. If omitted the
+      RATE pin state is determined by the board wiring.
+    maxItems: 1
+
   clock-frequency:
     description:
       Controls the SCK bit-bang timing. The value is used to derive the
@@ -61,6 +68,7 @@ examples:
         compatible = "avia,hx711";
         sck-gpios = <&gpio3 10 GPIO_ACTIVE_HIGH>;
         dout-gpios = <&gpio0 7 GPIO_ACTIVE_HIGH>;
+        rate-gpios = <&gpio0 9 GPIO_ACTIVE_HIGH>;
         avdd-supply = <&avdd>;
         clock-frequency = <100000>;
     };
-- 
2.43.0
