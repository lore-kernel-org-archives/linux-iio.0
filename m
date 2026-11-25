Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795638158;
	b=dxqa7eS5MWgFSGoen+RYmOjogBFCBiblLQvqedgerQ6sVOrcTqcn02+lu70+i0YAyp43
	 d5c5pQI53jjW2LyN4AmWqvftEgOzAiVDdTRjnwHJ8M5eVsPPzZpRg7JWWswRppP6sIsIT
	 ZcisoVJ4hIg/HjJAyyHVrFPGDetwwq9jLBUzDKZHpHbPHTHeDEIljohDdpLtiSqG5NP9u
	 WYVUjAiE7qGEr9GUoNNamSrZZu2S2+/7piHTzIpAyqjBwrkvGLWi2qGHmdlT7wvIImUxR
	 Hp+jWx5RAlUmV4sT7LbUovwmvEqrMlgycE/avEi3D34TXe6hr0NlfD0SOf+yshVdv4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795638158;
	h=DMARC-Filter:Received:X-Google-DKIM-Signature:X-Gm-Message-State:
	 X-Gm-Gg:X-Received:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:Message-Id:References:
	 In-Reply-To:To:Cc:X-Mailer;
	bh=0KrHNk+oD9Hb9TFBnf9d2wavExw3z/x/bPGkwY/46cQ=;
	b=HX8YKQ49HDHvOxfnKmpiG247P1pRy6Qh0SrdYfL1bO4I7lGXQcys0DC03r0RyXQuCZAd
	 rWF9J0fxeE23VYwbNC71mhy4jlcxLebTfkDXEIPs06E/jPMx3mex4CR5os+749DOyAC1L
	 ThoILxxgxH6KLWFmhdEG3LWOF20zLRtaxub5IG6AbphdV8AsbDkrI46dT0v61gTXDLvRN
	 8MnhN/lEb3rNJ4B+OWVAiRLE+xfYBeC1byxTmECfKzA8zJA/E2JV+IBn77FRZ6QWA/NbQ
	 9XqtClaQOyZmfI9gKsF7jvlt6jbGfx9aXTxT6vQWYcpAjZJLtiTtmN03mJ7hE7cMfDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=telaak.dev;
	spf=pass smtp.mailfrom=gmail.com;
	arc=none smtp.remote-ip=209.85.128.169
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374F1606A680
	for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 20:22:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 374F1606A680
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=telaak.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8b0d126f631so55095617b3.2
        for <linux-iio@vger.kernel.org>; Wed, 25 Nov 2026 12:22:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795638157; x=1796242957;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=0KrHNk+oD9Hb9TFBnf9d2wavExw3z/x/bPGkwY/46cQ=;
        b=FQTRwVpWd+kDKo1VIb0Y/2RVS7fx+UVE0yuqqSe033WnEoIWjdkHVLhK6YFzCe4d9L
         rT5pBAo2PHdwfFRl5Gmd61JFxvxIkYJCZfrfHfJlx8O9QARAm3slBuZ7W/7CvE/pRPqL
         CQhAx5AUx0XDrKVxfLuG6t4xxooaqYAJQD5IhGNF2yebGsCs67CNnHTSfVKuohZNvKf5
         1CGm6Om8YLg4UL8pcizC9/TX0Oeoace5KbQXTRbmyogRzGAwU/FRKyrLMdTEX4/uapec
         DVJeJPGPLXboeSVOPvfxt/YOTa0/mEh7yHqRiWQ5MJ0tO9BkkNA7958+dXbJdotNjYzG
         Xkaw==
X-Gm-Message-State: APuU4Z+7mNsEEPpIedDRXR93js3sKjLgf6gK3ryYt8gzioCz2ylHZvaN
	QezosEzjoSJjPEftgFChfqhaJkYQQ8xPCaNmzUcXViSeeuaf9NJrtMzB
