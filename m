Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE506355F54
	for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 08:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778659810; cv=none; b=b+H5lBmpC6q2TnunkwjkcOy6/4FAfmYy0un/N/O8XaOaSndDnB2zkScaELPU98og4rIcGukMb6y1n9ieJmKlUtvEBQYJBvDtEKktDVGHVneDet8fjSMYUL4c8N/kJgLjkEvUmDdCUBk/gwwClEMBaNmcXGiFY7kvxW7G9crSJDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778659810; c=relaxed/simple;
	bh=zMWu/hP6Dlnxe/IBpWqQy8v3Kzot9brI5H5/fhi0MIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=siw/UzO/h5cJEMsFqX/KXLoAni9quYxp5ivuNAg2hD4ehrj0DUGNv4ziOE26bJBHGH47Wrb2uJS+UHtuU0ZxjATGUc2TglKndkAsO2Z+QmeYjJtlpasQVYwIkK6hTFYx3lH7+hS3k89dWPrbl/FEVZmKEZd6sYNNfXh8w17OqXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=foN+0E+l; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="foN+0E+l"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-bcff2d08ca8so461645166b.3
        for <linux-iio@vger.kernel.org>; Wed, 13 May 2026 01:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778659807; x=1779264607; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uC2jsKFjgd5oQjURouLaDIBNO0MVJIAzvh5s+EY9Yi0=;
        b=foN+0E+lx7aQYMbEzJFJpBKOB2R6NoxFd62yjoMhKCC9DNXW1nOOQL+UNSmx/5n7Dg
         FchSFEhonm/9lNRNfIkXI2raOGzmL68tN70GRwIWfQAyoj9pEbYFjCKPLnAlNN8EHTvk
         U8JCRlvsN+Ch64/sXt4WRWubQOUvCdoQOgaGdgqpi8J8qgiWB/6/kJerLbxTDzBwIMtP
         JBOlbJ6+p4m5+w6IyPhntVF3DMDTZL9Y5vmcpwGBb7RT4HLE46dGPJbPC7MRZt2d6vZb
         NgbASse77lIIcSQapnjV0pnnVbpIrVBik+kTNJFpU8NxLapkjoNE9xeWkc3GHsGmOqYR
         46Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778659807; x=1779264607;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uC2jsKFjgd5oQjURouLaDIBNO0MVJIAzvh5s+EY9Yi0=;
        b=mclpyT0QBNA2HbSE6G5S/cJ7kh7d4p4uyHwkrrBriHT8WWCUK2wLqtsp8sB5FIgUKc
         nRE9QHTwlvj9WeJ6GqlkXNTarKoCq3Llyybpx6zeGydJDI0mkZoJbt17u2+QHq92IqG1
         aHoM4/LZs5Ap+/XcmvR24nFHsMwAqSbF3TzKaW3WjpLHFaF2aB3NVsLHdUA92shdZbXF
         f6tKTblNISUHLJHe47cB5ZvtaK/8cqOAz5GIUET40RPqtO/D0b4/yq+6CK3qnCjxfq/4
         HGpUP72sdJEqzfriAfHZewIb2Th/vIJA8G4Pvxi9kuggv4w0viPkVYaH9AioLKJCSgOo
         c9mg==
X-Gm-Message-State: AOJu0YxpQLUio77SbbTxNpKJY3hQJT6almefx20AFBus31qHtGR4zXLw
	XrHEhTFLdSfFI8hWWN9VLX+kjx1Pbgg8McNVxyb7rIqt7q4iVVqMdDefc1fdbpN2
X-Gm-Gg: Acq92OGVm1kFubmnbA/MdeNZlba1tLm8PrAoxgsDXhvGx8YPFruEjPPpJA54QW/Zd/l
	SBYj25Vq73flwpZnl1oit02agJwdmi1/nBnwCU428y1+4m3rVDzlkvUMTxawABRF6ksENe9rycG
	7KZ7Fr8vtXepWAbEYKKmgMXcChbXFWDI/XJl3TRbQtR/C92rnB7uJKnegtJpRJ7pezzc7MITSCT
	LxT6ic/5iRl9g2DmY9OVT6KjiT6QhYlfwNn03ZYo0DKDlVxGJCbwi+QpXW76OiZ4n5X1VXookkY
	N7Wu7HjvunU20ZYzQZ72AQdto/j75I+U2z/iujJWnRUV6IvUep7tOFOKQpCbcwFDvyxdvBBGU5F
	h9Lo2+2KD8uHg/7kMgqsTNqnzbrK/AWluAw+s3yYzL1IiDKKE3g2RN3/0iQv9El4/bJCV1vEiOo
	uYpLmb683tKMQ9HxpdLJ4HFh8FRnEatZVW8shX4w==
X-Received: by 2002:a17:907:9453:b0:bcf:5729:9e5f with SMTP id a640c23a62f3a-bd3e044edcemr120698666b.10.1778659806635;
        Wed, 13 May 2026 01:10:06 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0e1c2f9sm5970515a12.28.2026.05.13.01.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 01:10:06 -0700 (PDT)
Date: Wed, 13 May 2026 10:10:03 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	devicetree@vger.kernel.org
Subject: [RFC PATCH v2 1/2] dt-bindings: iio: light: add Broadcom APDS9999
Message-ID: <438370a42f57250cbead53ac73834fbf9ccb9269.1778659152.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1778659152.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778659152.git.azpijr@gmail.com>

Add Device Tree binding for the Broadcom APDS9999 ambient light
and proximity sensor.

The APDS9999 features individual R, G, B, and IR channels with
a green channel that uses optical coating to approximate the
human eye spectral response for ALS/lux measurements. Proximity
and RGB functionality are not yet implemented in the driver.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 .../bindings/iio/light/brcm,apds9999.yaml     | 53 +++++++++++++++++++
 MAINTAINERS                                   |  6 +++
 2 files changed, 59 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
new file mode 100644
index 000000000000..759fe0151549
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
@@ -0,0 +1,53 @@
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
+  R, G, B, and IR channels plus a VCSEL for proximity detection.
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
+  vled-supply:
+    description: VCSEL power supply
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
+            vled-supply = <&vled_reg>;
+        };
+    };
diff --git a/MAINTAINERS b/MAINTAINERS
index 1aa9c989973f..64c8cf2601e8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4302,6 +4302,12 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/avago,apds9300.yaml
 F:	drivers/iio/light/apds9306.c

+BROADCOM APDS9999 AMBIENT LIGHT SENSOR DRIVER
+M:	Jose A. Perez de Azpillaga <azpijr@gmail.com>
+L:	linux-iio@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
+
 AVIA HX711 ANALOG DIGITAL CONVERTER IIO DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 L:	linux-iio@vger.kernel.org


