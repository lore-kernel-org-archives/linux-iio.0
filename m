Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795822760;
	b=UPCM6g1/t38WKf5s7VAasvsKrJQJh9a/ZZItJxJCT/VlFqKFtmzyVdt+8HP3ZG1RnCYm
	 BW7DfKcmqZ8CEvTf/GKeRLnfIkD7ffLnP0vwYJ9q3Tz9H7but25gHVZzPpwkiDrnS88Ud
	 40TvAlQA+G2R8ZBR7t1xykZXJN6cdbGYN6E8IOLRjzDqtcSb7DwXwFm3Knkdcuk7nAZNB
	 O+fZLzC2lFpiAr8Bql+NdRXv46fMB09HjOL8XJfuRqTM3SFDEoX5a2lG+oX9ioOwbQwWg
	 t8DogVnbOgml+KNkgWaOwlPsPaLabZi+VQ9ifujHfJP5q++56HxQKxtdmPo/dFvwXTA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795822760;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+3RRMtZv6HW7DHQsn+frSa+HroU8cWD7aZOMbE37s68=;
	b=FzrIUHdjbYzHElxXI1zzqMBrILBrrFNbUExejznGHy7D0BWlXFXvMzcbzLFMBsk8ovTA
	 visOA3R+B+DUz+Juk9k1N6b7IamuAuq0tpASLddmc+r9rNrEHepXzFVnLw+hQcqUUKLY2
	 A2wO9nUxI1n3xz3ubzdvKFrd83YQm9G9fs7IoEHQZ4duSzLzhL2fznEuQpVsU9TcBICXq
	 +4XZfxyK1MdF35RnqriC25Zln9EfJceC7KnSbF+P3LeUBaW2XfCvcV4HhwFVDSrDieRjd
	 BXK+QME69ARqMrZ5sNGWtHPwiy+br5mBhGYsBNSg3fzsn0aVSDU5DJ5BbCNUB0cFnxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4Hwv9d2;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899FF606A31C;
	Fri, 27 Nov 2026 23:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=X4Hwv9d2
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795822760;
	b=oyBdaemEGUlsOuHQlDXbkZSzzhmjkxx5LipLN1Gvp7hEhoorZ5I+hpb63IndUgzrZ4M2
	 5mwjdrJj0wgKOl31ZBoiWAI/aIjwJimBKnRrdsgNURPjEdPr2Ag+lKGRXUAuU9K7U4DZg
	 BnYUwWnMiXiHLuHqI4UF10iVqcfvNaXahIaWtAJiNStCcEj1LRMuQatoYJn0KZE0tOvKh
	 wOyWvr2moEV9F9Fb0TRlI/+naenCT2dkIl43QV+gPLufe9C64TamG+lp0/RvHVMPu5Gxw
	 qmTWv2ysA58oYJoJ4gBWg9cejvgr2WYG1qKsc2DwlLzkxFXy5uV4u4buZIacZyDpS+w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795822760;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=+3RRMtZv6HW7DHQsn+frSa+HroU8cWD7aZOMbE37s68=;
	b=2ddsNZoRB7WGAeaWIqMG1cbbgZbtRZw4mMkHco9x3KRWSWbyMcRJIbhLRS7aBiUwmYP8
	 c1g/aS82M2ByLujcshLXL6EYazfGgiOqxbjmyvCcUsKF517eCFkoZdMwXAtj4jlZBR5SY
	 UnRohG0WmvxDA30wLH2fB393r0rvnDZ8mH1hM5p4qB+4//2q/CEHGtBlbhfOmlBLsw0jx
	 ID8Ujy/JoZAGg5z9RS3V9FdfY02YtIBEGUHSvojlErEZtsIRc+XfDlTVfOsDoLzI0pIh8
	 m1N2FPliUZyp55CFo9LjHayegvMSPn+dDOUggYFKqkwCjWV4dBlXS6u04y8jpZhhL7g==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 556B51F00893;
	Fri, 27 Nov 2026 23:39:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795822760;
	bh=+3RRMtZv6HW7DHQsn+frSa+HroU8cWD7aZOMbE37s68=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=X4Hwv9d2y9xr6+jvbtWZET5IXOtu0gp9K9T/l8FWJcxiNCfmvpXe1lLJ2VW8E5Hyr
	 7IfEKPu/SRZBH7v4vst/rKETbJhmnThQkH0ppb0zlWXCl+JB76uIs22OsnBZyF3glf
	 2d74VS0RhkkwRPCRtWCfOeQpHqwURkIMoYeV32pgZUNJNUSEZ0kzBMiNfI+uXXO2Jf
	 12BOHIx8uLGkGFJc0p/vBdkzHl0wOv81B1SafPs7pI/KtS32gnXdP6uFs6nwdLCqqV
	 LmO8ckj3z5Ylp9ake6PGPZMleCvc8Z8mfsf4OAghvoVRmw+kqyKU/Ex0Amjrjep76A
	 v4NahgrR1qFQw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id D34AE4DE85;
	Fri, 27 Nov 2026 23:39:15 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Sat, 28 Nov 2026 00:38:56 +0100
Subject: [PATCH v4 1/2] dt-bindings: iio: light: Add Capella CM3217
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
Message-Id: <20261128-upstream-iio-cm3217-v4-1-fdab04f40bbc@tsv-stahl-riesa.de>
References: <20261128-upstream-iio-cm3217-v4-0-fdab04f40bbc@tsv-stahl-riesa.de>
In-Reply-To: <20261128-upstream-iio-cm3217-v4-0-fdab04f40bbc@tsv-stahl-riesa.de>
To: Jonathan Cameron <jic23@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Kevin Tsai <ktsai@capellamicro.com>, 
 Svyatoslav Ryhel <clamor95@gmail.com>, linux-iio@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Patrick Fischer <admin@tsv-stahl-riesa.de>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795822755; l=2057;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=Qf+hCvwfO7ANZ6gJHm3yJLRxcLVAWMuBfi8uqq1FrSU=;
 b=ET6cguaw50TINTCrvqJ0WxCmlUlUfzsa+/FSgLA7x/WEklrg3cjdLmQYKTx+d0ZCvAbWRRD5t
 tcr9HXGiQYnB5UEK39yNy55SiiwTn75RwHKXxQWRNL9vdEQMCq8CkTR
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
the two fixed addresses 0x10 and 0x11, which are both listed in reg.

The sensor is used in the NVIDIA Tegra Note 7 and the NVIDIA Shield
Tablet.

Tool use: Claude Code wrote this binding.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 .../bindings/iio/light/capella,cm3217.yaml         | 49 ++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
new file mode 100644
index 000000000000..a03cdf2bd375
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
@@ -0,0 +1,49 @@
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
+  The CM3217 is an I2C ambient light sensor.
+
+properties:
+  compatible:
+    const: capella,cm3217
+
+  reg:
+    items:
+      - description:
+          Command byte 1 (shutdown and IT_T) on write, high byte of the light
+          count on read. Fixed at 0x10.
+      - description:
+          Command byte 2 (FD_IT) on write, low byte of the light count on
+          read. Fixed at 0x11.
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
+            reg = <0x10>, <0x11>;
+            vdd-supply = <&vdd_2v85_sen>;
+        };
+    };
+...

-- 
2.56.1


