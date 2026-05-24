Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D48FD3033E6
	for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 19:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779650470; cv=none; b=WdmEK4ZV38wl9bKb1Jo4DToaHZLqomg9LiYZ4St21jgNIdFO8luF/Xrig+ZqCTylVr0n/bCvOZ4csslBdd2G8hfsmmh8m4j6rNKF9Z1FfyRPt876Oc6lu1oTmqOo5zdNnIxQokTgh0LojRrIQ+tooQ8tDn6VrBw8+IwXYVTvYlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779650470; c=relaxed/simple;
	bh=3hMBMGYsZsIoB3ZnKY+/wKu1ld+B3eVxVXPDrNrmqtk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OkCv8AkchyZ7a+gHMAv+ruyI3dRAKXPJ4BKc2i8Eu8O4Ww5guTxmqx/vha9gsHhWR4JWneqP9ctv7hhOt0GEN+U6Efq+y34JBQpfhTQp6jktjhpUSYn+4nsJI8XnilIX/VqvTgvqSzrec73zMXS0ZKbmmZRdzaopVWUI/ood760=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gCSwu8jM; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gCSwu8jM"
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-83d5bbef760so3694750b3a.1
        for <linux-iio@vger.kernel.org>; Sun, 24 May 2026 12:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779650468; x=1780255268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dPqO9Ba6XGtFWc34qWTyk53wz9ueUFdVwtQK5XJuQvc=;
        b=gCSwu8jM5XezO/vOjoJMzn81SJysOb10HsEmOW/KRIun2q5XxzbqEj8cRDcq0TaIrj
         Obds9kT+5f5k81+m/GpbhRIG1e6dcVJx/IL037EUXKa+BsZEgbieeteZpy27vWAuqSQf
         C4WGEw85qPB6ru5ZWcGlHhoCElfnq20GwHSQPXr5GJwmB3LZxauWrpYxErka9OpWJUQF
         uuy3Xi3EyfVlElEMZ2nwkhgpxxb2omA7qVbbllzaTwW5k2xmQRpBL6SlsrXZktuGpII/
         6Y/mYEXbHzYu8MQg0phhvyHWC90gD+Y3SnwMKhjXQ95uCmFYmABVWr7dWS3q8aG8N5y9
         RQHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779650468; x=1780255268;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dPqO9Ba6XGtFWc34qWTyk53wz9ueUFdVwtQK5XJuQvc=;
        b=OE9QO1L9X5POSzPfeo+r07cGlm4BOo8aChJoQ7YzW/m9NKgXPZVeRSofPUhvxNBgvT
         1l5mcN2SBGRbPJkt/pyFcPi1X+BXqKjCe/OcAmjS+Es+rPOy+PBT0CIN9lMVGjyBKQeD
         Jn0L3xNFVDE8KIPdyI9+mcNwEfasWLq1teWZa6KqsdwSPigmb7LSlSl1JqXjxir6P65a
         uuS/U7zwol4uKaeMIvfudkij1yn0EKLKOcOPoPAikfAohTrnh7YYpB2QXnDQTHxWeA6J
         D6B0SYN38Jr7yzEYOFLOOyV9hs3VgBkm5uMLT8z5PQAr0tjkBuemBJoGhAQuM9zMgqL9
         f0Eg==
X-Forwarded-Encrypted: i=1; AFNElJ8CFDq1BICKri1D9rZrh1SpQki74viH241qtf2W+kLojONvtJB2H+caxvzhqNcNHlWNRvse94hsSS0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yztr18P/Rfg0L+jpA9nNn8M4MTQ7xUSHoTSEo+HM2Y5O8n0a7uu
	DqKkKd77q2dz4iH2S3Lk4fvWlBiuJ/TreG618axpyhQA/qJZM6jku4VJ
X-Gm-Gg: Acq92OFjhwmrO/BfGP+02500scEVEzl7afc3PHTfeiV7U5ezpL6Q3FCMyfFVgOC55OA
	F6mEn5yXiKDBiwsQpYPKzrTgfK03UOPh0VflUn+3Q3DzYMvm0urh6xe3T/VkLHdEky/1llyYM/6
	VgVU5e8UIuhvsB9gL7scZvy8MIUsbx2+NLOII9gMnzT6/TC5ZO6JG+gSfw35bRQiiRTk8FBzbSk
	L7sTNOITq6L4DUJ9xzb5YwYId1N1Zr+/tTGOB4p59x1AunEIYBQ2Nc40y2KAtAgtsntjSt7Oaaq
	y/2SGrC1RhOPcDFoCm5xw6pQCI/IdmTfUgUJWcHQPNAulo9EyI6ihv09MCKyxVXxvKp/sllQTAh
	OaxfWpJgFeNpNEF3z0SLLm1APEed4sRhfXFb1VyfXkvx1KUqjKtx1P7BNvZjr1lHSf646NnwKqZ
	jgQIXPNVWXYloXgB34T7DdHSkpRQoJKvhHjKVvYMMtCyM/p4NOsw4rvthcz90=
X-Received: by 2002:a05:6a00:ad8a:b0:82f:6e7:152d with SMTP id d2e1a72fcca58-8415f1a06fdmr10580518b3a.21.1779650467975;
        Sun, 24 May 2026 12:21:07 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164aed7c9sm8689973b3a.13.2026.05.24.12.21.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 May 2026 12:21:07 -0700 (PDT)
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
Subject: [PATCH v4 00/36] HID: iio: basic clean up and introduce devm_ API for HID sensors
Date: Mon, 25 May 2026 00:50:23 +0530
Message-Id: <20260524192059.1193716-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

