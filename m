Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4D3560AA0
	for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 19:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790190631; cv=none; b=Ro4hAfie2oGA/V5MJ/9b5F7nOTITjUyB6RTnjFm/4h7xufiEQClYgAnsU7kewde+1Ak12c9XzG/M5xjQkK5/TkrNyPfX0NAmSQyx7B1tdwiwkezhwgyazuRntCsFnIZ+/9Iv5LS7g+JP8NQOOup+eUKfAUb/h+NT4N8bJYUa81c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790190631; c=relaxed/simple;
	bh=7ZDZ7klOzvZJ/C+DBag+kOc89L0iMjV12OJhh/9VyzY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=D080p8ZJc604f/A6aoeAMNFpmxJKCQiwRs9DGhkffRM0HfcKOzAsvMwVq80nFgqaWwI/weF3KtoaYYc3Md46JXSkHvOzGX3wH0z5CojvLGWhS8zJes57Lx/oVNRkxZgJprUVciegRAmFyqv7Jy1nxqGYaEbDihFxsFqA+Nb2Yzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nQcxCnDM; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nQcxCnDM"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ce364488dso4277585e9.0
        for <linux-iio@vger.kernel.org>; Wed, 23 Sep 2026 12:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1790190627; x=1790795427; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QH5dWwR2GVuVuHDcQ8qHypbiUhKqxfbgH0UpgH6h77o=;
        b=nQcxCnDMHdhy0VdE/2aDjrC+h4mIYKjryDmaItqV5BtgRMxst6gDMMBmMMnkZLH9Mb
         vxiEJ+Zg2PD+aSn8Ospg4JU7ywRmbxx0h6qi00Bis15p1cxpUb4XY0EErMEjUYNFdXkc
         xjdq5nRkk/zQr0Nm9/QtCyJrpJHTvfDBKhHGUJ7jszWFeeRAHGnQZGxXUBOvjo6Trmpc
         HfhTTCxBZGE9H1xIzjHIobpyHFxik8tUgtRcuM0iLL8POfIw9gbZANj+75kQW3ujPhBd
         S/GiJS2hKhWQIS+WGFZy7++83stUvSeCmjNl0qTpUB5GwtduOI4oTLlNnLj20Ppa7U4p
         0fuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790190627; x=1790795427;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QH5dWwR2GVuVuHDcQ8qHypbiUhKqxfbgH0UpgH6h77o=;
        b=Z6duEZPk9i96YfQ68VLhx2Q6uhZXA2dd7vHMtxUlwjSRHDP8wtRDzdMm2QWnH8C/HM
         MUU3dd22Ge9t5oNP7dkEmdivYTYD/x+d1LI8k5qyOWmXYfQUffEnBOVeJfnJigkv41vc
         EvGxAmpsrDaipbm0VcC+JNT/5rEThcGe7ondD5j+m4N6gQHfkaEonYh8lhHA7fxfYmdC
         EUEzJ6PPccYiwNkOFGULFSfXk/7GAmWDzofBe4vUag6vAlpC6Hx30ey2XYnCBaxjyDua
         TtJ40XSwGnuFAe1wihhT/Vj5JCsw8l2IC2rdOCzRLV/yF1Y8RRigtAybQtpo9hk7ORMb
         oWtQ==
X-Gm-Message-State: AFuF++k/wp/DhoV7/ANyyFgPT8CnryCrm0XlkhkdupepeZ4DP20FnNmY
	Q0tqoLufWgpBMY5oN6449pbEHBZFOQfrEwzsgKkbAXgpFyY2JY1qfURgwqAZjhmkNgQ=
X-Gm-Gg: AYBFou0gO7z1kEH6k06T4TdsrjugY57kS/EBtAOGV7jmrHZe3tie8vbpq30O7SIcCol
	xTyFNgkJ4vcxmGRO+wHMMc+Xqas50ZahTo98w8N3JMRYCBf7Y216nfm40UBVMiiyBRzwBj6FtPn
	i6Vxin1HUaqFHRbo7zA43p0DqqA8H1Q4539rSFBMEEFDMrfHq92/5sj7JW458jS8AUDsP4jCfe8
	0AKbDtfy+PINzDD7LngN6FNVJGEbIutd8AI2xIJj0j1MpK8PB9m1NcyCY9t+wfP5im7KHpKO1Lt
	9RqSTppbTsWs1AGSWUQ3Ghv04vWo7yuHjiEr89xRAdZntnloCrvVlpdMn49XzWV1/0YNz4F6YVT
	yrb/DFYoSuMgB6W9BXfSWrTnN17GijiUFDEVN5K9RC8xLjMYjblqimaVKoge95YwafLLTEl87A5
	iVcnpA+dkxqffthLWUw1l+gFSKfGOpXWHEeRZGY3O6hty1Zh/cq8t6s94tE4tTKb1ZRFmtO2891
	FyXGyoTB9dhh5gaWgY=
