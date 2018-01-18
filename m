Return-Path: <SRS0=pDbV=EN=gentoo.org=chrisadr@kernel.org>
From: =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>
To: jic23@kernel.org,
	knaack.h@gmx.de,
	lars@metafoo.de,
	pmeerw@pmeerw.net,
	broonie@kernel.org,
	arnaud.pouliquen@st.com,
	arnd@arndb.de
Cc: =?UTF-8?q?Christopher=20D=C3=ADaz=20Riveros?= <chrisadr@gentoo.org>,
	linux-iio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH-next] IIO: ADC: drop unused 'of_id' struct
Date: Thu, 18 Jan 2018 18:44:15 -0500
Message-Id: <20180118234415.32410-1-chrisadr@gentoo.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-iio@vger.kernel.org>

When CONFIG_STM32_DFSDM_CORE is enabled, stm32-dfsdm-core.o is compiled,
which raises a next warning:

drivers/iio/adc/stm32-dfsdm-core.c: In function ‘stm32_dfsdm_probe’:
drivers/iio/adc/stm32-dfsdm-core.c:245:29: warning: unused variable ‘of_id’ [-Wunused-variable]
  const struct of_device_id *of_id;
                             ^~~~~

Signed-off-by: Christopher Díaz Riveros <chrisadr@gentoo.org>
---
 drivers/iio/adc/stm32-dfsdm-core.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-core.c b/drivers/iio/adc/stm32-dfsdm-core.c
index 84277bcc465f..6290332cfd3f 100644
--- a/drivers/iio/adc/stm32-dfsdm-core.c
+++ b/drivers/iio/adc/stm32-dfsdm-core.c
@@ -242,7 +242,6 @@ MODULE_DEVICE_TABLE(of, stm32_dfsdm_of_match);
 static int stm32_dfsdm_probe(struct platform_device *pdev)
 {
 	struct dfsdm_priv *priv;
-	const struct of_device_id *of_id;
 	const struct stm32_dfsdm_dev_data *dev_data;
 	struct stm32_dfsdm *dfsdm;
 	int ret;
-- 
2.15.1
