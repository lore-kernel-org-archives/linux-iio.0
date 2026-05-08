Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28B9A36492D
	for <linux-iio@vger.kernel.org>; Fri,  8 May 2026 23:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778283470; cv=none; b=Iby28cY+0FtEAfl4f8d+Sa3t/naZ+sYonJnpVNz10qeSt2VwnAPUytGsSB2meOTywlSdibXT/LRJVuXKCHyKK4BF9L42JwartQSQI/qSMs9EX1PHI6eTucjFei0OV2aXjUoxxR6P5+OUp6QZ3cP8zDkWmi2Ahft0dreOBMBirXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778283470; c=relaxed/simple;
	bh=AXqNsoW217lGfE77JCCRFiEok9jdH7/UFsUx+z+NPyw=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QVHunLCn+jt92kDT0G7wxLCzuFgjBinR/6FZpWn6SdFdgLmLGFQZykro8Zh0L4bm751mMof/412fxEcOqwxyuWWF0GXI5aakDP1cR7e3L2gobLgb1EGwwIurhl+kQz8/itZYxRVvOgkKW3EXecmmaqfCiO1f5/VBfxiHfHLDw00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JCtD4YtE; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JCtD4YtE"
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-12c45281a06so4463239c88.1
        for <linux-iio@vger.kernel.org>; Fri, 08 May 2026 16:37:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778283468; x=1778888268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=zpKwuDs0j68b87eKPB/Fimbw0GJQpFhTCSxpTkiRu0E=;
        b=JCtD4YtEgS2SVnf6mrzXSPzzvCAOUZDkgzgMfYolYDnWwT1Z8Bttlp6Xl5dP35OTqV
         HAicJGfD8oVBjPcsUiDqsyUaXqsQguhj72W8zjMc1m1a/u/srW59JSwraQdwPwUhj85/
         sVcAyByZyW2MZudPDcWmPytekMmaHM9ZiX4iaQo7u5nopST3IqycBjWkJI+KyZ/rHysr
         G+fTaaNq/E//QzGr7YhrRnUe9hgZiwk/+IkfAPqGlo0YzUrJ5dGE+j0eL9qMbPJAvKuw
         maXlHmpXQPHXq4ndAc7cSDi289w5zLjO4o3IZg9jET1bIr3IoF0cBdRo5S+RTwhcdi5g
         dI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778283468; x=1778888268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zpKwuDs0j68b87eKPB/Fimbw0GJQpFhTCSxpTkiRu0E=;
        b=r1J5b7hKMd1gPhgnfSLHnVvdTGjjr6ssKj4FD0sfURI044OUuiA/z2DuQNuk4Kg7D1
         TRehCvQrMW0b1+MdiqoyRTTQJ89uz2m81M7Yu7MGCaXsXycMy2cgus8E+7t6vtPDQytF
         Dt++KhuBlgBIqlkkQOlcsPVXqK5C3/tiPZ+aQnyWS9at16OjlX/h9mhmpeKdtxZIMAOw
         HsartAkHA3cR2YDZkzg2d3DffGueFN98/I5MBApZW25cxPuGTOhOnrveG9K65iqqXx5y
         fqSqafTSSi7TnXyT/MLsgeRtahYuGKtr/0DoGMCnYq8BflsSCZK5B+FlcPTTqSlZnzTV
         JTuQ==
X-Forwarded-Encrypted: i=1; AFNElJ/CCK9Uq9RU4c4S+rPfgn2co+8pDjp1z5Kj91lwWY3dzDf7Gf5rQn+KIqEs/feAL0jUMQX/JrNx028=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7QTpp357kZ9Vh5WHvEh0q9Lxd68p8M04GtuqH4DdYk7TcWMsN
	8gRnrsF/r5CW/b3naptyamAbDN364u2AG6n3ELE/zODUk3Lj/9OX76Zc
X-Gm-Gg: Acq92OE5TC6krqJjlt2dFRxdpAXhbJhGLHXGAFdhA4sAuEQ8HkBjBVhvURD1PX0KLbG
	04vA4Q/j4NrNzbK6iOqe3PROY7LeP+5xSruodiOVZMrBkHsK+ePVRvmUDljqqItfEkAu9p00IwI
	yaDAODsuCfGQg2hu+XNOBioizT+AdLyW0AnZ/Esy91eTcsuphyIpG21gdVM3uAeB3BJb82TkdWh
	Z6yF/DX6GiMPxNrvplUcvi7QBbneqVOUEqESnVE2124pOtI7F89uKm2sksy4a7TPoUQUnqp2CFU
	TKaw92WSMY6d/G08anq34BLcbvUdBJ/m6eqjayHm2SQi3E+xDi/vUuLg7N7JeEWU5WBVvxgikGJ
	r1giernIH6+Y/aWoeRR7zlspi4wfbD55GlBprb8kZY+IkKZihbzBwHjsYmuwWtdkSS7uvBPGsNg
	d9uAVKGCYk36kjoD3oFfUn+JvjPMhqxioGlCJcM6Iy5HHQAQrOcHy8/1Ee6rXFZt1BMg==
X-Received: by 2002:a05:7300:8623:b0:2e2:d94d:6186 with SMTP id 5a478bee46e88-2f548e95823mr6547009eec.11.1778283468092;
        Fri, 08 May 2026 16:37:48 -0700 (PDT)
Received: from localhost.localdomain ([76.32.119.210])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f888e4016asm4269036eec.28.2026.05.08.16.37.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 16:37:47 -0700 (PDT)
From: Hungyu Lin <dennylin0707@gmail.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org
Cc: jic23@kernel.org,
	lars@metafoo.de,
	michael.hennerich@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hungyu Lin <dennylin0707@gmail.com>
Subject: [PATCH] dt-bindings: iio: dds: Add AD9832/AD9835 binding
Date: Fri,  8 May 2026 23:37:30 +0000
Message-Id: <20260508233730.77834-1-dennylin0707@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add devicetree binding documentation for AD9832 and AD9835 DDS devices.

These devices are SPI-controlled direct digital synthesizers
requiring AVDD, DVDD supplies and an external master clock.

Signed-off-by: Hungyu Lin <dennylin0707@gmail.com>
---
 .../bindings/iio/dds/adi,ad9832.yaml          | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml

diff --git a/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
new file mode 100644
index 000000000000..7e2eece086d0
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/dds/adi,ad9832.yaml
@@ -0,0 +1,66 @@
+# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/dds/adi,ad9832.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD9832 / AD9835 DDS
+
+maintainers:
+  - Hungyu Lin <dennylin0707@gmail.com>
+
+description: |
+  Analog Devices AD9832 and AD9835 are SPI-controlled direct digital
+  synthesizers (DDS) capable of generating programmable frequency and
+  phase output signals using an external master clock.
+
+properties:
+  compatible:
+    enum:
+      - adi,ad9832
+      - adi,ad9835
+
+  reg:
+    maxItems: 1
+
+  spi-max-frequency:
+    maximum: 20000000
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    const: mclk
+
+  avdd-supply:
+    description: Analog power supply
+
+  dvdd-supply:
+    description: Digital power supply
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - avdd-supply
+  - dvdd-supply
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    spi {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        ad9832@0 {
+            compatible = "adi,ad9832";
+            reg = <0>;
+            spi-max-frequency = <20000000>;
+            clocks = <&mclk>;
+            clock-names = "mclk";
+            avdd-supply = <&vdd_3v3>;
+            dvdd-supply = <&vdd_3v3>;
+        };
+    };
-- 
2.34.1

