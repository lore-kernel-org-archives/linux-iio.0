Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39BA36C592;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780418032; cv=none; b=YV7yFJT/4FcGDfBjcKqya1x4aZuL8z8jShhJEmhUEX4N7wn3cetuq3pcvnwpW6AWDx7/ZQBCMAQVtCetCW5UsROziIwPLG4KBGB9szp07nvjz+Pb8BXjDN47MI7M+jCLus2ldaTsPFx/CGaVa64ygHWF9vkLONW+gyJafmubRfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780418032; c=relaxed/simple;
	bh=xMKqcbaROw6imR2IrvvgY6v8Sd1HK13DJfnlNymxGhc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=HlERApwukXERvXb/yT2kfJbcd69WHpfuAAFpZ724MF0gf0OBGiuT+9D20mMG7hPQgKOShxeEUv6g4PEGlJWoWSpy58G74OB3gVX2BBIudH9IAKR0AX7oyoaQoq5O/bFTe35YoAyTTbHfDYi7utRuR9/u/26PTo+9DZ88YWPQVCE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRnwiEmN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRnwiEmN"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6D469C2BCB4;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780418032;
	bh=xMKqcbaROw6imR2IrvvgY6v8Sd1HK13DJfnlNymxGhc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=WRnwiEmNr+qUWFQcp3HprvWQAtBy9kszDayZ2v0Tq1FwTsOvu6Czea9hcM7ghwn2y
	 Jhb5fvOSFzt2PatRkYF1nVjVdmYHDAWufg91zVsXQjpKLqszt9NrkDOX9+WJPdCp8V
	 nQ2KF4I5YZDpyWUWRWwOKvYMOVnis+RGh3ZJisNpssSH+SvTvSJuTUTcN5NhzWdQGw
	 72qq7r+h+7h8jJYCDUGlFHOu3qaeWlgs/Rf8Y7PHsZveLTn63y9Fk8SDJPMtf1G/uJ
	 6Y78d7wHKSfAW8EmvnMA6gBLc9VzhlU1dsi3I+En3IRPF6fiRGelwaZP9uHzmIjYDt
	 nLnp+LyFTOiQA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A3C0CD6E61;
	Tue,  2 Jun 2026 16:33:52 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 02 Jun 2026 17:33:49 +0100
Subject: [PATCH 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260602-ad5686-new-features-v1-2-691e01883d27@analog.com>
References: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
In-Reply-To: <20260602-ad5686-new-features-v1-0-691e01883d27@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780418030; l=2331;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=VM8uU+sbzNkXZ9pYeXkANlRpKN8chnD0VXo09VsEx34=;
 b=WAqADsMtZ1/nb+nA5zkqFvMUOU2PtbfmgiZ+e3KQRlY2u9nYhbgMvyPGTIcECefCyLnZkYBoo
 /6ob1a8iUUqA2IkrPSt/qKHdSO7evo7u3zPD/7AXiYKzsC0V7UExKJn
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add supplies for VDD, VLOGIC and VREF input voltage pins. The vcc-supply
property is deprecated, once it does not really exist as none of the
devices describe any power input with that name. VCC is also misleading as
it sounds like the input power supply, but it is being used as an external
voltage reference, which should be called VREF. Certain devices require
vref-supply to be available once an internal reference voltage is absent.
For correct operation vdd and vlogic supplies are required.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 31 +++++++++++++++++++---
 1 file changed, 28 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index 2dcc049f30e9..e5fbaec4adf7 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -33,9 +33,19 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Input power supply.
+
+  vlogic-supply:
+    description: Digital power supply.
+
+  vref-supply:
+    description:
+      Reference voltage supply. If not supplied the internal reference is used.
+
   vcc-supply:
-    description: |
-      The regulator supply for DAC reference voltage.
+    deprecated: true
+    description: Use vref-supply instead.
 
   reset-gpios:
     description: Active-low RESET pin to reset the device.
@@ -55,8 +65,21 @@ properties:
 required:
   - compatible
   - reg
+  - vdd-supply
+  - vlogic-supply
 
 allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,ad5693
+              - const: adi,ad5694
+              - const: adi,ad5696
+    then:
+      required:
+        - vref-supply
   - if:
       properties:
         compatible:
@@ -83,7 +106,9 @@ examples:
       ad5696: dac@0 {
         compatible = "adi,ad5696";
         reg = <0>;
-        vcc-supply = <&dac_vref>;
+        vdd-supply = <&dac_vdd>;
+        vlogic-supply = <&dac_vlogic>;
+        vref-supply = <&dac_vref>;
         ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
       };
     };

-- 
2.43.0


