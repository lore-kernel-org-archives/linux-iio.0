Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8523CC323
	for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 07:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779782122; cv=none; b=Ccf6RrteG9nbyIIHa6reevcuiVISSem+1gdDo1qTZDdcQUFtM/lTKU3Q3Mi+L6+HMTYagqcel2dAU03iRKj1RWocp4cWgLNh+YC0IZxUpx73kwPVinm6yF+0eY1e46QmhFd5HRSjweJm6woDJdlwV0H070Nw0S9b73YtmAORyMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779782122; c=relaxed/simple;
	bh=QV0YlTAU2lskKT3uhQB3b6jvRCJQlkRZdCcoZ9mgN0E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ddlz4yLpM+kf/AeGKY1UAAGYlLV7UMP1lDPbxEYkfiUDMpO0ywbEeVrZA37GBDVxy+nGpv8THtvKfv3NoRkUlpE9kTRDHFuYX2UzmW2GKvBpqxdQh9KSLeXPe0KKqUXZ7VMtn2ZJUsuZkeuWNzIA/terDyoZKsoW7k1wXsBCc4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oLjgnKbq; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oLjgnKbq"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-449de065cb3so9987775f8f.2
        for <linux-iio@vger.kernel.org>; Tue, 26 May 2026 00:55:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779782118; x=1780386918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D2aPyhO7hzXrLKywYqgkmZvTv+qfhylQJCaKMaJ/KcY=;
        b=oLjgnKbqHoIDzwJuvDMLsvrPbxh7ye7T/thlzz16Fo0kWvuJHtNVIjmrhd3+rGp7o+
         pCHZGXHOp3agQwNRsQToht9z85J486FS80MgkacalJBgyQK328vtDtsTVhYE0gQs6z7w
         ZxtL7LebjTrQZ5uSYWEQoTwzX6Vq7V2C86sfFORfIfaynYKIW8yP5JImPWbf7A4f+vPB
         QJH3lhlRRj9IqCzSc7OwZTsto7s7u+GNOmmyaJWWKs6nRUd3YqAsG8ES6zjI+Uu3MdJP
         Ieriy4SBpc9JdFLl5n+n9+HMTvS/3IscBqX7pGOroMeVJArHuFw1lSeJgFMKiYREAlNl
         V59w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779782118; x=1780386918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D2aPyhO7hzXrLKywYqgkmZvTv+qfhylQJCaKMaJ/KcY=;
        b=McL8s9trao0oN3g53MZkvGjEJKUbJFF8UJjr04EMyh9+r7NFzogAUq2ooPxhtfKodr
         vPkPwIQBbPOnJRN8DjHoQw2t81eA+KmnObLR1lnv3ZecMqa3ktOip1a1iqSH41MeSjw/
         X49q8ivT7fOifvC5yt8n7ApP2BTMrxQTHV9AmWTbWDs0zQAw03Ur1C693QqmvdbUxUJt
         1JuipWivNWut1eWQjPrka0ecbaggCWinfNb8PYwrNqFYmpeBvanmF8oUFyCFyXWbsiYS
         0kfGO5KA2sutHqGq4xkhBmjA91RQBsnMVZ4C8XxVtd9MRpHBG5nudPwWUHwJJoJ2yKPX
         ycpw==
X-Gm-Message-State: AOJu0Yyt6FXv290Er1RxLnJ/nqKuNCwFQHhEvQQU+ETOTFNOsdsQDnr0
	GT9Bs5+UPOie0tIO3uA3iZAqKRwskIvEhEmf6XM9OhM+mRmRBMnEXVuV8cgrlpir
X-Gm-Gg: Acq92OFj+/QZM3RmDYXDKSzKwdrnDP53J11ZcVXU3RbxZWlS5gu0S6m26+9Glkb7Tvv
	pMRtNO1ZcJPSTEL3+LzHNO+BmaENujyHiuxfUD88Sw3VO0H3+XYjYaJWrJj2RW/HZSu4usc22wo
	ThLizYzoruFeuEH08UYVssqBkaQWkeC7ytGYe12FyAwigXFope2ExcucSVKq4Jq8iKWl0OxKc8/
	S+Oy1JhfPVq0UUCpQHF68JMGPUrI43719EATS83XXmvXmMkQ7DGC5aqqv9HehWai0ymSYeABBCQ
	Pn2vPApIeLY/WvpwtZ6Df0XPjx6uzFdxHz7WJgjwArpW4EETxiewFEZu780UlEvbpIKFyWnQyb1
	gtrdPg0/849wgfY6mHWWGIkNpqac0SRGPnnYOCFswsVbVfUodTFqoQpvArVKumfHPkwLDZLHJvD
	iHnoH87s2yCQ84E6YhicczJfPDkR4=
X-Received: by 2002:a05:600c:4f82:b0:490:48e2:5618 with SMTP id 5b1f17b1804b1-49048e257admr254826205e9.22.1779782117880;
        Tue, 26 May 2026 00:55:17 -0700 (PDT)
Received: from gmail.com ([79.116.203.237])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d4ca0dsm32916475f8f.18.2026.05.26.00.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 00:55:17 -0700 (PDT)
Date: Tue, 26 May 2026 09:55:15 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	devicetree@vger.kernel.org
Subject: [PATCH v4 1/2] dt-bindings: iio: light: add Broadcom APDS9999
Message-ID: <2da5163825ceb794c73c9aebb5cadf6ab3728097.1779781224.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1779781224.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779781224.git.azpijr@gmail.com>

Add Device Tree binding for the Broadcom APDS9999 ambient light
and proximity sensor. A separate binding file is used rather
than merging with avago,apds9300.yaml because the APDS9999
has an additional vcsel-supply for the VCSEL.

The APDS9999 features individual R, G, B, and IR channels with
a green channel that uses optical coating to approximate the
human eye spectral response for ALS/lux measurements. Calibrated
RGB color sensing is not yet implemented in the driver.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 .../bindings/iio/light/brcm,apds9999.yaml     | 54 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 60 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
new file mode 100644
index 000000000000..9f5b3b294c2c
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/brcm,apds9999.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Broadcom APDS-9999 Digital Proximity and RGB Sensor
+
+maintainers:
+  - Jose A. Perez de Azpillaga <azpijr@gmail.com>
+
+description: |
+  Broadcom APDS-9999 is a digital proximity and RGB sensor with
+  ambient light sensing (ALS) capability. The device uses individual
+  R, G, B, and IR channels plus a Vertical Cavity Surface Emitting
+  Laser (VCSEL) for proximity detection.
+
+  Datasheet: https://docs.broadcom.com/docs/APDS-9999-DS
+
+properties:
+  compatible:
+    enum:
+      - brcm,apds9999
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  vcsel-supply:
+    description: VCSEL power supply (VVCSEL pin)
+
+  interrupts:
+    maxItems: 1
+
+additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - vdd-supply
+
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        light-sensor@52 {
+            compatible = "brcm,apds9999";
+            reg = <0x52>;
+            vdd-supply = <&vdd_reg>;
+            vcsel-supply = <&vcsel_reg>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1aa9c989973f..2d8d4e2eab6e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -5000,6 +5000,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/brcm,apds9160.yaml
 F:	drivers/iio/light/apds9160.c

+BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
+M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
+
 BROADCOM ASP 2.0 ETHERNET DRIVER
 M:	Justin Chen <justin.chen@broadcom.com>
 M:	Florian Fainelli <florian.fainelli@broadcom.com>
