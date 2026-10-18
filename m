Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF8D4C33F3;
	Sun, 18 Oct 2026 13:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792330908; cv=none; b=jfbqO3wWPHVeANC6/bwAgp7ojKZct11k30V8rcTwfpaYFmLA/GNLmndn7dfoPDAAwC4cRWyW8/1k0Uo+fKsE//x+euRftTWlt41hR8VKH9GJni2qd8E1EOagcK/vgTmN1hrLTZL2+4z1/OQuD84C7rwFbxncwc+DfFLDg0zbalI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792330908; c=relaxed/simple;
	bh=qUNuo08HuRCsYyRBRIxHEBGkyY0NfHIo/OpUESBmZLg=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=q4fcuGr6UQ8/H0YAod04TT7zKI144yzYH88iwuLBvAnh6YSBx956hOsNMnEgCfBrXya6SFP/xkOUHGbQv4WVU7cGIHZ4irmPGLdxaXd1AyLfE87/vUs2YQ7xzew02S1uhfVgM0SDn+692eV7LDkDHJmnbDOmZIhsCwctQel3Tu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WyW0Woep; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WyW0Woep"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69ABAC2BCC7;
	Sun, 18 Oct 2026 13:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792330908;
	bh=qUNuo08HuRCsYyRBRIxHEBGkyY0NfHIo/OpUESBmZLg=;
	h=From:To:Cc:Subject:Date:Reply-To:From;
	b=WyW0Woep2MnOEIkdY4c/2Hah8g22awdg3C05bRp9hRJegSQMcUEUu2AIMNWkl4tNB
	 7WQXUQnwRwBMrgb+AQdysyU76khJJByrPpWFHNiq138xrVlx6gPqBqPbOxBsDS4A5D
	 ogmaeDA1pvtMArtvtbgSWqG91JzTojIUQjoQ3PtVKvqqvAXzq7wxbjknU9vBFQlryS
	 WKiyRcSG3ttCci1hBNUdYFnloKdCLFKdavaUfqCKoimbKk9dBY20wyetCBpYHaNbeJ
	 HlY1lTkHd4or/maSwbojzCoiwQckr2GG0fwVfG+qE9eOfbJdTe+xjyiZMdJShdyGfW
	 PfR5AvKnGxGVA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5546FCCA490;
	Sun, 18 Oct 2026 13:41:48 +0000 (UTC)
From: Wenqiang Zhao via B4 Relay <devnull+berringtoni36.gmail.com@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Michael Hennerich <Michael.Hennerich@analog.com>
Cc: David Lechner <dlechner@baylibre.com>, 
 Andy Shevchenko <andy@kernel.org>, linux@analog.com, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 RESEND] iio: accel: adxl345: update period cache after
 successful write
Date: Sun, 18 Oct 2026 21:42:00 +0800
Message-ID: <20261018-adxl345-period-cache-v2-resend-1@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792330907; l=2895;
 i=berringtoni36@gmail.com; s=review-20261018; h=from:subject:message-id;
 bh=gzk/oV5DxvB5SYVBfqj3OWFCMqVZXw8MAoKLN74hP0E=;
 b=Mb2B/AFNc0QLKH07NYJvnlGaYS7HB1+5O8/qSTVwxi2BHmLjWSes3ii3rGw+VFP5siTpmfMl9
 dJtMUq5ujayB/0IjKUNid+XcFDN3juinVN/izAo10tdTHP5Qd3DYg8/
X-Developer-Key: i=berringtoni36@gmail.com; a=ed25519;
 pk=rRiAvRvS4MMqogNnloZgVnqWliVWNDq+PcP6vMYXOvs=
X-Endpoint-Received: by B4 Relay for
 berringtoni36@gmail.com/review-20261018 with auth_id=1226
X-Original-From: Wenqiang Zhao <berringtoni36@gmail.com>
Reply-To: berringtoni36@gmail.com

From: Wenqiang Zhao <berringtoni36@gmail.com>

The ADXL345 event-period read path returns st->inact_time_ms. The setters
for inactivity, free-fall and the ODR-derived default currently update
this cache before writing TIME_INACT or TIME_FF. If the regmap write
fails, the sysfs write reports an error but a subsequent read returns
the requested period even though it was not programmed.

Update the cached period only after the corresponding regmap write
succeeds.

Fixes: 8a1536cc4a1c ("iio: accel: adxl345: add inactivity feature")
Fixes: f6f22950d925 ("iio: accel: adxl345: extend inactivity time for less than 1s")
Assisted-by: LLM
Signed-off-by: Wenqiang Zhao <berringtoni36@gmail.com>
---
Resend: unchanged code; submitted via b4 web submission to avoid delivery-time wrapping.

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
@@ -391,30 +391,47 @@ static int adxl345_set_default_time(struct adxl345_state *st)
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
-- 
2.50.1 (Apple Git-155)

