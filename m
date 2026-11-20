Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795140649;
	b=RZjye1aS0Pcc0544kd0MkjjfkdxBkUHh01stqGNQZyuHbKTZeObZ6R7Q/kyQP0iEhTpr
	 +u+9ED7MMQ41Fq4R4MlpL00QREY5FOLtp3pQtyaJPBsD72uOD+//VOZRJ62uXnFmrtbOe
	 eMWGbDkbLxylrjf5YPcQVa6aOyj8poqhPB1bBp54cwuhdDP05tJ5e5eJEcNGiXQCnKLNV
	 IElHk8UHy9B0duXcMzsqmH0v3mTj3NkkK8IY5MHf7DWIc+wAyZiBYTan5rRpo4TqNodHc
	 nW6lMdpI1vRktShZhLvbBKUCra4BDLw197B561w+TgQbKu+3UBkuivKBm1fO2C6PQoQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795140649;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=qWTIQYd8LsBycV6tDNDo4yeWH8peAJc+BARwBoSeYIY=;
	b=LftarFGQcws6tXlILz/9hjWk8LwkQ3h6A73QZN/9uXDpGWYVYv0v+B3QlDg1ZH1qHMoP
	 k5m+qay85cJ7K0Eka+CQw6EsIoxCcOfmM5ykkvEfMZOAuCbEMnhhQAcbgEwqfoHvUnKlU
	 9bpxMitpUM8Apg0atWdY6YEnhgi8ICCesRsrVGxu0O2G5THSPPtM9dYnVjq3R98crSzOq
	 mhU6J5zUVCTIk4YF09mqQCYdnDRaVXIC5b/mQMuRnXaGUe1iaMrGtLoFUtQcftNssLDSA
	 w65EQW15pRPFFCVFOlYNViFlWXxkqlTL2oxyu0XqcQho7/zbNXINix2CoC2YulJ0lQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=reflexrobotics.com;
	spf=pass smtp.mailfrom=reflexrobotics.com;
	dkim=pass header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tx1Pauet;
	arc=none smtp.remote-ip=74.125.82.48
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E5F606A325
	for <linux-iio@vger.kernel.org>; Fri, 20 Nov 2026 02:10:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4E5F606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=reflexrobotics.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=reflexrobotics-com.20260707.gappssmtp.com header.i=@reflexrobotics-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=tx1Pauet
Received: by mail-dl1-f48.google.com with SMTP id a92af1059eb24-1a8cc11ac42so572495c88.0
        for <linux-iio@vger.kernel.org>; Thu, 19 Nov 2026 18:10:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=reflexrobotics-com.20260707.gappssmtp.com; s=20260707; t=1795140648; x=1795745448; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=qWTIQYd8LsBycV6tDNDo4yeWH8peAJc+BARwBoSeYIY=;
        b=tx1PauettnPxkIqAWaFtW1a/gBgrgqfvTRUMhZPLJj8uvVjvqyWKp+4uAdVPrXRNEI
         kdCaM6vqeVqsLeHdE367fxTzVWZi+ffIDc9P2ItC0geE4yXx3P7FcmPurwiwjrGwV+HK
         NmomjWTv6SSK7w/gHBlT8SEHBV2b+6AosuDpMucrHY3RAndIH70yCB51UjavH3Oe2CKb
         ELl72f8YjhBklY8Vl/TALiYdAV3Y9ix1Z7o4+JwCnC160vDvreGuWtRPiK+akXBJPTxl
         EPRsmT8iTIVJVEcDYnZXsYXloVe9zqoGOw6sj1cq26ExuxyFTazgDAqdqi4Da/diNvq5
         j1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795140648; x=1795745448;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qWTIQYd8LsBycV6tDNDo4yeWH8peAJc+BARwBoSeYIY=;
        b=PMK+PSsuITur83ZaJLUt+6WEOvZ4YoAn/XCbCA9vGJgeVuAr6ETBUZCzZjqyz84VXU
         jr0UsMea6C2ruaWSWtxlt118WRebxdTDSH5QEWaQf7cVaA2kzIuZx4rHHYoYyqWZdjXJ
         Yq81duLeIluJjSSXjD3o1/Nj8CrDi66ACgfigr4djYjuJ2q+qDuPiAqxCvPAkSdrMnGG
         7f0GYu2qGeXq1aELZSM6K8e6YzH5qlBURO8Tn6mAgxfNIx/IojuQQydf+GjMDABUgixU
         wdsXYGI+azPV+7t3iv7jIFQV2aXNVYuUBzjTvT9+SAAB3/UB6wnbhKAuF1vIqvtUevnj
         Vqhg==
X-Forwarded-Encrypted: i=1; AL+hErFvUE1M2rGWAg1Td0baaR8hZ9MHRoXzKOAmsOXDfVg3taYMC/bBrjuCoo5v8gGdEA20Ap/xn4zwx4Y=@vger.kernel.org
X-Gm-Message-State: APuU4Z9DEAOM2NpkpS/MKLsfaWosPnbzJlhqEGscDkNiPB6uowamIprY
	hrXgtNxL3Dxu8hOgUlI39EQVH8C1uALq+wnvlrDf9M+frSHgf7euuhf0F0nrSMMn4NI=