Key highlights:
- 0000-0024: General cleanup and kernel few coding style fixes across HID IIO drivers
- 0025: Remove unused iio_dev argument from HID IIO sensor helper
- 0026: Introduce devm_hid_sensor_setup_trigger() device-managed API
- 0027-0036: Convert HID IIO sensor drivers to use the new devm-based trigger setup

changes in v4:
- Extend the series to cover remaining HID IIO drivers with devm API usage
- Reorder patches to place cleanup and warning fix at beginning and,
  devm-related changes toward the end based on feedback from David
- v3 series -> https://lore.kernel.org/all/20260509101040.791404-1-sanjayembedded@gmail.com/
changes in v3:
- Added cleanup and prepratory changes before adding devm_ API
  conversion based on self review: 0002, 0004, 0006, 0007 and 0008
- Address andy's review comment on commit message and coding style
- v2 series -> https://lore.kernel.org/all/20260429175918.2541914-1-sanjayembedded@gmail.com/
changes in v2:
- Following input from Jonathan and Andy, squash initial patch v1
  series in single change as individual change should not break anything
- Add devm API support and two driver using the same
- v1 series -> https://lore.kernel.org/all/20260428071613.1134053-1-sanjayembedded@gmail.com/

Testing:
  - Compiled with W=1 for each patch in series
  - Build-tested on QEMU x86_64

P.S.
- Sashiko reported an issue in a different driver and noted that it is not
  introduced by this series. I have taken this feedback into account and
  will address the actual issue in a separate series focus on that driver.
- Once this series is merged into the IIO tree, a number of HID IIO
  drivers will become available to fully converted to devm API usage.
- The changes are organized across drivers to keep similar modifications
  grouped together for consistency, making the series easier to review,
  rather than grouping all changes per driver.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (36):
  iio: hid-sensors: add missing blank line after declarations
  iio: gyro: hid-sensor-gyro-3d: use u32 instead of unsigned
  iio: accel: hid-sensor-accel-3d: use u32 instead of unsigned
  iio: light: hid-sensor-als: use u32 instead of unsigned
  iio: light: hid-sensor-prox: use u32 instead of unsigned
  iio: orientation: hid-sensor-incl-3d: use u32 instead of unsigned
  iio: orientation: hid-sensor-rotation: use u32 instead of unsigned
  iio: pressure: hid-sensor-press: use u32 instead of unsigned
  iio: humidity: hid-sensor-humidity: align parenthesis for readability
  iio: gyro: hid-sensor-gyro-3d: align parenthesis for readability
  iio: magnetometer: hid-sensor-magn-3d: align parenthesis for
    readability
  iio: humidity: hid-sensor-humidity: use common device for devres
  iio: position: hid-sensor-custom-intel-hinge: use common device for
    devres
  iio: temperature: hid-sensor-temperature: use common device for devres
  iio: humidity: hid-sensor-humidity: use local struct device
  iio: gyro: hid-sensor-gyro-3d: use local struct device
  iio: accel: hid-sensor-accel-3d: use local struct device
  iio: light: hid-sensor-als: use local struct device
  iio: light: hid-sensor-prox: use local struct device
  iio: magnetometer: hid-sensor-magn-3d: use local struct device
  iio: orientation: hid-sensor-incl-3d: use local struct device
  iio: orientation: hid-sensor-rotation: use local struct device
  iio: position: hid-sensor-custom-intel-hinge: use local struct device
  iio: pressure: hid-sensor-press: use local struct device
  iio: hid-sensors: remove unused iio_dev argument
  iio: hid-sensors: introduce device managed API
  iio: gyro: hid-sensor-gyro-3d: drop hid_sensor_remove_trigger() using
    devm API
  iio: humidity: hid-sensor-humidity: drop hid_sensor_remove_trigger()
    using devm API
  iio: light: hid-sensor-prox: drop hid_sensor_remove_trigger() using
    devm API
  iio: light: hid-sensor-als: drop hid_sensor_remove_trigger() using
    devm API
  iio: magnetometer: hid-sensor-magn-3d: drop
    hid_sensor_remove_trigger() using devm API
  iio: orientation: hid-sensor-incl-3d: drop hid_sensor_remove_trigger()
    using devm API
  iio: orientation: hid-sensor-rotation: drop
    hid_sensor_remove_trigger() using devm API
  iio: position: hid-sensor-custom-intel-hinge: drop
    hid_sensor_remove_trigger() using devm API
  iio: pressure: hid-sensor-press: drop hid_sensor_remove_trigger()
    using devm API
  iio: temperature: hid-sensor-temperature: drop
    hid_sensor_remove_trigger() using devm API

 drivers/iio/accel/hid-sensor-accel-3d.c       |  30 ++---
 .../common/hid-sensors/hid-sensor-trigger.c   |  24 +++-
 .../common/hid-sensors/hid-sensor-trigger.h   |   5 +-
 drivers/iio/gyro/hid-sensor-gyro-3d.c         |  96 ++++++++-------
 drivers/iio/humidity/hid-sensor-humidity.c    |  61 +++++-----
 drivers/iio/light/hid-sensor-als.c            |  31 +++--
 drivers/iio/light/hid-sensor-prox.c           |  30 ++---
 drivers/iio/magnetometer/hid-sensor-magn-3d.c | 112 +++++++++---------
 drivers/iio/orientation/hid-sensor-incl-3d.c  |  36 +++---
 drivers/iio/orientation/hid-sensor-rotation.c |  38 +++---
 .../position/hid-sensor-custom-intel-hinge.c  |  27 ++---
 drivers/iio/pressure/hid-sensor-press.c       |  36 +++---
 .../iio/temperature/hid-sensor-temperature.c  |  15 +--
 13 files changed, 264 insertions(+), 277 deletions(-)


base-commit: 08297ca8422541dde6c8b7e6b1d68bd4aa4568ef
-- 
2.34.1

