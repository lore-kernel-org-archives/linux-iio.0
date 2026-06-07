Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522530595B
	for <linux-iio@vger.kernel.org>; Sun,  7 Jun 2026 18:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780857449; cv=none; b=Cv9MQT66oL3exQUb3+hBM7SJ3/XfQWmAgXbqiM4T3twSixPpSEF8FKbElQbwnhqW/kGGAQqtkjEE8MTGhfXzem+3LLQHfEiEyLXTZi9cq9lVsNH3QpGV3WpyBnMzqtOnvBluPVPhitACH8eJHNeVS+ADaFwWdmCAaZl+kWnkot0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780857449; c=relaxed/simple;
	bh=yEjOX07S4zJvX1LEDBhq5IvNEprQPi0UWzNcFypZyWc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LFUzlIW7I3StoYDl92xlozIYnWQn2rUDTvuPNX9ZhNyPAG5xSU8EsIdkwqVNN/XVpNQ7IMEgzTClIEOyCYtGR/aDdWZBvMPFQdVkYINc7fKaG/VhEm3pj5KG1vR+mYQqVN6l44W26N0QsRITbDdyMAOaMJ8tDkJ+MkQApnZ6cBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HkVXf2Wu; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HkVXf2Wu"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5aa68cfc182so2982150e87.0
        for <linux-iio@vger.kernel.org>; Sun, 07 Jun 2026 11:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780857446; x=1781462246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2akuz5+DPpkEGyOUvAGrzEL48qzjsdIRCCP8EQOQUuU=;
        b=HkVXf2WuNm5RywlEFaUdp9vZ3uj+pS5f3BDsZJRfB0m0bAcOIE1XomvLz2QOkgWtt7
         YiOexQZT44XIOQJ3/fkxkOUe6HgOC4D3f87iPD9JPfUL51o0nqgIWX67d8UXFV0nvZEC
         7jX9oL/t7VBqaCn6vvYsyNn82ihDqPWSnmZtU2hvugf6bhJHcV2Bl7G2tpP/juqlReDG
         ORtBqN67vTLHPbcmaKmZ3esNbZnJ9HJNy4DOHLT2DZl6Huz32ehsaNqF0M7078+HN3/4
         qnF7yoJ6Fn6d5AMHrT62A4CxovbWWNuPu5zqgs5knMMIcR/2H6vbRS0ISN0SAghXzFZq
         K/Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780857446; x=1781462246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=2akuz5+DPpkEGyOUvAGrzEL48qzjsdIRCCP8EQOQUuU=;
        b=sOyHixhYBeUClKjY2F5+CF1g++taqIr5Rs1HTxLziUxUDalnwh8cGbDDWwQ2Dwy7n9
         dF057FguI4+6Pb3vELEYdl95BSSNO94b1HXnucKEgbpnByRxq7j9Fg7weZQEcssIaPuD
         xwqn5B/zsQm7MU5X9+3kJDBZM7AP1tAcghPt/KZ6qG3SpwDJIFOCIZtwDs5LAtQwwW4f
         3li4THAIp7pw4V8HTVp5tUuU6Ap15YRqVQAV1zCO+Zvos7JxWJMWWwlwjlnYpmZ1+wi6
         rxGm4yjOwt/pUDNI8xKvxffynzMPY74wIRgZw/YhuYrC1yEZG8LMBrGq9aaGgTZipypD
         KyqA==
X-Gm-Message-State: AOJu0YxkFJTQmjH7MoshqUfJKHWOdfmhRbffOOXIJ1cjhuTornrgfECq
	9TN6LxEJg1eLsz/uKQgsiPrYD6/My2xRKiNQSTVp1VbR8bArlV3y9Q3PLgArpncn
X-Gm-Gg: Acq92OFGfaW1gH9jNdH5jae9bcAd4W0f0HKCaG1IROav01YGvYehdetFmRUmUkpw1/l
	QDxCCi5hPsIyHRmrud8MjrvHbL1AWfwfwPmWWtr/2NaWSwoQADJ3dfsmkVl+gk22Rrcv72JMxdl
	bPeGqmJWAeVEAcyMVmyjp2kw8/AJPQtioqMcEhZULF4+hnlE4hsCYsDw27vlse1Fnn6XK3Iuphz
	Z3UVwy65DTss69Wqtuo/JyNQLynzaOn5UGkyzASLV/7f1CdyZ0j4DqslLeHCwvCgACk9U0p1WHS
	TrOQ9yjyVMbwJ0AagR4CxrvBQvqG+miP7UG2tsV2TGL6VtfWg6JERNrrw9acKaL5AM1ZRj9/As1
	+N/OUWIrzcpccRRaRlDKgo6IGnlIMwvNq/Yt58U56/sdbmu9vejueJwnJxIIyO0X4Y4dmraWA/B
	ToxY9gPjCvb/BRo5UEnyJe1fIABkSWHby1U3jAE8Ij4DdRrkTEkks6yCXIoanal89XJts=
X-Received: by 2002:a05:6512:8046:b0:5aa:b6b:f6ec with SMTP id 2adb3069b0e04-5aa87baf627mr2236328e87.42.1780857445711;
        Sun, 07 Jun 2026 11:37:25 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:efe3:f920:63b7:5b7])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fc426sm3240809e87.26.2026.06.07.11.37.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 11:37:24 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	marcelo.schmitt@analog.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	mike.looijmans@topic.nl,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	jorge.marques@analog.com,
	antoniu.miclaus@analog.com,
	mazziesaccount@gmail.com,
	jishnu.prakash@oss.qualcomm.com,
	duje@dujemihanovic.xyz,
	wens@kernel.org,
	sakari.ailus@linux.intel.com,
	linusw@kernel.org,
	jszczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH 1/3] dt-bindings: iio: adc: Update title and enum
Date: Sun,  7 Jun 2026 20:35:40 +0200
Message-ID: <20260607183542.368184-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
References: <20260607183542.368184-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jszczudlo <jakubszczudlo40@gmail.com>

Add ads1110 into title and enum compatible for ads1100 driver.

Signed-off-by: jszczudlo <jakubszczudlo40@gmail.com>
---
 Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
index 970ccab15e1e..4c43996b7ec6 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+title: TI ADS1100/ADS1000/ADS1110 single channel I2C analog to digital converter
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
@@ -17,6 +17,7 @@ properties:
     enum:
       - ti,ads1100
       - ti,ads1000
+      - ti,ads1110
 
   reg:
     maxItems: 1
-- 
2.47.3

