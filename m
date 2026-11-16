Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794793726;
	b=K1HcTHEcLCBWJ+xaUJaXqhtvDKTGnQkdqqUdsCxHHWbRXMF7FZTvt1MrOblfu1y/JrEI
	 YPaLuOXYJTf8y4Yl7zGcqaBleZft5mg//x+V1E7x6aBGhQL5bO4vksMDbt/TZPkQsrWk3
	 UYEOdsDOgMQVPaZF9FR9mYbXTU8XyNZ5szEmqHc/i6SErEDDCsE4nu0dbbIwOAJBt1su7
	 ZSjsERrhn3NVyjIiTI4+1h01CaoQf6HXvVf8C7x5GGGdabTFFyEHtFvawGpk+VVkynmrC
	 Fau+QMOh80WgqDfaEBHh+0q8TBfxDZdlxHUyEW1KlbjvK2NJECWP8WO/kJg9RUDqz+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794793726;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ywtOqJAsM2bjb8qlWKSfscVg6+9YAEeCvH9RDxo3V7w=;
	b=a7suVyIBSRYSH0H79fdUVTvjjP0+t8hcgDnEDqKnrd7IqpyztIflpLyOmhjlooUmI8Qe
	 nseygksnDvYnYeSw5VYeByBpX9kf2jmjhwsoFtdO15xeaylxZtywtHqWWN4z8kRH8VpLC
	 r53hrqhllG/Eu3CA/tjt5Nl+17jjuDsqfg5f1oMEuYYNv9CBz734RDEE1oHOZN/zrjeyD
	 I1yAdTLx8nG7ATFR9QLzg+Zt4f8+Dzv9Bj5RdtC1mk8a5tTeIU7z/2pRQgr+HfmaXjbRK
	 CjLI9qqRqm0SGamcH0wOH9Z9yfCurssJ2LUURhFzTiQifSCBmArjroGGYF54m7zr7Rw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgWNSTzt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0091606A321;
	Mon, 16 Nov 2026 01:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IgWNSTzt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D921F000C4;
	Mon, 16 Nov 2026 01:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794793726;
	bh=ywtOqJAsM2bjb8qlWKSfscVg6+9YAEeCvH9RDxo3V7w=;
	h=From:To:Cc:Subject:Date;
	b=IgWNSTzt8U8o5SeNtfglHcQRf0/mYnUGkt7aixsvfAMphxlG99RgV7XUSBqsxxggz
	 fmT1UHdKIN+7OpwTjpem+hp3HY4aQIKTKxLPyaITqKOQZefM2RO7XOGeTOAjR6Api1
	 DRngc6NcsWWsRh7YgOBpKAwNjdlOzjgp09XLoJhNzPFTRzC6jyBo3QAQWiKtBSZEZh
	 mQadyZqhfyaVpzpZnl6K6qIoJV/TR45PS37xIhAeMJEosiF2q3MTuxwIm6gh9O78tw
	 VRmU5exlPrrlHTyigmNZEG4jFj4QmQt1RkVrqLBBAeI9AXO3B0Xdmolsxq1xMRxzmR
	 rZ3ZGjEsA1iVg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	Gustavo Silva <gustavograzs@gmail.com>,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Ramona Alexandra Nechita <ramona.nechita@analog.com>,
	Tomislav Denis <tomislav.denis@avl.com>,
	Jorge Marques <jorge.marques@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Jianping Shen <Jianping.Shen@de.bosch.com>,
	Gwendal Grignou <gwendal@chromium.org>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Esben Haabendal <esben@geanix.com>,
	Narcisa Ana Maria Vasile <narcisaanamaria12@gmail.com>,
	Jiri Kosina <jikos@kernel.org>,
	Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
	Vasileios Amoiridis <vassilisamir@gmail.com>,
	Abhash Jha <abhashkumarjha123@gmail.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Nishant Malpani <nish.malpani25@gmail.com>,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	Linus Walleij <linusw@kernel.org>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Subject: [PATCH 00/35] iio: closing default trigger handling leaks
Date: Mon, 16 Nov 2026 01:47:48 +0000
Message-ID: <20261116014823.3132576-1-jic23@kernel.org>
X-Mailer: git-send-email 2.56.1
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

Note this is compile tested only!  I definitely want a few people
to test that I didn't break everything.

This is the first part of what I think is a long term solution to the
currently really fragile ordering constraints around setting default
triggers. Today these are set by iio_dev->trig = iio_trigger_get(trig).
The reference is only released on the iio_dev.release callback and
only if we have set the mode to include one that means there might be
a trigger set. That mode set only occurs when a buffer is registered.
Thus trigger release only works if we have already registered a buffer.

One solution would be to reorder so that the default trigger is always
set after the buffer registration (we have had various recent proposed
patches to do that for individual drivers) but that is non obvious and
fragile.

The solution here is easier to reason about. Decouple the setting
of the default trigger from the acquisition of a reference. Thus
we can acquire the reference in iio_device_register() when we know
all the conditions for it's release have been achieved.
So that's all we do in this part 1 series.

