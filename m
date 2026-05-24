Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A3562744F
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 02:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779588292; cv=none; b=cvG7ZpH/B3fyo3iMT0AS1WGOEVn99U8QW7OgCM6zfAz89GUuomzcTUQRkNmiQa1z4vY3IYRCuKIY33/ED8bjz2SyAEAux7GI93rCRzRKgY4IH6/A6Tpp/CWKdNZ/TJ7WaEqXsdCnJ0lVbpce0YE9Py4M2x0FVp6Ssy1jkm6hQD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779588292; c=relaxed/simple;
	bh=iP896goZa4JSvSMaGWKtW9GY1PSXDeqHR1q2E1vIz3o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ec0oyGqX1Z6pCyIN84IISVy4qPbKJYu6tK8ZmhtaR0V8PMFUyEeaQ0dQWbrF6LgwGvYOUTX7LZTwpiamhzgYSxQTOQLKbnRDHbUZmV/DskecvWqVudceabgGxNjNoZjTa61T/x7ZDADS54OE22zmEkGBKtMCOhk0VlwtNdy28n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GaQyChWD; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GaQyChWD"
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-7c23248f3a3so91906377b3.1
        for <linux-iio@vger.kernel.org>; Sat, 23 May 2026 19:04:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779588290; x=1780193090; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1mG58R360m/1P/UQMKqIOxr15zPVVMiOX/bVxawbO54=;
        b=GaQyChWDId8B4Q6CYLM/fAC5cgIeCrqUPBLs4z0Jdf9oVXsAeb8edPYWP3lBPWXn5G
         yNPdGE5ydiU/2N8uGpaDID1QX3bSn3am8vWDSLxR9qnqv0EQdeHh2MbIzNoUFk54QtIh
         okQ2EZAebYlm7AoLszZ6Ip5tMCneTQlHImA0Wkw6R6WvxvFEoautfDz2W4dxzzm2PPtB
         kJFeDImmKbwm+Gn7LPAGZdsvzwRXVkqPlFwx4Zt8JTpJ70dIExyCdA2rxq5IkKtYJ6ug
         NyR27vxeBuFZtGgbYKwxjmfJF9U0iduqmc+J73/6AR3VI8t97yHaCcUafcpfD5Ihfapz
         qAeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779588290; x=1780193090;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mG58R360m/1P/UQMKqIOxr15zPVVMiOX/bVxawbO54=;
        b=XrpfQ41ni+z33e3wI/DblIW6815RATpeXgyJs+ISci1Gke5Qy19mx/OG6nFVfubIBM
         6On/3IHgDKhBzYCM1QI1PhZ2f6Vj56IkrH3nzduy4Mo209tBYgLjVJu64GWE9Xg7ons5
         uJpVz+2ud5Ni/AfHeRXt6qmj7LVtVnX3HqHs0p6UjagnpqZTHD1xgxmCRJAq8bC2YiQN
         4G2wJEkctBMGMqvZyLEoiUDe2cMk1bSnXbjV7eQ1wR/CIVPdxG6rHXDibMC0R/83kR+W
         kMwjwPNMgpvIunV0lVFBimjxw/2J/ZVfOzZSmgoHERr2lMw6i6d3r7rAyALzggWF60gW
         OgvQ==
X-Forwarded-Encrypted: i=1; AFNElJ/htgixhsyJYrCOqeIBprW04WzGeqdCas+4ySrYuwyG7g+wNern+oYNCPFfE+uSprl8UnrF8k9Bml0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzrFOdajJj/ZBGWgVg/Sct9fwe/eBzuvKd5SIRWXrbPOW8nZva/
	kpKsxLEuFy0U+Bd+OXoV2M4FisDcOeCTVGpk7WZ3sLsLo6rZmto2PxQZY4hfo7BO1yQ=
