Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7153C38887E
	for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 08:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787389146; cv=none; b=Lwzpj25SjMrSWlHXYyLN//L/HyHu87z49OtlgKn2n1n7CWHAKvjbpG7CUeWvfDxxXkkSQDS4Q/lt0xM/pJZ/EXcMVgqDwdx06tkrOtWx3+Cm1GeVzJxst1KF+5SIi+A2FJqM0ASNHDRvW+CbslgSIW9iWFbdd/e5eGW0vAyuQiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787389146; c=relaxed/simple;
	bh=9gxlDRHqhuwt8FJ/CwukjTyzdPv7n6MCBFsd7dAHKR8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVcqDNSvmNsOq2TR23jTMqzCLTCmRBnEhaF+cj5b0Y+rF6UWHRkkIScDdqpAsilq9kGIbjG5sT/LWXXkcaBBAq2JubOLuCVU5sSpB8Yqxyd0jPYDdfoWSmyms8H/Ou4eKPrJmYcL8jjVFkUun39WKZQzyHDdE5sf1a1imJdBZ0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WtURsgPa; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WtURsgPa"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-49954b88fffso14776235e9.0
        for <linux-iio@vger.kernel.org>; Sat, 22 Aug 2026 01:59:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787389143; x=1787993943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ht5SF4+wx6Jf8JH+OLs35dYBN3IVS35rx1u5RktbmkM=;
        b=WtURsgPaY7dhFpQaoptaa5Gesp/20CvJpu5EiY2YfqTjvY6RxSy6el1MtxFSZws2Jo
         ODXcnLClj5KTue1lU4jRD19KEBDeY7U7X5fGn42fihQXeYsupxEuCxEDXDLX2hw4/5Uw
         ypnUKFweZyvSj8NDHS2j7cJzyWaG5mDOlzGhDqaXpX4zDh4tHFSRdEOvhFdElL8WkgsH
         LBR7rlkywUBlSWEsUNrsJ4SycwatjxqQFkenrw47tVlrmOv2HYeXet43WPYx69a6qRWI
         Lc2oguj8OWu9s7fONVt2ezLR0rOu4ZM2h3MMGC9ZbL9X2xm5GH6CCyOa92V2oCU7Rjn9
         5UZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787389143; x=1787993943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ht5SF4+wx6Jf8JH+OLs35dYBN3IVS35rx1u5RktbmkM=;
        b=VZpMUtHzfw5iobO2UdhoPMsFkfRefB08qlgrpINTWAredQoSxh9pgZZICr4nHkq7+z
         DMr983ZHAasoCkfcla0ZaNbQpigXTQBXN/vO5Hc9/ZGGftC/vR50d80T9MXEV2vMyo5Y
         ahLBzxOU7z56N6VZ+e4Yx9LP2aGA+pQeB5JHnGK3unQuWYeDjGPfSFhzG+DaYdoNtj/b
         MGZnO46qop1LPiyFCo+Pnk0eVLw22mnDdvw585i55SNJNv4+tQSILXukP5qV8NWokysU
         qupGegB3kglbENW1iV4WCYiUTzew9b8GyIXcr9iJ5WYeCwUJ9UImk/ji0/nT/t0PR0tU
         EvbA==
X-Forwarded-Encrypted: i=1; AHgh+RpsaJ0G8/XofaPP+KnyGmPWr/sjqWlkLzhz/Y7up42JyQDZpbV+ZHTtklkoYRPe8Ii16MfYYQvp1RQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nMreHBYMHuGBWkJj2uGWCoSB5oh4GJVClk7CrXKTlFTPBPqNbI
	8xk1A1R3VRMAzbVItHsL1e8aztVy/bv7Gj7WCJl119wargmrrbxmRpeu
