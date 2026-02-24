Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B148A39E18C
	for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 14:04:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771941849; cv=none; b=dZCjyX9/5VhXJFiFLtJJe7XFmIok3Ud1nttOC5dGePeTGTSqNz66hHIYF8Y21S2lNwzAF0KNO0OxgKM49Tf+B3btnlseeVfVwmC7hzRTTEfP8kSqf5APAHzBVkSBvk6G8WtEbKwBUwOlIEs0VC3GjAOj+Fx5evqQEe84VFMlhxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771941849; c=relaxed/simple;
	bh=oLLb29gcQ0BdhzqDQZuPnB8XcQV025xjsRtvxagy5mY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EYNcoDEBcIXlKl7fyYp1DIwm0KaX3Cx4dFvuwUY6ZwJKazVNf1/qrSgChQIDyRhkxmxtXiW2s5JNYpf5J02g1q1RnnOseOtqoDN4/v6Mr6jT97JTO7gVoOEPr7EwVBgzqUZ9EP5ZureFlHI7j49IBzXjjNdOwtCMm2YxyVYW+4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e0zhnCy9; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e0zhnCy9"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4806f3fc50bso63005325e9.0
        for <linux-iio@vger.kernel.org>; Tue, 24 Feb 2026 06:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771941846; x=1772546646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JXJxDts9nitekq/TVoz9OLkW8FMNDccXXJfyJV6WzLY=;
        b=e0zhnCy9hl8we8Ow+/1z4tj7c/vNeLMiVlP+m8Nv1QaejlG2zFHsTC8LiPk/WNIDs4
         Dv6DDVMSELtSzo+h2CrQjD/tWD90D3HAMVhbg8tSZjP+Ct71POnTR+K+hHQJnC6RB0kB
         djk5XPwJkE/YSYj4awO4yo5H8l/HgbiDSH6noZUhkMZ92St5fOc3FERRPSfKhuNT5Xxb
         jt0jquwm1YDjfpqdvw5WO10QwPfWh5qr9OkwP73kEwJ18gG0UGocI6IF1HA1XifGSlil
         fFgh2Z4uvwPmCGwBd6iOLaNJWmYoE4jCnSUylpw+iVpSQB75+hoJj/ogHr8bo4jzmgNh
         s0MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771941846; x=1772546646;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JXJxDts9nitekq/TVoz9OLkW8FMNDccXXJfyJV6WzLY=;
        b=ZPqfAzGk4Xmrss7ajaDxQS6/ROkk/V36o2sBwSxANZitnb/WSi1A6AjGAH4U/j6WlF
         8GZ3YeUnORaOgsej+AWDg2q6mqQfbcWAo/CWSQGTJOsjsLl8zTLg9mxBTkrTVqD5ECN3
         9mYjcaf9SzudhhQ8/4vtwgOXSy8AefoeVLgHdVD1Enx7Zgc/RG7RsLYqZ/eCTmLhq3z2
         N5M3RowJ9m9rYj4Pnz0nGp+FFhCXBaZT4y2+Iuv+DD43Cvb4fBzdRJdDlZ8bzq3UrB0Y
         TgT5dtJU88JWvyTY1ynMfFedoP2Z4OsUisor10a1SCCnnicLVObj4pWXXdU8P+vjgVnN
         3ToA==
X-Gm-Message-State: AOJu0Yyi4aGT/pNhseM/nhUaOYpZZKpV/N4Ob0ksd7S6+VEOJo/JTmpn
	pTSFDTgvraeJjZYUcm/g/daU75lqaCLzKGxT6QohrgxmG220BsATaHA3iU5i/TyG
