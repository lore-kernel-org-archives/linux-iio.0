Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794869294;
	b=S/g2lAIR8f9GgvpLWR76rcGjZmeldEBqHNNJUyVgsCk/vkuFo68+v49QkWjHvD63r2e7
	 FEs6+7mOZJ72yoVlDBB50tf+5QekpI98C/RszM3W/5Fj0cQXcKi/9jsef5Ldt+Tm7jDtQ
	 7Kp/D1JXjSRw3c3GvZuYKUPULUrzy7sWIs9Cper68SSD2q6Qfx1mCGuGRlAQcDdmdDSqS
	 W5EAmsuLDJQP/vfHIEljQMIvFrpe7G3PhNIBllx9SkOe95EhNG9mku54b5rBaaXvwHoZD
	 cbQC9ijynFXBzOiJAYpdM1XGGwH16O6qcRlHqNnNzcgKJlPVDcdh0+KMSRJB5NebmkA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794869294;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=rS6peJ8v9Pm7ofa72f18HTAmcNJmQCcntGCb1eMGOG4=;
	b=d3q3MaMtqqrF32N/pw/hsZKsTehsFThlg7eS+hLAqtHsd9bgbCndFhn6rukcwYb0tz0n
	 YmPtPxDSuxzD6/ic2DWUqyH02hJUA1h0rJ+KBquoUTvvkbkclMB8SeMxd7SKmhEEqj+Oc
	 jh2ASdj3s7wj0MHsmBm7Ayqzw/80huLJiZ05k9kdVt0h7tyLFmCf9WTP+1s1LEbSHefym
	 8zc8AXPTCHIl1prIRi0dZuimnJpYCWPcTSBJ4pkdhqe5AH2iRCdrAPtpAZSlrzxN28x5c
	 A1A8Oc6vYi+w6mTv7Mw+7SRUPf0tfI3K3jL+rqrIHzQtjeksAqvRZIwW7M8mhDxanBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMrP4nhH;
	arc=none smtp.remote-ip=209.85.128.170
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30196606A336
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 22:48:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 30196606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mMrP4nhH
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-8b4d26094beso15346027b3.1
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 14:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794869293; x=1795474093; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rS6peJ8v9Pm7ofa72f18HTAmcNJmQCcntGCb1eMGOG4=;
        b=mMrP4nhHg1WKTA07AKwpAgg+P5/GoShtgNoHJW8UIXeK2rO3d9JAmX4JKmd/efBJjm
         WFicAGY+DZpockrWJhvlo0RmHGyjsgloldDkyWrW8b9C7NvmPPFOUxtKvYG14VT2BY2J
         Tbcv1K63JWRS+c58NnGXfg+k9gikcQo/8HjP9858Riq2lhiAbH+NIjB181LOY5C4FPHR
         tDh3wsxSuCpkkR9q/kx+zMU9PnY6/O1/di7A4RLhifyFNs5LK6EUNhiEyTUYQxy0IVL0
         O1+YWSveYimJuRae6Ck9AKQa5lvbx92y6ZJSV0nCkyts7zhhdCfLqCUI2z9mZBYUjyzo
         hIew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794869293; x=1795474093;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rS6peJ8v9Pm7ofa72f18HTAmcNJmQCcntGCb1eMGOG4=;
        b=NfqGr8a1ZqflC5qSYmZqg28lWqTb8+0R6s0IDyuZJXJNhtCpTSywFdzEc/ALKlFxDM
         BJfTt+TWLi0c6pIuBQr43tveDN5oJCfaenZbRWPg+lPuflUucAURXn1kV85G9X2fKZIM
         gnsihr3TGJW5B/P8fPl4nS/A7+20EV6Q8HX5oMzw3qoVNHEngXJMUiwkUVPT0XK2po3I
         mH25Ag0DbWVis/hGO5dk0NPhMy2QLtaO1fpMQIXfQC9MWwuXvX0r92bbrBm4JZcf8yp8
         MhS7plv+zeaEyMbLYB/+TKgwxUO8kH5fOPsYgTbsxMUioe9G9+Woqb8qlSxJogDRR4KZ
         Jgdg==
X-Forwarded-Encrypted: i=1; AL+hErF/MgAyZa84N4Uj20Rd4520wFlRsssUoFOrRJEx7BjVHf2rJk+6oGdI6aWfh5MQ91Ud2Ppr7te1HsM=@vger.kernel.org
X-Gm-Message-State: APuU4Z9qwN75f2jm2C0d9UEAWGpTvwSuhCjZvIeC07Xp+7SzCpdUOrP2
	E70jreqgXLx0sEuHrZmKGmVqnckWQc/9hmXBqqltLpS+gBVohffSjUG9
X-Gm-Gg: AZFdTZfgxzjjrEaI+pYshI4vGnHQBiYW8AMBggGB+WdRYffQl/c1V3g8pSAaScNyv5j
	NaZwQkN+TooX2lep9Gt/wdy4vUfW2K995d3Fb+HZ3oD5tYFaZn255OZvG0qIPed76txIdyWCb7t
	N9t50AYGP0/YRHZTJB4DeN2sbOL1sADInC2MbPGfnQwL7+Z+mkHP8+7aHK4q6Rq+5yTjtheLWoI
	kq0NS3I/AfLl4mLCTOForpnpt5w+HDHkDNQUXsmuKakG0JqXPXIscopZIQIfGlWGPFPSjR7H6Zy
	spHIwjzkXqTF4Fq2sEjxm7qENoIYWvrT1oNUatTYTgBJ6gAHhu3Bmb/niyir5FzzwoIF9n8zUWw
	mPf2SuVVVA/m7fRbuvvF4vth6nuV1IUt5jE/5nmtOlqJMG574TRA+ZdW+FwMoB57naQoD72xiLM
	LY6/M9cVHV4gbRpPbFEw0FMmHwCCTnsILXQS9kqYdQ/ipqWqFQd+rCzpaM6pf7Ywud7VUemwnft
	xQlw03LZFN2zT0mpRIXFYdTBi9DBSZed33jsTUcpjJ5KgnUfYc1bfQ5DHPSRkswpSt4DJ/Avr6e
	tX6jDorHjbUdB4gZdu1I2zWmEdQy75QskVjrzglAa4a5a4iwKkqsRhHpLtU0EOib1XbnL4hsdDj
	d7qSnYc3CM/+vE2o/3eA04vg=
X-Received: by 2002:a05:690e:4191:b0:677:cf4d:a932 with SMTP id 956f58d0204a3-67d896cf4b2mr5729807d50.63.1794869293001;
        Mon, 16 Nov 2026 14:48:13 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a803:1afe:e1c3:da60:db44:d0c8])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67db0361f39sm5259534d50.19.2026.11.16.14.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 14:48:12 -0800 (PST)
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
Subject: [PATCH v4 1/4] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Mon, 16 Nov 2026 19:48:00 -0300
Message-ID: <20261116224803.61154-1-festevam@gmail.com>
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
Changes since v3:
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

