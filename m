Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4531126C17
	for <linux-iio@vger.kernel.org>; Sat,  6 Jun 2026 11:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780745881; cv=none; b=gyPBQakbUiLzaqN4vC6lQ1Eayx2m4+QnbRnFudS0go57smu538z30pa8Wji1SEkRUSD4NryfobKpXjUtc0E90kAriyVBiYXB1DMIBYA3xt6nZ/bnWoOPSVyKTSm5vEmWoVwyvJ2BU73uTLGBklbe8LhTJ6NnO88+YBn7j1HPCMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780745881; c=relaxed/simple;
	bh=PdUKDn3SU2eJys++eOMc7I+5A6p9MCo6ZvhZceIqZWg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=rBZMHFVugvCeI5VYYaOZekfiIbHLHhmWeUT+K2lkh8niBTkht8mlq1USjk3sH2SvSyNjIahGXOW0CdsgGZKsApI7dq3eXHP0bytgp1Gx/PifyYLuTNGiu/uzaB4dL4Mb9RAdRJqeXWfSbe8QDm5mpglJVBEF5NCYWmOIjc6EL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VqjJR3/j; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VqjJR3/j"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-36d98b68d68so1997293a91.2
        for <linux-iio@vger.kernel.org>; Sat, 06 Jun 2026 04:38:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780745880; x=1781350680; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HWSBV5t7vgvzy5zfpTiogfYypqNTbSS/3Dq6vr9fHyg=;
        b=VqjJR3/j2Tfrd6YUdIrUSHIG5wkOORUZYKJQUlj4mEYiiHx9O0SJ/J1dRGnlJpTbw7
         VWcIUipedQFTp8znqFIXGXgw6GlB8BGcCymZyvEW5g4m6UpPrs6PD5pEI3D/y+nsDpyv
         Rzt1EzOtf7JDBxUyRHkJOvwnS2jbsv2ZHW8QywFqfqlemvEoqacgt9gSDS8zALr0UNIv
         ozHNu+eI8Qd3HVgDrhgwiT7tLXHelwqB6BSj/+1ZKXE4SUU29sKfNe1Lu1yioMTDNeFd
         XJozQ2ooSsSoT64nJPVFXPr6tuRBwDopBFDFBY4P/XatrCgbiXMuadCf6uqdZg/Diyrj
         kYfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780745880; x=1781350680;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HWSBV5t7vgvzy5zfpTiogfYypqNTbSS/3Dq6vr9fHyg=;
        b=H7Rla7KWeLHwYeb9GY31vrhSrKQiQnRj3laKkcbVdVZV/YZLevEGPZcjPWP0AA/yKA
         uL4h64A5QwXaUmaCbFzPb8RHOsVBTee/rNZQB4iZGXvmWfT9PIeB35lZ97DZSehuolk0
         EMw4TP9qaibLsAOygcLsD2O4ZP6HNbLmxf64Jq0cnKBwj8oXW+tIVrjyZ2mlqRrQ6xxF
         wm3L1XVgc5Sr59fMrTcEL6axXZ1UXQh41rvvp8Nvjt/k3pUkUoVvwMrtrsjYdwibgorI
         uGUhWKALfnd2xwZq8xIaz3EVFE5ZNT561Gi5sD+QIn5GmVD3r0b9L1GPyKa14iQZEnKa
         pHlQ==
X-Forwarded-Encrypted: i=1; AFNElJ+TsYggEIP5SKZaXxijvL0daArj9qpQ2gbF3q0u7p+eIiF+cyXuzeAUQH0CWmBDJQgYHY02tG071LU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyR5BRRcoAyOdXZCA8jI8Fna3edVws4DvcVWaVtmgut97VRGynx
	oDfgyips/hWgd4MJyvGWKDQ0MZA79a4/sN8IZ1YfO+zcQcW0qsPLiLWu
