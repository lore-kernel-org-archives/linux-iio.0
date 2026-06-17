Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DD2E2BEFFF
	for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 16:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781714590; cv=none; b=gmeo+VziO76vc69AoOC7u7PmKfYk7Ih8Uk+U5I32rSPhf/p0gpRvCszZyYrOBqM9dTwk5S90bGKRdPSRTfDtZXYuWvKbTF3E4yMzYilCsnss6abTV0fX/quFVg6kdZ690OA5H8dn1sMwbVT/yrgYVNMVb/GE2mzr7UT2gNbKjgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781714590; c=relaxed/simple;
	bh=z0uNI+3cRdvUh3qZGJX6EassSKKeOqa0yujN3qWdboc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ALTR/vkN+grtVnQouSbiNt1D8bzszS0t24QY/P4DtTFxsT5l7K3y8e2FmXkMzIiyK/625VdRGsVxjwnCUj+rbVjaHAptP0WWdUDU2fasRQjPrNX83sjf6Axu+Cq12dc995uY/KV0nvE2tTO8T5SDDoGp+9wS59DESDGU1ZBAmhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=nOMqtXfQ; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="nOMqtXfQ"
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-7e8833c99fcso175597b3.3
        for <linux-iio@vger.kernel.org>; Wed, 17 Jun 2026 09:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1781714585; x=1782319385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=m57fUc7j93jT60i9/ebcaU66ACid66iQNI0qZdCgYjU=;
        b=nOMqtXfQF7EAn41K3IBcEPrj4msfgq2dqMuTQUvas5q1zcZZQMF5N8+Ul9rn+9ii1q
         IOoTGIIuj+vZIiA0I/WVZokODoYTpiJw1jsS/kLJACloP8WiUmSsvRHmg5lXKFjZ0cFK
         IazeHcfTZm3irDHy8n8CWJ2a8I98GobmFtIhnjsLXYYxzEHjEq4eYRgroFX1j6fBKcot
         w17S9Vs8npNw+1zGlU1C9b+/liv2Cvd7UdyI3cFkM8/sNR/kRYLg0qTJufwhDk1uGNDv
         lQoGraqx0HzF5SPLJFWz2jkTh81GcuORpC3QHM9K4ldxP++xmxAIzgEl9Yvky9DjLT2w
         xd2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781714585; x=1782319385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m57fUc7j93jT60i9/ebcaU66ACid66iQNI0qZdCgYjU=;
        b=CYob2Pq9pY34veGTCz2e7sXgNMJKK0al1IxZ3W02G3n9lwZwd+5sAg7Azkg/MnWaSe
         sG1X2+llZ9dYTmXxNRkCZuIQiG+rZD56a3amknKW+ojSyWQBu486WwmB2u0mTMoFRg9d
         b/1UtHhSWiThhWecTQhvet5ALUz9pN34G045KOio4knTysYTfQLFeip85A+GJiY/Id4d
         O7xpfXR7j96Cltpd2IgMFZF4NxsrZ/beaHt1AtzT/RRxMngWW91h30xdA9k5kkbUBZ66
         cb+GuvC95CgV4vSWCFKua0+Rj3uHCTmI+7sEj1CyYwypiYqAWJzasuyWQuLls2BGyk7m
         zzDQ==
X-Forwarded-Encrypted: i=1; AFNElJ9AgqO8BuZ+u5ZhBGxkFBAnet90LzdSSv80G2dl5uF0AAHUErwTIijdWeJSkzDwrEJdjDBhJlt9B6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbSg/148KHLKHfVDUVFKTfS1300jGELM6ffuJKn7MPZsOoOLRa
	rJIhZRgRf4S+hrN0EuUkV2UfYMvpmtGlpunlPx59miofbGbKyr4gTVbQKJsLsq9+cuc=
X-Gm-Gg: AfdE7clyP56mupyODAIGu8CtKNBq63gVTH3CPRU8QFACwM53aVYhP9EGNDhiJjr+dXw
	eYY6K1v3aNMBrrmq+25HMfylG7oCH08FjJepl1p9u7qeUeRFd/qR/qecgjY2epCJjFoFmnVwBiH
	uTtmWWkRvS1cF3ybVmK5EiiqrkYWdcg8LMHpwq7+fkaMyZynCMg1ooLw68bqUvTRzDkxwwc+kKl
	D3j0ywK5SIGnMmBBwDUlQaG2D6qHFkiff8SAsGDiVfvftA0qaC4U0lxXzNXORoa3lo09Yzon25h
	srUJY4zPWm7y0+EpeF3ukSo8W0DIUWMf+QeJKxuA3Q4hnc7VhfEMM7EWJeUvre/NUNgtZF7VH65
	qYwDS5phycvBDWeHPBMzi8QBtG/c0rBHE6qttnM1n1jyQY4yTO/DdmQAEFO7wTCxJX8UUFmyxk5
	IsRvs9KK0hoUwr0/yVRWYlJSp/Ti+ZMA==
X-Received: by 2002:a05:690c:c6d2:b0:7ff:5d6:25a1 with SMTP id 00721157ae682-7ff05d6439dmr22948727b3.36.1781714585230;
        Wed, 17 Jun 2026 09:43:05 -0700 (PDT)
