Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794722460;
	b=UZRtHCGPPRtiDrKSPocb/COlDYUMEfD39U+vUQcQ38HbWYxfx3Fm2FX2Zj7zLQJx4Dm3
	 VBq1+fS1wLafRw0/9V0getrtUMe8SkwCDNEf/oKBqjvITKtkjv2h/0yyXbUFNnenh6jNh
	 dOQzifdYls72zMTiRNemu4IDEbrrUqUzK+bNiyXkDqyUku+ckvQ6AYIk2k5xja6GCk8uM
	 y4GQ3KsfFSVX4xlE3x4KVWcLhhMalDj98kDWYdgMIJYDlV9gJVKIPnHvXXzfFmhUrSWFP
	 iq+PkeOFcykvxNm0YzWLd64K1Ni5B3QQujNGc82ny2elAToc1xQt+tg3GUwbPGFhavw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794722460;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=sikHWDwwcHY7wUeIPuVUS6zZeaVy/rjClvTT+uODGBI=;
	b=PdHKkR9XDtKrUcj+8kJezSX88fBeEYtmiB+IX3CecPdOfVZnmeA6ABPjmEOH6yvt4/y9
	 UU8WeU4cct9AzQGpU3JbDLahSzVKAHhLvt3cHlKydRoRKum94p14kBzoYEb11W887JZCU
	 LnaCN/SBSfkxZwQ5GNLnBfF3ewyuKstanqeaWMLS2jt9TK7sv78J7ZF8se1EvadhVZBaa
	 V3mP8zYTVuNQDUWJjFX0kBOn7ITuEqgLsjXv0u+WMOulflzoDVbOe0or5u5dce+xuPUTT
	 qUvYaF9ppsUO2gPVUH65U74haOA3/e6LaFPfEre8TuUfhH9GNl+QnW4dotmdRNd1Vgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AySxjepw;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28FC9606A32C
	for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 06:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 28FC9606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AySxjepw
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3b15e46698aso2033809a91.3
        for <linux-iio@vger.kernel.org>; Sat, 14 Nov 2026 22:00:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794722459; x=1795327259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sikHWDwwcHY7wUeIPuVUS6zZeaVy/rjClvTT+uODGBI=;
        b=AySxjepwHPZGrkDowx8EnSp0zug319xmkETWuYn3bTpq+EJxJPH8yQzwb5pM3ylK9B
         gYXAjXO2Ext1+uLYbWbvqjgmPkZU5jdcaycLY5YywGhRiUPhxmtgyQ4BLBYT9tbSoUWI
         tJGYwNglgEhpmpzLLVsVz4e97SGWd29m5t+Qomh3OmnE+IPeOkAz0gTAqX6K2x1+7QJS
         3yiymLWvy/Ntm4Wy+NL8A0fYUvwI3iGucJuHSqHnYHnKgRVp6nhsYJszB73g5Ibpnx7j
         pw4AakxfKv0N4lqIslG4XHtKThmecL1u4zYQVryifJbNWYtUa5QmHWoBMDOyLCUxadIL
         Z2/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794722459; x=1795327259;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=sikHWDwwcHY7wUeIPuVUS6zZeaVy/rjClvTT+uODGBI=;
        b=z+xtYyqr6NI5zmL4vkcN8ap71qlADPp++CbF/ZHYUxVH9ZkzoEdkbL7Q27JLFbHBQA
         SQkOw8cmua72+usTAcLAoCBAi5z68y4QaOKQpoMujyZ4oJEIH/S9IsjRzj5qJiSJzvEx
         cXRVpjobiQHpdgBgTfj2WRpSPMKsmssFW2eA+HwDXUq3QYuen6QgMjgEcv/sElB4Du+R
         CsNjrR6NnKDbW5qR7+zlTDMWiostkwUrTE/30xehtb3JnmhLmtrpIQgQeVNhFAxG7jyd
         H0yTN4NBi27Wp+Lick1e+aEQme6+kfYtUjOG7HyuHb/Cjup/LY0QX2OIdJ4YnAJijr/s
         VSJA==
