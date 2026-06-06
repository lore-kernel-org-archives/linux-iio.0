Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78E83AC0CC
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748291; cv=none; b=LFfndgjn/gjAeY6CXGjo+3LbFIHUA/13H0LWbncSw6dwFMHSVu/I46OJEyBZp9S8NajAjdW+wi+w1hRQuQON0aKTdJhR0FxONzTQ9lkSXXnby6wzRlSfwBRYDMcG22YEeuCZWT7ngy79RSMBNUjVBDV9EgULs5L4QWFfK2jAfTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748291; c=relaxed/simple;
	bh=xBT92X/iokZZhb/ZjZ5JAzsLB+6j1lmE1BdA8QH83Vg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aQ0nfShKgtTOx1d9f32iSqjIRTtdIBl2vmxivMRiVPdmZiB+nHerI47hPUtSIw9edDCCaeUO47ePmOPNUcwMPbJDlCtL1Ohb2V4+qsM9CBij5QbaMcuDcb/BUyByXayiyvTO9YiXTYWvYhg44P80czWGwm76p85XxC4rNZYMs/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cz1eqplv; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cz1eqplv"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-84231305a80so1558082b3a.0
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 05:18:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780748290; x=1781353090; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zdrmak029/i3EG0k6Ru+XZi5MEhnOinTZYf/SVwLuno=;
        b=Cz1eqplvf7szaPRCDUehdnIl2jbSFtbHU4m4zwrRXh0FLx/CiJMmoFLPdkG71iBqwH
         B4pPnLYhnw50lFT6f6H/M9An2VPSlIof2OeXKMzYnxvfcdxX47i6FrN20PAgp/SFrxwi
         R9qiB4qs5QIal3QTiOZfRqgQhadfeV3g0R/3Vqjmgpgtj1yoXTMUSS0GiP8GBtDhyGDw
         PHutkDoc4tfupgXg0kcC4SiJ9dmJfTV5tUHsKMZHaUeAI8Jj4wf3/lhcwjO7fGk6/8KU
         q3nVzyXqd+bUeWEblk50qhJvKN8QekRrOBhEh4zj2+8ycawSnoNw9IaT3lqmVg4wcqa0
         HxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780748290; x=1781353090;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zdrmak029/i3EG0k6Ru+XZi5MEhnOinTZYf/SVwLuno=;
        b=H4fzKZMT/xu49rL0h45UAtbhrkdM+6rZ7NxIh8gN3epAqrbqFRPzRtbGxpndEZSL8+
         8407RKamphb0jKcSRYYZH/1LqsCJAZbTRatLHQQ/ZGK2i5Rd60bXczDBplpyNSk55u5B
         T02Ej0B9ZV4egLrfqO89WZEN6dTu70iObRoQj0SvqhNWnTFi7Q19ibpU9+VqAyksATmi
         ecARdB+JPHqIwWTCgpoQ5mfEOMXUSVpch9NXVJ0m6/4V7i5mKi4KLIZ8PYkXsVuoK/WR
         qeWDrvQOzXlkVNJCuS1zNEjaAjm0og1jdznisNOSBs7357uHXtI1ZLdv6rSnCipp5IR1
         oGYg==
X-Forwarded-Encrypted: i=1; AFNElJ88PS0RIw5IS/PyO1mdrnnM+U9t0vE1yq9vzEpbLyY6p6MPSdYKMrrA9bofwpB0wKx6U/b8T/6Uya4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw08XuPatodKMkzwvjctiYaD2aPG6vWu4lXviGjWweewp5qJigD
	YfaVShSO+YfOmF6ynOSpDWom7/UYTX1f7fflMvGnawgwnrLWHgQA8+VCTq+ONA==
X-Gm-Gg: Acq92OGUMtUhLsaimQlJb2jarkZtqq6NJdrqpvA9Iae+X49BN9VvS9djUEo2pd0mIu+
	Xu0J53VA+aIEY2UlE2Qn5sQkEAbh2C4+jVP5OmXULHI8gYRF4CdsR+A+CwlzaLn5oaByaI602m9
	iLJLVJFXLqfWK1I8u64Kh+iIZPYp+tP2fZYmGkCMdLiMa8fR+d1ZJwCemE1sJUyg7YOU0N6Nv8+
	49l5OIkX+W35rhzjnxHGALoa91yOg+ZwQqwYpUzCj4TEBL15UobBbsIBzRZyEi+B7+4RO7IeGuJ
	uqrSzO2Y+GFIaMrOWBoahFshRftZ9+4wQnCJacdgD9sAU8FFmTq+ckKxNuXRyekioZCfnSjj7KD
	9yELagYSr994qQxs6eYowgVf5Bpuftesu2Df4YpFnyHdXaPAqnZ0/pDKcZwXL/4j/6+O4dhz1nw
	njNTKKMHpeuxHecP1+mcuc+GR07681nvHy2ROfa6TeDbeZuQcte9pBMd/VrbnGhcKLSpRgyw==
X-Received: by 2002:a05:6a00:2789:b0:842:614e:cc94 with SMTP id d2e1a72fcca58-842b0f56f5amr7806194b3a.26.1780748290041;
        Sat, 06 Jun 2026 05:18:10 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8428291ed20sm15253532b3a.61.2026.06.06.05.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 05:18:09 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:47:45 +0530
Subject: [PATCH 4/7] iio: light: hid-sensor-prox: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-6-june-hid-iio-correct-usage-id-v1-4-dd4a6820b674@gmail.com>
References: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
In-Reply-To: <20260606-6-june-hid-iio-correct-usage-id-v1-0-dd4a6820b674@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' variable to improve code
clarity and consistency with kernel style.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/light/hid-sensor-prox.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/hid-sensor-prox.c b/drivers/iio/light/hid-sensor-prox.c
index edc9274a2c07..9059f00f0ced 100644
--- a/drivers/iio/light/hid-sensor-prox.c
+++ b/drivers/iio/light/hid-sensor-prox.c
@@ -166,7 +166,7 @@ static const struct iio_info prox_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -183,7 +183,7 @@ static int prox_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int prox_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {

-- 
2.34.1

