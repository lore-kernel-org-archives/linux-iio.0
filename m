Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE5846C82F
	for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 11:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787052878; cv=none; b=u9tDUi2akUB36JQon1m9+4NCoTW++8IGVvZuf8s/zxHewi7HS4fCiUcIN7Mc4Bhrtfelf9xjLqDZILHUY71cn0uWSKilp1g1VhMxKgaVqwIdoUgxAANJA6Fr6vzugKpD2Zpf9oj9pXD4kC4oQkqf7Y7K6cdPtOAZZ8lxbGL+mA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787052878; c=relaxed/simple;
	bh=aaM+chNBUVzOK+71XSf/Mb82WOTb5qO+DxTTOj0UyJ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z1MxXB1LARjFDtSlMluM5qgCKfHd6CX8jKktiwl5XjWwX/hDYh7rfunDt9Tma0J1GXUdA8BGx6hHg/0bHEpbeR8VNNLATzQjyrmfo3xI363nbSQhzLsF/REFKHZqMjLxZLtFGqAx40HFFnR4d4Ay0YBOnESylZsqFucCYw+Bvlk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WrFmua2M; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WrFmua2M"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-c1671ec8692so610682366b.0
        for <linux-iio@vger.kernel.org>; Tue, 18 Aug 2026 04:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787052874; x=1787657674; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=vcNEmMVFuuQmsODrVbSfU7PhXNWqkwOb79tP/Y3pu6A=;
        b=WrFmua2MqMmHEGO9ImmL+c8QmlqqjDGRqrTti86FUkA9zqoGe/dhVclrqXXRJaqelJ
         Unkn2P+pRZ8+wQgJT1AiR76bBoeAixcCIMvMrtt1JcrY5Tf+4ZEqB2U8UW+zTc7jvPIa
         1zXkXlTa17o5LjWlVwdvmJw8VUoLNkXuCSf60k04KdD2MyV90alG2T2XBgqat7+9NZlZ
         +eyMgQ91IiwTgtbnNF5wFWG5fvZDbJ6LAp2LUtLSy2iltTwJJehBOTNPhiMZ+BEHs3Ad
         jVZu9LCvsDTWfHZWfjhDuxKsKUA36zRTijkGcdpLVXtUn4s9ODJ32vd+Fv7fdzC1FuDq
         IROA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787052874; x=1787657674;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vcNEmMVFuuQmsODrVbSfU7PhXNWqkwOb79tP/Y3pu6A=;
        b=XUw4qqhE4M3YpDOjSYBq7bjq1NdG/hch9oF5JFET1IkQw5uEB8hSlef5NrDhVzr92h
         5kvqBOr8KZG6xZ1QcDOfppoP1aNC8vhI5RQTk/JfQDdujXb+BHAdWvyEgwWQllPM7IhE
         XpelzxXk3J36kA7olzJK4Zo2XBFtXhy3Xs1JILWZgP+j/x0QuFLpFycvvkJn9jxA26Ik
         fvth5HlINwJdEo19miwfPt7Ya2WE7zeBqFMtQoNuAsZ2JnFKxKIN58R+VWYjfbriDjyo
         wDo6bTw2+369VL8gJUmFqXMjCxBE839RBjxpn0KKfYmUTKvlXMKr4O77Zv3LkMtVsSzq
         hmzQ==
X-Gm-Message-State: AOJu0Yx/VgaPqa067q2hVOrNlLBpz9Ji6pb7pD7939VQMQTuy1llZpxf
	d0h+x3RhYFXAmE7thHakXcMsMa64H6I5v1FPlGbP5F2rVoT5l63KfX5O07gdRA==
X-Gm-Gg: AR+sD13eZ1O/tNh0Bx1hqvG2TIIZnRqCpRNGPit0PO6VHG8sFdb2lqolMzHIh2oLM4V
	X8itjwlUKf+JSNa5c6BEXr0r1OPTrCAgOMFRbIsIdVVhWXeExzQbuwKb7kFnK0kuNWgFWK9ljiN
	uQcBN3U5xUWRRYQgLI4XvnsklwXXkhxT4m3pthZotfxxEsyHB32q62iWSxst7kbu4TRcwXQmabo
	t3ig+HoCj0NbyVY1qYkqGzINZcJJ4j5KENN3l2iq+thubEGEeK41dVV1HzeCQzMHYcwRWcavNS5
	5iPuwhGbzpwPnV48ilN1IbboFRSZS6F2cm8bOTwzv8LtJwf6zDCdWv8j8VeClcufVSBRMeDL9kv
	dvsCE+nGk0bh9Wu2BXNVEmz2rJFUhAvYWi6KuEQ1MrsepcdlbLu/xMtm2L5b9dG8RKxeD2Nz4W8
	XP9bzJtrF+ytmwmcqdhBBoJdsOGQB8+QhykFtaiA9HXGbgi2QNOKo5w70wkI5vZUJ/ylGW9LbRv
	+hUjQ==