X-Gm-Message-State: APuU4Z9Vp6Q55DacH1dUMA/Am1CzKY2/moOHpHstLolGjuhedHBRnMv1
	ZdXpc1L5ic5CMUnEHfDlNR6D+p+J7SKm2BIfR4rRGhZydcSbrHpomj7kH6coMDfl26c=
X-Gm-Gg: AYBFou3vv9I3bGuqIZdCYQ0TNVh+FgrjSLCTDNXyAGETFKpju/s6PF53LCFl2Sz+uLy
	CTexZOikdASdYdQlUQ0LjxSne1yytmsbWvVeUA+QPMtQcXTXzXG0U7Pacte5R6Mz+sgYl22+LYj
	yuB/Z6aw1COoXVXxXAYKlwW9hxKJulFa6vPszEgzI2oVdYmr25rOGD6v/+DWJbWUcAArfQVtLIw
	ZV4fTaRKkh/HdyHI3r2/zIZnDLaGmty8RQVbMdwu8N+4hFL/Rl27o795QZ3z/jR2rgrr3JcdGIl
	2unrjl9lr/z7IYgJhyG0FCXCpqnaIrhK+nz/kmREQ82k8GNFQ1e/yznMLNzs5nh96TTGUBdJbjo
	0F+A71ReJe7pnqws+LpjxWKm8e44lSHsJFcLvG6GMLtnFXdocu6wbwpYWwRsYVm5XNSKxbUoARP
	5Sc04vYMktnISmq6sQ0R5XWYHaQDDQGSYGjnQvwehcj5YI5qGeH9dSTvACUCDW++0vQJFXqkWOO
	k9BiTXuOhMvaud7tHKDWQ8NpxQgj1MEoKbLuxtCGGtMUIPxYtpSjLQZ3zDjxdIqmVAXd+Ngg+zC
	88J7N9Sp14KrqlhAmqIV15v/1JTawSBfgea0jySKmOY0+DXHeHpgHhz+BxgenoYe05tN1rIUazH
	xhmmKuzcioHfZrfFcegORuA==
X-Received: by 2002:a17:90b:4483:b0:3ab:413:49bc with SMTP id 98e67ed59e1d1-3b1b0a4c331mr6596624a91.37.1794722459394;
        Sat, 14 Nov 2026 22:00:59 -0800 (PST)
Received: from not-op-Victus-by-HP-Gaming-Laptop-15-fb3xxx ([2001:4490:48e1:a6d:b698:9913:39f1:6954])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1aec43699sm10988889a91.10.2026.11.14.22.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Nov 2026 22:00:58 -0800 (PST)
From: Akshat Chandra <notmissinge@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	andy@kernel.org,
	Lukasz Kulga <lukasz.kulga@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: iio: chemical: Add Sensirion SGP41 binding
Date: Sun, 15 Nov 2026 11:29:39 +0530
Message-ID: <20261115055941.362185-2-notmissinge@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115055941.362185-1-notmissinge@gmail.com>
References: <20261115055941.362185-1-notmissinge@gmail.com>
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

Add a Device Tree binding for the Sensirion SGP41 VOC and NOx gas
sensor, including its VDD supply.

Signed-off-by: Akshat Chandra <notmissinge@gmail.com>
---
 .../iio/chemical/sensirion,sgp41.yaml         | 43 +++++++++++++++++++
 1 file changed, 43 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml

diff --git a/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml
new file mode 100644
index 000000000000..28528a695cf3
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/chemical/sensirion,sgp41.yaml
@@ -0,0 +1,43 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/chemical/sensirion,sgp41.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SGP41 VOC and NOx gas sensor
+
+maintainers:
+  - Akshat Chandra <notmissinge@gmail.com>
+
+description: |
+  Sensirion SGP41 indoor air quality sensor measuring raw VOC and NOx
+  signals over I2C.
+
+properties:
+  compatible:
+    const: sensirion,sgp41
+
+  reg:
+    const: 0x59
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      gas-sensor@59 {
+        compatible = "sensirion,sgp41";
+        reg = <0x59>;
+        vdd-supply = <&vdd>;
+      };
+    };
+...
-- 
2.53.0

