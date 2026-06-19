Received: from mail-vk1-f175.google.com (mail-vk1-f175.google.com [209.85.221.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B60ED2561A2
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 00:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781829204; cv=none; b=ReCTxmzZFMYXbmlcuyc/cLuaCF6Vk/H32omGtFuEG3BaBT5ZPBwK3e82vA3xMxvlgmJixr8g90EuQXmbBrZhXdsboaar2y89G0GlsfQdmHv04lHEA39HLdhxtfywuktdpuvuFjfob4BKtjCTwp2t5ga5226R1nQ27oSLf1booDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781829204; c=relaxed/simple;
	bh=l2g7/z/AH31QQ2FPAVpxdJVGorUFIpJvHR3qJvSCt/M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=et19eKnikSnsDg+v2kXtIiRSx2YVCFt6ws02jJp0+N/SJnlvo92MLhSw/msNknKndmM3FLZ2lNQs3LeT9vZM26DSngLe8s3pT3EQMx20idbj0TKXAKZzBd1x4z0ErlLAoo6PWNsblOt1EqXfw78uTHa0JHA3rpYX6Xs2RE4nDgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VTt7qKEx; arc=none smtp.client-ip=209.85.221.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VTt7qKEx"
Received: by mail-vk1-f175.google.com with SMTP id 71dfb90a1353d-59ccf81e6feso522074e0c.2
        for <linux-iio@vger.kernel.org>; Thu, 18 Jun 2026 17:33:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781829201; x=1782434001; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxJPuccmsizX1T5f4AHNlctz3loKgW1+YIRVdkkYLLY=;
        b=VTt7qKExq3k5M8tPmcv0Mf8g6QQwloKGdpNFRZwTW/GQcyIRE4fPIM7x+lcuzB4Osr
         RpzOa6kNgsF7L4fGbmmDFOiN+s0h5vunS99RCXievO8StkPs/XMC49ezlBxbJClX7A/q
         lHAl9nw48AtBNEDhMEIFjxw22mRL2DXfFaK3FI/L1ksHliMzNJwY7KxwHAMk/4y+4wls
         nNtsd512n5xQhN63ZvuIiRBy6XlzVxq7c2Ellbm26/FCAGPyrJh1SaQT/GmeRTb4UNYe
         iRzL4k3WoHfhWeIv4keuM0OMjo84t/DSdo123G6UcQfRJH6nuecL+JO+vL99KdyocO9E
         jrnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781829201; x=1782434001;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=JxJPuccmsizX1T5f4AHNlctz3loKgW1+YIRVdkkYLLY=;
        b=HsXnxEQ7uDNoS+DfcyVQderP2MTHeOBnmSFnAIqzxVGkDWRAExxC8nhR04m/BODi5G
         OFPrEm8UFWFxBJ6UqMo2Cs/4gcFw5fEtYpsBGGYszEpTW4Sa771s1htP1R0rQMEricrd
         xM8jAr12XsuiVvO/Qd4sCIObBjZbt6RvpZcrZyGxEWfJRy73nt4hh3k78WK2SJWQV537
         EHulUzL/oBe3bN3khl2vmb32cxVgm9/HAq5OI4Ru/tTcdhYfELDmi5n7+NUUidfVab3i
         hk9Bz6hZc8HtidVbuCo8/+f4gfcnnw6ey3hkQDAo4i3t3AykdKCtigLZzx1Tw4yxUCA3
         ezWA==
X-Forwarded-Encrypted: i=1; AFNElJ+eGKMsUNu23eUZ/o4Qv1vi+8zb2lTcYWtLA2o0tU4P0icEGTzoC6pKLrYE6K8rDe3xKYslsn4VNVE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV2K8EaiC3DJ3izLMvbAH7OLy61qm3QHw39MgfsBWS+eUVamqW
	uHN58lrAqWmsIf4PzmwZwAirNNJZutvhxA3x5PkcAJMCspX8nXE7xQ07
X-Gm-Gg: AfdE7clL+PGZM1W80y0sKDPJJ/pT5tK2nZb9YJ53SJ9Nm5JeUhTucjvRWu23n1OLaq5
	qeyDsguxC2dKzl93pmAGY9ozIvq9XAvovqzX+ZrMIFJGQOJxEUrLNi9i2XohzpVhm4Gld86+Ldm
	yQKQQnv/65a1FkaarliSDPqW2N57/UIX8BsNJIM3dI0I8vt4l0iQpqp1HecrD8zEDxb3FinIv9y
	jP4b2TaLoOXvUpKaPbZyDvUccm7SkiWWudDi8YzhHBwwz6lxKug6Oq8IC4HmzpWbANiKPqqSBVP
	+7jV7WBTRxsE0N8dFzY3FN5z+qkk6ZnYdZ684gFmJsniqmz39m1a5JtOUOlXMfgv6VVVBVPiWQt
	zgMIVM2IU5IVgX8SRHW3Ytz/Kr9dShkU9Euh0ujMQjEgX/LnK2My9Vi19/wupkqqnhwmrkJ/3VX
	Eq8jPS46ls6JZQhSU=
X-Received: by 2002:a05:6122:a18:b0:5bb:d01d:451 with SMTP id 71dfb90a1353d-5bbebc4c13emr623003e0c.10.1781829201380;
        Thu, 18 Jun 2026 17:33:21 -0700 (PDT)
Received: from [192.168.100.222] ([2800:bf0:177:563:8f3c:3421:b12:7a09])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5bbea36b5e6sm861581e0c.9.2026.06.18.17.33.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2026 17:33:20 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Thu, 18 Jun 2026 19:33:03 -0500
Subject: [PATCH RFC 3/3] dt-bindings: iio: adc: Add burn-out current
 properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260618-new-channel-props-v1-3-963c1b5cf40a@gmail.com>
References: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
In-Reply-To: <20260618-new-channel-props-v1-0-963c1b5cf40a@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>
Cc: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1291; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=l2g7/z/AH31QQ2FPAVpxdJVGorUFIpJvHR3qJvSCt/M=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDFkmfZ73DRgZPy/582Flz/md3Le+/Pqcx83VIL5rBfcq9
 ZNHfQ96d5SyMIhxMciKKbK0Jyz69igq763fgdD7MHNYmUCGMHBxCsBEAlQYGb7kthZfK5MzUbHU
 CV688HPWW6n7LpsKfm39dmv3a14ZCU2G/wlenwPqpT7zB0krGu9IucLt+Ekxsaw6ZOOlnARWsxN
 LWAE=
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Some ADCs incorporate burn-out current sources that provide current to
the channel's input pins for open-circuit or short-circuit detection.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 106b1e317411d5..6b63aac9ac04dd 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -106,6 +106,20 @@ properties:
       This array describes the current configuration of the excitation current
       sources or the single matched current for all sources.
 
+  burn-out-current-microamp:
+    description:
+      Burn-out current sources provide current to the channel's input pins for
+      open-circuit or short-circuit detection.
+
+  burn-out-current-polarity:
+    $ref: /schemas/types.yaml#/definitions/string
+    description:
+      Burn-out current sources provide current to the channel's input pins for
+      open-circuit or short-circuit detection.
+    enum:
+      - pull-up
+      - pull-down
+
 anyOf:
   - oneOf:
       - required:

-- 
2.54.0

