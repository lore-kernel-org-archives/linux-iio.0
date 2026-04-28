Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BD1A3B7B68
	for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 07:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777360581; cv=none; b=Z9cd7rJRb3uEb1j/gclnjICqr+SaW4nPdAfbUE/b+79Qb4L4eGgcdUdsFnDYAFZDFYYbNAli7KUvzUtAieHhjxis/2EwaQpg5KmznufMicu9FoimcdkLBz5VkzE7xtq/PwK6SEdvb0A+ykDxawoto4P3/YMTMivDVQvAG+8/qvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777360581; c=relaxed/simple;
	bh=vnQVADDxQ0ttdYZpf97F0FvwlAmDKtuJ+IcyZBRg7gc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=svrMAHP9YIHVu2ZRC1w/qSsRZIuME1cE58+NOM9PLR40IA+GN0n7iGPrJMc1vEW7hG4aEu8u7wzefyQSHNLk/FWnfph95L45ehLGMXiXdVw1ChpCi1uAB2W8RjwUtqb/SUQD5L4vIKEn3XRI1sxn+vT2Y5kBSHRQ6/cH8jTa+Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IaUrad+H; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IaUrad+H"
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-c7358a7a8d1so7179341a12.3
        for <linux-iio@vger.kernel.org>; Tue, 28 Apr 2026 00:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777360580; x=1777965380; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=VzVQi/4uRerG6QDvEL4eh9INtxekMjFaRMwVGPZBDjw=;
        b=IaUrad+HtrmT3IuwKqnF4KABvAgmBt4T+2G6fOaJmBmqjdTF0ZBJTSy46eIBoUaONF
         ZMr04A5m07U/MCJIQxhpM+t0kbWcvRC/F/g6x4HEsH7QqDwuY+HbTmyK8HkmHhdT6w8k
         9k+ICUsU3fX/y5bDUG4DFL+0hsNIsY8P5+jpIH3P2sAqIw5Dmg2kqTBOYRsL/wB7ZHme
         OIhbSEY7NcjkM2fOntrtKyK+8Bm/cgzPn7c5rnvFUA9HXk+TubXUqegTyeTyXWSuk6Xb
         5ExKhbPBy8KGYIEFyFT1XB8ibbp4mqqdcHubdg7cgvf1NjcMbqh9aauonHV7cWxFi4qw
         5WYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777360580; x=1777965380;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VzVQi/4uRerG6QDvEL4eh9INtxekMjFaRMwVGPZBDjw=;
        b=T3LQWMC79K33x3ZI4QOwtJOnqHMR575PVu4oFcmT+t+8BSyvCVavSkkEfGh1o51Sdz
         9btYwt3e/fkJAozXQy3mykfrXlLPgqtvab5mybIDwMZlbmf7AhCBFTlh9ibC1irYzdkD
         pBDZ96Sm1K74T7USbz0GCwzxG+mVWZNuwQumqR7ShuHV4EUG2dOO+uIMOX4g20c4AUbF
         paN3u8LwLRGviBpDkDUjrIOfNkssDOiJ2+//qn2ZFz7cCKYF24UGKZSVoTlmN4iM4TaJ
         MqMDfZBfPF/bPYca+9s3tQ4e2K63IeNsmRdF3kOLJWHdaOo2aNn0F4T6E+fPfynCoZLy
         WEUA==
X-Forwarded-Encrypted: i=1; AFNElJ+jfEHc0jalyMYANuMPxaFKu1g33qfxE6gheSAKPeYDrxEM7ebwFB/o/y7ia5NX4nZASuTy+V8jGW8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCUsmZ/Z4w7FH6p/7OYN2LK6Dnnnza9zcahMdDUixtuPTcOD/I
	5QCItZUXohHqd4KMvlaQ2R8ar9sbWumofEhffyhCd/kAUp4cSFHwsXNFAMbEHw==
