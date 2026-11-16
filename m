Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814820;
	b=wa+IZhC5wicsamqs666Toc/myFGaexI5f1gvFBPYwnrkADnnqyf9qZ4X+i0FJdMOiejp
	 0KYhRVv+IrEmO0zNFPVdTFr8qua2PBBcf+0sl9uiPZznCkAat5IQ9pHORdWavmWj0fGPh
	 vwdJVxI+8HZvSO7wrmonrqQykuv67Sl/KzPW1aYClOIWOjw6mICad/fnumrspWEGr/uVC
	 nl+hcVzW8CPihLORsCISe8H5wRX4ZYa62IQFeFf+X2+cJ2INyo3oko1aAic0Okd3mTgqZ
	 D5fdLuxErpn9YaeU0bB4pnjWGBUjpawcndcISNWCs4aTDq31jLuxZf+dzAD+QLUvHRQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814820;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=xyQrPGCPEbH8yQYIpRCWFwW9mLNyzd5f976QgJ4wDRg=;
	b=UJWghI/0+vqQ8+ZYaSW4YFeDZ+lrmfWP82powfnKQPR+RJk4UdjSlW/tbfhOPZIry3s3
	 8mPqwDbt8KEVpT47XA6F84i46Gz2lDLbdOPUYwGCUoMl1xdLxEIdLb5AY/xbFR4j075wM
	 7RsozL71jDsJnYAkMP8bW+ZIrG/Dt1ZrD3NRQOD51+AYN9pCRLkT8R/8qU2GRgbRR1oUo
	 YMpvSTMrgaB/Ta7Qg7+A9yp6lgLXlV0FtNIg1pC28jYkhRdZysgzWoE6SIp1sV6z/MEEg
	 hPBvpp/ggEQgMOrWUOrxG70wYmFFCjj7OL/FG8PIcMksAYzRWvOsa2yQIoMlwOHQyWQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQIllmdf;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7C5360A2621
	for <linux-iio@vger.kernel.org>; Mon, 16 Nov 2026 07:40:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A7C5360A2621
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=MQIllmdf
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb702a7548so4741045e9.1
        for <linux-iio@vger.kernel.org>; Sun, 15 Nov 2026 23:40:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814818; x=1795419618; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xyQrPGCPEbH8yQYIpRCWFwW9mLNyzd5f976QgJ4wDRg=;
        b=MQIllmdfsamobYuYUbGh9pvlZFXvPPC48p3GzVjsX6TjMA3ZgemLVBR07Z5z9Pydgz
         BxmvMPGn6WGP+hHdEsPbYZJRL4BlW66LGLG55I1Rm9ppkiw02kUOE9DSKphefjhRHydL
         bPg9vXOPPx8xe/4on9mIkq4CkgjmcT7T/F3seQ0wNgjGjdmqW9S+5h3ecYHWgCQx43Wg
         Huest9FK/uzkeER2HS91v0veh8tjxG5oMm7lKtuxQK8ZRwnLxpF3OHvmGL8Gidd/ca+L
         E4R7h0BWSJcqGovUYSWpOToJanLNrfvuAX38juFYCZialZyFGIdoPfRfpfpBsKfPNcn1
         larQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814818; x=1795419618;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xyQrPGCPEbH8yQYIpRCWFwW9mLNyzd5f976QgJ4wDRg=;
        b=fv/fW7MH2Dj5ExqvJwvqSaxm048Ib7ERZV2E4ajc1wxYTDcK4tXaJvtNkNszwO7QKO
         TA+Xejie7yBpBa9+dzXyZYPunhyK0bxKQ/ADW5YYHJfiyYFg2IWWQajGjFn/A5DtoPNi
         c2ZODYs79jiXK1ZMA+IXtLNFUrW7irCJbas3Drl+RKINd8TycLIWM1mhCOdZKOJAtmL7
         BzGlgD4nLyP2FAmMefhgx3hCEW74kmJEy5WPSDOMfRYC9D30FUAUfAlfoGiQRSRordKY
         KXhYFtnmJgnh++Y0gky1RmQIJifsi1Y5kyjg8uPxw1GwZuA9XbRsNQV73cjk2eUAO4YD
         v9tA==
