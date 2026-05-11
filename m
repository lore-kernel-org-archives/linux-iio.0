Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC3D3C7DF0
	for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778494491; cv=none; b=hnZVYBmzklO35xHe6MN8tx424XuCxr9v0/twwVyUgi/o301woqPEQOwxMks+7jWYn/B8E+E9PKRfhfs/7seDXOL8ClBZhdpZmOvCA5FO9BLBXzWtPeIniw2odziNl1TClXFcc3HLwQdNVDkMQY37QxvQTSpEi8+uhSCwUN+J9KI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778494491; c=relaxed/simple;
	bh=UrN1afK68QFFToFk7TEvn+jetfWduXcwTRXl4nuDu/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pd/nrmZFeZ585SGC73ziVAZ2Baj43/6RLFkSAYDCVreooqbAMYxOchInSJJSP9ZUglBzVjvPdFNGMpz43vUgw5vVRf2ss5wb/FCbEmx8lY0jPFvSIGyVk1oYkNjpeoR4g2ZXu3852z6CvxJ9MgwsBujPbhj2+IMRscX1v8+IeKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q0+M+/Nr; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q0+M+/Nr"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-670ab084a39so7012922a12.3
        for <linux-iio@vger.kernel.org>; Mon, 11 May 2026 03:14:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778494486; x=1779099286; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7LdQx0+vKz6eXlxoK7NtY+oPLATkE+9I4kST4liVNUM=;
        b=q0+M+/Nr/Meohzgk01q7xXrc+94XnUO7D5MybNd01K9pyNbgk7NLOypvUfM9hXNSYA
         PlnNSfocA0p51/Aa5Tn1uiwHlrflCRttJ/E7A71qA5W981l+OJAIHnIHpSWX1CuqDzb/
         /nghVIJL1S6po4dVa08Kw4qjpuhLfPnK5Pm2JixJMuu0lkGCb2XYSM4UuAqSqUKev4uz
         o5RirwdeUbQNQi4UK/OXr5G4mtLfIwGEsZwNF17EE3J+2DhGWLqD0/KjxQqvRpjaCtJe
         aHqqFdjxq++G3g8EcxlTK/wrxCFqU3v7AgTqtal/oPTp4gmIx2CZbDBCOoVFskRv1sJ2
         rQIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778494486; x=1779099286;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7LdQx0+vKz6eXlxoK7NtY+oPLATkE+9I4kST4liVNUM=;
        b=TbA3CkeKzDdrOVhsoSWAo9MShlw3ySP5YQXsancQSN84WzpiraOqplOinZbBJQ4F5g
         YhMJ8L498nzVqLIqajDR0cMbB2bthL757dESKldtWlbcnSlOKJQIsXpq9INj1aiSbQ47
         zwmCXow8Pri6e4K929yNK73PMD0PoKvecIK0ALuH3pKe5srqMjqDrZNPcjb7SAuZ821+
         mw0ps3+Nu1iFVckChIsmitNhJAWoqL3+MLke5oC32zZCcw76Nc1d3+sNE1+OYdhyKVQI
         5SvpTaEnFjp4TdH0t7f25XSTSDeAopqB8LHi4fHN27TlVkk8hMZDCufgivJ+X9jCVuHt
         +dIw==
X-Gm-Message-State: AOJu0YxW25vNDvvC05IbWe3jrT+Ucer2CA31+V1Z31qKijaZWuDLXCb9
	I02WudD/xSKRQvMml3XUgcPXfg5qJoNzoUFlSTlFRF4nU9X05j9K1Rjj9zNKATOM
X-Gm-Gg: Acq92OGX8gJX4Ay4NKbwLcsqnMG76ZQuHcn9OGq/+/QFbpFKm4ZjkqwZQfnB4fAiwzZ
	Obzi0KWtuzg09qPZytYjTdHnWwY/4RrzfkoZiYaUfO+UYgRAekFN4qTieWpvP9YmfPPMDoSXi/6
	xMUT+ie4bd0N+VR1diWGY9T7Xji65yf7qWmKDpPVbN6r3hkRXSV2j9Gs6m9KJSbj88/Wa5YRlgj
	6JW4a6v5qAM2wHe2rqrv1fWgwEspPFYVA3Umb/7125OBHn//OXCJXZucpqMJ96UiVXy1uO27Aop
	+qJg5LvHbXB5icYiMWnHZQnt5qmG36pgwNU3YUsEy5Q9H5TLaQElyg1WWGD199FUexxLWwbDCIW
	N3Kwkwi/q6tug+H3a9m/Ie0ZEYfUkaz6+tZbx2yK79JuRpCJuL8twx10U9XveQswKNRfwqw5Xj1
	eMT0RwkmzS5WJKlSCfW8Z3XXF+4tc=
X-Received: by 2002:a05:6402:4251:20b0:674:28d8:11b9 with SMTP id 4fb4d7f45d1cf-67d63aa078dmr8788255a12.4.1778494485857;
        Mon, 11 May 2026 03:14:45 -0700 (PDT)
Received: from gmail.com ([212.75.105.246])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0b3bb2asm3435300a12.6.2026.05.11.03.14.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 03:14:45 -0700 (PDT)
Date: Mon, 11 May 2026 12:14:44 +0200
From: "Jose A. Perez de Azpillaga" <azpijr@gmail.com>
To: linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>, 
	David Lechner <dlechner@baylibre.com>, Nuno =?utf-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: [RFC 1/4] dt-bindings: iio: light: add DT binding for Broadcom
 APDS9999
Message-ID: <6acd3ce2a0e417699a8184817a4a8eb381450beb.1778491503.git.azpijr@gmail.com>
X-Mailer: git-send-email 2.54.0
References: <cover.1778491503.git.azpijr@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1778491503.git.azpijr@gmail.com>

Add Device Tree binding documentation for the Broadcom APDS9999
ambient light sensor.

Proximity and RGB features are not yet implemented in the driver
and therefore not included in this binding.

Signed-off-by: Jose A. Perez de Azpillaga <azpijr@gmail.com>
---
 .../bindings/iio/light/brcm,apds9999.yaml     | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml

diff --git a/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
new file mode 100644
index 000000000000..b20ef3677670
--- /dev/null
+++ b/Documentation/devicetree/bindings/iio/light/brcm,apds9999.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/iio/light/brcm,apds9999.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+title: Broadcom APDS-9999 Ambient Light Sensor
+maintainers:
+  - Jose A. Perez de Azpillaga <azpijr@gmail.com>
+description: |
+  Datasheet: https://docs.broadcom.com/docs/APDS-9999-DS
+
+properties:
+  compatible:
+    enum:
+      - brcm,apds9999
+  reg:
+    maxItems: 1
+  vdd-supply: true
+additionalProperties: false
+required:
+  - compatible
+  - reg
+examples:
+  - |
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+        light-sensor@52 {
+            compatible = "brcm,apds9999";
+            reg = <0x52>;
+            vdd-supply = <&vdd_reg>;
+        };
+    };
