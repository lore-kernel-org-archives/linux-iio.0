Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F4F33BED30
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360590; cv=none; b=PNwrpzatSUSoPhNhQy90xK1DWRXMC2gYwZ/h0yWhettH0SvQwvYp4ESj50ldmfLOMEo5DfQpuDR510FRGgeSj8CJsNCtMWjAeZALicb+aYHYQoF1sYf/5ScvDmJG/w56UlsYrgCX2FNEWM2oNyY03MmeN4ujk+PJDxk7g1v9MV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360590; c=relaxed/simple;
	bh=GcfKUhA9sUCH/m9Qy49VZDRVp9ZkTdbtacQbAQFjBGs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fabx0Z0eVb8xOUkIFGGyXRPVbKjzXMBgakkUcnNPDBwBmOwfoz75iAfqHT4lSqv9MkFKMBjKslooT4aaMqcmYCK9qFmiR29jhVNrKXAxMIuRAcNjaSYKWM69l1RJJDUmG00PmGrQCqqnWJvxNhO5Ofnn2keDzsPSTvotu9FdnGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=oeCtA688; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oeCtA688"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-82f4a53ae20so8080535b3a.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360588; x=1777965388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4SSYhf4HLOqy0avoXIi70zEszKa6ZWlWDxXxbtQNr6o=;
        b=oeCtA688sitlJZXH3fhzWn0GoNL1vAaISDM3T1QfaNu5Lbm31CgpHjYDdxwVAL+f5b
         ktekRqpQM/26MwFPGIlIfRiCqEEzj6fETkVm4o2o7AGoiRIxjGO0WD1kJ6ZoaiIDRKb2
         OhQwA2ppzp81/07H0EC1aQu4vHABthRm63YKG1uPk+1a/ZinK5l2K08dYOxHfkz44h/e
         0NQJjz6ohuIYOLshjpg8TZeUZta7RfxHlCSExKcYtJDWbj8Z0wwaxxfai2OwGx90snMT
         3GGaQF2qvsEr8hvLHMlCCfsKwaD6mcWQAT2d5lOigy3IubI1EHBO9wcOcE+n78jlONLB
         PMOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360588; x=1777965388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4SSYhf4HLOqy0avoXIi70zEszKa6ZWlWDxXxbtQNr6o=;
        b=q4/vpEXOZh8f3XG2waznPE0/zfM7Ca1PCLhvC4J5rg2gl9XVdfOEEDnK0LaTmNt/Ii
         H8xRxADrum7gJZptTqm39TcLiniRTnzS27s6cWJnOd4zqF7epX/X+LLGbRgFq3bvh4wJ
         XDuXNBq8pSbmkbqcuYibYP/WrmOIT3D+62fYSxpeAwvUjCkzdB4193M4Jlw4zzIvcmEE
         kizUzCvyI/SRNKoaWR1i9u1625MfDyfQjWm3ltz2yTGdoCKu03y/5CD3laxw6vFwJAMO
         FGUY/IL60JoWqRc3UkDAtDjuGjgsK+hBSmZ5tU53RCvDIPl1vVcRz0eQ7AWPeFKjox9n
         lEXw==
X-Forwarded-Encrypted: i=1; AFNElJ/YT8YIZMk8yGZi1yRcF6rjfFgRWASe7dC5jQoUzuBKbB26V68mLFCK9Dj9+G+yshPl95PKT3Ayswg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyF3FKSOcbJGVb5AAAbHEOlqyjbPVPouBphsxToGKDQKlRi8vFw
	a3ni6jNjp3VX/DhLO0CYMIxbz5z4Tt6ffIfX8O8M2zTOttfkO0PON7iZ
X-Gm-Gg: AeBDieuwOkNCUYEailh46QlS49RqV0s4TNO/ghOzjFi+gcWx8xPH+B4/tVcq1XoMxPH
	0OX0nW4gHfdgul64qMq858jI3b0C29f4nkkyFSqivFYZaa8r06NXVfxUyQ8HY+AoaZ1KwYSmwKQ
	/ecuUZmDu+ufdhk+iKgpEPoam4gaFTSiSOHF1Tj+6/FNoaDiYoUx1R3pwIF2dITUHS62GAfHLy8
	dsIIol3ibE05Ec6O8yoLmqN4n9qT+j5LFZunr07/lLhl3IrkRplDQjKxl4VezebItlclf8/jcHL
	bLtak69lNpJeCK7+pSPsGzfno/+QFnzcloUV1BOlaiOKWf1c10g3u7bW1Qrsgi02aT/EzlJutmX
	P6IAqgawcWOfP53O2KMN0168ZNZ2GE2Z9HLcuza7uERvW3pj8qdsRnswQvjNq6GQYYkp2C9u4IS
	rMe6fHwC5ZpGo/koooDwhw98h+dLY7IQ/6FClaGOk6APKjD3V5vCofm/2vbFk=
X-Received: by 2002:a05:6a00:4094:b0:82c:e0d7:268b with SMTP id d2e1a72fcca58-834ddc2d692mr2132239b3a.23.1777360587812;
        Tue, 28 Apr 2026 00:16:27 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:27 -0700 (PDT)
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
Subject: [PATCH 02/10] iio: orientation: adapt to hid_sensor_remove_trigger() API change
Date: Tue, 28 Apr 2026 12:46:05 +0530
Message-Id: <20260428071613.1134053-3-sanjayembedded@gmail.com>
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
 drivers/iio/orientation/hid-sensor-incl-3d.c  | 4 ++--
 drivers/iio/orientation/hid-sensor-rotation.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/orientation/hid-sensor-incl-3d.c b/drivers/iio/orientation/hid-sensor-incl-3d.c
index 4e23a598a3fb..56fd9c53dfc2 100644
--- a/drivers/iio/orientation/hid-sensor-incl-3d.c
+++ b/drivers/iio/orientation/hid-sensor-incl-3d.c
@@ -378,7 +378,7 @@ static int hid_incl_3d_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
+	hid_sensor_remove_trigger(&incl_state->common_attributes);
 	return ret;
 }
 
@@ -391,7 +391,7 @@ static void hid_incl_3d_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, HID_USAGE_SENSOR_INCLINOMETER_3D);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &incl_state->common_attributes);
+	hid_sensor_remove_trigger(&incl_state->common_attributes);
 }
 
 static const struct platform_device_id hid_incl_3d_ids[] = {
diff --git a/drivers/iio/orientation/hid-sensor-rotation.c b/drivers/iio/orientation/hid-sensor-rotation.c
index 4a11e4555099..56fdb3412fe3 100644
--- a/drivers/iio/orientation/hid-sensor-rotation.c
+++ b/drivers/iio/orientation/hid-sensor-rotation.c
@@ -353,7 +353,7 @@ static int hid_dev_rot_probe(struct platform_device *pdev)
 error_iio_unreg:
 	iio_device_unregister(indio_dev);
 error_remove_trigger:
-	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
+	hid_sensor_remove_trigger(&rot_state->common_attributes);
 	return ret;
 }
 
@@ -366,7 +366,7 @@ static void hid_dev_rot_remove(struct platform_device *pdev)
 
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 	iio_device_unregister(indio_dev);
-	hid_sensor_remove_trigger(indio_dev, &rot_state->common_attributes);
+	hid_sensor_remove_trigger(&rot_state->common_attributes);
 }
 
 static const struct platform_device_id hid_dev_rot_ids[] = {
-- 
2.34.1

