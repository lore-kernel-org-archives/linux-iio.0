Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794533542;
	b=qW3W6u0bcW2xcK/ZPb+o/pGagcF0QhP+nP5CdI3lvp/3Bnzr8CGLUt6ZL/h5qiJvqHmw
	 qhNnhNL2x7GdIvFhoWniZSxlQzjc5rqoysbYA7YzahUd7jSTRTh1SBPsF6iJiPaOgHuPu
	 7gjPyBOgvQFQPGSnQ2ahso/CM4Z/Wfhcn2U7Gvduv20bEturJ+lO9F8YMgF7zf4jAtL/y
	 f7qEe1w7nHc2bK4Hhli5OvO5ZSoQswxZg6AEV/kDJUcwGP9E8CYH4nl7ZINz58CGkHtAX
	 HwfZFntXiF9nwwXdlBVxkHetEjafDQywHMhpKOUN1Se/TsofcKhaG3cCaJylSNxhm3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794533542;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9HVV9rxTa8NDtE3CvH1N7rbiUfOat50MeJpUNT5hdrA=;
	b=uTocP0xTsQ6K8e2jSxADXjYC3zxJbsIOKpEcKBF8qeRXR92Wge3aPuJ7b6lPtHGYeNN9
	 G8z94TtAYDoVpZwaq50NbUoZ1SdbQqUiD8HrH7eSHhoWBExqAcjlKECkHZ/wYtcewkGRc
	 9btYcXfEH2Tmwvhsr0mh1eIYm9VXxn2wN6VKQVbo+NCjgJPHKMdLA/gxDg2YVchZoOgG8
	 3y60SX25rQI50PQJLUbSnXsqUctaeRs1sirzNzSEKkjoXnF7czLUMjC432gxH4BDvKpDN
	 vxK0en3TY92z93JYJyk/nhH4mRUhLUZF787W84kQY3AzF9aWRGyyV6FuCKmVxysd3AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hy3qLLrI;
	arc=none smtp.remote-ip=209.85.217.43
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF40606A32A
	for <linux-iio@vger.kernel.org>; Fri, 13 Nov 2026 01:32:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6FF40606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hy3qLLrI
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-7cc603a168fso129632137.3
        for <linux-iio@vger.kernel.org>; Thu, 12 Nov 2026 17:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794533541; x=1795138341; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9HVV9rxTa8NDtE3CvH1N7rbiUfOat50MeJpUNT5hdrA=;
        b=hy3qLLrIRv1BFkwO03rDySamlfl15qA9jnwWfkhmYebEr08ulWyC5RQg7wEwkRCAPw
         3a1/ziPmO1tvE0msm2E2MWJYqKzAihW51iu/sd5T5eXgOo0K3+K8MH1XqPhKD346YLP0
         E4qYDA1nYrnGvdcfJhtl6VEQTI3F+IEfx6STNupxzIQQ5TQE1iWAxPiN4/NljjGbNRLb
         P6KvSXyGkQzsadvVlzZ50eiwrBlsF/Tn1HK1FYJbAW01NyPM61KGqR+GVs1VX//aMtHc
         xN8nHj6UIXPrFvAmxWxXd3xDTTSyuItGgcL/pTV4S5FJsEMSeL9xZsR/7y2B6WSYkiMa
         i/yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794533541; x=1795138341;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9HVV9rxTa8NDtE3CvH1N7rbiUfOat50MeJpUNT5hdrA=;
        b=j78U+owL0yG758EyTxMB1gUQXdQmBjfkEyjN7paIEwA24bgv86BgbEx16XbZBKufCc
         +EYolDSWyHjYL4wDukU1eG1FCfjWncWStjzkGDjV0rUEMTUwBi6bOMX8gpuzMpY0DLML
         UsjwF1aYNuI5PXDKSuJ7bO/TreMRPQhR5aFqpTdzXXJqxINjX4qd98stsOnQn/7/SyiU
         GWTgfhkU1pHZwZxaWUKZoDzmK4EsgVmBtwVJbSkUZ6nVR3w/rTGToHQSISAMLI7qHDH1
         gUwnhaCK7d2u5aD6cxeeijvBLUZYJqlC/zCCA3IqJNr9aLeXP+ItpRDcGP8p714zkCDx
         uX1w==
