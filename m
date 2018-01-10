Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:14190 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751988AbeAJPXo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
        Wed, 10 Jan 2018 10:23:44 -0500
Date: Wed, 10 Jan 2018 23:23:05 +0800
From: kbuild test robot <fengguang.wu@intel.com>
To: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Cc: kbuild-all@01.org, alsa-devel@alsa-project.org,
        Mark Brown <broonie@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Hartmut Knaack <knaack.h@gmx.de>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: [RFC PATCH asoc] IIO: ADC: stm32_dfsdm_stop_filter() can be static
Message-ID: <20180110152305.GA83560@lkp-sb05>
References: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org


Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
Signed-off-by: Fengguang Wu <fengguang.wu@intel.com>
---
 stm32-dfsdm-adc.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
index b03ca3f..e628d04 100644
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
