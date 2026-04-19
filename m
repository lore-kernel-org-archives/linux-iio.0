Received: from mail-dy1-f174.google.com (mail-dy1-f174.google.com [74.125.82.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A05F10F1
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 00:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776558974; cv=none; b=g+23J/1gIn6jm6gYsUGabNP9bahSTJi4pgE9JZFiDOkFE+zBfNVyr8m4vyqy4M5cJSEO7TSlOp5vf/4/M7zGIKDWc42NXQd3cGbzTbKvG4TEKH0/Ps8+K4K281PHCIoEVlday1ZQqDuobvTPMIKUXckSxZ3KdfJaxXHYyxVD0ZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776558974; c=relaxed/simple;
	bh=53RGE1t2+7saBafrrL6B8/T4U0qGClratEd4TrMk70g=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wx/kG/kEQZkeo+oFSZRVyqWiFgKo/J38POF318YW17KB14LURT6NCmXM0Fl6Fhd9DLOsRMp/TaIiLYy2uLHyxKEF2xz30hfeNlve/ofaKW7O4OQeg9DM7nmgLhOzugXHk4yjy5DVZxg7s0vTxA4fMApjTYeM2nlsy6SqFAi7PPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=W2eWYWun; arc=none smtp.client-ip=74.125.82.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="W2eWYWun"
Received: by mail-dy1-f174.google.com with SMTP id 5a478bee46e88-2d96243c8a1so118808eec.3
        for <linux-iio@vger.kernel.org>; Sat, 18 Apr 2026 17:36:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1776558970; x=1777163770; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KYAQit1qpWD2EbbKRlZhtnJXb/3TTPBbnFppv8glLdA=;
        b=W2eWYWun8xP0fXo37EwWmJaQDluNbPwfTt6YuxHcdmdn39aDlG2ohheqJKlkyXX5tT
         QuwJiUEYNrbGy94NALb3QApXIkBgP5xY/GRTBESdPNqm1O3l2QVkpZpTWLuaiT4Gf3WN
         01US/OYr57V4Fwc2mdWl8Nq3kpQ6/OB/3ttBuYYdTCBsaUTKI6XoNj8LhlQrcMTKy8n5
         pFItdpPFHs22eBt1uRVFxRKVG6hqOaVmQvCwMIofRN+sYPMKiBD9znhnwlUBYsoqj5Ka
         O7/SIrcbsr6i6EjC/Ca+4WbciWnKwl3Qe/ItZkn/IY1xTjI2luwbHLSzdcuI/cMaStc3
         sazA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776558970; x=1777163770;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KYAQit1qpWD2EbbKRlZhtnJXb/3TTPBbnFppv8glLdA=;
        b=J37twfNp21RMbR8sDVAFdswX/m9mzz8woKG9saOgTxD71lHQ9VmUAzJ91s7rTBnAMx
         /5Iki9uNIs1OCWnpjdGbNpML8td1dGn7nn3XMtLv8uDakW4oPWBD5+JRE3Y8ecTVoae+
         4H6WxsraYjDElDpvIqw/f/jqPGq+3mLsRquSCmFqQaziX+fcHCoUDFXoaguoicXUazQg
         wEi6Af+9UVaMcWusUbkBuZDdX7wLinjts3lWZJzKTm/Q7+xKKS8QnfGZ8kTAkd7vHO/1
         qPqBUUNKpFvHSm/MsyGmfh1uC9vhiQKNpawTr8my3nTZt3W3yc5YhaIT8yGs3jucOIOt
         8VTQ==
X-Forwarded-Encrypted: i=1; AFNElJ8gDhW/y389zA2B2LRw3HlGRc6aizWQRGFHqmJ2v27BH6R0/MP5mZ5b3gpnp7nGr+rrOvBoWK1ZK9Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylf9n4MeHhrYu2bfvogVtCCjhuwkykW4fZmvJMP99PAenlIC4F
	oTpbPB5u4krGySsfdax1DN2p2Yr7tnVDYEwLS++Yn+qoPS99HoftR/moCVnbAX4xZmF+8+AKBrN
	NuaWh5V0=
X-Gm-Gg: AeBDieu2ks8TxP0J9rMsDquJq4R/sbrOKkzZsImjlemuPs96iLX2Ot6jYcVSw4GUIhr
	RZQIlpdT5G/perLKzXgnb9Hx1z7aS3BVHXFZ8aN28hkW5wil2NAqpYwCrYXqhmp2P9tB/ztucww
	2od8I/m0EhjUu7lKSAywhBHs0N3/uHdAEEzJvmKCpxVOyL22PDvA7uJiDdU4HWvjX3TS/lyauX4
	r5pfWQgyHM5aLc2O4F079gGkqclPMQg4iP5mrfU+RPMAjr6GKyVvBLBU+sLzP9oDAjOYBNZJsNn
	qLcjcTWf9c+VQysMTTHsblHdjyRNlo06wGNYSXCQOVRYjRFm2tYLxdElniFvJW9mGF91C/HsLhF
	bWCw9HGnwt/lpjXRQYY/2XEMhQdIH32Pmi7ELaaOtqZjQXupkMcikZYzR8juFJxMZsK1wRFMluR
	4kwRAgGgBCnJgBN6X2bPxYo4Dfsho1EL9Mn4UgGJUZ1qGLbKFs6RZQphB6q3UAmqKGJnItcvYGD
	RmpcydiFw==
X-Received: by 2002:a05:7301:6785:b0:2da:a813:a629 with SMTP id 5a478bee46e88-2e466044070mr1711863eec.2.1776558969578;
        Sat, 18 Apr 2026 17:36:09 -0700 (PDT)
Received: from localhost.localdomain ([177.188.223.123])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2e53d2ce98csm7853585eec.20.2026.04.18.17.36.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 17:36:09 -0700 (PDT)
From: LucasRabaquim <lucas.rabaquim@usp.br>
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: LucasRabaquim <lucas.rabaquim@usp.br>,
	Matheus Feitosa <matheus.feitosa@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v2] iio: light: tsl2591: simplify tsl2591_persist functions via lookup table
Date: Sat, 18 Apr 2026 21:35:43 -0300
Message-ID: <20260419003557.45287-1-lucas.rabaquim@usp.br>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace the switch-case logic in tsl2591_persist_cycle_to_lit()
and tsl2591_persist_lit_to_cycle() with a bidirectional
lookup table tsl2591_persist_table.

These functions have redundant switch-cases. Now they use a for-loop,
like in tsl2591_als_time_to_fval(). The change simplifies
addition or modification of TSL2591_PRST_ALS_INT_CYCLE_* values by
associating cycle and lit values in a single entry defined by
tsl2591_persist_entry type, reducing code duplication and verbosity.

Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>
Co-developed-by: Matheus Feitosa <matheus.feitosa@usp.br>
Signed-off-by: Matheus Feitosa <matheus.feitosa@usp.br>
---
 drivers/iio/light/tsl2591.c | 104 +++++++++++++-----------------------
 1 file changed, 38 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index c5557867ea43..3fe34a48ec2b 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -170,6 +170,12 @@ struct tsl2591_chip {
 	bool events_enabled;
 };
 
+/* Persist cycle conversion table mapping register cycles to lit values */
+struct tsl2591_persist_entry {
+	u8 cycle;
+	u8 lit;
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

