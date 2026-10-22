Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792682350;
	b=qdbuQeFleJ4BzhPR86iEXabGgadXZlempxhzG57Dt4y3IM9HXFTw+Wq+wQ+oionOoTuQ
	 1z8q45Sst4rYBfx1XlR1ILXOUeQgX7RkEtT7M3d4xbZK69aH7uJ2cKIo8m0yKvgVwajk5
	 ZkDf1IxSHNsQQVlnDxnhLPgoSgheaD2uHP+To2hHIQoSROYhwkZUTJKAB2OCQYuDhtOnz
	 IaUSgyOsrE2mMiJ7siiWlsExqvGuucpA+SSpKf4JgcNP2ktLqcUa71UNpnTAaOMXL9kFx
	 oGQrYEame4GKMGhaVu+E8A4gj78bzJVtcREhsOHmIg7XtHuxHrmOc6jUskIM9SKw/oA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792682350;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	b=CXa51UqCGVMfxQ9NQ1c8z1hxNwPQghLzQ0L5LRiF0tebrtIQsZwHmBRAEc9q9l8OLnCK
	 tGB+z3HmUvh/FPMHkQ1ezxmxZMJFjh8196SP7Ck+4TbDTC1kpQYENfTPrjNcTfVTREyxX
	 ZO6fmAoUhRqdbDyh3LGSK7tHpso7XjfgzXfWT4cMi2wpvpuufq+g83luaBFS8mfZsf/f7
	 BHzPQXIYICHbfcZ8nKPm5Vt2WYEqxwS6BeEVOueBZqkZaW6oePxWrOR3RIA2VxYr9cKPb
	 TVuGQBh23TtSkW7PGn8J+AasQGdMyv8dGatyMPYDvhd3OZwYwRdRes1xA0NdadQCwyQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3v2BCtb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A83D606CC4A;
	Thu, 22 Oct 2026 15:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V3v2BCtb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792682349;
	b=ETrOkxX2aNLnORgC8Z2maRzKAGR+bRXeCSJT5Irq/CMJ7zV/JTURGRGo7gkDpwj100yF
	 JbmAitX6GXIHfohUowgX96L+doxX2oYM1lWsqwPKDtnLRNmp05synLF13N+/hqeB6+gGX
	 buI4J/gx+h5s3bBpVjhNcho93g9LuZqhRP0TJhKZUYKl2Dd18um5TeJU0CmW2/l48Li7N
	 2fUAlVyb5IDzVtUHZNJsgXEPK+ekNCzrS99MgvIeIfTU5Hzgdy2UaYWX+3z7a2m0AoTjN
	 kzqHtH7+5bWVRMW97dRQmbuV2TRg13hf2Bc9PZxMj/2sKVMIXqgB5jjx4cjWb5Sss1g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792682349;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	b=JVuDP36x1ms9ZgHzDnHts8b1y5nUxHdQsm0XuwSwDbxmX9C6EHkR/oHQFoIpQ6lA0xUN
	 DgEy34pXY3ifTL/BJ4Y53kVlvdlVg0ezLjgZxB9TZwWUlRHdYeB3KQlUeA3a+w4oGsvmJ
	 Wye1zm6vZF1pBOoUjrCWuO+hzkSD26NkFo+ox9WgMBqWyUYifROWIEjEljXyth0t7Gwu7
	 iZvpfqmxcJCtYX2mcPMGof1OxTe94y3O2qBM/VBeUS08wEAWxQ3A2aJBrdLpayPmO0Gt1
	 Dy1/UgMCzCd6ywsvdAZNT7n+4gcNtXzxqiE/ZurrG4MYdrLHE9n0Hu3uhUvxmm74kWw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0844B1F031E1;
	Thu, 22 Oct 2026 15:19:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792682349;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=V3v2BCtbez1PkCclnED6TCXlvF+z1wqCBzv2widFxVucJi4ayQ64/SWSt3jRcsBpw
	 03BZVIL+XxnLPFZFKyiTDAMK9pD531bId+cUqXPrBJUXFbrqaYAcLCxKsPAS18rEVf
	 PrzekblA4rSN8NMuEtE0h1rOKQz/U7nwdn3AA/bBm/04DUYKppq/WXQd7nLKNXhztU
	 Z9SuKb8G/1ERdrY/0Z0KrMOLCbxu5eLebCGAJt6FI2d9b4OXCVmjG2MI+VjDAuNY1I
	 2qV7YvbszegqRmlDKctufATa4/DOUm+zIpIkVzxJW8DXuuqpXHRZF3uHIL1atz5yfV
	 0L5oDQMy4BU1g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 85FBA41E56;
	Thu, 22 Oct 2026 15:19:08 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Thu, 22 Oct 2026 12:19:02 -0300
Subject: [PATCH v2 04/10] dt-bindings: iio: frequency: ad9910: add
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
Message-Id: <20261022-ad9910-backend-support-v2-4-0ff7f0bff326@analog.com>
References: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
In-Reply-To: <20261022-ad9910-backend-support-v2-0-0ff7f0bff326@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792682347; l=2580;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=j5dklZUTaCzTsmtRwls0MFDoIhZtjambNyK1FFjRxqs=;
 b=BsBOHVrPcRaqCnqD4VjmxeKnUFNL37ft9mauZkQYeiH7Dh5zw1B2NjNd5fVxFfd8mSvZZU9lZ
 rWk/dEVGvOqAluy7AvsMnkS+trqT9dnGz4d3NEEcB2AdsOo82aU+KoU
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


