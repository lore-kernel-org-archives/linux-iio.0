Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD8F1C84BC
	for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 18:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776538557; cv=none; b=agu/PbFWWzvTsCrjcVmLFMwX8cT8Oz4n+x0ffd096q6+peN5rIfWuL1Wz/FWGem1H0mvoqXtkrNqnrp1JJF3wv60gtKcSCbkGWTKxMltgE/aIECKJSsAdeZ4iy3J9hxt/KNmif+72LOpoviIfjjF/3MiJyksEIq9he2btOCGDNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776538557; c=relaxed/simple;
	bh=vgd8SUC1EghmT1I9vG8BhBRDHuetUa3gam/yCrySoJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PUGRLc0gfLKm15BiCrH89Ce4J/XAvRRRGYZWZHxqiBt+o7Jp2GVPzTwsZEL/qwlC4oTt2EnXwZacGdu2vs2hDOpdw4lqQSTWGQxdPDkAPehSSEOzZK1A5a+7fuxoYAZIMA1ZPWaP6gDlZiPjxTCLzChbj5WVpq4xo6pXgjVOHMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=wEqBI+wF; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="wEqBI+wF"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2e6b6167d7cso34159eec.1
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 11:55:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776538553; x=1777143353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3EXvngyd+7SDsQ3J34kXhozlsNIp7lAIo44ViwpcH1g=;
        b=wEqBI+wFxH9Mnbr4FxIoePOsmVZ6jeb78op91es0GW9rzwyqQNOVF0rxpwtInyRyBY
         znh9Wx4uec80xE35mf04OKIrZw1rkypVbdXHOqTHl9t2HEXetGWQHlmaJ4PfkqoyF0mb
         +KgGeWUwfKM7q6Q69ISfpNif3KtXeJJfmkECLL4NT4DLO0kgQcHHNqIfMYBwckuSKl8V
         harm7wiAw6y2xIVMwhPFyJgaPdIdgUI8ctvZE/Ao65u0vQ5E579j/aNwBvBGknidhq40
         KtyqvTI5yPbBnxnongaO7S8sVuc3ubhbFbu6c7+gAgzAcnUadfFzhppZuVqVGqWMMzBz
         zZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776538553; x=1777143353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3EXvngyd+7SDsQ3J34kXhozlsNIp7lAIo44ViwpcH1g=;
        b=oV1zkPOzcrjpJlP70nYlsNTQTqyYHuVB+SoEB5vEMycUUVsLqWDI4vv5Pozgh9Q5VY
         NGC4OQhq6qBNhYO/t+qvzoIP8D0ebReXLDgaPbAXhmMDFJ8mSch6Ug2nSTIRRnb8wnm6
         rNRkL5bFZabPAMJ7P/OBmUeZ4uK5CF2KWmLyYNYBRpGtguJPch736p90gT6sKkrgTZ1f
         ZUNTlf4d07FNV7o2CVWUqjdNva8kY2rdX9bCyotCcZM76PZK7NeQMhi1fdmMGETEbWDb
         I5vxeGbIQn2KhditFDI+dDdn/UEQ+wR1EolcfYxWFDMZEwDeHkcaoWoiVrEUpUuzpOGU
         19sw==
X-Forwarded-Encrypted: i=1; AFNElJ8zDsXwu4MwpfggCrpXapmZYW8mA0RosW88TI3Y10XkyQKDGjYFEnzM+YMq9Az7T1G4Q8Dx8bFfhHs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2o6h/pak2U0HwYETcsFYp5qt+f0eSMwhsrA5zG/nkWXf0UUpq
	ssyYWcKW/Sebtq+Rg4rHv0c3uqwlfwDhaIVPGr1iT/AkKfAvzv3h8P1I3NK7ktJQpDE=
