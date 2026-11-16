Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794847202;
	b=rODlFo6Ko9+DwgQpnXnL2wWC0sa1tGaOGkCIJ0IWResEI48tiri3cINWDgSGwbQJyck3
	 Q8Ue2TeLmqbX+o89WXRXav9I5zz0PcH0fQ02lORKoir2hJA/aeVTu+WugYQhCVG0HPke9
	 r36sAzcLfB1ir6ke3TFuiZs3lUXtqLttEpFd0HEGjXMz+PIaxEEDtdGFCoAOH9k0E9zrk
	 Q0BrLewElz0FNwQXPZ6zxNuyI99O8qCc+cDJV6clTF6v2i85a1YVjtRTsRhz0Ff9tUuGy
	 mBLmoRWHHWRNbahDi7lJTACN6lofVnPfr2rfSdyqjn7PAmghdmQBiGCn2uR7lrPVNkw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794847202;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	b=AfA12iirSYzFuB8ThP36e1NUI/6MxuddQcrR0QxQ1GOkrpVuJT6PdcxPG2fKwGV9gs/0
	 n6dBNu7CzgBAxdkL3iG3LgLBhlXhFYc4uK5lU7FJ4cc2gvg71J4VMOXoY5RQjhfXy8/a7
	 mRFJQGDi/Yo/RmhcjvCGPXkwZ890PZ5Tj6CKLWyaxsC0ZdZjDIhooxqi/6dBAj+r8m65h
	 VfJZlO+Y5zTzKQUYEdKiZKY4w42MOPwslu9Ehs3s8lewgatMkuOUPVwY0i0s57EWa3G6c
	 2Elr3t1VkpouqCs3OIya5fSSC+06EV1SaWXGV6fKCveda3VaMzVHI5w3E53xM+/h7Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbZjfmZb;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C249606A8B8;
	Mon, 16 Nov 2026 16:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbZjfmZb
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794847202;
	b=vosvZ5BepwCtkGU50YmYkrtBgk4DksF97iarJ1ffo20Z0RXS6qWCye4HmYADkpeb4oBS
	 EpMLTi859e2TZ5QxfEXreNiA1TplIFIRl83y51MuvvlNZWjlw0Frbk3h6ENILJT639/zA
	 0/Ep2+o4SoO6QOYI1bn+Urfoaw+RRNOq3F7Ww5epfQ/dNFP9jDYzCTkEgqI7ryAOjvu53
	 3rJieZTzVkvDdTdIWPhxKtX3vjPpO2QlshlbFUd2ncUg7L3HX3y6kOqzRKOQoguL638JN
	 oSM5d7UunYUBZQ4UrUW4n3jxFo1/ckRNKGpl6gIsOIUKxu+DTaX0nElraOKDV6sBmUQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794847202;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	b=NIlf/pzWMuRI/w+Kcaf9m4/k0efOSLSwMTiezsKzjmb/M39JJzIyIibQH6xwlhxDVV52
	 JR/PJj7YbUYPIEp74aQzNHvfi7PsQo684fWYE6jgBslyxblkFtaToo0IXq7NpVJVnVeEV
	 9kK9boUqY8FKHR82LmPJi7Lu7uTPBJ0Eo+vUXni/t+SRvDe3bmxuJp/mDswpb47v/l4b7
	 RWKwbskwZNiiYPOphAQrjiN5P23l/9AOx7FQEPd2yJCKDprpfcscXl66Zo8qoLxXvlqtn
	 /8bhq0UOUYhTXOOsDTHC1k7daroZvy5mU3InVJX0PcTSlNHL/hHztYKBJn9w4tokB8Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 83CFE1F000CD;
	Mon, 16 Nov 2026 16:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794847202;
	bh=tspvrJnpoKFHb7HbQbrWvZ9PGJAK8DVOcpQAjMGTVTU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=QbZjfmZbBzAuZSDdELlKJf8yS6vz4KWkyqpKsNNAXT6tSs1KO/qbT/AZy84AT23kZ
	 imTThWJ1vKBmjfInwAz2iRARHy7h736M4vEV92L6FH0iz9S0YzMoQSAZ2Gr+GFiR4t
	 9Gl0IrBI6muEg5ZFthYlpv5y/TI6QEKuLrawqHqfldYp8/osz0arCOB85rL8h2CIdf
	 H09jh957NvgjhDQ1zHn8zT1D0LVC7Fpv4kKyvJe9IAXoTplpUkixgv4+2bTHAmHXni
	 g1oEk8avw7DEQaLigaGhxqRAk5ic53AX+0CzlpbBtBq44urDxie4z+aasYg+vvJvzn
	 k1kwGOYc9gMcg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 3BE734A52E;
	Mon, 16 Nov 2026 16:39:59 +0000 (UTC)
From: Rodrigo Alencar via B4 Relay <devnull+rodrigo.alencar.analog.com@kernel.org>
Date: Mon, 16 Nov 2026 16:39:58 +0000
Subject: [PATCH v4 06/12] dt-bindings: iio: frequency: ad9910: add
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
Message-Id: <20261116-ad9910-backend-support-v4-6-fcf1ad364ed5@analog.com>
References: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
In-Reply-To: <20261116-ad9910-backend-support-v4-0-fcf1ad364ed5@analog.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794847197; l=2580;
 i=rodrigo.alencar@analog.com; s=default; h=from:subject:message-id;
 bh=j5dklZUTaCzTsmtRwls0MFDoIhZtjambNyK1FFjRxqs=;
 b=tlu2PdHBcsP/jZkRQbqD74n4mvZvwhoZCJ95ooMYlIhKwlmwDSRbX4Tdj3zV+fNDYGoK8vf5q
 qm6ZBMbSdABA/ZBdEgX4ua31FHNmdTmW0vNqKlccbTdnKlwE+EbgOTf
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


