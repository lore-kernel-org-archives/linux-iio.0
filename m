Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765AB1FF7C8
	for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 00:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782002800; cv=none; b=I3FEaqc5la8wisDq/Bz6733+ESAIHVj0DjQ75Vgfn7Q6KBxjJbujB9VuIKv/icl2ELsmEbLCwtdGthiNf0WGvBTVIJ6Yz9XKg6sNzUIduwoC4TdqPgc82x+xgzPQb2aqKPv8+vdpMM049cbxiDlJougyPnnN3DQyw6YNuXZj3N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782002800; c=relaxed/simple;
	bh=5TTxQ3I91yDsizRvGxC6wGurDup/AtF5mbCDjYKei1M=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDQRbyzZ7CSXPaY/0YY8xBm40nzsjSE24wgl4FYgXo6qTJQO/7CplgBA+9kXbGEUIFd1DXv1q9rclgOneSxoA4rym1J40zjW6nfpfeY3ukpDJcNqGr/OeZglrU/PRKtrF8Ikr3oHkATuWSiMO+AbVrceycxuqzqppy0k4E6sVLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QQ+PYWpe; arc=none smtp.client-ip=209.85.160.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QQ+PYWpe"
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-43ccd4f6f6eso2236752fac.0
        for <linux-iio@vger.kernel.org>; Sat, 20 Jun 2026 17:46:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782002790; x=1782607590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6UcOBkVQ+LuwHq0/corgNyTz2DMj/Og0DSgHE/NFxEw=;
        b=QQ+PYWpetG9zk+hisGM4B2Xa3x4V3uLwp9TShUJLa/29KnYerBghnhlDxw6UAUbjHB
         0D/V/VMjTnue43rnDYXc4nci5HHvtawBUKrNl7hGHXmZ7C3Nt/mgPVjmPJLz9kaeMIRi
         fcAeynmVeUzkE2HZ4mGnFGIEs6L4hoVZouAE7/LBtWWwnVTS33t+N2Z1kTgTA7Dvi+d9
         uK9BKF7pIKmdMpBQVKJKE5rO1YYkolSzdJw/GinPfXYtbPKrUY2gx2qgz+1UH5B0Qk1s
         WXJWG8Zjrz1cU0oyFzmb/XGi63UKTo2RWmJGoXKV8Nn1KDWxDMq9aNU7mpa7JA4mZz+w
         dNAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782002790; x=1782607590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6UcOBkVQ+LuwHq0/corgNyTz2DMj/Og0DSgHE/NFxEw=;
        b=Xj3hxPhwSjKI9NYlhMPp1alDStJ88H4akAOnoxLLSw5rxijfdY8Q9rf134qFVnhI0l
         NmY27pYL7br9Td94IHG1yeZfUecMcJyWAx7duLg0YU9wOL8q9r1QwZS8B3JuQH9iRDF7
         0v3r45G+dtCBzSbKUjYqO6YtDd6mlborGTndY1BpPs/3TilPz6QR1VdqY46452qkHOgz
         UxeS8JFx2U1b8ba4wL9Dt2PBjLf+Piwno6ST+MJ13lU1vl2D08mcbZU6Fkst+xEEfqWS
         iSDTNvR/hOiLa2/DTn+E5I14nsuveHZVdVr+D/O6QdHrEjr8t/fe3oSA62x5x+AD0Kw5
         bbGw==
X-Forwarded-Encrypted: i=1; AHgh+RrE96UXe7LLnhLihOIYqd3cciwnAbGCKBkrYlPJDS1vVjiNd6iAEekaKJBXnft+8Ro91hoTExQ6ihw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywru8vj+46J6zJtGz4vzndeqWOw06bUuLc4Dvsz81Fw25UKk98S
	Vs8c3ZZ2frfECzIhW+S9vRqU7u6S6qCJtJEtJy+PVQCATSbi6gQz5BzR
