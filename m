Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBBA72AD00
	for <linux-iio@vger.kernel.org>; Mon, 22 Jun 2026 05:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782105704; cv=none; b=pvYJ8OPmwuLopnNwNT0EnSJ1UwV/ONDEwRBfSgYqqWlWMUxPuaSPbAGrSud0b7LN+WtGVHJvC0yFrSxNRtD22JYQDKHz1dOxZNVYaQiOD6uVkevyRnvnV064Tce0xmh6pWLkt5KVrgDh1jiKItfcLQzFFWnZBJ9PU7H4//YCHXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782105704; c=relaxed/simple;
	bh=BCpdxMp13MWmpuNuhom36/A72/T44xS2dimSXBcYIZA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=iewFgfR6ms9B80HxEph0aDylIAUx0bPZgpgsdYFCatAw5xj/u6TWE5C0oosIJN07d3ZEkIkwqeuKh64+4zPzGTwgBwtA0bSrjvZRvPq2/MP/muzOoLMmx3ESxibJf3X6OGs6tX+dfuuEIt2Sq0VehX5Zc10TuU8KzXq3ZCKQ4cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=knl5OBDh; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="knl5OBDh"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-36b9ec98144so2647880a91.1
        for <linux-iio@vger.kernel.org>; Sun, 21 Jun 2026 22:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782105701; x=1782710501; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=cuk3e9Q9B2r4SSDnaS5qw6ILcFjwSZa+lRAcxCF+p+c=;
        b=knl5OBDhpydRo0TryTR34snEnXDdt4XDWdOQz4IMeHYFLPw/PpBeIq1H7MnvTEYAk6
         bu8qUdwauJwSv/oKnw2O16tD5rbupY/l0GsqYzlr0WCk/oHuKuj2IBB9GAzxFdy/n3PN
         b4+tJIkYiEMzJMrR0c3bH//CiDjav6dspU7ILbQf9RJcqCDMebYf5eDhGsEwUOf6/gfA
         nl0B1wAViOlJsytFkTf0+AhmepncplDn02sOS8hbt3JcdVvpec6cH0xo1YN28ZTI0dyO
         EQKoOKE3CGYUMOC0m0NRo73JyssOFqyCpXRO/wGDRfg02O9fMw6bjAl3VhZ7oJiExSfS
         TJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782105701; x=1782710501;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cuk3e9Q9B2r4SSDnaS5qw6ILcFjwSZa+lRAcxCF+p+c=;
        b=ahQSiSM75XR/fB4CHShRKMFzGsC0wjk2vpTEI5tXLCQZ2N8d3DoxP/yozqSH5rVglv
         QwLC5Azma9AqybsOHSNflr9LGm6mstRv5xnmadz9J7cRcD94Tm9uoSZUFGQ2k7N1HTRE
         FHBKjHHZMik6WZinKzXZuPro/Sia9WM3x/80cy/kpGjjyJ8PEo/RJkUczXDVTTcpOKue
         Z0VU274ugs4Wvot4aWDJ1wV4bwY5hct8lQQL+IOSUp2vK2/1gaACWj2nz3Ex+fo5npnY
         7/tGxzYuG9TDRhJunMHtIq3wlQ8nfcZUQA/X+G6Wi753NPSufP80VUxDTYpeHUN3Y9Xj
         qJgw==
X-Forwarded-Encrypted: i=1; AHgh+Rr7oNZsKfy2QY/kJs+Or63f+mmoPhDTYTxPkLBcGep7G/yN0AsHkJjHdRmHmmbk/9WeNdemijC7aKc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzfqu9YlI9abqU835Dh7XWImtiN8/npmOwVxBUu01MtkjV2Hrdn
	99SDI2LjXuWhLgmMZ3U3jrVmI3YXuobt3X/z0DRkuEJJMt2IQes3HPFw
X-Gm-Gg: AfdE7cmxMPAdExQUd+Tg8X9XBS2g30e8qk7nVqRlS295Zct9J+vtUF3IKvfW8XfgWof
	4rIfL4SaWwOzz9yrJUQ95vyRa35R6u/GOu8ZiMcB1wzkM5yJW6AOiXNPxPVB50qKFUt89c3VUHi
	urDjo0lTRSWSzI4xlUznxaZyTqzUPoSEqC/bI05jG/tMSTi01akhSbr8cbhhYoXlxzvh2gDBXLj
	DQC8cPegSwZBqPm+XKHRVSffqp3WdwnCbqfrEvPmYpf1eUDaJ6aAWGePw/Zanv/kLDbmk5NlT8q
	4GHTaIulUvJ9idbnQ6p7/AyEs6sGj5xCBRtC7vs8EIg/zzrIV5x207YmvIHNqSgjIaeo/c5S+1k
	95QzqeUL+bQ9+qgwmg1qwgmkOpAThS9fh6fbD9lI1En6RbyVIJNoXYAEjO/lWsFRGgwlRKCQtNl
	rsxk58i6vHno0rgYMYE8Fy1Zw24C4/zUDI4D2dpw==
X-Received: by 2002:a17:902:f652:b0:2c6:db18:ae3a with SMTP id d9443c01a7336-2c7423d62d4mr102798665ad.9.1782105701126;
        Sun, 21 Jun 2026 22:21:41 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c7444aad99sm73455275ad.80.2026.06.21.22.21.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 21 Jun 2026 22:21:40 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	hongyan.song@intel.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] iio: temperature: hid-sensor-temperature: switch to non-devm iio_device_register()
Date: Mon, 22 Jun 2026 10:51:35 +0530
Message-Id: <20260622052135.1804135-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Avoid using devm_iio_device_register(), as this driver requires explicit
error handling and teardown ordering.

Mixing devm_* APIs with goto-based error unwinding breaks the expected
LIFO resource release model and can introduce race windows during device
removal. In particular, the IIO device may remain visible to userspace
while dependent resources are already being freed, potentially leading
to use-after-free issues.

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
--

