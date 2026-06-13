Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7F9391825
	for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781377835; cv=none; b=mxvDqwVzgM/uNkWghCRXiDsbJRKhhPguXnkMX82UzSt9APZcRamdYVyGq1JQT2evxEas+Tl0S73X1VnjyEMnuM5gAHnPOUKlxy76Lb/XHn1VKp/QTwswsrS/cbd3R/pPWhIOK1L5VTenPCj08GwvuePUlOt4n5GvZWUSQcoRJOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781377835; c=relaxed/simple;
	bh=5WojoqxUs/ntPznjUv9nyPMgBf7/G0hvcdYOyUnOR4c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gd7XdU9uGlfPogiDWhvjKP+aVuVu3GtYMM7d3ksm0b5oA823Pb0wlrrVnOj/j5ZNp/+f5DXAFvzt/OBN/RMFCTf/NQ4E62vx5F2eiERnpGStGSXUmoKI0WkjgH1xUgfO398MiOtWkOwo7qyaUx54CahXm22QEjid8E0APQ4cBVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=sNwLRfb3; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sNwLRfb3"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-beb2a97cc9aso377220266b.2
        for <linux-iio@vger.kernel.org>; Sat, 13 Jun 2026 12:10:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781377832; x=1781982632; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ODs+nJPeDxYTbJmLgo82ZIoGtAVgjXH6j+M6Vh+Y9KI=;
        b=sNwLRfb3zO0B/ei0Ec4j8ot2RRch4mem4f3ZMJYBtg9mkC5wL7/zIy60IxuQcu454V
         iqboEXwKmrG8AlwQAv6UGbBsTSSRrbjjFtQaFV5PqzOiPYzGp59K9EMForl8pnYlqmOQ
         w86hWy042s8wHtgh7ZT0Nl5akk7dyOyMUmANKABUyQc3VCOpNu48cSp41perY+3VbjDT
         clUqmjtBPNLtUNPKJrim1ybJj2LqyfIYuZgxxM+oVtN4IXO6/+nIOv6nTR1hy2eek/YR
         Wp133VY17E2CVqdfNlfEWTDzKSyZtysvhX8+VVcfqKlv1AyfmrxdRA/wXBBsfPS0Z/xI
         HfPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781377832; x=1781982632;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ODs+nJPeDxYTbJmLgo82ZIoGtAVgjXH6j+M6Vh+Y9KI=;
        b=QjuT7eDbfAVAzSCtlUCawqf779C0K+g39QN7Udndf+zmYJtnmqPED/aQAMdvsvYege
         Y9oTXWXuyEcp6ywkDeBlWd9chnroZ5vHC3xr7Su3a+DNG7Bf3mxbzDsIl2Qzc2hFeMzm
         e/DF2PVOMfdsqkpR47cewqYSDWJ/EQIuWzcmiCvaMYxhyfeiB7DLUMsIuGrOtuDYFGkk
         4a3L5jd4EuDVTsAqKnJZ6z/BHJuJdKKmVhfO+RsZwVI5tBugYeFKDdMt0cDX3wMLlpvW
         J6X5nG4KWG+/dMeU+97RUUDhnYllwPeV/FI4DRdWCmDoa6kEGpzhC0Xppz1fM78qLa5R
         2oGw==
X-Gm-Message-State: AOJu0YxnN8zWqhvvMNeZfS278Gt2RjQsONqLwFFcwozgCKyL06dgmD8I
	fhd9G/rcAPGCVZVUPnz8xv/aJW+ens1VeHi9J97pz6W/3eaciO1b6Mx3v9Ed9GgQ
X-Gm-Gg: Acq92OFvYJJawVgMDOsJJIJlNZPN2ZvBrjNU068LRjV5m8leWV+Qt6WO4kyNTLC+X7P
	qQudtTPL0QpU+YhdinJaRjQE8gEiJH2z0xGH7Dxv3K8JHGDT1BK+z+nBGjfTaxsirVAOj1JMzS8
	6xjvJlyuWGW8JLrzxTUJMp8RrA0bdwCQ4W2RZhpr2Qhk/VYyy7raHF4LDFXHix49DOjwXOx2PfJ
	qoeslOIYt9akUBkj6Z95ufmPiKkE9+U3mECrMT3mLeXhzCQi2fyJFSzAw8CZ7iNSeA8rKG4f0+I
	6bSk1G700a7yqsL7oM1wFJQk1bLsuWGhCv7DyRC5KOX+BiAsjQqLpaX+XI4rq3cL8VXrKVIDmM0
	j4BaE8ZYPqKqE9VYJASk3saYcFXe3v5JyuZOGcco2vPi6z1M+WCqNBlH7DabeBSP8uj3Ra/IsPd
	shpotB6qK9VPxt2DkCgL/PbWvbhU8wFv8GK6Bco523lf4qPh89Gdo9bh4CMA==
X-Received: by 2002:a17:907:762f:b0:bd9:2b46:99b0 with SMTP id a640c23a62f3a-bfe2b3ea941mr250053666b.49.1781377832427;
        Sat, 13 Jun 2026 12:10:32 -0700 (PDT)
Received: from MSI-LINUX.kielce.vectranet.pl ([2a02:2a40:27ec:2900:9790:7740:8855:4d8c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bfdb4b2276fsm237193366b.17.2026.06.13.12.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2026 12:10:30 -0700 (PDT)
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
	krzk+dt@kernel.org,
	linusw@kernel.org,
	linux-kernel@vger.kernel.org,
	marcelo.schmitt@analog.com,
	mazziesaccount@gmail.com,
	mike.looijmans@topic.nl,
	nuno.sa@analog.com,
	robh@kernel.org,
	sakari.ailus@linux.intel.com,
	wens@kernel.org,
	joshua.crofts1@gmail.com,
	Jakub Szczudlo <jakubszczudlo40@gmail.com>
Subject: [PATCH v3 1/3] dt-bindings: iio: adc: ti,ads1100: add support for ADS1110
Date: Sat, 13 Jun 2026 21:09:55 +0200
Message-ID: <20260613190957.654798-2-jakubszczudlo40@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
References: <20260613190957.654798-1-jakubszczudlo40@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Register layouts are the same as for ADS1100 but ADS1110 have different
datarates and have internal voltage reference that is always 2.048V

Signed-off-by: Jakub Szczudlo <jakubszczudlo40@gmail.com>
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

