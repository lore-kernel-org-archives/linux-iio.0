Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BCD42669A
	for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 15:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781105863; cv=none; b=QtZgQkhsZbrmsFVFdHymHCsFXvuFxkY49CDQxZH5+wf0MBx8S6hI+5FW8WEFeNGNUtC0xOx8lspZwNOSnpPiiD9f/Y9bGhjhC9MeRu9zKnYPiOm7pFxDhjpE7h+w6YB2gOXN7oJfxsusmxQKDcJiwPebkeEW9KqKQA59Wszg/+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781105863; c=relaxed/simple;
	bh=pkm5vzy2vpiZYWSqVFviIVDc/kJl4k0wNGj/MB474XQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BJ7aHDGFIGhcrtxCCFCpHaBlXdt1yYWJcCauVWII6BLXs774kf1i9+QtwR76nvqL7T8TZtLhbzbwoK88RpEOL8aIXSAjMwaHDiOJAqn1QZBAdpmyE1ezeL6z7WiH5Dfr2EYXPCYXneg8edc941EnWDHae4n8/S74HfZ3eKsWGLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EEFTkatv; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EEFTkatv"
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-36d98c9b596so4398032a91.3
        for <linux-iio@vger.kernel.org>; Wed, 10 Jun 2026 08:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781105861; x=1781710661; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yHKuvBHrVXhG8sQXlD+Cs6t4uIzT53cwVV1ajiwy0lE=;
        b=EEFTkatvzaKYZ2PSHF6MIwD9PW1qdLb+hgDtPkhqyIJwFeSpBbiVH9fgQA2+jaujD3
         W3awaPy7lF3/bw/lSpXk0wqjPaq+plEIFzUTPgOWeCAoKR/yfdfkf/w0rdUAUejgTXdE
         CDiuCDAY+HXrh123V0PqLqnOklGjQwvTw112VyGCgQmFkOyXBGmkhRtWnZa702kbvjDH
         2HGbg3W9UdaxTFSHMM/thVWCzcooJPUpPbTpi3IAIIbnhoG9XyIaTTLs+sGEebqSQr+t
         xsY7D4Tf/bTE5IN6muCFGBqxBuqyKzrFCWW/83yFGH7HwskjFgoAgi90v24ulSD51wwV
         fsdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781105861; x=1781710661;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=yHKuvBHrVXhG8sQXlD+Cs6t4uIzT53cwVV1ajiwy0lE=;
        b=Qkg3MVzCcw1XZSCedXHwBu7c6DZ28GvmEbEde81qC0CmKUgwe1zKtxU60AgaDI71sg
         wh5cWvkyZfXdsW+J5xDxKL7dwggpnpfZ2EJDo9XJ7CoY6hVfOKyuZwNpfI/mvBrqDyW8
         tULXiGt76Qo5LUq/Or9O9dqXl23tLXMOjhtcD9NA/COTFz1aH9Hq5CtL6jJ9m/WtrPtt
         aw4VSN9YFGvga4i9J7/NmADXGtSkeffrZyzjQzG2soOP0LvPZLgvb3ycnvLLvWad4Zn5
         VDJcq2nAi6tEbJZIsTaQ1bECtwTFl1hX/l0KuzkJGcjRpSd1LH4l7Xeu5fcptGskvVlE
         UT1g==
X-Forwarded-Encrypted: i=1; AFNElJ+UQUuJmCaNScP0SZS+39iD32p6RQydFMEy2Z9AU12o5R+yEamogavaKe/o50C0DBd3G3GFjJIBkNo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxArLg1/An1NnyHtzPUBVjbR7WDjlxRujF4yi43TGixIYTv4lNw
	2oUtmrlJ8pnz9cz2B0xYdTzaylqj1GliIQ8Qjdipo1y5yAwEn8Z7w7hG
X-Gm-Gg: Acq92OFLCYwyljo4JGk7B1opABEQ+Gzg1cVCpWh3+bVr55Fji95Xs/aACNnwcSt5QfQ
	3TyEVjyAudD8fdJOnz3kZDwFQLbcXdDXDC+rSb2dYl7hInkh7Fd9GpI+BwKER35OoTZPaDm3XUb
	FQf2EEfDx65HSmnSoI+87dxWaywaRvKmXREfj+AdQJcs1lSrlNNOqApbZfV8f1ZDJaEU2GhPHuE
	CYCF5c0B6Fg/11RQRsrQK6Z3Q+VFYIPQXu/fSr35gcBtKjPlASVQAxUMe8SrGup9ZfS7LcMSBrc
	E6HkSYEx9D8h73UoH9j4N9h3NhqqOL89M4Mj4yHEUJarr1W70tBpLVNyKCc/EJG/SolRWKBY6ui
	JtIciSNeDCYA5MruM5T0VRl89FdHroFOg2XjNp+wV8ZekmF7LMjgRRSrCtUA9TEVbYkCKCa29Wv
	eXMV/bPsCRmX8HfCb/FV5myM5FuikyFvpshWNavJd+jCrDeSILMeLGs9/d+7cCrZ01tEGHPg==
X-Received: by 2002:a17:90b:4a48:b0:367:b8ad:f0e9 with SMTP id 98e67ed59e1d1-370f0579c14mr23686254a91.16.1781105861399;
        Wed, 10 Jun 2026 08:37:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3772e3a2c92sm127506a91.11.2026.06.10.08.37.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 08:37:41 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Wed, 10 Jun 2026 21:07:08 +0530
Subject: [PATCH v2 7/7] iio: pressure: hid-sensor-press: use u32 instead of
 unsigned
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260610-6-june-hid-iio-correct-usage-id-v2-7-c3c5f0720493@gmail.com>
References: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
In-Reply-To: <20260610-6-june-hid-iio-correct-usage-id-v2-0-c3c5f0720493@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Sanjay Chitroda <sanjayembeddedse@gmail.com>, 
 Maxwell Doose <m32285159@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Prefer 'u32' instead of bare 'unsigned' for usage_id variable.
This matches expected callback API type and improves code clarity.

No functional change.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
Reviewed-by: Maxwell Doose <m32285159@gmail.com>
---
 drivers/iio/pressure/hid-sensor-press.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/hid-sensor-press.c b/drivers/iio/pressure/hid-sensor-press.c
index a039b99d9851..3e47a10d72a8 100644
--- a/drivers/iio/pressure/hid-sensor-press.c
+++ b/drivers/iio/pressure/hid-sensor-press.c
@@ -155,7 +155,7 @@ static const struct iio_info press_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int press_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -176,7 +176,7 @@ static int press_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -204,7 +204,7 @@ static int press_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int press_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				u32 usage_id,
 				struct press_state *st)
 {
 	int ret;

-- 
2.34.1

