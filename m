Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793544377;
	b=OqoAjLdlu0Yoyexu7Uk5SIGQIwbfC0tMu3aOkja/C3cAaWhm+3+LBjg5jwzpNoslNRv1
	 19BPMVhiom2AQMDnatdPPW2ElONH78hnHwwxI+LokyXKBQHcqZrZDd5sRjEZk1Yp7DlNB
	 oIovUElSI8rPcNCY1N5QqYqnC5D4gIWGqEEKBwRsy/5SivMzSbFnQ9AorTZBgUFQilX6s
	 MxFpHBV+1f6uFtl8ba+7h4hXo853poHd+Azo3vy/TW1McKXaGQTyscE8BXaCdS90VSMuX
	 9/2OdFLIhS1dgNwxumfskIHOsBi3Xzm18ewanI6PmSUMZ71zGIRanJK/+IP+kUuwyHw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793544377;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Y0EKTum5EP5fxtMLDtNFhmHW3yDMuM2BLJSfkovSjmU=;
	b=kP3wiSqHFHJwIHUh3tw/RQWI+NHMR+Rcr/GiwNPm/AR2LnEvVAlP0uQpPF+08ducbT6L
	 4fWlHrH0hdeTtfKy7pgB3QX+184dzdW0udaCb5b1M+lhReWIM+Y/GW1iSonxXasw29Qhk
	 /6mR2pysj132QmOzQO0uRPaEF+X407UjAkO3/bQOPDuw3cEt9iUoAR3yht1w/0oJmBSHf
	 wW2PhVJF0asssA90OIlixZqe9mPO47EzLY1QBLQF5oHpHGr0z7+BLUm1uLVVUbwLLD5oZ
	 H1ft0sC/kP32CS7AppSypGop8MSG1n6cH4zCC1rtTHFv5w2BXsdeLqkGLi44Wxcxj6g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxx0bIp2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9062A606A324;
	Sun,  1 Nov 2026 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rxx0bIp2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793544377;
	b=ICj+e2L70vhq/EAZB7VBFnfz3HIHamSy2Pbu0ddNM8IIdRvoKhUgab4j5gQrgzzXsC7n
	 cIChrk2VFcIBAXgIug+u56Uqvbd9GdO55UVvhzsikzyz7hA+Es1sJiFTkKd/0OOsVq664
	 fJ+jtuQaxy/KtqWlWGLsqELPQS4RR7k5Yl+z29eukvUmKOfd8j+Sz2Vk1vF75tn2xhhHF
	 SeTmEbOgoTMqtpl60/C1GkIV+n1X729oY75h9KAa7b3H8XXZPoEcyo4NL7fu3vqulJV3L
	 VNjRdZOPJUmx389gLqciI0vbaDOD2JiV3CAVkgHROtwx7bNdvz7L0/+07Qq9OcTovlQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793544377;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Y0EKTum5EP5fxtMLDtNFhmHW3yDMuM2BLJSfkovSjmU=;
	b=ZsVUGfODcfvqxbC9HY9MXEHXc/BF8e+Urmx8KGw2uH+S/dOykQN2N8eJdvPwfDWVhksZ
	 tiKHr7ZUfx2wwVKSSx3R3o2MaVinmj6D/mcwYt70dFsA6A7nP4sfEbElq0sg7UpaGZJ7Q
	 HAkBMS/qZki9ihq9xbpA0Q/rOxDO3yRF4lrDJpVemRTYfFDu1f4cVzAh2vGwdidMPWZtG
	 897XHb6lXGDGH3ZtY43qbn5TGDqwD9rqFR+RFkirWbo9HavmJY7TsnnPms0TU90ldQ+Pt
	 O2TgGY+WxCZJsOYKKpIaC8YtVenJqMy9IKSihtBC+I1DaCIdNRVBCX8dMkusNrjcySw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id B51DB1F00919;
	Sun,  1 Nov 2026 14:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793544377;
	bh=Y0EKTum5EP5fxtMLDtNFhmHW3yDMuM2BLJSfkovSjmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Rxx0bIp245zhF5/L9rzfezd+SsQZ9OFJ1cI5XtPRkwaKcd51gXfs7O1Gmk1qd8fff
	 FIxdwi5ZzMZm6XTNujQc5jqSgFWn8NhQrv8yQD6KBLoyyKDU8L4bF9V+C8Gffsl6kl
	 F5p10CbbmbRCDCX3JQDfGcBJf7TvPFr71htQoiwmvGEtXKfIQ94zCHmpemiZOwBygR
	 +PgFlmYGHNS9odNIWYPrOU0aVLo+1SXFxIPA5dsdr/+QjD+l5dliH97eh8jlvb7rCh
	 YyilWWeabjpKPK34k6qNdcd6DRg2Dj7gGOdLZkjFYfYmWs8uZ+FNoWNIx+ZO0VyFTb
	 PQIo2YqEnpeew==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 489D4461AB;
	Sun,  1 Nov 2026 14:46:16 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sun, 01 Nov 2026 15:46:06 +0100
Subject: [PATCH 1/2] dt-bindings: iio: light: Add Capella CM3217
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
Message-Id: <20261101-upstream-iio-cm3217-v1-1-5e1724cae7b7@tsv-stahl-riesa.de>
References: <20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de>
In-Reply-To: <20261101-upstream-iio-cm3217-v1-0-5e1724cae7b7@tsv-stahl-riesa.de>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793544375; l=1847;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=DRsA8LrGGGchvF8FpCFYONWWJwxVpYsv7ZwhqvhN1Oo=;
 b=VSrV1z5oB0nvlFENH52PtDcThkAqDcLjbK2YH3sepafcsh2zRwhs1q2ZZcZYxzX+AM8r7nQ+g
 QgZpwmO/UvFCQOD7VnXySogZXTIkgvABxGZQc25PzAxqpwKu79DWqI4
X-Developer-Key: i=admin@tsv-stahl-riesa.de; a=ed25519;
 pk=D+v6EloYcEY9PIUHFyTM5sqcGIU/fIXzLUdkR8vjAtk=
X-Endpoint-Received: by B4 Relay for admin@tsv-stahl-riesa.de/20261020 with
 auth_id=1251
X-Original-From: Patrick Fischer <admin@tsv-stahl-riesa.de>
Reply-To: admin@tsv-stahl-riesa.de
Content-Transfer-Encoding: 7bit

From: Patrick Fischer <admin@tsv-stahl-riesa.de>

The Capella CM3217 is an ambient light sensor with an I2C interface but
without registers and without an interrupt line. It always answers on
the two addresses 0x10 and 0x11. The node describes the first address;
the second one is fixed and claimed by the driver.

The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
Tablet.

Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 .../bindings/iio/light/capella,cm3217.yaml         | 45 ++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
new file mode 100644
index 000000000000..b2ddb14d657b
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
@@ -0,0 +1,45 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/capella,cm3217.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Capella CM3217 ambient light sensor
+
+maintainers:
+  - Patrick Fischer <admin@tsv-stahl-riesa.de>
+
+description:
+  The CM3217 is an I2C ambient light sensor without registers or interrupt
+  line. It always occupies the two I2C addresses 0x10 and 0x11; the node
+  describes the first one.
+
+properties:
+  compatible:
+    const: capella,cm3217
+
+  reg:
+    const: 0x10
+
+  vdd-supply: true
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+additionalProperties: false
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@10 {
+            compatible = "capella,cm3217";
+            reg = <0x10>;
+            vdd-supply = <&vdd_2v85_sen>;
+        };
+    };
+...

-- 
2.56.0


