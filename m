Received: from mxd.seznam.cz (mxd.seznam.cz [77.75.76.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 972813A9014
	for <linux-iio@vger.kernel.org>; Thu,  4 Jun 2026 12:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.75.76.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780574578; cv=none; b=iNN9izOZpiToh6WY8Xn08cXmdeP2W+FSWlPoNfFXnTOXqX/zQ8qM+/abA/OqKrqRuUpKZWDI/jvc2R2cZ+K12Xgvll2bYfg7mlmrnLdFr4Bm9bilOzvQVVGHCbLFUZg8oTl5wzkabpGEde0W23F6DlluovKngr2EVUhkKrnsAik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780574578; c=relaxed/simple;
	bh=wIfu6ey3OwWBMtV2DqXTRQgHK3J1YqIGTKsTy0ZZzRg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=lAPoIuh3wjR88GSChp+TMstP7hSmyZyS8zYd+gK9GVkmhNc82pIfXzXYlUvx2u1gp7hmF7Xj43hZj0WrCAzo1YXf8ocGGzmbvMblODH6TS23T6AyL6trkbJrrJa+1KUzds/FFcE/i8M0FQTvIoDpsPAWqakKD7LtO1Wamaldqf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz; spf=pass smtp.mailfrom=seznam.cz; dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b=ApkaXi7z; arc=none smtp.client-ip=77.75.76.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seznam.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seznam.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=seznam.cz header.i=@seznam.cz header.b="ApkaXi7z"
Received: from email.seznam.cz
	by smtpc-mxd-85fb448c55-l247v
	(smtpc-mxd-85fb448c55-l247v [2a02:598:96:8a00::1200:706])
	id 61785f2dd91772a26386c5b1;
	Thu, 04 Jun 2026 14:02:54 +0200 (CEST)
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed; d=seznam.cz; s=szn1;
	t=1780574574; bh=oMIS17F7U4apFwJE02RTuEx1AEeKGiBjxDj3jsYuJ5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	b=ApkaXi7zUXmcYl9iM2UDVhkiu8H3ZrO1AnbrjoZOFPl4JZjd8WsfuGY3Y6Xs1a9lX
	 pp0T7guoTWjiHb9Dczhqro5Dz+yb+tl5Ji1eHdoB8q2AjEnlL6k6SVQobMmE0vAhqr
	 FqRPd36U3Qy1JhoMIHZNv2Rmq6M+AzvpkZUy/cBJoLIT6yh5YSPulBq9GJpXqKitKJ
	 9wETlvj2pOUc36sDgkvcEBhHgdMwCG30VB+5usvVrcKBNNp9ujeqIWibTKLC+DblSk
	 JIeGuZeeiMCcMACdJt6FtUSzCFepDUpBAQnAu8UWMa/D9nXuy0YNTMkmzvPSlDzsKw
	 R9AmW3XfsCsIQ==
Received: from archlinux (ezechiel.sdb.cz [185.100.196.77])
	by smtpd-relay-b58bfc659-k9lmt (szn-email-smtpd/2.0.73) with ESMTPA
	id 0642cb48-30f1-4b1e-aaa8-eff269a85580;
	Thu, 04 Jun 2026 14:02:49 +0200
From: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
To: linux-iio@vger.kernel.org
Cc: =?UTF-8?q?Vojt=C4=9Bch=20Kr=C3=A1tk=C3=BD?= <vo.kratky@seznam.cz>
Subject: [PATCH v2 00/11] iio: change from %ld to %pe for PTR_ERR() printing
Date: Thu,  4 Jun 2026 13:59:20 +0200
Message-ID: <20260604120201.116925-1-vo.kratky@seznam.cz>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

v1 -> v2:
- Improve commit message wording

Vojtěch Krátký (11):
  iio: accel: change from %ld to %pe for PTR_ERR() printing
  iio: adc: change from %ld to %pe for PTR_ERR() printing
  iio: chemical: change from %ld to %pe for PTR_ERR() printing
  iio: common: change from %ld to %pe for PTR_ERR() printing
  iio: dac: change from %ld to %pe for PTR_ERR() printing
  iio: gyro: change from %ld to %pe for PTR_ERR() printing
  iio: humidity: change from %ld to %pe for PTR_ERR() printing
  iio: imu: change from %ld to %pe for PTR_ERR() printing
  iio: light: change from %ld to %pe for PTR_ERR() printing
  iio: proximity: change from %ld to %pe for PTR_ERR() printing
  iio: resolver: change from %ld to %pe for PTR_ERR() printing

 drivers/iio/accel/adxl313_i2c.c                 |  4 ++--
 drivers/iio/accel/adxl313_spi.c                 |  4 ++--
 drivers/iio/accel/adxl355_i2c.c                 |  4 ++--
 drivers/iio/accel/adxl355_spi.c                 |  4 ++--
 drivers/iio/accel/kxsd9-spi.c                   |  4 ++--
 drivers/iio/adc/sun4i-gpadc-iio.c               |  6 +++---
 drivers/iio/chemical/bme680_i2c.c               |  2 +-
 drivers/iio/chemical/bme680_spi.c               |  2 +-
 drivers/iio/common/st_sensors/st_sensors_i2c.c  |  4 ++--
 drivers/iio/common/st_sensors/st_sensors_spi.c  |  4 ++--
 drivers/iio/dac/ad5770r.c                       |  4 ++--
 drivers/iio/dac/ltc1660.c                       |  4 ++--
 drivers/iio/gyro/fxas21002c_i2c.c               |  4 ++--
 drivers/iio/gyro/fxas21002c_spi.c               |  4 ++--
 drivers/iio/humidity/hts221_i2c.c               |  4 ++--
 drivers/iio/humidity/hts221_spi.c               |  4 ++--
 drivers/iio/imu/fxos8700_i2c.c                  |  2 +-
 drivers/iio/imu/fxos8700_spi.c                  |  2 +-
 drivers/iio/imu/inv_icm45600/inv_icm45600_i3c.c |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i2c.c     |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_i3c.c     |  2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c     |  2 +-
 drivers/iio/light/gp2ap002.c                    |  2 +-
 drivers/iio/light/st_uvis25_i2c.c               |  4 ++--
 drivers/iio/light/st_uvis25_spi.c               |  4 ++--
 drivers/iio/proximity/ping.c                    |  4 ++--
 drivers/iio/proximity/srf04.c                   | 12 ++++++------
 drivers/iio/resolver/ad2s1200.c                 |  8 ++++----
 28 files changed, 54 insertions(+), 54 deletions(-)

-- 
2.54.0

