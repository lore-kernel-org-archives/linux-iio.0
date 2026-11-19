Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795095658;
	b=VhGAwIb9fBmsp1rTV3KEIp4rrVa+kVp42eHm4UDnd5BUxLyVcS7Fg3+MEqJNG+ydngVp
	 EUIf2bAXpw6elUst4aKt7O1k2W9ptqFR6bu/ysNwYzelCo8Y4USQdU1dPhd9MvA4v/2nr
	 m8F2rnKTKL8rdSfOJs6b5+igUOf+Z0JWGsyKo8NN2YQQjEhNDNkWTD3BH1VRoyreSqX+V
	 eEyt92eBPh/R6QtjoS3YV6poeEOTfbFsQJ/Wh/fv0dS7DhCw0hF8e06WjP3cBfs+4bZ6e
	 hS5nWGLiwB8JADv+Cw2ZpUAI1sVAl2HdZeQVhwjdcdmnEdzBwlXP2onK8lgkglMK2IQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795095658;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=PzR8EHqO13mERGH6qlAcIvdtNywH2LjT8NBNjWxU6Bo=;
	b=HowDb2I48qEI8dhDiElW6kf5A803fh/Vom5gM2JglifITbLK/e7v5pE0dTuEAgPbdiFW
	 dV1+ugHZQ4un/zWjLPNPfV7g+RCthJy9LqiBJPUdSiImjXz55ZXRsW6sw9XlZ7lXBVYkF
	 mKo2u5uJpPqfQcJsAd4QVaKi2lbrEJvCMytii4uHROm7HjFWV9ctQ4aQfvBME+dCi6o8c
	 fkznCtQVReWz02cDa98rwnBhHrsiH+IzyJ3gFVPgy99xIJgDPPWXW4S0kPipk8fF7/H8e
	 4Ane4dXIOaEI2xW9Qo+4VCXcuL8TJs3AMBvm/5JX47RsTUFSkPRzJBsM5trvM2KyfLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdXZDhHO;
	arc=none smtp.remote-ip=209.85.217.46
Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F342606A32C
	for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 13:40:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7F342606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=rdXZDhHO
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-7d2d95c5d81so700338137.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 05:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795095657; x=1795700457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=PzR8EHqO13mERGH6qlAcIvdtNywH2LjT8NBNjWxU6Bo=;
        b=rdXZDhHOsEz9CaLUyjruA+CqbJbKEPqMupYrT++jViMeQJVer+/hLdp+EMubbRt/R/
         2hPLO6jmI/DJfw96d0srhIN2GAVfmg6kDVpxKl+wpiGdm5wsYGvpgvo25NI8PjOYHNlF
         9G4v6Lwgnd2w4KxhZWclxwqq3WX7NdSXc518D5PN6EIbwGnbRxpqaFoDD59qentEUiP1
         IoSWZXYYYVJsqxaGYgd+TUEPswKqkT4H6Fv7bLASgh1hXoVhbTTRQKVLVdiVPFhlQekU
         9XLYGZf1mFJmHdRN82BQ/wJHuwP0s+Hr0OE1IgHt9urSwoOdaCxu+nw9jT+exb1x3svG
         OuRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795095657; x=1795700457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PzR8EHqO13mERGH6qlAcIvdtNywH2LjT8NBNjWxU6Bo=;
        b=qaSm1rm957ZvEpKLHEu3a8jTbK4seazOPDh/AUU509i0lTsYRTCoT+ZEfjPAB+wTPQ
         2wNm7RD5ESiUCPKKW7DaADuUPN+Nq3tHBRxAE7ooK+gIJXxfkBsNE6ZiUKukYXrCZLqv
         CBVj66hX5LFHIbWSg4qOiGJu81YFoBfSMRVwUkFw7a5QMTCbODKaL0pRtDTe0jZ1Hbso
         +AW0ioGD5Vd46Vhhdi4nIw2ZrWbUytWjVPAkum33Zn/pXDduOQm/V2EKkh1MiR2Creig
         3gX8VC5Ui6N6L7+u2QZvknTvoQanH5MJng45fqKoWJKskn2CCABwSoAi/YQ6K/bmLkXX
         XrFA==
X-Forwarded-Encrypted: i=1; AL+hErEixfoBDWDvjh9o4GAGXECkw5t1/LbJMFiZgKCZFbcxchk2CnhMXqdFdmVH/eSMAF5j8LG0EnFW4Jo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/y9Y71/7kDPeUzBr5DOLWPK/0lFF2hsPovhnd7WVZ9Eu26EVTx
	rTGBp0AX5oqs4YQvnMCqN1S61xJnvV8wTrx8CBARHVCYjIJR2pmy2kWvFop3Cw==