X-Received: by 2002:a17:906:6207:b0:c12:83c9:d41 with SMTP id a640c23a62f3a-c2129be130dmr1739874266b.12.1787052874257;
        Tue, 18 Aug 2026 04:34:34 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:17a:e1ae:f7c9:8a7c:d206:62fa])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2185b73db1sm137901966b.40.2026.08.18.04.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 04:34:33 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Tue, 18 Aug 2026 13:34:26 +0200
Subject: [PATCH v7 1/4] dt-bindings: iio: light: veml6030: add veml6031x00
 ALS series
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260818-veml6031x00-v7-1-2b0de0f20edf@gmail.com>
References: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
In-Reply-To: <20260818-veml6031x00-v7-0-2b0de0f20edf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, 
 Jonathan Cameron <jic23@kernel.org>, Krzysztof Kozlowski <krzk@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1787052868; l=3092;
 i=javier.carrasco.cruz@gmail.com; s=20260111; h=from:subject:message-id;
 bh=aaM+chNBUVzOK+71XSf/Mb82WOTb5qO+DxTTOj0UyJ4=;
 b=jMmCQLW61kUrWLBtl1MZQqb261yjfNkfD/oSsrcjhqnD356XTW/oo0iICnXNIpzZaP9oApzQ0
 POesHo2NQWxDbu3n4C9d279bI00H5/l/5DnYZsiTDYbdP2GYbdlc5TQ
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=Lge8w8xidNSf/INy7JAIbAW+Hezkp3nsBh2OjKL7lLU=

These ambient light sensors share their properties with the ones
from the same manufacturer that are supported by this bindings.

Note that only two datasheets are provided as every one of them covers
two devices (veml6031x00/veml60311x00 and veml6031x01/veml60311x01).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,veml6030.yaml      | 13 ++++++++++++-
 MAINTAINERS                                                 |  5 +++++
 2 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
index 0041e1db6838..a44de649184a 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
@@ -4,7 +4,8 @@
 $id: http://devicetree.org/schemas/iio/light/vishay,veml6030.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: VEML3235, VEML3328, VEML6030, VEML6035 and VEML7700 Ambient Light Sensors (ALS)
+title: VEML3235, VEML3328, VEML6030, VEML6031x00 series, VEML6035
+  and VEML7700 Ambient Light Sensors (ALS)
 
 maintainers:
   - Rishi Gupta <gupt21@gmail.com>
@@ -23,6 +24,8 @@ description: |
     https://www.vishay.com/docs/80131/veml3235.pdf
     https://www.vishay.com/docs/84968/veml3328.pdf
     https://www.vishay.com/docs/84366/veml6030.pdf
+    https://www.vishay.com/docs/80007/veml6031x00.pdf
+    https://www.vishay.com/docs/80008/veml6031x01.pdf
     https://www.vishay.com/docs/84889/veml6035.pdf
     https://www.vishay.com/docs/84286/veml7700.pdf
 
@@ -32,6 +35,10 @@ properties:
       - vishay,veml3235
       - vishay,veml3328
       - vishay,veml6030
+      - vishay,veml6031x00
+      - vishay,veml6031x01
+      - vishay,veml60311x00
+      - vishay,veml60311x01
       - vishay,veml6035
       - vishay,veml7700
 
@@ -69,6 +76,8 @@ allOf:
       properties:
         compatible:
           enum:
+            - vishay,veml6031x00
+            - vishay,veml6031x01
             - vishay,veml6035
     then:
       properties:
@@ -82,6 +91,8 @@ allOf:
           enum:
             - vishay,veml3235
             - vishay,veml3328
+            - vishay,veml60311x00
+            - vishay,veml60311x01
             - vishay,veml7700
     then:
       properties:
diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..4369cbf8b5ca 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -28761,6 +28761,11 @@ S:	Maintained
 F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
 F:	drivers/iio/light/veml6030.c
 
+VISHAY VEML6031X00 AMBIENT LIGHT SENSOR DRIVER
+M:	Javier Carrasco <javier.carrasco.cruz@gmail.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/iio/light/vishay,veml6030.yaml
+
 VISHAY VEML6046X00 RGBIR COLOR SENSOR DRIVER
 M:	Andreas Klinger <ak@it-klinger.de>
 S:	Maintained

-- 
2.43.0

