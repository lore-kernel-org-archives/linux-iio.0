Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621BE2E7363
	for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 10:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780051507; cv=none; b=lTs+2ijiLX6oN4aJlZn7v7JWYyn4/VwunPDKVPhoRYZwH+eU01XsOvOLuUvIsW4p8p8wK+UFcbojkk2mBRYckaT6FlW/EaarkiXwKXVPsAg0JFHxe7hwvL8Z7opaSIJHyGEA4WkNtvmprydCttVP6se/z4y6YLxagAdif0VskbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780051507; c=relaxed/simple;
	bh=5XrUAZCKALQ/K4rRj3UilL1pQnTEhw7pp2RKetgAPLA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hcC6NPjLw2iJT3RSKLK+YF27WCQs1P3KjIdBzPYgJrFRDvtJfYyYI1NaOH2W0yOrKoiGfEUSGyHxT896XJGnEc4J8lUj9zn6s9EhBHhaOUMZhu3fcrnsSWtvBOXVR+ry8mcbE0PM5AVLmVXzZ31Wq7vBsmxuvvPtS+w6HxeF/eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z5pfW7j4; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z5pfW7j4"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5a8e3849de7so1528449e87.1
        for <linux-iio@vger.kernel.org>; Fri, 29 May 2026 03:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780051504; x=1780656304; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=f285livwfibfPOpeihvBsAwaP3ma2vuk5i0MORNhkXI=;
        b=Z5pfW7j4eDTLaTpwVN8iQ2P19de4O550ngFjJdwqI60Vntfa6OrTIPuz/4n66XWkr8
         EqDJbQ5q88+hX90fTRnyJKw+cCWgpL/v0NmQio1aRNvjkcgEnrrcMEI0o9At2lSuDsvB
         8llsZLsShq30TpTiSyv1wEozTgWrvsi0NjiwAVHLgXPACzQ68ZTZfOHs9ixT1VQtDHsA
         8+EWRyW37ZlCOSYOkkroiQR+no10/UPY1+E2mSdlxeIwkPOz0ahcJgZaB9/Q4kSq8Ji/
         9UlhBC3lNZBN9049MuxpjUjfH+/ZD8E23eDFxP2AjvZuq43swwM6HCnzuPhGTWhSARbf
         LhBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780051504; x=1780656304;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f285livwfibfPOpeihvBsAwaP3ma2vuk5i0MORNhkXI=;
        b=b3fC5iyWQD9zYr9iia/2lJtjlSYXzVPA9YPk9kKO/vL/Bo7sOHwZoFAzsy9XIemzdt
         TtVv8pAsL2WXnKNMwGxMFFPuNs//kc8kJERPivZbl0qcZp4ujHChKa61cnsYTXX0LHzJ
         15r0JWj4PzzivYznNdaJV/lb1pjKSSjWv1mD4A8marpGwPkfxBkN3QetCqQi/zlvhb6h
         UGVFrp0xsfA70ujpcoX4xkVSF1YrKGYJWUTxsZiK63hi0/v1GLtTvE28zPb2oHwTn/mT
         5s1ri9Qh016u7xXZ6INYzdGebO8r7K31BwZJBhjToOWXNuhxJOTdf5V0fpybqoHRCaZI
         9cqQ==
X-Forwarded-Encrypted: i=1; AFNElJ+5aV52H7/pY5aI6qjz+siKmB8RN65WVCE2xz1ngj94+yNVwddBtgwKnfMzHeIyZJ4b3HFlYLkpuQM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoIHQr0ngAjR2NLp3yMa5c4QaP7SjkO8T/TcTPnNd3MK18ECp+
	vrA16JrP2h19H5fFI7S20wpnOJw1PpN49xR7FKO0ceoBdkgqvjUbMCqF
X-Gm-Gg: Acq92OGdj9+Cxa9WtgAYo8Hckv57Dgd9eENmRpBDGyaVy4vPDyX2u6QzoMbcfYsbapa
	+BngxwidwSS4JprM/rA8LMFgIiHRX1qH+wy6Hdr32Fahd4DYisyOCHN9gkl5E7w+mW3uz/RoqlJ
	JIzMH/lzHz9VXpxhIZJldiRHQERoVGs6grzg3udMQnGh68oM8EpsrYhvVuhCsJQILmZ2cdM8s72
	N5sHQ/GmenIZXghCzfwdeEYabrWnTI+wqefMU6m+32by5Q7KsO2ta0bzMipJU7yhFWn1zQD/Ac3
	50pG7BJKKIT9jisZEnK61KXikix5Z5TpUHCPWA54XFYARMpVKdXg0J3wDYD822OTfw88VD/rm5X
	29hrxn17Rwx8TUvTVMaAkbg2mNNEnHx4PGkGcDzxeNX7NI7whceEie4PqSoAQOOkQs0fDG26Mqo
	WQFkeXeydAkzuZV19q1WDiPH023yl+D7eZLaafSPPOyx2i70aBkSqpez6HXotqaH3S3Q==
X-Received: by 2002:a05:6512:3a8a:b0:5a8:847a:dee2 with SMTP id 2adb3069b0e04-5aa5949d066mr324254e87.3.1780051504319;
        Fri, 29 May 2026 03:45:04 -0700 (PDT)
Received: from localhost.localdomain ([94.158.61.193])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa5b071d25sm205269e87.18.2026.05.29.03.45.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2026 03:45:02 -0700 (PDT)
From: Stepan Ionichev <sozdayvek@gmail.com>
To: jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] iio: fix PM-enable leak on probe error path across 4 drivers
Date: Fri, 29 May 2026 15:44:52 +0500
Message-Id: <cover.1780050609.git.sozdayvek@gmail.com>
X-Mailer: git-send-email 2.33.0.windows.2
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series fixes a class of runtime PM enable_count leaks on probe error
paths across drivers/iio/.

Each affected driver calls pm_runtime_enable() in probe and then a non-devm
registration function (typically iio_device_register()).  When the
registration fails the probe returns directly without calling
pm_runtime_disable(); on subsequent probe/rebind the runtime PM tracking
complains about an unbalanced enable.

The fix is the same in each driver: replace pm_runtime_enable() with
devm_pm_runtime_enable() and drop the now-redundant pm_runtime_disable()
and pm_runtime_set_suspended() calls in the .remove() callback.  The devm
action runs after .remove() and handles the teardown.

drivers/iio/adc/ti-ads1015.c was posted as a standalone patch earlier:
https://lore.kernel.org/all/20260529101011.3030-1-sozdayvek@gmail.com/

A separate follow-up will cover four more drivers (apds9960, mma8452,
pa12203001, us5182d) where the same leak exists but the probe error
path needs a goto to the existing manual cleanup label rather than a
plain return.

Stepan Ionichev (4):
  iio: light: isl29028: use devm_pm_runtime_enable() to fix probe error
    path
  iio: light: tsl2583: use devm_pm_runtime_enable() to fix probe error
    path
  iio: temperature: mlx90614: use devm_pm_runtime_enable() to fix probe
    error path
  iio: accel: bmi088-accel: use devm_pm_runtime_enable() to fix probe
    error path

 drivers/iio/accel/bmi088-accel-core.c | 6 +++---
 drivers/iio/light/isl29028.c          | 7 +++----
 drivers/iio/light/tsl2583.c           | 6 +++---
 drivers/iio/temperature/mlx90614.c    | 6 +++---
 4 files changed, 12 insertions(+), 13 deletions(-)


base-commit: 7cb1c5b32a2bfde961fff8d5204526b609bcb30a
-- 
2.43.0

