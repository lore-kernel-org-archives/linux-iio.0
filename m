Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18813483BF9
	for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 13:14:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790255668; cv=none; b=jCmC86/gRWtwRh2pJiwJOHHy5SNANzieKkl5vuTT4ac6LyydIQLQn2oOJ8b2xZWnBtf+fwtXmvgxRbIlwIDyQK/5uXgIdbbOE7/sJTk5C44lVWGtRu5ESBAtcb4ML7k2GKVxOazFLCaem67t4FMSJyVG4+CK+qKlV9/mC8Il5Eo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790255668; c=relaxed/simple;
	bh=ixkLfsi5z6rhg+8XtIM+rmsLjd0FiwPrlwpSt0GJlHk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LjRuudzdESNT6C48Irq0GxmwAP2x9jZWTMSX+yV+xDaFmAHPl/JeVrfNS0oiyG4OXxN/rZI30SAzGWfGopMPAgsJHZtK9tC4wkqEgXEgZ2YO/ObM7KhQoQMME5VxqZ8tuA8Vym+AeJMJG6FNj6SvKhtXqOMut0JnsrrKqfqpxcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=liqRmhU/; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="liqRmhU/"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49d1ca5b0d6so13898265e9.0
        for <linux-iio@vger.kernel.org>; Thu, 24 Sep 2026 06:14:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790255664; x=1790860464; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fLtv64omo0yQg2P3gbqoTCMdccerTB6y1krEjLFdXsE=;
        b=liqRmhU/yqIVr9dfAuSxDwoDmB6/Lcoh09ZmvX99quCGINUrhDFy/Nt/tVOb85H4lW
         nacza8Z3BEmHcOaXAZ4VrD8l7Z9dNoahbtaQNWdzHkmo/U6a7PseBIEgbDgxTM4CIqho
         jI3QaQliPgaHG989Ir5NiCAMrLSkbnG/1Q/0CiYOUE69mZkjnXsbN+ZClDh8CcMRr7wT
         8zMF3SR8aG3TDcYi0araVhAyuk/QtDEiiJmbVYD68uD8p1pc3Si9Uhzh+ZlnZ3yEK6Tg
         /g0WAvsGVH7VL9bY0Zy4MKEt9i680iJJbcTs8A74ym0M8WhkTpUbubLoqJjnqOMiLbCO
         qf7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790255664; x=1790860464;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=fLtv64omo0yQg2P3gbqoTCMdccerTB6y1krEjLFdXsE=;
        b=qk4gCM+y6Dmc0u2+XDYPArl2lbLOIQnhLxFneHFWy/pOARExqN/M0QJ4LrZauaWoYW
         BQdSKRBrFqTLbKzgLphAO1i+wQElG+nIIhS5E8n8QzUELO6I/j8dJbfVau2esvoQw4An
         qu/yHlUXRzc/GoBJiCU480ft49nKHd52dG/fOucfpN86nTO5QcbWayst+emCdx6XWO/v
         G9eECl66wHOelMTEMY6sxmPlhtyqtUQYik3BmFjHoO9NiOOfLZBLdmSyFhli/fc50qUh
         ENvClmEUp8wozCrb69A5G1D8Rf1zhchFoLJ1Jkdm08wGuNwg4KD/Z1tI9za/kG76oM0m
         l81A==
X-Gm-Message-State: AFuF++m/1tJcVECwCF16qljUECCDfepVHRcVdkGjOsNHpuNl2laU4zkA
	C7jl2qROHTs/ibBPQjr4mzzE61KHnx3hj0w3TLa+pZhF0ZbGDtXO51Mnt7uEWhnwDW0=
X-Gm-Gg: AYBFou2rK88SpOs7fsqiD9oNhimbilTTQ/vNegJpSnhm3lP5iB3IpXqEv1qLMhHHrD9
	29qYTP5jnu0JrZG2KXotvmDkye5qGR/OnURl8/NVls+YtX27DtpsVP/WPZ8R51EevEdbk6FsBNE
	gcwviUGm5HcqkPlGjBipBl26MenVv+4pH2niG1SttzdDHe878iGlcFJ8IVP9Y2y8qMqIihmDejC
	zi4StBgSt1RKtxUbXsqRW63j+71W6OJD8Biu6w3ceG37keX0NGfOJ0okLzPnwduLs3bS44VjIlg
	4JITyugIc/YN2tXfHmt/zQcvB5CtqoVwFQFvr99M5u5wqfFyowf4INYay0J2G6w2ZDSVxqNVyBu
	QMtG3TBPyyfTd6LQMSt9vK9nF6dyYDlNewc46mweLZ3g+ilTYRBOj8f640cAJlTrfSY3NCisM0m
	/D+UEpuQU+vsZn8aFiQPVTTb+NYdUpn2Lf9IFN54oa3fNu8MO+Z4Dt9TZ2P68C7C2KjfYAL1iPD
	5B840BtBG2QtGGbgZI=
