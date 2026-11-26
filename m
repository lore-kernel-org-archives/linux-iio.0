Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795680721;
	b=L0SXw+cDBJRlrc5hkMTMsQp4wGvSVzixsHVWzXHKeee+sorEaWF6+doqWJoiPHjQjZy0
	 /t+zci7ttZbzDihA8p2J7IE2QBJrcrjrGds5ItnMRc956IwIklJxuoUno62hzoJkfU9NA
	 FipMwhDACvNiTVh/Nnl303pQ43EWsX8uABAwUkgbKCjpJWknVw/nIAqPCkMhjgtAdNbRm
	 n+0DrA3TzmK6LcCZ2W17O5Uj+OvqRfs9NirodTXGzSGqJPP3nnMPwbsmvTt8OvphqcIfp
	 R8+wqQkmt7NPsuOjvC/Y/fHNmJjtkq3pnu4xHZyi1bw8mV+9AxX77ke6OuJFX6u7R3g==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795680721;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9/G1Vu6zc8fcopapjdqUOr2ovRpO+znKcwj1cdx0q48=;
	b=hhB8TQnqV6byCba+hw1dTRI6Mb0aFzpG717a3NfQAqkjJ8f7wgCrkRKo+nr1kNU9wwMu
	 b+NFMDOpzXTDwHd8TbGbCXOboo+/aoPBOkNveGsVmPcKUBnu4+sy3jW0YGwmxJMyrAQxP
	 x0fymu4j1i1KloW3iv0dcMbS8cbnjsdvhPSvGUfPHmOKoc71dCbAsMFcjvRzb7ZmA5pQl
	 DqG6BJ7wxbtCl9iN1RQJcwFD2l8e/7l65TZazel8wLS+dqzXvenh6TJdT4ivrPhpkIzlv
	 FCMyjs/ZnNPGRZe1MsmfEzJ9bkgR1Np9UcbMtFUWzdvIkAAFyZXAb99dhBqZjz4/dtw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozkxIMx0;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3F2606A31E;
	Thu, 26 Nov 2026 08:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ozkxIMx0
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795680721;
	b=vIhl/0He4ca3LBkZlGuSznNQbXuyIiw+AwXWK09vr2YmuzG6vuVYFUA7uYORqHJgDr7K
	 gMWI/uhFYXA0MPhX+pk1Z01yzi56StPDjLcPqo9WDwEU9nNNTLeC5R4kbGPo9adBMc7pz
	 jiUl8W2KiCAusomSXmrIFxD4NiIAN7QgdGia7YQDcb3C62HlmH5RA/eXXq9AT5qiSgbkz
	 RWLBLxH1NRRmn5Y3//ySzjoCJJI/LmE61glRue5+LVE13mwb/O2+BgBaTEqRsX/uOUqfQ
	 5zJMXIPbbCKf+HQczOFNuRnmfV/zW2WyDPnV+l+akUIjMnTXePjO/+MrH9eR/6bvcPg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795680721;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=9/G1Vu6zc8fcopapjdqUOr2ovRpO+znKcwj1cdx0q48=;
	b=OH9KPwq3PfZY1ZOIagOWehwJ1ZhFYvOUPvvVfCeHefV1emn488e1mrN4OjiEX6608cE9
	 EjzarycU5aZZwT/M5NQ1zYRHPVXwC+F2cCsi+VPpIafotLd9C2PNfW+2gAWohOGYrShOm
	 bVhJm6isQQDRyaNpqbRNrbZbymoO8Rpa/EDKZ9/VWdVUsw4ICw3YLUlgsaAqOn7GfJIIS
	 GL/cswo0929ZRTmiMDj+y0KjGFvVrH3bacKSsHm2w/RztsVrBFhvrgohl0OvF2XPzeYcp
	 Yi47pfSsHknpgU+05JgyVZzQxKuil6gmG506F7l73xqmNAuzapDqCa8MBCHS+sNZj1Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 13BC51F000C0;
	Thu, 26 Nov 2026 08:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795680721;
	bh=9/G1Vu6zc8fcopapjdqUOr2ovRpO+znKcwj1cdx0q48=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=ozkxIMx0Ch/jCd5eR7I5sdvTSd27fvmDm5lwVWFiX7cjg8Dpqhf4+K3RtBwiNnkqy
	 MQzzDmWp/uIwz7HqEAw7miM3AuBwkO+RZbckJrwtLw7mLsqsKARLqdqlvmMv5ZCDtF
	 IIBgybsLm6nGT6oEFbPydZs9Pz2+cLEe65TrB446BbZwkEkNmkBugA0IYJAGwZ6/qK
	 rMBAeuFblKVvUUkim3tHRGgkzO2AQ8denDPXeVH06uRVugUv47RToVtER/JE+9dmLt
	 QK5PZI654uVsgp91zcAAlf8Lb5So3utgG2cHhTB9NaQ93YVk7RryWdwabfQnQQOHkP
	 vL57n1q+I0iuQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 83BB44D2E5;
	Thu, 26 Nov 2026 08:11:47 +0000 (UTC)
