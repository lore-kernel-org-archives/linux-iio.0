Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320434;
	b=xcS/cYwJl1I4HVppKUdsFscY7EpQl8lyyyT8OqiilsR6ETn5fgeJ62h4JdMjjh5vPapo
	 pwc2sDwZr5Nv0Uwm7HWZNirufSsVCoXEsOAhruDPuTq202mNXob/gCu9ClTU+Jn2wEnrA
	 8SGT0esFAfJfBlKD23A7lTLHZfW0FvQ8rx09HkaxeIHu1OCwP2v7WW+h6CZvRovRxCs6x
	 oOcYZIeRyG/mBm8UvHmOrdN9gOXIHndFqA3kUQhBIa53SsftALyK8hsburXeElHsDv6zS
	 Q2t1imNc/IRj+rLnhXmKuGeEEA+KON/WxnDD8s1E7UJ0ifv2CX5aYOcxlStmV5FAJNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320434;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=pjjNjXW/DLhm8uTgpvdp1RvacwHSWzmRlnWHV9BPT4E=;
	b=rvl/6URTuB3FiDn5lF4/jwmq7atBHWoww6CShFpZjB2CBiSEDvnZCivqnW8z4oh+oBIS
	 D62X7hlJaiHowloRGWJ5a7HUFYYYvN4Jie9dvGAQBk4DFaMkhEEs/TPat6JSN3Scr0MMb
	 YkQqqevRIYabiiBUwRbS6EmNIZG04wgIDsj2yjRmsr8vzN6jC2Iwfksh3wLByOs5dlNMZ
	 Co039UWLz+KnhrzvZ3AFwuQgB3aeiXF/tnLsDLRASATJHMdOgOqtWW7hY82Qtn8e3T43p
	 Ggtre5NaIm5zMy1lDFkbPv4kUglehOU2O4dQGwppZBhbutW3YT5RQrPmThie917LfEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDICeYXe;
	arc=none smtp.remote-ip=209.85.128.172
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5455960A382A
	for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 14:20:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5455960A382A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=IDICeYXe
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8b349d21fd1so15316667b3.2
        for <linux-iio@vger.kernel.org>; Tue, 10 Nov 2026 06:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794320433; x=1794925233; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pjjNjXW/DLhm8uTgpvdp1RvacwHSWzmRlnWHV9BPT4E=;
        b=IDICeYXehUCODeb6gf08r5i2r/Lverd0wyvsfsCYPyCpfVRD2EBgtWpUnwoAar6XRO
         wgxoDhY0VKKJCAv7zWsmxzdskVr1R+CNe/rqFPIafdLl0x1F/sKJYx8uEr7TnUk0zgTX
         D+7kqoaEUnsT5V8dnYR3PsOlr+dI0Osb5bDhYC7Tvc7W8eOeQRSEYmWMcBHqjAjdSEY6
         j6QQEP7+SExFix5mFuGo4XXctgewthQmFzntr1vFM+cuMQXB2lJTIS6PJMrLlp+Gjjzs
         G8JjPocE3MDl8wvYC3ZVxFwN+O3jiBNNEIWH7I9QHv1JuJxQ/SJBCG4hheXqaTQ35ZLz
         GAcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794320433; x=1794925233;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pjjNjXW/DLhm8uTgpvdp1RvacwHSWzmRlnWHV9BPT4E=;
        b=1DDy5s57ApobKUGalddkS1ZBS81x6XgSZGgRC9Y5cyn0VmwYJTCCQWAjXUUpJOtPIs
         0hhz6vOxgMnCjf2NSQjBOYaTVJ74ApBINYxNnfBqWyMInQ+f2l/pW5tzLuCRuYr7LSg6
         5mUEbMwsIcJXYgrpCdiDeBeqoyDqDqGLVvCYtMPOjQNw4NXAvDqUOHJnAxzyJDwKKRrU
         7reZlzRWVjoWnWkZr5+TfNnduhegYoRLHsRzhH/HX+PEqaSycbtedcIlAUkW7Fi7+tLQ
         evb4IhK4OxO19YNPZtjMwxcID3yNzN0Iuo5CllfEIrFYMtJW+5nHCv2Oud/W6WlMLXs0
         cX3A==
X-Forwarded-Encrypted: i=1; AL+hErE5TNGFvl2SmPtewtGTpCg2ajgK9Pkox76L7o18ASJIbBxyNbw0eaMVjiEAXdrtiOS+LaGOJ5FssFY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/q0lx5ah7J4jLBH0qMsMOE3JVZ8h53hwAlQ0jAtemvcO5E3C3q
	TOLCazmF4qAP37zqjCgcfbY2UpYmS8dMMELQ5pySIP6AoAbcB9Jr0njZ
X-Gm-Gg: AYBFou0nf36k20rlovXaMASgRCZVImHx1m9Ngh2EfYUoTzGYY36Fg2MnAaELrulpkb4
	EtZYbBUdSSEqk95ywD/Vm5tTEKsbPQGkfMTWr007e4/Ga6dw81JEodRPw4dmr0fbZeBA7suIRRm
	1H+ppV9JQ/27DmiZuah/Wts2Wrr0QaG8y0CyeKkPA0vkSGTBDfKYbV3vANf8sNNJ5yADQf++6I/
	dnFG76NKE0pz+EEEBb2n1sX3ooYhyt+TJJMnqdq7nt4h9Aqa1ljAw4OUtZa9yWZvv3mWuQJwVfB
	gOttJ+twrmRG+V1ibM1C+5yA+kTKchLG6xwTNZIzMnKzvC3Rd5ZnpXJTmjE0mbPRlazfFC/NdEn
	cfXxQJYMqRmS17UTKG3dRy8BhgVWEtf0HpB00yk5HkAzIihRkJ7nfsz+ZgMc2dBMhsp6eGeJe4E
	+oE2n3/aBOTPAh6JBQHY8Uw/+hqjj203zz1TiWsNBof39VK/9Pjm6kdYOj2YBO11xXpdmMw+vmN
	Iw73AO0q9p63YKk7Ke/qKdabXjzNoLXCu1y+0Kqv+2CiLc/RpC9kCuBP+j1XP2BOqL7cFEbRjXa
	sScjYp/MK0JmVv7z9dCrulCQQ8fq5ND86oVlK/Ib9Y6Og6OAskLjvxnvN910uVHSdCgzkJTSnEe
	YrOw694v1GyG9Mokknk5apYA=
X-Received: by 2002:a05:690c:c4e5:b0:8b0:4f12:d28a with SMTP id 00721157ae682-8b392c0b62dmr12596647b3.65.1794320432935;
        Tue, 10 Nov 2026 06:20:32 -0800 (PST)
Received: from fabio-X870-EAGLE-WIFI7.tail2bb604.ts.net ([2804:1b3:a802:b7f6:2185:e89b:b285:6098])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67c589a229csm1863712d50.5.2026.11.10.06.20.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Nov 2026 06:20:32 -0800 (PST)
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
	Fabio Estevam <festevam@gmail.com>
Subject: [PATCH v2 1/2] dt-bindings: mfd: mxs-lradc: Fix interrupt order
Date: Tue, 10 Nov 2026 11:19:33 -0300
Message-ID: <20261110141934.42490-1-festevam@gmail.com>
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
---
Changes since v1:
- Newly introduced.

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

