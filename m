Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 543BF3BE621
	for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 15:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781884520; cv=none; b=kCD5IMEos/3A4e1iTXnyrwU0D9WmShGvaLDowhX6YvIeqaQfGF+CTlMFAGaWmVgovLMPYC8WGqhXdZQ5YG4/Ex+dc9r0rxGo0iPId9EBTX52gx9kqd4ZiBhFDmgLJyoH5Vz6IJ97nkYgn/A2g331wyX61PwyDoLFoRnCBr4IrTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781884520; c=relaxed/simple;
	bh=rzyItKitX1xfdqxIj4i5MGbTVUb24C8vStiJf51sFK4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TPlGke3zYLOIdNT0T0ImWFaniZwyIuOuzmWF/5FI4AIpfWL5rq+UMq/FXBDwQocBtZTgmJiwzfhy4S8Ur/7TkEm/h/3mj0puhuI+bxqe0LxnF4xfw4OCjGJ7Dg0IPZMWj7fiLlBfD2tgavz8zSJowzpMeYd6ZseFgiM4A8WEfxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=O0VA8rQh; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="O0VA8rQh"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4921e4dd62dso17171415e9.0
        for <linux-iio@vger.kernel.org>; Fri, 19 Jun 2026 08:55:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781884511; x=1782489311; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWrlTknTS3aWmoT0Y0dSpEuXznmrIxwbC2fvomDiC3A=;
        b=O0VA8rQhfPRGc4KOPKPrKTdJPhUHx2fQvNUjwvkEj4/+O91UqEieI8MjnnFU/id43T
         5ZyC/BJOa0rcLQ5QUnR0XDL8Lf2shn6OSC0SLNa+PVP9CO50QHYO9Fbx/XK599DetnnI
         xQFZnhNFAlRpZtJb89yiAEBchhBH4vL4uoygMLU3msHEdtNQZtpeFOXdR+MqM8o7E+Xf
         YpK0IDb6FI0MStkJngIbyYp+pDs/rP7AtCwDlsMifsMn7claOTSV6Zs+RnPAm3z/Wvg6
         RTH6ZSYjeziHMBgp9xl72YiEA9atDHVTYlEkActScTnMO/BXZ6LOlHx4kdKwdrFy/8jW
         vwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781884511; x=1782489311;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWrlTknTS3aWmoT0Y0dSpEuXznmrIxwbC2fvomDiC3A=;
        b=L3GPwvnoIkCF9IP9ArImF/VBF/EGVUkodlGQpXO8/U2bgxmLAXrIeJcv83LicwBQJ8
         D6EY13gtQy1yA5j7iJph5z9wxaMZKT+0Nu9SHuubPYvS7ZNKvkS4sm1j+86VXrQiZLFV
         d40wkyw+KbQt1jGF58QDOSNFF4SUdOorI1lqKdMna6XBHnvMcJ9zLVIVhcZC8v68qKXo
         TAiNth7p8PpvskcekfeWC85ZWeL4vgwmOpHLBVzHkDeZxXo38KWNaCD7yesGiIN/Uu59
         /TbZVB8JjXSiiyjOvgzW4YgyzglPUarVGuQWRNjWwYJDT0huOx/HzPKepjrp6sFv23sN
         BtMw==
X-Forwarded-Encrypted: i=1; AFNElJ+N9e35wiTLMrQfT+NpB5tkiG/e7ftuSymtPdIOLChJONBuVkTqbE7D3Xy3wwBSnU2JKO2Ax+MByfM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwS9c29A8+xFriEu4xvk6GRpwIBmHaBPHQebCyMWUN5h2aq4zM+
	pPLo/O5x5LO9DxsAPv0IuOCLZHs08/S9ZTiv+7JBtDebAZ6F6Gh0GjGK6+3WcZC1L+I=
