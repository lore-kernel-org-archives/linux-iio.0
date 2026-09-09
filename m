Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 595D9577E5D
	for <linux-iio@vger.kernel.org>; Wed,  9 Sep 2026 15:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.161.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788966277; cv=pass; b=RAUxf7KLyokg363MDGffkUcoZVv/zgDVMkAegN968xQxztLMEKt9k4FhEgp8hesuwteKhsBGultFVIb3jF3Afju2C8pb3ijlkNZ5GQLPZlukx3kMPg8tvuACJ3X5o7bg+unb3BcEV6jbTZEO+lOwmxKTPqHzQQzZmvpHffKanps=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788966277; c=relaxed/simple;
	bh=U9knPo6p/2xLEVyt8CjUdjDIRZX4yEwqE/qKt1LDz20=;
	h=MIME-Version:From:In-Reply-To:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FAtARqGyn+EUciCOfWRo+1g7y7789njEiwRNUHdjEGVOyt+OplSOjp4UVrxukitHh62BtuWlnZZNDZeXbP1M5QnmMZSpduZvaEPW/qrunQGdQ7oiJ8oyNLcxcKTYLt4Q945vVV470hgV1OaDKRfbJXiUI5VQ8xOTp1XNX/ii/qE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZLPlQfnA; arc=pass smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZLPlQfnA"
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-6b1b9c3af5cso4831413eaf.2
        for <linux-iio@vger.kernel.org>; Wed, 09 Sep 2026 08:04:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788966274; cv=none;
        d=google.com; s=arc-20260327;
        b=faGxX1wulvUih25TiWn6mI3y7MkPaaOnyO9ERonob9UCYUN+Eq00576rihK4oyv1TP
         UgZmACtYWZmD4vAUq/nlZygNBDF1xKwZ9FbNy+WGQFD2V+oGXZVUqS7I0niGKVTxKO2i
         wD7qwZf4hULrkwsFv7Drv8B7Vng2CS4ONgn9kkdad4ssee4ZbOKe+DZWW+uDA0WaK0ZT
         GHELt8DqdvQWc1JLy4ZXLJ2AcI2qpIIDem5MSA4AMju6bZFJGmMMyJqGJs8ODpWBHLlV
         uP28i5zNO4OvoanE/wUSuMP8GIK63H5ZRNFpHecfHLjXO4yKpJSp8gpE8OKtG+FSuDB2
         3sbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:references:in-reply-to:from
         :mime-version:dkim-signature;
        bh=c49khVQxrcrrH9RLPrVBMjgMScn97uDmz2gB0YQQwyU=;
        fh=tXEfRYcXoxx6Ccuc+DamLlnbZgUXbVWnxanP5/0d2y0=;
        b=NHfPhmhqMYrvKoX+zOvjA3mhwiCmsjrMv9K5rfZVMftK7ccxrh63UNgwRvThQ92ybh
         9T8mQn4MD+Exd1kbW9Npe8ZoCZWQrp1smgLs1AvAq0Tv8X+kooAOmtsXcohO07eCt+fP
         43MhX2nxnM5wAu255wUd3IXPrRk8dODY9o2Ygmwc3h6yh3QnzYmalhJYAZLIlQ77Wpqu
         Je68RDxrgcQqbUZp0L8nVkcqUVTLA/cu/aLT0IVrRBuGXUbZtryvI1UEW9W0J8JANhTV
         ciu9/5wx0/CoCMY9Viq9xWgR06daHYGyCGjXeafi9y21iExRqeCnIoY/c72HVxtbLi23
         LbBg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788966274; x=1789571074; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=c49khVQxrcrrH9RLPrVBMjgMScn97uDmz2gB0YQQwyU=;
        b=ZLPlQfnAlt0lm9ztZf7OG7v/t4qbjajhcQK7x77emyaBtqaoS2qH5ltqhTOtv8FbX8
         f9W3DEJgytR2KYbTf9mH758VTJ8PkfN2Wy11z67h+UMrzOeMWsUSlsgBOKVcUXDucfWh
         HWbWikRBqKCGFwspjjujlBHkP2EZLNxQ25YZs/nBw2KwaiudPQ24Lbb3Pys1tYwJTv4w
         dbz6aYD9RcxQnmSKsao7sVPpftC+EisgmBqfiLdJS3UwT5qEpi3ga3gOUSy6I1dw/0zA
         celuHT8xE3BIfY8CEE2g7DrL9vUPpv6oBkD1TaIqfHl1Opdx8Gn8j1H3y8642lIbQMe9
         fFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788966274; x=1789571074;
        h=content-type:cc:to:subject:message-id:date:references:in-reply-to
         :from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=c49khVQxrcrrH9RLPrVBMjgMScn97uDmz2gB0YQQwyU=;
        b=FQodrxpN+zOCHPUvtwyUhCmbDNxay/173zDh9umxnH2ZTbMFE94xV6994aJKApQrNn
         mBRICc5FtmoIuWASdoHO4tzjmXxytSGCCNSNFCqfDycjMoenBLizouaYEt7lSOmxHytp
         QhME8WN6xwnkbCYhDfXV3mB0EQgPyw34iGMgC5YKPs4DV7eXkFVUU1gIdevV976/M+5i
         emkX4rVyeOmxC2ysBdlM6EQOZOSw5o+af+wbclQr/ekGWN6VuNKxVq9FiSK5B9C+XStv
         t1x6R9usiRFK8Bv9QADMxTLjgCHKaKH4yPDzEGCeCNYg2uKwAla94HsdFj50a2qYkolS
         8nmA==
