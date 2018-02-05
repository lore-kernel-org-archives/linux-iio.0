Return-Path: <SRS0=b6id=E7=gmail.com=ulfalizer@kernel.org>
From: Ulf Magnusson <ulfalizer@gmail.com>
To: linux-kernel@vger.kernel.org
Cc: linux-kbuild@vger.kernel.org,
	tfiga@chromium.org,
	paul.burton@mips.com,
	m.szyprowski@samsung.com,
	egtvedt@samfundet.no,
	linus.walleij@linaro.org,
	vgupta@synopsys.com,
	mgorman@techsingularity.net,
	hch@lst.de,
	mina86@mina86.com,
	robh@kernel.org,
	sboyd@codeaurora.org,
	paulus@ozlabs.org,
	will.deacon@arm.com,
	tony@atomide.com,
	npiggin@gmail.com,
	yamada.masahiro@socionext.com,
	Ulf Magnusson <ulfalizer@gmail.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	linux-iio@vger.kernel.org
Subject: [PATCH 14/20] iio: gyro: mpu3050: Remove INPUT_MPU3050 dep. from I2C
Date: Mon,  5 Feb 2018 02:21:26 +0100
Message-Id: <20180205012146.23981-15-ulfalizer@gmail.com>
In-Reply-To: <20180205012146.23981-1-ulfalizer@gmail.com>
References: <20180205012146.23981-1-ulfalizer@gmail.com>
List-ID: <linux-iio@vger.kernel.org>

The INPUT_MPU3050 symbol was removed in commit b1fe0cf06f92 ("Input:
delete MPU3050 driver").

Remove the negative dependency on it from the MPU3050_I2C symbol. It is
always satisfied now.

Discovered with the
https://github.com/ulfalizer/Kconfiglib/blob/master/examples/list_undefined.py
script.

Signed-off-by: Ulf Magnusson <ulfalizer@gmail.com>
---
 drivers/iio/gyro/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/gyro/Kconfig b/drivers/iio/gyro/Kconfig
index 3126cf05e6b9..b702b9176006 100644
--- a/drivers/iio/gyro/Kconfig
+++ b/drivers/iio/gyro/Kconfig
@@ -92,7 +92,6 @@ config MPU3050
 
 config MPU3050_I2C
 	tristate "Invensense MPU3050 devices on I2C"
-	depends on !(INPUT_MPU3050=y || INPUT_MPU3050=m)
 	depends on I2C
 	select MPU3050
 	select REGMAP_I2C
-- 
2.14.1