X-Gm-Gg: AfdE7cmjc/6isReuL8Kv3tG04WsEQguFswmQdfgvY03sdEZrwR5/Ifl7VXXTunfBtJM
	OGhz8ITYzaCwkCaRI7cUSWwqkb5zDe7C3yAtdN0X9L0iYCfh0YzenGIJ9fygHyQctKfKWFBM49r
	0NDCkzNmakzxA4HdgeS5vNrc6fHGxzGn+M0VufuXV+eCal1joSzNGhu7Gx7ABNMKk2NhsUmJj2o
	92F03TLeF3qRcVTv/+yfmRyY6C23CvR0/7Bs86ix5u/2SuD/QP7P78z5w3NWrW3yEOamqPfZm2H
	ph6Fw6HOH93ytGB2CiBLisMLRklAXMWHQeBAMuIMo8evCMsu46hackDBWakEgGLf1NZt7Y/w60J
	3EQm1pqlMWzoKYigKoig0r+orlGVejdc1b0R+lQ/aXleetSXBaOIm4jxOg1pEP+GlpPKJJHowU6
	ZRfreLz1f7EKdia1SkfXvQNh+p7ICC25jQDkhqzG3xHI/ykIkNQm6viJrCT/HYETwag+HdURRHv
	ak=
X-Received: by 2002:a05:600c:4fd6:b0:48a:53cb:8604 with SMTP id 5b1f17b1804b1-49240a44a04mr56924665e9.14.1781884511454;
        Fri, 19 Jun 2026 08:55:11 -0700 (PDT)
Received: from localhost (p200300f65f47db04359fc0e70763236f.dip0.t-ipconnect.de. [2003:f6:5f47:db04:359f:c0e7:763:236f])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4923fce9590sm79979625e9.4.2026.06.19.08.55.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2026 08:55:10 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: David Lechner <dlechner@baylibre.com>,
	=?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Vladislav Kulikov <vlad.kulikov.c@gmail.com>,
	Kevin Tung <kevin.tung.openbmc@gmail.com>,
	ChiYuan Huang <cy_huang@richtek.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	Antoniu Miclaus <antoniu.miclaus@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	linux@analog.com,
	Marcelo Schmitt <marcelo.schmitt@analog.com>,
	Petre Rodan <petre.rodan@subdimension.ro>,
	Dan Robertson <dan@dlrobertson.com>,
	Rui Miguel Silva <rmfrfs@gmail.com>,
	Dragos Bogdan <dragos.bogdan@analog.com>,
	Dixit Parmar <dixitparmar19@gmail.com>,
	chuguangqing <chuguangqing@inspur.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Marcus Folkesson <marcus.folkesson@gmail.com>,
	Andrew Davis <afd@ti.com>,
	Puranjay Mohan <puranjay@kernel.org>,
	Ramona Gradinariu <ramona.gradinariu@analog.com>,
	Esteban Blanc <eblanc@baylibre.com>,
	Sergiu Cuciurean <sergiu.cuciurean@analog.com>,
	Alisa-Dariana Roman <alisa.roman@analog.com>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Renato Lui Geh <renatogeh@gmail.com>,
	Ramona Bolboaca <ramona.bolboaca@analog.com>,
	Kim Seer Paller <kimseer.paller@analog.com>,
	Marilene Andrade Garcia <marilene.agarcia@gmail.com>,
	Marius Cristea <marius.cristea@microchip.com>,
	Kent Gustavsson <kent@minoris.se>,
	Kurt Borja <kuurtb@gmail.com>,
	=?utf-8?q?Leonard_G=C3=B6hrs?= <l.goehrs@pengutronix.de>,
	Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Gustavo Silva <gustavograzs@gmail.com>,
	Alexis Czezar Torreno <alexisczezar.torreno@analog.com>,
	Janani Sunil <janani.sunil@analog.com>,
	Anshul Dalal <anshulusr@gmail.com>,
	Ricardo Ribalda <ribalda@kernel.org>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Alex Lanzano <lanzano.alex@gmail.com>,
	Jagath Jog J <jagathjog1996@gmail.com>,
	Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>,
	Remi Buisson <remi.buisson@tdk.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Andreas Klinger <ak@it-klinger.de>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
	Andrew Ijano <andrew.ijano@gmail.com>,
	Giorgi Tchankvetadze <giorgitchankvetadze1997@gmail.com>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Md Shofiqul Islam <shofiqtest@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Stepan Ionichev <sozdayvek@gmail.com>,
	Sam Daly <sam@samdaly.ie>,
	Colin Ian King <colin.i.king@gmail.com>,
	David Jander <david@protonic.nl>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Linus Walleij <linusw@kernel.org>,
	Gabriel Rondon <grondon@gmail.com>,
	David Marinovic <david.marinovic@pupin.rs>,
	Lukas Schmid <lukas.schmid@netcube.li>,
	Shi Hao <i.shihao.999@gmail.com>,
	=?utf-8?q?Rahman_Mahmutovi=C4=87?= <mahmutovicrahman5@gmail.com>,
	linux-staging@lists.linux.dev
