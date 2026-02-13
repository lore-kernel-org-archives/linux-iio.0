Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C37362139
	for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 15:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770996137; cv=none; b=b57D0F13Mf+7sEZZRuA3vFREV9LSHiOsIiwkAk4bz9ns2ryFWRPjCWVjJPJBJgfepxxY4OXeCCrjYPR71jamd1FclR3/h/GQQFRLUM4bZibWhkFgmasnNCFjtOWcXXoJbJJ1RgKjftpkXd/m1dnUpq1OnSOSHJYFJwFRkVLALrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770996137; c=relaxed/simple;
	bh=xYhYEsPdd2+0oNo9iKHc5axKQXCMV0Of3fzouNXiaq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAc1bqM7qS2A05xKyyy2xSYXYwzb8wg1oBaHyMODhxN3tJ/AfvxgK++F73C1nOW22K7/V8s6lKzJOXN+0Nj3caryK678PKkyoyzrWsU9jzMiTGC4np+nFPCnAux3zs6P8gArWvFmlAGSQJSpPaohcqum+gIFPCxa31nNV+mq3KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OZRRY79t; arc=none smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OZRRY79t"
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-127148c2112so77810c88.3
        for <linux-iio@vger.kernel.org>; Fri, 13 Feb 2026 07:22:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770996136; x=1771600936; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AeQcjxOP6PSP1GLUVNa4VIyei2GpgQ4urNvIlgdld0U=;
        b=OZRRY79t2fHrMwLmIEaOrbDXRtGLmP6eXvB4Q+Rm1o6BkFgnuWEdqYaSh1CWV/veUP
         XXsouq5ILDNsKNeuaRSPHwp4JzAtiRy1q32ojSMubIa3KUZ/qclnezN/SbFyrFCzSmTm
         9UBurrrqyB6I741mmZw0dpAb8uLqo1EX0yqudEYycBcD984QLKMY2IFiEVz3rUx1GRSZ
         fa9A5RrJp7cMvT1CNEHL9qWi0bgL7Sdno3yY6xArcEdUbHe8gj7s8hmI2crpmi96mTnl
         eiW/TEsG3IZOMEyOJH/YWzXQ8tvvSlHFi4BGoEZCPEzkxnDX0zflQIRn89D5he4G5rA3
         dVLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770996136; x=1771600936;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AeQcjxOP6PSP1GLUVNa4VIyei2GpgQ4urNvIlgdld0U=;
        b=Tybu7+GeV65zjVc8l+XJUSrUfqEv1S5Yt1lG1YDEqDKocYgytYjxobdPg2wVd5XaHQ
         qyaZBRhFZaAk/4xuQi2EvRx83LJDaDA4jAVrZkXnEQrYqfzQbfA0Ph0it9m7ULhUyVC+
         2pKqOmse4WhL5VfsJZbjMAMYr/5DFfs4rXK0ORYyD3NFVa6J5iS4A/O/niWS1khxDSRg
         pnM5F4Xp7dpPC75uW//u1ee0mMH0AgVyUQQdDu0W8MQRW1GqdhF4h6ZW4hShgix92S+U
         CfKXvD8iMnpPEh730AXuca4nKv0OUefkI7Fii570dmeAEtbToG0LgCOaGVEQicKdm8yG
         WvnA==
X-Gm-Message-State: AOJu0YyCzpa6OifCI75ReEb1w0fWazZTlFaoUD4S1UMERIEIfGX45NjI
	UA5ofKu5E1BcLvYiURIHmhU5HVDhsPoMUxyEMHAHaolkuo/Mp1fA9TKz