X-Gm-Gg: AYBFou0GxYzihiLkaYAw0Y3XbGx7aDCFfsefHqXjrnxCnIXr3KEHLaU/HM/Atu43K+r
	KwlbCZ0OF5gDui6chFbBPfU53P/QWkpuugJ4QgoXUo5AOZwu90gq2ivREiKAGpXTTqvZ7Jg5Kma
	pQj3KV3EhJzTNpKbKHh1Sp4z9+8dO2GLf9bmRdnnZl0t5bJ4q6c6l8BPI5Z46thtXJlgO1Q4QJd
	qInU/Ak19ayFYSLjRq6SEjX+2wzf6wSr5w0JXVIWHKDMO82w0c2hf4RjTeBIdjWZvhfKtPXAIkR
	C/A1bYG9OjQbOyjObk/0jNCbNpqlTNLRYUBEod7hfSJk3dhlQ2QiIFVrNlQp1HdDd/hMvyPhxK6
	/JxL7kXh8rshbQm0V+zRHkyes52aer+OEIQnTrDfrMsImPxuwhggo3keEH22d6PdrKyAMq+0ny/
	hycASltnKSyVIdFIk8piem1YW0RebmlJCfy4wXAhAXHcWcZqNwcQSERV4sHAoR34p4T6FuJbABj
	GqKR9C7lIAanuCwNF9Z7snxxNEdvSvLoiaA2iE65dhMs4mP3dFDtk21G3F13Jo7K7J63yHCr8sX
	Vb+zfqbZEzje3Sb71fn1GBnwJ5fwJ+ms9dLzurfcN8GpO/nwtE8L4UHxRMp5xq0HJiyFKzVejtZ
	NXtch1u+tIYkhZlqxDZM+rvCZyqQr853/VYCT2S8NBnKS
X-Received: by 2002:a05:7022:f10f:b0:1b3:abd2:2eb2 with SMTP id a92af1059eb24-1b55689ed61mr1647264c88.10.1795140647739;
        Thu, 19 Nov 2026 18:10:47 -0800 (PST)
Received: from localhost ([76.51.7.19])
        by smtp.gmail.com with UTF8SMTPSA id a92af1059eb24-1b556840494sm2727974c88.12.2026.11.19.18.10.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Nov 2026 18:10:47 -0800 (PST)
From: Joe LeVeque <joe.l@reflexrobotics.com>
To: jean-baptiste.maneyrol@tdk.com,
	jic23@kernel.org
Cc: dlechner@baylibre.com,
	nuno.sa@analog.com,
	andy@kernel.org,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Joe LeVeque <joe.l@reflexrobotics.com>
Subject: [PATCH 0/2] iio: imu: inv_icm42600: keep the temperature sensor always on
Date: Thu, 19 Nov 2026 18:08:48 -0800
Message-Id: <20261120020850.24318-1-joe.l@reflexrobotics.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On an ICM-42688-P, the gyro shows a large, stable offset at rest (about
8 to 23 dps) whenever the driver has the temperature sensor disabled
(PWR_MGMT0.TEMP_DIS): without it, gyro data is not temperature
compensated internally. As discussed with Jean-Baptiste and Jonathan,
this series keeps the temperature sensor always on and removes the
driver's temperature enable/disable handling; temperature reporting in
the FIFO stays switchable.

The chip only measures temperature while the accel or gyro is on; with
both off, its data register keeps the last measurement. Patch 1 makes a
temperature read return -EBUSY in that case instead of stale data, so
that patch 2 can remove the enable/disable handling without changing
what a direct temperature read reports.

Discussion:
https://lore.kernel.org/linux-iio/20261118232418.7fc702a8@jic23-hlaptop/T/#t

Tested on an ICM-42688-P (SPI) on an i.MX8M Plus board: on 6.18 with
these patches backported to the 6.18 driver (minor context adjustments,
built as an external module), and on 6.6 with the driver backported
from mainline:
- gyro correct from the first reads after boot and after runtime
  suspend; accel unchanged
- idle temperature read returns -EBUSY; current values whenever accel or
  gyro is on
- PWR_MGMT0.TEMP_DIS never set (regmap debugfs)
- buffered capture of gyro and accel, separately and concurrently
  (including stopping one while the other runs), with and without the
  temperature channel, and temperature-only: correct data at 50 Hz
- repeated buffer enable/disable; module reload
Build-tested on the IIO togreg branch.

I kept the INV_ICM42600_PWR_MGMT0_TEMP_DIS definition in inv_icm42600.h,
now unused, to document the register bit; happy to drop it if you
prefer.

Joe LeVeque (2):
  iio: imu: inv_icm42600: return -EBUSY for temperature reads when idle
  iio: imu: inv_icm42600: remove temperature sensor enable/disable

 drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  6 ---
 .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 16 ++------
 .../imu/inv_icm42600/inv_icm42600_buffer.c    | 14 ++-----
 .../iio/imu/inv_icm42600/inv_icm42600_core.c  | 37 ++++---------------
 .../iio/imu/inv_icm42600/inv_icm42600_gyro.c  | 16 ++------
 .../iio/imu/inv_icm42600/inv_icm42600_temp.c  | 10 ++++-
 6 files changed, 26 insertions(+), 73 deletions(-)

-- 
2.34.1

