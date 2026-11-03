Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793717583;
	b=yg3DjB0BDC2sygudUJFKOOVWIu1VmygH83t8lu7JlaZw++amqH3lXeFr1DGZf5pUG50+
	 wHEgYm97fszWgYYE9AnEW377M8oA/pf7RGJ61Coj2ThMuLuYCtRcrCMKHbBnEips+YGHI
	 J+8d8+c6e/paAbdmZK8LT4aPpbf0V/gWKozd6utkCPkn87+rDL2rWZcjjTj7pcXQMLmEN
	 2Nnj30YpOCve2VGwDsoIDCogNp+E1to3dptGWwIndALA4MmhtL72Xd8+SO49X1+g3OCb2
	 QDL5k/lnu2wws3bL48wyNQhTfsVx9kxhxGktJuWgQJpp+DmQMNIu7Zic8OMngofLhZw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793717583;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	b=Fc1HWmbpHb0EUMjEUFQtZmSedaxXnkKGpHhmQrnBGsjZf/on9wiPVRobyBRo0dxFeInP
	 ixzw1Z0r+62lbWYUck+oiaRqdRa4+gJCjuLqDuwkLBbeLsFP/+HXU3g13mRCklsQFro1n
	 EGhsJ2r3ryKm38MFIlCiK76oytsfVMNH0dzhCtlRkVphrVyPNq1R8a6/lFo5E7ANe8Q3+
	 HSfzP6kIm8p7Srf92ytht38oQzUOXoVgMNFQn7ZI+6cwtNXlAy8q8+hotv5g2yohRwaeK
	 Ur5TWbDiCUmkpHzK/QE3DqxeqTT9zvXWAelV2xXQ4xg9tt6W3bAAcvGfSSZw740872g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp5KoLGK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE8A3606B26F;
	Tue,  3 Nov 2026 14:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Tp5KoLGK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793717582;
	b=kJSMXk/di5N0Zz0qLDPN8ac1s8a74YSYucK30qlmvIw9vSOFTTjiw2waWb9JfkMueRuc
	 0b7rzSECA3igIp7Bp+wbTkK19ql/ne0leChRPFNsYmLwhq70I1Pk4ZvlzXhbv1KoVqw6W
	 EMti1815/A/NyTv6xHh+ugedXv5F7ypiPByoJoGMt6BQ24275y5fkOu4cKogDrPVKtcqz
	 4BF4Ldwl6vkZrdyWg9K7fRqNt5hjADU7ZI1MB8RIO2DFnQvt/IKxF8ytJ8p97MomgGoYY
	 En2vzMPhvyawFTVoT0PddCsmwHWi/Clj4d7oywDUtjbO4AvI0sw/WN+zU216kMLwwaA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793717582;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	b=JE8f8PY+pQaUvb98poHxMCaUwEKptj31vdV5aMaugmstyUxm3EPJzYw2lre2ZI/Sma4T
	 JU1F1h5N8jfeFYsHDW0Vdw18cYZ+RxB4kVa5HkU1O3doDTi5V0hdzJBl3rCHErzPyw1yb
	 +Qo+Vlo5VqWs0gxvJ8txZqg+BM0Tl7BifGX/eUmBAPogCLN8japXwHiFjdRoTf2VDvawa
	 dr6ac4nsuGtpM89o6mb6oZdJ3a0gTPAo5gNlpxRn5gY2NSc46gbwgg84fWssa3U5rnf4h
	 749y7dSQyQ8OCiR/PMqXGkeDHZo4kxHUr3M3d7hrqXvyw9kHWVTDEgejARRnyhPdXJw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id F224E1F00A15;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793717582;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Tp5KoLGK0iKPoLqdLU2GZu1YzQ7V0ehTub5fvBpqdIAqPZsAZhkJWDXk8Lf+ubxpz
	 LPmhTEdEQIrHZoXGgVVHp/r6SH+tHNHrnpZ9gr9ZDyAJWbtWgmhPr2pk/ExZR6f/Ja
	 76fQK9ZxfHNCQQowbaDQbMVbrXMMtXFxUm9gxTC1IjuchVFqnGVBYOqv8IYVR23eU6
	 9XN/a3CTwoezI5fOs2h83k9Epob8D8YoJ59Q3goQ+UWK1wLhLmrVQ1K25rKcWTZpUc
	 vlDmBRljbJmP/ZEaRACVdAx0bU/yeADmu6m+/aHgu/haxPXTBNpRNqLl4NDb/Zl5LK
	 x690aaencpzZg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 84E57469AA;
	Tue,  3 Nov 2026 14:53:01 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Tue, 03 Nov 2026 11:53:00 -0300
Subject: [PATCH v3 04/10] dt-bindings: iio: frequency: ad9910: add
 io-backends property
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
Message-Id: <20261103-ad9910-backend-support-v3-4-0e9224ddf7b7@analog.com>
References: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
In-Reply-To: <20261103-ad9910-backend-support-v3-0-0e9224ddf7b7@analog.com>
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
 Rodrigo Alencar <rodrigo.alencar@analog.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793717581; l=2580;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=j5dklZUTaCzTsmtRwls0MFDoIhZtjambNyK1FFjRxqs=;
 b=83s9FQMqeNHy0WxOBbsjsm8HPLiB1Z6YrnbIYW+Z2qOev1A3lPAar49HcVoJjeJWZCRd5ewmj
 NjPiOsMf3iXARgg/QCMCpoL/Ix0iPVcxHR3wvRrAx5FIYdpVs+MwY1J
X-Developer-Key: i=rodrigo.alencar@analog.com; a=ed25519;
 pk=ULeHbgU/OYh/PG/4anHDfLgldFItQHAhOktYRVLMFRo=
X-Endpoint-Received: by B4 Relay for rodrigo.alencar@analog.com/default
 with auth_id=561
X-Original-From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Reply-To: rodrigo.alencar@analog.com
Content-Transfer-Encoding: 7bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

The AD9910 parallel data port allows high-speed modulation of the DDS
core parameters, which requires a data source such as an FPGA IP core
connected to the F[1:0] and D[15:0] pins. Add the io-backends property,
so that an IIO backend providing such interface can be referenced.

The property is optional as the parallel port is. The device remains
functional through the SPI control interface only, as other modes can
be used to drive the DDS core.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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


