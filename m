Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38FF532B118
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 13:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616341; cv=none; b=opRGDx0fHmTBbwf87B3f8DqljhswfxgXvMTfgjWvkPu3Ke+tbOuWf3t+CqbqZzgOTlriyORPj0s+jmUoG6M8laWwv3S5RY+d7iQ0ytOebwKHni4e+NH1ZsSW33Uj0dXI5lYh4p6Y6mFwSty/zl74eJMsrh+TtGGB7H+ymX1Teow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616341; c=relaxed/simple;
	bh=Sxd/SrcujUUhRfwBaDCPn5GXXbvSiDKztzm3UU5gxPg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Df+a+wb3UWGanIXbpNtFwPUEteAwhhGuj7jOatjKL0WGWBNnQta1h2WQkteywX2FNtUbKwh7GcAVDS9vwD/e66dRtSG/p9o13vZdYhQfHaR2+0wuVsKhN+1RZY8zTMD+rs5ZdsVTcIoPXjRmKAUoHp665ZrRO08ehvlVzYoC7PA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=p5Z2njBz; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="p5Z2njBz"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c8584e80bd9so1730986a12.3
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 06:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616339; x=1782221139; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NkocZihbZzYSbPpNk3n5PGGeczdx5v/JvKMwmEHQUjM=;
        b=p5Z2njBzNUmXB4BZ2UHNTGohs4RgnaAlXUw8dleX9wEvcwfnpPI2GuMArepwgKWS7i
         3vr55CYblzMxhHWODxANIkMkZ3heGnHbYjRw3qUG4x9nbfsMLtIUKEO5iheGj7Jw4hK4
         AO5VUYlAIu3knIPQI3qW6mfHnBYoX+s365qnrJ9l+1eMBD/CnBAf6UWtNCHGveRwr8Bl
         UHqOVBBZ7PKb1TtAnRPJWptf4EM+W36G0XSh2FpIqxTqpkkNJSMboNvt8W9Nao4OblB/
         7QZmAyr0bsvIAfEpnBNSahdhFU0pYxVx4eQvvmlMUuiPorE5LUS02YSyFco0tThCO2gf
         IF5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616339; x=1782221139;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NkocZihbZzYSbPpNk3n5PGGeczdx5v/JvKMwmEHQUjM=;
        b=UzeC8YL/GbRaGqmQYRtNsOHddW1U+VglxL97B7Xi52C4f74GgR580ziqqNp5XuDhuF
         F2A9zJZ2nKUBsB/1rmvDK0Lft4mtMUvhFFk83jxJ93nDpXfWl2bmAnJVjPmK1HuNXoQI
         dT/piDglJGCDM+TWIC5kqARwK4GiJ86LqYjfij/7yuHeT/Wqtofs71+49A+0jSg/MDrc
         FjjGWuGZFKRzBLxcM8YJLtIFhmLqNBnINUc0OFs1aT2DrlOJ+68CFeCH/aDQCz3Rq5Ai
         yQCSXGAnXGC8koh9dHXJWPqX7qlTKqSDzjGowiZEormOPGn79KkgB/aeSeIvpA7FOxX/
         cNbw==
X-Forwarded-Encrypted: i=1; AFNElJ+zq9+uSzBOoXDLC5MDmcTk1xBVGAgK6TTk/1sVJcmd9Drc7LrQJmRa2JalegUEUq7DuUaLWm7zo78=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx7n7X0HyXFv1eeZGcN3m6yhKtTqYuBPQiQlKclafr2KCrSVAsv
	n7VVTGh4bULu0j46FbjCdKqTt90ZD84xrUnG98kxwMWuzU79n1Bb2JrB
X-Gm-Gg: Acq92OGrwiLR0VYqXwmNU2dVeTgx1pZHD1TWAjQ8x9aNu7k9F4hnnZ1t4h8oMm5fBFk
	n/LmoZmR5Wdu1U/rq0imAXPSEYB+qtmvR8NIdildEoA0YMypUjnHE6pt82CvWVesgTIXnS7/cpu
	0cBm5SxG6d9dyaABzHiT8vdlz3GadLxajTt3tVI3KpvSk9M+YEi4wh0Kog82bjo60LHFum5eayH
	VolLMepEE/Nrl5qvCBFSV4VPy/jlk2d64SPyu0TgF/z1n3QbgqnahSFczN2HfIDb8rI79J2ladm
	eG36g1S/yfgVJEO8mFzjA1HmhrPAhs92vRZf/iJHF4KGvAqaJEt3XOETvGP9KYq/+DtVWV6+sMC
	btyNh7Y8HPwc85RzEmLiC2SMW8PYT1OdYIYbewojO8rHtsTiygEgwjlNK9/76PrUJHxkp9NLGur
	Bn0gSGtMIkudPYU9Y7oJ+cAwQeE3YJHfrcmPsUc0t9oDnaaSWP
X-Received: by 2002:a05:6a00:4c08:b0:842:2efa:5fac with SMTP id d2e1a72fcca58-845151a1030mr3580208b3a.0.1781616339501;
        Tue, 16 Jun 2026 06:25:39 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:39 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 18:55:21 +0530
Subject: [PATCH 2/3] iio: hid-sensor-humidity: use u32 instead of unsigned
 int
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-2-952c74195f46@gmail.com>
References: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
In-Reply-To: <20260616-16-jun-hid-iio-u32-api-type-v1-0-952c74195f46@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of 'unsigned int' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/humidity/hid-sensor-humidity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/humidity/hid-sensor-humidity.c b/drivers/iio/humidity/hid-sensor-humidity.c
index be2338d5f407..c376a247b137 100644
--- a/drivers/iio/humidity/hid-sensor-humidity.c
+++ b/drivers/iio/humidity/hid-sensor-humidity.c
@@ -127,7 +127,7 @@ static const struct iio_info humidity_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, void *pdev)
+				u32 usage_id, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct hid_humidity_state *humid_st = iio_priv(indio_dev);
@@ -141,7 +141,7 @@ static int humidity_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
+				u32 usage_id, size_t raw_len,
 				char *raw_data, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -161,7 +161,7 @@ static int humidity_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int humidity_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned int usage_id,
+				u32 usage_id,
 				struct hid_humidity_state *st)
 {
 	int ret;

-- 
2.34.1

