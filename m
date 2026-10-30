Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793386412;
	b=5mMhCpSfQsylDt2J3+5TZIXdGMsoRpn9Mi6RrEbHQ4R3TdbRsq9727RiLjeXvLLALnst
	 vgxobYqVBX1yK/2Q75Baxdjr6/8Fl8TGxYvvRqKMAhRGwApjBjFFLkUti9KAUig9mRPQf
	 WwIAPj0p0SbTcrxytF3MjYeqe0Lfv0EUuAZHRiO1mMWQFJqe13yVZVN44KaXsy2sRc5h0
	 7fnGzumdizlCrJSx0A8MI6aytlxpy0wNaVzf2Sdz8YoQcpRxREMGmYbgalJHd/jQHnQ/X
	 bUNXtxTY2eSM50WLzrlz5EpjxdvdEHYoHGrCX6JaAta0ZWQE6i3+Slmh4YT/dPPw8LA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793386412;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fe4RNK7/9GNwXOLesS6DtxLPhNs3D3794NTNOF2GqJg=;
	b=m9FrQ9qFRoQ8VeVrS15QJ5/u3ub0xNocxK3I9mD2I2XPHtuwijcvCTMNiKcmAVK5d4M0
	 lr+ZUoPw0HO6GAGZ74wa4n86nBIw8Agk6Z0yo8vv7p3cQBe3XrRkaeL0sSejev3253H8k
	 1/88t4fQToP8xOgRLe0TzJhMo+BVcC4W7fU7lTj+YYiUosUyKYfSmba8/mh7n4WfPnr4Z
	 fUEAjuw1LlZ8skIQ6zzaS58c9Y0W51Al2vJfqpBxMnyQ4vQsH9F7Vwgpza9gPtvuLnrGN
	 olGgdgAnNeNIcOLwmOJqAQYbUHU9dAlzjH6nhMNr1qfb05+rusPKsICK20JGuOAfuog==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="ghYCYv/s";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52D7606A31D;
	Fri, 30 Oct 2026 18:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ghYCYv/s
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793386411;
	b=JDbeSBVcRGj1E3FhTrc+82nYjdMyEhRrc/P4sdemmbvJx/pWNdD3uXKVpIPSNUPEwI3O
	 eSEqp4WZs5HVWVoX9N/XrvXtZE3TYVDKyRKQkLeqmROdbmyVwuqIg1hgzzFMEHfa+PRw4
	 STo32oPE/OdTve7YIlLm1b6Jw6Zez3xy25VMJKbcu9Ks5uNJ8uw37itiicRowyTNPrlJN
	 Kt8y5PI4oN+jNcuLi43LT9Kwk5UbPibFdMXACf6j5ZQUeIIuwMu7rB8AyQvt6eHd0N6Lh
	 qMBj0W2/tfPMm8uSw+SyxFY9Hh8CKSAx892cnHF2GIZ3I4eT6g1gqwZFsIGcmnvWjVw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793386411;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Fe4RNK7/9GNwXOLesS6DtxLPhNs3D3794NTNOF2GqJg=;
	b=i3Gcb0K60eX/nFdrtWuO/QIe3Z7Sw2GWwQbCaJI8Qg5NypzLozhSaKWczbTGurekUKcR
	 EV9TxbvW2vkpjqlUPtwHPX5VOK+i/5USuHbAyng3J/boGxG9mRIM2NkzZqlHKCo+Nx20+
	 YcYDjPjUuX/rnE5HGwRAzgPv67wJkGKPcYCweXsPpmQF9IID9Mn7upkxmA7+sltRvcg/0
	 F/+r4QnAH1cpjiy1F/ijdA62IcAPGd+Ivxs8BqIk1gM3ojwY4SBVY5au0mmZiUjVOZoys
	 7FcW2dDE6CviZC1SKHTZeUIRGes0ENkl8wd9KtK7GS1sIPuoDtXitoItE8Lp5kgUshw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 9A02E1F0093A;
	Fri, 30 Oct 2026 18:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793386411;
	bh=Fe4RNK7/9GNwXOLesS6DtxLPhNs3D3794NTNOF2GqJg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ghYCYv/sbRMIaSggYhJEAQ4k5uvjS8PmF8Gva9VGLTmYrSKS0jrof3s8WDk8Cj9eD
	 BKgdxyRVBiH8MS4672ztYhlPO+iYrLFCltFg6f8u0wm+ufHkZyJhAD4mU7Avh90b4O
	 9SkPTTW/dAzn6HAzDcxrMtpKCwKCsm+1SAErWl076OehXT1Rbuu8w3sK1WaQgjGmtK
	 fi25wMbThoZoyMaEcO3LYEvdaUal4HFzLEjOGUMAbhNU0MXgMqewL8gKzn5O+f+nNQ
	 s2N/UOj+iY/qjhy9LFIPuCLTUEEMqr+gEeRy7I77t63XRtCdMYzJN9TjKXnVoR0oVS
	 eTjFI+V8yI51g==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 14A9444249;
	Fri, 30 Oct 2026 18:53:30 +0000 (UTC)
From: Vidhu Sarwal via B4 Relay <devnull+vidhu.linux.gmail.com@kernel.org>
Date: Sat, 31 Oct 2026 00:23:29 +0530
Subject: [PATCH v2 2/3] dt-bindings: iio: proximity: Add Benewake TF-Luna
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
Message-Id: <20261031-tf-luna-v2-2-ce403579bb8a@gmail.com>
References: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
In-Reply-To: <20261031-tf-luna-v2-0-ce403579bb8a@gmail.com>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vidhu Sarwal <vidhu.linux@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-iio@vger.kernel.org, Shuah Khan <skhan@linuxfoundation.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793386408; l=3211;
 i=vidhu.linux@gmail.com; s=20260713; h=from:subject:message-id;
 bh=ocYeyqYoBl3HVzLcvJavpWYsClFy28D0KPq7x1fpZtk=;
 b=mW6j3+3+quNnEyG314nQuPlWdij1s9csYRJfc/7JZI5uprtNNcWI8ZYNBE6Y4QhyuclPdyvCS
 fY+jnFEKkuDCGISJypY0qM9qqDRKb388XPvK92kUjX5DuvqCqyyCwBz
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
power-up. This binding covers both interfaces. Pin 6 is a data ready
output and is described as an interrupt.

Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
---
 .../bindings/iio/proximity/benewake,tf-luna.yaml   | 66 ++++++++++++++++++++++
 MAINTAINERS                                        |  6 ++
 2 files changed, 72 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml b/Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml
new file mode 100644
index 000000000000..607a71a6ab39
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/benewake,tf-luna.yaml
@@ -0,0 +1,66 @@
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
+  of pin 5: tied to ground for I2C, unconnected or tied to 3.3 V for UART.
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
+      Output on pin 6. In I2C mode it is a data ready signal that goes high
+      when a new measurement is available and goes low again once any
+      register has been read. In UART mode it can be configured as an on/off
+      output.
+    maxItems: 1
+
+  vcc-supply:
+    description: Power supply, 3.7 V to 5.2 V.
+
+required:
+  - compatible
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
+  - |
+    serial {
+        proximity {
+            compatible = "benewake,tf-luna";
+            vcc-supply = <&reg_5v>;
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