X-Received: by 2002:a05:600c:35ce:b0:49e:8222:3451 with SMTP id 5b1f17b1804b1-49fe66fa420mr2247145e9.14.1790190627241;
        Wed, 23 Sep 2026 12:10:27 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:106d:1080:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fe5bae53dsm7291815e9.4.2026.09.23.12.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 12:10:26 -0700 (PDT)
From: Neil Armstrong <neil.armstrong@linaro.org>
Date: Wed, 23 Sep 2026 21:10:22 +0200
Subject: [PATCH 1/2] dt-bindings: iio: add: document the MAX34417
 Four-Channel High Dynamic Range Power Accumulator
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260923-topic-sm8x50-iio-max34417-adc-v1-1-41d4ba1bfc41@linaro.org>
References: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
In-Reply-To: <20260923-topic-sm8x50-iio-max34417-adc-v1-0-41d4ba1bfc41@linaro.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3189;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=7ZDZ7klOzvZJ/C+DBag+kOc89L0iMjV12OJhh/9VyzY=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBqtCQgF5o4IkV8REDXPbiUBGSYERQyQlwDExrR3OYa
 tAAcaW+JAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCarQkIAAKCRB33NvayMhJ0QngD/
 oDvtzmJp7GTtiWNI+PlkrC2pVivYhEibQ3RWf3eaw1305ZaOx78EORAX/o9PZu6LIE18IGSH6DL0n8
 gsFO0w5xOi3XBa7fM3XaC8AXJMZKaPYHOe/cLwnqD7dyVBlpaGz7auAe6qEbkbCvmXV55glEP03bCm
 OTpPV0llS0JikKnNOyVp9uq5FHeeJ0Qqaz7TiZtJNtP6s7qd0nmrEa2ZrS6UOTh9XkArPZbq24FkQI
 qSWAq0N86aDmd195csKFI/OS2l82uIP+BWsGZHRjXvHUHNo8pZQ682wv8vF5MY9M1qzwu//a2HKfAj
 yLBb1Rj9J44q2VSRbmAaAv0qVcSccqHV3kR1vOTai6khk9ZSjf5gpxCJfw6O2GNxidUbTfxpPpmStE
 apmuwqPOcQi7/EEIq0xzVv3QhZCYZhWTsTAW/Lq1M4SHp9WZO+4HZh1Hspt3QtaEi1rse6iHYU8Vwe
 mg4mWOAB1f5rskSuHQLZ3QX/ntMvqXRVuAAUbgspksT7H3otxUN+rG9BmGV8HikCERwcUyqvf4GOcY
 djV5PhXZx/yMKfTU7NHU2jTtiyrjY8v5uqP/h92O6soj1Csf1j/vs4qLsJ0IF1+lyuNaKKswSZL7WS
 g03W5faFmTcTfBAcXEI6nS6YXbzvdIiN6nlWZY91XcV1ir4UC0eYFdCRV/hg==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE

Document the Maxim MAX34417 Four-Channel High Dynamic Range Power
Accumulator used to monitor power consumption of portable systems.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../bindings/iio/adc/maxim,max34417.yaml           | 99 ++++++++++++++++++++++
 1 file changed, 99 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml b/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml
new file mode 100644
index 000000000000..6f2339a92771
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/adc/maxim,max34417.yaml
@@ -0,0 +1,99 @@
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
+      maxim,rsense-val-micro-ohms:
+        description:
+          Adjust the Rsense value to the resistor value
+        enum: [1000, 2000, 4000, 5000, 10000, 15000, 20000, 25000, 40000, 50000, 100000]
+        default: 1000
+
+    required:
+      - reg
+      - maxim,rsense-val-micro-ohms
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
+    #include <dt-bindings/gpio/gpio.h>
+
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
+                  maxim,rsense-val-micro-ohms = <5000>;
+              };
+
+              channel@1 {
+                  reg = <1>;
+                  label = "ch1";
+                  maxim,rsense-val-micro-ohms = <10000>;
+             };
+        };
+    };

-- 
2.34.1