Received: from notee14.semfio.usp.br (nat.ime.usp.br. [143.107.45.1])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7fcd00d9db6sm52871207b3.6.2026.06.17.09.43.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:43:04 -0700 (PDT)
From: Caio <caio.groff@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: Caio <caio.groff@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: tsl2591: replace persist switch statements with lookup table
Date: Wed, 17 Jun 2026 13:42:58 -0300
Message-Id: <20260617164258.9007-1-caio.groff@usp.br>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tsl2591_persist_cycle_to_lit() and tsl2591_persist_lit_to_cycle() are
inverse mappings of the same 15-entry table, duplicating the same
pairs across two switch statements. Replace both with a shared
tsl2591_persist_table[] array and simple linear searches, eliminating
the duplication.

Signed-off-by: Caio <caio.groff@usp.br>
---
 drivers/iio/light/tsl2591.c | 104 ++++++++++++------------------------
 1 file changed, 35 insertions(+), 69 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867e..6626e6d0b 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -229,80 +229,46 @@ static int tsl2591_multiplier_to_gain(const u32 multiplier)
 	}
 }
 
+struct tsl2591_persist_map {
+	u8 cycle;
+	int lit;
+};
+
+static const struct tsl2591_persist_map tsl2591_persist_table[] = {
+	{ TSL2591_PRST_ALS_INT_CYCLE_ANY, 1  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_2,   2  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_3,   3  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_5,   5  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_10,  10 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_15,  15 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_20,  20 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_25,  25 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_30,  30 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_35,  35 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_40,  40 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_45,  45 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_50,  50 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_55,  55 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_60,  60 },
+};
+
 static int tsl2591_persist_cycle_to_lit(const u8 als_persist)
 {
-	switch (als_persist) {
-	case TSL2591_PRST_ALS_INT_CYCLE_ANY:
-		return 1;
-	case TSL2591_PRST_ALS_INT_CYCLE_2:
-		return 2;
-	case TSL2591_PRST_ALS_INT_CYCLE_3:
-		return 3;
-	case TSL2591_PRST_ALS_INT_CYCLE_5:
-		return 5;
-	case TSL2591_PRST_ALS_INT_CYCLE_10:
-		return 10;
-	case TSL2591_PRST_ALS_INT_CYCLE_15:
-		return 15;
-	case TSL2591_PRST_ALS_INT_CYCLE_20:
-		return 20;
-	case TSL2591_PRST_ALS_INT_CYCLE_25:
-		return 25;
-	case TSL2591_PRST_ALS_INT_CYCLE_30:
-		return 30;
-	case TSL2591_PRST_ALS_INT_CYCLE_35:
-		return 35;
-	case TSL2591_PRST_ALS_INT_CYCLE_40:
-		return 40;
-	case TSL2591_PRST_ALS_INT_CYCLE_45:
-		return 45;
-	case TSL2591_PRST_ALS_INT_CYCLE_50:
-		return 50;
-	case TSL2591_PRST_ALS_INT_CYCLE_55:
-		return 55;
-	case TSL2591_PRST_ALS_INT_CYCLE_60:
-		return 60;
-	default:
-		return -EINVAL;
-	}
-}
+	int i;
 
+	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++)
+		if (tsl2591_persist_table[i].cycle == als_persist)
+			return tsl2591_persist_table[i].lit;
+	return -EINVAL;
+}
 static int tsl2591_persist_lit_to_cycle(const u8 als_persist)
 {
-	switch (als_persist) {
-	case 1:
-		return TSL2591_PRST_ALS_INT_CYCLE_ANY;
-	case 2:
-		return TSL2591_PRST_ALS_INT_CYCLE_2;
-	case 3:
-		return TSL2591_PRST_ALS_INT_CYCLE_3;
-	case 5:
-		return TSL2591_PRST_ALS_INT_CYCLE_5;
-	case 10:
-		return TSL2591_PRST_ALS_INT_CYCLE_10;
-	case 15:
-		return TSL2591_PRST_ALS_INT_CYCLE_15;
-	case 20:
-		return TSL2591_PRST_ALS_INT_CYCLE_20;
-	case 25:
-		return TSL2591_PRST_ALS_INT_CYCLE_25;
-	case 30:
-		return TSL2591_PRST_ALS_INT_CYCLE_30;
-	case 35:
-		return TSL2591_PRST_ALS_INT_CYCLE_35;
-	case 40:
-		return TSL2591_PRST_ALS_INT_CYCLE_40;
-	case 45:
-		return TSL2591_PRST_ALS_INT_CYCLE_45;
-	case 50:
-		return TSL2591_PRST_ALS_INT_CYCLE_50;
-	case 55:
-		return TSL2591_PRST_ALS_INT_CYCLE_55;
-	case 60:
-		return TSL2591_PRST_ALS_INT_CYCLE_60;
-	default:
-		return -EINVAL;
-	}
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++)
+		if (tsl2591_persist_table[i].lit == als_persist)
+			return tsl2591_persist_table[i].cycle;
+	return -EINVAL;
 }
 
 static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
-- 
2.34.1