X-Gm-Gg: AeBDieuGSZeMCkb1k07i9VkhZicx9zDkGPLvxS6doyvk/dG4BofTT9TjJellacsW8iO
	zWvd7czQgr0tMtBAcEiNBViHwUBiEKtyc3FE2bSy2tozvk39m/Ru+69pq3ZenZzH3TDT12UPeZf
	msMY9Q7FgXX3fpQk7KzpgjYYNyCW74rVTalWIFs0c+FPI/H4acD0pWHazrZoqOQgqR9H3IwiTdQ
	e2TDSwJ4RCVPp6uprVWO0tF7yFgqbpAubk0Gxi/qDD8NUiQleDbnnhE+CHSPZ8hfigKHNKwp8Nf
	5NCJtsb+rEm3xWzqhhRyKyBqjsKiYM2xMpKfoZiROCG5dD3LDOe+CROwmfBB3GG6qsBpgEzlV1l
	LV0eUHUpwlbmKdcPc4wPbOmiTRDg8GjNcxqE33e2CZ5DiQooRkv4abKCkvOlp4XwtiFFqtlWcrS
	DkRFTmxfr40nvP0wEEww0Njdb3C1ST+x0Ek9fwBe9Tm75jKpoFwQmCcZL0C1H3xI41pYe87TsH4
	oxGGvrgCg==
X-Received: by 2002:a05:7022:397:b0:11a:2020:ac85 with SMTP id a92af1059eb24-12c73f94982mr1578600c88.4.1776538553286;
        Sat, 18 Apr 2026 11:55:53 -0700 (PDT)
Received: from localhost.localdomain ([177.188.223.123])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c749d29f3sm10217883c88.5.2026.04.18.11.55.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 11:55:52 -0700 (PDT)
From: LucasRabaquim <lucas.rabaquim@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: LucasRabaquim <lucas.rabaquim@usp.br>,
	Matheus Feitosa <matheus.feitosa@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH] iio: light: tsl2591: reduce code duplication in tsl2591_persist_* functions
Date: Sat, 18 Apr 2026 15:54:09 -0300
Message-ID: <20260418185422.166542-1-lucas.rabaquim@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add tsl2591_persist_table as a bidirectional lookup table for
tsl2591_persist_cycle_to_lit and tsl2591_persist_lit_to_cycle functions

These functions were prone to errors in the case of adding or updating
TSL2591_PRST_ALS_INT_CYCLE_* values. The functions utilize a for-loop
like in the function tsl2591_als_time_to_fval, allowing it to compare
the cycle value with tsl2591_persist_table[i].cycle and return lit
value with tsl2591_persist_table[i].lit as defined in the new type
tsl2591_persist_entry, reducing the risk of logic mismatches.

Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>
Co-developed-by: Matheus Feitosa <matheus.feitosa@usp.br>
Signed-off-by: Matheus Feitosa <matheus.feitosa@usp.br>
---
 drivers/iio/light/tsl2591.c | 104 +++++++++++++-----------------------
 1 file changed, 38 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867ea43..86483f0b2e01 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -170,6 +170,12 @@ struct tsl2591_chip {
 	bool events_enabled;
 };
 
+/* Persist cycle conversion table mapping register cycles to lit values */
+struct tsl2591_persist_entry {
+	u8 cycle;
+	int lit;
+};
+
 /*
  * Period table is ALS persist cycle x integration time setting
  * Integration times: 100ms, 200ms, 300ms, 400ms, 500ms, 600ms
@@ -229,80 +235,46 @@ static int tsl2591_multiplier_to_gain(const u32 multiplier)
 	}
 }
 
+static const struct tsl2591_persist_entry tsl2591_persist_table[] = {
+	{ TSL2591_PRST_ALS_INT_CYCLE_ANY,  1  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_2,    2  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_3,    3  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_5,    5  },
+	{ TSL2591_PRST_ALS_INT_CYCLE_10,   10 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_15,   15 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_20,   20 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_25,   25 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_30,   30 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_35,   35 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_40,   40 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_45,   45 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_50,   50 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_55,   55 },
+	{ TSL2591_PRST_ALS_INT_CYCLE_60,   60 },
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
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
+		if (als_persist == tsl2591_persist_table[i].cycle)
+			return tsl2591_persist_table[i].lit;
 	}
+
+	return -EINVAL;
 }
 
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
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
+		if (als_persist == tsl2591_persist_table[i].lit)
+			return tsl2591_persist_table[i].cycle;
 	}
+
+	return -EINVAL;
 }
 
 static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
-- 
2.47.3