X-Gm-Gg: AYBFou2pOxof1brPSLBslj7jcHAnT8BJFqekRUtjHCmpJRrcxPtd+YYIlwh/QHAQPWi
	gslnM8vCN+Z8LOHn1RmbfP+3p1ejqnIwCrovo0t+qTE0XY5J6Ap3qFISRteagQPtmfYXIbyrYX4
	uFlWzRKHL0drMLcrnxYBX6l5k225HF9GlUq8i51NN7QOV21O6cmN0IFRfmYZNfWEtkWuK+3ltpJ
	Rj7GmF9QLrxDFoJaiFQZm9vrprrxV95zR2qggxKqEn/A3Vs7YlP0adg4Iylm8loSagbmnuHOU/U
	JGgNMBV4uxDv2i40fWFOe01pwB3D4SXnzHzxMZA+SBgrPjxi9JqSYnvlY8B7Gn4zd6BXz2FADoR
	XTapZrAKKdIZyBEwvT39kC9aXF74fxuoZeS1HPvHx99K+tBa5Ik5eDmCfjjnOylz6dD6HaOAbsI
	ZLmuZRz8sM90myLQZl8/Zl+glCQr0SDnKCTegzaIVPRJFag8wgmtTcIVTxO4ALmP7x/Z7YFZuEC
	TmF6YezsRZCEvmm9BV4HlAHWb701hHtXF5QWtYezNxjL/dmJtOAac9eHpNx4yyQTbwsQcj3qhTy
	kFqCddSeHRRNJzK4lS72u92To23zIqOOzQsdchuIQoVhgy2UeU6Bh9UUUPcH9m6QxS9Xs4FFOew
	wcfQtF47KiktCeIQxg04=
X-Received: by 2002:a05:6102:578e:b0:7c8:78bd:fd7a with SMTP id ada2fe7eead31-7d6db9e66a3mr319517137.25.1795095657332;
        Thu, 19 Nov 2026 05:40:57 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:a13e:f40:91:660f:4d51])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-99e4a240ac5sm4134862241.7.2026.11.19.05.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 05:40:56 -0800 (PST)
From: Fabio Estevam <festevam@gmail.com>
To: lee@kernel.org
Cc: maz@kernel.org,
	andy@kernel.org,
	jic23@kernel.org,
	dmitry.torokhov@gmail.com,
	linux-input@vger.kernel.org,
	mfd@lists.linux.dev,
	linux-iio@vger.kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	crofts@kernel.org,
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Thu, 19 Nov 2026 10:40:38 -0300
Message-ID: <20261119134041.16611-1-festevam@gmail.com>
X-Mailer: git-send-email 2.43.0
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

The interrupt descriptions added during the conversion to YAML do not
match the ICOLL source numbers used by the existing DTS files.

For i.MX23, Table 5-1 of the reference manual maps source 36 to touch
detection and sources 37 through 44 to channels 0 through 7. The DTS
lists these sources in that order.

For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
15 to the threshold interrupts, sources 16 through 23 to channels 0
through 7, and sources 24 and 25 to buttons 0 and 1. The DTS also lists
these sources in that order.

Reorder the schema descriptions to match the hardware documentation and
the existing DT ABI.

This change was prepared with assistance from OpenAI Codex, which was
used to compare the binding with the reference manuals, existing DTS,
and driver ordering.

Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v4:
- None.

 Documentation/devicetree/bindings/mfd/mxs-lradc.yaml | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
index 782b2f4005a0..755029880677 100644
--- a/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
+++ b/Documentation/devicetree/bindings/mfd/mxs-lradc.yaml
@@ -87,13 +87,13 @@ then:
   properties:
     interrupts:
       items:
+        - description: touchscreen
         - description: channel 0
         - description: channel 1
         - description: channel 2
         - description: channel 3
         - description: channel 4
         - description: channel 5
-        - description: touchscreen
         - description: channel 6
         - description: channel 7
     fsl,lradc-touchscreen-wires:
@@ -102,6 +102,7 @@ else:
   properties:
     interrupts:
       items:
+        - description: touchscreen
         - description: threshold 0
         - description: threshold 1
         - description: channel 0
@@ -110,11 +111,10 @@ else:
         - description: channel 3
         - description: channel 4
         - description: channel 5
-        - description: button 0
-        - description: button 1
-        - description: touchscreen
         - description: channel 6
         - description: channel 7
+        - description: button 0
+        - description: button 1
 
 additionalProperties: false
 
-- 
2.43.0

