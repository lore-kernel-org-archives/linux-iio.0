Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32257367B6E
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 23:14:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791760485; cv=none; b=EuHPH1VkXnWhhW4Im8Q416Ft+yPZo0xCV4HRe7cEl6PBRuTz8t/hvHjBcOcyS9OH4uNKIkeWmtBD/N1iVl4IRlgG3KQOSVkEB0QmOjt/PO6yS209qQ2Gc7u6dd+FqrR54B6ZA22wxtxBMLZIIWSRabn2M+hiaqeNafaNgoMWvCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791760485; c=relaxed/simple;
	bh=mY7Smke+Kwz6EOpYsROmGVCMz5vFf4N6N8Iv6WYNPIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JGoJTVThDHPuTpDaOJfL1/KEZP9Ca837ynejAXacuha3jPOSm4VlIHp6x8qcMQxLS/xl2mY/RicOrlr2qiNyyKTNSH/CYfZPPRmxy1b6Pp9Gn5PuPpxxULipucnFoqFoEkXJWAgMiXC5UuvHOhoJNy5Ae5k7ZmfhUHaz3HKfojs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EjDIH5Fq; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EjDIH5Fq"
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-884062f3296so922853b3a.0
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 16:14:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791760483; x=1792365283; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BFBIQXoG2aeGkZzB3O/CnVUwpPtY8AGILGw7slNAgvA=;
        b=EjDIH5FqKkwkZGkN/wIOe6mir4IU5XwjRBX+NFeRwSrdZYhKJ4b60FnqNF045a8jYG
         +EfEpf+EhT/YLCNuBNPPBVCFbQT48cPFgsEWCaUkuzPovlg3eEw/IrNQTckNKM2BQKAZ
         +D30gIGEVg89X1RORSGp4hRFcbYKo9X0A90JWGTgsyOfCFpoONWzfCbIwxNDlGpZ/5vW
         djsNeYPpUH141jB/YWDywZfOsIVB6oDNhQ2wfGP3VgX6EIeHMuB60ckpWgHbkoCSssZj
         YUlzBGVMVQ1B2O9QnEH76ytsVLTXG6SBLwfSPbPoVCPkPVBJ5iYNKGTJ0MFDgsXJ/TnP
         Mi9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791760483; x=1792365283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=BFBIQXoG2aeGkZzB3O/CnVUwpPtY8AGILGw7slNAgvA=;
        b=Lvys8SQv0HjR6Oah/NIEfwqsNmwpujSAPQjNfWustOEnbBTQMUgEKuEjXw7FpJRzEE
         qCPf6IBIzcbA80CQngljDDj6LFuyooCmDJdDA6kNSOnqVftzVJl7L80fjbiGkYIP7CMx
         7ns9Y6imA1t4ZeR79GsQGMZbMk/iQxKn6XCoC2C3ajvxKY1wxSrrrM81uxP+EJvKl2Ls
         tX9obGlU3h5cVJf0bzP5Yfue4mTY/JDpyw6eAbFO1CojoalnIqN6XRtd5yIBXFsScz7y
         gEXbmyabhK5Pb62vljPCWb5QKs2pIRPiRgArbRTeCp9JlssKLtRf5dDeOLJaDUXRbYGA
         K8/w==
X-Forwarded-Encrypted: i=1; AKwUvBxwFPSQs9xrSbrFn63OGjGU1r8rQcI6ld1GfajtD3aJpEdRRyFXUPuTVZ9iFgj0XIp61f+yX/O4QxM=@vger.kernel.org
X-Gm-Message-State: AFq9FYIYddSy9DE4a8YGPMnmgkjydB3rGFwBajgIvTisLZ69+jk30JnU
	tDpNla/K7Q03Bto2PKmgWWHCPe/5yfwUqkMCx+f8dqwVbXMpB8B9pcpU
X-Gm-Gg: AYBFou07uMNFOJfwluDaesa62jGR0RdFNYPHJVRPEJLo88sNnuJcBO2Ji9Kmht6cef8
	mxK0Mj5pdwlWj1+lgCSm3GumN1J5GErrokpCDHZbMqQgOWXM4ifGbMgCQzIJhIr0//EGSbGsD/K
	Wgij46sw23IH62c+Z2FT110aBqEf4sOCwlN1TtmAyXtvOCXmcOYeSe4ygTruP8XDhu3jzrI+OtL
	ij7yWTcMjs1TgaTIINN5bbBPOtp2fIyVONaeSS+5qqlcZgC7yA/HPw8XW9UXE1JXBO3mHrFPZSL
	Bn2WOhXdQiYjS6+5vLBiZLcjeHND6nsrL8AgVWWeHlJL0KAgFoCvJvmuK73AOvJsM3roHvNak0d
	NX47c1Uyu4lMJepkMbkeoycy8N/Ts5Qx4FRAbbAXH5ZbR3YjczXwQuq9t0rZQN7qQl2wwErRrX9
	57HoqTMYUxb+6P+VzlQoLkQK6H6oqyqkexXO+zY0Yiq9TfNyynAMVvnxybKriiZIo6o4SX9CH44
	3IkMKigpflXg9+SmyAL2ANvUWBplWsdNyDx7Z3tRfZADx7Ex8WPZJ2sYuvMwox7zFjzTjKUySdY
	ygziPeA=
