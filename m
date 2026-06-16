Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 604A9329E55
	for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 13:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781616337; cv=none; b=h+jhG2MHvDxr4ulm7Yk6yJGNz8ryeKJULS5Ah/mBG4K/BlHvjF6k14XEORbxeX/kjdLy9JVH5qlPk2CQLbNaa+F99cxOwdWxpuvf04w1uwr3hz2WOK+aVcTDp6jjXujBF6NJ/ZKVKJ6MuQ+CFsv7WTM4OiDVOeF9Ag/QEyZ70Nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781616337; c=relaxed/simple;
	bh=ivbSDbPjMlcwVSaPpwbnzauJAgE6QePNzCiPCOIkAos=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Zv1gwlSMplXS1CRtR5gMMSRKxCMP9B1yUIbofr0CyfP+sJNM4L/jpkpIcuOPr7npfkCdJMCQn4TYLHHBXrB1SW9sqj6gP6haBQ+knGDvpivcmiqZdePHHT5o/9pRBNri+Wfo08k8GnL61rKRWnN2SuwAscKcMTEHMHbUIn4czvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U/FqFtul; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U/FqFtul"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-84230ab8857so2112420b3a.1
        for <linux-iio@vger.kernel.org>; Tue, 16 Jun 2026 06:25:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781616336; x=1782221136; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBh3T8DiAUTzySoFqHErLUnRhZqyPc5fESGPTvCXENU=;
        b=U/FqFtulpgqDzj+DMnXHncndgFaZFsID/BuFVPNaf5pgLhDMjukwN3bVt40sv7MwSQ
         +jIjEE7EJlg1Rhu5fuqiD2wxSkNJ2QCU+MBGmaoTYC5WgBOIVGP9eEHdwIdcJmf9iwCe
         j++h+OfxDYbQixBGbatbOeF/ql3nEJ0XxxzJm24eI+jK0GqQnxPcNrCVR2ctCv4TLjHN
         4Cta4l3SUfF1ECTLxYif5KCKSs4gnCpAcL18j6AEA2qFqowD1p9bJve0BFiEbdulz6WF
         V9qwyCLgbRLyMC315qnMKCY7oF0nVsyEK5xHbvhZo+L8ZDthSXoxkaAuYPs3c8JSiD5i
         rKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781616336; x=1782221136;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rBh3T8DiAUTzySoFqHErLUnRhZqyPc5fESGPTvCXENU=;
        b=h6G4FYdMdh1Q5GzUjIa7C9Y85hlSNrrSiwytPvl/To1FEa5HDDwWFS0tEB2kUT1NXR
         8zxZ/5Xo7K6wMIHIHakmqiAR9T7kf/tbI7fRnTCQEFuOXvi5zV/U8xc1A0NUjE26/3PZ
         Qi0mM6VhtVCwNeNFGnip4EvK3+m6YfZ5lXFTfuT6CiiSTg/J6kOjA/E+OqYP80ULqOUq
         nJLqAs1+WsY5aqjQl8A6IeRDjOhcbFuggtgS0malYV1NKelcZWVqyqlt2awd3DiJ0wsq
         w9d9RebjUo5cAvbppw4SA7/y1d1neFUPpzvr2a3AyNS1bhL+ko7gFmCydytJxfaNjk1o
         iKFQ==
X-Forwarded-Encrypted: i=1; AFNElJ857Ki4nZx55LvwCzFc3JgHCu3tCjltNLefhHxYntA3ZDhQ4iiqaue+UpYaAOzhBsmElFGo4vCcqjM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz6FkOxgAeGSG986w0b9EZbBJWP7S1H82FX5Tx2ANU4Yp/eSnmd
	QioAA4POZOvUfP3CubzgnDBm5zTsCw+zio4AHCPK+7RccIqrULeynQ4b
X-Gm-Gg: Acq92OH/cB2g8oY5dXScXUmS76g6ajSFGd3Q19E6MqcMJeWHz6TAmEgIEv9oqnVSGn9
	sHkDi1AisxQymlmAkJhJ/T2Fw1q2EFGAsIBlF29oGKMUob7fhH/2QqZoDpJbfvoRa6+cr41Xy0c
	O62RNcf3fMpfiTYjcCgHMtRLvC+gA418jUZlFsGOH78H6DcICIAE6Fpchsdyf1xBk2CEpE91R5d
	YcLTDykWEQEzpOLQ5/nN/jO3M5kdfKEO86ULwcbHqtYx1UmHM1nq6aGgFHlRCPlZrzgOkYLvzAv
	nuvYhytbLXdAVnC8n92dDGDMfxHbIyQRl89ohrLVPSBot1w5LyVu5pc+uRJEloA1k4slGKvI7lh
	xjLty7NRVoKfmOjQwevK4qd/W1+Tf9PJ3hkr1aC+DawsgWsVXQ28tdfsie8G7O/v8py7dzIKSQO
	ihkKyOv/H7x1ybh9ZDUKGKokjSZolb1G5zsYRy0tEMbOR+ciqS
X-Received: by 2002:a05:6a00:4fc8:b0:841:edb9:4ea2 with SMTP id d2e1a72fcca58-8451561d852mr3340064b3a.32.1781616335757;
        Tue, 16 Jun 2026 06:25:35 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434b046911sm13105079b3a.53.2026.06.16.06.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:25:35 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Tue, 16 Jun 2026 18:55:20 +0530
Subject: [PATCH 1/3] iio: hid-sensor-temperature: use u32 instead of
 unsigned int
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260616-16-jun-hid-iio-u32-api-type-v1-1-952c74195f46@gmail.com>
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
 drivers/iio/temperature/hid-sensor-temperature.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..a8d3a15f9c53 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -125,7 +125,7 @@ static const struct iio_info temperature_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, void *pdev)
+				u32 usage_id, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct temperature_state *temp_st = iio_priv(indio_dev);
@@ -140,7 +140,7 @@ static int temperature_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned int usage_id, size_t raw_len,
+				u32 usage_id, size_t raw_len,
 				char *raw_data, void *pdev)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
@@ -159,7 +159,7 @@ static int temperature_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int temperature_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned int usage_id,
+				u32 usage_id,
 				struct temperature_state *st)
 {
 	int ret;

-- 
2.34.1

