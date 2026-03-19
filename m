Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7104731F99A
	for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 18:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773945148; cv=none; b=uWy2sf3jQqPR5Qkj1V0LASPk64myeH8VAKBTfg1CAe8ky8UuDMOW1gbx4HtMoUMVX0Vr1Q3ZFhXiXA07OletACy4VfecLvQ4182tdYoG3RElcZJwcQ0FncZmNU9xmguwOI5O56bwn/W6SducczpogeyYDL4NLsW3LpAvVCiUtXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773945148; c=relaxed/simple;
	bh=OWKWp+BLvNZUhhCwq6oRBWRIXjmiSR4NS463QO/TtVU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qHrXPM7lxuAZs6qywPAHPQPzMprbStSe9Chp7TlcEd27bIuejktTXMNoDXGR/2JsjivNyTJB4eC1NP9kx22YjuS9kC8lqS/X9Wf1BznMVOvpHJ7TURn+e7wBN4kb3ab5aCetCMDdzOZi4HlzkHKSYJZP3A0USInUIE4WjX55MGU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=geoL4BYP; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="geoL4BYP"
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d7d50516e9so790116a34.1
        for <linux-iio@vger.kernel.org>; Thu, 19 Mar 2026 11:32:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773945144; x=1774549944; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KTByHItjyR7/RYBQwNnWdmqTMyR9cwK4/f01mIblYeA=;
        b=geoL4BYPMRN7D/gOiLOVYTPtRr7bJRl6QqrOHKMgTloFXrr2X1ZpQ6HBcIcQSyETiw
         r/vJYwSHooiWnsTmHJicAmT2wmSf6PvBdhIbV4WkyhR0yQNkvOd3MAgRcoAhSO8RrWKZ
         7imJgVmUmahBJW5+MHikRj0EX2m5M4oZydjYomqiMPfLJg2gvoE8SLEyvD7SiPy9zUoB
         JmzVMt0FT8Z49nlTyv5/7Q+j/zXYw4ClkV3m+Vu+DTKt8C+o2o+Vuje2NEovNnO5oeWy
         /88etarY+F/d4nJ9rvNU0CSBCZZkzbgzYebRwIvUPpidY41TriXYCSjNkVO85DO87ind
         P3RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773945144; x=1774549944;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KTByHItjyR7/RYBQwNnWdmqTMyR9cwK4/f01mIblYeA=;
        b=IVgbb6ogLawl4X2PGDZvPSvuby0G2uDTUGiiDpv2uJxifKxTKDRM+wu+dqwB3gJMno
         Hy/9iz6Axmm/zl6SxtwXDdniTeKihrBig2KWhdxBgKHEXlHereR2REWZmIPyD6JOc+eO
         jw9Tys3o5C856bcPqJ1wHHbzcy6aRaBUqq41gt1l1AJOKIxvUz3tvCi8ySEIK14ko+3X
         Ij/i9RpPOJ68B4jPFGL2HpMtJKyCt1Lceu5SjvhL7olMEDuQyADtMGngmYQEV/SMiSKs
         Wpd1cSajbm8pyKjdWvJm36BVz57caS/3XYjJXQ0ErKLrcA7lANaB560jcOtP+e+8G/9K
         /izg==
X-Gm-Message-State: AOJu0Yzz0OMRJ9xRcWEnrsJprhLKN07yUAgUX0ZJYzDJOLsc+V7N7mit
	9fVxx27pi6vnRjXlWZyzwfLWuqwSlMkAB5y1kM2eekdtE7Cc8iBD+p6X+rgqAg==
X-Gm-Gg: ATEYQzwTqowoSLYE2R47S+/UhjhvqEVLhTYyfZaQ3/2Ta9jSmjR42B6qutUTjnldmwd
	0fLJrW8iqmbjKlf0luJftAgKox/RlTPYpbLOeQnW+aVdb8tATSsAvmg8leH4iLnl5nGM/MYmZh5
	VIMxVDrQwbxsefQRpfn8FkCMU9nxMmPpn0W6RSfRQ4XvI069UdHkBZElJ2Q2HoY9EOTdWyBCceL
	MH7pdoj5Z7jgcIOxqXdTQmI0tC8Z++2ZcHqDkWbW/PkaGE6kFASe7TcY1PfEHpxP7PL93tH/Z/x
	SEI2AvJtp4xXD06cAUhIZUCes18wldbciyWpgiRQTKH7ic9mZvdzQoHRqTGgMeYK8RRdx2zeATk
	Irp7aBmPkNmcFunF12rnPOfi6NzKU1ESFcvv9SOPi+ZbzHefqJSN8sMiC2IvkGql7j3cGVrahWo
	k4qwV7G9bXY7VVPhES2oJR
X-Received: by 2002:a05:6830:6aa1:b0:7d7:d097:96e2 with SMTP id 46e09a7af769-7d7eae1c964mr190466a34.7.1773945143893;
        Thu, 19 Mar 2026 11:32:23 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0::54])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d7eadcb11csm172193a34.13.2026.03.19.11.32.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 11:32:23 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: linux-iio@vger.kernel.org
Cc: andy@kernel.org,
	nuno.sa@analog.com,
	dlechner@baylibre.com,
	jic23@kernel.org,
	jean-baptiste.maneyrol@tdk.com,
	linux-rockchip@lists.infradead.org,
	devicetree@vger.kernel.org,
	heiko@sntech.de,
	conor+dt@kernel.org,
	krzk+dt@kernel.org,
	robh@kernel.org,
	andriy.shevchenko@intel.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v2 0/5] Add Invensense ICM42607
Date: Thu, 19 Mar 2026 13:29:36 -0500
Message-ID: <20260319182956.146976-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add support for the ICM42607 IMU. This sensor shares the same
functionality but a different register layout with the existing
ICM42600.

This driver should work with the ICM42607 and ICM42607P over both I2C
and SPI, however only the ICM42607P over I2C could be tested.

Changes Since V1:
 - Instead of creating a new driver, merged with the existing inv_icm42600
   driver. This necessitated adding some code to the existing driver to
   permit using a different register layout for the same functionality.
 - Split changes up a bit more to decrease the size of the individual
   patches. Note that patch 0004 is still pretty hefty; if I need to split
   further I may need to create some temporary stub functions.
 - Used guard() and PM_RUNTIME_ACQUIRE_AUTOSUSPEND() on the new functions
   per Jonathan's recommendations.

Chris Morgan (5):
  dt-bindings: iio: imu: add icm42607
  iio: imu: inv_icm42600: Add support for using alternate registers
  iio: imu: inv_icm42600: Add registers for icm42607
  iio: imu: inv_icm42600: Add support for icm42607
  arm64: dts: rockchip: Add icm42607p IMU for RG-DS

 .../bindings/iio/imu/invensense,icm42600.yaml |   4 +
 .../dts/rockchip/rk3568-anbernic-rg-ds.dts    |  20 +-
 drivers/iio/imu/inv_icm42600/inv_icm42600.h   | 333 +++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 497 ++++++++++-
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 240 +++++-
 .../imu/inv_icm42600/inv_icm42600_buffer.h    |   5 +
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 795 +++++++++++++++---
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 379 ++++++++-
 .../iio/imu/inv_icm42600/inv_icm42600_i2c.c   |  53 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  59 +-
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  |  64 ++
 .../iio/imu/inv_icm42600/inv_icm42600_temp.h  |   4 +
 12 files changed, 2289 insertions(+), 164 deletions(-)

-- 
2.43.0