X-Gm-Gg: AfdE7cnUPu47tVxrORi1fpgws/LBZWQ2gNshXqpQYXfUF+RcMK5982vt5f9O3u01PdN
	8JWTX953Fr76SRs21wSOj+5lkxU5BDNz2czhBu0PomncVIAtYWxgLFWFEYRpf8vg713GC06s733
	iS6to3ZYScOFv6QVdv7iE7loli/GVrEj0rHOnt2D7nl/7SW+BPC5pVRXX3JsGheGOIg6JMXmL5U
	Gtjx2KQ2QKjYi5sxdcXt+glKViABTNS9XQTxR61mPG+jg+zf+cAhNdsd9QF8/IhnlwneIx4NcHD
	Vb2KOYq/9OdQ4hu129JpOLc53hgaZu9TgPFrjCM79gH1D7JFulamWL8IQBMOrcPQQphZCiJgwCa
	mNLUe80jDKWcstwBXFq18JKOJsLPM3o5Foru4L+YwlcxHbfIWZwtBz/E7Holw0jw8oGGy1I3sD2
	yKOznrEghSBcD4iyTsMoxqcL6aNFySzJekJw25O+aH+/eAgpE=
X-Received: by 2002:a05:6870:e386:b0:430:3ddf:9712 with SMTP id 586e51a60fabf-44707c309dfmr7829163fac.5.1782002790326;
        Sat, 20 Jun 2026 17:46:30 -0700 (PDT)
Received: from linuxescape.lan (23-88-128-2.fttp.usinternet.com. [23.88.128.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4472ec5fd4csm3080457fac.2.2026.06.20.17.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jun 2026 17:46:30 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2 1/2] dt-bindings: iio: temperature: Add STS30 devicetree bindings
Date: Sat, 20 Jun 2026 19:46:23 -0500
Message-ID: <20260621004626.66629-2-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260621004626.66629-1-m32285159@gmail.com>
References: <20260621004626.66629-1-m32285159@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the devicetree bindings for the STS30 family of temperature sensors.
The STS30 family of sensors includes the STS30, STS31, and STS35.

All devices in the STS30 family share the same commands, timings, etc.
The only difference between them is their measurement accuracy and
tolerance.

Additionally add MAINTAINERS entry for the driver.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
Changes since v1:
- Squashed parts of the MAINTAINERS commit into this commit.
- Added ALERT pin as an interrupt and in the examples.

 .../iio/temperature/sensirion,sts30.yaml      | 55 +++++++++++++++++++
 MAINTAINERS                                   |  5 ++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml

diff --git a/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml b/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
new file mode 100644
index 000000000000..9bb0f04795d4
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/temperature/sensirion,sts30.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STS30, STS31, and STS35 temperature iio sensors
+
+maintainers:
+  - Maxwell Doose <m32285159@gmail.com>
+
+description: |
+  Family of digital temperature sensors from Sensirion with I2C interface.
+  All devices are compatible with each other, their only differences are
+  their levels of accuracy.
+
+  Datasheet available at:
+  https://sensirion.com/media/documents/1DA31AFD/65D613A8/Datasheet_STS3x_DIS.pdf
+
+properties:
+  compatible:
+    enum:
+      - sensirion,sts30
+      - sensirion,sts31
+      - sensirion,sts35
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
+        temperature@4a {
+            compatible = "sensirion,sts30";
+            reg = <0x4a>;
+            vdd-supply = <&reg_3v3>;
+            interrupts = <2 IRQ_TYPE_EDGE_FALLING>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index d95d3ef77773..7f94b8cac3e2 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -24487,6 +24487,11 @@ F:	drivers/iio/chemical/sps30.c
 F:	drivers/iio/chemical/sps30_i2c.c
 F:	drivers/iio/chemical/sps30_serial.c
 
+SENSIRION STS30 TEMPERATURE SENSOR DRIVER
+M:	Maxwell Doose <m32285159@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/temperature/sensirion,sts30.yaml
+
 SERIAL DEVICE BUS
 M:	Rob Herring <robh@kernel.org>
 L:	linux-serial@vger.kernel.org
-- 
2.54.0

