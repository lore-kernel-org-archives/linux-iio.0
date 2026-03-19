Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F603C199D
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:59:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773921555; cv=none; b=HgQb15r0aX3BHI4JQS1bNOI0/KI8C4sy3797YFY+5oBYNED67DCFpq2nJvDI13E4sitLbsogf0S03ZjIYXFqX9jxFfR69I5ntdZAN0sA+CtLLdveN1HjEu6Fz1Pn/oVErKQvt4dksRtanT6wbXKAPCyGrxVu7+C9rnK5rFhwujU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773921555; c=relaxed/simple;
	bh=FyYL7KjhfBkhq4Z8eKOH65vilPS2pr7+rN80jiOzQpc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sp+v77ZXsZI3L/H55p1GK+/q81TLpdN3W8HTpGh0rqsYkUJzNIdVYRe3pRRcreiyaRpcXhVphHXYLK+EersRGfUnAbe5MlxO48+IX0KUoKxE1F6p7KJhFPbAxrDjTfJab7WYj/CJ65x8vilL0cs810HjnrvIBVvFbzdVQZeldpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jr5exfEK; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jr5exfEK"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b9793fa5371so79713866b.2
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 04:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773921549; x=1774526349; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AGTiQESNTxF+kqg9mPQcr06UPYRyUnWm55j6lAp7RWY=;
        b=Jr5exfEK9YaQ/thIlySFnLsSKgAz6iUh/nMJRplGQa9P+FisjinJcPAKWx5ZaVQz+2
         Wm1R7NhYdxJCX7v83hVDHWgUsD5n/310rd2G3+a1p2AFhxxmKZNmWt61KRSUor7/7JDe
         BYwieDWtqGI61vosW7Nfty+w1swF66taFB9GUaUayGLWfRhOFHwyD1I8gG8mrOH9ckuF
         P59NgU18z2kQwL8mV2t24SpkQWH5zSXgCTuWOJhjRcntvvld0wMPfHNF1dOd8hI/deCV
         AkDdmlyJO2RKgxibJKUvRRDcc6NN1tAJiLwsrpYESDVbvVbtT4z2REU50pTQXuGVxJbE
         vjTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773921549; x=1774526349;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=AGTiQESNTxF+kqg9mPQcr06UPYRyUnWm55j6lAp7RWY=;
        b=JUda44fZ38G4UOr7dI2JwvUsVIzD+4N5zMBt6wY4FKXIPMulaqI/AnOmk+Hib4c5IR
         6p/B+9UlMbiJMdJO6A+Y+ytf/B73hL8W3MMs8UAYfzYfG5dVGOH79iwRRP5UcVfaph2u
         5Im5OKMXNbERq42GXjWh/34yORDHvemq7Zp70yDLrx8UVnYAHRv9PZ/IEQzEl2gPQccE
         jb/I+s3d9g30MwZ/8Tec/nAGVX2zTtC3AMKFdockopp9nZ4HF/ah4rTsN91dmfAnnJmb
         +YOPhsodJjLoYLHlQ+oRPVxkxTnCcDpbE18xhFsdXmfdvgIRrB5ny2DNaNo82H3WjKrh
         hK9w==
X-Gm-Message-State: AOJu0Yw+jIE0BaQpwry3/rEDyNDsnnTTL9ZzUGrXdVV6LnzZvQ2SrmwP
	2ypn6k3k9IDU5rBYTJF4uL7MKmAy45NPQ+1x0QaVwbxyvmvcrMXdppSRWVndzF83
X-Gm-Gg: ATEYQzydN41ieKBdO09ZpqZXICS54wDyJ09g7RoJ10GyLwat5nNqio3vmISNUsWWmGN
	CVhAyl1NslRlA9m9UP6w0uglaXFCF8grDpaXGB7BG+zO1aCHJkntt/fYhJLWkdWd1Rkl8/bSf4+
	VHVTrJ8ZK/T/MnliFL2wVcz1/OSqlD26JEFWqRlGydOMthuhA71X8Mxc6qgSdfCZfSSWkydDS5t
	shru/jG1D5VGMJiseFDnr5PRLi912Ns4z/ponkWjZeq4+BmxN08CsyNeeIuKcsDs41RlEXyqU/h
	yhAUr0DcFDY4IzPjnfhXa/Q+lfjqKDzOTMxUzY6yPS2MABqXLB9JX8zbWRRTqnvTCXNqjE4Iw+6
	CaaWO7/t9yXIsjVhVVf2UabXr/6mpVtL72alhl2Im+dU4ndrbYB3YwXlfpa3ux4y1nuHRxWWM7w
	RFiHAGVAHqmXb0GMCTE5s7sbQ8ng==
X-Received: by 2002:a17:907:ea6:b0:b97:fb80:dd12 with SMTP id a640c23a62f3a-b97fb810dcfmr397921866b.33.1773921549259;
        Thu, 19 Mar 2026 04:59:09 -0700 (PDT)
Received: from [192.168.0.39] ([79.133.247.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f16d3380sm461399166b.42.2026.03.19.04.59.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 04:59:08 -0700 (PDT)
From: Erikas Bitovtas <xerikasxx@gmail.com>
Date: Thu, 19 Mar 2026 13:58:40 +0200
Subject: [PATCH v5 2/8] iio: light: vcnl4000: sort includes by their name
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260319-vcnl4000-regulators-v5-2-a025d3332805@gmail.com>
References: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
In-Reply-To: <20260319-vcnl4000-regulators-v5-0-a025d3332805@gmail.com>
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

Sort include headers by file name for better readability.

Reviewed-by: David Lechner <dlechner@baylibre.com>
Signed-off-by: Erikas Bitovtas <xerikasxx@gmail.com>
---
 drivers/iio/light/vcnl4000.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/light/vcnl4000.c b/drivers/iio/light/vcnl4000.c
index 5e03c3d8874b..939ff2d65105 100644
--- a/drivers/iio/light/vcnl4000.c
+++ b/drivers/iio/light/vcnl4000.c
@@ -18,12 +18,12 @@
  */
 
 #include <linux/bitfield.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-#include <linux/err.h>
 #include <linux/delay.h>
-#include <linux/pm_runtime.h>
+#include <linux/err.h>
+#include <linux/i2c.h>
 #include <linux/interrupt.h>
+#include <linux/module.h>
+#include <linux/pm_runtime.h>
 #include <linux/units.h>
 
 #include <linux/iio/buffer.h>

-- 
2.53.0

