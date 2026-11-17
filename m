Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794895205;
	b=TGG88opTTTv7o4wXKSmsCZic/WBkHXea0TcqzsWmRtDBmR8hv4y9hgk1wZ6E7pCpavtj
	 6SnT6tBDcmv8qZi1W6gea2Tc3Uzz/gFfn1fCUWkJSGYavN7HlC0/JLDlHTKiJCOcstMTv
	 AuWd04cikG1fmwZRqqf6e5SwYbgCSkWdRY1Jk3PGyhlvda9QR0UCLHMS/o52N4ok85hTw
	 vkJtWxilJutvsRL6jFedbJnqxeAP+0ic9GuRn6ndbMPb60i07EbL3bZTFGboDxL8gefZO
	 9CakPoXZD7u71AIYSOY7VoAqhCdIFLTo7b0VkTTJn0dzYQmX6QRyeAq/NI5huSE36mw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794895205;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:Date:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key;
	bh=lkS32XPAkky3Y3UuvpRMfImoXnZGvPVVobvUu9A3i6o=;
	b=lCP3R56+o0Is/VwQEVQLPpbEZn3T6amtCrGR5RqgY1kI26YD+vdKYP2vGRcsmN7PtmWO
	 HbXI3Z2Rv4tSSiqYIISOseoV0jP2+eZLu3ceNgo3qwZ8rZIVGg0++PYYqMWb4lD9Jq3Yq
	 q3SsjTs4hyUXy/qgT66MYXsy2oE5qshO2MPq40bdox6XLelKSM/43w4mEaF5JDsS+DRIL
	 INhglWOG6793GpYZMC2RcaaXdln3V6bBZwUEMjmBZh5zC5i+HM+UZH2FY2zn0Mfh2BYGV
	 6Pv47WGMCwrITm1FGq+gb/ziNQQoxh+zJd68oWbp0smkEt1OVEiSA2eMCoGzOX/0WJQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSW6fmSK;
	arc=none smtp.remote-ip=209.85.214.170
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D2606A32A
	for <linux-iio@vger.kernel.org>; Tue, 17 Nov 2026 06:00:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EE4D2606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=gSW6fmSK
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2e9995ce866so40514295ad.0
        for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 22:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794895204; x=1795500004; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=lkS32XPAkky3Y3UuvpRMfImoXnZGvPVVobvUu9A3i6o=;
        b=gSW6fmSKs8az8HHSrcImPPlh8twk0+ePtltPv5E9/XKh6yQ60ea+87EWBeYgXYakDp
         cl4pL0mAZ4S2Mw3OXFkqXlGJLzUamT3IaMxRfUGZB3IpAfIBF8B9LjRuhbp2bGLIV/P5
         tJlGG6gKf02e95BnNtwnWabddrCmPJ1gEUNSBjaJpTKo4KKd1TsWge1CU7DdCmrOU6WP
         fs257DMVTNXpHyWjQABQaMwvEK80XDuSLtwKdtl9IDYJfWkMzB6YmLWv3WZf0+sFeGii
         J8OR3b0nJY8CVpaVT/VcqhU8kYjYG9XkG7F0p26X/SmQwehaMnIrlqzIndR3GPu3xqJU
         pSdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794895204; x=1795500004;
        h=cc:to:message-id:content-transfer-encoding:content-type
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=lkS32XPAkky3Y3UuvpRMfImoXnZGvPVVobvUu9A3i6o=;
        b=Tl9oKtvzTxzXY+med80l9giCduFRRi4dvt7bvl2t55M3nOj1RqTPwtQz48CAb0eKCU
         w6pLWlzcHVDBW+iDC/nlblBYv6lb07y6WQQ0zPv3xPb6JmoAJcMj2+XzFhMPvjrxkWs/
         wV1YEIcl3ZwA7F4OinuEEs7P4bra+Y4TvExSUW4rTTN3VeI+1wC7Rc6G6/r4ebXbuMlM
         IyIjtIipmOT0MIdymAuJBEuQj42MQk1altedANLK6BDofXOqEbVk40RCTjuuMVHnMubt
         Zuy8d8F4ylnGN/Z/acNIK06+1wyyXoHoOyo1M8Yw/LTgUEpQZWWvAoj4Py39q6qBRL92
         cVPg==
