Received: from mail-dl1-f41.google.com (mail-dl1-f41.google.com [74.125.82.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D6241C309
	for <linux-iio@vger.kernel.org>; Thu,  5 Feb 2026 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770304071; cv=none; b=t2dTOM4OfNaEjNYkDe7ZO4sjsZLC0Rn7qXcFAFJULHl1AIOS/fFhkg7pqDfyW5fY/47ZwC+kPxwjqwBDj9t0jydbCD3eoCiIXvsBTcvLw0dIdM/A98zZam4f8976wj6FphLxAfeSWQfY89XEJbj15T0OAHaYtPFRgjKTEyI4Kiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770304071; c=relaxed/simple;
	bh=vX8BkboHsssC8Nw57SXxmpuXPbRg3g0R8uICrF6E2bA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a4/zyQkmSaaWHYG2Jccc4MHUdYQpIuJokYJvBnmlF7Ly5SDfq2PMN9wP5xIJwPsgPLdd1isKX/8M9u0knKoY2qhe96Gy8I0KVVJ3BLf0hpjfLAJMOKx8EMPNfkMeY28px45TZqZXY/9YLapQ7+yKCZJWH5z7Qetw6kNmqEvhczU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EUo9jEu6; arc=none smtp.client-ip=74.125.82.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EUo9jEu6"
Received: by mail-dl1-f41.google.com with SMTP id a92af1059eb24-1233bb90317so1606292c88.1
        for <linux-iio@vger.kernel.org>; Thu, 05 Feb 2026 07:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770304070; x=1770908870; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7Iai4Rzf3DIepNpQoUJOL8Zunvxr2B1jf9ADiX1Z9Pk=;
        b=EUo9jEu6QObtY+0555d6v9F8cntt16v3YN8gsOIfR1TmaMO7mQlKnQ53lWGx+uBLrc
         EAF6asYlw29CB4Z6cEvovRm9Qa55swnpSL8yiB2uwcOhy7CMTY80Va1ERQkthTugWUt7
         FyC+ZNnCcVWLyewxpMNVWGQginVGf6culi1SrI1VuGk8cfyd3SJ5j9MspQP3lUcrxac8
         o7xbRyJvtJZLS0p9AFgrqwejHRL5ZWD1lcFrEFwdlAgplUEDszb026TLHmaG9J5PwnUc
         QCdzLwFhEIAe+vzsfXmQWNN35n+dFxm33zmhmtrSIlsVB12ArOU+GLnbP55ylzEpsK8M
         IcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770304070; x=1770908870;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=7Iai4Rzf3DIepNpQoUJOL8Zunvxr2B1jf9ADiX1Z9Pk=;
        b=N5qf1utUDSIqVFIqucxJ5hCtp0TIeZV5bxUBgjht+38i24hTKRSDFO8KJgZv3K70rk
         qPngV7qvJBIHsv2RHLfeqELRA9Z6zMIqV90jT53WYuXCLwjgamCEaOpAKiOUXOR5Dvvd
         mv/bh13MqocqJIrx3E6Q1Kbb0qiSlOn5ptLq7ECSyecglSynmmHFDgjuiI7pE4BbbNyH
         LhCtyJPMgeje1oCr698TtgDg9bOxCCiGTJab9o649npMA0hTwSVWowtoqL4FZQWx2dyj
         +rgk+CFI05fLB9T+Zx9Rz5Ic/NiUtivALraM8nQI6wxy/FMlnno96NyCJupJjmextW4k
         tjoA==
X-Forwarded-Encrypted: i=1; AJvYcCVxvJgyxfnH4veRZxRm9nUjGmx0kTBU+kHQhsM2XSR33rfxKUFnNc6lUHw2SuUeE6H+DF55cwanDWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwWhakY1HxlAY+bJwASdOWM+OvrgYlH7zKid64WDYNGFTVE7sSW
	qFYJVP29lz7jmx9fXWR5/C7nAaXKdEO1hSKzOiwjR0g/bLIHFb6UuZO3
X-Gm-Gg: AZuq6aJYmgK0dQx86O5f5VK80Yn05tstrXUIBXA9+dqU1vlh9qcmdJEmXRhbQS4tcIK
	mJx/cAEBrA5GmPiatbYSWaGVVNcNHSJn+9SzhT7tPl3I/xqwenC9/2zJ/ChfHXcW2HUb/iAW0Tp
	dD0sgbcjlVS/n6/9BggTyEp4SmNLox3hoZYNx/xRKBxym8D3WJP6t/bZ4tMqYRwU3j8r1GRuM4x
	XeAps3Jjpt37os3JJpU336xxxkWRZk8ySFw9A6zCkfw2UOxGtSRVDbVuP3/OMSz98eaJ/hUQutE
	6qV0xmMGf59d08X/At9dPjHC3G1BKRAz5vd6E2tXZr4JiCHmYios52ahwfwyg2nfGijU7OB7YMa
	53zpy17BE7co/FhKVCbP3r8+VHq5/0Ws5W0i6kmWUi2VSqRPK1EiozLO+RANz27vsDZRu7uxoB3
	A7vir0haqC
X-Received: by 2002:a05:7022:619b:b0:11b:8e9f:1089 with SMTP id a92af1059eb24-126fc2b0f8bmr1136516c88.6.1770304069965;
        Thu, 05 Feb 2026 07:07:49 -0800 (PST)
Received: from arch.localdomain ([2409:8a28:a52:d2b1::1004])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-126f4e04467sm3909693c88.2.2026.02.05.07.07.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 07:07:49 -0800 (PST)
From: Jun Yan <jerrysteve1101@gmail.com>
To: devicetree@vger.kernel.org,
	linux-iio@vger.kernel.org
Cc: linusw@kernel.org,
	stephan@gerhold.net,
	hns@goldelico.com,
	jic23@kernel.org,
	Jun Yan <jerrysteve1101@gmail.com>,
	Conor Dooley <conor.dooley@microchip.com>
Subject: [PATCH v4 1/3] dt-bindings: iio: accel: bosch,bma255: add bmx055 accel binding
Date: Thu,  5 Feb 2026 23:07:28 +0800
Message-ID: <20260205150734.525947-2-jerrysteve1101@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260205150734.525947-1-jerrysteve1101@gmail.com>
References: <20260205150734.525947-1-jerrysteve1101@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the device-tree binding for the Bosch BMX055 IMU (accelerometer part),
which is compatible with bmc150_accel.

Datasheet: https://cdn.sparkfun.com/assets/b/9/1/f/4/bst-bmx055-ds000_datasheet.pdf
Signed-off-by: Jun Yan <jerrysteve1101@gmail.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/iio/accel/bosch,bma255.yaml      | 40 ++++++++++---------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
index c1387e02eb82..7f9c5eec35dd 100644
--- a/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
+++ b/Documentation/devicetree/bindings/iio/accel/bosch,bma255.yaml
@@ -16,25 +16,27 @@ description:
 
 properties:
   compatible:
-    enum:
-      # bmc150-accel driver in Linux
-      - bosch,bma222
-      - bosch,bma222e
-      - bosch,bma250e
-      - bosch,bma253
-      - bosch,bma254
-      - bosch,bma255
-      - bosch,bma280
-      - bosch,bmc150_accel
-      - bosch,bmc156_accel
-      - bosch,bmi055_accel
-
-      # bma180 driver in Linux
-      - bosch,bma023
-      - bosch,bma150
-      - bosch,bma180
-      - bosch,bma250
-      - bosch,smb380
+    oneOf:
+      - enum:
+          - bosch,bma222
+          - bosch,bma222e
+          - bosch,bma250e
+          - bosch,bma253
+          - bosch,bma254
+          - bosch,bma255
+          - bosch,bma280
+          - bosch,bmc150_accel
+          - bosch,bmc156_accel
+          - bosch,bmi055_accel
+
+          - bosch,bma023
+          - bosch,bma150
+          - bosch,bma180
+          - bosch,bma250
+          - bosch,smb380
+      - items:
+          - const: bosch,bmx055-accel
+          - const: bosch,bmc150_accel
 
   reg:
     maxItems: 1
-- 
2.52.0