X-Gm-Gg: AZuq6aJcshcHfEXblFbNRCxggY0JtAL/GcZ1IzDLE68ikr0PLxa7XwOR42M99EYd47B
	J9hcOly7JBumknIBT8uccrJKN5E4RjQxuls0pTFXkIXSsItzyJQwmP74k/zRClN8a5SRM+blxcK
	/lZZJM32fzvGDSopUQssrm2W4m10+WgYGX8Ar2a2suET811IvMbSNUauMQKbISwp41yb8lTBkej
	zoLHfkxtKbqwPte80egpNSKbv7bYjdsOhMXZQX64DwI+DC7UsPFicr6IilBCm6GOo3zDa20o4sm
	WpEWSOggaFXiac/iosF00SnZfzmr0ZzkvMa6GPkN5Kd/NGvpizbUyov8zO0ClwUrtRs9F9LYYYs
	uPpBy9+Su+wFqyipMxxjfxvFZdZ/M7xR+gn0kEQhyCplpWKIhAHFzfOiQOQc/UrHrGfFBGkA5Q+
	hYjxe2+09xD5pThRg0k0Tch6tGdfIbUkAlh5rr5mBqVEZOPk4z+DU3utHbfns5Hg==
X-Received: by 2002:a05:600c:5020:b0:477:5cc6:7e44 with SMTP id 5b1f17b1804b1-483a95fb698mr228656595e9.11.1771941845765;
        Tue, 24 Feb 2026 06:04:05 -0800 (PST)
Received: from db07.1337.ma ([197.230.240.146])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bd7010a0sm1043505e9.5.2026.02.24.06.04.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Feb 2026 06:04:05 -0800 (PST)
From: Taha Ed-Dafili <0rayn.dev@gmail.com>
To: linux-iio@vger.kernel.org,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	rdunlap@infradead.org,
	skhan@linuxfoundation.org,
	linux-kernel-mentees-archive@lists.linuxfoundation.org,
	nuno.sa@analog.com,
	andy@kernel.org,
	corbet@lwn.net,
	lars@metafoo.de,
	Michael.Hennerich@analog.com,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Taha Ed-Dafili <0rayn.dev@gmail.com>
Subject: [PATCH v5 3/5] iio: accel: adxl345: Expose IIO_EV_INFO_VALUE for double tap
Date: Tue, 24 Feb 2026 14:03:46 +0000
Message-ID: <20260224140351.27288-4-0rayn.dev@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260224140351.27288-1-0rayn.dev@gmail.com>
References: <20260224140351.27288-1-0rayn.dev@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ADXL345 uses a single hardware register (ADXL345_REG_THRESH_TAP) to
store the threshold for both single tap and double tap events.

Currently, the driver only exposes the IIO_EV_INFO_VALUE attribute for
the single tap event.

However, the IIO ABI dictates that if an event is supported, its
associated configuration attributes should be exposed to userspace. This
applies even if writing to one channel property alters the value of
another due to shared underlying hardware state.

Add IIO_EV_INFO_VALUE to the double tap event specification to ensure
full ABI compliance.

Suggested-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Taha Ed-Dafili <0rayn.dev@gmail.com>
---
 drivers/iio/accel/adxl345_core.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl345_core.c b/drivers/iio/accel/adxl345_core.c
index 78e3f799ecc1..1ac99263ad8e 100644
--- a/drivers/iio/accel/adxl345_core.c
+++ b/drivers/iio/accel/adxl345_core.c
@@ -235,8 +235,10 @@ static const struct iio_event_spec adxl345_events[] = {
 		/* double tap */
 		.type = IIO_EV_TYPE_GESTURE,
 		.dir = IIO_EV_DIR_DOUBLETAP,
-		.mask_shared_by_type = BIT(IIO_EV_INFO_ENABLE) |
-			BIT(IIO_EV_INFO_RESET_TIMEOUT) |
+		.mask_shared_by_type =
+			BIT(IIO_EV_INFO_ENABLE)		|
+			BIT(IIO_EV_INFO_VALUE)		|
+			BIT(IIO_EV_INFO_RESET_TIMEOUT)	|
 			BIT(IIO_EV_INFO_TAP2_MIN_DELAY),
 	},
 };
-- 
2.47.3