Subject: [PATCH v1 00/13] iio: Use named initializers for device_id structures
Date: Fri, 19 Jun 2026 17:54:28 +0200
Message-ID: <cover.1781883685.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: linux-iio@vger.kernel.org
List-Id: <linux-iio.vger.kernel.org>
List-Subscribe: <mailto:linux-iio+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-iio+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=11695; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=rzyItKitX1xfdqxIj4i5MGbTVUb24C8vStiJf51sFK4=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBqNWY077mz+IneYUxYuaLpYax6i5fkl0MlbjCq/ twUo8BMy+eJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCajVmNAAKCRCPgPtYfRL+ Tr2LCACm/YMyB8WhTFr6LRRdNciD+nrrFtcRo9T3TDmpK5UYOkk5HB6A0pFYp94gVfx45pAEsE8 bvIH8R2YT694urLQDuUp9OI1/XT2zQ7w1TBLeR88+7+zRh9BY0NZhrqUALEoK15Cky4MOC0isEP 6mVdmL/pgZBTZgbzGbTiBWnMIUfoJQWDTgvaZDhp9yQQxyuUfo61HzV4ZK8+fcn5m0PopH42m/t ckkXQcpdQB0QQCsmkCGXqHISYf5U99ZdseIINwkpyjxsDozWUYVyYWa4VC8qMY2B9WCbI8lnJwK wF8SrfUH11cXKZ4o6yp+ZK8NXpkuF3UZ8c1TCFTRyU5C/CFz
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

Hello,

the first patch is a follow up for making iio's i2c_device_id arrays use
named initializers. The two drivers adapted in it were missed before
because they were not yet in the tree I used to prepare the patch. The
remainder is a similar adaption for spi_device_id. Instead of adapting
arrays with a single entry and .driver_data, rework these to not use
.driver_data.

The ad9523 driver is a bit special here. It can only probe devices that
have platform data. A device instantiated using dt never has platform
data, so this driver only works for boards registering the device using
a spi_board_info struct. There is no such board, and there never was
one. So an alternative is to just drop this driver?!

I was unsure if I should post the staging patches in a separate series,
I hope it's fine to include them here.

Best regards
Uwe

