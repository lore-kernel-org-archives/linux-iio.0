Received: from mail-ua1-f48.google.com (mail-ua1-f48.google.com [209.85.222.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12614304BB2
	for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.222.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791713894; cv=pass; b=NlUbO6kapf+E8/yPMHwoMDt7be0pA2flweRF89yMsQMrMk3frbm6uZWU8dC8D5/kZWv9HOAjm8lg7PI2JmhtT0D3fMlj5TV1zSwjhbHpSnnflfi+hLLsoAJ2LaquuqvFkG2w6fppplYdvdmkNZxNMsBESyuO2ZNVTkMA9G7LxBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791713894; c=relaxed/simple;
	bh=8QVnP8e031bGfGfvNZT9OId6tEk/ip7/dkUDXa6w1aw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=C7NM5np6cx6TMoRyAwfySFFghnGzro7MT4zlZ1aws8FLds6lh4i5209GGIF7snWgaQsgbPJbrwCxvwpmno/XLMMNYvQ5Jy0p7oykFIkKCA5babr1NnNmRWlsIi3OPfzOfYgxzrQiDWHr7UnklDO4aBBX670wARqzOR/BU7WA+l4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DtsWza2L; arc=pass smtp.client-ip=209.85.222.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DtsWza2L"
Received: by mail-ua1-f48.google.com with SMTP id a1e0cc1a2514c-988f270d308so696162241.2
        for <linux-iio@vger.kernel.org>; Sun, 11 Oct 2026 03:18:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1791713892; cv=none;
        d=google.com; s=arc-20260327;
        b=Yy9vJ3gEHgRusw1UGpmQgddmFK0CR+a0rpcFhHO+6s3DSfRcJo560V1HPGaQLLlD6c
         K4lr0CcioGtsguBoIhmyYKw+dhWa78pabx/pRL3M1il2w05bRJCd9n5yHGJBoqhLwGDL
         iGKLDMQ1OlX+NBeELNCVnnYC8yHpmF8/lXPKJ2Wm7L85aOBCbE/iJwQS8jeS22RcTFTH
         r9UEVyJh5KZjiQDVlJEq8+BM+cHB/KwjwJBxs5bgDkO6zgwnFGlil3kzci8BxbTkOsPR
         MIPd+rqfkcN1nNNmLZDVGG+9jHTVa6aZHKe2v3C+FefVHKY/35Q5xZ/vIO+a21W/iCWL
         +v9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :mime-version:dkim-signature;
        bh=7VFFpRhUZGG173cxRqsJ8XWcj2i+48AarU4CckLgkP0=;
        fh=HiPopKYNaa8FtUhU3UgsoQP41/0nRRn7Vhd5HgDrxJg=;
        b=cprFEUmRcKcfhK6uhaVF8Jt+Pmv4GTtDm4Ir4xo9cGD1K1zk99/eRjP2QryJWov6pv
         ZlBB3ZvD9OQjr/3s8b25ZMi6cvatjHV2FjgeYLSzWy5SrW4diGs9tnSBlpISBVR22wF2
         pPYfRv6/iQG6wkG4/v2grtncCQo+wpDHz+BrbO33Q6r9Z8ohEC3Ga5gAI/gV6ooM7XZJ
         EKI1ItaHLCEQSmOhNFU2CBf8PhKeZSGrVqcJ6c9sgo0PX0Dmc3FPEdkawrLmh/CPwb6E
         bNEwcOpWlVRUWu6dJO4QJgZQi1f3EYTWUjl5qlF36LF1F9F040Wshj0vd6nctfzuQW6j
         X/Ow==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791713892; x=1792318692; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7VFFpRhUZGG173cxRqsJ8XWcj2i+48AarU4CckLgkP0=;
        b=DtsWza2LnSyfn+n2nJDPXdfmm+lGpgMOXksW4jiXdP5HJbYfgShOUTw0LV2aTkaElj
         tngBZz7Y8vnMxRORnUud9QZZjpuwYDeoAXtGkOVVDtL7Zu3MSbqHGaVCWIR2mtqduBw7
         5YIbc8191Ebo/TItmPdGvdtoBxd06lDIzsk6bTGeDrFtIibHyliwDX7nDkgZAvkPnjM5
         h7pzYuBbq4a8u/GiD6pRyYmIqIbWxUkl2wh6J4UqGK5BlI2qeIzHkF+rNx46vKz4anQ9
         xPC//WRvQ7jQTfCAO9IAE3WUNQZk2IYU6O132aJ2qPiOe3UxepMnyxessYmZcXRIH+C9
         uA8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791713892; x=1792318692;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=7VFFpRhUZGG173cxRqsJ8XWcj2i+48AarU4CckLgkP0=;
        b=EqFTLo13aCt1Un2nz6GMYkhfTA78IBUPxUiyJq/46ZhXfz/9hzXu/A+AjcbjmJQGW5
         uNql2bRw+kCDRAcsmquBqX1wcmW5H0McwBHGV9qPRCOe+mvu7aLptJxBTU8pD80DbBbq
         iLiYhc8SqcXaorzm80gU6yAeb+WdXOPC3XF+ENWFv9uq8WSsItU4nh+E6aJQRtQ3JYk3
         4ytYwwsumXCJpWYarjE3e24TGDLQ6X9+p+CpVKTe2bfc/UTWqgjhBxPZ5ErDctQ7LKeL
         Jml5lWRVowcjDwbgln7nIvBLjuTIKVjQ2T3Pug0eRtkgpmtmbFNylYHR5yJX+QXOtffC
         4aQQ==
X-Forwarded-Encrypted: i=1; AKwUvBx7CShqmoxHH8LOuN9FkcqtWdiMQTFPpk7QtjC6sfDf7KQc46zd6rb2cshXGTNgu/unBzTORoYdneM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKr2nKP34iUIVwK3XfOaWrWLVRmzYRUssfsHzDokTnrwa7LM5Lp
	1atAMB2qSGr9kYMTL5r0gFrRnKQml8rOF9NtztipMKu5Sc9FD5yGQozzU5+9DfBxxdQ4Ekae8+l
	NkuB0S9st4HVYvZiwcj43gY8mMLG3BiU=
X-Gm-Gg: AYBFou1ROJJQcnbTX0OJyYaatWj1LtToegU1cxktuuiemKWbt4s0jGo04X/xsQSI703
	JVMSpsNk4GutPEVZw/un3PBa23ZEjPi1o2a6ELCMGfL7dZtTFguwkMrFoD0e22+EvFZam2tdBz/
	w4/ntlV1RvaTHIqCpiJ5e3lC6sJB4k7s74nt3wuQGRZDWbQ6i5Qtk9D4aGVaRmKjikrLYndmAtG
	judNhIsIf/BCxv8TecjsNKkzUVZnfW+ij6np3fJGjKsBpE9q6sUi9b3ob0T6NLO6PkP0DNGuuFT
	ZDWLu+u11yLrzpu7nq1uDqZIY11jU/q1LtaKrCZ+tLRtxo08LVwZpQ==
X-Received: by 2002:a67:e70e:0:b0:7c3:2fa4:9a71 with SMTP id
 ada2fe7eead31-7cb3722f17emr2058168137.9.1791713891831; Sun, 11 Oct 2026
 03:18:11 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 11 Oct 2026 06:18:11 -0400
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Sun, 11 Oct 2026 03:17:39 -0700
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: =?UTF-8?B?6LW15paH5by6?= <berringtoni36@gmail.com>
Date: Sun, 11 Oct 2026 06:18:11 -0400
X-Gm-Features: AclHuK9LHDqD951buwV0hi21vRltaUq6IwxrZMZz83OPQBQupDB3sEGtQOzC1cM
Message-ID: <CAF2O-sPmL=eyUD=EndsOpDnJr2FvpXxhF2RD5S-4-9OgfCRqkg@mail.gmail.com>
Subject: [PATCH] iio: accel: adxl345: update period cache after successful write
To: =?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Michael Hennerich <Michael.Hennerich@analog.com>, Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>, Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
	linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

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
Signed-off-by: =E8=B5=B5=E6=96=87=E5=BC=BA <berringtoni36@gmail.com>
---
Validation:
- A host harness extracted the production setter and period-read helpers
  and injected -EIO at regmap_write(). The baseline failed all three
  failure cases (3/6 passed); the patch passed all six cases, including
  successful writes.
- Compiled the full source to an x86_64 object with Apple clang 17 and
  Debian Linux 6.1 headers plus upstream IIO/regmap headers and a cleanup
  compatibility shim. This checks syntax and types with a mixed header
  set; it is not a full current-tree Kbuild/modpost or target-board build.
- No in-kernel KUnit or hardware test was performed.

AI assistance: Codex drafted the fix, changelog and fault-injection
harness for a contribution related to an ADXL345 SPI/IIO project.

 drivers/iio/accel/adxl345_core.c | 27 ++++++++++++++++++++++-----
 1 file changed, 22 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_c=
ore.c
index 6c9080d..cd58304 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -391,30 +391,47 @@ static int adxl345_set_default_time(struct
adxl345_state *st)
 	odr =3D FIELD_GET(ADXL345_BW_RATE_MSK, regval);
 	val =3D clamp(max_boundary - adxl345_odr_tbl[odr][0],
 		    min_boundary, max_boundary);
-	st->inact_time_ms =3D MILLI * val;

 	/* Inactivity time in s */
-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	ret =3D regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val);
+	if (ret)
+		return ret;
+
+	st->inact_time_ms =3D MILLI * val;
+
+	return 0;
 }

 static int adxl345_set_inactivity_time(struct adxl345_state *st, u32 val_i=
nt)
 {
+	int ret;
+
+	ret =3D regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
+	if (ret)
+		return ret;
+
 	st->inact_time_ms =3D MILLI * val_int;

-	return regmap_write(st->regmap, ADXL345_REG_TIME_INACT, val_int);
+	return 0;
 }

 static int adxl345_set_freefall_time(struct adxl345_state *st, u32 val_fra=
ct)
 {
+	int ret;
+
 	/*
 	 * Datasheet max. value is 255 * 5000 us =3D 1.275000 seconds.
 	 *
 	 * Recommended values between 100ms and 350ms (0x14 to 0x46)
 	 */
+	ret =3D regmap_write(st->regmap, ADXL345_REG_TIME_FF,
+			   DIV_ROUND_CLOSEST(val_fract, 5));
+	if (ret)
+		return ret;
+
 	st->inact_time_ms =3D DIV_ROUND_UP(val_fract, MILLI);

-	return regmap_write(st->regmap, ADXL345_REG_TIME_FF,
-			    DIV_ROUND_CLOSEST(val_fract, 5));
+	return 0;
 }

 /**
base-commit: 9ee8306121495d2a25aa5d1bfd519f2748786b83
--=20
2.50.1 (Apple Git-155)
