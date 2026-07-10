Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C488740861E
	for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 22:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783723914; cv=none; b=J+a7t4ZCqB3pcb0pL8MVWkwd74iGBR/PP9UWf7qR0OLZwXKBdPyW6wYYlQzkO/XjgvNKyhA1IjsW0rsJa0wFzRRbiJdOFPsLGmjrKG37p+oFJ38tTi8dH4PFeSj9n7tWi4zLgY56zd2KvhujOv1agcJaTP/6IPkgt1V9yW8P/YU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783723914; c=relaxed/simple;
	bh=pXZqBPVsQAX6C4cq7oQjhumpWyE4mIYJYT8ptp1NWE4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GG/hlGG1q3Y2bdOTDR5Q+V+Xyt5yIIE6JN6TK19cq5bRCsu9BU62RP+MQtXowXR/qqUdFqf7Yk1byCcMvgmjvt8z9CXotc19fy37FUI+37v4b/w7VIFd4oWK/D5RV2CLXbbPqn5j8aHFkUs4TLz2ElzuprX/9w4tHXr9OHk3kDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=FKLKUeOs; arc=none smtp.client-ip=209.85.210.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="FKLKUeOs"
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-7eb6573bd52so861700a34.3
        for <linux-iio@vger.kernel.org>; Fri, 10 Jul 2026 15:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1783723912; x=1784328712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+y/9/z07LI3KgSCtNcOq+bFpEuuE+3foLILyjogZgfE=;
        b=FKLKUeOsv9jtwt2ztMBCCDPG+42VoAEdRHJb09LzOLO8LKBwXIeUh1d+OyZw7PRPZ3
         VWTH9owYV44UfzoHa0+u4aOYMn8QI9x9wO7/i5BK3QJImahoPEUzdl1iiCCyhtBeayDQ
         p+rX2Zftp7lZc+bDWpy3/jOd/PrSzWAe8eY/0nGScv57VMZ7sCY0QYLadUJJQlaMKE3v
         KdLcPqTlkDClSisKfY0nE6J/jkXRyr7Fyd0Nuoc7bsnuJlztcUHIFZ5HO62xi/vfFbxN
         KIv72UJefCpQV3nasOZF47cCnkrQyQi4xYLiTrG5QZZ30/1rLosX+ovTv5lKFHTayTJt
         GZQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783723912; x=1784328712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+y/9/z07LI3KgSCtNcOq+bFpEuuE+3foLILyjogZgfE=;
        b=oMjWNmc+RnaVJmN3U6ohMu7Nw0cXN0nV03bDiHNhcYjoHbbj8wZOVdvfazLb5trR3l
         D+zX4uWNiEQ3ndnh4amIIB80eALoSCXFTW4iDt2ZMgoVdms3F2XcLutPTQJqzBFvehDM
         yRLBGQsC68ZU2fHdBB305sLrKmAvulX/RLvGQBTQ5mLIvxFXdcSZjBoGKbWD6oBXuslH
         hGqP0UdAm6rnMi3nLCo/+4M7Frw61VtNhS9tY4NeWbfG8XozIBOsW8bbKL5PstjrMouZ
         MNmsgtBTdCoK1gMVdgy5Z3f163SorzTyQH2xs8xfBerlQbxxXPsv6fRbXp/S99MGMiVj
         /6dA==
X-Forwarded-Encrypted: i=1; AFNElJ+d2p8GTrOjKvm1DO96oDCXka4mn+MqTzJL2pZ/xpXIgbtnGcyfJ/9YJuUAy7IItLaLDgMR5M4fivM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+1sxfetA71IHal6P/kdRPOaUEBJybCReVdcyjPIiO8X4P844Q
	ZbHgaaY9ZiXPeuGdIhbazzD9iYRoyIZgZFQlkLed3/JKvfDLy8tdI9CbsKIn5pVckd4=
X-Gm-Gg: AfdE7cm1kx3CMtGrFtBSvjnIusCshc/sIRjjhe+Obe/1H8lsgpzPPZI6R0rQrFgxiiw
	0gV5ucqzR1BCa51CQ4Bs1W/SryskVe4ZPA8qiG6BNZuIO8XreoKdmSaDbYW2dJ8OV7a9Bgs49kD
	zbPzUWE/06o2hYMKmqFH6Aw78RKzrDqJ/AZhK1d07lWhgBM9WWR6nlxsQkE6mjxlm1ZIH3yAN84
	SOpDLlE/+oa4P0/SxglvrXdeLIA4jhoZ1yyo0Fe/tc9j7EFS4KI1ws2Z/Ua/vPQBimpWpC2wMQP
	SyGvlUFiTN1M8CAkAnXZ8RE+Vire0/rClJDGKt3YPumtbAIUgx5TutOtfB3XzXCk3onqtE7f7LO
	rL8xVsP7vhzUcLHvGxT39b4ZtEvMcLajNQKXVvob1IN4SdOKGd1AyevFEqhfwhYkVIOOY33FSSG
	JsuATN4LOwUpsXeAaO
