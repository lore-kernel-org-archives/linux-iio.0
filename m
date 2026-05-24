Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 956B931E827
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 20:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779655880; cv=none; b=oVoxdXSMHxpRGEGG1sGMwQ2jNr7YJz/Qh78Ti/9RT/8GBgc8DsuSLTTseAkiu2A0ensshuJHoxKMTdwy6BhX1QC+twOMOFXLFGRnAt+NEx/opHTaqmOazfKEb2LVQ7/AxOibWm0N8RsWuL7v2RXvwCKaHLSl2f0MYT4oj1wzh/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779655880; c=relaxed/simple;
	bh=p4FNiRW7IH11He7Tc+nMe5zvSfjEJPLmgVrsIw3u5mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MD+8eY0IDBTqJtEZT0RylmwSJVyEL+KsC7Sl/OVTq3BP7nTAbnevyAfPjwqv1MtTFildCQR09eGNRWh4g8rF6AJwU11cQ3HNxla0Q+ieX7Pp4x4vOeNfStCWMFHlHD2QJtietYAN8O7cMl4wV8mkHYnvNB7F2MyfoDZYFXg+kUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBaaNKfo; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBaaNKfo"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-452169ae568so5782761f8f.3
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 13:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779655877; x=1780260677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E0qt0dN/pnIWpLYC8cK09N9h63M8YNaBsZ6T23s5myc=;
        b=OBaaNKfovBvFN+rAdXdb4i66XzPeeJWKRY8urwzaQWoMh7vANZBI8dlLhKHdrL5UdZ
         9Fns9PjIffro/7OtsVyzd22JPEfb+a/nq1J+wynwG3F61sFNZLC5swD/Yhl3+AQNe8zk
         LWAoi1/ssVUfI2S5jaI0gh0w3+9YAG+NB8C/FO0DY0ASigy77cchDGT1l5hLWHFMRzY0
         LUn3GanFM/LjiBndZF3vl/7QGCs4vDWsY26KDiwmHAoTonAW1oiUN20wW01mSp0W9vdc
         qKYMR0dlcUYsUIPu77wpyy1oktK2QhV8XECR7o06Y0tdzvhAlu6KSJBC08d9mqhIjkWZ
         sxbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779655877; x=1780260677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=E0qt0dN/pnIWpLYC8cK09N9h63M8YNaBsZ6T23s5myc=;
        b=L15PD3oimmlc0VEJ25xjnlfDbmCbmA1Hudgs0uIEuWjPA+7O4y9K4elTnPwK2PN+T7
         7nFsWYp+RAB5Bg1RKCGsAjqDhZlfCi0wRRJUb4ed9105iC+v9TQ3jbd+YMGIaySuKQwG
         hKexs7LVaKU70tipZ6H7xLPcCkUXbTjYMUM9+jHuIK1ZTmCG7H+uK9wzuoWgZg2y/Tbo
         CtUYQ2g+OTKignprkM0Yhc+2Ji7I6R5c6IuXgWUOfxdDuA3P7a553n8pBN2V/gAutJgR
         1mDuWHHjqZG6R3/dCyJvxPIQLFTJ6LdTT7e2viXqiODSelI2utJk3Z05vRmzT4j6zCkA
         i/kg==
X-Forwarded-Encrypted: i=1; AFNElJ/bqqLwNXzHAhAWAu4XI14/f346uf69Xis6HGRNAi/Iicoe4mSn6YHJQ4W1E8Sr0vEwKL4PNecu90M=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywbrptv/e+FZ77gYzgl6yG88y+3KXonhMqY2DRvYynfZFZtsg3c
	IFHuIwL1l5OK6WlnNQzGZPCwGmZqx8bcFVIwZUrp2E9l1O4aqIzsrt7l
X-Gm-Gg: Acq92OF94QNqo4UEhvvel3WFMOjJ/KT9HrqSir6+wXxomtc0pAK3qqllkqP9p21rnzE
	nk/t68CbG4EQUHmcLH8P1yAoloVGucutWr0/wObSofLYzy++2FtQqkwruZ8f90FhyLiyOrQ1588
	lPKU1p7fQxCPjuWHN3E/WSc18ZM1aKggK+2QaZGLuKnoKfti1LrzWXkjUrsE5uHCQJzzwCUwS8C
	rO9he5rwPx8m471rApLdSvw7Kp7YsL1EG7d4kiCXO7f9SgCsQ42Kx7OaqW+wV8yt44Q9uWzO+MM
	4GYUZk4TUzT22kb5zjJuLhZQEDWLxD1rHeG28fSr5QzCeH9PcLap+6AWj/kU0Yi7CxrxZtUJmB6
	q1wgl9a5QVpMXGWygnra85to+fdBqiwvsrfDbNfvNtENhKGpQFGR4oMm65tewAaCX9KoFKRufs9
	gWJNVmkexq9H6zb0Q=
X-Received: by 2002:a05:6000:4609:b0:45e:a0ab:8bc8 with SMTP id ffacd0b85a97d-45eb368915emr16870318f8f.3.1779655876913;
        Sun, 24 May 2026 13:51:16 -0700 (PDT)
Received: from sefo-laptop ([2a02:8071:50c5:5c0::361b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6d6ebf0sm22738588f8f.34.2026.05.24.13.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 13:51:16 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	linux@roeck-us.net,
	jdelvare@suse.com,
	ak@it-klinger.de,
	linux-iio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH v1 2/4] dt-bindings: iio: flow: add Sensirion SLF3x liquid flow sensor
Date: Sun, 24 May 2026 22:49:37 +0200
Message-ID: <20260524205112.26638-3-wafgo01@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260524205112.26638-1-wafgo01@gmail.com>
References: <20260524205112.26638-1-wafgo01@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Wadim Mueller <wadim.mueller@cmblu.de>

Add a DT binding for the Sensirion SLF3x family of I2C liquid-flow
sensors.  A single 'sensirion,slf3s' compatible is exposed because
the sub-types share the same register map and are detected at
runtime via the product-information register.

Signed-off-by: Wadim Mueller <wadim.mueller@cmblu.de>
---
 .../bindings/iio/flow/sensirion,slf3s.yaml    | 49 +++++++++++++++++++
 1 file changed, 49 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml

diff --git a/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
new file mode 100644
index 000000000..5ef62435f
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/flow/sensirion,slf3s.yaml
@@ -0,0 +1,49 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/flow/sensirion,slf3s.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Sensirion SLF3x liquid flow sensor
+
+maintainers:
+  - Wadim Mueller <wadim.mueller@cmblu.de>
+
+description: |
+  Family of digital liquid-flow sensors from Sensirion with I2C interface.
+  The same register map is shared by all family members; sub-types differ
+  only in the flow scale factor exposed by the device and are detected at
+  probe time via the product-information register.
+
+  Supported sub-types:
+    - SLF3S-0600F (calibrated range ±2 ml/min)
+    - SLF3S-4000B (calibrated range ±80 ml/min)
+
+properties:
+  compatible:
+    enum:
+      - sensirion,slf3s
+
+  reg:
+    maxItems: 1
+
+  vdd-supply: true
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
+      #address-cells = <1>;
+      #size-cells = <0>;
+
+      flow-sensor@8 {
+        compatible = "sensirion,slf3s";
+        reg = <0x08>;
+        vdd-supply = <&reg_3v3>;
+      };
+    };
-- 
2.52.0

