Return-Path: <linux-iio-owner@vger.kernel.org>
Received: from mga04.intel.com ([192.55.52.120]:59753 "EHLO mga04.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754941AbcDDSV6 (ORCPT <rfc822;linux-iio@vger.kernel.org>);
	Mon, 4 Apr 2016 14:21:58 -0400
From: Crestez Dan Leonard <leonard.crestez@intel.com>
To: Jonathan Cameron <jic23@kernel.org>, linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Hartmut Knaack <knaack.h@gmx.de>,
	Lars-Peter Clausen <lars@metafoo.de>,
	Peter Meerwald-Stadler <pmeerw@pmeerw.net>,
	Daniel Baluta <daniel.baluta@intel.com>,
	Crestez Dan Leonard <leonard.crestez@intel.com>
Subject: [PATCH v2 0/2] Add support for adc101c* and adc121c* 
Date: Mon,  4 Apr 2016 21:21:40 +0300
Message-Id: <cover.1459793615.git.leonard.crestez@intel.com>
Sender: linux-iio-owner@vger.kernel.org
List-Id: linux-iio@vger.kernel.org

Changes since last version:
 * Use struct adcxx1_model in the first patch as well.
 * Use VLA buf in adc081c_trigger_handler.
 * Rerrange code so the diffs look nicer.
 * Fixed other smaller review comments.

I did not add an enum for models because it's not clear how adding another
layer of indirection would help. Maybe if we ever want to scan the table of
models? But that's not useful here.

The devices actually have names like ADC121C021/ADC121C027 to identify chips
with different pinouts but identical I2C interfaces. Those differences don't
currently matter to the driver.

Crestez Dan Leonard (2):
  ti-adc081c: Add support for adc101c* and adc121c*
  ti-adc081c: Initial triggered buffer support

 drivers/iio/adc/Kconfig      |   6 +--
 drivers/iio/adc/ti-adc081c.c | 103 ++++++++++++++++++++++++++++++++++++++-----
 2 files changed, 94 insertions(+), 15 deletions(-)

-- 
2.5.5

