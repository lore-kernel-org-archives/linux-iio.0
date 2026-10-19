Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792451863;
	b=fi2vhmjB0hBHCScSCECbjnxbDGlqbNu6oE9UsHP0MT8nCIBya8XPkcQjMyXLERGUG2Fr
	 NJutxqliGs9YxhOBqTpGLYMIe1ioN4yjeiOfU2ZcW428kNy0Js2bg2Alv7E1/O1099FjE
	 A7dTnXu+SwvZjgwdFuXulsNu/fvYywrHq8Sg8Q+VCqQJeU+lQWSo5p5VSDby3XoUVMmuI
	 Xd6F904SsFloSOwXs0Wt4kP+5QM5dFByTqef8oB4evbIqZJl600e1lbYdQFN2p8Yb2lkg
	 ahweM+TRXtmfOb7GXvPKS6EdJu1bU5KHNBaecYq2mnl9SVBJrszeYk6pghcufrQ1cHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792451863;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qMV4MHzD9X6bj2fo95tLdn6ggwKiyHTtTGXppl18I60=;
	b=QEtYUPVpuVknADiq6Ua3lMp9RCUXAMCcCtYs5A1EDaqhzwADMMhLedojNrAifo9f6LTZ
	 HAWo+DrsV1SB8wd0TkvpWYio/U1hA+DVDDereo8m7eoZM7o5qvH2kwvbCfNAOtgCfnsSj
	 oEp7OVAJ6cw4sfsisBx089qF/uNQH6/5vEuaa0oNpZHHYqV64bb9x7WarIZjSulKWs7tI
	 4TJrigFwrHwMrIqxDBIS4yU9WTOaJumIYCUXjobiFPqloc9zffq/FTNQDm1T5fId/AXPe
	 7XKH8ijFbsl4TMWRAXaXiEAtMIKM4rWqgNQZRJ1GCCe9rviR3A6scq2AsQ+YtWzb/6w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPuJHk5a;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F6D606A323;
	Mon, 19 Oct 2026 23:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BPuJHk5a
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792451863;
	b=PGeeQmUrKX5DDr9RfLciPOf5imVhGL0fxGXApwYCkwSISphv56jlNXUq8obcIZXiAAUC
	 9TryMCCQp98aBjNfSV63z90gtVDqExuDOsPwLMdBGP8/V17Ua2uzLWYibC5W48mSE9Ve+
	 UABuovJy0LDYfdJ/KnrKN885ZL1rc6proMC9DwzuVjljeQr/1k5r31tsqtkC5V/vLG4bx
	 tJ4LKB5hrdWC15A/rsD+3dSjQ9HCuHcHTDuNFUZFLTP/VndFur48PPIINx1aLKs8mKxGt
	 uWIt5HVijTj8xrZNIQ1EGZiLb0humW4IR+K0FE7LWN0siTBaQLUTbtkxKNn0i39k5yA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792451863;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=qMV4MHzD9X6bj2fo95tLdn6ggwKiyHTtTGXppl18I60=;
	b=zMecOjllS0IX0AGqsV/tohaQ9MjpqtfUeUeWaGbquKU+n91oLveC2cVcsp5TPZkBZH23
	 Wyiur9GskTaxCfFdQywd5b5xnqvfrNydxckVWWeReaoEqtJdiG5C0QHnqwGY40rNnpv3S
	 h2+Sz3g7zZcxrp87pRe1yg4LefFhRf9crkKHCaJZ1Uo1nGTfVr3lez4OqVAlNaLpWwvRS
	 66TjF2u1itf/I+RsKcvMWJEQ8OMm0U60WEC7poySTWSj+suWMVWn7Xz3zv+mP8IVc1+k8
	 gEZUgvekxcpO4dWJZ9R6+/tNo21N9EUtFUziC+Kla/JsTWUOotdwPpZ0BKskpYjqj6w==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2693B1F000C6;
	Mon, 19 Oct 2026 23:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792451863;
	bh=qMV4MHzD9X6bj2fo95tLdn6ggwKiyHTtTGXppl18I60=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BPuJHk5a5P6LqI3E6uX7WyqBkmN7l4W/abLjQkrElo2kaUctyfgXMkbNAYAmKOLzP
	 R9P6dHOgX2V1FeOZXK2g0sA+aAQOe2Nnag7ea+1IyBi2AYuh4kbZfrMe9QRiDnuoyr
	 35Wnvs+AxYQSBZFxdbbcP8N+S/BzXVSS5yyIwXKL1+exO3Hn2A1AkWZTdhmQgllGnH
	 DWXXk7EmnWFG+XmPDd/q0GiUXeqQ8H/6hGnvzA8tifakBUHWoZJicdj5H+9t5uUpPd
	 0CvIo08QHKYT8JsEyriZX0mt110rpRZQ1Zc69jJX42+QPy1JY2JNJSyV80aQPjUGsd
	 ppSoXAhsoFcKQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 863FB406AD;
	Mon, 19 Oct 2026 23:17:40 +0000 (UTC)
