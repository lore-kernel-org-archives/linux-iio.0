Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A55B82E738B
	for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 18:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779994762; cv=none; b=Q5ryA9LVbn4K1EXjBYraW6gTcgwHOeOgO2AzaVWIERQYIueqUOQr9RKykcBHXqMbTlPSHYGm28+9jviHnSOm589mm/1Y+XXzmrvqeXooOlczBe5I4i1evRt2cDGZsM6gvjoMmFz9F4rkwhGqRO5zk/KyNjiAJnAcIust3jPRVPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779994762; c=relaxed/simple;
	bh=kf/bjLeVijnpUICiVOY8lCyjwQTv01W1/HuIKmZGlFs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hVlZ7Ly6HkYEFJN6UNbBQCKSHL34IWHogqoQb+4H5H9RuMJcNnlDblD81PGLri3rgFPrcrxNtcGLmHIvTkffOruQUcoB5ACN7fLZs+vEOXXNL24ZVjVXjDbt3ccKjwf7041tdBuLrJGk3FpXRruVxTq2IgxDRzJ54vJ+K/B/PQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=P6gayCLl; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="P6gayCLl"
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-50e63771d91so120540251cf.0
        for <linux-iio@vger.kernel.org>; Thu, 28 May 2026 11:59:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779994759; x=1780599559; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NGz6gS5E4ggFznyOVCY+cXd+CEAbqaKW1bSa+gAqlTs=;
        b=P6gayCLliCfTo6WqxNXMnIyBLlM62GjKDI2npZB8wAlZXuyqKm0/1AZdZjtn29EQeX
         LAnyt8VgNeKOzK6YS+ol/E7CYN62SvaXmZ4hI7StsltpErm+VSQKij4qj/yfNlfDMaGA
         RpbuK1zrUzj4P76BvqK9qI7n5868VSK5fNbExRkMXDjYtlbN1w3+gepizXmT8uymPMZ1
         TXbkC5o400aMWy5at88JKIjwv5kc8r6Ga2qqs/mPOC9fPLd3E/ismcBnQ5vhT8D3e4xs
         fqeoeRw+E+R6StoWiFLk7oHvZIh8vOFZgr5H0LEekTUN8QuHo+TOBuBckFEjY3xtbOyn
         UINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779994759; x=1780599559;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NGz6gS5E4ggFznyOVCY+cXd+CEAbqaKW1bSa+gAqlTs=;
        b=jhTLM0iLjrgV+ZkD5sD44Vg7vFrdxMF3xxpvfCfVuS+/sm6y1VS+VYN8qjHQeux+0I
         LJ0fq78JKNbpN17Wep+3g61AP6bx3spO6GXK5drSWc3Wl7CEkPpgqihDr1ikMYe/uMpk
         YHBmr/OWX1ouoJ1oESc9bOI0TlvlfUO6SNzkJLrjK3R0a63z80DkCyk/Fg0++Tsm1KiI
         TAtkR83AYHLYepNHL+WoUeAckA16Uzde3hS2EmivLpBJHIoxLYN9qTJXd2JJFyDugQcI
         j7xthiD3lISS1EjsimPKXrEZBPwXWRV8ty7h02+/BJ1WgXFjEJHTDPuDxw05/nED00x5
         uLlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+pEUX8UMzVpeO+bNO83l8ENTDnFaNj1lIfdEH5+agEb/9Leer96+yLNDxjGn58KAv0tkUBs2R9Xds=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8bNnnfJxQkI9+E5dsVxs6Da1e1H9Cm/ubgDLBCxWOivlwfZ50
	3ZSASAtWWMGXxcQZ2XqOpgpalqLLxaJTvxvyChYvp/TOCfNqmVhRh5m66k84sJ6dOgg=
X-Gm-Gg: Acq92OFe9NnB06UdPv0jZaxtXiYT0FxGwkWjSWVU1bU7yWvY2t5nCy026RMHjWYeP+h
	t5L+ZUX+477RofdPvp/c4tbgeRZITtb9C3JFOjfLs8sx5dRPDaBUK39dZ38bfAdf/zJEyWU8uJu
	lYBNp6khJUQm0UFp4kdHabXTyZcbWLCo5KB7mdq6nTWAhBxkrn1EP8oTPr8zHtNLLurfzL3Zih8
	b0eGQ3iIa5eS0ilLRk5yPUL4VDDrseQq/a6/UVWC5/bAiF1Z2WiNaevxkVDP4TqQG6LYZmlaeBD
	8yQKRXL3QT7GsU/AQFQeEt0hUfKFMd9P2WZ9/nCTp2rv51HVg6UQOnvcHjKmlY+wVwWLfLk9Y7Q
	VJkvREyuprpd54BAaDVuwZUpQYsz3LC2ys3Ac5v0w/b5kL/xMRKEFDLLnWn9SAn3rv0XpazjDLu
	Smc41GdrkkO7UyAQZ97eMxlOq1oNW6LGdyRt76cywF3K+DzwTeYF7/qBG3gARpm1z89R3k78HTx
	s/3Pq6IKEesL9mQW7X2
