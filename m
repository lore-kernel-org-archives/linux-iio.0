Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A637A4FD279
	for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 18:31:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015504; cv=none; b=X5eRxqoYL78rFkm6WSsPX6lvME8Rve2uK64GZ6JjegXYu/i2EULXqAdOY6OcS03GyeADaV2Q5VzFVcI623ARSdq5VTgjKiNL1xqUUiOaxtKK5ACr6nAadvRfQJqYTkEDi+HCvZ6BgyOfDHuYxv3s6i6tQmO4jXEfU6mxV/G7wc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015504; c=relaxed/simple;
	bh=2f3W7ewvZD9vQ7bzg12iNZ75xkP2pWmWjFYvl7E8R3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mSwOjq6e1wW3XsLs02pGX4QjXnEWRUiE4f58+RMlfhdahK2CPojJsRBj+/szmTWJnSZTlMXhJyCrwma5butRG63S9Uo2YuhNrKayGHyxCewkSbooqdTVSIgpvL0oAvUX0NxezUQ6srH+0z62z/KyiTbc/w2Xblj8cct56LQs58k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OSakWhV2; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OSakWhV2"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a49a10ee5aso25950481fa.3
        for <linux-iio@vger.kernel.org>; Mon, 21 Sep 2026 11:31:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015501; x=1790620301; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2j1Tv4agtRXuOvbEOgkc069No6p6dhHi73ng2NMw2ME=;
        b=OSakWhV2yLjW3FW1HXrPiz1nWPCmH7q1wgcyraM8zegSxdjbeyr1qIXU4WO5RMcoN5
         gKaqzU+sdezgoQl1Yqd53vJKwozUfP1Zxef5w/LZVzJD3YdP40GU53pEdITdfoSwhTbn
         heMbWN+aW62XX/6nU8reP8b4FVQlWmg+Cq998cAoz7ShqtKA/OwVgxAgOIZcVPr/TypO
         gxtMSLktoHWKcz8b4/IM3cstulCf1GsbWEqStiLxCb470ZlUkMu4jGXMpNQq8PD/o9C1
         bMABk1qzGAig52PTFZspZCzczgbi80L8Akc63032I2MoTikgrfOUAf61ULG1vHoz91Wy
         tsdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015501; x=1790620301;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2j1Tv4agtRXuOvbEOgkc069No6p6dhHi73ng2NMw2ME=;
        b=I8nYYWb7/b07XbmcLT9+99p0Lbg0cI0u9gDQpzsfp44bMn8kRv2hfzyr90hJFDTbtk
         gmckLo2zF05MSiLPw6Pw2/gSl5O87vwv5SoxWRd2tUxRGWIT2Hdz1tkJ3J/Pq19+I87P
         +5K0TQcb1HADgqWsT/w29QJgup6nbH4I0z40j8nKgOguVXL5dRxh7T4G4uetdWNeJCg5
         cJeKBJch1gPZZbuDDrKPQZ/yxODbLVYIKZRT3FExWYASf8CDIo+c5H/dU5RijpH60UsZ
         F7L8e9c3X0lvdMYIQVbPOiJsaX1XrDxDK8TtD0K0cmtqbuFrrBpPxCECZ+neN1XyqOXU
         cPBw==
X-Gm-Message-State: AFuF++nJzBujp1Xxhbw9wGr9/xfL7QYmZvCoQqHqPYk4c2FVTDDw1AXU
	m/co53v9U74aR3ktMGQuKnw5GIA1wv3qg0ABPnSzTrVASVrIK/1EdyUG
X-Gm-Gg: AYBFou0aZtAlwKeIDDdP3fDTymlHkGgdPNmX49WYrvr0+4Tr627AzsQ82v89F2WIQw5
	uWCrJiNzNbpKXStoOdMnux5IVi9TrBxbYzbWNeck6u5FvHxiThzCKZQ2199lf5k3VdLx97iHf7r
	dQEvXR6cTXa9keTalb1AuyHiFTgjXBCmJ/p5ZHvfesW9ge/ulpNSxX6Xd0rx63ecWBfcckSMrzc
	tEoltddZi4Ap+4sCr8bvN++reN5gFPT0yisMPT4WRBsXzSZTXZSiu/2DR6pri+sHjZ9KzlN2tku
	sUKKodVT5Lp3i9q/cSq++TT/cL2eT/vAZw//g0nyCYX2Y7tnmR3nW4p7XLImieJC0v8bYhwbgJ2
	3oshy7LfuPmq9s1jHJwboNWZRQ3pgL7ZbYr1CfpY4NwxnhavfW3I7jiuagLv0aknM8eX2grjKaA
	2+st6kLS8iojQ0fufOx6odH9j6QnoqDF3T8lcl2PAM+YzZ+Bgwrdnt+lVT6aNTBGGKQtDH9rASz
	WVUn2SR2VviYY4ZH/GWppciytylaEzKItQp5OxAaAmRlQBr1k+/9Yrh9B2CYUtXhTfaiA==
X-Received: by 2002:a05:651c:1508:b0:3a6:74a:53cf with SMTP id 38308e7fff4ca-3a6074a5560mr19625551fa.28.1790015500539;
        Mon, 21 Sep 2026 11:31:40 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:39 -0700 (PDT)
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
Subject: [PATCH v8 03/10] iio: pressure: dps310: use get_unaligned_be24() for the 24-bit results
Date: Mon, 21 Sep 2026 21:31:25 +0300
Message-ID: <20260921183132.233136-4-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
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

