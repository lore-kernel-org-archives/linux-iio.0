Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370DD3290A9
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778440227; cv=none; b=K+h96fFyknpyyj08CLqznlkuUJHJVRpWWRM3ESvuW3m+9tEHoKvJ5V6skmFTAEXlkN0EDJR3CDGiVkJZH4fMV+cbt0JCjF8NUKp7xS+88W3xXuJk+zNTegJoBeKfmjuIGDP+R9NDXlZUyYO8kt01yBWyVw+5jBeJZuNDeScfSdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778440227; c=relaxed/simple;
	bh=M6Dx83Ui69Hc+PRyWZEaRE3zW/Ly+1sPAzVLBH6r4vA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=P7/C0Y1mKTmE/16ibLjkO4zwAjf+Le0Y7ac6agvYIoA3rO1esE/EgRLHn0ojq1e17sdEg11UxqqTCkWqOOII3rJB2lYNYuAitdyvP48xKyjqdA6P5qcdv3Dirh7r/uFm50ytb8iykFm/6XbBKJDuO6p2rVrW3ayeLGaTDafaBvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hpL5b9r5; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hpL5b9r5"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2baef9f5ecdso17673905ad.1
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778440225; x=1779045025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SYxE166qH0s2fjU8ewtwMDqscaCiwZ73Fz5HIN1pOHQ=;
        b=hpL5b9r5ByAv4fyPu+p/AlKCxo8Jb/vNZcgEfHX2XrKgRhUTuDvzAM7QGMMjaHiKPb
         GSKoymBirTVCkXUhybBPRr9FKiBgE3rVUbVNNGV9QdyNqplPVkk4BgdprwjikjTJchb2
         ws61aCktcMq8r9GqN3rAJzp6wJINZMfHN1VyaU7uYc6yWV2T6iYi8gE4L8eW9WsSRn1A
         Fq1WsTiyJWYgUyLmnRoDFuSWcDzbbHldP1bZ/KHUofwsgfPwBcF277cS8EuBL+R7l7RX
         jN4VHp2iWUi3pYsMksOnnl9IQ6c+cDtTdy1F6ELk2ip6V8ASJequZ03j5T76Oe5gESt3
         fDlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778440225; x=1779045025;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SYxE166qH0s2fjU8ewtwMDqscaCiwZ73Fz5HIN1pOHQ=;
        b=EQ7dPM5gEa/EugjMlNCNtLruYcEKd21VEVqIPkNZSuo3GtkAtQqM9JQFY6b8RtF1Jl
         a4ddXHVrDdB14ReTtC7zb4c9f0eIiIBm5FulUhs2ywPY5qEAlUbi2p1zvQtQze3jF+PC
         pDgYvthDL9rjIbLk2MTUvyRDHpngVfbM09Y610cN+fyuZ0gU2XKwR/L9Y/47hefJKR17
         8h1NaZ4ylD2Cs9nyYprl9xaKsKb3K0OBMPYiCNRRhifjGW6hAZrk6Tez8hTbyqfJEQF9
         f/S8PLlnVD7z1n6S5OEupm33uzvTociNoGKJI3kB8szd4u6wAZLCwBYKkIzEhJuFUo6k
         0PYQ==
X-Forwarded-Encrypted: i=1; AFNElJ/E++NhLETRPMpOQWjx6AcbOkIxFBaIOdkxdJfyHNYtcwSYtEzrarNPNebe9bcwCyu/4hxWyT3wves=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxbz1BSvX42BOFXa05oLtAk3HZaofMyTeFHIOf2QRVCFusVk+dF
	7HfI9KFSxfKaDDqfjJM450txxCaIIfseg2p5hSBJQS1URh220XGd6Pg=
X-Gm-Gg: Acq92OFd1ZFKAb58eGBmbzf/K523wRVZ+jLFlDwi9qafJ5NcFgv6Kr+kkZnO9fk5qoL
	t9bFLKWP9/dMQeUyjwO5cztfGsM5VypfIGZeeXUxozsBtS/AOl146qpkh+jXHr85BwmSIQeidZR
	JWKmAje0qOsIHiIbJRmM8/HQT4d7RIcw1Xpz8BrxZ8oYtWMGSjhL6eC5Tg3RugaLjJ7yt1+Bzhg
	pplaGf8hV7FErSFGxwO0pCyVCdUoh0hzSZmSFV9NEEAm9eAGdav2xYw/m/ePTRKeNj6QMHTxQOa
	Ctru15j6CKc4CXJ9IDr37kS7tA122gbuWo16hhZlQVmzJ0S0/+hkFBvXqc76bXQkg01h/33keIU
	XWXYBUaNeUYlmB4nMWujQ1OVpPprCcW4dBOYufX62MNG/N15njqGwyOiFP7HcnYK3iAJ0NcrpWU
	+wIfo83Jy0e5PSkecKVOJYoajb1JhEY0/CSrfaaM2keZtt7YWO9+opAZqvasTLFHQ6YDPfMQWKA
	Sw=
X-Received: by 2002:a17:903:3bac:b0:2bc:7662:90b6 with SMTP id d9443c01a7336-2bc7aa11bbcmr69633725ad.25.1778440225491;
        Sun, 10 May 2026 12:10:25 -0700 (PDT)
Received: from localhost.localdomain ([103.76.103.36])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1c5466bsm81817305ad.0.2026.05.10.12.10.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 12:10:24 -0700 (PDT)
From: Nikhil Gautam <nikhilgtr@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nikhil Gautam <nikhilgtr@gmail.com>
Subject: [RFC PATCH 1/2] dt-bindings: iio: magnetometer: add Melexis MLX90393
Date: Mon, 11 May 2026 00:40:09 +0530
Message-Id: <20260510191010.155380-2-nikhilgtr@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20260510191010.155380-1-nikhilgtr@gmail.com>
References: <20260510191010.155380-1-nikhilgtr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree bindings for the Melexis MLX90393
3-axis magnetometer and temperature sensor.

The device supports magnetic field and temperature
measurements over I2C and SPI interfaces.

This initial binding documents the I2C interface.

Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
---
 .../iio/magnetometer/melexis,mlx90393.yaml    | 39 +++++++++++++++++++
 1 file changed, 39 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml

diff --git a/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
new file mode 100644
index 000000000000..b99629ff2585
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/magnetometer/melexis,mlx90393.yaml
@@ -0,0 +1,39 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/magnetometer/melexis,mlx90393.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Melexis MLX90393 magnetometer sensor
+
+maintainers:
+  - Nikhil Gautam <nikhilgtr@gmail.com>
+
+description:
+  Melexis MLX90393 3-axis magnetometer and temperature sensor.
+
+properties:
+  compatible:
+    enum:
+      - melexis,mlx90393
+
+  reg:
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        magnetometer@c {
+            compatible = "melexis,mlx90393";
+            reg = <0x0c>;
+        };
+    };
-- 
2.39.5

