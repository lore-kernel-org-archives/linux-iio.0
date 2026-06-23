Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F413D0BE7;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782212160; cv=none; b=rJlwRqxJ3eXWI2j5Qw6SyQ+BnGgUJN4BrrFBTICvDm7wjtxg58r5t4Rc9FZIv3U8EcS2O8rrBKwlhT4wFDocZDYlT8mY5CfH7h2tuYwKXUY+nv9IWRmdr3MsRMFL00eE9/7RNFqTwVkqb2wnnZyoQji8580Pzv1z4Tu4EBHKtnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782212160; c=relaxed/simple;
	bh=x2GL0GsNDsjpB7I7H/5ycLEWa7K7jpFlr1IN4vmfFi0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=flQPrqkX/F12Eaq1PzOH3wJCvxxNIWc4n5OhQa8CesQBIgtBHpbhyx9WbMJyUEi1rLnDFlKkR8yMqBP+AoS3ggyA86cNTPmBjlJxWvWgmy6dUJopkfIkVCd4AsV4r1JRejFViIkWe4L9pijLQBfqt/mOx16rDQW36GH2qsqFtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bMfzcVMj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bMfzcVMj"
Received: by smtp.kernel.org (Postfix) with ESMTPS id AA2A9C2BCF5;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782212159;
	bh=x2GL0GsNDsjpB7I7H/5ycLEWa7K7jpFlr1IN4vmfFi0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=bMfzcVMj4NlE5akOO/89LKYpADN60JhaoRk3tvGa+YnAvb4lFnNuH/yG5NR6krUeV
	 KGvlJ7fJw0EKLgQ2Q0Byc1DOtl9z5HHE0vrJPgbFejVYg6q+R9AJXXo5hkYj/dyeLt
	 ztynfdrOMoU1nMvFUqSS5aVfxZWazZtNBDg+tX2JtRB4+bLZszqXdctI6OjnAaqF41
	 +knR9c5Oq5IDFfBN1Pr/pEtAHLYtkrMXzzodlkDkNdE8spHIL3uvO4eXGelGvDFnIq
	 /ECB5N5ZRSP9E9P+hmltNSgCx6/TTpmqmG6E+7nkNB6JrR5PFRweu+Ys3JkaaRzQk8
	 m7sR6CgObbmfg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96928CDB47D;
	Tue, 23 Jun 2026 10:55:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 23 Jun 2026 11:55:42 +0100
Subject: [PATCH v4 02/12] dt-bindings: iio: dac: ad5696: rework on power
 supplies
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260623-ad5686-new-features-v4-2-28962a57db0f@analog.com>
References: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
In-Reply-To: <20260623-ad5686-new-features-v4-0-28962a57db0f@analog.com>
To: Michael Auchter <michael.auchter@ni.com>, linux@analog.com, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Cc: Michael Hennerich <Michael.Hennerich@analog.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782212158; l=2556;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=M2ZxcKplq9dYBzPvJ4Kk2806O8GaXfgsF0JAQRB+TJs=;
 b=Tj/qTi1p5DdFHOViHzZH1raVk/h6R+VDZAk2oeiBbIpA2PdTF+ZOQyih1xOkcf0iLY09umcmJ
 X/Ut76t+787CqjfQZjNX6+9xky+lhGpp92hA/Mku9IPoMpIwvW2Cl2f
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

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 34 ++++++++++++++++++++--
 1 file changed, 31 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index cc343cdf6085..e10f8596f9d3 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -33,9 +33,22 @@ properties:
   reg:
     maxItems: 1
 
+  vdd-supply:
+    description: Input power supply.
+
+  vlogic-supply:
+    description:
+      Digital power supply. On some tiny package variants for single-channel
+      devices, this supply is internally connected to vdd; in that case, specify
+      this property with the same regulator as vdd.
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
@@ -62,8 +75,21 @@ properties:
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
+            enum:
+              - adi,ad5693
+              - adi,ad5694
+              - adi,ad5696
+    then:
+      required:
+        - vref-supply
   - if:
       properties:
         compatible:
@@ -90,7 +116,9 @@ examples:
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


