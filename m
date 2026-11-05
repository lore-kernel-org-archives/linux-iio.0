Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793881021;
	b=aF84TtpKxioFpCE3yWtV7rcJiDVSemSkIu9C3xN56lOOGcqFkPy9FjZKmdNh7PB0t4pl
	 CHvJO00ts9tvnx9P94swjHZFucfW7x1wDNfd6jIxy5DuptLaMfhpQGwSH8p5CdnvkgKp4
	 edVCC9wSzX9jVaVIjqtwP66V16k+4YmtbWJimgVgAvusUTeGBLVjvRS8V6YFup0EhIvgd
	 9e9afavYtO+c240s43XQ2slt9kkjAeejhX2NYLFPI3ObBDUGvwmqJMBYk75z4tFVTakVY
	 KMuG1D7eVpmpPMzN7JCgaX++75OvRvjIjVzhsbQbcIfvQuW3xpi5/zCnibHCMtmmirw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793881021;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=UVkIIXb/q2/cPaHeiRUhrvGFwLmJPG5MCpguu9J85vE=;
	b=ME4DuApqCHMq14/cs0zavs0GQeSQsFJYeDJKrQfuRHgqVHSc47NoGK04zGo8+q2x4OJj
	 XDxjrb9mKrEQehdqs/4g986DgjqlEi1Zdtj0XvZMySq1UBqYh5aK2ES26EoCH9volwq9Z
	 r7F9Wv7dldu5SO3ksVB4RvfJR9T1KZiN64NuV+IpFALXLO0K2Wh6rnspMXPUxu4vbsKuE
	 sAaIy60TZLXisJB6UGS0vgjUBC6M9L9VT3zdUMjgH4obHNFyuadBN/HJ+RwahWW4/Gvqh
	 Xi0yhsi3M13Cd2eGvwccJ0BOohL3GJ1CuTr5A87mJOwbKM+E/WW1EGqwCsFiie1P4yQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="QdL/JfEY";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62965606D839;
	Thu,  5 Nov 2026 12:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QdL/JfEY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 585AB1F00A15;
	Thu,  5 Nov 2026 12:16:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793881021;
	bh=UVkIIXb/q2/cPaHeiRUhrvGFwLmJPG5MCpguu9J85vE=;
	h=From:To:Cc:Subject:Date;
	b=QdL/JfEYDKLa6NzBkN61MKh9VJbLFc1qgwKkrgJhPHH4mjmH2lUxQLh9Yk/AQhAac
	 dNIs7RgRRk74I3rt7AlKwYN+eYOUSKM/vDcox8jDm70LVmPsVsKAH+ENRsbqtDV0/1
	 CPb++Qylbu5JKhVxI0vQrq90JqMavGtnMOM3oXkS1Joi09wNcQxweUStVOugW7VYm4
	 cLN6dWhU8TVkBMCGk6ySAXUEBAQ8t8qtfeqzTFx6+xSbjSH483ojnkusS2EavJ4RsC
	 J/6IHsmPtNo2aXvmR6yehbtLvVN79i26k2xXprOOCh10yeMnKW0DWyr04cESwQ4ZCS
	 Epby4mCiPf6LA==
From: Joshua Crofts <crofts@kernel.org>
To: Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Eugen Hristev <ehristev@kernel.org>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Haibo Chen <haibo.chen@nxp.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH 00/10] iio: remove redundant pm_runtime_dont_use_autosuspend() calls
Date: Thu,  5 Nov 2026 12:16:25 +0000
Message-ID: <20261105121635.1612-1-crofts@kernel.org>
X-Mailer: git-send-email 2.43.0
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

Since commit d1706f9da9f4 ("PM: runtime: call pm_runtime_dont_use_autosuspend() on reinit()"),
driver core is now responsible for undoing any
pm_runtime_use_autosuspend() calls on driver exit.

Remove the redundant function calls.

Joshua Crofts (10):
  iio: accel: bmc150: remove redundant pm_runtime_dont_use_autosuspend()
    call
  iio: accel: kxcjk-1013: remove redundant
    pm_runtime_dont_use_autosuspend() calls
  iio: accel: mma9551: remove redundant
    pm_runtime_dont_use_autosuspend() calls
  iio: accel: mma9553: remove redundant
    pm_runtime_dont_use_autosuspend() calls
  iio: adc: at91-sama5d2_adc: remove reduntant
    pm_runtime_dont_use_autosuspend() calls
  iio: adc: imx93_adc: remove redundant
    pm_runtime_dont_use_autosuspend() call
  iio: gyro: bmg160: remove redundant pm_runtime_dont_use_autosuspend()
    call
  iio: imu: kmx61: remove redundant pm_runtime_dont_use_autosuspend()
    call
  iio: light: vncl4035: remove redundant
    pm_runtime_dont_use_autosuspend() call
  iio: magnetometer: bmc150_magn: remove redundant
    pm_runtime_dont_use_autosuspend() call

 drivers/iio/accel/bmc150-accel-core.c  | 1 -
 drivers/iio/accel/kxcjk-1013.c         | 2 --
 drivers/iio/accel/mma9551.c            | 2 --
 drivers/iio/accel/mma9553.c            | 2 --
 drivers/iio/adc/at91-sama5d2_adc.c     | 2 --
 drivers/iio/adc/imx93_adc.c            | 1 -
 drivers/iio/gyro/bmg160_core.c         | 1 -
 drivers/iio/imu/kmx61.c                | 1 -
 drivers/iio/light/vcnl4035.c           | 1 -
 drivers/iio/magnetometer/bmc150_magn.c | 1 -
 10 files changed, 14 deletions(-)


base-commit: 1390ca4953a7400ca932cb49635f02c727f885a6
-- 
2.47.3