X-Received: by 2002:a05:622a:1aa3:b0:516:dbf6:f8ea with SMTP id d75a77b69052e-5172cb69159mr1527411cf.19.1779994758527;
        Thu, 28 May 2026 11:59:18 -0700 (PDT)
Received: from outlook.com ([179.228.233.6])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8cc812e657csm231151726d6.24.2026.05.28.11.59.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2026 11:59:18 -0700 (PDT)
From: matheus.feitosa@usp.br
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: matheus.feitosa@usp.br,
	Lucas Rabaquim <lucas.rabaquim@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v4] light: tsl2591: simplify tsl2591_persist functions via lookup table
Date: Thu, 28 May 2026 15:55:12 -0300
Message-ID: <20260528185912.24774-1-matheus.feitosa@usp.br>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Matheus Silveira <matheus.feitosa@usp.br>

Replace switch statements with an indexed lookup table for
persist cycle conversions.

Both functions contain redundant switch statements. This
reduces code duplication and makes future updates to
TSL2591_PRST_ALS_INT_CYCLE_* definitions easier to maintain
by keeping the mapping in a single place.

Signed-off-by: Matheus Silveira <matheus.feitosa@usp.br>
Co-developed-by: Lucas Rabaquim <lucas.rabaquim@usp.br>
Signed-off-by: Lucas Rabaquim <lucas.rabaquim@usp.br>
---
Changes in v3:
 - Remove struct persist_entry and replace the struct
   list with an array of u8 values
 - Remove the loop from tsl2591_persist_cycle_to_lit()
   as suggested by Andy Shevchenko
 - Align tsl2591_persist_lit_to_cycle() with
   tsl2591_als_time_to_fval()
 - Keep the loop in tsl2591_persist_lit_to_cycle()
   as suggested during discussion by David Lechner

Changes in v4:
 - Fix Lucas's name in tags
 - Start lookup loop from TSL2591_PRST_ALS_INT_CYCLE_ANY
   as suggested by Marcelo Schmitt and Jonathan Cameron
---
 drivers/iio/light/tsl2591.c | 95 +++++++++++--------------------------
 1 file changed, 29 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 08476f193a44..2b91ecb86ade 100644
--- a/drivers/iio/light/tsl2591.c
+++ b/drivers/iio/light/tsl2591.c
@@ -192,6 +192,24 @@ static const int tsl2591_calibscale_available[] = {
 	1, 25, 428, 9876,
 };
 
+static const u8 tsl2591_persist_table[] = {
+	[TSL2591_PRST_ALS_INT_CYCLE_ANY] = 1,
+	[TSL2591_PRST_ALS_INT_CYCLE_2]   = 2,
+	[TSL2591_PRST_ALS_INT_CYCLE_3]   = 3,
+	[TSL2591_PRST_ALS_INT_CYCLE_5]   = 5,
+	[TSL2591_PRST_ALS_INT_CYCLE_10]  = 10,
+	[TSL2591_PRST_ALS_INT_CYCLE_15]  = 15,
+	[TSL2591_PRST_ALS_INT_CYCLE_20]  = 20,
+	[TSL2591_PRST_ALS_INT_CYCLE_25]  = 25,
+	[TSL2591_PRST_ALS_INT_CYCLE_30]  = 30,
+	[TSL2591_PRST_ALS_INT_CYCLE_35]  = 35,
+	[TSL2591_PRST_ALS_INT_CYCLE_40]  = 40,
+	[TSL2591_PRST_ALS_INT_CYCLE_45]  = 45,
+	[TSL2591_PRST_ALS_INT_CYCLE_50]  = 50,
+	[TSL2591_PRST_ALS_INT_CYCLE_55]  = 55,
+	[TSL2591_PRST_ALS_INT_CYCLE_60]  = 60,
+};
+
 static int tsl2591_set_als_lower_threshold(struct tsl2591_chip *chip,
 					   u16 als_lower_threshold);
 static int tsl2591_set_als_upper_threshold(struct tsl2591_chip *chip,
@@ -231,78 +249,23 @@ static int tsl2591_multiplier_to_gain(const u32 multiplier)
 
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
+	if (als_persist >= ARRAY_SIZE(tsl2591_persist_table) ||
+	    !tsl2591_persist_table[als_persist])
 		return -EINVAL;
-	}
+
+	return tsl2591_persist_table[als_persist];
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
+	for (unsigned int i = TSL2591_PRST_ALS_INT_CYCLE_ANY;
+		i < ARRAY_SIZE(tsl2591_persist_table);
+		i++) {
+		if (als_persist == tsl2591_persist_table[i])
+			return i;
 	}
+
+	return -EINVAL;
 }
 
 static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
-- 
2.43.0

