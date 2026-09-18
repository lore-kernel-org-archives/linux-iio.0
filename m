Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325BC4EB85E
	for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 12:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734336; cv=none; b=VGHPvgys3LkIr/Ham4sgLOzBSuNtVRbnOGJjcvhLzcOad2+ysAE8ZQrMXQ7rPyINcdQtkuOKKDFUMBv1G0+A+XaZK/n2z1qK5gqeXoL1vmQyKCpn0O5LZDVN2otIuDcovwBvZP6RSNlQqN95+daqBDVUxdw4xcvVb76D8rzOees=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734336; c=relaxed/simple;
	bh=2f3W7ewvZD9vQ7bzg12iNZ75xkP2pWmWjFYvl7E8R3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PriUGa2NDXytjjUdmy4mORMbQMUj6omMtWd3yyo9j1OnmWXt5UumFRRnDGWHFw+iAoeJDvP1gKH9c8HX/hMi6I6I1t8dXFTQbwYJf5gQTuYNWBR1FHBOACo1yd8Una7WibNIDD1j4rE9WAKN1P2xtLlr+B1sOBNaKeTrK6MwMvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/79rJ6o; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/79rJ6o"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a5b6840edcso6235641fa.1
        for <linux-iio@vger.kernel.org>; Fri, 18 Sep 2026 05:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789734323; x=1790339123; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2j1Tv4agtRXuOvbEOgkc069No6p6dhHi73ng2NMw2ME=;
        b=B/79rJ6oBGFHcWWCezTYMlkT/VHthiSXZRuOqaFJthcYm+oSR69BiRiN4Y2eDAuFgP
         dhQ7Z0jBDQT3lI2FWVrnDVtS59URLfCfaO3Vw+w5LByqSiXJzMOTWgqLJ7XbwjRHINtD
         9zSBmemnyn/oMGd/+h8l5x3pQCaNYahISK4epnQC0BdMpcpIa5yD87nOGE1YsczhpI5f
         Ie/2mQ807F9sK5JyJB1csimPNb2S4lnN1jE/i9Vy3Pk7B3dN0vYUFVJ4ZIvRTafbEpC2
         Icn8PQUOMkJZVcCQyg+l6EKaULK8v0lpDb4SOvwnrBAuzE7BGxDTYlZDXHeTV6d66A5M
         2BbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789734323; x=1790339123;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2j1Tv4agtRXuOvbEOgkc069No6p6dhHi73ng2NMw2ME=;
        b=e5Oda+4D746gjHCm6JeOXFH38aoUaqVxMSKKPWl5ddEty3UmoMvv2ZIOpLPBpWopHk
         cetDbDvplq2Gs1lhX7zcvZYKLQ2R+jLYqMtz1N8ZhQ/2dfMIjxAxyWEDi5o2DYR3dIhH
         OhCRNvgJOVuhkvHmAfwEzeBOWNko0jYLY6HcKkdbVLjfeInzuvbx+tF+/tIHcI2jDETS
         69j1rL6liAcbFN3Kn0AidQkuIb4qbPLaotJ4HzCMZNWNpfArTT5IqnWaqSnpUsPiZlbc
         hZyfsjVGs6QbHP928LCfPzvWg/XiaXvVbS/Y9t3rPrbanXwgr5Kw5X+LpNcyM9A6iPwb
         UxEw==
X-Gm-Message-State: AFuF++ncOQG7caSgziYgYaur8VdeODa9ptkgYx34YgeNF1Mmu69kRfW9
	JsKAo6mS3EYT1MOqCmG07YhN6ZXAb8T4KKrz6+Xeacmb9+o3Bq1RYTbl
X-Gm-Gg: AYBFou17ypqQErs2nJtKSLaYTOGhTuVjLmeaLIR7UvoplXAGs5+BuHcqKbSVJ43e5Sf
	o6EbCgs8Qbn3sBSLFq+gJuHAyO+AM43H6yClN4/GURumw1wHulcSNC8OlvYQDMQxgy8fTjDpRtm
	6yyqUEOk2UG+3zb73VPNpQW5zPUZkuEiiZYOiSa5Do7z9BL12kIPXKpHUjmnYvVu5uwvOyOgwv5
	ZEG9rMXLS5T68E3rIhquFhttr2FyLDJg/9NFj3Argxa2OlyVqPlpQbLcUn9TmV79fvrxrl6GV0s
	PeArpqsfSyX9+S0nXN3I0psDyN5WH61VdCmGbA8L/h/pEN4/fSpY83etoSxB8ASlRM1o6MfUxic
	6kRV+bWq8cWxbtsdxQG2J3zQNnFyLadqvKeFG5aRvniSijG/3p4AemubaCtnljTceiOmIGAvOW5
	1TVqoZR1sD9QdHZbmWHexqw5SQ2jMj4SwHwYll9d2BXbZA7pUa2nKlp7eQPvduMuqYK5bY3Lwri
	lzeA6PsiHPMIi9AO9OhIOPZ1tfXE11Jalc71fZyxSY9/zTtf6DYpHvr2kfPqL3d5KtbJA==
X-Received: by 2002:a05:6512:1293:b0:5b8:9ee1:10fd with SMTP id 2adb3069b0e04-5b8c195b2a3mr741943e87.32.1789734322491;
        Fri, 18 Sep 2026 05:25:22 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b8c270ea53sm398549e87.12.2026.09.18.05.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 05:25:22 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>
Subject: [PATCH v7 03/10] iio: pressure: dps310: use get_unaligned_be24() for the 24-bit results
Date: Fri, 18 Sep 2026 15:25:10 +0300
Message-ID: <20260918122517.377565-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260918122517.377565-1-zoone.rupert@gmail.com>
References: <20260918122517.377565-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pressure and temperature results are big-endian 24-bit values. Build them
with get_unaligned_be24() instead of open-coded shifts.

The coefficients are packed into the bytes rather than byte-aligned, so
they stay as they are.

Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index bd7da4f12749..e7f173e08e01 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -19,6 +19,7 @@
 #include <linux/math64.h>
 #include <linux/module.h>
 #include <linux/regmap.h>
+#include <linux/unaligned.h>
 
 #include <linux/iio/iio.h>
 #include <linux/iio/sysfs.h>
@@ -468,7 +469,6 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	int rc;
 	int rate;
 	int timeout;
-	s32 raw;
 	u8 val[3];
 
 	if (mutex_lock_interruptible(&data->lock))
@@ -489,8 +489,7 @@ static int dps310_read_pres_raw(struct dps310_data *data)
 	if (rc < 0)
 		goto done;
 
-	raw = (val[0] << 16) | (val[1] << 8) | val[2];
-	data->pressure_raw = sign_extend32(raw, 23);
+	data->pressure_raw = sign_extend32(get_unaligned_be24(val), 23);
 
 done:
 	mutex_unlock(&data->lock);
@@ -502,14 +501,12 @@ static int dps310_read_temp_ready(struct dps310_data *data)
 {
 	int rc;
 	u8 val[3];
-	s32 raw;
 
 	rc = regmap_bulk_read(data->regmap, DPS310_TMP_BASE, val, sizeof(val));
 	if (rc < 0)
 		return rc;
 
-	raw = (val[0] << 16) | (val[1] << 8) | val[2];
-	data->temp_raw = sign_extend32(raw, 23);
+	data->temp_raw = sign_extend32(get_unaligned_be24(val), 23);
 
 	return 0;
 }
-- 
2.43.0