X-Forwarded-Encrypted: i=1; AKwUvBx96qrKOAOca5nkznYWfrfoQar2uA2Oubqe/RRBj6Te9YwmS2SNDSX+Nlmemt08cWLhlfx+oJdyvio=@vger.kernel.org
X-Gm-Message-State: AFuF++ndIwklp1nyDva71+YHNFZDSv9RVD/ZB6Y54aizhN9TjitCAtX8
	WkuSMJOcTUQMCeneid6sFqjxq4doNrfNdALDcoGyUlDuAkLlrmn9hq0Pmn1PTAXZUGeav6O7t6N
	CgzqYD21yROIzOFWj4nZiy2ZZV3nsTFA=
X-Gm-Gg: AYBFou0L8WyhTmumpL1UXWfKJegENf87R3qfFFNJfdj54tvWickwlubWV3mxGk28obW
	1m1NEZC9nA4V0zc3cg4Y7rNZwtOwdUScvHhDTLeoCNXdo1mwCYN+AKkaoeLALZOjpnLhundvk+S
	iwhWu25BxZYBaxp66nlTHj4n+ZA6xmxsmovfjS2QtjFpzzZ1hmfhlE9X3zSQVAxVK+iSmUw1QtQ
	71mUsJGhm7oKXjU8Y4R2iwBDQSNC6Fy8+lFSc0EQf5cZ7bkxsgrqYoqcfzl4c7GRXqCFMnHHT2/
	ZiFRzY+3luolp4cqLbQ7ysv39jB7fzJOKR057SjuwUA6OXPnULV+V6fgh/rhzbhvyuYLwmRsD0w
	wiAebH9NTKLiUEc8cYlFM/eHycU2VQMwy6XWZWw==
X-Received: by 2002:a05:6820:4ccb:b0:6be:31b7:e684 with SMTP id
 006d021491bc7-6be31b7f404mr2736324eaf.34.1788966274062; Wed, 09 Sep 2026
 08:04:34 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:04:30 -0700
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Wed, 9 Sep 2026 08:04:30 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Jinseob Kim <kimjinseob88@gmail.com>
In-Reply-To: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
References: <CALMSewJPfQXRX5q4X3gJf=LT6m2FnusTM=DBiWsBqRFiyNP_Gw@mail.gmail.com>
Date: Wed, 9 Sep 2026 08:04:30 -0700
X-Gm-Features: AcwNN1XYs9GTk3zlIcbnA3lnOyqdq9oaXAcxw599RIPrGm1qpMGnH9zSuQWNF6Y
Message-ID: <CALMSew+q5W1LWn5suOt+uADfoWwoJJvT36Wv34E=Xbmoix+eKw@mail.gmail.com>
Subject: [PATCH v9 1/5] dt-bindings: iio: add Open Sensor Fusion device
To: jic23@kernel.org, linux-iio@vger.kernel.org
Cc: dlechner@baylibre.com, nuno.sa@analog.com, andy@kernel.org, 
	linux-kernel@vger.kernel.org, rdunlap@infradead.org, joshua.crofts1@gmail.com, 
	u.kleine-koenig@baylibre.com, julianbraha@gmail.com, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Add a binding for the generic Open Sensor Fusion host interface.

Open Sensor Fusion devices report capabilities and samples over an OSF
protocol stream. Sensor channels are discovered at runtime from
capability reports instead of being described individually in Device
Tree.

The protocol version is discovered at runtime from the OSF frame header.
OSF GREEN is a product identity, and OSF0 is a wire-format magic value,
so neither is used as the Linux compatible string.

Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Jinseob Kim <kimjinseob88@gmail.com>
---
 .../bindings/iio/opensensorfusion,osf.yaml    | 52 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 MAINTAINERS                                   |  6 +++
 3 files changed, 60 insertions(+)
 create mode 100644
Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml

diff --git a/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
new file mode 100644
index 000000000000..3998390828cc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/opensensorfusion,osf.yaml
@@ -0,0 +1,52 @@
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
+  This binding documents the generic Open Sensor Fusion host interface. Open
+  Sensor Fusion is a sensor aggregation hub. The hub exposes an OSF protocol
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
+    const: opensensorfusion,osf
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
+            compatible = "opensensorfusion,osf";
+            vcc-supply = <&vcc_sensor>;
+        };
+    };
+...
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml
b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ba2002969373..0ec4e481c64b 100644
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
index e033f2d564d6..ff09899bd645 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20511,6 +20511,12 @@ F:	Documentation/process/maintainer-devicetree.rst
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
-- 
2.43.0
