Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE32738E5F5
	for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 11:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776425305; cv=none; b=tCW0Pi/wQicf0QwpL+OP5KD2d2dPSzPleHey2sFk6sWTjU3OBD/jbhNdbDfQguPBl8tzk7U/hJaldret9L39Qg2dqe64bNBXl+3K4P8NyizjRcppBYX3FswM0fdYZFYZ27G/TuuNcIN3wiEALppwAq2IM9918AciVpH0MtERh70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776425305; c=relaxed/simple;
	bh=36W6yJDWLIth+tUseXKkzXolAUxka7O34Ksz1lKW9Nw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OnDdA988mHOsMfMC9lTnwgghHSwREjlhjlWYKfyUMPDbaPJEOTpMv3QzvU1JSu05jJoc77PYnIbxKgp9IzEmjlrwl6kdINHwCV4SuODLSbcppoWyThEwdkL3GRorgWDerKNz9BjTwKbug+Zv3Qr6VIGVr1o6c088+HjymBQYIzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M3Z/s0zV; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M3Z/s0zV"
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b9c04152730so100495666b.0
        for <linux-iio@vger.kernel.org>; Fri, 17 Apr 2026 04:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776425301; x=1777030101; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0uNWB3DvmF873bNYVv5qFQjmGY5lb9eWysb+QqY8hMw=;
        b=M3Z/s0zVWMzdG6KqkMUcPyCdvyRrb71PHImf1UhkUFko5x+8xDQHmham/k0d16vpD1
         WxH5bHgZ2N1CBAUQmdhXy4F0UemUx7fwnXWDVEf5gk4Ev50um9gLjPzW7r+SIcahM5hS
         K5ce3l83VPGTZyIuWEUGyv+biEDV9SX26+t0D5Goj4vOZ1CpzZ3UkIkdwxjQxloFoMeO
         UW74LSscwkX/wqkoMkpF4moJDIfLK+qvFf8Ak9HY+pCrzAxy/9cAEGOkDFAI26PrgVyp
         Nmv4HPnxcr6tq+CjLiggWxUAGquKX/eYkk7+zAfOB9iUoyys/1mq1m/Wo8ITz79GUL/p
         bIcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776425301; x=1777030101;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0uNWB3DvmF873bNYVv5qFQjmGY5lb9eWysb+QqY8hMw=;
        b=OFnuhpDfutREiFyR8qA79DSKMIkssZa0ctkGMqbJSwNzBUWw57lgmfELItPQJt2WXe
         omubSQEncONfp55xb/Xb88XIuWNPb0YtO8Paz//JoP4wQlFWyOP9f15wxV9V7U+Ho8Kz
         JMdDfSxKasvZhObOnYjATIDG/iyR1FXlk/ZK6PAi5jw/ZCThS5Wxc6tAChCL52SQYTRk
         aWXEgTCSypJxrIVDGweRbOA13dpMh/S7s3Rnj1lQ7zehP57wQsi5eY26zgHfRdSZotTF
         8Wy9XJxVIyQCA3ycZ8Es+M+uRnhwhso0YCqxeWiAOHUbTZcSqRC60GIxXWFNHgOQApnQ
         0OLQ==
X-Forwarded-Encrypted: i=1; AFNElJ8aK5c0r1UKgUIvuj92xIhbu3GW0xmKFH9Z0VaUcAMJzw02fDLQvgju4t5WX2cdDH779W5153CzSHo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yza4OyNZoudwWle3e7rruV3Ry+IObfq+g46yIDyib5mzSO2kana
	iLZTQOz1MxE2OQTIvK7nTZFpLOy3n9dwkCGyAe6tQY6dQ6r6wDalQrbS
X-Gm-Gg: AeBDievIyVig1mgn84dcUf09GMXxbcsbWwvXozeEyWR2Q2umN6JnPyRqzmv21jTvJPR
	dYVZH43q759vZ+g9U6/9qMpDGSk0JStH3bv/boHb24ad63XhQ7LkZU/WiXxOI0UJKKu34/MYLMR
	a22M7PBE3gB7jig5xxdg/SMfyQWiX5E9X//ICiPT386lbv/2oCp+SVzNile8YruG6EGyWhY4C5h
	YplSK5jktP8BDmJ/lCSe7mN7DWC25bbvaG0bHB1kJJdizbX4w0u65MyulWP01krcRpAH2STe3/Q
	rkj9RqCvR2RnLT5AJ0W9XvopLlY6e7fVzcsibI6BpGO0Lwlh6vlewQAAnIm0amiumx0tDFnkCgs
	68oRHbaiEZaabhsd05jt9HFpVQNrlB+46/4UpL2DEe1QVr+fFPNgD0zqfaw3LD3cTf184spChVe
	5siTv21FyNTUk8fMAeZoLa3YAkA3ipaeIcw4rPk52W1YvGoqJctISSNvwbLuUIWZa72YsEZLsKp
	RMkeamz/Mi9kBMavdLfNUpmqrTt4v+cG7EHtmTBPapBGrtglJLths+FjYm1lFrf0zkoAmkErHG7
	xEwukjWD0HHBU+Ci27vl14/nJZ3E3eH+bdux3zz+VY9lyuG3WQ1ex/eAV5X+2SOPD3Jw3Nt+G1E
	oCg6Ztw29lQjyYbCGkZwY1pSUAYE9xvO+m9D4hYMbgroPAjz+h8FI0ZvN4cYA9sc1scAlF5OI7J
	hn0nHntAf+i5cx
X-Received: by 2002:a17:907:e989:b0:b9c:b808:4617 with SMTP id a640c23a62f3a-ba4188822acmr136165766b.7.1776425300954;
        Fri, 17 Apr 2026 04:28:20 -0700 (PDT)
Received: from cs-280612103108-default.europe-west4-a.c.od237066db22328bb-tp.internal (100.61.7.34.bc.googleusercontent.com. [34.7.61.100])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ba455046429sm45363466b.50.2026.04.17.04.28.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 04:28:20 -0700 (PDT)
From: Joshua Crofts <joshua.crofts1@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joshua Crofts <joshua.crofts1@gmail.com>
Subject: [PATCH] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned int'
Date: Fri, 17 Apr 2026 11:28:08 +0000
Message-ID: <20260417112808.1280-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'unsigned int' instead of bare 'unsigned' to resolve checkpatch.pl
warnings and adhere to kernel coding style.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e..67550f16a9 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec **channels,
 				int *chan_count,
-				unsigned usage_id,
+				unsigned int usage_id,
 				struct magn_3d_state *st)
 {
 	int i;
-- 
2.47.3

