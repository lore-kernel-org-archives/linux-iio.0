Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F87740EB90
	for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792230509; cv=pass; b=GmH5l4Z1TD/6hML8q/hx/oRNJChz6Xo8mMJJdl9NzKp2CxFoYN3vY/dsu3VrSOfWt/OjHBwLqyAcSbCPLKf3guSdk90ArsDuFaRSwvChh08s/Kc8wUZwCI+AvkOGa37Und6dnYo2If0OevSXcdPstJygJ5YTikEDGmDbXroTr74=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792230509; c=relaxed/simple;
	bh=cPOKI0YwXXROnWh8Xa+QzrvdXvUSGF1yvdjlmF4zwH4=;
	h=From:MIME-Version:Date:Message-ID:Subject:To:Cc:Content-Type; b=dNStvL2DWe5H8PkuUkMlOvDctSPARFLiyzsuqDkhgHxiusaFCPRuUjKrukyneodqIdWS0zXYXpiGrt+iCzWJymWJbQGyE55J3rTIBTktxAyF/4DDc5o5yI6Uh64ft0R0ffwM5i/zuo2efUDjp+9YakZwEqXy639c7pe4R6q7N+M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fk0ciDlf; arc=pass smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fk0ciDlf"
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-5e3e525cf4bso598398e0c.1
        for <linux-iio@vger.kernel.org>; Sat, 17 Oct 2026 02:48:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792230505; cv=none;
        d=google.com; s=arc-20260327;
        b=FXgQmpC86C2gFkBKta/zRp86oTkA/ZbMGXTbW+KT2g77SySXVanqKBA11IO3ZH2j4A
         cpS7w4BNX7sJaNVMfSAVPjGSSzSLLwGEHBn0zfWbulfXdDZM5t/Cc3XWZ2E/m8MM6O7s
         Os4F8s3fgeCU7bCgWmC6WxZIRs8no3Or+s05ogav9UJMtLQG3diBCcfb0bSEWMnkHzKe
         obJFNt6Ou+FcxDT327eg3RjAtBbg5VfyATIHyky1YObObwRVpJZJkXnAe08iNm4/qcST
         ekr3nPzElUXlogMH0B4vyyPoKigbhCC+cC2P/Sd4+pRODb0MR9oU7BNh9I74Qa5o2teL
         Gi7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:from:dkim-signature;
        bh=ga6N3yF0QQLdNTmXfoZ07LNIVQ63wj19E69wKGJBb5E=;
        fh=aJXdsdDZn8B1rsolGLn7Dx159R5hQ3kay9kgBwo/fdM=;
        b=F0aq721lZLO9/t9AW+wjdmhXbslVoFOXdIL31rQBVxegqdPNDIG5Qof3r7b3pFBY60
         rQ4pDtdtioipdjBmug22PLMQgUWuvyonnM/SkJtB86NL6/YOh4+sRohFBPuS+DY0pSBI
         3wO4p71ZowhbtMeo0WeJG0c4nAGTrACH1Text6+DWNeuBuwi8aaqOL5EqpL/mJcTvuig
         pvAq+XKtW7EED9Pn5FfdM2FxevSfFz2geExTlIDGXQ1Irw5XZ/MHPvgaZSzKlOC+FW9Z
         rsCdK/jxrt17V9J1m93Ws8SHwxsXZ2J+Q+KkRhmWAZGkW6KCKJphYgasNm/R29ovnafr
         HBWQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792230505; x=1792835305; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:from:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ga6N3yF0QQLdNTmXfoZ07LNIVQ63wj19E69wKGJBb5E=;
        b=fk0ciDlfpzpnsUmpV18rXCc1hWBS55UNHhOZyWwohcYSNTp4dOTYF1mDLVz0yMP8Wv
         fDIqrylvNFN/whjxCrneu6MKv8gHnxwiVm/3cLKPoDY7woWwoLniHAUUdAROEs1hhOqN
         TQDv9rcxd7iCbpbecRuPPcSPnegQPYisHCKPj7DbjwnmKSvi0JS67e0W0unoBk+rBJH9
         /cWrFfVog53SbO6H99geYK9U6C4Anr3CvJCnYJ3tZ1a54ss7AtH4TQNS0GcXKK/yTenP
         UVpbxlbgkTh71ddPkc3sZ5kwqeRiY/m4X/E+SG62qLyOy8DM2qsyqWKei2aYI+fBOq5V
         s9xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792230505; x=1792835305;
        h=content-type:cc:to:subject:message-id:date:mime-version:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=ga6N3yF0QQLdNTmXfoZ07LNIVQ63wj19E69wKGJBb5E=;
        b=0esuv0v9Xm8Y0nWNsFeGKt/0SpVzUfChOgSPRvMvlbFvsMnNEOzd+RmG241eE7lGD2
         3zhAjniuZOITJrN+iZZ1oyh525evYnwj3Mg0JKTL3eyvSFvYDGvcuNG96UG2nh9pCIiD
         H/07IqWlpqhbvKdZzA0WFQ7dtyzxmWVV028qgvX1rEnloYzHcBvGQUxrGW3pQmZbDoV7
         0lfBzaR9zxM0OCTEY8iIIx32iy1yHd1ttAdfHcWL248tNO6T8f3Y18KSbM/Qek3mxKQm
         JTy+3FLdupS4JiVSSkc48gDFC+vYMwBQaeDqSjYlZl6Y5N6er40pQVhbBUsCLUxeNpv/
         QDCA==