X-Gm-Gg: Acq92OF3RZSbBDuVc3vRb2eUGEF2YPht2k+9d8iJSFv37A8/eb1s0fiWd8JSTTLfs6e
	uwGvXLdyR7/RVaiHDs/lG7yDj7dYFEWMWj144i76osb97+nY9s79SAZ40zC7jyKD9ciKMEywFix
	vk01XcTzvWXC3v4kqlHsgMkF3pT6Q7XMsFkZpRu+j43bQfb/0wjilLF5eHh5OuKqtlsla1P9ZMm
	rzgnTMvJxpfvg2Odw5qPFbu4f5kOT2Y0FH+0xdkALITgRkbaoexTS4aI1JGXAJ+mZ94R5HnlN2Y
	WiptGRRP9rknkdlGwlpL5AndOx1SEsgQSsuCCCWuVnHgg5PjsxNJK+xHyIxq7PFIimouBev+cbt
	4oa+4psT+ZCKmjBS+nc2no9lD0SikUKzFfi3zdAA03u3pwM/8eyh/NaWbWG5VkPgSxNYBL01xOu
	3ThA0JtCP6s2xGs/kEzl7psF0z3wU=
X-Received: by 2002:a05:690c:45c6:b0:7bd:a4dc:c26d with SMTP id 00721157ae682-7d338393a2fmr115700167b3.41.1779588290158;
        Sat, 23 May 2026 19:04:50 -0700 (PDT)
Received: from i-use-arch-btw ([209.37.158.229])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7d38c335164sm28159187b3.33.2026.05.23.19.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 19:04:49 -0700 (PDT)
From: Maxwell Doose <m32285159@gmail.com>
To: jic23@kernel.org
Cc: Maxwell Doose <m32285159@gmail.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org (open list:IIO SUBSYSTEM AND DRIVERS),
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] iio: chemical: scd30: Cleanup initializations in scd30_float_to_fp()
Date: Sat, 23 May 2026 21:03:08 -0500
Message-ID: <20260524020309.18618-1-m32285159@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Include linux/bitfield.h for FIELD_GET().

Create new macros for bit manipulation in combination with manual bit
manipulation being replaced with FIELD_GET().

The current variable declaration and initializations are barely readable
and use comma separations across multiple lines. Refactor the
initializations so that mantissa and exp have separate declarations and
sign gets initialized later.

Signed-off-by: Maxwell Doose <m32285159@gmail.com>
---
v2:
 - Added new floating point macro constants per Jonathan's suggestion.
 - Included linux/bitfield.h to use FIELD_GET() since Jonathan also
   recommended its use.

 drivers/iio/chemical/scd30_core.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 8dbba9a7c426..db5cc295aeab 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
+
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
@@ -43,6 +45,11 @@
 #define SCD30_TEMP_OFFSET_MAX 655360
 #define SCD30_EXTRA_TIMEOUT_PER_S 250
 
+/* Floating point arithmetic macros */
+#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
+#define SCD30_FLOAT_EXP_MSK GENMASK(30, 23)
+#define SCD30_FLOAT_SIGN_MSK BIT(31)
+
 enum {
 	SCD30_CONC,
 	SCD30_TEMP,
@@ -89,10 +96,15 @@ static int scd30_reset(struct scd30_state *state)
 /* simplified float to fixed point conversion with a scaling factor of 0.01 */
 static int scd30_float_to_fp(int float32)
 {
-	int fraction, shift,
-	    mantissa = float32 & GENMASK(22, 0),
-	    sign = (float32 & BIT(31)) ? -1 : 1,
-	    exp = (float32 & ~BIT(31)) >> 23;
+	int fraction, shift, sign;
+	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
+	int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
+
+	/* Determine sign of received float based on IEEE 754 standard */
+	if (float32 & SCD30_FLOAT_SIGN_MSK)
+		sign = -1;
+	else
+		sign = 1;
 
 	/* special case 0 */
 	if (!exp && !mantissa)
-- 
2.54.0