Part 2 will address immutable triggers and those that are effectively
immutable but predate that logic. That is those that set a one to one
relationship between device and trigger.  That change is rather less
mechanical than this one and 35 patches is really a bit big anyway
even if most of them are small!

Part 3 and beyond will move to a situation where the iio_dev->trig
will become opaque. That should stop anyone manipulating that directly.
I have a few related cunning plans to test out before we get to that,
not because the particular challenge is hard, but because they will
trample on the same code.

Jonathan Cameron (35):
  iio: core: add default_trigger and take reference in
    iio_device_register()
  media: pci: mgb4: use IIO default_trigger
  iio: chemical: ens160: use default_trigger
  iio: adc: ad4130: use default_trigger
  iio: adc: ad4170-4: use default_trigger
  iio: adc: ad7768-1: use default_trigger
  iio: adc: ad7779: use default_trigger
  iio: adc: ti-ads131e08: use default_trigger
  iio: addac: ad74115: use default_trigger
  iio: addac: ad74413r: use default_trigger
  iio: temperature: tmp006: use default_trigger
  iio: adc: ad4062: use default_trigger
  iio: accel: bma220: use default_trigger
  iio: accel: bma400: use default_trigger
  iio: imu: smi330: use default_trigger
  iio: light: acpi-als: use default_trigger
  iio: chemical: scd30: use default_trigger
  iio: accel: bma180: use default_trigger
  iio: accel: kxcjk-1013: use default_trigger
  iio: accel: mma8452: use default_trigger
  iio: chemical: ccs811: use default_trigger
  iio: pressure: mpl3115: use default_trigger
  iio: common: st_sensors: use default_trigger
  iio: common: hid-sensors: use default_trigger
  iio: pressure: bmp280: use default_trigger
  iio: light: vl6180: use default_trigger
  iio: gyro: itg3200: use default_trigger
  iio: imu: bmi160: use default_trigger
  iio: accel: adxl355: use default_trigger
  iio: gyro: adxrs290: use default_trigger
  iio: accel: adxl372: use default_trigger
  iio: light: si1145: use default_trigger
  iio: adc: ti-tsc2046: use default_trigger
  iio: accel: mxc4005: use default_trigger
  iio: gyro: mpu3050: use default_trigger

 drivers/iio/accel/adxl355_core.c              | 19 ++++++++--------
 drivers/iio/accel/adxl372.c                   |  2 +-
 drivers/iio/accel/bma180.c                    |  2 +-
 drivers/iio/accel/bma220_core.c               |  2 +-
 drivers/iio/accel/bma400_core.c               |  2 +-
 drivers/iio/accel/kxcjk-1013.c                |  2 +-
 drivers/iio/accel/mma8452.c                   |  2 +-
 drivers/iio/accel/mxc4005.c                   |  2 +-
 drivers/iio/adc/ad4062.c                      |  2 +-
 drivers/iio/adc/ad4130.c                      |  2 +-
 drivers/iio/adc/ad4170-4.c                    |  2 +-
 drivers/iio/adc/ad7768-1.c                    |  2 +-
 drivers/iio/adc/ad7779.c                      | 20 ++++++++---------
 drivers/iio/adc/ti-ads131e08.c                |  2 +-
 drivers/iio/adc/ti-tsc2046.c                  |  3 +--
 drivers/iio/addac/ad74115.c                   |  2 +-
 drivers/iio/addac/ad74413r.c                  |  2 +-
 drivers/iio/chemical/ccs811.c                 |  2 +-
 drivers/iio/chemical/ens160_core.c            |  5 ++---
 drivers/iio/chemical/scd30_core.c             |  2 +-
 .../common/hid-sensors/hid-sensor-trigger.c   |  3 ++-
 .../common/st_sensors/st_sensors_trigger.c    |  2 +-
 drivers/iio/gyro/adxrs290.c                   | 19 ++++++++--------
 drivers/iio/gyro/itg3200_buffer.c             |  3 +--
 drivers/iio/gyro/mpu3050-core.c               |  2 +-
 drivers/iio/imu/bmi160/bmi160.h               |  1 -
 drivers/iio/imu/bmi160/bmi160_core.c          | 22 +++++++++----------
 drivers/iio/imu/smi330/smi330_core.c          |  3 +--
 drivers/iio/industrialio-core.c               | 15 ++++++++++---
 drivers/iio/industrialio-trigger.c            | 21 +++++++++++++++---
 drivers/iio/light/acpi-als.c                  |  2 +-
 drivers/iio/light/si1145.c                    |  5 +----
 drivers/iio/light/vl6180.c                    |  2 +-
 drivers/iio/pressure/bmp280-core.c            |  2 +-
 drivers/iio/pressure/mpl3115.c                |  2 +-
 drivers/iio/temperature/tmp006.c              | 22 +++++++++----------
 drivers/media/pci/mgb4/mgb4_trigger.c         |  2 +-
 include/linux/iio/iio.h                       |  4 ++++
 38 files changed, 114 insertions(+), 97 deletions(-)


base-commit: 94921bc9eb214f838481faa847cda5c42e486013
-- 
2.56.1

