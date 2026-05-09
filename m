Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 205B239EF2A
	for <linux-iio@vger.kernel.org>; Sat,  9 May 2026 10:11:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778321465; cv=none; b=O2664uHMelssHiWupveSeNbvZ2KAAnD6E7rvFxz3FTqWUrg30S173PY43KDcr1ATEK4l1YmaHqLWenr37Nq3va43f4skLn2KpdrW4YMAd8U3jkqMC04MjcdOXHfJFgz7pf7R2qh63BYiqK7ek/LVoacbjC7PHEwBYdE6Qv0XIjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778321465; c=relaxed/simple;
	bh=fePoKQCdmGQ5iCsHGCBYd3YJit6qtCw4gWlQYUfsjL8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ryL/TboVRCaGFbtGpx1ZZCXfi0NW/OFYWeIHFow18EuRxM2bxAHFgEgFMqEgHB+zXg+lV06ZxAxuPasFPSAZD0zXEhIAEK2y9NaewSZHqyOCmMseVKZ26A44unYFVZpE3kul6k23KM4yEPCac0L1+4Cj+a+tEhSFAOQwbV4dkDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HJmqrtHU; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJmqrtHU"
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2ba1e9d3687so17840075ad.3
        for <linux-iio@vger.kernel.org>; Sat, 09 May 2026 03:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778321463; x=1778926263; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cOHJqaTcF1+fILni7WOWN2idwKhjTJof5YlmSEOsQy0=;
        b=HJmqrtHUT98sbXStBPPsJRo+/iuIgJRV+dV7ta3ywwzsORubxNeGsOooEU3Ad+dmDn
         /05+i/rCkhYzxu9P40O7iyjXN2q++/ZfN5uWkSHOh0TJhY+NKJ6K0KWYpzhbok03QWgc
         ks4fFaOozG2vkxoB27FXOKqT+hlhSKCLsxXkxcNaeyfBpJcz6b+FAW9HMnBVsOMTFH2C
         0SD4OOzX4qg6jiKUeAHpwid4BhtrLXBzKzO+bwjh219E5OG0W6yzcbUiEh4YiFRGFzlB
         WIwVcJD5xb1+D96dgPKx9ooKTzRnQyu9tbkAKOngpeKo8aR0aY6ywV8nScaA3McGnEAw
         g1NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778321463; x=1778926263;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cOHJqaTcF1+fILni7WOWN2idwKhjTJof5YlmSEOsQy0=;
        b=mooPcpv4sy6aCRFIxiYQmXPWM8h/X2kLp885fChrNr2z81lwN0s6a9ysxitz1sgZXP
         PtAmiV/uAOypGLxHn8VTVjSTFdQbthtfjiG+qFRWC4g/6EhgIbmkqIjTOevndI6Hz7Hf
         Oi7s4otY+b2LgkKZ6RUYyyqgxggQlGkrL+qi7PlS5gutlNUuL2Kz8NpMnzS+rfwAJ39B
         abjpRXto/Fg/vvDNGM34aNie8/KMS8XwumlVcpIAAm9lxDczrUEhM0oUH+U7UAgnH3BL
         33HbcvULmNDXFsPrwx3Hti4caNsOXTGeK5hBpxLT0HIu2wO7vbJ2j7Lu3OntTNT8m7sd
         GZxA==
X-Forwarded-Encrypted: i=1; AFNElJ8A/tlYyAL0ijv5f87NhDKniUn4jaWp020tg7g/8/B3EuKmJs4KuI6Al3rKpgTEyZciv48I8FaNr1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfcV79i2IJ3Zh3Grc4adJOdCI7iMSkpOO2flznLDSsoq0PoniN
	ctNumgOV2i2jWGXagM26PJwFtqrSFIvy6/oPK/Xl4hNtoqTtLJNJC5il
X-Gm-Gg: Acq92OF6rc9NE60jI9bhw8jOHX+u6LRkBKvDvmMbJM/0n1N5cUcloxTLBif+IkG7skn
	oeVlsik+jtv3qmOTgrqBPJirSMWE4RiG4u369e2JoDjP+/OJYLPW/62jljX92xsYIsnDkSKW4Rt
	uleIzf+ewVYmD6LUMGaIpHau1322EG4OntpmTbfvFIInvI5UrpC14J8X8AH4gciFwMzdGsSn1Hz
	Hucp/ps3hm5cNp5FFFPSNjgDsRD25swau2f8oT1CUPRpKZBCXP1FU6qLGkq6uih/LqhhiyMywhk
	K4CW3EYN73Ea/GXMfGTGopsaSenKY5WGt9bNAFi/klv2iv/O5RYpA/s64M+PB/cf3Zky72yI3jo
	wgPsUN+YjkObSJpoUvjr4TjrCqw1fNuDyZDOHoec7r0RXaZzNnG9ruBXSTqJvtK8n38+3mHIrjd
	OWX3nSgjsbIg7i7j+UvLeioD7MxFdBAuuei1cTjuPsdm6YaZ7elenkrsvSEOE=
X-Received: by 2002:a17:903:1b50:b0:2b2:42da:25c4 with SMTP id d9443c01a7336-2ba794bf96emr162194595ad.14.1778321463470;
        Sat, 09 May 2026 03:11:03 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2baf1e83084sm47335365ad.61.2026.05.09.03.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 03:11:03 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sanjayembeddedse@gmail.com,
	sakari.ailus@linux.intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/9] iio: gyro: hid-sensor-gyro-3d: cleanup codestyle warning
Date: Sat,  9 May 2026 15:40:35 +0530
Message-Id: <20260509101040.791404-5-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260509101040.791404-1-sanjayembedded@gmail.com>
References: <20260509101040.791404-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Reported by checkpatch:
FILE: drivers/iio/gyro/hid-sensor-gyro-3d.c

WARNING: Prefer 'unsigned int' to bare use of 'unsigned'
+                               unsigned usage_id,

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/gyro/hid-sensor-gyro-3d.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/gyro/hid-sensor-gyro-3d.c b/drivers/iio/gyro/hid-sensor-gyro-3d.c
index fe663b19e902..87537f9c58fb 100644
--- a/drivers/iio/gyro/hid-sensor-gyro-3d.c
+++ b/drivers/iio/gyro/hid-sensor-gyro-3d.c
@@ -187,7 +187,7 @@ static const struct iio_info gyro_3d_info = {
 
 /* Callback handler to send event after all samples are received and captured */
 static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				void *priv)
 {
 	struct iio_dev *indio_dev = platform_get_drvdata(priv);
@@ -209,7 +209,7 @@ static int gyro_3d_proc_event(struct hid_sensor_hub_device *hsdev,
 
 /* Capture samples in local storage */
 static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
-				unsigned usage_id,
+				unsigned int usage_id,
 				size_t raw_len, char *raw_data,
 				void *priv)
 {
@@ -244,7 +244,7 @@ static int gyro_3d_capture_sample(struct hid_sensor_hub_device *hsdev,
 static int gyro_3d_parse_report(struct platform_device *pdev,
 				struct hid_sensor_hub_device *hsdev,
 				struct iio_chan_spec *channels,
-				unsigned usage_id,
+				unsigned int usage_id,
 				struct gyro_3d_state *st)
 {
 	int ret;
-- 
2.34.1

