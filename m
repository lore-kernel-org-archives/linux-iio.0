Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102317;
	b=D4TeoaRer1SP6TTm5EMSTfnrPHuAZpeUDs5HnRkHLmIVkUPNJxCsCksRuYL5rqwJJ610
	 2NoxIwSXxsMRKD0kjcljPh2x8vhTLXwNPKlMrAKjcSW4rfzyh3X9Pwod/oL/ZARFxHI5W
	 7FUEGIr7xAqOcwBIZrG7S4e122S886e8GZ9DN5Qsgv5JR6Nhaw+oNZeyCGaUmuRxu72m9
	 OL/Kq/n7e6H/Z/mgmo7oxSwEM1E8jLSszrLDCCgZTwhB6ebcvtqkLDscWEGTcmhGcm7UN
	 KZGG5zoInsG8UdkrpoNgFqX8JvXRDB/QiH/XRDb1XQ0YyOfi2nPy6ule7oa1OpaSvzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102317;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=X/7FVMEXiHBL4WSOz0Pysl4wEd+SmpS1KQgCfjBgAZI=;
	b=LE97mIA0pHxFWuWlPp1bwzeLIIhW7e+g06GXjcXLZ2z5aXpnwkos+DYQyBu7ZubVBx6N
	 VFVODKx32PXdQx7FT0Sxd9WQ0oUlGOLUJ3PvPPX0CkRpblsGcbeUT3UcQsJaepiYEJpDk
	 kaTYr0As1rE8yxEB1mOxqSl8WfbtLzaqp1OST+h3cWOBSYV0/oevh6JVfPBLhGGGwx3e9
	 2s6GnX2oebDBBG4M9SIuyeyaREK6iHlqDCSo2cAlWGi1pWbFqm+LxAjfucSTvxyZwGTrA
	 sP3jH/N+KnMa9PW1B+y85BiFeuhHVmHY72uGyKAXl2hDIMISAP8yFeuc9gZwbkMt4LA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Iyr9/xW7";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2474606A320;
	Thu, 19 Nov 2026 15:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Iyr9/xW7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29E21F000C4;
	Thu, 19 Nov 2026 15:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102317;
	bh=X/7FVMEXiHBL4WSOz0Pysl4wEd+SmpS1KQgCfjBgAZI=;
	h=From:To:Cc:Subject:Date;
	b=Iyr9/xW7xxwLpx19/6opDpoSmJ2s/MGFRTUq8pKHHWyvtgqt/6NY81BiQyhPzLFpF
	 bxbG/rzEdIDvdk8tCaVzGBJoG3LuPdOxatvz49fC+WFtm2jzGsIVMrk5GYSYYGZii8
	 TdPgGAEzYjCOdBMmzC2vkEgrqZoS9bWvfpUhRtjoPPJ36IN4kp4g0+eVjNr3wJFJ5Y
	 VAwpM2PeTgakhzKIrg8KrOkekTlO88z/NspyQPtBWsNrcf0U0ijriZivmz6lM7in31
	 fj0TuK4mEswc3lLYMzBRIBW0fAClOZRuT0tb2OIRHqYdzmeQctqLEEhzB7mGRl6n3b
	 a6tiHvkhqbB/Q==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org
Cc: linux-kernel@vger.kernel.org,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Alexandru Ardelean <ardeleanalex@gmail.com>,
	Andy Shevchenko <andy@kernel.org>,
	Bogdan Bolocan <bogdan.bolocan@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>,
	Joe Sandom <joe.g.sandom@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux@analog.com,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-iio@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	Lothar Rubusch <l.rubusch@gmail.com>,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Mathieu Othacehe <othacehe@gnu.org>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Olivier Moysan <olivier.moysan@foss.st.com>
Subject: [PATCH 00/10] iio: Fix memory corruption, teardown races and bounds checks
Date: Thu, 19 Nov 2026 15:30:33 +0000
Message-ID: <20261119153151.1397003-1-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Post: <mailto:linux-iio@vger.kernel.org>
List-Help: <mailto:linux-iio+help@vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-iio+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

These issues were reported by Sashiko.

Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: Alexandru Ardelean <ardeleanalex@gmail.com>
Cc: Andy Shevchenko <andy@kernel.org>
Cc: Bogdan Bolocan <bogdan.bolocan@microchip.com>
Cc: David Lechner <dlechner@baylibre.com>
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Cc: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Cc: Joe Sandom <joe.g.sandom@gmail.com>
Cc: Jonathan Cameron <jic23@kernel.org>
Cc: Lars-Peter Clausen <lars@metafoo.de>
Cc: linux@analog.com
Cc: linux-arm-kernel@lists.infradead.org
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-iio@vger.kernel.org
Cc: linux-stm32@st-md-mailman.stormreply.com
Cc: Lothar Rubusch <l.rubusch@gmail.com>
Cc: Lucas Stankus <lucas.p.stankus@gmail.com>
Cc: Marius Cristea <marius.cristea@microchip.com>
Cc: Mathieu Othacehe <othacehe@gnu.org>
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Michael Hennerich <Michael.Hennerich@analog.com>
Cc: "Nuno Sá" <nuno.sa@analog.com>
Cc: Olivier Moysan <olivier.moysan@foss.st.com>

Lee Jones (10):
  iio: imu: adis: Clear pointers after freeing in
    adis_update_scan_mode()
  iio: accel: adxl313: Prevent FIFO buffer overflow in
    adxl313_fifo_transfer()
  iio: accel: adxl313: Reject sub-base ODR codes in adxl313_read_raw()
  iio: adc: stm32-adc: Validate channel index before writing chan_name
  iio: adc: stm32-adc: Detach chained IRQ handler before removing domain
  iio: adc: pac1934: Fix custom attribute allocation and channel bounds
  iio: adc: qcom-spmi-adc5-gen3: Free TM auxiliary device wrapper in
    release callback
  iio: adc: qcom-spmi-adc5-gen3: Reject empty reg property in probe
  iio: proximity: isl29501: Fix division by zero and overflow in
    isl29501_set_freq()
  iio: light: tsl2591: Prevent infinite recursion on threshold
    boundaries

 drivers/iio/accel/adxl313.h           |  2 +-
 drivers/iio/accel/adxl313_core.c      | 13 +++++++++--
 drivers/iio/adc/pac1934.c             | 33 ++++++++++++---------------
 drivers/iio/adc/qcom-spmi-adc5-gen3.c | 32 +++++++++++++++++++++-----
 drivers/iio/adc/stm32-adc-core.c      |  6 ++---
 drivers/iio/adc/stm32-adc.c           | 12 +++++-----
 drivers/iio/imu/adis_buffer.c         |  2 ++
 drivers/iio/light/tsl2591.c           | 25 ++++++++++++--------
 drivers/iio/proximity/isl29501.c      | 10 ++++++--
 9 files changed, 87 insertions(+), 48 deletions(-)

-- 
2.56.1.708.g77570a6a1d-goog

