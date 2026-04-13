Received: from sonic317-21.consmr.mail.gq1.yahoo.com (sonic317-21.consmr.mail.gq1.yahoo.com [98.137.66.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7813540DFD5
	for <linux-iio@vger.kernel.org>; Mon, 13 Apr 2026 00:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=98.137.66.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776041037; cv=none; b=hNE1xB1Nu4v1y0+B598ka0ssNV5qwm7dAhJ9U2ey/PZfwW49TOu37u6DMXXwxlpKf6uUaxVEzasg5tv8av+vBXeDStW7U3c2FEThb3wxmpBUFdkJk8fvAD4S8o57pEHC2TS//FBFU1HT/N5HEdK/LvRkDUufiG+cqUjYjYQUj4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776041037; c=relaxed/simple;
	bh=DvcdHr5WV7t2vSg6J9ISv6gWSBfoWpAGpSBhtnTPK5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:References; b=ejF/0Eqku7XKeTTekRgxSMlxgSaZM8iv0ph3HBgNYwJNP17JiiJPzVpjcbxdj7cgD5pNBklS2EpIXsF9k8EXTSAfaMCTcHY2SWS5KpTz3haBC5sj6a+rqmDThkf8WHtbopeJ7rtoG6K28bF3kK/RDb6vkYeywiLMKDUaIn1Ubtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com; spf=pass smtp.mailfrom=yahoo.com; dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b=WDEizSnA; arc=none smtp.client-ip=98.137.66.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=yahoo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yahoo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yahoo.com header.i=@yahoo.com header.b="WDEizSnA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776041036; bh=CZlO7FMM9s8j+IpZHrd2gBaWbbjNweo7kmcN0jFoFvY=; h=From:To:Cc:Subject:Date:References:From:Subject:Reply-To; b=WDEizSnAWCiZqW5Siunhou62+Lws6RqCjSr4C9085L5NrzsvFVYcQxbDitrnN14EHvHiMRQoL2hwkSOWHb83ocu30atNhDDkIizP03r10Pc+Od2hwK7iGYv2ApfZupgnBq7YdsiRmJxI3WgvvRs04u+d6Evv2pHQpwX+o6gnpPb76ncljftR0LU4moMEDjC++/fNY1cGxvS8e2UNUu5RHjxGJd5yobQLBDaJqDr3qa+5GOo4gQ2aOuu4GPCc/rulAh7k8MczySGptuOUCP6bcgLLiyvVbeLcbTedaqRjjd61D6zgUbf7FFiF/gN/m8j+acjsu0Xo0Xeph6R/CDJHFg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1776041036; bh=bT2iHb6QnnDPoxz6ml5rpVkpk/Zs8jiXFXlUK0w2GPj=; h=X-Sonic-MF:From:To:Subject:Date:From:Subject; b=SXLGklyjwNGiczVMYIZ5dNQB15rqF8FW/dScbOgB/74ggIFz0hmvSAebXzCDRoMCPgQ4sgRAfBTqa/ifhhrfNm95CT5FOz2vEMil2K6Aa3UWgpdXAGDsIfgJXWScizFZO7YBrzb6cniyioT3nGJj4WIvNnLHDjrzluhGfJVj7tuVjCAbdD1oSe3lJ12xVpWqbqqR5HvN/YJEns4mWwn4jr1h25ZEVIdKcu7Q1O6jPoPCNQ+FmKjCH0J9oPTj2rTQAVagcr5yCvOmZQimQuKb3R93efxxnEmSqBEE17x/peNDieNhOapROQ9fgDTLj3+qnsoZxIXNCPA9gThGbKjTpQ==
X-YMail-OSG: gEoLZzAVM1m2f0jSnvkvaKc5sMh4nxHOSNily3EaJQEcxdWuL9LXRBa247AaMut
 bGElM3ok_A_ZDftuL3NEdq6kbIzb07mR2GyUPrX17kE7jcm_PgYBc9OpC7vWomAB3JqxfgJRSXUs
 r2C0_bmsM_raCj5YJD1thpBEKEue_KmXFyMwwB3M5zUPAToKekCnYt2MxHleLt8PnWHpAOzRGdoE
 5.hQF6mjGyRzhZJQg_7dgn1wY7cjkpDoHfKY6YychrxWGqzov9y3E2N2e5yD9MuK5p1xGGipyQ9a
 e6yBmRqj4PVCbNXqCFN15hCZrL3Kt4faScayt6wZoam50EcE56vK9BEGm5ipe5WYcePMPjBOakBT
 iF44t92FoAvjYU3C6Vo7av4jR5gHzwy7QnvV3sv750h8MFpcWi0MPWTIXHFiXyKKeS.iE9yZOqnM
 B7.boJa6ENefh5RWE5zY1ayHe6lMcXDPzIq3CPK3p7EFeRsaxmSNkh.31EmAO5zAR14kKxYh2lDs
 agw9jrJtk8j2HLbTDn_RTtwm6PauqvsF9.uN68DbHXPeKh_yp4GOEbevz4UI4j97ywd9FlfVQ9Yk
 owHEHyDdIJeR9YcSZnbfTbts4AP7p.VF9qPwpb35EIAaaNtqL32.3Vf1zXf7yhffFCZNbdC5dp1A
 KXrKdwH23zcall6mJvpGZiH00GEIGL0itZ5y4W9WKr_nJ0nQ8iOCD.Wk.eU7a6dGZEMfIHX8EQW2
 M9QSAFaVFDJxJsA9F98YyQFDedIFXMiBs4sz7xvcFfCbJI2rTLlihZxQ7_Fdcxoxjt0Y1cZrcYuq
 A.gy0yBDFKFlYNKlJCCkFCR6I4oXMm5jUa6GrjkWXiFU7.PrfeTD2BJJcav6IqGQLmSE0DIm4k_7
 jlAGTO1NhQJdg__js8vPdgclO4huMLaG7IPZv7ffxbyCpb0aApiTLhu7ssrHmSiEdFD7bFMEeSOq
 .0Q0APbpfeHGDsh25vhALu6K5eWg3JLJUXUuDDD2z1irH7kx.GxepUT8RmIcZr_Brlx0i_ouJzZ.
 IH5HOiBTu9eb7n1YA9RvOIsMXvy.2_gufndkKBSSR8hX2FRmUj7DTV0LD20u7XFs_pVproIyyBFI
 hJNkKBoKeSt7SSzAJgPrdONCEs43B32vgI77ogNmtACHjXGCSWgwcWKiTFM0TYoWgV.ecVYr18j5
 h8ENm3knA_u3Qr_8I2GYFUxKazYo.wdXhF.utT9DtWWogBQXOPsFDWVI_3CJ5UNYtDD94F7G17av
 fsH6yqCEDl6eK7LYkeg4dPDDndJk_xWNRqp5B5gR8JUzt.PEhgVGfZstZDPqGlIW0SZsj0Za0L3L
 SqJX2Of8kH8OqrCPqDZJ3.Rjzswy6jL3qzcLQtUJefzNd7.GX8o_e7BUhfLVXwGxet44js1aeA2b
 vn1y9hayb0UY8LsDzoa4hz3fn8P0q_Y5gvd5RQcU3fIqPyeAOu2GYLCgrWAFRnD0ryFtdkPDFD7m
 PCHrmpRJxlv5Lq63ev0zOkYvZKK.RmbM3GYONKf7X6JO1TErID1Yz2Jc4ShC44x9T7xOWI.rc3hV
 5suzlVXKxThn3XgnqNpWa8i5YZEu9uQY3vhxEpHeU2vyRG7tUwDRlPJFNV5y0cC_ruoGP2oz40QQ
 8.RdMJBOt.ISy9hx4LVT.1xBqmoW6Fu2YnjQwbjJZBjVaOkCAPxN6vCpCn5U0p5PLyDq.lobZ5G_
 JuUaCJY80JCqmTG0xJR.fo.aK3FHfq_vFbN7LfSlkMGvcc_CMfKxJWNaNWKlQNfVncTCqo2ydAs1
 LO7_zGpAUCb.lUiZ.Iv4psWkxfIJkBvAjoRmQeOnNn..bX0XZNppczECymDy4BwmKQQ.BCX7aZuq
 dH1Ubu0PtPhx6qHDWE.z6OB4fNcsXwYAwCqUTK8Kt_fswC_jwbUYkoya55wA97kiYtYwxfijaFQ8
 4is65fBUo2jWRBEjiSZMDXEe8LLJVR9Rmkai1iv0Pj.vsPrilGnjqj76oX10aKpSjODWvGrEh4YR
 Ak.betLV2nhnTON1nKGKjjnZ1pl9EM..RLZvudMpLY_KEPsv6a0EVE4M2eB2o0UTeiYzkuU_mVoX
 GoY8NqI4gdn8RlPZOCDiaqaudkQLB.EOjktJVjByLbQG9hpn9RPpOKyhS_9dIBkOF_IMtEVYvun8
 GdMz1PUbwpK1YR7FygHJUV_Hsi.FdgaVsqYGo3ERzxu7QTznJNvGPrh4i0U8gT3Pu89Bmpj.bj81
 5KPejwP6c6t_E1L2_19oUT7rMoogiBNkipcuMSlnLUgPgvWutj2D8awLG0qaa8pSdEGcDsRE-
X-Sonic-MF: <sainiharpreet29@yahoo.com>
X-Sonic-ID: 7cbd3f3d-fd25-4d4f-930f-a7370acbd5ca
Received: from sonic.gate.mail.ne1.yahoo.com by sonic317.consmr.mail.gq1.yahoo.com with HTTP; Mon, 13 Apr 2026 00:43:56 +0000
Received: by hermes--production-ne1-555c74f9db-72v8p (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 298e7ac331929bb0df4f7fbb414ef451;
          Mon, 13 Apr 2026 00:03:23 +0000 (UTC)
From: Harpreet Saini <sainiharpreet29@yahoo.com>
To: jic23@kernel.org
Cc: Harpreet Saini <sainiharpreet29@yahoo.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Marek Vasut <marex@nabladev.com>,
	"Kael D'Alcamo" <dev@kael-k.io>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] dt-bindings: iio: light: Add PixArt PAJ7620 gesture sensor
Date: Sun, 12 Apr 2026 20:02:55 -0400
Message-ID: <20260413000308.7618-1-sainiharpreet29@yahoo.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
References: <20260413000308.7618-1-sainiharpreet29.ref@yahoo.com>

Signed-off-by: Harpreet Saini <sainiharpreet29@yahoo.com>
---
This is part 1 of a 2-patch series proposing a driver for the PixArt
PAJ7620 gesture sensor. This patch adds the Device Tree bindings and 
registers the "pixart" vendor prefix. The driver patch will follow in 
a succeeding branch.

 .../bindings/iio/light/pixart,paj7620.yaml    | 48 +++++++++++++++++++
 .../devicetree/bindings/vendor-prefixes.yaml  |  2 +
 2 files changed, 50 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml b/Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml
new file mode 100644
index 000000000000..301816485fcc
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/pixart,paj7620.yaml
@@ -0,0 +1,48 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/pixart,paj7620.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: PixArt PAJ7620 Gesture Sensor
+
+maintainers:
+  - Harpreet Saini <sainiharpreet29@yahoo.com>
+
+description: |
+  The PixArt PAJ7620 is a gesture recognition sensor with an integrated
+  infrared LED and CMOS array. It communicates over an I2C interface and
+  provides gesture data via a dedicated interrupt pin.
+
+properties:
+  compatible:
+    const: pixart,paj7620
+
+  reg:
+    maxItems: 1
+    description: The I2C address of the sensor.
+
+  interrupts:
+    maxItems: 1
+    description: Interrupt mapping for the sensor's physical INT pin.
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        paj7620@73 {
+            compatible = "pixart,paj7620";
+            reg = <0x73>;
+            interrupts = <4 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/vendor-prefixes.yaml b/Documentation/devicetree/bindings/vendor-prefixes.yaml
index ee7fd3cfe203..d73a0bf62b62 100644
--- a/Documentation/devicetree/bindings/vendor-prefixes.yaml
+++ b/Documentation/devicetree/bindings/vendor-prefixes.yaml
@@ -1273,6 +1273,8 @@ patternProperties:
     description: Pine64
   "^pineriver,.*":
     description: Shenzhen PineRiver Designs Co., Ltd.
+  "^pixart,.*":
+    description: PixArt Imaging Inc.
   "^pixcir,.*":
     description: PIXCIR MICROELECTRONICS Co., Ltd
   "^plantower,.*":
-- 
2.43.0

