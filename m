Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B89AB381B07
	for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 12:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778415829; cv=none; b=dlPLTpRRUS7jq4iwuBq75XJUrHxNBKp6Sr0t3T66mPpaGPBWFOhhiGuHnVAh5eE0mj3nCMJwaK3Re5e2NhxCvIukfAy0c2d0v12rk+py58GQmAFZccLtNrMW+lc9hz1oR4DJR7i1jqWE7N1riShw89Owd2aujoxLPK7nvxPPQAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778415829; c=relaxed/simple;
	bh=kuysG5h2Y7Mn188naOQdZNfsytOdV64esZcTSI5DaEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZZbKpi26fOBYWv0QIGAgquTek7u7fKWuUMLdyxSZuVzl8+1U1rqONWF5V21/GATWgTPt/MXrB1/P3R+71lE0eV/1ApW0zKw8WZxFLYE2S0izCe7wB5iV+V/pkrj4GX1KCPrb4MDWrZZ6bAQVvHV15+aIRBzThUwoHe4wVm4rvPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jI2tQ5Bt; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jI2tQ5Bt"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-48910865133so2373905e9.2
        for <linux-iio@vger.kernel.org>; Sun, 10 May 2026 05:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778415826; x=1779020626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xA8yr77PL7VLLJq5Y+Ie4ll9KIN7omQUcugjMXQ7hNs=;
        b=jI2tQ5BtSovbBH/VFkYw+YgCn91wdB4IDTaL4anGh6HuNGoWHqaGDiAiXKc3DSFrED
         4zWEzy1Y/4wZDLO24Fux0jk9jgE7ukM/zxQy3JPpXnhqKxA72rkoold49NdvowL7cI4q
         A+gArnJ0cnPs3tZIkTOXErOEFBK82JUoN5HVeiJydvmO3783/9TBDzkB7RDfMMURaQW4
         Y1AHfEu1zXMB95or8Vhv8Ojz9kAaC5JOkGYMrHAhYwBxC9+Lqoy6PhrV+llAkZlWZJg+
         uHVnm0+MzP52Elvmczb+wiEOAhEFT0CwWay7pNBAxvmsYZun4yL9uwV5Na9scaZCUA1S
         aEjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778415826; x=1779020626;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xA8yr77PL7VLLJq5Y+Ie4ll9KIN7omQUcugjMXQ7hNs=;
        b=U3KcSNKNZsGBI/CqJYLGRLLPF6MSiQy6apKgBqFufcSXtyviQw7DbFJwUA3XQ8x/Sv
         IP10eZaTwz7PBpKx1aISbOgh1iz6OPvmcxk0hZZRvFKWfBdQsDS+ZgT2wmVUdTUTNgtx
         n9LBq/3/kYVOMs7iQXcfRU7g6I1hKAtwNCm2+RnCz+UbVmyfwnj4D2u2oUkH9+4NZDG1
         3MDrFG1FA7d201j6YDZ/yJCqn1UQwd/PcX+oAXQZmqHHJ+67BM08P+Cwhe+vBSabK22L
         PkDET0Uz0siuY8NFbK89SNmj/u92egvGs3RFEKirN2hif5+EdhPdmfBrnw9HxmqcDpN6
         C0hw==
X-Forwarded-Encrypted: i=1; AFNElJ9KD797s0+wYAauXWaI0KlTnf1nLNsPmRqNatXx2KVrscDRYbhBN02JM/t/VCfNzlSNIpVfQAE4qLo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4M7SxrO8TBvBTu4L5NEb6SBAhq/8e3d6FmpTTx+wN+zImRDCP
	tDB0QHjMrCDInDP0jf1C3OTRs1d+lvaWIi7OybtxGwx6irr+09LqiSMF
X-Gm-Gg: Acq92OFUONWX3Pt03TP0UXDipLd8CirLMAzFU/k7zq64/7uV0+DCRT7ByPaz96AmS5J
	OyMbnx1mLrd6pSZNI2RlVg33ZkG3RXSOdbLHLzWAybTBODqsS3tNaXqFJf0Wm5raOIDNSxSbaIh
	zPMh0e/w1HioHgUQWNzekM4f9MCDgFBL16DA8hHg9uVESMeyYyecoDUqqRktAMKhPK8zzrqfv0B
	zDYYW5DfrcDNR9NbJ+G9Ha83uX85g/VlLIe02u8KcmSlexOVfv4nEwXRQw3XHgTuoBNmdHfliXR
	WtIksHJ59c8uS9DUKCYWFH+EFIQlJ1NZdeyyEaD7K73kRXYQyeK4Sklwgk7Nfbf7Co7EQdtHf48
	3CjWFkMVtlEyhD5tOCJGpWUnd+Dy+EHfQbxHV5JPSqSaW+ehPvw6dQXwtXuzxNxFPj8joZvmnPJ
	AJ/6YJWuRlyRyLdvdFV0bDML/6v4q+IQa3NHIfRuoC05lA
X-Received: by 2002:a05:600c:a0b:b0:48a:5391:8424 with SMTP id 5b1f17b1804b1-48e532a4dfamr146423105e9.6.1778415825938;
        Sun, 10 May 2026 05:23:45 -0700 (PDT)
Received: from localhost.localdomain ([82.215.118.79])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e7041c4e8sm113150465e9.14.2026.05.10.05.23.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 May 2026 05:23:45 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: lars@metafoo.de,
	Michael.Hennerich@analog.com,
	puranjay@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	sozdayvek@gmail.com
Subject: [PATCH] iio: accel: adxl355: replace usleep_range() with fsleep()
Date: Sun, 10 May 2026 10:08:20 +0500
Message-Id: <20260510050820.27748-1-sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "at least 5ms" wait after software reset has no specific upper
bound. Switch to fsleep() which is the kernel helper for plain
"about N microseconds" delays.

No functional change.

Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
---
 drivers/iio/accel/adxl355_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl355_core.c b/drivers/iio/accel/adxl355_core.c
index 8f90c58f4..594c8ad93 100644
--- a/drivers/iio/accel/adxl355_core.c
+++ b/drivers/iio/accel/adxl355_core.c
@@ -351,7 +351,7 @@ static int adxl355_setup(struct adxl355_data *data)
 			return ret;
 
 		/* Wait at least 5ms after software reset */
-		usleep_range(5000, 10000);
+		fsleep(5000);
 
 		/* Read shadow registers for comparison */
 		ret = regmap_bulk_read(data->regmap,
-- 
2.43.0