X-Forwarded-Encrypted: i=1; AL+hErEFvqqEDs3yZn6GhTDtbEQrO4+Zu3jf3U7Z/s7AaG7NWXvjQMcCNY+LWixFsNYJgE6jYwJM7Di18t0=@vger.kernel.org
X-Gm-Message-State: APuU4Z96EaX3d0uNhU1bbOeMpcAXFhUMTPQJRMtYlBpmjTzcGPSTxowL
	pKXk+/rIprK+rNSMLYmmuotO8mmbvTZRzmQQQcAK4O9zcA3oqZ/oEINNeW4FDA==
X-Gm-Gg: AZFdTZfwFZ2btHtyJVo1Ecb9B6GrdjY5its+kjkYkBdpt7mhxEVBcsKUCWw6Cvi/2LN
	NN+Q+fr4qlcAyFyN5E17ydL2ooEFBg2FVI0m2kwJIeMw74cL9tsLJe9I0PqwSool2A3gsBWsuCX
	97leB1llCRIKbp/uAAfLICUzJRTolKFH0xCUwwxW5b9wYT5P53xoT52n9MpLHBb9kXlXdmEVGaJ
	h5gyC9Cl8WE7i5UrhThYIfKy3/6hPPKfwxQL/6o33xr2/gnlE6X+lYLvx1zUcLHOt/z66JHx0TF
	v1vq5scPfG2w42u7oU48t6d9QQaMKYZ4v2E/nreAmu9qWQhy8GHmYcQVSdHcf4FXTu2V+l7Vtt+
	Sa/ibi64lZE8iOr0uBRP5ZNhHz4S67x80gjAsXgS9mLYctLv7mEzs3U9wYhbhlhHFWLat1leAYC
	f3Jfr6bBgkAadCCFk/S/C2jtPcEXqVKSIPcj3imzKrdu8wqV/nNA1jpVbiCgRtd0G9nYWlvhLuJ
	maMHPo0Os9DGr7dizlX2XGAcRUwoOvRqzjTv06+AG6bg4hPZmtWerAyrNuNUPTdHtsu2/akqlZD
	bG4LFb/ch41KyfrS3jdRaajBxrCqQFNKoujICFINNrYNIAtMcq4Z+0VxMdrSr4rrt/qh
X-Received: by 2002:a17:903:1846:b0:2d9:599e:df95 with SMTP id d9443c01a7336-2ee0d6600acmr126536685ad.3.1794895204164;
        Mon, 16 Nov 2026 22:00:04 -0800 (PST)
Received: from [127.0.1.1] (61-220-246-151.hinet-ip.hinet.net. [61.220.246.151])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2efd7a173fasm8264435ad.14.2026.11.16.22.00.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Nov 2026 22:00:03 -0800 (PST)
From: Kyle Hsieh <kylehsieh1995@gmail.com>
Date: Tue, 17 Nov 2026 14:04:38 +0800
Subject: [PATCH v2] dt-bindings: iio: adc: lltc,ltc2497: Make vref-supply
 optional for LTC2305/LTC2309
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261117-ltc2497-vref-optional-v2-1-62e9d1ac7400@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHXu+2oC/4WNSw6DIBCGr2Jm3Wl4ibGr3qNxoQg6CYoBQ9oY7
 17qBbr8/ucByUayCR7VAdFmShTWAuJWgZn7dbJIY2EQTGjOOUO/G6HaBnO0DsO2l3zvUQ1OqlE
 PUjIFpbsVl97X7qsrPFPaQ/xcN5n/1H+LmSNHWZtW142ThrnntPTk7yYs0J3n+QVtfMUyugAAA
 A==