X-Gm-Gg: AZFdTZdRoQGgzD8jPdTVVgvZ6kpkhRTjFcAPPIOsuewQFAYQVtfGqmVqqxiCwnOwjIN
	buTfeczTcwJYIh03g90SmI1YWZcTDQW+lYwH1jIcjcTde16qkYY97z3+KIzlFrr9lmUlmr7f3NP
	YjxhREG3+9hO8H5UJhNjjoM5J7vm+5X5TkWLDA3S4IbKKyyOo1PLcjxy564kj/mg3rf5KQdylmp
	AYudmefNq81s5+Q3Tv/pgXQUTzkkQEpOW6yVLrQvyR8MzljY12uOsAOog1cnybKdJLevYLtgSEX
	m7S94Bjy0NIn/T28v8BOzozQPOVWFrRyKj4P8A+atw4rke6R7Dah44H9WQa5mNyT3crfBLGNCwb
	BLFYoPTpL+znbtU+Nk0r5Q1sJ+WO6mbbz9ieVuaynCNRxKQZ77LR6m4w4Ky7bxGmdqzRj/cU4DE
	XybRzpUZIB0Wsxqfg+V3S2HfrPy22mvaBoxqfbwOK5Wj5aP8EHUCIdnyUwjDfGwpqHnNPyx1h00
	MLWRMxmTT/hDRmo2GjaaUqUyTiswknY0rxaL0BU9Gz/Wr7bDZZEGNtfpS/NLJqeDgGjX8DU9viJ
	hvhr5UuApmfvj/zNRjUs487IHNOdx0n7YV/smwrSRdUzcrY/2jAIK9GQc3yF9P7HcQCkTe/gKu1
	Ni2mO5k4YNHBS1rSVgO6AcFmYJEpbmLdNkB9ajKAJoU+RkaYzmBB1hNbknyzguTzotCvNcnnosp
	R4Z1PomcgMW56Xmbj7RJB3+ij5Se48JnQx5nMNhAXaT9SzxA==
X-Received: by 2002:a05:690c:905:b0:8b4:dfc2:bea3 with SMTP id 00721157ae682-8b5204e9094mr93671177b3.50.1795638157142;
        Wed, 25 Nov 2026 12:22:37 -0800 (PST)
Received: from 1.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.ip6.arpa ([71.68.170.161])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8b5201bb6c7sm77074377b3.6.2026.11.25.12.22.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 12:22:36 -0800 (PST)
From: Joseph Telaak <joseph@telaak.dev>
Date: Wed, 25 Nov 2026 15:22:30 -0500
Subject: [PATCH v2 3/6] dt-bindings: iio: potentiometer: Add Analog Devices
 AD5246
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
Content-Transfer-Encoding: 7bit
Message-Id: <20261125-iio-ad5246-v2-3-8feeb630f0b6@telaak.dev>
References: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
In-Reply-To: <20261125-iio-ad5246-v2-0-8feeb630f0b6@telaak.dev>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Peter Rosin <peda@lysator.liu.se>, 
 Michael Hennerich <Michael.Hennerich@analog.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Joseph Telaak <joseph@telaak.dev>
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux@analog.com, devicetree@vger.kernel.org, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0

The AD5246 is a 128-position digital rheostat on I2C, in 5, 10, 50 and
100 kOhm versions. The end-to-end resistance sets the scale the driver
reports and cannot be read from the device, so each version gets its own
compatible, named in kOhm as for the AD5272, with no fallback between
them. There is no fallback to the MCP4017 compatibles either: the
AD5246's step is 1/128 of the end-to-end value, not 1/127. It uses the
same protocol as the MCP4017/18/19 and the mcp4018 driver supports it,
so list the binding with that driver in MAINTAINERS.

It gets its own binding rather than a trivial-devices entry so that it
can describe its supply and be an IIO channel provider
(#io-channel-cells) for a consumer such as dpot-dac.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Joseph Telaak <joseph@telaak.dev>
---
 .../bindings/iio/potentiometer/adi,ad5246-005.yaml | 54 ++++++++++++++++++++++
 MAINTAINERS                                        |  1 +
 2 files changed, 55 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246-005.yaml b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246-005.yaml
new file mode 100644
index 000000000000..9215de612a08
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246-005.yaml
@@ -0,0 +1,54 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/potentiometer/adi,ad5246-005.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Analog Devices AD5246 digital rheostat
+
+maintainers:
+  - Joseph Telaak <joseph@telaak.dev>
+
+description: |
+  128-position digital rheostat with an I2C interface. The compatible
+  names the end-to-end resistance in kOhm.
+
+  Datasheet: https://www.analog.com/en/products/ad5246.html
+
+properties:
+  compatible:
+    enum:
+      - adi,ad5246-005
+      - adi,ad5246-010
+      - adi,ad5246-050
+      - adi,ad5246-100
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
+
+  "#io-channel-cells":
+    const: 0
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
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        potentiometer@2e {
+            compatible = "adi,ad5246-010";
+            reg = <0x2e>;
+            vdd-supply = <&reg_3v3>;
+            #io-channel-cells = <0>;
+        };
+    };
+...
diff --git a/MAINTAINERS b/MAINTAINERS
index ef6033c5edf3..b680f922d9bf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -16691,6 +16691,7 @@ MCP4018 AND MCP4531 MICROCHIP DIGITAL POTENTIOMETER DRIVERS
 M:	Peter Rosin <peda@lysator.liu.se>
 L:	linux-iio@vger.kernel.org
 S:	Maintained
+F:	Documentation/devicetree/bindings/iio/potentiometer/adi,ad5246-005.yaml
 F:	drivers/iio/potentiometer/mcp4018.c
 F:	drivers/iio/potentiometer/mcp4531.c
 

-- 
Git-155)

