Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4650A3F4101;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780999991; cv=none; b=ayVS+B3iDM+YK8klofaybKzFGro2WVoDimNTwQVtjIZy2CBu3P19TrkMkscvtjW/fznRQt3LExsSMMmJvAlfJUThbta1ff+XHucKS6VE8VBIE4tREMpCqcdg2Pm9bsRXaG+UrI2xmEWeBL2SxIBM0F+fdzeuOS+IndFuFJi6zTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780999991; c=relaxed/simple;
	bh=VpyNWKEpUs6kC87Yh1bsIzN7Mc90ZiqU1b0YvNZszkg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dVnwhYr+GZ9xTjEUEC5wW6iK8GWFRKdGZTOa95alAsz7ApNbfaouUkv/VCh+qYwCqyvZknbK0cCpBwGjA2hYbvMbqIjjwCNBmrqSxYrPiNFgMGtR5m2+z/Ojw9O2Aj/tCxeizEbqlGwmXVS7P0N8/WbCpynNO8/mVIbU8NVdTyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJiiAsRL; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJiiAsRL"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 04230C4AF11;
	Tue,  9 Jun 2026 10:13:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1780999991;
	bh=VpyNWKEpUs6kC87Yh1bsIzN7Mc90ZiqU1b0YvNZszkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=iJiiAsRLmowDYcnqLX8YTH1205Fv8pKaCi89oMH1zHrEfgGy9W97Dk68SedP5+Uj1
	 bMSvTbKhZnOwORAGAB26fvQ4ibS5meGKKSt/Lha6VzSarSHosNjqnk08YfoRrP8a96
	 izI+v4n4CQavfUMvgrnYwhvwsysAVLtKPqy4h6f2cDyjVBNHw5V/9hQ3OQbkLz4+Mp
	 fto4VURlRtTmuNSGF/wQ7AXBlcHBg47Dzvni7PMWcGyxpDAP8fItMwmSXO4GJw3eCD
	 Vz2cnUcvqW8mdfiRR+dOR3reYgxoWNvCrMcQZggrW2nmVUBKB6Z8OlW7kAuTv8uXN7
	 M4dN9C1VNaMEg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE190CD8CA7;
	Tue,  9 Jun 2026 10:13:10 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 09 Jun 2026 11:12:56 +0100
Subject: [PATCH v2 01/12] dt-bindings: iio: dac: ad5696: add
 reset/ldac/gain gpio support
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-ad5686-new-features-v2-1-70b423f5c76d@analog.com>
References: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
In-Reply-To: <20260609-ad5686-new-features-v2-0-70b423f5c76d@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1780999989; l=2173;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=Uodwb5bj6wApJ0FYWPX0bGa/9JMjqxNyEKnyBWSUBgI=;
 b=GBuLiZzqD5TZ/vzy8PD91oZvWyLAiDLQPGEF6sGhyjAoXlvrRYwTzVbAK5kHOy2sP7YEs5aoZ
 +De+f1mS1S+CMjVvi9ZS//oNVyGfleun8wXOFOORlHdXsYhLxkmHI4c
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

Add GPIO property for RESET, LDAC and GAIN pin. RESET is active-low, LDAC
is used to load DAC channels with values from input registers and GAIN
can double the voltage in output channels. The gain-gpios property is
not available to all supported parts.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../devicetree/bindings/iio/dac/adi,ad5696.yaml    | 34 +++++++++++++++++++++-
 1 file changed, 33 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
index b5a88b03dc2f..2dcc049f30e9 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5696.yaml
@@ -37,14 +37,45 @@ properties:
     description: |
       The regulator supply for DAC reference voltage.
 
+  reset-gpios:
+    description: Active-low RESET pin to reset the device.
+    maxItems: 1
+
+  ldac-gpios:
+    description:
+      Active-low LDAC pin used to asynchronously update the DAC channels.
+    maxItems: 1
+
+  gain-gpios:
+    description:
+      GAIN pin that sets a multiplier for the DAC output voltage. When high,
+      the DAC output voltage is multiplied by 2, otherwise it is unchanged.
+    maxItems: 1
+
 required:
   - compatible
   - reg
 
-additionalProperties: false
+allOf:
+  - if:
+      properties:
+        compatible:
+          contains:
+            anyOf:
+              - const: adi,ad5311r
+              - const: adi,ad5691r
+              - const: adi,ad5692r
+              - const: adi,ad5693
+              - const: adi,ad5693r
+    then:
+      properties:
+        gain-gpios: false
+
+unevaluatedProperties: false
 
 examples:
   - |
+    #include <dt-bindings/gpio/gpio.h>
     i2c {
       #address-cells = <1>;
       #size-cells = <0>;
@@ -53,6 +84,7 @@ examples:
         compatible = "adi,ad5696";
         reg = <0>;
         vcc-supply = <&dac_vref>;
+        ldac-gpios = <&gpio0 1 GPIO_ACTIVE_LOW>;
       };
     };
 ...

-- 
2.43.0


