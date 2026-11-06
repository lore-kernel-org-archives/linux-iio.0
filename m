Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793998612;
	b=MKfCQ05JkTjfa2bspT4QaOCDI+kyCWQRQ5zCH+sqjVGrILS6qGnoNtzY5RBCdO+7YSyd
	 GLnPUCj+M05C5WgwD14qG2yireq/uSqWGOBEJyg8k6LYEPlqQs3xfmuAD6aKUN/rFMKew
	 9KJkgoLBindRPY9Y48OSQFIkBhtIP6205AlMGf+EA+v/rwq5t1iNwJrZ6Sf53rdCMGr0t
	 k2g1Eo1iStHsq7sYbRwFu3qfqeWsKWaFyQQ3AI0aFgA0bCytEud0a/8J7KciZ/exg1i9G
	 W+kjB6iaOOYEsMqUQVryjMoAK3EOBaII5DOALOF976MwsI4Mb2GRuhhEJlvvCdKwRIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793998612;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hF/8cHol6oifLy6xHxGiLUqBkdJhttiK2PlLUMXUHto=;
	b=4NN9ABib09U4Do6FAVm9ksPuxqWCwBMQG+Thm/H5341RNYh0dIexXc+cRbQrz2zdbbHy
	 OxTIGBK1bY3WbaaLk3LixCLnvtq4OE7svfFOg6AmkUZK8GKL+Y7i+chwR1jZdnRORFCCw
	 8ZCdXLgnMKH6PgJFiB983D+29vfrLHlSNykgNfqJaCsoHuD3wwQMZbFWw2JUCjGH4yUDv
	 Ua/5ASlWCya/mZ0YKMs4IqYRXfiv5CRKbOqAW8AenAjS7v4fPBIKoYE7q4YSr4dktjkXl
	 ZhOYkLR/BeXS9+jdmLoCkwSBLRu8D2Mm/fSQ/S+Y/7fZo7tlGhg4Wexr5ZMnpZGj/5g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="W/CTDNne";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E09606A338;
	Fri,  6 Nov 2026 20:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W/CTDNne
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793998611;
	b=Lcv0ja4HlZSJ3ByCo0P1DckYxgGvtXEEwHMXjfr+cjt009D5z1wKTPBjtk9S1OHCpppO
	 qCzdfS5K5NXcYcvu5Z/3TGkmM6i7VBxQ29ehb9aALg4VHQLR4j3kbMJtdHfJdv+3XjLDc
	 4svz6kjt+pPTAnJPo9oP9y8i+iM7/+Pk0ZbWgTI2tmOzrj78YStn2+A3wyAOSIFDykBOU
	 NsIKl8c93z3nNWj2502oGVmQ6CDMEChD0bVhV4AHoesfEStgmI1A+Xus9hxF15x99C7aV
	 YijnZyVarfh1NGMm6Bx7z6iC9s/nQFsVAZWZrCA9g/YoTjVS3mYaBewh06exUWQs0vA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793998611;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=hF/8cHol6oifLy6xHxGiLUqBkdJhttiK2PlLUMXUHto=;
	b=DI8Gq7a4cK56t7wjpThIp/RV4kcdxuluxcLeb7ljZylgwRnq7yoe82wWljt6Kj/fEiVw
	 1cK4mKVtEHM33Euvx0/TO8911hXchayfG2pWZ44g2GO5YeyHx9tjIUB6y0Z9QBED/XwkF
	 8nW5t2SBK0xiCX4jk/RLY7eIpVt0Pk4M3ed+aQ0xxDedAU9NKRwpJSpBNBnMr32p/AvNJ
	 MnlDKlxCi+VRMp7V9S1dU+0PCH38wbyVkGch/JeK5yGdBaGpoFLkXPqReiKt8DRx1852S
	 BFoUn0x7R/Qyr7C0NkqHj08getFkVLis6Dg+3SZvV+68jR4K/dG+TfkIwbhWK2bMU0Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 48AC11F0089F;
	Fri,  6 Nov 2026 20:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793998611;
	bh=hF/8cHol6oifLy6xHxGiLUqBkdJhttiK2PlLUMXUHto=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=W/CTDNnenmcWp/VUovWshCWYE5fr7zps3g/LtbjD4hsLwuYiaWGqdroKal4xBCGin
	 FKAaqm6YBoeyxCmP7x7rUoCqMNTWezLRbGgzouVpq6nvwn7dtNaw288ZLIx0sw5cNI
	 wuDFNKrDF9CL5qaq1BbelJJc0qzpeWsrEz8rZaOAckDOcy7FHil3kgjmK66ykwhZRC
	 sZvDIzHDd2KXO5HxUqsjI3hJi18DfwTVsE8Sd2CH/3SQoUiiwO3+evhbvdNqn+jv/z
	 KnI+RM0b4QOIGJMdwOsfqiUqyvwkuDDVDjfY1HCsOQhshLdOrNTTrO8HicznOJW7or
	 QhbHjR7de13fQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C8D7E4787B;
	Fri,  6 Nov 2026 20:56:50 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Fri, 06 Nov 2026 21:56:29 +0100
Subject: [PATCH v2 1/2] dt-bindings: iio: light: Add Capella CM3217
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
Message-Id: <20261106-upstream-iio-cm3217-v2-1-d97adde9171c@tsv-stahl-riesa.de>
References: <20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de>
In-Reply-To: <20261106-upstream-iio-cm3217-v2-0-d97adde9171c@tsv-stahl-riesa.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793998608; l=2155;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=RVztLRvLE2XHZl0smZ+iXBmMb3aWuOAd6PH4N53y5GY=;
 b=C4AieDI9YGOFjRxPrCLPVknDSODMUmQygjomFWzyROfdpHyk1AkmT5fVQJ62JM3+b9ZfuXIGx
 eSMzXKx1f7mAZTW8s3c5uML/kKZ6zXiQgBNfc1UOh8KgnlpzJOe+7y5
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
the second one is fixed.

The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
Tablet.

Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 .../bindings/iio/light/capella,cm3217.yaml         | 51 ++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
new file mode 100644
index 000000000000..7f2a0d5d0243
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
@@ -0,0 +1,51 @@
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
+  line.
+
+properties:
+  compatible:
+    const: capella,cm3217
+
+  reg:
+    description:
+      The sensor always occupies the two fixed I2C addresses 0x10 and 0x11.
+      Writing a byte to 0x10 sets command byte 1 (shutdown and IT_T), reading
+      a byte from it returns the high byte of the light count. Writing a byte
+      to 0x11 sets command byte 2 (FD_IT), reading a byte from it returns the
+      low byte. Only the first address is given here, the second one is
+      implied.
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


