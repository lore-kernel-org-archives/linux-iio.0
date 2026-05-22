Received: from mail-ua1-f44.google.com (mail-ua1-f44.google.com [209.85.222.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C231F145FE0
	for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 18:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779474069; cv=none; b=Ti+aX4gC4dCF4j9vcp5SkNiaqmySImNyWoyHps43L4xmWB3iONhNIrwVXyNxP/xkW6fktMyGSprkdSSYbraNJeQtMThW55azDWFnpViBaH/Zdf4//tkRDfTU9lT5o3rwRc7HUGWqPAcaQJoMpZ7VhdpJSKyXjb8m4wc1ZAQmu+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779474069; c=relaxed/simple;
	bh=Mb/PVaaEnXa9ea8A4ZtYFhspDn9xR0tD4MLNdhCQIUs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ikWGyiwuH2xPQi2pwGR/qrhT4Xp+4fPmYT987maQ2AFkl+2APPhvhkZgjLDQ15lpN9UDPddE+E+tn2N+IP3TwLJwNTo8rNmlHcfopMCwdvYJHQ24GNIjX2OWBAMNsPYASm7/adTX1rcgC8zWy+CWK6vB7KIexRxuAxFBEe3Kxa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br; spf=pass smtp.mailfrom=usp.br; dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b=gyQFRgg/; arc=none smtp.client-ip=209.85.222.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=usp.br
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=usp.br
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=usp.br header.i=@usp.br header.b="gyQFRgg/"
Received: by mail-ua1-f44.google.com with SMTP id a1e0cc1a2514c-95d0476490fso2321429241.1
        for <linux-iio@vger.kernel.org>; Fri, 22 May 2026 11:21:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp.br; s=usp-google; t=1779474064; x=1780078864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AC2h6IXlNwuG8lxfp8Pf7QCdvyg+hXs1agCdA0oxeos=;
        b=gyQFRgg/gXHvfYmFOOCnMs5fugS9RE8skB+/XmCScKcLmoxiGk4kLaRmLpUBbx+cQO
         klACgZRyavXaV+JOisYSBEwBn5a1GHnHZNebrmMqwXKpYuAS3JmLqCAtKMJXeGZBH94y
         SNbmEmjrDbf2lodXXM9TB6Ws/gOrKtCZTAyMbD/VIA08KT6vdKSqKIWsqlGpZexY+Ay7
         01kkYp6ULo18Go/1XkSyYk6JeBOhP93bv+swQ7+vuzC2CNDnJ8DM3MDfOHGCt4M/fjOA
         m5qIGxPx7VB1yNipI6dTdQOgybUzXJyZNdNd1bfcOhka/lRXrxc9CPT1+P9B1GeQhvEW
         GWeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779474064; x=1780078864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AC2h6IXlNwuG8lxfp8Pf7QCdvyg+hXs1agCdA0oxeos=;
        b=AA1fS8YX1yOYfi2AQybylImZ+4jwpTEcyiU+t5NidNwtjK5xLMwbVb7yIA1wvjqjY3
         sLB9eviXVV27m2FKIWS74ZTzNDFBHtCNu/OjZ1pVjaKupJoRDfn/FE2XJg8CLho5kIP8
         9vPDFEi97WQPi72XgxclAOHjARbGkAGJfKaUqFCsOSMpkJn264IeOVnk1SGSo0RwjdlW
         lx6rChxupmjDJHMwOcl2RA6pbl8xX44fDEwhi5goCbo0lQ34LsTxyDY0VIUXqhT9WBXB
         QbksDLDXf9Ih4UwdN/Eb0TJCQpO7/4SkdZqFso/0/7a0bo9/BfaSy52sIHsreFxVtrDw
         vF/g==
X-Forwarded-Encrypted: i=1; AFNElJ89d1bEDdR1ofjr1+G0GSW8jY566JKh2+6J6zM4fIfPuawQS3dZ3rC5Ap3REVKWNPzepVtZmsbUFwA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyGyM2lZKYYvoionNmQRE7DN1XMGrKBAtHYJtoBaSt372FptvqT
	EmcFm2ozfSS3FA7j2GjAzm0FuhhmC6l6Rt53zoBTq2sH2rET4CO9sNHLPuH1XHhE9Gg=
X-Gm-Gg: Acq92OFOPORNbWCxKLpayU2DVlzXJRkRwuZNZenl17lO7HZHT3YhNAk9IYyPewmp6vs
	x6nr6U4UiBk+LCVyqgjynAIT0/1PHPJCM7DZRw8bNNzj8fU8HcvFwT2LUptymsobxqdSrl8tTlr
	kb/RRcnEIMHEqVuznLaw3ov2pExRFoXBjB64+YS5GpRPC7NGXQmHnjPf6F4uHTVKB2q0dB9EN6Z
	TyZxsFjDZ+m9VbK8Sqi5FNkwImy0/fe1X8EwLTfnRShempWR8PaddB3TO8cV+wyMqFctnMD/zsD
	kRf5+3onvEcRTvZv5/IejHee+z9LmWk1jWf1b7UMk8ODMfl4S+Gtqy2aZmV4elwtBSSks0GPiA1
	Un3YOJdZDEqqrrr7y9sfBVmZcaqP1WQ7R/gEUe+47jrBfi34Esk0RPXaxM02zkniYRqtjJ2NIva
	tcX6KJAojj/cu8g2VNFSRXyNe8uwrSvz5/hQptOno8n0trbUz/oFvXja2hQiY5JeKHGkdt1m8BK
	wz8MQD1Yw==
X-Received: by 2002:a05:6102:5114:b0:631:81d6:e15c with SMTP id ada2fe7eead31-67c7e1217bamr2769831137.4.1779474064460;
        Fri, 22 May 2026 11:21:04 -0700 (PDT)
Received: from outlook.com ([179.228.233.6])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-67fda9003a8sm2218783137.6.2026.05.22.11.21.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2026 11:21:04 -0700 (PDT)
From: matheus.feitosa@usp.br
To: jic23@kernel.org,
	dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org
Cc: matheus.feitosa@usp.br,
	LucasRabaquim <lucas.rabaquim@usp.br>,
	linux-iio@vger.kernel.org
Subject: [PATCH v3] iio: light: tsl2591: simplify tsl2591_persist functions via lookup table
Date: Fri, 22 May 2026 15:12:57 -0300
Message-ID: <20260522182058.199762-1-matheus.feitosa@usp.br>
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
Co-developed-by: LucasRabaquim <lucas.rabaquim@usp.br>
Signed-off-by: LucasRabaquim <lucas.rabaquim@usp.br>
---
Changes in V3:
 - Remove struct persist_entry and replace the struct
   list with an array of u8 values
 - Remove the loop from tsl2591_persist_cycle_to_lit()
   as suggested by Andy Shevchenko
 - Align tsl2591_persist_lit_to_cycle() with
   tsl2591_als_time_to_fval()
 - Keep the loop in tsl2591_persist_lit_to_cycle()
   as suggested during discussion by David Lechner
---
 drivers/iio/light/tsl2591.c | 95 +++++++++++--------------------------
 1 file changed, 29 insertions(+), 66 deletions(-)

diff --git a/drivers/iio/light/tsl2591.c b/drivers/iio/light/tsl2591.c
index 08476f193a44..0ba2e86a11fc 100644
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
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tsl2591_persist_table); i++) {
+		if (als_persist == tsl2591_persist_table[i])
+			return i;
 	}
+
+	return -EINVAL;
 }
 
 static int tsl2591_compatible_int_time(struct tsl2591_chip *chip,
-- 
2.43.0