X-Forwarded-Encrypted: i=1; AL+hErEb+EDeVk64IaaMMzdVilfK4sSUGDUms/zLLhWEpCYRA9PfRNxxzpyKV4RGWzwvmzY+wTuwdvTaVjc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8B8diEvCyhl2o70h2mxoS/+i6cSS6EvL4KE+NPeud8mhByVJj8
	NULj1OZpK96BLaQM9UIPqdUReV+pqClm42cfi+VFnNrr9gy7JZDdGZbG1Gsx7A==
X-Gm-Gg: AYBFou3VvgMWHL4SNl6/CFyYe6Sw2lF8+NMdDbz8Es2MHHNuLynWpuJZ0ff5ymDdRYL
	IuOZzv4lnudve0DdSn+5UBIUCg3TZZtvIrjblnfccadTjaKD5HAkaD2vg5eajJzdsw3CydEkxUc
	ItZDAV0ppMdafJjUeaKpsGvqHzBxS7Aa//vCcv39EeCuoxSU7lcWxwvt+d8tn+R2/OZLgfqtEo2
	b0i5gWYsI2gLebqKtNAc433lDZB6lGbuOtETrT2LtAqZWZWtLlIEReIVTZR6gc8nBuz8dDxOCc6
	UUIwIvXu8ct3zqTSCQR+qMzanVjvqOR1ldlQf/rO0ojn2giByslAJ2VRb9A+hE4ES0rcfdqWB7o
	I8NlVF61it0BvPvv8LcHZDpa9ss2KSg7lWGxacsLWwCY11Ul2YuVz+nmMrG3UJeLhm+guRuLY/T
	0Yu9/OJAD0rq1Vz134Vd3ANRCQj+SdpS/+D1/QLQ19ygk/l9n86TWi+3F41QoG/cGl575Av/84A
	fQ+GUhNIbVbZAjJe8l+K4P3doUCMFyMoI8pSnIyt/8GlNEi1VgYLD2UBe3EBQiN8qs2xPYtusOx
	McXMASJimQ+x3+74MQiljIECKL7VcumFn9lJLb1X0AkWkcNSUWvPRpSYPMHYjUyiQ5fcsdQ1mTN
	QEt4hXC3lS8vIi1LLbm29Hw==
X-Received: by 2002:a05:6102:a4b:b0:7cc:1192:563c with SMTP id ada2fe7eead31-7d64d770298mr297767137.25.1794533541329;
        Thu, 12 Nov 2026 17:32:21 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:4b16:e82:1dda:bfc3])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d64be7e2e9sm796166137.0.2026.11.12.17.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 17:32:20 -0800 (PST)
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
	devicetree@vger.kernel.org,
	imx@lists.linux.dev,
	Fabio Estevam <festevam@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v3 1/2] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Thu, 12 Nov 2026 22:32:11 -0300
Message-ID: <20261113013212.470981-1-festevam@gmail.com>
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
detection and sources 37 through 44 to channels 0 through 7. imx23.dtsi
lists these sources in that order.

For i.MX28, Table 5-1 maps source 10 to touch detection, sources 14 and
15 to the threshold interrupts, sources 16 through 23 to channels 0
through 7, and sources 24 and 25 to buttons 0 and 1. imx28.dtsi also
lists these sources in that order.

Reorder the schema descriptions to match the hardware documentation and
the existing DT ABI.

Fixes: 009528b5aa13 ("dt-bindings: mfd: convert mxs-lradc bindings to json-schema")
Signed-off-by: Fabio Estevam <festevam@gmail.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
Changes since v2:
- None. Only collected Krzysztof's tag.

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