X-Received: by 2002:a05:6a20:e68c:b0:3e0:e513:3ceb with SMTP id adf61e73a8af0-3e16beacademr6278189637.53.1791760483534;
        Sun, 11 Oct 2026 16:14:43 -0700 (PDT)
Received: from DESKTOP-G3E0OSP.localdomain ([58.224.60.243])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-896c48945dcsm3188917b3a.54.2026.10.11.16.14.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Oct 2026 16:14:42 -0700 (PDT)
From: Jinseob Kim <kimjinseob88@gmail.com>
To: jic23@kernel.org,
	linux-iio@vger.kernel.org
Cc: kimjinseob88@gmail.com,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	neil.armstrong@linaro.org,
	andersson@kernel.org,
	prabhakar.mahadev-lad.rj@bp.renesas.com,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org
Subject: [PATCH v11 1/8] dt-bindings: iio: add Open Sensor Fusion device
Date: Mon, 12 Oct 2026 08:13:33 +0900
Message-ID: <20261011231340.42885-2-kimjinseob88@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261011231340.42885-1-kimjinseob88@gmail.com>
References: <20261011231340.42885-1-kimjinseob88@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Describe OSF GREEN as the current hardware model with a generic OSF
host-interface fallback. OSF hardware variants may use different sensor
configurations. A model-specific compatible allows future power sequencing,
errata and quirks without changing the common fallback.

The current Linux driver needs no GREEN-specific handling and matches the
generic compatible. Sensor inventory and protocol version are discovered
from runtime wire frames rather than encoded in the compatible strings.

Assisted-by: LLM
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../bindings/iio/opensensorfusion,osf.yaml    | 55 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 ++
 3 files changed, 63 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml

diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..c180c6e41008ee9443411a88c234ae1c19b8de2a
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/opensensorfusion,osf.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Open Sensor Fusion Sensor Aggregation Hub
+
+maintainers:
+  - Jinseob Kim <kimjinseob88@gmail.com>
+
+description: |
+  This binding documents the Open Sensor Fusion GREEN sensor hub and its
+  generic host interface. Open Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF protocol
+  data stream over its host interface and reports capabilities and samples for
+  multiple sensor classes. The actual sensor channels are discovered at runtime
+  from OSF capability reports instead of describing them in Device Tree. The
+  protocol version is discovered at runtime.
+
+  Public project documentation is available at:
+
+    https://github.com/opensensorfusion
+
+  OSF0, protocol_major, and protocol_minor are wire-protocol details
+  exchanged in OSF frames.
+
+allOf:
+  - $ref: /schemas/serial/serial-peripheral-props.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: opensensorfusion,osf-green
+      - const: opensensorfusion,osf
+
+  vcc-supply:
+    description:
+      Regulator supplying power to the Open Sensor Fusion device.
+
+required:
+  - compatible
+  - vcc-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    serial {
+        sensor {
+            compatible = "opensensorfusion,osf-green",
+                         "opensensorfusion,osf";
+            vcc-supply = <&vcc_sensor>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373433b1f48118872c46cf7bcfff276..0ec4e481c64bc0aac8937c4fbd0d96dbb359b0fb 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1267,6 +1267,8 @@ patternProperties:
     description: OpenPandora GmbH
   "^openrisc,.*":
     description: OpenRISC.io
+  "^opensensorfusion,.*":
+    description: Open Sensor Fusion
   "^openwrt,.*":
     description: OpenWrt
   "^option,.*":
diff --git a/MAINTAINERS b/MAINTAINERS
index 3a2dfd1a4fd84ccb068332035f054ac77dada814..edae5bf594fc3c72fb39e14b797c7b2eccc11471 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20537,6 +20537,12 @@ F:	Documentation/process/maintainer-devicetree.rst
 F:	arch/*/boot/dts/
 F:	include/dt-bindings/
 
+OPEN SENSOR FUSION
+M:	Jinseob Kim <kimjinseob88@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
+K:	opensensorfusion
+
 OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
