Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794243199;
	b=om90QBnySt0xm6EusL+vaDGfERFEiJANZv2GT5Upivs7DIpp7eeSutoUkdw3Ik6Lj/Kp
	 W43emvTh9lDyI0tiCXXlu2vcRC9bvO3hy6bXBWGryk4x62G3Td1+s6Tm2d3+pL0eOE0w5
	 uq2UYYx87UmBOeDiKc3rvPp9aMiHyaaejqPvHAH0SCzNxta4uY7s6icFhwmWvaEEPWdFf
	 zTiAKzpfzdcCU5M+JUG7FlbQJLeKTaKluuZoc6EPd67RFg5PRD/Zm5ENgfndhFqedskNN
	 ye1WHue8ut88LbWxHgOLWYzYVKrltAt4q2DB8dgqzypj1zzcY0lFbku5hcI0PWKjPJQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794243199;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ShbzkIQa6iD3Yh19E6sZ/yyHbNgJ2H3YfWH0hJZQ8kw=;
	b=cjXr7BYhL757ozXhJjO/TYrQortvN2nRFFaV/UJSVuhaWsp6DI9uO8Z41Lnka1RiKnUg
	 HLQThAceBSLBhjLpBPP1Mp4dbLAW6AL9ERbt5Kiy+5PHwgHOUUlmTNcZ1Yjpp17fSIfk6
	 sTpkKwmbHgnC+N0ueQoa8rjBRg2lYGn8WhEjHTCWFcWvGgAJrKsqAefEkKspvgGC4kWoB
	 PePvjKmfp9Mx4ZFC/REAVWtPrP5EskqxAF6hEhW/eWwZTd2LdwnZu8XeMiNFzq3xRABDD
	 OWSFKC8oTartXuEaQum14RUetF+VuclhV3mQ0KZSAOYpzZKaK2Vkk9TrtC2SJ7C5VSA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGTFNMJY;
	arc=none smtp.remote-ip=209.85.215.176
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7589B606A336
	for <linux-iio@vger.kernel.org>; Mon,  9 Nov 2026 16:53:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7589B606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=RGTFNMJY
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-cdba1b5ed8dso471010a12.1
        for <linux-iio@vger.kernel.org>; Mon, 09 Nov 2026 08:53:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794243199; x=1794847999; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ShbzkIQa6iD3Yh19E6sZ/yyHbNgJ2H3YfWH0hJZQ8kw=;
        b=RGTFNMJYdBS0cgQ88AMNk04K6Mq2fSu/WyCzOqNVC1BWznq6UgHyli2qvP+nPZPMMT
         dK5OVThC7yr34Ald/BV9e1D/n4H3TrencJ1i81wmuvwfWckHCY90ex6T0Ucb9i4gf8+f
         1ZkHmWUE1A3DcmaoquK2ekNDTk/QYfVz6+pjCIKeaF2YV+WPAVNl4Ra23hQy/KU1xehR
         40nb13lhYswzOC9AUz7NNm0WEytabQqbOMoj6c0GWp8XioV2gUmju5OGCXr4JL1dxSiH
         O1tx1aTrSMAZnqRI1XncjurNQhUhDE2tViSn4okW4MMC2T+TuUou89wdDnGz5oQaCbRH
         r+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794243199; x=1794847999;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ShbzkIQa6iD3Yh19E6sZ/yyHbNgJ2H3YfWH0hJZQ8kw=;
        b=E5BksePjN2IbcaNnuEPzEtRu/YUkPJrNsK6ZkSvZt0c1Uxdd8+qbQpFcj7IUnJaJ/z
         ZVSFoNOx2RRMgcIK9PINMXZdNbd0bgYdrgdyy7fzYkA85N8SMdWkk+Eiyr+SmsnwZrPL
         DcIujBTtRsBOfCskfxBmI65r9pUW7qynj0Idglb2Sz0EMbHsRVwmjrw8nqS0jomzWOuc
         tJx6157sQRdRQJHr9oW3es3dl/niTFiTFhYGZvk7x7Z7+xD5WdyHMsci8cXTzq4eEyZh
         P550xKj8fZjW9mQD6322r4WyYQzDCula7EfUTmU0zi6rOeQpqWgUEhKWG5NmiiiyG7MP
         n5fA==
X-Forwarded-Encrypted: i=1; AL+hErEjnZiwCZFGT0d04VO/l9inO9rB+yKdIFDPCGcPyNGleFvQqM9yyK6Uajyh7MoMnIKncKUiXvAN1c4=@vger.kernel.org
X-Gm-Message-State: APuU4Z8IAkYo2DgNg6h9Ehf0MMJsbhnsFOFjmwQkBWH67y+F+XZgk08h
	6BxfdjRG9qS90I/H2dCQ3TWsZdmKdq/3JIGyIEkFV2J6WjYeOoq0kQMm