From: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Date: Tue, 20 Oct 2026 00:03:42 +0530
Subject: [PATCH 2/3] dt-bindings: iio: proximity: Add Benewake TF-Luna
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
Message-Id: <20261020-tf-luna-v1-2-53a88f93db24@gmail.com>
References: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
In-Reply-To: <20261020-tf-luna-v1-0-53a88f93db24@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vidhu Sarwal <vidhu.linux@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792434836; l=2973;
 i=vidhu.linux@gmail.com; s=20260713; h=from:subject:message-id;
 bh=0UBEPrfvmA3ptYlQPCqBd+fp3dX9vJ8y5I7yTq7Hq1s=;
 b=RZQf02ROujFEc4ayDljTkgirbR0+KERzramPjlK8nLFoB7Ma5i/5YJpaQIB7qpDyiK+te7XnN
 4JHqEHmxu41ATWBz7bPws7I87rWh9ZUkeAQivk1bLUXsClSUCUrFVo8
X-Developer-Key: i=vidhu.linux@gmail.com; a=ed25519;
 pk=xDu3Cbesz76CQXwY8lteI74n3ELVIV7wCsuYAvcX1Q4=
X-Endpoint-Received: by B4 Relay for vidhu.linux@gmail.com/20260713 with
 auth_id=869
X-Original-From: Vidhu Sarwal <vidhu.linux@gmail.com>
Reply-To: vidhu.linux@gmail.com
Content-Transfer-Encoding: 7bit

From: Vidhu Sarwal <vidhu.linux@gmail.com>

Add binding for the Benewake TF-Luna, a single point ToF
LiDAR distance sensor with a range of 0.2 m to 8 m.

The sensor talks either UART or I2C, selected by the level of pin 5 at
power-up. This binding covers the I2C interface. Pin 6 is a data ready
output and is described as an interrupt.

Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 .../bindings/iio/proximity/benewake,tf-luna.yaml   | 58 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 +++
 2 files changed, 64 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml b/Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml
new file mode 100644
index 000000000000..cfc3dff58013
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml
@@ -0,0 +1,58 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/benewake,tf-luna.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Benewake TF-Luna LiDAR distance sensor
+
+maintainers:
+  - Vidhu Sarwal <vidhu.linux@gmail.com>
+
+description: |
+  Single-point time-of-flight LiDAR ranging sensor with a range of 0.2 m to
+  8 m. The sensor talks either UART or I2C, selected at power-up by the level
+  of pin 5. Pin 5 must be tied to ground for the I2C interface described here.
+
+  Datasheet: https://en.benewake.com/uploadfiles/2025/04/20250430174501874.pdf
+
+properties:
+  compatible:
+    const: benewake,tf-luna
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    description:
+      Data ready output on pin 6. Goes high when a new measurement is
+      available and goes low again once any register has been read.
+    maxItems: 1
+
+  vcc-supply:
+    description: Power supply, 3.7 V to 5.2 V.
+
+required:
+  - compatible
+  - reg
+  - vcc-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        proximity@10 {
+            compatible = "benewake,tf-luna";
+            reg = <0x10>;
+            vcc-supply = <&reg_5v>;
+            interrupt-parent = <&gpio>;
+            interrupts = <17 IRQ_TYPE_EDGE_RISING>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 52024397dc78..24fa7cdf6a57 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4662,6 +4662,12 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/luisbg/linux-befs.git
 F:	Documentation/filesystems/befs.rst
 F:	fs/befs/
 
+BENEWAKE TF-LUNA LIDAR IIO DRIVER
+M:	Vidhu Sarwal <vidhu.linux@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml
+
 BFQ I/O SCHEDULER
 M:	Yu Kuai <yukuai@fygo.io>
 L:	linux-block@vger.kernel.org

-- 
2.53.0


