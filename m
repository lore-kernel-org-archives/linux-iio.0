Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFFA43D47A6
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360614; cv=none; b=R7g7z+GLHkGl7K/TMawlHFwwcDuhj6+k0cZAoKciPB+Xr7CwrnQCz1i38xNQtyqw5a0kW89kG4FxYX0Ls2DzAbDF2OSQQxAAb9kin04wCkBMRqswW4cmPm7BIS2/g1TmFIc2d87izCOckuqKE5PJe+J2kM5/+j5UOTUCJQ6dYeo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360614; c=relaxed/simple;
	bh=jj0oKGMSJItbsfmBv49PEQMMzZmhENkSicxavbGihZk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EkfQVfRaqD4I+nVHa1Jc4Vy4++r3SxTGEQh4OPY44vA/IQLyT+mVoNQmZJadA5DFkyuNAW8XfYMnQTJcqta3peoPFsV9LZuBv4qbl2MayVuQnjIwTnFPYE5pVsdXjVB0NB8F3Ne9x6JAbmavsbQBqkAIFMR4ZL2P6bRPdUX5ZBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VzYXteKK; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VzYXteKK"
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82735a41920so4417853b3a.2
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360612; x=1777965412; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lyeuJKAlOIXJCmj0O+A4wW9kGaPEO/cRUvtuXdGiC48=;
        b=VzYXteKK78S9/oZIV5Kurp8xxOaj7VjyyWNi9Kt6Ma0jI+zoJtCBPJimbVbKQjz/mi
         kujhdZj6BdK+CCm2lxb3TImkAC3JZSDey879DAZozIh43O5Hu0y0n+xEjM2BKAmL7lKQ
         5PquKrpj/BlnKvsEi6FYe+xUN1g08dGBWUczM8NchEDomXGX7flt99+qLsopsRd9uw32
         RwVn3u4fUZSr46gy4MRMiu4PvS/5MN7iIsCEdE6qclTOaiuOgikVbL39J9CSBMbNPK8G
         R+N5HtyEklduaf8yV9MN+BiQ0R/BJrumOQJW0xfzvJ6kvOtNHUYeJmtNmlQwgxaiIuyG
         VMPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360612; x=1777965412;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lyeuJKAlOIXJCmj0O+A4wW9kGaPEO/cRUvtuXdGiC48=;
        b=IDxx3s6ADl67+9it7N6CZxkoOqSBn6puVAn1EBXE37xmyOedyLyNZOerjG4h9FdRcU
         TE68JqHjDAzwMvxyRUlqBH582QwlKgNenlCrIPgnwy+2MT9RgkkV1xLtBhz/520PRWku
         ANPT6hzYeCgAty1mpAehO/YqGecdJBJu046QqGFi5RG5qqEh3i7VAojn7YOg1wp0gHrA
         Bp6BtbZOI1e6Y6yp8Ms0wOxRtZ6I9miMazEyTiSluo+h858KqcHzDRk7/NGWD6rkN+S9
         yR7u1aNVwAt0DBp6zbUYfiX/AxzadyahwTRERfpKtC4B3VXvpp7p2fibyZyy/hk1/FGT
         Pxww==
X-Forwarded-Encrypted: i=1; AFNElJ9rpskU3fCjnvOZ7kwXQJmcmo6otu6GNK5UqHOcuN/pVm0t5NsVjE9Ih1J3Krc1+Tw1xvXj/JflyPc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMqmwUIek77tRf/B8I71hHbbQm1IYQeDGZt5APnQ9O2/457YnX
	C9uQMMpHFsHzICZA9gyPvYrWe37OXnob+u3kys8uYANzHBGSZOEsAiB+
X-Gm-Gg: AeBDietekxGm6ZstU5T8W55uxgLenVK7V68pAno2D1wqsSq1tIYIbnbYmUqiqALZwQn
	TbywcJCKTDbtC/tdySkr47geH3qzCz1IlnWqv7VK4e8GuD7KHUypS+PPaY8iswcWsauKZmSbn7o
	8v9dYZ+fmixZzHBjxontgTOxl+TEMCGnssBRPJZNPyvpSBUfEQyEImPMRNLlXR6ncVqyfurMhWV
	4BazwqCWxJwh4s6h+/oLEzziM1WseQwRxRwVLZbx2JPomeNn5avhlSG0zsZf3iGZZCYseqRDwS1
	ui04FZPSz2tKrR+2x2EWyDzq7CNPbcSwmWabEsFyltAVux0LQKfTk+RElgol23Pu33IgSUoVKgE
	V6W3JFPKA0JscXIvNuVFsoqzpDTco5Jh0exFUcnTtLmk9U/nkn0zPeyYL4vSARs4gWNPmOtYASK
	4RosESpZBHc5sjJNiJg2UDYjrWnhG4m4uyz7AQ/w4bW+XPKoWcQmmQDsSXfyQXLNqGwXxW7A==
X-Received: by 2002:a05:6a00:99f:b0:82c:ded1:261f with SMTP id d2e1a72fcca58-834ddbe7be7mr1926583b3a.27.1777360612421;
        Tue, 28 Apr 2026 00:16:52 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:52 -0700 (PDT)
From: Sanjay Chitroda <sanjayembeddedse@gmail.com>
X-Google-Original-From: Sanjay Chitroda <sanjayembedded@gmail.com>
To: jikos@kernel.org,
	jic23@kernel.org,
	srinivas.pandruvada@linux.intel.com
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	sakari.ailus@linux.intel.com,
	sanjayembeddedse@gmail.com,
	linux-input@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 08/10] iio: magnetometer: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:11 +0530
Message-Id: <20260428071613.1134053-9-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260428071613.1134053-1-sanjayembedded@gmail.com>
References: <20260428071613.1134053-1-sanjayembedded@gmail.com>
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Update the driver to match the updated hid_sensor_remove_trigger()
prototype, which no longer requires struct iio_dev.

Signed-off-by: Sanjay Chitroda <sanjayembeddedse@gmail.com>
---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/magnetometer/hid-sensor-magn-3d.c b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
index b01dd53eb100..8be3dfe4dd58 100644
--- a/drivers/iio/magnetometer/hid-sensor-magn-3d.c
+++ b/drivers/iio/magnetometer/hid-sensor-magn-3d.c
@@ -542,7 +542,7 @@ static int hid_magn_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 	return ret;
 }
 
@@ -555,7 +555,7 @@ static void hid_magn_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_COMPASS_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &magn_state->magn_flux_attributes);
+	hid_sensor_remove_trigger(&magn_state->magn_flux_attributes);
 }
 
 static const struct platform_device_id hid_magn_3d_ids[] = {
-- 
2.34.1