X-Received: by 2002:a05:600c:1d28:b0:49c:fc6e:8cbd with SMTP id 5b1f17b1804b1-49fe66fc677mr46599505e9.33.1790255664029;
        Thu, 24 Sep 2026 06:14:24 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe0c4054fsm111837945e9.3.2026.09.24.06.14.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Sep 2026 06:14:22 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Thu, 24 Sep 2026 15:14:15 +0200
Subject: [PATCH v2 1/2] dt-bindings: iio: add: document the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260924-topic-sm8x50-iio-max34417-adc-v2-1-9a0609e72f5c@linaro.org>
References: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
In-Reply-To: <20260924-topic-sm8x50-iio-max34417-adc-v2-0-9a0609e72f5c@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3123;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=ixkLfsi5z6rhg+8XtIM+rmsLjd0FiwPrlwpSt0GJlHk=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqtSIsRNXKx8hrQxj/AIgbysRUPujHdAXL+fL4nbKy
 cX71SS+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarUiLAAKCRB33NvayMhJ0cdYEA
 Cael6BBw4+XxJp/wnjhttyN+iiraV5CxPTwT72C8ptxer4fHnwhG2PuZgD3DZZQYRKUPWYxuBsWLd7
 1+T5WPFMWGSfsf9oDSL4njspjGZTbAUiYHhd9GaEI6SlFChnggRYVaelvwGjdCUVuQlRBCFGhrIZ8d
 wyyLQO4NGe6JxBVNOWTBjE5ArfaNoHfd68UasxWGPAy898U2PaQQ8VIvvgZGAqN4HxvfqpfJgELCrx
 iUIizbPE9dTAzP9G/aJgkez9MbXLOpSEiNj4M16ElsVF4RpWvi6KQLyFBw/UVh/nnMlSWGlw/14Yxi
 p826jUbEgcg0iBlLSLX6RJM9HXtfZ1w4316UhN1SGLRME+CemrHIUy9+vRIfD2rV8eKICUlHtm5FrF
 cWQ/QObmjoSWPabUmbNl+5Fp2lt3krGISJvxSaRvm46ZZ1GN6yWWATQEdtbUP5Zz5MdEIILQZPpsTU
 h8Ovj4FvccOxvyXhzGKjCvW4xGDXEPVab4xPTooBrxhFjfrgJeGT3jVFtJLNeimtQWMMo5fNtC5EF4
 2AFqwszcrq9ACvrqUH1yIturXDvFWLBvePoLt8ZMB6smQ5aBEARaRlPkkmI2ayu5yB/gbQhMU2rDny
 z6t+X8jOou9EYvD0z7njIXLhOHuuJRgA8PXDFCuYVDAl0kzr7teZElFnsyTg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Maxim MAX34417 Four-Channel High Dynamic Range Power
Accumulator used to monitor power consumption of portable systems.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/iio/adc/maxim,max34417.yaml           | 100 +++++++++++++++++++++
 1 file changed, 100 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml
new file mode 100644
index 000000000000..058af61cc04e
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml
@@ -0,0 +1,100 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/adc/maxim,max34417.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Maxim MAX34417 Four-Channel High Dynamic Range Power Accumulator
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description: |
+  The MAX34417 is a specialized current and voltage monitor used to determine
+  power consumption of portable systems. The device has a very wide dynamic
+  range (20,000:1) that allows for the accurate measurement of power in such
+  systems. The device is configured and monitored with a standard I2C/SMBus
+  serial interface. The unidirectional current sensor offers precision
+  high-side operation with a low full-scale sense voltage.
+
+  Specifications about the device can be found at:
+  https://www.analog.com/media/en/technical-documentation/data-sheets/max34417.pdf
+
+properties:
+  compatible:
+    const: maxim,max34417
+
+  "#address-cells":
+    const: 1
+
+  "#size-cells":
+    const: 0
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+  vio-supply: true
+
+patternProperties:
+  "^channel@[0-3]$":
+    $ref: adc.yaml
+    type: object
+    description:
+      Represents the internal channels of the sensor.
+
+    properties:
+      reg:
+        items:
+          - minimum: 0
+            maximum: 3
+
+      label: true
+
+      shunt-resistor-micro-ohms:
+        description:
+          Value in micro Ohms of the shunt resistor connected between the RS+ and RS- inputs.
+        minimum: 1000
+        maximum: 100000
+        default: 1000
+
+    required:
+      - reg
+
+    unevaluatedProperties: false
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
+        sensor@10 {
+              compatible = "maxim,max34417";
+              reg = <0x10>;
+
+              #address-cells = <1>;
+              #size-cells = <0>;
+
+              channel@0 {
+                  reg = <0>;
+                  label = "ch0";
+                  shunt-resistor-micro-ohms = <5000>;
+              };
+
+              channel@1 {
+                  reg = <1>;
+                  label = "ch1";
+             };
+
+              channel@2 {
+                  reg = <2>;
+             };
+        };
+    };

-- 
2.34.1

