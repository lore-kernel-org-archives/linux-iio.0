Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C3D35CBA9
	for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 14:45:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770907556; cv=none; b=Imz94bjhySDo+moezOVD/j4/q9ezjsbwd+PEXQTZXW0PqjZIKKn/69YmoFOzRJEpiVTDXRNAFoAuhYpqoLYNf70FzME4byU771+VPlm6y3iPrDncYQ7bG7u13EytlFruXGoFpnl9ETZGUwb83Wb53+6kUv7xnLUrlpL8XaixSJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770907556; c=relaxed/simple;
	bh=lazVxl8WJKg/jltTmr7HFjMBJRcsa2eV7m49E9VAdAc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaCxjEynExoEmx9u4edVXp4nq7kcMvaDmxMBDEANqFj4AwhZ+12A9tdUwHlbbZPggJ6D68YEwcHwT0jTX5gg6bW5yBeyQ/JuJQI1gA4FpE+ITZ+N34MgOdtDYrPMEkzt9NfMKam3BBMIjQhRTyz0QFJZmgvGWLcbJ+7/oMHcKyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tqtwan+M; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tqtwan+M"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-794fe698e36so34328417b3.2
        for <linux-iio@vger.kernel.org>; Thu, 12 Feb 2026 06:45:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770907554; x=1771512354; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OiO+nVc5IO8Z6Ent3/Ayytw2yL90H0wfU2AM1rR7mW8=;
        b=Tqtwan+MxuRKTgh2+k0wpds8w/n7bD7UIZaxveWzj2zYi3Q3i9ZRfEBBmwp+7t9ylO
         HPoW92/P0kAek6NBLT/7ygOxMaMA+GB2AhZBgopJN1TfG60RwI464ic6e2QX8kYIiiIE
         NKEDiGDmapKWQtotggWqFH0ky/kV8jTEeOdMvY0ym1xLZRuUspjXkMs3pgHs2eOX5PBQ
         jW4+jHyh6FMQD7weZiUacoL37vtv4I9hVoBUoWZQfBI7v4NKsblTFO/nPh+o8MGu9vUs
         BjPYpouCZuRfJQbHSHsdriTiywsdUubDfLPBkvUTS68HMb0vRFY4+MQOMPTpUVu4FISh
         ReCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770907554; x=1771512354;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=OiO+nVc5IO8Z6Ent3/Ayytw2yL90H0wfU2AM1rR7mW8=;
        b=HS4rzjFkl6vlUARp8UtUM56zlkhf6WasutD7Fvjn4v2ojMXp24JSw+HH/+UwfCNKjw
         z5JmIlYf0zdxWw7v1OL1rvwXsFe662C523Z/vOT23Gf+rNiThEg7//v1PaRJx/piWJ/d
         hHrKAztkVhjdeQ0mgJdUJ4P7e6vGHdSLgUdNLhaoPRNGziPeoEmG8kyw8xf540Ociu8n
         ITdXRSufC+VyADpbfy1/Zia7fM774kX1iaUEtx5qXxHlI2IbSQ/vSa6Fq9QEAtznLYRV
         VM53qM/g8rNn08P1G52n89zMTtehvs5yqTOSjLWmqzAMZV8VP2nuRhA2q4M9iHqwuou4
         DnPg==
X-Gm-Message-State: AOJu0YzwR4QIXFugUKK+SsqCl19IVSgLztYPzGi9lcFIDB9wAzgmB8Uj
	eMza+vCmlE4GFEfqRlr9CWlebRvpLfpvFD+KXcpYc3C5a56Abe873q06
X-Gm-Gg: AZuq6aL8AIDLGbu15XxvggFbjGRpm8MSjB6vUqW2KHeMsAU0Le7juM6p7LbaTcxhRJD
	xSBKNcbryuBUX/jQK6Gq4uGTe/17d7ZlZBSbDMSkEaBhQCfU1zQ++ijImDMSrSaZ44YXloq8Z+J
	Tb+hzhtXJSQg+LOTLDzPsAIzXYAMMeWbb4CoR9HvtApv4ch3B/mI2eWjNJSf9CUTmaNoqeAyIcI
	gCPGCxuIYZfJbOxVg6UWaQu0+jR3Egk60ZJwPaEO0O+olQHJ/zWQOkYqyqHETwkMQYfVhhhHsiu
	1wExpNRBNjA6zuQa4sKWxxJ9MxmMSJF+GYnXQ6woO+IFYrVTLwnGWTS2PaGV1GHwHgEmWcgf0dl
	8oSmbA9OUy9z/1hBRBr1NeGgj8eC5c3OePEhpnv6sOQOswMgXFifcI3K+F+9fkzAAl6FIqRIc68
	awjUpkh3f/HqmcCIr35wCfZjUdpg==
X-Received: by 2002:a05:690e:400e:b0:64a:ee9d:8b83 with SMTP id 956f58d0204a3-64c081ea5a8mr1592504d50.41.1770907554038;
        Thu, 12 Feb 2026 06:45:54 -0800 (PST)
Received: from [192.168.0.40] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64afc83c201sm4897318d50.3.2026.02.12.06.45.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 06:45:53 -0800 (PST)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 12 Feb 2026 16:42:47 +0200
Subject: [PATCH v4 1/2] dt-bindings: iio: light: vcnl4000: add Capella
 CM36686 and CM36672P
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260212-cm36686-v4-1-8f587d4a72bf@gmail.com>
References: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
In-Reply-To: <20260212-cm36686-v4-0-8f587d4a72bf@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Peter Meerwald <pmeerw@pmeerw.net>
Cc: linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht, 
 phone-devel@vger.kernel.org, Erikas Bitovtas <xerikasxx@gmail.com>
X-Mailer: b4 0.14.3

Capella CM36686 is an ambient light and proximity sensor developed by
Capella Microsystems, now a subsidiary of Vishay Intertechnology Inc. It
has an I2C address of 0x60 and is fully compatible with an existing
driver for VCNL4040. Capella CM36672P is a proximity-only sensor that
is fully compatible with CM36686, and therefore with VCNL4040. Add
compatibles for cm36672p and cm36686, with a fallback for cm36686 of
vcnl4040.

Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 .../devicetree/bindings/iio/light/vishay,vcnl4000.yaml  | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
index 4d1a225e8868..2ba4d5de4ec4 100644
--- a/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
+++ b/Documentation/devicetree/bindings/iio/light/vishay,vcnl4000.yaml
@@ -18,12 +18,17 @@ allOf:
 
 properties:
   compatible:
-    enum:
-      - vishay,vcnl4000
-      - vishay,vcnl4010
-      - vishay,vcnl4020
-      - vishay,vcnl4040
-      - vishay,vcnl4200
+    oneOf:
+      - enum:
+          - capella,cm36672p
+          - vishay,vcnl4000
+          - vishay,vcnl4010
+          - vishay,vcnl4020
+          - vishay,vcnl4040
+          - vishay,vcnl4200
+      - items:
+          - const: capella,cm36686
+          - const: vishay,vcnl4040
 
   interrupts:
     maxItems: 1

-- 
2.53.0