X-Gm-Gg: AR+sD116Yq1qh4vFSjp54TR0zb0tSbpr/4ZavNXCzut3zXrsNE651njLkJE9BI6xWPv
	0zSBgE/DWtfooCTJadFF4m0B+QiwAtUuYMghmZk26h2nNLM07T1+6Ex+bDwtC+EGeq/mbZkksy6
	0mKhZL6sGeBIy7Jc4V+e1XrfMr7Lrq/OJfSzt2dVLM0IAzcGYXOQ/RhNKoO8c+YMKfBoeEVoCIN
	wnsXQ1sXhE1tCSte5/XtckDnp8wJsX/5skOXUGpkDoAhp0VicEKY9fmuvTdWoqdFjPGHYlUs/mk
	C+a5YJ49vBkC//k5TqGS8rW6sBm7oGn3kO1NUHqqFXo3MsYYtsnXx781Mpt7q5z0NWEKOzBn5La
	tONTuhpBD/mWv9RtK5MbWee92tN+9eS6vWeLrBcqUJqarUC5gbZBhaDBkL7XN99ttQEwyIEtcoa
	G2IXxYmu7uRnipInI3GcjNAvla8eGFiQVhKGuXF6Bhuqac/b9UGZsaVal/KOyJNMUDm2pKJKuhC
	tteQCFs+pU=
X-Received: by 2002:a05:600c:3111:b0:495:7888:281c with SMTP id 5b1f17b1804b1-499c1772dd5mr39257375e9.0.1787389142531;
        Sat, 22 Aug 2026 01:59:02 -0700 (PDT)
Received: from fedora ([105.74.72.30])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c359b9fcsm13596635e9.9.2026.08.22.01.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 22 Aug 2026 01:59:02 -0700 (PDT)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: jic23@kernel.org,
	lars@metafoo.de
Cc: Michael.Hennerich@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	skhan@linuxfoundation.org,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v6 1/6] dt-bindings: iio: dac: ad5504: add output-range and missing gpios
Date: Sat, 22 Aug 2026 04:56:48 -0400
Message-ID: <20260822085850.17527-2-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260822085850.17527-1-0rayn.dev@gmail.com>
References: <20260822085850.17527-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AD5504 output range (0-30V or 0-60V) is determined by the R_SEL pin.

Use standard output-range-microvolt and range-sel-gpios properties to
describe the hardware configuration of the R_SEL pin. Ensure mutual
exclusivity using the not/required logic. Additionally, add missing
vlogic-supply, clr-gpios, ldac-gpios and datasheet links, and provide
a complete usage example.

Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/dac/adi,ad5504.yaml          | 39 ++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
index 9c2c038683b4..e0123dceaa33 100644
--- a/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
+++ b/Documentation/devicetree/bindings/iio/dac/adi,ad5504.yaml
@@ -10,8 +10,10 @@ maintainers:
   - Lars-Peter Clausen <lars@metafoo.de>
   - Jonathan Cameron <jic23@kernel.org>
 
-description:
+description: |
   High voltage (up to 60V) DACs with temperature sensor alarm function
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5504.pdf
+  https://www.analog.com/media/en/technical-documentation/data-sheets/ad5501.pdf
 
 properties:
   compatible:
@@ -27,6 +29,29 @@ properties:
     maxItems: 1
 
   vcc-supply: true
+  vlogic-supply: true
+
+  output-range-microvolt:
+    description: |
+      Specify the channel output full scale range. The R_SEL pin
+      determines if the range is 0-30V or 0-60V.
+    items:
+      - const: 0
+      - enum: [30000000, 60000000]
+    default: [0, 60000000]
+
+  range-sel-gpios:
+    description:
+      GPIO connected to the R_SEL pin to select the output voltage range.
+    maxItems: 1
+
+  clr-gpios:
+    description: GPIO that controls the /CLR pin (active low).
+    maxItems: 1
+
+  ldac-gpios:
+    description: GPIO that controls the /LDAC pin (active low).
+    maxItems: 1
 
 additionalProperties: false
 
@@ -34,9 +59,17 @@ required:
   - compatible
   - reg
 
+allOf:
+  - not:
+      required:
+        - range-sel-gpios
+        - output-range-microvolt
+
 examples:
   - |
     #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/gpio/gpio.h>
+
     spi {
         #address-cells = <1>;
         #size-cells = <0>;
@@ -45,6 +78,10 @@ examples:
             compatible = "adi,ad5504";
             vcc-supply = <&dac_vcc>;
             interrupts = <55 IRQ_TYPE_EDGE_FALLING>;
+
+            output-range-microvolt = <0 60000000>;
+            clr-gpios = <&gpio 4 GPIO_ACTIVE_LOW>;
+            ldac-gpios = <&gpio 5 GPIO_ACTIVE_LOW>;
         };
     };
 ...
-- 
2.55.0

