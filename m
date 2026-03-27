Received: from relmlie5.idc.renesas.com (relmlor1.renesas.com [210.160.252.171])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91B6537C11E;
	Fri, 27 Mar 2026 19:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.160.252.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774639565; cv=none; b=ih0RESFrrp506xrt4lKmE1qr8/75FpAKAOSQqtMsWZPJI0R9cNit/qaucKVPArTibdBn3Xehk5Pqwv2qRKrMHjo+MI92xLZAFMrc/HZRWx8BRmSLroJdVhJaK7i54WTInWJdbQhefQwZgS5uNI1Wit3O6W3DsC0BpgLVC/y+8Cs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774639565; c=relaxed/simple;
	bh=yEvuaB8ffjRTYjgdYXLkjKKb4YiN+zeBdEHcqNocKCk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O5EzqShEHUhFcQMarY7uQCV4+KiuApiI4fl7Oqtl4WFPp5/s8clezdA+sVFQhScc30q4rWxmQDTQmWnRbRNQwwBaTviJIELOTbOtqOHGhgAfyTJuyLQlyyT/47HIQexlatfHYbj8HnHm3Gh2qAE9AnhHfl6Tn/I8lsGDJ3TQdKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; arc=none smtp.client-ip=210.160.252.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
X-CSE-ConnectionGUID: cuGr9sI8SauQWH7G9OEeUg==
X-CSE-MsgGUID: ShQGxZWVSjewgcpCA7pifA==
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 28 Mar 2026 04:26:03 +0900
Received: from demon-pc.localdomain (unknown [10.226.93.36])
	by relmlir5.idc.renesas.com (Postfix) with ESMTP id 138EC4015D6E;
	Sat, 28 Mar 2026 04:25:57 +0900 (JST)
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
Subject: [PATCH 07/11] dt-bindings: timer: renesas,rz-mtu3: move required resets to conditional
Date: Fri, 27 Mar 2026 21:24:21 +0200
Message-ID: <20260327192425.438263-8-cosmin-gabriel.tanislav.xa@renesas.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
References: <20260327192425.438263-1-cosmin-gabriel.tanislav.xa@renesas.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Renesas RZ/T2H (R9A09G077) and RZ/N2H (R9A09G087) SoCs do not have a
reset line for the MTU3 block.

Prepare for adding support for them by moving the required reset into a
conditional matching all compatibles except the fallback one.

Signed-off-by: Cosmin Tanislav <cosmin-gabriel.tanislav.xa@renesas.com>
---
 .../devicetree/bindings/timer/renesas,rz-mtu3.yaml | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
index 00cd5cbcf6e9..4623f6cddaf0 100644
--- a/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
+++ b/Documentation/devicetree/bindings/timer/renesas,rz-mtu3.yaml
@@ -231,7 +231,19 @@ required:
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
 
 additionalProperties: false
 
-- 
2.53.0