Uwe Kleine-König (The Capable Hub) (13):
  iio: Initialize i2c_device_id arrays using member names (part 2)
  iio: adc: ti-tsc2046: Simplify device abstraction
  iio: adc: ti-tsc2046: Drop unused member from private data
  iio: adc: max1241: Simplify device abstraction
  iio: dac: max5522: Simplify device abstraction
  iio: frequency: ad9523: Simplify driver a bit
  iio: imu: adis16550: Simplify device abstraction
  iio: magnetometer: hmc5843: Simplify device abstraction
  iio: accel: bmc150: Explicitly set spi .driver_data
  iio: Drop unused assignment of spi_device_id driver data
  iio: Initialize spi_device_id arrays using member names
  staging: iio: Drop unused assignment of spi_device_id driver data
  staging: iio: Initialize spi_device_id arrays using member names

 drivers/iio/accel/adxl345_spi.c               |   4 +-
 drivers/iio/accel/adxl355_spi.c               |   4 +-
 drivers/iio/accel/adxl367_spi.c               |   2 +-
 drivers/iio/accel/adxl372_spi.c               |   4 +-
 drivers/iio/accel/adxl380_spi.c               |   8 +-
 drivers/iio/accel/bma220_spi.c                |   2 +-
 drivers/iio/accel/bma400_spi.c                |   2 +-
 drivers/iio/accel/bmc150-accel-spi.c          |  18 +--
 drivers/iio/accel/bmi088-accel-spi.c          |   6 +-
 drivers/iio/accel/fxls8962af-spi.c            |   4 +-
 drivers/iio/accel/kxsd9-spi.c                 |   2 +-
 drivers/iio/accel/mma7455_spi.c               |   4 +-
 drivers/iio/accel/sca3000.c                   |   8 +-
 drivers/iio/accel/sca3300.c                   |   4 +-
 drivers/iio/accel/st_accel_spi.c              |  40 +++---
 drivers/iio/adc/ad4000.c                      |  62 ++++-----
 drivers/iio/adc/ad4030.c                      |  14 +-
 drivers/iio/adc/ad4080.c                      |  22 +--
 drivers/iio/adc/ad4130.c                      |  12 +-
 drivers/iio/adc/ad4134.c                      |   2 +-
 drivers/iio/adc/ad4170-4.c                    |   6 +-
 drivers/iio/adc/ad4851.c                      |  18 +--
 drivers/iio/adc/ad7091r8.c                    |   6 +-
 drivers/iio/adc/ad7124.c                      |   4 +-
 drivers/iio/adc/ad7173.c                      |  26 ++--
 drivers/iio/adc/ad7191.c                      |   2 +-
 drivers/iio/adc/ad7192.c                      |  10 +-
 drivers/iio/adc/ad7266.c                      |   4 +-
 drivers/iio/adc/ad7280a.c                     |   2 +-
 drivers/iio/adc/ad7292.c                      |   2 +-
 drivers/iio/adc/ad7298.c                      |   2 +-
 drivers/iio/adc/ad7380.c                      |  36 ++---
 drivers/iio/adc/ad7476.c                      |  60 ++++----
 drivers/iio/adc/ad7606_spi.c                  |  22 +--
 drivers/iio/adc/ad7766.c                      |  12 +-
 drivers/iio/adc/ad7768-1.c                    |   8 +-
 drivers/iio/adc/ad7780.c                      |   8 +-
 drivers/iio/adc/ad7791.c                      |  10 +-
 drivers/iio/adc/ad7793.c                      |  18 +--
 drivers/iio/adc/ad7887.c                      |   2 +-
 drivers/iio/adc/ad7923.c                      |  14 +-
 drivers/iio/adc/ad7944.c                      |   6 +-
 drivers/iio/adc/ad7949.c                      |   6 +-
 drivers/iio/adc/ad9467.c                      |  14 +-
 drivers/iio/adc/ade9000.c                     |   2 +-
 drivers/iio/adc/hi8435.c                      |   2 +-
 drivers/iio/adc/max1027.c                     |  12 +-
 drivers/iio/adc/max1118.c                     |   6 +-
 drivers/iio/adc/max11205.c                    |   4 +-
 drivers/iio/adc/max11410.c                    |   2 +-
 drivers/iio/adc/max1241.c                     |   8 +-
 drivers/iio/adc/max14001.c                    |   4 +-
 drivers/iio/adc/mcp320x.c                     |  26 ++--
 drivers/iio/adc/mcp3564.c                     |  24 ++--
 drivers/iio/adc/mcp3911.c                     |  14 +-
 drivers/iio/adc/rohm-bd79112.c                |   2 +-
 drivers/iio/adc/rtq6056.c                     |   4 +-
 drivers/iio/adc/ti-adc0832.c                  |   8 +-
 drivers/iio/adc/ti-adc084s021.c               |   2 +-
 drivers/iio/adc/ti-adc108s102.c               |   2 +-
 drivers/iio/adc/ti-adc12138.c                 |   6 +-
 drivers/iio/adc/ti-adc128s052.c               |  24 ++--
 drivers/iio/adc/ti-adc161s626.c               |   4 +-
 drivers/iio/adc/ti-ads1018.c                  |   4 +-
 drivers/iio/adc/ti-ads124s08.c                |   4 +-
 drivers/iio/adc/ti-ads1298.c                  |   2 +-
 drivers/iio/adc/ti-ads131e08.c                |   6 +-
 drivers/iio/adc/ti-ads131m02.c                |  10 +-
 drivers/iio/adc/ti-ads7950.c                  |  24 ++--
 drivers/iio/adc/ti-ads8688.c                  |   4 +-
 drivers/iio/adc/ti-lmp92064.c                 |   2 +-
 drivers/iio/adc/ti-tlc4541.c                  |   4 +-
 drivers/iio/adc/ti-tsc2046.c                  |  12 +-
 drivers/iio/addac/ad74115.c                   |   2 +-
 drivers/iio/amplifiers/ad8366.c               |  26 ++--
 drivers/iio/amplifiers/ada4250.c              |   2 +-
 drivers/iio/chemical/bme680_spi.c             |   2 +-
 drivers/iio/chemical/ens160_spi.c             |   2 +-
 drivers/iio/dac/ad3530r.c                     |   8 +-
 drivers/iio/dac/ad5064.c                      |  32 ++---
 drivers/iio/dac/ad5360.c                      |  16 +--
 drivers/iio/dac/ad5380.c                      |  32 ++---
 drivers/iio/dac/ad5446-spi.c                  |  62 ++++-----
 drivers/iio/dac/ad5449.c                      |  14 +-
 drivers/iio/dac/ad5504.c                      |   4 +-
 drivers/iio/dac/ad5624r_spi.c                 |  12 +-
 drivers/iio/dac/ad5706r.c                     |   2 +-
 drivers/iio/dac/ad5755.c                      |  10 +-
 drivers/iio/dac/ad5758.c                      |   2 +-
 drivers/iio/dac/ad5761.c                      |   8 +-
 drivers/iio/dac/ad5764.c                      |   8 +-
 drivers/iio/dac/ad5766.c                      |   4 +-
 drivers/iio/dac/ad5770r.c                     |   2 +-
 drivers/iio/dac/ad5791.c                      |  10 +-
 drivers/iio/dac/ad7293.c                      |   2 +-
 drivers/iio/dac/ad7303.c                      |   2 +-
 drivers/iio/dac/ad8801.c                      |   4 +-
 drivers/iio/dac/ad9739a.c                     |   2 +-
 drivers/iio/dac/ltc1660.c                     |   4 +-
 drivers/iio/dac/ltc2632.c                     |  44 +++---
 drivers/iio/dac/ltc2664.c                     |   4 +-
 drivers/iio/dac/ltc2688.c                     |   2 +-
 drivers/iio/dac/max22007.c                    |   2 +-
 drivers/iio/dac/max5522.c                     |  31 +----
 drivers/iio/dac/mcp4821.c                     |  12 +-
 drivers/iio/dac/mcp4922.c                     |   8 +-
 drivers/iio/dac/rohm-bd79703.c                |   8 +-
 drivers/iio/dac/ti-dac082s085.c               |  12 +-
 drivers/iio/dac/ti-dac7311.c                  |   6 +-
 drivers/iio/dac/ti-dac7612.c                  |   2 +-
 drivers/iio/filter/admv8818.c                 |   2 +-
 drivers/iio/frequency/ad9523.c                |   3 +-
 drivers/iio/frequency/adf4350.c               |   4 +-
 drivers/iio/frequency/adf4371.c               |   4 +-
 drivers/iio/frequency/adf4377.c               |   4 +-
 drivers/iio/frequency/admv1013.c              |   2 +-
 drivers/iio/frequency/admv1014.c              |   2 +-
 drivers/iio/frequency/adrf6780.c              |   2 +-
 drivers/iio/gyro/adis16080.c                  |   4 +-
 drivers/iio/gyro/adis16136.c                  |   8 +-
 drivers/iio/gyro/adis16260.c                  |  12 +-
 drivers/iio/gyro/adxrs450.c                   |   4 +-
 drivers/iio/gyro/bmg160_spi.c                 |   7 +-
 drivers/iio/gyro/fxas21002c_spi.c             |   2 +-
 drivers/iio/gyro/st_gyro_spi.c                |  18 +--
 drivers/iio/health/afe4403.c                  |   2 +-
 drivers/iio/humidity/hts221_spi.c             |   2 +-
 drivers/iio/imu/adis16400.c                   |  30 ++--
 drivers/iio/imu/adis16460.c                   |   2 +-
 drivers/iio/imu/adis16475.c                   |  54 ++++----
 drivers/iio/imu/adis16480.c                   |  40 +++---
 drivers/iio/imu/adis16550.c                   |   9 +-
 drivers/iio/imu/bmi160/bmi160_spi.c           |   4 +-
 drivers/iio/imu/bmi270/bmi270_spi.c           |   4 +-
 drivers/iio/imu/bmi323/bmi323_spi.c           |   2 +-
 drivers/iio/imu/fxos8700_spi.c                |   2 +-
 .../iio/imu/inv_icm42600/inv_icm42600_spi.c   |  14 +-
 .../iio/imu/inv_icm45600/inv_icm45600_spi.c   |  16 +--
 drivers/iio/imu/inv_mpu6050/inv_mpu_spi.c     |  34 ++---
 drivers/iio/imu/smi240.c                      |   2 +-
 drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_spi.c   |  48 +++----
 drivers/iio/imu/st_lsm9ds0/st_lsm9ds0_spi.c   |   4 +-
 drivers/iio/light/st_uvis25_spi.c             |   2 +-
 drivers/iio/magnetometer/bmc150_magn_spi.c    |   6 +-
 drivers/iio/magnetometer/hmc5843_spi.c        |   6 +-
 drivers/iio/magnetometer/mmc5983.c            |   2 +-
 drivers/iio/magnetometer/st_magn_spi.c        |  12 +-
 drivers/iio/potentiometer/max5481.c           |   8 +-
 drivers/iio/potentiometer/max5487.c           |   6 +-
 drivers/iio/potentiometer/mcp41010.c          |  12 +-
 drivers/iio/potentiometer/mcp4131.c           | 128 +++++++++---------
 drivers/iio/potentiometer/x9250.c             |   4 +-
 drivers/iio/pressure/abp2030pa_spi.c          |   2 +-
 drivers/iio/pressure/bmp280-spi.c             |  14 +-
 drivers/iio/pressure/hsc030pa_spi.c           |   2 +-
 drivers/iio/pressure/mpl115_spi.c             |   2 +-
 drivers/iio/pressure/mprls0025pa_spi.c        |   2 +-
 drivers/iio/pressure/ms5611_spi.c             |   4 +-
 drivers/iio/pressure/st_pressure_spi.c        |  24 ++--
 drivers/iio/pressure/zpa2326_spi.c            |   2 +-
 drivers/iio/proximity/as3935.c                |   2 +-
 drivers/iio/resolver/ad2s1200.c               |   4 +-
 drivers/iio/resolver/ad2s1210.c               |   2 +-
 drivers/iio/resolver/ad2s90.c                 |   2 +-
 drivers/iio/temperature/ltc2983.c             |  10 +-
 drivers/iio/temperature/max31856.c            |   2 +-
 drivers/iio/temperature/max31865.c            |   2 +-
 drivers/iio/temperature/maxim_thermocouple.c  |  18 +--
 drivers/staging/iio/adc/ad7816.c              |   6 +-
 drivers/staging/iio/addac/adt7316-spi.c       |  13 +-
 drivers/staging/iio/frequency/ad9832.c        |   4 +-
 drivers/staging/iio/frequency/ad9834.c        |   8 +-
 172 files changed, 886 insertions(+), 927 deletions(-)


base-commit: 3ce97bd3c4f18608335e709c24d6a40e7036cab8
-- 
2.47.3

