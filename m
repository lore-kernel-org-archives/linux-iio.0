Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ABD6367B6C
	for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 19:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782675855; cv=none; b=hnwPTHnraicpl9xDz48dgq3cXhitudK6UB/78AX2wbZGzMzoZF+tDBaloUQ7KAcbtz7Eqc8gbnmp0ihzZkH75VQ2Mmb4hI8dMvogjUH3pI5XmwBgwzZIQTC6OATwJ5jdMBj295UbQ8BhIYjS9/z9BRaEDLeZLUfZ684pVDO7/vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782675855; c=relaxed/simple;
	bh=U2YoNQx/hGloZRC8McPJss1WdTnU2vgI7Fy7zmdhFok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0cEebPCwQHUkvwe3Gvm3+JxO649rICUobJctIWyQVvt4JogjW0+z6dTZa+2FqdEcOrnoZg+c5t/omKqctaLhPfUy27/RGQvLNnAU0C2rFFxTo+VBPC3wGGWl7w+z6U8IMhK0K0uQH7AfRURxPzOMNYAgzeRUEuT+jG6cni1jv4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=s/EKyjr8; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="s/EKyjr8"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-39ad9c80fa8so18736561fa.2
        for <linux-iio@vger.kernel.org>; Sun, 28 Jun 2026 12:44:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782675849; x=1783280649; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=s/EKyjr8VjPC2KnnfUaz0m5WdyNjpg4JtdMaKOwY1v8pWTkpDMb62NLTd6T1Jx5Iv8
         Cd0jQxT6f+PUpA1hthzVVfmKOwOINfecKywDHIzh/Z8Po2YW9EgfhLJOeNm8HoRIHbjD
         jKnTG0jbyhUbUJNlBpBK+ayvNARGUUOf3MSr+nUsQ1gIdWWK3vur5VmyHO0is/klJkYD
         iEuduo6Pm0k3z8P87Tutz+m3GNqL2Kp4fgSkpxCHhv3IcE004s6THMrwfTLJQ3eHvWda
         Dzlryju/YwoWQvxAnjf9J+e0h6BHU45pFxnzdokFhOe08hggYDgfLXXSf8vjWnfVjgDc
         n0xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782675849; x=1783280649;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L/Qd/2tRCLWffwMQFEM05180CiTbv4f9HSRyN2+W50k=;
        b=o/t+5sbcz5N+JWl/yEBB/x61T9wrw8TO3MX5LR/IoO8qtWafcCeAdLAijmLTFCqPMJ
         4OjpGJcTfkAeNauKV0jh4jWfkrMqDiw8UYR1YVBH0IG/EpWbcPujD6dtUCuhGeICM/Js
         0X1gCNfPpy65U27tlfrrDtf3oxOuG8MCSlJS5ZPz0fVZgnnQ+y7Jt1ef7gLQZQ3THBBC
         cm8YzebMeakgOpp8Vp82IMWp8m4082GxO9kszxJSl28rozm3WG8+9kSryjfdRcqj0pug
         ptPUU7UucpnNVkWOVUxIlgvk+jE/pU4Ehw4xFq7+nxKz/9raJwiSC1icAq0ZabIs4e9N
         K71A==
X-Gm-Message-State: AOJu0YxSgfhnj+q4WoerM4HHgFNjO06Sm7dTnLMf2hdbxot02+4PfpZU
	UafXKvU7BIXEj1FmVSm/wfpESVQ1is3OTt5ABakaYdYjBELjufZuQ58OJ6AQhLvW
X-Gm-Gg: AfdE7clYZCtksMEr0qpZp3aKiDOetrdM5ES5x47+3xD//iY57SKl7oeDJZ9nUGdsfrE
	mDyC9G0T2v5MATqfGceGmfLGJ9ywJZ32Bsf/xjsNQrxdWhaY8vkLtcClZAay9NRGh0ujO9Hp43Y
	xJ5oi3LMIxzgYfXajWLWYfNKuA2jH1Iio4rxrpiyU6RiSMqEicpp9kazTSartnicQb2gX3SA3SI
	h+GXyFiHcTswLspUXvS8DDKM/a6KLDA6cvpaqtznkZevLLZG9n0ZpY1/KYgF7zQHR6bvBFCGNsa
	7T2xHCJQaTU04KRVKgCGmwJrIXW1lM5WAbc1QrJy1h7e+V9BSvrzYPohIG7WMmx82n5TME0ciwf
	Q8lMy7i67lwWmzBYjnchd7QyZUnO2sT5TkMwLY/eyxHn7uqTlyv5D2nqd0hiPZHkRqoY+DRrJ+h
	OpmNk2OB1wQ37ukwSEQqdltQZCoDef
X-Received: by 2002:a05:6512:1410:b0:5ae:ba27:ee61 with SMTP id 2adb3069b0e04-5aeba27efa9mr26577e87.51.1782675849135;
        Sun, 28 Jun 2026 12:44:09 -0700 (PDT)
Received: from Nitro5-JS.kielce.vectranet.pl ([2a02:2a40:27ec:2900::3ab6])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad69551002sm5221688e87.24.2026.06.28.12.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 28 Jun 2026 12:44:07 -0700 (PDT)
From: Jakub Szczudlo <jakubszczudlo40@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	antoniu.miclaus@analog.com,
	conor+dt@kernel.org,
	devicetree@vger.kernel.org,
	dlechner@baylibre.com,
	duje@dujemihanovic.xyz,
	jic23@kernel.org,
	jishnu.prakash@oss.qualcomm.com,
	jorge.marques@analog.com,
	joshua.crofts1@gmail.com,
	krzk+dt@kernel.org,
	linusw@kernel.org,
	jakubszczudlo40@gmail.com,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: [PATCH v5 2/3] dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
Date: Sun, 28 Jun 2026 21:43:40 +0200
Message-ID: <20260628194341.66752-3-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
References: <20260628194341.66752-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register layouts are the same as for ADS1100 but ADS1110 have different
data rates and have internal voltage reference that is always 2.048V.
Also correct order of ads so they will be sorted alphabetically.

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
---
 .../devicetree/bindings/iio/adc/ti,ads1100.yaml        | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
index 970ccab15e1e..28c5e2dd0ad6 100644
--- a/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
+++ b/Documentation/devicetree/bindings/iio/adc/ti,ads1100.yaml
@@ -4,19 +4,23 @@
 $id: http://devicetree.org/schemas/iio/adc/ti,ads1100.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: TI ADS1100/ADS1000 single channel I2C analog to digital converter
+title: TI ADS1100 and similar single channel I2C Analog to Digital Converters
 
 maintainers:
   - Mike Looijmans <mike.looijmans@topic.nl>
 
 description: |
-  Datasheet at: https://www.ti.com/lit/gpn/ads1100
+  Datasheets:
+    - https://www.ti.com/lit/gpn/ads1000
+    - https://www.ti.com/lit/gpn/ads1100
+    - https://www.ti.com/lit/gpn/ads1110
 
 properties:
   compatible:
     enum:
-      - ti,ads1100
       - ti,ads1000
+      - ti,ads1100
+      - ti,ads1110
 
   reg:
     maxItems: 1
-- 
2.47.3