X-Gm-Gg: AYBFou3Non9Sseiq7k42dB6WkgoThTuqE7i5A1vaTHcRTw9MKVXn/rD2If35bQcd245
	VTRcYFmTbl+RIrogKVfSxqHMLrB7uh3aRxPG/ASwRMJOKSsu3jYD8ieTuwDSRxgx64nG6c99uIm
	meNCSeoi0LQu/frNF0Nu5UeRCh/tzKMDZaPFUI+B6E18DMHUw7h3xmUSxiLSLFMDfn4KNgVXiHX
	FCbZ9ucqqEngF1ZKD+neI2XJxgKqzQbzkabE/GUXtM3gF7qGX495YB/G9JhVt9r7f/plGSq0jNS
	/74W0LZlFQ0l6l/vmM2T0sY64qaFkTHr7Zmkg0PGrbAb3ztWDVTTLCrDRCOmHNLIPYLfHJlwmPv
	EdVY2QWwgU3CdCeeR5eRsseMAbGHdVkKPsj0A5CKpp+Wz60pxPrxd4fG4OxTMdNYSjKo5BujByr
	C+Gs+OpW/rB6OECS3XcllaEaIvpRe1FDy6nrQCrL+5EdhhY0/RG7kA1Pz8w513gmlYEsQCgf7o8
	OtS+jJaOR3butKGr+uRVABn+lJKnDXsou4JaVSPn3AhqFclFgIEcGBhH+o2TAKk2jKU29Em5+77
	/UXegf+vEYzUHh81KSxKvYUoB8leuOjJAKfU/NN+h6vQIuOccDx6VJUCV1zWSA+dqQ8QU1ej6d8
	UuSZGsHq5HradGK4YPL6XCJanHyc=
X-Received: by 2002:a17:90b:5604:b0:3ac:b6eb:e0de with SMTP id 98e67ed59e1d1-3b1678cf082mr61000a91.4.1794243198803;
        Mon, 09 Nov 2026 08:53:18 -0800 (PST)
Received: from debian.ari ([152.56.156.124])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b1034718f8sm6455688a91.4.2026.11.09.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Nov 2026 08:53:17 -0800 (PST)
From: Archit Anant <architanant5@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	andy@kernel.org,
	nuno.sa@analog.com,
	u.kleine-koenig@baylibre.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joshua.crofts1@gmail.com,
	Archit Anant <architanant5@gmail.com>
Subject: [PATCH v6 02/11] iio: adc: ti-ads1015: Sort headers alphabetically
Date: Mon,  9 Nov 2026 22:21:30 +0530
Message-Id: <20261109165139.30803-3-architanant5@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20261109165139.30803-1-architanant5@gmail.com>
References: <20261109165139.30803-1-architanant5@gmail.com>
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reorder include headers alphabetically to comply with the preferred
coding style and improve maintainability.

Drop the redundant linux/iio/types.h include, as its definitions
are already provided through linux/iio/iio.h.

Signed-off-by: Archit Anant <architanant5@gmail.com>
---
 drivers/iio/adc/ti-ads1015.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads1015.c b/drivers/iio/adc/ti-ads1015.c
index 7211cefc731d1..3c2f27f41093c 100644
--- a/drivers/iio/adc/ti-ads1015.c
+++ b/drivers/iio/adc/ti-ads1015.c
@@ -11,24 +11,23 @@
  *	* 0x4B - ADDR connected to SCL
  */
 
-#include <linux/module.h>
 #include <linux/cleanup.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
 #include <linux/init.h>
 #include <linux/irq.h>
-#include <linux/i2c.h>
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <linux/pm_runtime.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
-#include <linux/pm_runtime.h>
-#include <linux/mutex.h>
-#include <linux/delay.h>
 
+#include <linux/iio/buffer.h>
+#include <linux/iio/events.h>
 #include <linux/iio/iio.h>
-#include <linux/iio/types.h>
 #include <linux/iio/sysfs.h>
-#include <linux/iio/events.h>
-#include <linux/iio/buffer.h>
-#include <linux/iio/triggered_buffer.h>
 #include <linux/iio/trigger_consumer.h>
+#include <linux/iio/triggered_buffer.h>
 
 #define ADS1015_DRV_NAME "ads1015"
 
-- 
2.39.5

