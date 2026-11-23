Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.182
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795452798;
	b=HZN734HBBYGBszZBJcwge2e1wsHgI55we0AQCwnpLaurLUm250jrBmUhpyunmLGAFDi6
	 lyiH7+zz81H9aimXw0X/ylnkn78svAFA32eoIyqdKbcMHOM14Rp80uZtRjb2IMqscT68o
	 7eQbcSiqbqUnuoSqYrjRL4Acb4kYdT2HCycd/B7gYkYN6DG6CbJLHgM/RtDhOTVCKpI2w
	 v3Xe5XJQqOCRSSbU42iBWiORhc/8phGRaSS3WAq81IR9bQ0lUM6UznbKfO6L2Z5FoE363
	 Dr8aY8Z3OLWKEooG4dHApqUda6SQv2L8NRKlKw1DtqzDEs2/DBAlj9qn+dqSWpmPyqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795452798;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UoR1p7/PkH8Dz4a5g4MXuD53QAwk1hyRbYHCFm0rXQ0=;
	b=jR16Vn/UWlVybB4p9PYBdZnZSEVH/hmoQehTivU3U24NGLODqrnXPlMRwkgZ15Ipo/H/
	 OpzFIgMUgQOGJAE2oxlChq//ojHwQl7VqR17mR/TCKVy3fVT+tgKx8u3QRDlw5J7awJ63
	 wAYFuBicrxrdR1CW/gJIQGILZ7HcqyEI0gmMpXA3PJ08DpTlTBh8z+6lqZO8eeHVi0AeG
	 8PVQKsgcsvE28AGU0EMQILWM/rbNs/UHlaAx2bgJV5Eh06M4rySLs/j80W9qnhTdFC7eb
	 ddOp41KvpAbZDPAv/gBf68uMeUQaEiaWEZMHCYifYP9q7RIr7xLS0Y0PNKp84RxjScQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1aDyth2;
	arc=none smtp.remote-ip=74.125.82.182
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655C4606A31A
	for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 16:53:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 655C4606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=l1aDyth2
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-3863db981d4so4737914eec.0
        for <linux-iio@vger.kernel.org>; Mon, 23 Nov 2026 08:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795452797; x=1796057597; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UoR1p7/PkH8Dz4a5g4MXuD53QAwk1hyRbYHCFm0rXQ0=;
        b=l1aDyth2I5Xo1f3VwDGbV6C21nlMgWr37HxyaB4v0JfpCZ1kMgu/zgMpQi/A3AHjha
         yyUWEw6h8jqhrOyoCJaJxh/GLpyvnOmourCIfZWl5/LHPO/45Kxy7XTK6RM0AD+dhMMX
         DxJMP2t4HJIfct3UlOOusVva8AQ4nIDGLU/1jKnlF9uvHNRBbyfIivzR6uTrX5/TIDh8
         IN4UgjYUd/DvdnGUoz31WxNej2BXjPaRAWUQKz0l5mtH5jyVVjOJy1SX0BdSJUlo0j02
         h7MY+EnCwEEhdCEHnY/M06/JcFMth0pVKRZRTaPx55/TGIlQSthxo0APZK24mdQ7ONkZ
         K+GA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795452797; x=1796057597;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UoR1p7/PkH8Dz4a5g4MXuD53QAwk1hyRbYHCFm0rXQ0=;
        b=PFaSikeiAbAuYazDXEacvbg14Ecr+q9wciVu8PirWQAccz/PVr36qnjwlxLmJwQLUq
         GWTgPoi24iyZJxLhzZ+qYft28RME4rVHhXWGthyJ3vJbUAejXR/dIP1DsaZqOWGn4CAS
         UUBcBF0tMhoMEUoIH4Nj0pYO09FEmM4it0BwDE+xJOC2pY2y2OGt4ThVKlY7nQTeP7zu
         rC8J/IUvYVcsKhSprkWtitsZGw8URYvZu7mfSG40DEi1rSjJLDvpFWGhlI9cNOIk+zDF
         csxS6ss1QGx1LsrxR/7XyRfctCUPzmvEAe+9dDuNVsvp8703eEFzzGL6eNr6CxG8yzBV
         hW8g==
X-Forwarded-Encrypted: i=1; AL+hErGgic+GC6bn/Zojlhgf6YEXHhXsW8ryciKeD69JnkyHljEvDmqtvm37Tpqr/lg5OMJNcLIwGi5vFZQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z9asRNL/lfhWxbUwd4MBH9DlTwDZOmDtLlPLI61/b/JwYwv+7Ci
	G6yECSpT8Ng2ELlR/uflyR1iw113btOPYw4KcghYBeL5B91eVdg94g88