X-Gm-Gg: AZuq6aLLK600/aCAX9BVSuEilWRaimxL8i4tXsK0US269iXqG+GjpZcK3A+3IygntfM
	usMvjOrcrgYrmLYYbC0Lr3gA0nndloWEwYfRzI6o6490kC8sDvVt3SUcg7x+orVkvQg3upBafMO
	BZIOdYpTTH0QixJ3Gy28bp83LdutpTtzfsy4/g2ozKvPpzAJbeH78vukfg34DSVQ+TR1Wte7TEl
	AYSPNMAyA1iHi5T7DZBnqHo9hJbkf5TaTuyRBOEMnauBTR9iqTfWE8oKzBqU7ssNLYMSVj4BeNE
	+yD6WxwgaRdZEIEqtl4pXcUOqfrZbP11ptTyddkmo8ojxW11Ke5T9mXde8CBK5P+azZOM0QQPbu
	DlfPTHrfiUoNXYP4qJi3Ci0YVc7jG6+ENWBK8jLyiOsJQslPKOzeTll3BjTxdxJl4CZuxGh230S
	Q9GzoUfWcAJGJIi/BZSZZzax1LobaVrLV1yw4J5XIskSSpJkZPB4FQ4sg=
X-Received: by 2002:a05:7300:bc0e:b0:2ba:b16f:8092 with SMTP id 5a478bee46e88-2bab9ec5ef6mr548406eec.0.1770996135660;
        Fri, 13 Feb 2026 07:22:15 -0800 (PST)
Received: from [127.0.1.1] ([45.32.86.188])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ba9dcd01d1sm6755006eec.17.2026.02.13.07.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 07:22:15 -0800 (PST)
From: Yasin Lee <yasin.lee.x@gmail.com>
Date: Fri, 13 Feb 2026 23:14:45 +0800
Subject: [PATCH v3 3/4] dt-bindings: iio: proximity: hx9023s: support
 firmware-name property
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260213-upstream-20260219-v3-3-df9371d29f5c@gmail.com>
References: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
In-Reply-To: <20260213-upstream-20260219-v3-0-df9371d29f5c@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, yasin.lee.x@outlook.com
Cc: linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Yasin Lee <yasin.lee.x@gmail.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=1932; i=yasin.lee.x@gmail.com;
 h=from:subject:message-id; bh=xYhYEsPdd2+0oNo9iKHc5axKQXCMV0Of3fzouNXiaq4=;
 b=owGbwMvMwCEYyfeRr6Zs90zG02pJDJn9jn0z93Ksb1RY2NT5ZpVFcP+F2yq5N09nRx/cv1bzW
 OTz1NdCHaUsDIIcDLJiiixnXr9hzVd9uCf4t2sGzBxWJpAhDFycAjCRp24M/4uPLt+5acs0E9/8
 ik/bi13FfvLHZeXosa9euGw+S/1nn8MMfwVfCnvZr79qEDTlx7SDZZMX8/wuWhCbx3X4WcsCtpn
 rZiwEAA==
X-Developer-Key: i=yasin.lee.x@gmail.com; a=openpgp;
 fpr=CCEBEC056F25E1BC53FB4568590EF10E7C76BB99

The hx9023s requires a firmware blob containing board-specific
configuration data used to initialize its internal sensing engine.

Although the silicon is identical across platforms, different products
may use different electrode layouts, PCB routing, cover materials and
mechanical stack-ups. These physical differences require distinct
calibration parameters and register configuration tables in order for
the sensor to operate correctly.

The driver has always required firmware and historically assumed a
single default firmware file name suitable for the reference design.
However, this assumption does not hold for boards with different
physical sensor layouts.

The default firmware file name remains unchanged and continues to be
used for existing platforms. Allowing the firmware file name to be
specified via device tree enables selecting the appropriate
hardware-specific configuration when the board design differs.

This property does not change the existing ABI and is optional.

Signed-off-by: Yasin Lee <yasin.lee.x@gmail.com>
---
 Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
index 64ce8bc8bd36..cc5b5284c267 100644
--- a/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
+++ b/Documentation/devicetree/bindings/iio/proximity/tyhx,hx9023s.yaml
@@ -28,6 +28,9 @@ properties:
 
   vdd-supply: true
 
+  firmware-name:
+    maxItems: 1
+
   "#address-cells":
     const: 1
 
@@ -65,6 +68,7 @@ examples:
         interrupt-parent = <&pio>;
         interrupts = <16 IRQ_TYPE_EDGE_FALLING>;
         vdd-supply = <&pp1800_prox>;
+        firmware-name = "hx9023s.bin";
 
         #address-cells = <1>;
         #size-cells = <0>;

-- 
2.43.0

