Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794599945;
	b=rITgmoRzkZXrzZsswsackqRkxk3dWFpM1icT/LGOVSqkBQDD7mOO5Y0n0rXUDw3X29SJ
	 ZnYxAKpEfDtfz9EvGKTPqD+2ZLbs7DNYwAknwpgbfjziF9TAGX+1jUTCt4qU9R1j7cBRm
	 nywjk+nfAVlM1T4/J30BKlCmIzIpNmK/BXVmACSLoxyq5bXgMoTEsADlL7vX7qljYsmkK
	 JHSYNFuyxwSNgzvlIcqUSWPOy39NN6uxsW/t3Ume/7RwuU5NDJokEuM13wmXXnAv1Y9hs
	 OUWWFZrArRzKREAANwzASZd2ZedsuJHMhaOqxv8Z6zkOYQf4WsSQfP5WEmmKM5qD//g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794599945;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8d7moL64qRIbbil14RkFEI96WRP1DNirjzCKrhmfays=;
	b=U8K2f9GUH6no7/ny1yQH0A2nRg/avOnSR1nskY8rsjNlDodFZz1pMijKWo9os8by0Wqd
	 u0Y+H6QrWGXFTuRR2fexDqbbq+h+oR8+sqmm+NbPqvKsPXkfL/lW0gPJAiUHBIWMkeAUS
	 RwyY7vgReMWcLpvM7JflZCzVegPq1/sz9oU7ppAC9w8e2EZvJuNU64EtKGEb02g1AtHIo
	 3EntplnTfNGChcDMQx/KbLb8y54HndZ4yWIzwNT9ro0wNjQ2Gim/Ysyw7FDcKBFc7rR4+
	 kP4o7IYa/RB3YfFpTqK70oBuWHIyzlOxnH9bWo4nLY7AViC49fTYH1Hd39ddD8O01Ig==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="dcr+Ry/e";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E412D606A8B3;
	Fri, 13 Nov 2026 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dcr+Ry/e
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794599944;
	b=Xdw7Bcf3BvVIQLPnfYYXNyFwcloICeGv7n1KMapIEsxsIirJI7DIZG8uU3qDU3p4a83g
	 wRRNEaz/0XfkLPwF/QYseeLl51BrGVvGJxZLApmiAzAEaLuo1wwULTfi7lDEDCVBV64LO
	 A/1d1Q5eRZvmIG/Xz0AcsCOup76dnNuWeTNSLcWaDddU9RqB9WggnUC7xmQzRqopL3Ht+
	 lCykrW2HtQjJQ5uw9BErpYvXGQZ8iDu1rylxud/H0RdTY0RT4Xtf3A6slcdciZ1FASsJ5
	 YzUpdHp0+SEi4VUsEkLV0Qu/OlnHRCqLvGwt0il/8NMGZu/EpKnWUZr+0fnWfWaSSMw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794599944;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8d7moL64qRIbbil14RkFEI96WRP1DNirjzCKrhmfays=;
	b=FuZt3eIVUmuAS+aQAIW5LdXoHk39LR8zfMHoFZwAsOzLlnTqnAW6T0larSDI5LOWeGWt
	 E2wLiD68FS805cMixWRS1Ca+VgBk0Fv2od2plHLl/DPovmUelI2BNnIuGHd9w6eiW/pRR
	 lutjiC4jtSu35EO5IMPOdNLA9qBcpEGcK9MrN8HZcG2P1vZ9D/ngD7WrjkHUZLR/eNdaV
	 YT6/CVcc9coPxD462GU4EsP9PMK1oG3X5N039kaSdCs4ProsGATjQwA4NbGR98XGXIPTg
	 FRhuoWOjBQT5FMB9MU2C2cWx27J1rkgag+tRz92fUVaU94tBagO72Qel1U7Q7I0sI7A==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0893F1F000C5;
	Fri, 13 Nov 2026 19:59:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794599944;
	bh=8d7moL64qRIbbil14RkFEI96WRP1DNirjzCKrhmfays=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=dcr+Ry/eHnwvVlrI0j0tSMBkpl3xDBR8sqcZKKkXGa3yZVsouQUSzdMgKhdlpdelG
	 za949qc8em6k9NrksJ7nbrpr+zt8nT/XAOTkXMaJhU9b7ggiZYATdbenWhxPSvWSgo
	 dIVuYpil3Jdysq8260gbFobdDxlevjj9hmKQ6eUkaLd+j7Kh19eSXgBpIq4KKrjT7g
	 g1f4HB4YyH6qLUA+dk0e7LkvNyDysaw9NF8otEQR4hUJYznGqZxT5Gtcrv9bpOolR2
	 Rm7SABKaDTpeNWXM8dxrsWh3ie9RFwe+mRb82LeYXTBGJFXmXte+vjE+AjO+PU7c+2
	 B44mp6OcXCzyw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 8822B49AAF;
	Fri, 13 Nov 2026 19:59:03 +0000 (UTC)
From: Patrick Fischer via B4 Relay <devnull+admin.tsv-stahl-riesa.de@kernel.org>
Date: Fri, 13 Nov 2026 20:58:59 +0100
Subject: [PATCH v3 1/2] dt-bindings: iio: light: Add Capella CM3217
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
Message-Id: <20261113-upstream-iio-cm3217-v3-1-c4d5b2485dff@tsv-stahl-riesa.de>
References: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
In-Reply-To: <20261113-upstream-iio-cm3217-v3-0-c4d5b2485dff@tsv-stahl-riesa.de>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794599942; l=1979;
 i=admin@tsv-stahl-riesa.de; s=20261020; h=from:subject:message-id;
 bh=z7mQtMfNm0xaT/KOZpQZ7OocJj4b4MNfSXLn05ky7ZE=;
 b=d1yhZ5y8Bd9Jkfpclza3JAOkx/JvqIT6pc5wkJ/CqlaTICFCyF6FfLEROQiR+KUgikhtMTYyA
 IYTbGD4cn6oAeqsorDVqNbcKtcrnmBZCQhWohUKJO4LClJNHT2X2B9d
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

Signed-off-by: Patrick Fischer <admin@tsv-stahl-riesa.de>
---
 .../bindings/iio/light/capella,cm3217.yaml         | 50 ++++++++++++++++++++++
 1 file changed, 50 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
new file mode 100644
index 000000000000..9aba05949a27
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/capella,cm3217.yaml
@@ -0,0 +1,50 @@
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
2.56.0