X-Forwarded-Encrypted: i=1; AKwUvByvxJ7goWntXvUKs+Th4XZDf7RpYkXfYUEXH+ES00IpdG3akntvgCPGm1/pY3H514LUxoBg4OLrxb4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKDqe2bG2IiV08kvvKYAiP6tpiZNHMIHoBRE7B9NjkKF7rg5eOD
	gu36XKcBa8lECU4g9IJKNXYeb8F7/yfOZOB7lKGB/tCtLTwYiY9l9s63jxlS5dqAPRDLX7wOvJS
	MHonnLN9K2yxL19WrWDsiJK+i0pu9ZHvqe0dr02o=
X-Gm-Gg: AYBFou23ZLN1WyMq79OEjoWjgU61yN7qMMG64MPhXDVznB82mNpJB/55bHnAZSdlzHP
	uf8M9AUeY6Aw3qijGuz0SjuVRlnzn2yJw1D1CVNrTPz4ie6SY3K5+0HcT1KQ0GFyRDDR8WWREFp
	XfaQKvUoIF/cS03JGOyoj/EzA8UKJ3N0cs7Tzh8nkZjxF4tabhM3yMx/37eEx2AxfwSaMIbJQC6
	nrYBxyQwbZXv1Ia6rl6azBi+hnhW7/7GRPwIJoVlsQtdfCqGhjhrAtuOI1iRubIPFcbycEyQsDL
	bMrqJlIGJaFowGeZ1cQzi7tnrABvcbdMInDcEyu4ijJra4TvA2jz5g==
X-Received: by 2002:a05:6102:38ca:b0:7cc:3246:3095 with SMTP id
 ada2fe7eead31-7cc36b3d24emr711904137.34.1792230505414; Sat, 17 Oct 2026
 02:48:25 -0700 (PDT)
Received: from 219304801992 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 04:48:25 -0500
Received: from 219304801992 named unknown by gmailapi.google.com with
 HTTPREST; Sat, 17 Oct 2026 04:48:25 -0500
From: Wenqiang Zhao <berringtoni36@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Sat, 17 Oct 2026 04:48:25 -0500
X-Gm-Features: AclHuK9FxGlMlcCjimXZeRb-7era7lK_0Sasn_TOvi8XgQL9o8qfQmHKnbm2rH0
Message-ID: <CAF2O-sN=PM1MUaWzv2r3zT0TozZZje+0eYPiJLQV_LHB3-Qj6g@mail.gmail.com>
Subject: [PATCH v2] iio: accel: adxl345: update period cache after successful write
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The ADXL345 event-period read path returns st->inact_time_ms. The setters
for inactivity, free-fall and the ODR-derived default currently update
this cache before writing TIME_INACT or TIME_FF. If the regmap write
fails, the sysfs write reports an error but a subsequent read returns
the requested period even though it was not programmed.

Update the cached period only after the corresponding regmap write
succeeds.

Fixes: 8a1536cc4a1c ("iio: accel: adxl345: add inactivity feature")
Fixes: f6f22950d925 ("iio: accel: adxl345: extend inactivity time for
less than 1s")
Assisted-by: LLM
Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
---
v2:
- Keep Fixes: tags on a single line (Nuno)
- Use a Latin-script name in From: and Signed-off-by: (Nuno)
- Drop the long validation notes; build-tested only, not tested on hardware

The missing serialization between concurrent sysfs callers that Nuno
pointed out is a separate issue and will be addressed in a follow-up
patch.

 drivers/iio/accel/adxl345_core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 6c9080d..cd58304 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -391,30 +391,47 @@ static int adxl345_set_default_time(struct
adxl345_state *st)
 	odr = FIELD_GET(ADXL345_BW_RATE_MSK, regval);
 	val = clamp(max_boundary - adxl345_odr_tbl[odr][0],
 		    min_boundary, max_boundary);
-	st->inact_time_ms = MILLI * val;

 	/* Inactivity time in s */
-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	if (ret)
+		return ret;
+
+	st->inact_time_ms = MILLI * val;
+
+	return 0;
 }

 static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_int)
 {
+	int ret;
+
+	ret = regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
+	if (ret)
+		return ret;
+
 	st->inact_time_ms = MILLI * val_int;

-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
+	return 0;
 }

 static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fract)
 {
+	int ret;
+
 	/*
 	 * Datasheet max. value is 255 * 5000 us = 1.275000 seconds.
 	 *
 	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
 	 */
+	ret = regmap_write(st->regmap, ADXL345_REG_TIME_FF,
+			   DIV_ROUND_CLOSEST(val_fract, 5));
+	if (ret)
+		return ret;
+
 	st->inact_time_ms = DIV_ROUND_UP(val_fract, MILLI);

-	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
-			    DIV_ROUND_CLOSEST(val_fract, 5));
+	return 0;
 }

 /**

base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
