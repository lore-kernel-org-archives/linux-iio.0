Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2762A38E5C7;
	Fri, 10 Apr 2026 16:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775839031; cv=none; b=rTqCHCgGAkVDrEG6B1dh+lP3K1G0k6uoeUUsu14DvVOgVVjusDaQvEp+raOMog7QoqfjRAhxxhlDTUIR3qwPwrREfN24XqKoyCAw+QLt/CdiDFxQbIii1fEUFA4HczLS+WDT5VtnLzqbI+ICvQcA1Qtug1kLydUga/xl/yPtZyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775839031; c=relaxed/simple;
	bh=VwE7p5Fpurcfv4ZJXM3hEQCsN1CiDSExRQKVg/6EXdA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5actyk5tSIcCyt/1oH6wJI4h4+I14w+mpmJhLvqA/KeYIo4TJb/JTPZgMO+i586UI+d6LX7hT6fG2HE0j8p/R7xedtNnuc/ocV8P9aUz4PWfvG0RqxRBoS0fFv6WxPJ8//3NfvsatWH5c0jvTlqbBPXzMPEe4k5oYXwm9IMuKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: x7NnH3vKQOelpyIX2Ey0LQ==
X-CSE-MsgGUID: LWrc2InfTMSlrYeelmhTGg==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 11 Apr 2026 01:37:08 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.85])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 77A5B4006DED;
	Sat, 11 Apr 2026 01:37:03 +0900 (JST)
From: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-iio@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org,
	Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
Subject: [PATCH v2 07/10] dt-bindings: timer: renesas,rz-mtu3: document RZ/{T2H,N2H}
Date: Fri, 10 Apr 2026 19:35:27 +0300
Message-ID: <20260410163530.383818-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260410163530.383818-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Compared to the previously supported SoCs, the Renesas RZ/T2H and RZ/N2H
SoCs do not have a reset line.

Add support for them by moving the required reset into a conditional
matching all compatibles for the existing SoCs. Disable the resets for
RZ/T2H and RZ/N2H.

Document RZ/T2H and RZ/N2H, and use the generic compatible as a
fallback, as functionality is the same.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---

V2:
 * squash "move required resets to conditional" into this
 * disable the resets in the else branch of the condition

 .../bindings/timer/renesas,rz-mtu3.yaml       | 19 ++++++++++++++++++-
 1 file changed, 18 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 00cd5cbcf6e9b..ecff2912d812b 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -112,6 +112,8 @@ properties:
           - renesas,r9a07g043-mtu3  # RZ/{G2UL,Five}
           - renesas,r9a07g044-mtu3  # RZ/G2{L,LC}
           - renesas,r9a07g054-mtu3  # RZ/V2L
+          - renesas,r9a09g077-mtu3  # RZ/T2H
+          - renesas,r9a09g087-mtu3  # RZ/N2H
       - const: renesas,rz-mtu3
 
   reg:
@@ -231,7 +233,22 @@ required:
   - interrupt-names
   - clocks
   - power-domains
-  - resets
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - renesas,r9a07g043-mtu3
+              - renesas,r9a07g044-mtu3
+              - renesas,r9a07g054-mtu3
+    then:
+      required:
+        - resets
+    else:
+      properties:
+        resets: false
 
 additionalProperties: false
 
-- 
2.53.0