From: Robert Ijtsma via B4 Relay <devnull+robertijtsma.gmail.com@kernel.org>
Date: Thu, 26 Nov 2026 09:11:47 +0100
Subject: [PATCH v2 1/2] dt-bindings: iio: light: add ams OSRAM TCS3430
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
Message-Id: <20261126-iio-tcs3430-v2-1-6c5329d20919@gmail.com>
References: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
In-Reply-To: <20261126-iio-tcs3430-v2-0-6c5329d20919@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robert Ijtsma <robertijtsma@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795680706; l=2571;
 i=robertijtsma@gmail.com; s=20261122; h=from:subject:message-id;
 bh=oT2YcBwRHJlAGiUMywD1VuA9hLwSIhrT+EC9d5oP2Lw=;
 b=PFA3h61Ctb/pGXgYJNcTfov11ejFZoLGU7QDLD8L596VnE+/BD5+tES4c0Rhdiu1c+FqRTIOU
 GKrAK5M7GsSBTe4sDHL+eWZO/F5WEPaIW9rxpdvCxgdXbUwbVjv8IbH
X-Developer-Key: i=robertijtsma@gmail.com; a=ed25519;
 pk=qiDyKVqFicxFIR5sB5m+p9SWPKL2/+mMoiQnUx0C9P0=
X-Endpoint-Received: by B4 Relay for robertijtsma@gmail.com/20261122 with
 auth_id=1604
X-Original-From: Robert Ijtsma <robertijtsma@gmail.com>
Reply-To: robertijtsma@gmail.com
Content-Transfer-Encoding: 7bit

From: Robert Ijtsma <robertijtsma@gmail.com>

Add Devicetree binding schema for the ams OSRAM TCS3430 ambient light
and CIE 1931 XYZ tristimulus color sensor.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Signed-off-by: Robert Ijtsma <robertijtsma@gmail.com>
---
 .../devicetree/bindings/iio/light/ams,tcs3430.yaml | 52 ++++++++++++++++++++++
 MAINTAINERS                                        |  5 +++
 2 files changed, 57 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
new file mode 100644
index 0000000000000000000000000000000000000000..085a70e5557b1b5201bdd11e00736af065e002de
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
@@ -0,0 +1,52 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/ams,tcs3430.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: ams OSRAM TCS3430 XYZ Tristimulus Color and Ambient Light Sensor
+
+maintainers:
+  - Robert Ijtsma <robertijtsma@gmail.com>
+
+description: |
+  The ams OSRAM TCS3430 is an I2C ambient light and CIE 1931 XYZ tristimulus
+  color sensor with photopic Y, Z, X, and IR channels.
+
+  Datasheet: https://look.ams-osram.com/m/43d518b4cd81e3f2/original/TCS3430-DS000539.pdf
+
+properties:
+  compatible:
+    const: ams,tcs3430
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  interrupts:
+    maxItems: 1
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
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@39 {
+            compatible = "ams,tcs3430";
+            reg = <0x39>;
+            vdd-supply = <&vdd_reg>;
+            interrupts = <24 IRQ_TYPE_LEVEL_LOW>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index 44540a1eb2b8088f9da95a9b6f83b4bf05188ee1..ea8ebd8ccd849702e82bf6aaeb4d8d60c2255628 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1489,6 +1489,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/ams,as73211.yaml
 F:	drivers/iio/light/as73211.c
 
+AMS TCS3430 DRIVER
+M:	Robert Ijtsma <robertijtsma@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/ams,tcs3430.yaml
+
 AMT (Automatic Multicast Tunneling)
 M:	Taehee Yoo <ap420073@gmail.com>
 L:	netdev@vger.kernel.org

-- 
2.47.3