X-Change-ID: 20261110-ltc2497-vref-optional-4bf34d6b3304
To: =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Liam Beguin <liambeguin@gmail.com>
Cc: Michael Hennerich <michael.hennerich@analog.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Kyle Hsieh <kylehsieh1995@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2317;
 i=kylehsieh1995@gmail.com; h=from:subject:message-id;
 bh=Wrcor3O6J2UjW7XHhJfIbkXTOnZk7CENzM1MR5U2g1M=;
 b=owEBbQGS/pANAwAKAaWDQrcJVsSBAcsmYgBq++54Vs8iILbLbQM6li8beTDhF8wDz/11oiHts
 1xfJ8LNU+mJATMEAAEKAB0WIQTJHsaNZOdY+THGqJelg0K3CVbEgQUCavvueAAKCRClg0K3CVbE
 gSrAB/99AyqPTsJgRsc3MtdvJ16FxWGikkgo8KkE4A7okDvCiAnQd2QYvvw4J7TVVqHtbJLqRPq
 oTkV0QXJ45MYQ+CzjmvDORGPvbuKg9D1xLnft35neBjUgMFR3cl9u2snKFocW3vAOsKADfKugYW
 to625O7j7Sz+Ppyobz7JMo9iTSkZRUeV3hQqoehJIDAiitr70x9HcwL1eerU5sFPoWdQ60JH2Z6
 hxKY1+TtSDb2m0Mks9yaNn50puIfVloc+0FE3k+2IRTiDOwYfeq0wkezQbDFYHjywQSUKt0y3yF
 nYv/aZP5LiYhgI984COjA0ZHdb06CmJG+quqdG01VKvdanMt
X-Developer-Key: i=kylehsieh1995@gmail.com; a=openpgp;
 fpr=C91EC68D64E758F931C6A897A58342B70956C481

The LTC2305 and LTC2309 have an internal 4.096V reference, so their REF
pin does not need to be driven by an external supply. The LTC2493,
LTC2497 and LTC2499 have no internal reference and require one.

Only require vref-supply for the LTC2493, LTC2497 and LTC2499, so boards
using the internal reference can be described without a dummy regulator.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Kyle Hsieh <kylehsieh1995@gmail.com>
---
The ltc2309 driver already uses the internal reference when vref-supply
is absent. This is needed by the Meta Ventura2 BMC devicetree, which
describes LTC2305 ADCs that use their internal reference:
https://lore.kernel.org/all/20261106-ventura2-dts-update-v1-0-b085ece9bf57@gmail.com/
---
Changes in v2:
- Also require vref-supply for the LTC2493, which has no internal
  reference.
- Add blank lines around vref-supply.
- Link to v1: https://lore.kernel.org/r/20261110-ltc2497-vref-optional-v1-1-35c9657f3c0f@gmail.com
---
 .../devicetree/bindings/iio/adc/lltc,ltc2497.yaml   | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
index 4df5aadd1e1d..93cc163b73c2 100644
--- a/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/lltc,ltc2497.yaml
@@ -47,14 +47,31 @@ properties:
       - lltc,ltc2499
 
   reg: true
-  vref-supply: true
+
+  vref-supply:
+    description:
+      Reference voltage supply. The LTC2305 and LTC2309 have an internal
+      4.096V reference which is used when this property is absent.
+
   "#io-channel-cells":
     const: 1
 
 required:
   - compatible
   - reg
-  - vref-supply
+
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - lltc,ltc2493
+              - lltc,ltc2497
+              - lltc,ltc2499
+    then:
+      required:
+        - vref-supply
 
 additionalProperties: false
 

---
base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
change-id: 20261110-ltc2497-vref-optional-4bf34d6b3304

Best regards,
-- 
Kyle Hsieh <kylehsieh1995@gmail.com>

