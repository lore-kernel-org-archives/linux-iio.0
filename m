Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3A03EFFC2
	for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 09:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779182599; cv=none; b=eEoG60zqp5baJt4+tIMgwD556paxuWcBNNme8nRZQX1+/Y2JXXyw/mWPXj+krJ94p0c9UBrBA7oW4NmuS/HmBUNK+N4IVMz23xb3ooiV0rNTmYgLfCwPS7GRvJ+oGdbwAq10YQScsknJCphzwWBartxEPeFLkSMcUng7QC02Qn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779182599; c=relaxed/simple;
	bh=Ays/AOR03eQ9fnsVDYNlf8e3KW+AqPJ8S6XZihMvT+c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ihdvU21J0AaoD1wCRPRUOZk233wK+3Zh/+eHObd7c5ah8l/jYdXnlSRp7g201AESVAgJWrVUjW1HuZNwPD4CJoDBWf0dcqtDFFTfVV2HVI4SNFT5yAQnYPVEGiqclWURela7NDA5vQbUmw0mCBo89Dnba7wHqc27UZ67GPN1bfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RiHBahwW; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RiHBahwW"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-bd373f83042so687678366b.1
        for <linux-iio@vger.kernel.org>; Tue, 19 May 2026 02:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779182596; x=1779787396; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/acds5PobtVmDUQ4dCMZg0BCAmtwvenliLGdACo8DBc=;
        b=RiHBahwWY0MDJ4aTNs/BMihA/xEMDRzefOchXUGvw6ukYXKJ4ISGElHuTfOE7q7pvZ
         sgxQA4nTEugM64uHJNG/eJMBdSF9H8tVwhM4BRHNkT0WTj7vBjAjgASC2l+j1FAxHRdN
         k3QkxaeJ0LZclrxuroWi1PXkJaC5S15RGMoYCFtoG6Byx8QPONldLZzLwOuvh4zkS1Py
         NaJzVVXL5BtM9dQ0yv8wHuNVLyXNE4bvNvOhLRuUzuphOowhLgOxBtDp8GOM8gHyQ8jD
         DR7mdEO+ZlcuZWvkfFVKJpc5RQmNL12qksfeLDZaB6yHXWOstvYo6D9iWf/+BdS5u/0x
         UMhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779182596; x=1779787396;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/acds5PobtVmDUQ4dCMZg0BCAmtwvenliLGdACo8DBc=;
        b=GKG48eCBhD2uejW/xyot1Gy23tT+QoeR+wkPcgKIJRofp+mG50ku0CwqcGD6axd0Be
         dRVp4i7b9bSXBs5hCQ9TukHeGwolFf3OzCOXgCoZGDLxF7xFd8pFRbkpcvAGpZ0YRUxC
         8iP20GW7GIzqVnNVnzPRuCbMl0/H5bdr8wdyDPwufaswPb1SaDlPYpb5djVMZoDnUw9e
         RjWkoqABnU5wdQniXS7c9OpON2Q2fKJdSyKwtVRXusKxK5jkXLLHKcFnCVlo4EFqnatH
         rzTRopkZ7ynT7BYbfdQujAiLXzg3qKLTIjvfbgsyKJG6yIivkhGvSHTEa7/A5m32YNsI
         VFTA==
X-Gm-Message-State: AOJu0YyLegIK+zTOBWQ8Mb8+XLMh72IFS9of5c5wy7rQLvYTCTbA7ti9
	pF4jh3FsWVeh5Kx9QCMfMYT4Wxf9CYKJvP1vVUPhU03XGy5uhZrtEr1q41RH4NLNrBU=
X-Gm-Gg: Acq92OFDcvKrJqOoyHDPdk/iiXOj2wQENNOrKQgupEbevreaGwY63LUFxmVwfOBdkNm
	jUXUJqyo6f0sV6581+wvVc0HY9KlrurAQ7Re1ijM+NJ8YYnij4LVEoxV0DUzEVTgXU/xGuU14aJ
	zD1KO568IYs5F2Z1iaP3qQS8B1az6vqM4BuTuSrsUYNQMrxYAcNg2OT1IXh+0A8oAVvfgfQeei1
	EwEnKUyEC3+7c37uI1fpzwsSHR6RuAKO/rNj6p1D3h3aX83c9pAMY+sXpxr5v7MHFphWAkAXDXR
	QI4+3eYpmdLyqviVaTIEwQkUGlbRrpMg7gkvo8OtjMbc3scaWmosXmatKUXDZRtoptb7aisQhxx
	AVqPKj5tzErUCtWITBY10fDKU/yN9dzKbufxyDuAmrlCO0pvpANKbrTnlyVdNhTMLnbAHDKG2lk
	Gf1I/up9LCDnGiNyWQW/h6klDzDjY91yzE4uJc6g==
X-Received: by 2002:a17:907:3d45:b0:bd5:27b7:adaf with SMTP id a640c23a62f3a-bd527b7af46mr818011166b.33.1779182595357;
        Tue, 19 May 2026 02:23:15 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4dea93dsm675169366b.38.2026.05.19.02.23.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 02:23:15 -0700 (PDT)
Date: Tue, 19 May 2026 11:23:13 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>, 
	devicetree@vger.kernel.org
Subject: [PATCH v3 1/2] dt-bindings: iio: light: add Broadcom APDS9999
Message-ID: <12b145839a1a9c5381946a9e5237bfe6fe0ae9a7.1779181370.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1779181370.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1779181370.git.azpijr@gmail.com>

Add Device Tree binding for the Broadcom APDS9999 ambient light
and proximity sensor. A separate binding file is used rather
than merging with avago,apds9300.yaml because the APDS9999
has an additional vled-supply for the VCSEL.

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
index 000000000000..4d9e9aff8894
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