X-Forwarded-Encrypted: i=1; AL+hErEEFApTNK8UPrUestq16snSaBfeLb7Y3dWATQqpiRh1Sttg0KUvgkBoho9yQQG/cJ/YWzux2JAg6MA=@vger.kernel.org
X-Gm-Message-State: APuU4Z+a/lyCtUW5pEDNmui5sCCDxLyN/mj2YhjqoFX3PHR0Yv2U7VaX
	lTpHf7aLt08dS4FDXzXejGVdJo4ZHZWcwqtuU+1Kz3R8VDI1pwlo1tLj
X-Gm-Gg: AYBFou3U5A75p3AtIM/ZJLP1xZ2bZ2OZFdZu9lntYvtp8Zj9DN1Dj5oFnePxAol7E2L
	YRvI9XP+F8mQ0Ezjr04HsDwOF8w4fMLk6yb+4GCqKvKiY+etDcxzwILFVYeZjbfphQ+h/AtpxZD
	uD6gqvEvGootkJ1jEHJ9v621NgYAe5qQvsHdXY/2SnbH7uSWjA/UiA1pfrNAeZezi8b4hlD/YVZ
	TwB8FaCI/oIsYwNuteqh8iAJproSAJne648EV+Az00Rb9RsCeAAmArMLkDjhjFCDbeUvuMNwmxe
	ZpaCI5lE/hoibc3aj8IFtNzZnKx34FcM/uzTpiBjT5hGThcAomMYfiK0PxvMU6FFFSEZlqWQ3PP
	t6YMpp76F3AHT8bpz+/2OhkpS12fiF2kR0xNOfxLRviyG6y+Dz3NlPXj70VfSI60565rsMYiDI8
	oFh7pM/OkwXi7f0nMdRbAYrEymu3kTD77jLfheoYN9GbfQnSmw6ofkRv4z2+2IvQEVTFvg1qBqM
	RTmA2M/QgFs2bKZ2aZQuRw6OXoZfR2gYvaFzsyYarxGSDvZ0Ddg8vo9+leFLTMv/wN37YxVc6Bm
	REEa5kuOiQE=
X-Received: by 2002:a05:600c:154a:b0:4bb:6a5a:7824 with SMTP id 5b1f17b1804b1-4bb6a5a798emr78860495e9.30.1794814817903;
        Sun, 15 Nov 2026 23:40:17 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb571cfa2esm259712705e9.2.2026.11.15.23.40.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:40:17 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 1/2] dt-bindings: iio: proximity: add Imagis ISG5320A
Date: Mon, 16 Nov 2026 10:40:12 +0300
Message-ID: <20261116074013.355363-2-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261116074013.355363-1-tadilhusrev@gmail.com>
References: <20261116074013.355363-1-tadilhusrev@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a binding for the Imagis ISG5320A capacitive SAR/grip proximity
sensor (I2C), as fitted on the Samsung Galaxy XCover5.

The binding was drafted during XCover5 mainline bring-up with the help
of an AI coding assistant (Claude Code, Anthropic) and reviewed and
validated (dt_binding_check, yamllint) by me.

Signed-off-by: Adil Hüsrev Tepe <tadilhusrev@gmail.com>
---
 .../iio/proximity/imagis,isg5320a.yaml        | 56 +++++++++++++++++++
 1 file changed, 56 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml

diff --git a/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml b/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
new file mode 100644
index 000000000..b23d6bafd
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/proximity/imagis,isg5320a.yaml
@@ -0,0 +1,56 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/proximity/imagis,isg5320a.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Imagis ISG5320A SAR proximity (grip) sensor
+
+maintainers:
+  - Adil Hüsrev Tepe <tadilhusrev@gmail.com>
+
+description:
+  Imagis ISG5320A capacitive SAR/grip sensor (I2C), exposed as one IIO
+  proximity channel (B-channel diff = CDC16_T - BSL16_B). As fitted on the
+  Samsung Galaxy XCover5.
+
+properties:
+  compatible:
+    const: imagis,isg5320a
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+    description: active-low data-ready / proximity interrupt
+
+  vdd-supply:
+    description: sensor supply
+
+  wakeup-source: true
+
+required:
+  - compatible
+  - reg
+  - interrupts
+
+additionalProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        grip@28 {
+            compatible = "imagis,isg5320a";
+            reg = <0x28>;
+            interrupt-parent = <&gpa2>;
+            interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+            vdd-supply = <&grip_vdd>;
+            wakeup-source;
+        };
+    };
+...
-- 
2.53.0