X-Gm-Gg: AeBDievTnipyOl0J3OGMVgA69/h5fG7COYqyD3BCDEBZLvRufIWWLPk84veeldRMDy8
	YKXf3RTkMHmJqVKTL9t/2tIvv7BFuDm8WeB8GVzXtT3U5J3mrvuyD0Ob6PVRAdM2tRsCeDUKRM4
	KTQlI7FnT5tU70ni9qsmRtL6ouwBdPPQ9/nZeYUsipAYbwLWLKuZLG/6tAWn5g7KnAFB54cZzrI
	A9tjVebpT3GqUb/ma8XRKDlX0Gp1pueqAz5VrHI6zHXq8m/a/qwO58yRAyW6dyNOLhhi0pZtz6T
	8TgBUpc0f7jsTUCSGyYVIjkGd7KUkO5YPddc26+84JWw4R1eVlKjjPzh6JVOZ+15E2RUmpEhMj+
	+FdO+zy0YFYBtOn6LXXMn4WFbczPKfifDtgdL785pCNi4n2Nqn0fzuT4zdL/qWG9XYvNLy/Nk3u
	QSWkATw6k7QxfYg4wUKy/qbv4I9BD1k2+s+/VmOIcfDGdjBckfBLZY9Yikh8Y=
X-Received: by 2002:a05:6a21:6da2:b0:3a2:f14a:4275 with SMTP id adf61e73a8af0-3a39c062af9mr2437037637.6.1777360579637;
        Tue, 28 Apr 2026 00:16:19 -0700 (PDT)
Received: from hu-ckantibh-hyd.qualcomm.com ([202.46.23.25])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-834daf5705fsm1987335b3a.42.2026.04.28.00.16.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Apr 2026 00:16:19 -0700 (PDT)
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
Subject: [PATCH 00/10] iio: drop redundant iio_dev argument from hid_sensor_remove_trigger()
Date: Tue, 28 Apr 2026 12:46:03 +0530
Message-Id: <20260428071613.1134053-1-sanjayembedded@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanjay Chitroda <sanjayembeddedse@gmail.com>

The iio_dev argument has been unused since buffer cleanup moved out of
hid_sensor_remove_trigger(). All required resources are tracked via
hid_sensor_common, making the extra argument redundant and allowing
future devm conversion.

This is a mechanical change with no functional impact.

Testing:
  - Compiled with W=1
  - Build-tested on QEMU x86_64

Feedback and reviews are very welcome.

Thanks,
Sanjay Chitroda

Sanjay Chitroda (10):
  iio: hid-sensors: drop redundant iio_dev argument
  iio: orientation: adapt to hid_sensor_remove_trigger() API change
  iio: gyro: adapt to hid_sensor_remove_trigger() API change
  iio: pressure: adapt to hid_sensor_remove_trigger() API change
  iio: temperature: adapt to hid_sensor_remove_trigger() API change
  iio: humidity: adapt to hid_sensor_remove_trigger() API change
  iio: light: adapt to hid_sensor_remove_trigger() API change
  iio: magnetometer: adapt to hid_sensor_remove_trigger() API change
  iio: position: adapt to hid_sensor_remove_trigger() API change
  iio: accel: adapt to hid_sensor_remove_trigger() API change

 drivers/iio/accel/hid-sensor-accel-3d.c              | 4 ++--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.c  | 3 +--
 drivers/iio/common/hid-sensors/hid-sensor-trigger.h  | 3 +--
 drivers/iio/gyro/hid-sensor-gyro-3d.c                | 4 ++--
 drivers/iio/humidity/hid-sensor-humidity.c           | 4 ++--
 drivers/iio/light/hid-sensor-als.c                   | 4 ++--
 drivers/iio/light/hid-sensor-prox.c                  | 4 ++--
 drivers/iio/magnetometer/hid-sensor-magn-3d.c        | 4 ++--
 drivers/iio/orientation/hid-sensor-incl-3d.c         | 4 ++--
 drivers/iio/orientation/hid-sensor-rotation.c        | 4 ++--
 drivers/iio/position/hid-sensor-custom-intel-hinge.c | 4 ++--
 drivers/iio/pressure/hid-sensor-press.c              | 4 ++--
 drivers/iio/temperature/hid-sensor-temperature.c     | 4 ++--
 13 files changed, 24 insertions(+), 26 deletions(-)


base-commit: eade2b843d9b1f668fc1775f15611bb0a1999cd9
-- 
2.34.1

