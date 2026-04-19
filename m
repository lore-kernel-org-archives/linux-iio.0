Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C75282F31
	for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776621954; cv=none; b=ke3fcDP8u1f7JvMW8HDZhVHTz1osWUKtWCxyJ8aWLDdQg9pQri6bj5eqC2SlfC6Y2ebp/8VmQOWhGyQJdual/Aq0yqYyMkMPAnP7zy4RyUzFid05R1JFkjrcrT0swwteK0AovnWIxslG3v8wax4DQTUIIu035sh7zK955madtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776621954; c=relaxed/simple;
	bh=h8c6KWYSx2qYQtRw9RHF5rYrIdnVminbpAKG+xia53A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=LsmYwMEeEzSDhFW8VCxHii4ST/tEWKpqoiz33JieSdDLCVPe2p3jmegd3VCVhfmBkrV9vs5m62vu1UwDh/GC07H5Sbdea3WnNGk8gR0ilbUcEf0O9LQ9tXW35ULqaeSmu3Rcuyr+kt0Hb3oohMHT6TcOOhYS/GmZRNLRkTqA5NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ab0R5wF4; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ab0R5wF4"
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-43d70c30767so1827419f8f.0
        for <linux-iio@vger.kernel.org>; Sun, 19 Apr 2026 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776621952; x=1777226752; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xuqLiO+tZUtflw20035WjCFl3ZnyOB0TyhLknS3UQg4=;
        b=Ab0R5wF4OCbPWI8OuqYAZIg9yJ4XPj0fBNDDanZPOKrPUcAwYmJXkWVC70V4DICaYD
         cz2/urNtaeSoLlgPbhCynLVto+lLBMcNKsImR9kVvEVGhkjq5m8/KMc/IDkGXrLt1DZr
         8joReVXDDlz9MbdejveBKTptKypwNBzxPZeIgnCxrkrD5rA1pKTJhnXdfGH22/ZKALAn
         HrXOahOeDv6QnNlDGGyHglGI+rmL5OnPAZi3HuNlQIBuco8WW7WW3Ht9bvyAUAiKuun1
         NITVC71GiBu6b0ExkN9AYCc1bqsQbos0E/hGBHU6GLLp4/juN/G1bQ0k3Uwo5kBtLu6X
         Zi3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776621952; x=1777226752;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xuqLiO+tZUtflw20035WjCFl3ZnyOB0TyhLknS3UQg4=;
        b=exvf9eEffRQ2y1OOScLbVmAieiY71OghbhNzXZnibazDoGlzxABPQ8MbCyl3GH/n0Q
         BT7JkLyqisVTi/zHyaPqsxxUKSCCWYpQJ5guxaILMo4O1bXAWkrCv4Mixcta/u+fVvZn
         E6CNOoWfTcCxMxSX9soNzRRDMTYYcdGx9SKTotNWTTb56bhCMH6BwB1kxuL7m5DrxUAZ
         GYYa3dLTLPJ5vUmSKRTTXUELC5H3MBJlkzXvRuCyavsKeLDPr23QNXVY3a4nXoEUQCpN
         qpQGKkHoC20SdDiGUZOxRI0QOtrhj9ut6IbnsLSAF8VI1pRKeuOfYmv10dr9OPiuixrZ
         WDUA==
X-Forwarded-Encrypted: i=1; AFNElJ+2jMHx8yCXa1qBT5/sNCBMQGG1eLCW2D5DjHW+/bpVwzbMZkSzWSD0QxWpqmwEwylPWgskAAqae2s=@vger.kernel.org
X-Gm-Message-State: AOJu0YweayNu9sB1G12yoCOYqOYiKKOWPMolOwJSdjkZWbk47RUVN6PT
	+RIiTjLjR+yS6tQpEdqYGUCoLFWxPm5oglYE5gqSFmDHFrDeKVS/HAQuoqLmUq8L
X-Gm-Gg: AeBDietKUk1/jy4wi41d19V8wJoEnFWAwnLhiUtPwyyI96zEer+jSM5K/oY3hnmD9v9
	peSFynM30jYvmraZl7WrUOcnEA6TK9Cg1MkTKXBiYIAjK1SGH9F4audFmtGEFa0Uv5EmiHK+BXJ
	HAxTwk+21sg0x3gPG5cZud5wOAMngcjJ6cIPlQ83SvOrrWnyITNz15Xr9pkxaYLjX9ajZ8ALkih
	oGHkVsSdtV4BRp3hHOU3YP291lylCAOxts3J/2JztphrD6mSEdxoEyumfN2SMU3aI511Tq9jg4m
	w28PYfnLonF+m1UuQCd+ITcUiMNChfPDZbdFZhGGy+0oymn4nem+3tcjehxq151OTfXfWyuqGmZ
	C6XUJQDseNhjeI9TiKKtK9md0AEpfN1Rw52pOvoTkoJ4V7+lDk5sFnKXW0NIdnR6u3P9ozitEwR
	2j2Tm9Y+9A5YAYF+3QrGUTH0v8RbVLNfGCvO0HkqC+8Obmd25JNaCIpAIJK4f1uOWIuA+0wA5o0
	LmoEjg7iQ0o3DmQy0+7Egc4f0nyql0NrZqT84o7QjKLSUvgUZGt9zxIDn2LLJfL5EwwcvLwOPaa
	aqYCOByVAKjQgyGsLFzIyX7w6sjHX8MBGMLAdKWAPdd0Jvb+Pv5l2G4zexpsO+97GG/GIAkl59m
	MR1in8f4FVfjugbEY+jGq
X-Received: by 2002:a05:6000:228a:b0:43d:779e:afa8 with SMTP id ffacd0b85a97d-43fe407a7e5mr16800025f8f.16.1776621951557;
        Sun, 19 Apr 2026 11:05:51 -0700 (PDT)
Received: from localhost.localdomain (ip-86-49-249-181.bb.vodafone.cz. [86.49.249.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4dc26a3sm25685556f8f.15.2026.04.19.11.05.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Apr 2026 11:05:51 -0700 (PDT)
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
Subject: [PATCH v2] iio: magnetometer: hid-sensor-magn-3d: prefer 'unsigned int'
Date: Sun, 19 Apr 2026 20:05:23 +0200
Message-Id: <20260419180523.37396-1-joshua.crofts1@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use 'u32' instead of bare 'unsigned' to resolve checkpatch.pl warnings
and correct type use as defined in the hid_sensor_hub_callbacks struct.

No functional change.

Signed-off-by: Joshua Crofts <joshua.crofts1@gmail.com>
---
v2:
 - changed 'unsigned int' to 'u32' per struct definition

 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index c673f9323e..b01dd53eb1 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -280,7 +280,7 @@ static const struct iio_info magn_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -302,7 +302,7 @@ static int magn_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int magn_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				u32 usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -350,7 +350,7 @@ static int magn_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec **channels,
 				int *chan_count,
-				unsigned usage_id,
+				u32 usage_id,
 				struct magn_3d_state *st)
 {
 	int i;
-- 
2.34.1

