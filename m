Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:34260 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752444AbeAJPXo (ORCPT <rfc822;linux-iio@vger.kernel.org>);
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
Subject: [asoc:topic/iio 9/11] drivers/iio/adc/stm32-dfsdm-adc.c:241:6:
 sparse: symbol 'stm32_dfsdm_stop_filter' was not declared. Should it be
 static?
Message-ID: <201801102320.fKoiIrHz%fengguang.wu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git topic/iio
head:   16cbca06fa8288a4f58426fc898b141e12ee8008
commit: e2e6771c646251657fafb2a78db566d5c2c70635 [9/11] IIO: ADC: add STM32 DFSDM sigma delta ADC support
reproduce:
        # apt-get install sparse
        git checkout e2e6771c646251657fafb2a78db566d5c2c70635
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)

>> drivers/iio/adc/stm32-dfsdm-adc.c:241:6: sparse: symbol 'stm32_dfsdm_stop_filter' was not declared. Should it be
>> drivers/iio/adc/stm32-dfsdm-adc.c:283:5: sparse: symbol 'stm32_dfsdm_channel_parse_of' was not declared. Should it be

Please review and possibly fold the followup patch.

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
