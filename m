Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710A354145D;
	Thu, 15 Oct 2026 16:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792082995; cv=none; b=blVqkyuNhIo3AJ5cH7m4vbkLyfHi6cu2AP944136pYVKQZhfYLLIBMGpzW1BiXMce0DAHz6NItupT0uSAx36Wx6xq2PCba/3zQKJ/0dJA9R+stVG7alRxMCk/0c5HObTwJ0PNKgwMqbGZnxysjxlJPRrskTNhX12Op+jW9KCKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792082995; c=relaxed/simple;
	bh=AaImLE0FEDxw87MGpv3hMNABB731sE/Jzx2WPzMFp5c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ieFjw/Uxzorwa4dN6wLnA9oYmd6BNB+bIk0uOa63NaS7TQsKrds3wLcrXmhKC5KgSMjKgdAVay6RtS8tFfCeOZOV2+3dJtbxnHLahgQtd69YJZj76kf73Q1+DyHw8vtzf0fPYdP/DEOXcBhSM8C2rtN/FMNZ9vR5/1k9xW566Iw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMKHz9S1; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMKHz9S1"
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0915C2BD01;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792082995;
	bh=AaImLE0FEDxw87MGpv3hMNABB731sE/Jzx2WPzMFp5c=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=NMKHz9S1EqrJA/oyzomBZAjprJP98YI1R1V01OCRYTvLieX8OxcR1r/9PU9RoufKk
	 /JWugdmXAGzMpFCPrjAOlmaAjlRiJUXdvGnZ03L4GESQJ0Z8vl3goaOW53UVR8i3or
	 A0UHUEn+2IwWLAqCaavEZr1MLb+sn/oxTXh5XxcG3UDZ/XOQLTgYffUL99mijULAac
	 6rJYlMPOPhqM0Dm6KaqAfTxiJYQO6iPsd3jAAeq6lftsCIwlU/sKMAEsIGM2gFT8XL
	 7DgLTmu/YZCNB5epTp0a2Tv3nPScmDF+naCn3OyXPHMppFoZUNNZ2fTanWKFq8XFfF
	 QanYarmbNJmpQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE13CCCA466;
	Thu, 15 Oct 2026 16:49:54 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 15 Oct 2026 13:49:44 -0300
Subject: [PATCH 04/10] dt-bindings: iio: frequency: ad9910: add io-backends
 property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261015-ad9910-backend-support-v1-4-3c21648c8e26@analog.com>
References: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
In-Reply-To: <20261015-ad9910-backend-support-v1-0-3c21648c8e26@analog.com>
To: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, linux-pwm@vger.kernel.org, 
 linux-doc@vger.kernel.org, 
 Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <ukleinek@kernel.org>, 
 Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
 Randy Dunlap <rdunlap@infradead.org>, 
 Rodrigo Alencar <rodrigo.alencar@analog.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792082993; l=2527;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=8jAo3Ub+lq360SLcTWJHf+ffhTCESzkP7WQXUZzi1Yw=;
 b=5bAk63xs1Vpwrtx+6vqlMosUp8ugrwZu08aBnPmW6Z1DUFERxhVFTj0mIdo8rn5z86y3G+dSy
 wUJlVgncKG/DcXTXxfDbMk2ztxvOZbq4YQkVtk0xqMvrkZNKZxdgles
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The AD9910 parallel data port allows high-speed modulation of the DDS
core parameters, which requires a data source such as an FPGA IP core
connected to the F[1:0] and D[15:0] pins. Add the io-backends property,
so that an IIO backend providing such interface can be referenced.

The property is optional as the parallel port is. The device remains
functional through the SPI control interface only, as other modes can
be used to drive the DDS core.

Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
---
 .../bindings/iio/frequency/adi,ad9910.yaml         | 38 ++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
index 4eebbd388b27..02fd49db93ff 100644
--- a/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
+++ b/Documentation/devicetree/bindings/iio/frequency/adi,ad9910.yaml
@@ -120,6 +120,13 @@ properties:
     items:
       - const: drctl
 
+  io-backends:
+    maxItems: 1
+    description:
+      IIO backend that interfaces with the parallel data port, enabling data
+      streaming into the device. The backend may also drive the PROFILE[2:0]
+      and DRCTL pins, the latter being exposed as a PWM provider.
+
   adi,pll-enable:
     type: boolean
     description:
@@ -206,4 +213,35 @@ examples:
             adi,refclk-out-drive-strength = "disabled";
         };
     };
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        dds@0 {
+            compatible = "adi,ad9910";
+            reg = <0>;
+            spi-max-frequency = <1000000>;
+
+            #clock-cells = <1>;
+            clock-output-names = "sync_clk", "pdclk", "sync_out";
+
+            clocks = <&ad9910_refclk>;
+            clock-names = "ref_clk";
+
+            dvdd-io33-supply = <&vdd_io33>;
+            avdd33-supply = <&vdd_a33>;
+            dvdd18-supply = <&vdd_d18>;
+            avdd18-supply = <&vdd_a18>;
+
+            reset-gpios = <&gpio 0 GPIO_ACTIVE_HIGH>;
+            io-reset-gpios = <&gpio 1 GPIO_ACTIVE_HIGH>;
+            powerdown-gpios = <&gpio 2 GPIO_ACTIVE_HIGH>;
+            update-gpios = <&gpio 3 GPIO_ACTIVE_HIGH>;
+
+            io-backends = <&ad9910_backend>;
+            pwms = <&ad9910_backend 0 1000000 0>;
+            pwm-names = "drctl";
+        };
+    };
 ...

-- 
2.43.0