X-Gm-Gg: AZFdTZd8pWezKBnsmI7NC0TKLWbcgaPm/b6xuK9Whk6/dgDJx/uPo4hAxzpSPgluoB3
	C0Q9WcV3FK8sKi8Ogq3EyPNl/MWNWKPvPiIvK8vlqzxjPeOWeKtLHWvL+8ZV++Ueu0z3cBK/2cq
	FhTxe2czJ1uUFrzQWvzcKiwXwtVdMvpWe5ULNXDbU300aT30AeNjwZK9EXH+BqFTlyMK7ayt+yx
	fGVppCV98YsW0nR03L16cVwb9AggIuAS8Bkxm7C/HvEGVrOufWP1UpNi8iqtbs/aKiXRASaeLVg
	ZvnWnAbH5Vddc1Tt8K/0C58r5Aht6f2nbM7tHidBdaZwH5SO2X570g6zbUIk7zMrMIrs8oci3Ss
	2V/CVmzIT5JJhPJ3VHMzkUhmBvDRISEgNp0TDP82fUv1iJlEVA268e9LJ+/naVuNe+1kIMd0LrT
	sh4Tnd63TieL9Aoz8qLMCjcCQrgmhoORVHg38OTVaWo62ZSQgckxIypjjxdha/3lZvJGLXfQksa
	ocLu0pSysWIAzn1JGzyf3l3pIRIvR3hLEpwtyPlVPeuqj9Vth4uBwd/WbdO049DBtKcmed/5/iu
	sXVqRDoCRJq0RBPSkWw5j6DBKGzpvs3Q3BYwTMBbI1oxwiyIfklEp9wXFOn0JMh2DEjfy1iZkJw
	LbFKJF+SDmXnRsABOfBs593kgsdKu3Qs/5LU7EuP3GYeBAOsGIxWhjDKe6LpOBuc1mkwF14i0Sh
	iwWmk+4w9F2nEF1fGUOZ/5o+2a2Iz5YkS1pNaLTGXzJA==
X-Received: by 2002:a05:693c:88c4:20b0:386:b070:6f16 with SMTP id 5a478bee46e88-386b0707080mr3556832eec.21.1795452797407;
        Mon, 23 Nov 2026 08:53:17 -0800 (PST)
Received: from kapoor.iiserb.ac.in ([203.18.51.239])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-385666e99fdsm47196668eec.5.2026.11.23.08.53.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 08:53:16 -0800 (PST)
From: Arnav Kapoor <kapoorarnav43@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Yasin Lee <yasin.lee.x@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnav Kapoor <kapoorarnav43@gmail.com>
Subject: [PATCH 3/5] iio: proximity: hx9023s: re-enable interrupts on resume for events
Date: Mon, 23 Nov 2026 22:22:49 +0530
Message-ID: <20261123165255.239490-4-kapoorarnav43@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261123165255.239490-1-kapoorarnav43@gmail.com>
References: <20261123165255.239490-1-kapoorarnav43@gmail.com>
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

The chip interrupts are enabled at probe (INTERRUPT_CFG = 0xff in the
register defaults) and stay enabled while only threshold events are in
use. hx9023s_suspend() disables them, but hx9023s_resume() re-enables
them only if the data-ready trigger is enabled. With events enabled and
no buffer running, the interrupts therefore stay off after the first
suspend/resume cycle and no proximity event is reported any more, until
a buffer is started.

Re-enable the interrupts on resume if any event is enabled as well.

Fixes: 60df548277b7 ("iio: proximity: Add driver support for TYHX's HX9023S capacitive proximity sensor")
Signed-off-by: Arnav Kapoor <kapoorarnav43@gmail.com>
---
 drivers/iio/proximity/hx9023s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/proximity/hx9023s.c b/drivers/iio/proximity/hx9023s.c
index 364ad2fd6095..5b43dc9b112e 100644
--- a/drivers/iio/proximity/hx9023s.c
+++ b/drivers/iio/proximity/hx9023s.c
@@ -1185,7 +1185,7 @@ static int hx9023s_resume(struct device *dev)
 	struct hx9023s_data *data = iio_priv(dev_get_drvdata(dev));
 
 	guard(mutex)(&data->mutex);
-	if (data->trigger_enabled)
+	if (data->trigger_enabled || data->chan_event)
 		hx9023s_interrupt_enable(data);
 
 	return 0;
-- 
2.53.0