X-Gm-Gg: Acq92OGMyFoDzGUaI0xpg+a5eeYKdshyxuBeQ49qWjJxKp4e+U/FbCocFdLQTSX1Qjq
	JeeZoBqpcjolDtN5UIm0GFPwtsUnJXt1IwTLy4mWT+DEb0ZsbGdiK8fuVnOZMMF6dqixT+9mG2Z
	ysM8H836JZ32BEgwvwBSzgs8mTpB4cQkDtjR/Bp2Mxleg/1QFQDNp2p2kpN13+5SHKEOaHa4fdA
	ZIHcbiiDHCCP7/7aN4CWN64Vtr+erp2HalavY2qgdq0n8GzBgZfPijoveFJJmlkPFhs4lNm16qJ
	8ilX2KLeKRd1nwBCcQvuLliA+yUR1Z613QRdwA8c+ijIDJpqbvAryvKB8XcmdyEiFCCQ3Um99R3
	mSedyPHfCqi4kU6Bdlqj0btTK/+2OrQrwBsCt0r0LwjEGAtXQdN7WstH15v5x5wE8PKie8/G5qL
	jdHZAcZY4tR7I/sW7dGxPjAGVEhfKcKX59fmvZobAtr3FUNtLnEplkVmSMxSA=
X-Received: by 2002:a17:90b:380a:b0:36b:b06c:30a1 with SMTP id 98e67ed59e1d1-370ee447ddemr8402142a91.1.1780745880167;
        Sat, 06 Jun 2026 04:38:00 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-371358615aesm3220830a91.2.2026.06.06.04.37.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Jun 2026 04:37:59 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
Date: Sat, 06 Jun 2026 17:07:14 +0530
Subject: [PATCH 5/9] iio: temperature: hid-sensor-temperature: switch to
 non-devm iio_device_register()
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260606-5-june-hid-iio-race-fixes-v1-5-27a848c5758f@gmail.com>
References: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
In-Reply-To: <20260606-5-june-hid-iio-race-fixes-v1-0-27a848c5758f@gmail.com>
To: Jiri Kosina <jikos@kernel.org>, Jonathan Cameron <jic23@kernel.org>, 
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, 
 David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>, 
 Archana Patni <archana.patni@linux.intel.com>, 
 Song Hongyan <hongyan.song@intel.com>
Cc: linux-input@vger.kernel.org, linux-iio@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 srinivas pandruvada <srinivas.pandruvada@intel.com>, 
 Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Mailer: b4 0.15.2

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid using devm_iio_device_register() as this driver requires explicit
error handling paths. Mixing devm_* APIs with goto-based unwinding
breaks the expected LIFO resource release model and may introduce race
windows during teardown, potentially leading to use-after-free issues.

Add explicit iio_device_unregister() call in the teardown path to ensure
deterministic cleanup and follow kernel resource management conventions.

Fixes: 59d0f2da3569 ("iio: hid: Add temperature sensor support")
Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/temperature/hid-sensor-temperature.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/temperature/hid-sensor-temperature.c b/drivers/iio/temperature/hid-sensor-temperature.c
index 9f628a8e5cfb..34bff7e9f3a3 100644
--- a/drivers/iio/temperature/hid-sensor-temperature.c
+++ b/drivers/iio/temperature/hid-sensor-temperature.c
@@ -244,7 +244,7 @@ static int hid_temperature_probe(struct platform_device *pdev)
 	if (ret)
 		goto error_remove_trigger;
 
-	ret = devm_iio_device_register(indio_dev->dev.parent, indio_dev);
+	ret = iio_device_register(indio_dev);
 	if (ret)
 		goto error_remove_callback;
 
@@ -264,6 +264,7 @@ static void hid_temperature_remove(struct platform_device *pdev)
 	struct iio_dev *indio_dev = platform_get_drvdata(pdev);
 	struct temperature_state *temp_st = iio_priv(indio_dev);
 
+	iio_device_unregister(indio_dev);
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_TEMPERATURE);
 	hid_sensor_remove_trigger(indio_dev, &temp_st->common_attributes);
 }

-- 
2.34.1