X-Received: by 2002:a05:6830:67d5:b0:7e9:d67e:b4e with SMTP id 46e09a7af769-7ec098002c7mr518197a34.17.1783723911729;
        Fri, 10 Jul 2026 15:51:51 -0700 (PDT)
Received: from [127.0.1.1] ([2600:8803:e7e4:500:1b03:95c:fbd4:4d00])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7ebcae177c5sm7613512a34.5.2026.07.10.15.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jul 2026 15:51:51 -0700 (PDT)
From: David Lechner <dlechner@baylibre.com>
Date: Fri, 10 Jul 2026 17:50:35 -0500
Subject: [PATCH v3 2/8] dt-bindings: iio: adc: Add excitation current
 sources properties
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260710-iio-adc-ti-ads122c14-v3-2-746d52cbf1d0@baylibre.com>
References: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
In-Reply-To: <20260710-iio-adc-ti-ads122c14-v3-0-746d52cbf1d0@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Chris Hall <c-hall@ti.com>, Patrick Edwards <pedwards@ti.com>, 
 Kurt Borja <kuurtb@gmail.com>, Nguyen Minh Tien <zizuzacker@gmail.com>, 
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, David Lechner <dlechner@baylibre.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2020; i=dlechner@baylibre.com;
 h=from:subject:message-id; bh=XmbF0ShRVUfkXXkMkY1dCuNi3Zk0osW7wZx5cZbqL0c=;
 b=owEBbQGS/pANAwAKAcLMIAH/AY/AAcsmYgBqUXdSmktPX9o174RlR9Srv92fOOYbzjUQJHjwn
 oP09HbHyX2JATMEAAEKAB0WIQTsGNmeYg6D1pzYaJjCzCAB/wGPwAUCalF3UgAKCRDCzCAB/wGP
 wKnoB/4oK7Qo5dwfv6uHvZmJdJORaJsimtHCeoktgJ+Li1+VQ9WD2KFgCY28dCxy4EjvcWvc3t9
 9dExy2kHl/xIrrSp/6lhNh4UbMgrQZfjbwjdOb25iVlDAyJB01/VefKIjFR8Ff5vOOU0aNHxuPg
 3TVgBmfpFJpp5r0ujVH/OSMwe4o1vEBKMaP1Fu1AMfAtDDZwCBLtz5Towlg42AhWcpmYR2X7oM4
 NcD4dYFVaccilDVG2sgz8VV7h2k8d4SnhYXqwwuJfVAy306zgRv7k22RjKOihfjp75FWqUITBWR
 CINFGQ5C16OohgV3bwdBDzdm+c6Dt/qU9Jfc0RCuQInBvW48
X-Developer-Key: i=dlechner@baylibre.com; a=openpgp;
 fpr=8A73D82A6A1F509907F373881F8AF88C82F77C03

From: Kurt Borja <kuurtb@gmail.com>

Some ADCs incorporate current sources that provide excitation current to
resistive temperature devices (RTDs), thermistors, diodes and other
resistive sensors that require constant current biasing.

Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: David Lechner (TI) <dlechner@baylibre.com>
---
v2 changes (compared to Kurt's RFC v2):
* Make units nanoamps instead of microamps to fit known devices.
* Drop bit about allowing single value for multiple channels.
* Add bit about semantics of the array index.
---
 Documentation/devicetree/bindings/iio/adc/adc.yaml | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/adc/adc.yaml b/Documentation/devicetree/bindings/iio/adc/adc.yaml
index 8f608bf0b24d..a21ed9ae4bab 100644
--- a/Documentation/devicetree/bindings/iio/adc/adc.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/adc.yaml
@@ -80,6 +80,26 @@ properties:
       ADCs usually allow choosing between internal reference sources or a pair
       of external pins.
 
+  excitation-channels:
+    $ref: /schemas/types.yaml#/definitions/uint32-array
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the mux configuration of the excitation current
+      sources.
+
+  excitation-current-nanoamp:
+    description:
+      Excitation current sources provide current to resistive temperature
+      devices (RTDs), thermistors, diodes and other resistive sensors that
+      require constant current biasing.
+
+      This array describes the current configuration of the excitation current
+      sources. The index in the array corresponds to the same index in the
+      excitation-channels array.
+
 anyOf:
   - oneOf:
       - required:

-- 
2.43.0

