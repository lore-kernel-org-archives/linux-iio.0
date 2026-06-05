Received: from outbound0.mail.transip.nl (outbound0.mail.transip.nl [149.210.149.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFC703CE0A1;
	Fri,  5 Jun 2026 10:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=149.210.149.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780654137; cv=none; b=oMFyJafBgXChQnkH4WIJ/PbWTDEYVbLXUTPteqJNFayj3fdWVze2hgzUmASnYP/DFnWwHl/X9mhUuPrLLh/x/botdA7n4bV0ylmjUEFTbatYRrKGcobT8D/CecrWyP6ijyEOAjuPVgdGdJBfvkbpoNtkYusVo2GhJC9pk92JX34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780654137; c=relaxed/simple;
	bh=tC0kyB9BK6SOo8GI5KsOX8ZAJbre+gCaY1tRs4yAu9c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SYyCXSeAJ0mG+NhrnNu0jH2ccfO5XdCfya1ga6sVpT32gG6BdggsOVoPpOu7P41VIlcsH/2Va6Uw5hAabX3BouKu99B39ztiYM91/6DJd8sRRA2PSkKwczf3EX4HdZQA2uyJWFFHeucDk3j8A+Yv0o7mqp3m2Y+GgtwDGrTOfMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org; spf=pass smtp.mailfrom=herrie.org; dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b=I9ipa7eX; arc=none smtp.client-ip=149.210.149.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=herrie.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herrie.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herrie.org header.i=@herrie.org header.b="I9ipa7eX"
Received: from submission4.mail.transip.nl (unknown [10.103.8.155])
	by outbound0.mail.transip.nl (Postfix) with ESMTP id 4gWxwZ1y2QzxPMS;
	Fri,  5 Jun 2026 12:08:46 +0200 (CEST)
Received: from herrie-desktop.. (180-93-184-31.ftth.glasoperator.nl [31.184.93.180])
	by submission4.mail.transip.nl (Postfix) with ESMTPA id 4gWxwY4fB1z3R3p03;
	Fri,  5 Jun 2026 12:08:45 +0200 (CEST)
From: Herman van Hazendonk <github.com@herrie.org>
To: jic23@kernel.org,
	linusw@kernel.org,
	denis.ciocca@st.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	maudspierings@gocontroll.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Herman van Hazendonk <github.com@herrie.org>
Subject: [PATCH 2/3] dt-bindings: iio: st,st-sensors: add st,fullscale-mg
Date: Fri,  5 Jun 2026 12:08:42 +0200
Message-ID: <e49aba850b1f48ea00089e7142c00584541001eb.1780652883.git.github.com@herrie.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1780652883.git.github.com@herrie.org>
References: <cover.1780652883.git.github.com@herrie.org>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: ClueGetter at submission4.mail.transip.nl
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=transip-a; d=herrie.org; t=1780654125; h=from:subject:to:cc:
 references:in-reply-to:date:mime-version;
 bh=XKJowAeDiAVcG9eyEc4OrgXmXamMxeJkeFMuCHuDvPw=;
 b=I9ipa7eXR04FsMnaejEeS+uFMjFLferYWZJp11sDc8yzkxUXENdr8FAKHgn1R1UeKkaWce
 VV36qtAvDiCuKMvI9J+773yLDinRxAoIaNva2isYzbFzH1K+GzJGzTFnCbkPNEjBzOLEiC
 pDzFcgFdNzNGUUIib6dHWdCBIu3C/GeDHd8ZpKAkza0D1qZvFuFoJYvT79ns1Gpn35YnEt
 duM3KhKrW11mUb8LbnuQxkBKPXLHouJt9mX/5pKJdS5vcLfuvPO/rp1lgqo7kHNdEPQ3ko
 YLMw1hBnPhf42XctkXiZ8TheYVbYy9mzKKaN8i7Ur1fOUo+TVdF8oCDd/sU/nw==
X-Report-Abuse-To: abuse@transip.nl

Add an optional st,fullscale-mg property that selects the initial
full-scale range of an ST MEMS sensor at probe time, expressed in
milligauss for magnetometers (and analogous engineering units for
other ST sensor families that may grow this property in the future).

The property is purely additive: if absent, drivers fall back to
their existing chip default, and if present but unsupported by the
specific sensor the driver warns and falls back. No existing in-tree
DTS is affected.

The motivating case is the LSM303DLH magnetometer on the HP TouchPad
(apq8060 / tenderloin) where the kernel's chip-default +/-1.3 G range
saturates the X axis to the chip's 0xF000 overflow sentinel out of
probe, because the chip is mounted close to surrounding power planes
and picks up enough DC bias to exceed the smallest range. The driver
core hardcodes fs_avl[0] as the starting range, so userspace cannot
recover without racing the driver to write the in_magn_x_scale sysfs
attribute after probe. st,fullscale-mg lets the device tree declare
a wider initial range up-front and avoids the race entirely.

Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
---
 .../devicetree/bindings/iio/st,st-sensors.yaml | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
index a1a958215cdb..335f38e9f78f 100644
--- a/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
+++ b/Documentation/devicetree/bindings/iio/st,st-sensors.yaml
@@ -126,6 +126,24 @@ properties:
   mount-matrix:
     description: an optional 3x3 mounting rotation matrix.
 
+  st,fullscale-mg:
+    description: |
+      Selects the initial sensor full-scale at probe time, expressed in
+      milligauss for magnetometers (or analogous engineering units for
+      other sensor families that may grow this property in the future).
+      The value must match one of the sensor-specific full-scale ranges
+      supported by the chip; if the chip does not support the requested
+      range the driver falls back to its built-in default.
+
+      This is intended for boards where the magnetometer chip picks up
+      enough DC bias from nearby PCB structures (power planes, ferrous
+      shields, etc.) that the kernel's chip-default highest-sensitivity
+      range saturates one or more axes to the chip's overflow sentinel,
+      and userspace observes that axis as permanently stuck. Declaring
+      a wider initial range avoids the saturation at the cost of a
+      slightly coarser quantisation.
+    $ref: /schemas/types.yaml#/definitions/uint32
+
 allOf:
   - if:
       properties:
-- 
2.43.0

