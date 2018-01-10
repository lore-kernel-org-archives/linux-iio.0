Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from heliosphere.sirena.org.uk ([172.104.155.198]:59606 "EHLO
        heliosphere.sirena.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965371AbeAJPdh (ORCPT
        <rfc822;linux-iio@vger.kernel.org>); Wed, 10 Jan 2018 10:33:37 -0500
From: Mark Brown <broonie@kernel.org>
To: kbuild test robot <fengguang.wu@intel.com>
Cc: Fengguang Wu <fengguang.wu@intel.com>,
        Mark Brown <broonie@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@st.com>,
        alsa-devel@alsa-project.org, Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        linux-iio@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Mark Brown <broonie@kernel.org>, kbuild-all@01.org,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Hartmut Knaack <knaack.h@gmx.de>,
        linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@st.com>,
        alsa-devel@alsa-project.org
Subject: Applied "IIO: ADC: stm32_dfsdm_stop_filter() can be static" to the asoc tree
In-Reply-To: <20180110152305.GA83560@lkp-sb05>
Message-Id: <E1eZINR-00056S-N9@debutante>
Date: Wed, 10 Jan 2018 15:33:17 +0000
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

The patch

   IIO: ADC: stm32_dfsdm_stop_filter() can be static

has been applied to the asoc tree at

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git 

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.  

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark

>From 1c4d0c5bc347328b257740d060ce9dbf48eebfe0 Mon Sep 17 00:00:00 2001
From: kbuild test robot <fengguang.wu@intel.com>
Date: Wed, 10 Jan 2018 23:23:05 +0800
Subject: [PATCH] IIO: ADC: stm32_dfsdm_stop_filter() can be static

Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
Signed-off-by: Mark Brown <broonie@kernel.org>
---
 drivers/iio/adc/stm32-dfsdm-adc.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b03ca3f94331..e628d04d5c77 100644
--- a/drivers/iio/adc/stm32-dfsdm-adc.c
+++ b/drivers/iio/adc/stm32-dfsdm-adc.c
@@ -254,7 +254,7 @@ static int stm32_dfsdm_start_filter(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CR1_RSWSTART(1));
 }
 
-void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
+static void stm32_dfsdm_stop_filter(struct stm32_dfsdm *dfsdm, unsigned int fl_id)
 {
 	/* Disable conversion */
 	regmap_update_bits(dfsdm->regmap, DFSDM_CR1(fl_id),
@@ -296,9 +296,9 @@ static int stm32_dfsdm_filter_configure(struct stm32_dfsdm *dfsdm,
 				  DFSDM_CR1_RSYNC(fl->sync_mode));
 }
 
-int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
-				 struct iio_dev *indio_dev,
-				 struct iio_chan_spec *ch)
+static int stm32_dfsdm_channel_parse_of(struct stm32_dfsdm *dfsdm,
+					struct iio_dev *indio_dev,
+					struct iio_chan_spec *ch)
 {
 	struct stm32_dfsdm_channel *df_ch;
 	const char *of_str;
-- 
2.15.1

